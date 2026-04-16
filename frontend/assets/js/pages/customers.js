let custPage = 1, custSearch = '';

async function renderCustomers() {
  const content = document.getElementById('page-content');
  content.innerHTML = `
    <div class="data-card">
      <div class="data-card-header">
        <h6><i class="bi bi-people me-2 text-primary"></i>Customers</h6>
        <div class="d-flex gap-2 flex-wrap">
          <div class="search-box">
            <i class="bi bi-search"></i>
            <input id="custSearch" type="text" class="form-control-custom" placeholder="Search customers..." oninput="debouncedCustSearch(this.value)" />
          </div>
          <button class="btn-primary-custom" onclick="openCustomerModal()"><i class="bi bi-plus-lg"></i> Add Customer</button>
        </div>
      </div>
      <div id="custTableWrap"><div class="loading-overlay"><div class="spinner"></div></div></div>
      <div class="p-3 d-flex justify-content-between align-items-center border-top" style="flex-wrap:wrap;gap:8px;">
        <small id="custInfo" class="text-muted"></small>
        <div id="custPagination"></div>
      </div>
    </div>

    <!-- Customer Modal -->
    <div class="modal fade" id="customerModal" tabindex="-1">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="custModalTitle">Add Customer</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-md-6"><label class="form-label-custom">First Name *</label><input id="cf-fname" class="form-control-custom" placeholder="First name"></div>
              <div class="col-md-6"><label class="form-label-custom">Last Name *</label><input id="cf-lname" class="form-control-custom" placeholder="Last name"></div>
              <div class="col-md-6"><label class="form-label-custom">Email *</label><input id="cf-email" type="email" class="form-control-custom" placeholder="Email"></div>
              <div class="col-md-6"><label class="form-label-custom">NID</label><input id="cf-nid" class="form-control-custom" placeholder="National ID"></div>
              <div class="col-md-6">
                <label class="form-label-custom">Gender</label>
                <select id="cf-gender" class="form-control-custom"><option value="">Select</option><option>Male</option><option>Female</option><option>Other</option></select>
              </div>
              <div class="col-md-6"><label class="form-label-custom">Date of Birth</label><input id="cf-dob" type="date" class="form-control-custom"></div>
              <div class="col-12"><hr class="my-1"><p class="form-label-custom mb-2">Address</p></div>
              <div class="col-md-4"><label class="form-label-custom">House No</label><input id="cf-house" class="form-control-custom" placeholder="House No"></div>
              <div class="col-md-4"><label class="form-label-custom">Area</label><input id="cf-area" class="form-control-custom" placeholder="Area"></div>
              <div class="col-md-4"><label class="form-label-custom">City</label><input id="cf-city" class="form-control-custom" placeholder="City"></div>
              <div class="col-md-6"><label class="form-label-custom">District</label><input id="cf-district" class="form-control-custom" placeholder="District"></div>
              <div class="col-md-6"><label class="form-label-custom">Postal Code</label><input id="cf-postal" class="form-control-custom" placeholder="Postal Code"></div>
              <div class="col-12"><label class="form-label-custom">Phone Numbers (comma separated)</label><input id="cf-phones" class="form-control-custom" placeholder="01712345678, 01812345678"></div>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button class="btn-primary-custom" onclick="saveCustomer()"><i class="bi bi-check-lg"></i> Save</button>
          </div>
        </div>
      </div>
    </div>
  `;
  window.debouncedCustSearch = debounce(v => { custSearch = v; custPage = 1; loadCustomers(); });
  loadCustomers();
}

async function loadCustomers() {
  document.getElementById('custTableWrap').innerHTML = `<div class="loading-overlay"><div class="spinner"></div></div>`;
  try {
    const data = await apiGet('/customers', { search: custSearch, page: custPage, limit: 10 });
    if (!data.data.length) {
      document.getElementById('custTableWrap').innerHTML = `<div class="empty-state"><i class="bi bi-people"></i><p>No customers found</p></div>`;
      document.getElementById('custInfo').textContent = ''; return;
    }
    document.getElementById('custTableWrap').innerHTML = `
      <div class="table-wrapper">
        <table class="tms-table">
          <thead><tr><th>ID</th><th>Customer</th><th>Email</th><th>Phone</th><th>City</th><th>Gender</th><th>Reg Date</th><th>Actions</th></tr></thead>
          <tbody>
            ${data.data.map(c => `
              <tr>
                <td><span class="text-muted fw-500">#${c.CustomerID}</span></td>
                <td>
                  <div class="d-flex align-items-center gap-2">
                    <div class="avatar" style="background:${avatarColor(c.FirstName+c.LastName)};">${avatarInitials(c.FirstName+' '+c.LastName)}</div>
                    <div><div class="fw-600">${c.FirstName} ${c.LastName}</div><small class="text-muted">${c.NID || 'No NID'}</small></div>
                  </div>
                </td>
                <td>${c.Email}</td>
                <td>${c.PhoneNumbers ? c.PhoneNumbers.split(',')[0] : '-'}</td>
                <td>${c.City || '-'}</td>
                <td>${c.Gender || '-'}</td>
                <td>${fmtDate(c.RegDate)}</td>
                <td>
                  <div class="d-flex gap-1">
                    <button class="btn-icon btn-icon-view" title="View" onclick="viewCustomer(${c.CustomerID})"><i class="bi bi-eye"></i></button>
                    <button class="btn-icon btn-icon-edit" title="Edit" onclick="editCustomer(${c.CustomerID})"><i class="bi bi-pencil"></i></button>
                    <button class="btn-icon btn-icon-delete" title="Delete" onclick="deleteCustomer(${c.CustomerID})"><i class="bi bi-trash"></i></button>
                  </div>
                </td>
              </tr>`).join('')}
          </tbody>
        </table>
      </div>`;
    const start = (custPage - 1) * 10 + 1;
    const end = Math.min(custPage * 10, data.total);
    document.getElementById('custInfo').textContent = `Showing ${start}-${end} of ${data.total} customers`;
    buildPagination('custPagination', custPage, data.total, 10, p => { custPage = p; loadCustomers(); });
  } catch (e) {
    document.getElementById('custTableWrap').innerHTML = `<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>${e.message}</p></div>`;
  }
}

