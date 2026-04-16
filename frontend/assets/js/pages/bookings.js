let bookPage = 1, bookSearch = '', bookStatus = '';

async function renderBookings() {
  const content = document.getElementById('page-content');
  content.innerHTML = `
    <div class="data-card">
      <div class="data-card-header">
        <h6><i class="bi bi-calendar-check me-2 text-warning"></i>Bookings</h6>
        <div class="d-flex gap-2 flex-wrap">
          <div class="search-box">
            <i class="bi bi-search"></i>
            <input id="bookSearch" type="text" class="form-control-custom" placeholder="Search..." oninput="debouncedBookSearch(this.value)" />
          </div>
          <select class="form-control-custom" style="width:auto;" onchange="bookStatus=this.value;bookPage=1;loadBookings()">
            <option value="">All Status</option>
            <option value="Confirmed">Confirmed</option>
            <option value="Pending">Pending</option>
            <option value="Completed">Completed</option>
            <option value="Cancelled">Cancelled</option>
          </select>
          <button class="btn-primary-custom" onclick="openBookingModal()"><i class="bi bi-plus-lg"></i> Add Booking</button>
        </div>
      </div>
      <div id="bookTableWrap"><div class="loading-overlay"><div class="spinner"></div></div></div>
      <div class="p-3 d-flex justify-content-between align-items-center border-top" style="flex-wrap:wrap;gap:8px;">
        <small id="bookInfo" class="text-muted"></small>
        <div id="bookPagination"></div>
      </div>
    </div>

    <!-- Booking Modal -->
    <div class="modal fade" id="bookingModal" tabindex="-1">
      <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="bookModalTitle">New Booking</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label-custom">Customer *</label>
                <select id="bf-customer" class="form-control-custom"><option value="">Loading...</option></select>
              </div>
              <div class="col-md-6">
                <label class="form-label-custom">Tour Package *</label>
                <select id="bf-tour" class="form-control-custom"><option value="">Loading...</option></select>
              </div>
              <div class="col-md-4"><label class="form-label-custom">Booking Date *</label><input id="bf-date" type="date" class="form-control-custom" value="${new Date().toISOString().split('T')[0]}"></div>
              <div class="col-md-4">
                <label class="form-label-custom">Status</label>
                <select id="bf-status" class="form-control-custom">
                  <option>Pending</option><option>Confirmed</option><option>Completed</option><option>Cancelled</option>
                </select>
              </div>
              <div class="col-md-4"><label class="form-label-custom">No. of People *</label><input id="bf-people" type="number" min="1" class="form-control-custom" placeholder="Number of travelers" oninput="updateTravelerFields()"></div>
              <div class="col-12">
                <hr class="my-1">
                <div class="d-flex justify-content-between align-items-center mb-2">
                  <p class="form-label-custom mb-0">Traveler Details</p>
                  <small class="text-muted">Fill based on No. of People</small>
                </div>
                <div id="travelerFields"></div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button class="btn-primary-custom" onclick="saveBooking()"><i class="bi bi-check-lg"></i> Save Booking</button>
          </div>
        </div>
      </div>
    </div>
  `;
  window.debouncedBookSearch = debounce(v => { bookSearch = v; bookPage = 1; loadBookings(); });
  loadBookings();
}

function updateTravelerFields() {
  const n = parseInt(document.getElementById('bf-people').value) || 0;
  const container = document.getElementById('travelerFields');
  let html = '';
  for (let i = 0; i < n; i++) {
    html += `
      <div class="border rounded p-2 mb-2" style="background:#f8fafc;">
        <small class="fw-bold text-muted mb-2 d-block">Traveler ${i+1}</small>
        <div class="row g-2">
          <div class="col-md-3"><input class="form-control-custom" placeholder="First Name" id="tr-fname-${i}"></div>
          <div class="col-md-3"><input class="form-control-custom" placeholder="Last Name" id="tr-lname-${i}"></div>
          <div class="col-md-2"><input class="form-control-custom" type="number" placeholder="Age" id="tr-age-${i}"></div>
          <div class="col-md-2">
            <select class="form-control-custom" id="tr-gender-${i}">
              <option value="">Gender</option><option>Male</option><option>Female</option><option>Other</option>
            </select>
          </div>
          <div class="col-md-2"><input class="form-control-custom" placeholder="NID (optional)" id="tr-nid-${i}"></div>
        </div>
      </div>`;
  }
  container.innerHTML = html;
}

