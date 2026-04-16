let tourPage = 1, tourSearch = '';

async function renderTourPackages() {
  const content = document.getElementById('page-content');
  content.innerHTML = `
    <div class="data-card">
      <div class="data-card-header">
        <h6><i class="bi bi-map me-2 text-success"></i>Tour Packages</h6>
        <div class="d-flex gap-2 flex-wrap">
          <div class="search-box">
            <i class="bi bi-search"></i>
            <input id="tourSearch" type="text" class="form-control-custom" placeholder="Search tours..." oninput="debouncedTourSearch(this.value)" />
          </div>
          <button class="btn-primary-custom" onclick="openTourModal()"><i class="bi bi-plus-lg"></i> Add Tour</button>
        </div>
      </div>
      <div id="tourTableWrap"><div class="loading-overlay"><div class="spinner"></div></div></div>
      <div class="p-3 d-flex justify-content-between align-items-center border-top" style="flex-wrap:wrap;gap:8px;">
        <small id="tourInfo" class="text-muted"></small>
        <div id="tourPagination"></div>
      </div>
    </div>

    <!-- Tour Modal -->
    <div class="modal fade" id="tourModal" tabindex="-1">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="tourModalTitle">Add Tour Package</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-12"><label class="form-label-custom">Tour Name *</label><input id="tf-name" class="form-control-custom" placeholder="Tour name"></div>
              <div class="col-md-6"><label class="form-label-custom">Start Date *</label><input id="tf-start" type="date" class="form-control-custom"></div>
              <div class="col-md-6"><label class="form-label-custom">End Date *</label><input id="tf-end" type="date" class="form-control-custom"></div>
              <div class="col-md-6"><label class="form-label-custom">Price (BDT) *</label><input id="tf-price" type="number" class="form-control-custom" placeholder="Price"></div>
              <div class="col-md-6"><label class="form-label-custom">Max Seats *</label><input id="tf-seats" type="number" class="form-control-custom" placeholder="Max seats"></div>
              <div class="col-md-4">
                <label class="form-label-custom">Location *</label>
                <select id="tf-location" class="form-control-custom"><option value="">Loading...</option></select>
              </div>
              <div class="col-md-4">
                <label class="form-label-custom">Tour Guide *</label>
                <select id="tf-guide" class="form-control-custom"><option value="">Loading...</option></select>
              </div>
              <div class="col-md-4">
                <label class="form-label-custom">Hotel *</label>
                <select id="tf-hotel" class="form-control-custom"><option value="">Loading...</option></select>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button class="btn-primary-custom" onclick="saveTour()"><i class="bi bi-check-lg"></i> Save</button>
          </div>
        </div>
      </div>
    </div>
  `;
  window.debouncedTourSearch = debounce(v => { tourSearch = v; tourPage = 1; loadTours(); });
  loadTours();
}

async function loadTours() {
  document.getElementById('tourTableWrap').innerHTML = `<div class="loading-overlay"><div class="spinner"></div></div>`;
  try {
    const data = await apiGet('/tourpackages', { search: tourSearch, page: tourPage, limit: 10 });
    if (!data.data.length) {
      document.getElementById('tourTableWrap').innerHTML = `<div class="empty-state"><i class="bi bi-map"></i><p>No tour packages found</p></div>`;
      return;
    }
    document.getElementById('tourTableWrap').innerHTML = `
      <div class="table-wrapper">
        <table class="tms-table">
          <thead><tr><th>ID</th><th>Tour Name</th><th>Location</th><th>Dates</th><th>Price</th><th>Seats</th><th>Guide</th><th>Actions</th></tr></thead>
          <tbody>
            ${data.data.map(t => `
              <tr>
                <td><span class="text-muted">#${t.TourID}</span></td>
                <td>
                  <div class="fw-600">${t.TourName}</div>
                  <small class="text-muted">${t.HotelName || ''}</small>
                </td>
                <td>
                  <div>${t.PlaceName || '-'}</div>
                  <small class="text-muted">${t.District || ''}, ${t.Division || ''}</small>
                </td>
                <td>
                  <div>${fmtDate(t.StartDate)}</div>
                  <small class="text-muted">→ ${fmtDate(t.EndDate)}</small>
                </td>
                <td><span class="fw-600 text-primary">${fmtCurrency(t.Price)}</span></td>
                <td>
                  <span class="${parseInt(t.AvailableSeats) > 0 ? 'text-success' : 'text-danger'} fw-600">${t.AvailableSeats || 0}</span>
                  <small class="text-muted">/ ${t.MaxSeats}</small>
                </td>
                <td>${t.GuideName || '-'}</td>
                <td>
                  <div class="d-flex gap-1">
                    <button class="btn-icon btn-icon-edit" onclick="editTour(${t.TourID})"><i class="bi bi-pencil"></i></button>
                    <button class="btn-icon btn-icon-delete" onclick="deleteTour(${t.TourID})"><i class="bi bi-trash"></i></button>
                  </div>
                </td>
              </tr>`).join('')}
          </tbody>
        </table>
      </div>`;
    const start = (tourPage - 1) * 10 + 1;
    const end = Math.min(tourPage * 10, data.total);
    document.getElementById('tourInfo').textContent = `Showing ${start}-${end} of ${data.total} packages`;
    buildPagination('tourPagination', tourPage, data.total, 10, p => { tourPage = p; loadTours(); });
  } catch (e) {
    document.getElementById('tourTableWrap').innerHTML = `<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>${e.message}</p></div>`;
  }
}