let editingCustId = null;
function openCustomerModal(customer = null) {
  editingCustId = customer?.CustomerID || null;
  document.getElementById('custModalTitle').textContent = customer ? 'Edit Customer' : 'Add Customer';
  const fields = ['fname','lname','email','nid','gender','dob','house','area','city','district','postal','phones'];
  const mapping = { fname: customer?.FirstName, lname: customer?.LastName, email: customer?.Email, nid: customer?.NID, gender: customer?.Gender, dob: customer?.DoB?.split('T')[0], house: customer?.HouseNo, area: customer?.Area, city: customer?.City, district: customer?.District, postal: customer?.PostalCode, phones: customer?.PhoneNumbers };
  fields.forEach(f => { const el = document.getElementById('cf-'+f); if (el) el.value = mapping[f] || ''; });
  new bootstrap.Modal(document.getElementById('customerModal')).show();
}

async function editCustomer(id) {
  try {
    const c = await apiGet(`/customers/${id}`);
    openCustomerModal(c);
  } catch (e) { showToast(e.message, 'error'); }
}

async function viewCustomer(id) {
  try {
    const c = await apiGet(`/customers/${id}`);
    const bookings = await apiGet(`/customers/${id}/bookings`);
    // Show in a simple alert-style modal (reuse confirm modal for view)
    const info = `
      <b>${c.FirstName} ${c.LastName}</b> (ID: ${c.CustomerID})<br>
      Email: ${c.Email}<br>
      Phones: ${c.PhoneNumbers || 'N/A'}<br>
      Gender: ${c.Gender || 'N/A'} | DoB: ${fmtDate(c.DoB)}<br>
      Address: ${[c.HouseNo,c.Area,c.City,c.District,c.PostalCode].filter(Boolean).join(', ') || 'N/A'}<br>
      <br><b>Bookings (${bookings.length}):</b> ${bookings.map(b=>b.TourName).join(', ') || 'None'}
    `;
    document.getElementById('confirmMessage').innerHTML = info;
    document.getElementById('confirmBtn').style.display = 'none';
    const m = new bootstrap.Modal(document.getElementById('confirmModal'));
    document.getElementById('confirmModal').addEventListener('hidden.bs.modal', () => {
      document.getElementById('confirmBtn').style.display = '';
    }, { once: true });
    m.show();
  } catch (e) { showToast(e.message, 'error'); }
}

async function saveCustomer() {
  const phones = document.getElementById('cf-phones').value.split(',').map(p => p.trim()).filter(Boolean);
  const payload = {
    FirstName: document.getElementById('cf-fname').value.trim(),
    LastName: document.getElementById('cf-lname').value.trim(),
    Email: document.getElementById('cf-email').value.trim(),
    NID: document.getElementById('cf-nid').value.trim() || null,
    Gender: document.getElementById('cf-gender').value || null,
    DoB: document.getElementById('cf-dob').value || null,
    HouseNo: document.getElementById('cf-house').value.trim() || null,
    Area: document.getElementById('cf-area').value.trim() || null,
    City: document.getElementById('cf-city').value.trim() || null,
    District: document.getElementById('cf-district').value.trim() || null,
    PostalCode: document.getElementById('cf-postal').value.trim() || null,
    PhoneNumbers: phones,
  };
  if (!payload.FirstName || !payload.LastName || !payload.Email) { showToast('First name, last name, and email are required', 'warning'); return; }
  try {
    if (editingCustId) {
      await apiPut(`/customers/${editingCustId}`, payload);
      showToast('Customer updated successfully', 'success');
    } else {
      await apiPost('/customers', payload);
      showToast('Customer added successfully', 'success');
    }
    bootstrap.Modal.getInstance(document.getElementById('customerModal')).hide();
    loadCustomers();
  } catch (e) { showToast(e.message, 'error'); }
}

async function deleteCustomer(id) {
  const ok = await confirmDelete(`Delete customer #${id}? This will also remove their phone numbers.`);
  if (!ok) return;
  try {
    await apiDelete(`/customers/${id}`);
    showToast('Customer deleted', 'success');
    loadCustomers();
  } catch (e) { showToast(e.message, 'error'); }
}