async function loadBookings() {
  document.getElementById('bookTableWrap').innerHTML = `<div class="loading-overlay"><div class="spinner"></div></div>`;
  try {
    const data = await apiGet('/bookings', { search: bookSearch, status: bookStatus, page: bookPage, limit: 10 });
    if (!data.data.length) {
      document.getElementById('bookTableWrap').innerHTML = `<div class="empty-state"><i class="bi bi-calendar-x"></i><p>No bookings found</p></div>`;
      return;
    }
    document.getElementById('bookTableWrap').innerHTML = `
      <div class="table-wrapper">
        <table class="tms-table">
          <thead><tr><th>ID</th><th>Customer</th><th>Tour Package</th><th>Booking Date</th><th>Tour Dates</th><th>People</th><th>Amount</th><th>Status</th><th>Actions</th></tr></thead>
          <tbody>
            ${data.data.map(b => `
              <tr>
                <td><span class="text-muted">#${b.BookingID}</span></td>
                <td>
                  <div class="d-flex align-items-center gap-2">
                    <div class="avatar" style="background:${avatarColor(b.CustomerName)};width:28px;height:28px;font-size:10px;">${avatarInitials(b.CustomerName)}</div>
                    ${b.CustomerName}
                  </div>
                </td>
                <td>${b.TourName}</td>
                <td>${fmtDate(b.BookingDate)}</td>
                <td><small>${fmtDate(b.StartDate)} – ${fmtDate(b.EndDate)}</small></td>
                <td><span class="fw-bold">${b.NoOfPeople}</span></td>
                <td>${fmtCurrency(b.Price * b.NoOfPeople)}</td>
                <td>${statusBadge(b.BookingStatus)}</td>
                <td>
                  <div class="d-flex gap-1">
                    <button class="btn-icon btn-icon-view" onclick="viewBooking(${b.BookingID})"><i class="bi bi-eye"></i></button>
                    <button class="btn-icon btn-icon-edit" onclick="editBooking(${b.BookingID})"><i class="bi bi-pencil"></i></button>
                    <button class="btn-icon btn-icon-delete" onclick="deleteBooking(${b.BookingID})"><i class="bi bi-trash"></i></button>
                  </div>
                </td>
              </tr>`).join('')}
          </tbody>
        </table>
      </div>`;
    const start = (bookPage - 1) * 10 + 1, end = Math.min(bookPage * 10, data.total);
    document.getElementById('bookInfo').textContent = `Showing ${start}-${end} of ${data.total} bookings`;
    buildPagination('bookPagination', bookPage, data.total, 10, p => { bookPage = p; loadBookings(); });
  } catch(e) {
    document.getElementById('bookTableWrap').innerHTML = `<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>${e.message}</p></div>`;
  }
}

let editingBookId = null;
async function openBookingModal() {
  editingBookId = null;
  document.getElementById('bookModalTitle').textContent = 'New Booking';
  try {
    const [custs, tours] = await Promise.all([
      apiGet('/customers', { limit: 200 }), apiGet('/tourpackages', { limit: 200 })
    ]);
    document.getElementById('bf-customer').innerHTML = `<option value="">Select Customer</option>` + custs.data.map(c => `<option value="${c.CustomerID}">${c.FirstName} ${c.LastName} (${c.Email})</option>`).join('');
    document.getElementById('bf-tour').innerHTML = `<option value="">Select Tour</option>` + tours.data.map(t => `<option value="${t.TourID}">${t.TourName} - ${fmtCurrency(t.Price)}</option>`).join('');
  } catch(e) {}
  document.getElementById('bf-people').value = '';
  document.getElementById('travelerFields').innerHTML = '';
  new bootstrap.Modal(document.getElementById('bookingModal')).show();
}