let editingTourId = null;
async function openTourModal(tour = null) {
  editingTourId = tour?.TourID || null;
  document.getElementById('tourModalTitle').textContent = tour ? 'Edit Tour Package' : 'Add Tour Package';
  // Load dropdowns
  try {
    const [locs, guides, hotels] = await Promise.all([
      apiGet('/locations/all'), apiGet('/tourguides', { limit: 100 }), apiGet('/hotels/all')
    ]);
    document.getElementById('tf-location').innerHTML = `<option value="">Select Location</option>` + locs.map(l => `<option value="${l.LocationID}" ${tour?.LocationID==l.LocationID?'selected':''}>${l.PlaceName} - ${l.District}</option>`).join('');
    document.getElementById('tf-guide').innerHTML = `<option value="">Select Guide</option>` + guides.data.map(g => `<option value="${g.GuideID}" ${tour?.GuideID==g.GuideID?'selected':''}>${g.FirstName} ${g.LastName}</option>`).join('');
    document.getElementById('tf-hotel').innerHTML = `<option value="">Select Hotel</option>` + hotels.map(h => `<option value="${h.HotelID}" ${tour?.HotelID==h.HotelID?'selected':''}>${h.HotelName} (${h.StarRating}★)</option>`).join('');
  } catch(e) {}
  const fields = { name: tour?.TourName, start: tour?.StartDate?.split('T')[0], end: tour?.EndDate?.split('T')[0], price: tour?.Price, seats: tour?.MaxSeats };
  Object.entries(fields).forEach(([k,v]) => { const el = document.getElementById('tf-'+k); if(el && v) el.value = v; });
  new bootstrap.Modal(document.getElementById('tourModal')).show();
}

async function editTour(id) {
  try {
    const t = await apiGet(`/tourpackages/${id}`);
    openTourModal(t);
  } catch(e) { showToast(e.message, 'error'); }
}

async function saveTour() {
  const payload = {
    TourName: document.getElementById('tf-name').value.trim(),
    StartDate: document.getElementById('tf-start').value,
    EndDate: document.getElementById('tf-end').value,
    Price: parseFloat(document.getElementById('tf-price').value),
    MaxSeats: parseInt(document.getElementById('tf-seats').value),
    LocationID: parseInt(document.getElementById('tf-location').value),
    GuideID: parseInt(document.getElementById('tf-guide').value),
    HotelID: parseInt(document.getElementById('tf-hotel').value),
  };
  if (!payload.TourName || !payload.StartDate || !payload.EndDate || !payload.Price || !payload.LocationID) {
    showToast('Please fill all required fields', 'warning'); return;
  }
  try {
    if (editingTourId) {
      await apiPut(`/tourpackages/${editingTourId}`, payload);
      showToast('Tour package updated', 'success');
    } else {
      await apiPost('/tourpackages', payload);
      showToast('Tour package added', 'success');
    }
    bootstrap.Modal.getInstance(document.getElementById('tourModal')).hide();
    loadTours();
  } catch(e) { showToast(e.message, 'error'); }
}

async function deleteTour(id) {
  const ok = await confirmDelete(`Delete tour package #${id}?`);
  if (!ok) return;
  try {
    await apiDelete(`/tourpackages/${id}`);
    showToast('Tour package deleted', 'success');
    loadTours();
  } catch(e) { showToast(e.message, 'error'); }
}