async function editBooking(id) {
  editingBookId = id;
  try {
    const b = await apiGet(`/bookings/${id}`);
    await openBookingModal();
    document.getElementById('bf-customer').value = b.CustomerID;
    document.getElementById('bf-tour').value = b.TourID;
    document.getElementById('bf-date').value = b.BookingDate?.split('T')[0];
    document.getElementById('bf-status').value = b.BookingStatus;
    document.getElementById('bf-people').value = b.NoOfPeople;
    document.getElementById('bookModalTitle').textContent = 'Edit Booking';
    updateTravelerFields();
    b.travelers?.forEach((t, i) => {
      ['fname','lname','age','gender','nid'].forEach(f => {
        const el = document.getElementById(`tr-${f}-${i}`);
        const map = { fname: t.TravelerFirstName, lname: t.TravelerLastName, age: t.TravelerAge, gender: t.Gender, nid: t.NID };
        if (el) el.value = map[f] || '';
      });
    });
  } catch(e) { showToast(e.message, 'error'); }
}

async function viewBooking(id) {
  try {
    const b = await apiGet(`/bookings/${id}`);
    const travelers = b.travelers?.map(t => `${t.TravelerFirstName} ${t.TravelerLastName} (${t.TravelerAge})`).join(', ') || 'None';
    document.getElementById('confirmMessage').innerHTML = `
      <b>Booking #${b.BookingID}</b><br>
      Customer: ${b.CustomerName}<br>
      Tour: ${b.TourName}<br>
      Location: ${b.PlaceName || 'N/A'} | Hotel: ${b.HotelName || 'N/A'}<br>
      Dates: ${fmtDate(b.StartDate)} – ${fmtDate(b.EndDate)}<br>
      Status: ${b.BookingStatus} | People: ${b.NoOfPeople}<br>
      <br><b>Travelers:</b> ${travelers}
    `;
    document.getElementById('confirmBtn').style.display = 'none';
    const m = new bootstrap.Modal(document.getElementById('confirmModal'));
    document.getElementById('confirmModal').addEventListener('hidden.bs.modal', () => { document.getElementById('confirmBtn').style.display = ''; }, { once: true });
    m.show();
  } catch(e) { showToast(e.message, 'error'); }
}

async function saveBooking() {
  const n = parseInt(document.getElementById('bf-people').value) || 0;
  const travelers = Array.from({length: n}, (_, i) => ({
    TravelerFirstName: document.getElementById(`tr-fname-${i}`)?.value.trim() || `Traveler${i+1}`,
    TravelerLastName: document.getElementById(`tr-lname-${i}`)?.value.trim() || '',
    TravelerAge: parseInt(document.getElementById(`tr-age-${i}`)?.value) || null,
    Gender: document.getElementById(`tr-gender-${i}`)?.value || null,
    NID: document.getElementById(`tr-nid-${i}`)?.value.trim() || null,
  }));
  const payload = {
    CustomerID: parseInt(document.getElementById('bf-customer').value),
    TourID: parseInt(document.getElementById('bf-tour').value),
    BookingDate: document.getElementById('bf-date').value,
    BookingStatus: document.getElementById('bf-status').value,
    NoOfPeople: n,
    Travelers: travelers,
  };
  if (!payload.CustomerID || !payload.TourID || !payload.BookingDate || !payload.NoOfPeople) {
    showToast('Please fill all required fields', 'warning'); return;
  }
  try {
    if (editingBookId) {
      await apiPut(`/bookings/${editingBookId}`, { BookingStatus: payload.BookingStatus, NoOfPeople: payload.NoOfPeople });
      showToast('Booking updated', 'success');
    } else {
      await apiPost('/bookings', payload);
      showToast('Booking created', 'success');
    }
    bootstrap.Modal.getInstance(document.getElementById('bookingModal')).hide();
    loadBookings();
  } catch(e) { showToast(e.message, 'error'); }
}

async function deleteBooking(id) {
  const ok = await confirmDelete(`Delete booking #${id}? Payment and traveler details will also be removed.`);
  if (!ok) return;
  try {
    await apiDelete(`/bookings/${id}`);
    showToast('Booking deleted', 'success');
    loadBookings();
  } catch(e) { showToast(e.message, 'error'); }
}
