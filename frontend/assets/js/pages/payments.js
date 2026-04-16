// ===== PAYMENTS =====
let payPage = 1, payStatus = '';

async function renderPayments() {
  const content = document.getElementById('page-content');
  content.innerHTML = `
    <div class="data-card">
      <div class="data-card-header">
        <h6><i class="bi bi-credit-card me-2 text-purple"></i>Payments</h6>
        <div class="d-flex gap-2 flex-wrap">
          <select class="form-control-custom" style="width:auto;" onchange="payStatus=this.value;payPage=1;loadPayments()">
            <option value="">All Status</option>
            <option value="Paid">Paid</option>
            <option value="Pending">Pending</option>
            <option value="Refunded">Refunded</option>
          </select>
          <button class="btn-primary-custom" onclick="openPaymentModal()"><i class="bi bi-plus-lg"></i> Add Payment</button>
        </div>
      </div>
      <div id="payTableWrap"><div class="loading-overlay"><div class="spinner"></div></div></div>
      <div class="p-3 d-flex justify-content-between align-items-center border-top" style="flex-wrap:wrap;gap:8px;">
        <small id="payInfo" class="text-muted"></small>
        <div id="payPagination"></div>
      </div>
    </div>
    <!-- Payment Modal -->
    <div class="modal fade" id="paymentModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header"><h5 class="modal-title" id="payModalTitle">Add Payment</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-12"><label class="form-label-custom">Booking *</label><select id="pf-booking" class="form-control-custom"><option value="">Select Booking</option></select></div>
              <div class="col-md-6"><label class="form-label-custom">Amount (BDT) *</label><input id="pf-amount" type="number" class="form-control-custom" placeholder="Amount"></div>
              <div class="col-md-6"><label class="form-label-custom">Date *</label><input id="pf-date" type="date" class="form-control-custom" value="${new Date().toISOString().split('T')[0]}"></div>
              <div class="col-md-6">
                <label class="form-label-custom">Method *</label>
                <select id="pf-method" class="form-control-custom">
                  <option>Bkash</option><option>Nagad</option><option>Rocket</option><option>Card</option><option>Cash</option><option>BankTransfer</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label-custom">Status</label>
                <select id="pf-status" class="form-control-custom"><option>Paid</option><option>Pending</option><option>Refunded</option></select>
              </div>
              <div class="col-12"><label class="form-label-custom">Transaction ID</label><input id="pf-txn" class="form-control-custom" placeholder="Transaction ID"></div>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button class="btn-primary-custom" onclick="savePayment()"><i class="bi bi-check-lg"></i> Save</button>
          </div>
        </div>
      </div>
    </div>`;
  loadPayments();
}

async function loadPayments() {
  document.getElementById('payTableWrap').innerHTML = `<div class="loading-overlay"><div class="spinner"></div></div>`;
  try {
    const data = await apiGet('/payments', { status: payStatus, page: payPage, limit: 10 });
    if (!data.data.length) { document.getElementById('payTableWrap').innerHTML = `<div class="empty-state"><i class="bi bi-credit-card"></i><p>No payments found</p></div>`; return; }
    document.getElementById('payTableWrap').innerHTML = `
      <div class="table-wrapper">
        <table class="tms-table">
          <thead><tr><th>ID</th><th>Booking</th><th>Customer</th><th>Tour</th><th>Amount</th><th>Method</th><th>Date</th><th>Transaction ID</th><th>Status</th><th>Actions</th></tr></thead>
          <tbody>
            ${data.data.map(p => `
              <tr>
                <td><span class="text-muted">#${p.PaymentID}</span></td>
                <td>#${p.BookingID}</td>
                <td>${p.CustomerName || '-'}</td>
                <td>${p.TourName || '-'}</td>
                <td><span class="fw-bold">${fmtCurrency(p.Amount)}</span></td>
                <td><span class="badge bg-light text-dark border">${p.PaymentMethod}</span></td>
                <td>${fmtDate(p.PaymentDate)}</td>
                <td><small class="text-muted font-monospace">${p.TransactionID || '-'}</small></td>
                <td>${statusBadge(p.PaymentStatus)}</td>
                <td>
                  <div class="d-flex gap-1">
                    <button class="btn-icon btn-icon-edit" onclick="editPayment(${p.PaymentID})"><i class="bi bi-pencil"></i></button>
                    <button class="btn-icon btn-icon-delete" onclick="deletePayment(${p.PaymentID})"><i class="bi bi-trash"></i></button>
                  </div>
                </td>
              </tr>`).join('')}
          </tbody>
        </table>
      </div>`;
    const s = (payPage-1)*10+1, e2 = Math.min(payPage*10, data.total);
    document.getElementById('payInfo').textContent = `Showing ${s}-${e2} of ${data.total}`;
    buildPagination('payPagination', payPage, data.total, 10, p => { payPage = p; loadPayments(); });
  } catch(e) { document.getElementById('payTableWrap').innerHTML = `<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>${e.message}</p></div>`; }
}

let editingPayId = null;
async function openPaymentModal() {
  editingPayId = null;
  document.getElementById('payModalTitle').textContent = 'Add Payment';
  try {
    const bookings = await apiGet('/bookings', { limit: 200 });
    document.getElementById('pf-booking').innerHTML = `<option value="">Select Booking</option>` + bookings.data.map(b => `<option value="${b.BookingID}">#${b.BookingID} - ${b.CustomerName} - ${b.TourName}</option>`).join('');
  } catch(e) {}
  ['amount','txn'].forEach(f => { const el = document.getElementById('pf-'+f); if(el) el.value = ''; });
  new bootstrap.Modal(document.getElementById('paymentModal')).show();
}

async function editPayment(id) {
  editingPayId = id;
  const p = await apiGet(`/payments/${id}`);
  await openPaymentModal();
  document.getElementById('pf-booking').value = p.BookingID;
  document.getElementById('pf-amount').value = p.Amount;
  document.getElementById('pf-date').value = p.PaymentDate?.split('T')[0];
  document.getElementById('pf-method').value = p.PaymentMethod;
  document.getElementById('pf-status').value = p.PaymentStatus;
  document.getElementById('pf-txn').value = p.TransactionID || '';
  document.getElementById('payModalTitle').textContent = 'Edit Payment';
}

async function savePayment() {
  const payload = { BookingID: parseInt(document.getElementById('pf-booking').value), Amount: parseFloat(document.getElementById('pf-amount').value), PaymentDate: document.getElementById('pf-date').value, PaymentMethod: document.getElementById('pf-method').value, PaymentStatus: document.getElementById('pf-status').value, TransactionID: document.getElementById('pf-txn').value || null };
  if (!payload.BookingID || !payload.Amount) { showToast('Booking and amount are required', 'warning'); return; }
  try {
    editingPayId ? await apiPut(`/payments/${editingPayId}`, payload) : await apiPost('/payments', payload);
    showToast(editingPayId ? 'Payment updated' : 'Payment added', 'success');
    bootstrap.Modal.getInstance(document.getElementById('paymentModal')).hide();
    loadPayments();
  } catch(e) { showToast(e.message, 'error'); }
}

async function deletePayment(id) {
  if (!await confirmDelete(`Delete payment #${id}?`)) return;
  try { await apiDelete(`/payments/${id}`); showToast('Payment deleted', 'success'); loadPayments(); } catch(e) { showToast(e.message, 'error'); }
}


// ===== REVIEWS =====
let revPage = 1;

async function renderReviews() {
  const content = document.getElementById('page-content');
  content.innerHTML = `
    <div class="data-card">
      <div class="data-card-header">
        <h6><i class="bi bi-star me-2 text-warning"></i>Reviews</h6>
        <button class="btn-primary-custom" onclick="openReviewModal()"><i class="bi bi-plus-lg"></i> Add Review</button>
      </div>
      <div id="revTableWrap"><div class="loading-overlay"><div class="spinner"></div></div></div>
      <div class="p-3 d-flex justify-content-between align-items-center border-top" style="flex-wrap:wrap;gap:8px;">
        <small id="revInfo" class="text-muted"></small>
        <div id="revPagination"></div>
      </div>
    </div>
    <div class="modal fade" id="reviewModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header"><h5 class="modal-title" id="revModalTitle">Add Review</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-12"><label class="form-label-custom">Customer *</label><select id="rvf-customer" class="form-control-custom"><option value="">Select Customer</option></select></div>
              <div class="col-12"><label class="form-label-custom">Tour Package *</label><select id="rvf-tour" class="form-control-custom"><option value="">Select Tour</option></select></div>
              <div class="col-md-6"><label class="form-label-custom">Rating (1-5) *</label><input id="rvf-rating" type="number" min="1" max="5" class="form-control-custom" placeholder="1-5"></div>
              <div class="col-md-6"><label class="form-label-custom">Review Date *</label><input id="rvf-date" type="date" class="form-control-custom" value="${new Date().toISOString().split('T')[0]}"></div>
              <div class="col-12"><label class="form-label-custom">Comment</label><textarea id="rvf-comment" class="form-control-custom" rows="3" placeholder="Write your review..."></textarea></div>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button class="btn-primary-custom" onclick="saveReview()"><i class="bi bi-check-lg"></i> Save</button>
          </div>
        </div>
      </div>
    </div>`;
  loadReviews();
}

async function loadReviews() {
  document.getElementById('revTableWrap').innerHTML = `<div class="loading-overlay"><div class="spinner"></div></div>`;
  try {
    const data = await apiGet('/reviews', { page: revPage, limit: 10 });
    if (!data.data.length) { document.getElementById('revTableWrap').innerHTML = `<div class="empty-state"><i class="bi bi-star"></i><p>No reviews found</p></div>`; return; }
    document.getElementById('revTableWrap').innerHTML = `
      <div class="table-wrapper">
        <table class="tms-table">
          <thead><tr><th>ID</th><th>Customer</th><th>Tour</th><th>Rating</th><th>Comment</th><th>Date</th><th>Actions</th></tr></thead>
          <tbody>
            ${data.data.map(r => `
              <tr>
                <td><span class="text-muted">#${r.ReviewID}</span></td>
                <td>${r.CustomerName || '-'}</td>
                <td>${r.TourName || '-'}</td>
                <td>${renderStars(r.Rating)} <small class="text-muted ms-1">${r.Rating}/5</small></td>
                <td style="max-width:250px;"><div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="${r.Comment||''}">${r.Comment || '-'}</div></td>
                <td>${fmtDate(r.ReviewDate)}</td>
                <td>
                  <div class="d-flex gap-1">
                    <button class="btn-icon btn-icon-edit" onclick="editReview(${r.ReviewID})"><i class="bi bi-pencil"></i></button>
                    <button class="btn-icon btn-icon-delete" onclick="deleteReview(${r.ReviewID})"><i class="bi bi-trash"></i></button>
                  </div>
                </td>
              </tr>`).join('')}
          </tbody>
        </table>
      </div>`;
    const s=(revPage-1)*10+1,e2=Math.min(revPage*10,data.total);
    document.getElementById('revInfo').textContent=`Showing ${s}-${e2} of ${data.total}`;
    buildPagination('revPagination',revPage,data.total,10,p=>{revPage=p;loadReviews();});
  } catch(e) { document.getElementById('revTableWrap').innerHTML=`<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>${e.message}</p></div>`; }
}

let editingRevId = null;
async function openReviewModal() {
  editingRevId = null;
  document.getElementById('revModalTitle').textContent = 'Add Review';
  try {
    const [custs, tours] = await Promise.all([apiGet('/customers',{limit:200}), apiGet('/tourpackages',{limit:200})]);
    document.getElementById('rvf-customer').innerHTML = `<option value="">Select Customer</option>` + custs.data.map(c=>`<option value="${c.CustomerID}">${c.FirstName} ${c.LastName}</option>`).join('');
    document.getElementById('rvf-tour').innerHTML = `<option value="">Select Tour</option>` + tours.data.map(t=>`<option value="${t.TourID}">${t.TourName}</option>`).join('');
  } catch(e) {}
  ['rating','comment'].forEach(f=>{const el=document.getElementById('rvf-'+f);if(el)el.value='';});
  new bootstrap.Modal(document.getElementById('reviewModal')).show();
}

async function editReview(id) {
  editingRevId = id;
  const r = await apiGet(`/reviews/${id}`);
  await openReviewModal();
  document.getElementById('rvf-customer').value = r.CustomerID;
  document.getElementById('rvf-tour').value = r.TourID;
  document.getElementById('rvf-rating').value = r.Rating;
  document.getElementById('rvf-date').value = r.ReviewDate?.split('T')[0];
  document.getElementById('rvf-comment').value = r.Comment || '';
  document.getElementById('revModalTitle').textContent = 'Edit Review';
}

async function saveReview() {
  const payload = { CustomerID: parseInt(document.getElementById('rvf-customer').value), TourID: parseInt(document.getElementById('rvf-tour').value), Rating: parseInt(document.getElementById('rvf-rating').value), ReviewDate: document.getElementById('rvf-date').value, Comment: document.getElementById('rvf-comment').value.trim() || null };
  if (!payload.CustomerID || !payload.TourID || !payload.Rating) { showToast('Customer, tour and rating are required', 'warning'); return; }
  try {
    editingRevId ? await apiPut(`/reviews/${editingRevId}`, payload) : await apiPost('/reviews', payload);
    showToast(editingRevId?'Review updated':'Review added','success');
    bootstrap.Modal.getInstance(document.getElementById('reviewModal')).hide();
    loadReviews();
  } catch(e) { showToast(e.message,'error'); }
}

async function deleteReview(id) {
  if (!await confirmDelete(`Delete review #${id}?`)) return;
  try { await apiDelete(`/reviews/${id}`); showToast('Review deleted','success'); loadReviews(); } catch(e) { showToast(e.message,'error'); }
}


// ===== TOUR GUIDES =====
let guidePage = 1, guideSearch = '';

async function renderTourGuides() {
  const content = document.getElementById('page-content');
  content.innerHTML = `
    <div class="data-card">
      <div class="data-card-header">
        <h6><i class="bi bi-person-badge me-2 text-info"></i>Tour Guides</h6>
        <div class="d-flex gap-2 flex-wrap">
          <div class="search-box"><i class="bi bi-search"></i><input type="text" class="form-control-custom" placeholder="Search guides..." oninput="debouncedGuideSearch(this.value)"></div>
          <button class="btn-primary-custom" onclick="openGuideModal()"><i class="bi bi-plus-lg"></i> Add Guide</button>
        </div>
      </div>
      <div id="guideTableWrap"><div class="loading-overlay"><div class="spinner"></div></div></div>
      <div class="p-3 d-flex justify-content-between align-items-center border-top" style="flex-wrap:wrap;gap:8px;">
        <small id="guideInfo" class="text-muted"></small><div id="guidePagination"></div>
      </div>
    </div>
    <div class="modal fade" id="guideModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header"><h5 class="modal-title" id="guideModalTitle">Add Guide</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-md-6"><label class="form-label-custom">First Name *</label><input id="gf-fname" class="form-control-custom" placeholder="First name"></div>
              <div class="col-md-6"><label class="form-label-custom">Last Name *</label><input id="gf-lname" class="form-control-custom" placeholder="Last name"></div>
              <div class="col-md-6"><label class="form-label-custom">Phone *</label><input id="gf-phone" class="form-control-custom" placeholder="Phone number"></div>
              <div class="col-md-6"><label class="form-label-custom">Experience (years)</label><input id="gf-exp" type="number" class="form-control-custom" placeholder="Years"></div>
              <div class="col-12"><label class="form-label-custom">Languages (comma separated)</label><input id="gf-langs" class="form-control-custom" placeholder="Bangla, English, Hindi"></div>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button class="btn-primary-custom" onclick="saveGuide()"><i class="bi bi-check-lg"></i> Save</button>
          </div>
        </div>
      </div>
    </div>`;
  window.debouncedGuideSearch = debounce(v=>{guideSearch=v;guidePage=1;loadGuides();});
  loadGuides();
}

async function loadGuides() {
  document.getElementById('guideTableWrap').innerHTML=`<div class="loading-overlay"><div class="spinner"></div></div>`;
  try {
    const data=await apiGet('/tourguides',{search:guideSearch,page:guidePage,limit:10});
    if(!data.data.length){document.getElementById('guideTableWrap').innerHTML=`<div class="empty-state"><i class="bi bi-person-badge"></i><p>No guides found</p></div>`;return;}
    document.getElementById('guideTableWrap').innerHTML=`
      <div class="table-wrapper">
        <table class="tms-table">
          <thead><tr><th>ID</th><th>Name</th><th>Phone</th><th>Experience</th><th>Languages</th><th>Actions</th></tr></thead>
          <tbody>${data.data.map(g=>`
            <tr>
              <td><span class="text-muted">#${g.GuideID}</span></td>
              <td><div class="d-flex align-items-center gap-2"><div class="avatar" style="background:${avatarColor(g.FirstName+g.LastName)};width:30px;height:30px;font-size:11px;">${avatarInitials(g.FirstName+' '+g.LastName)}</div><div class="fw-600">${g.FirstName} ${g.LastName}</div></div></td>
              <td>${g.Phone}</td>
              <td><span class="fw-bold">${g.ExperienceYears||0}</span> yrs</td>
              <td><div style="max-width:200px;">${(g.Languages||'').split(',').map(l=>`<span class="badge bg-light text-dark border me-1 mb-1">${l.trim()}</span>`).join('')}</div></td>
              <td><div class="d-flex gap-1">
                <button class="btn-icon btn-icon-edit" onclick="editGuide(${g.GuideID})"><i class="bi bi-pencil"></i></button>
                <button class="btn-icon btn-icon-delete" onclick="deleteGuide(${g.GuideID})"><i class="bi bi-trash"></i></button>
              </div></td>
            </tr>`).join('')}</tbody>
        </table>
      </div>`;
    document.getElementById('guideInfo').textContent=`Showing ${(guidePage-1)*10+1}-${Math.min(guidePage*10,data.total)} of ${data.total}`;
    buildPagination('guidePagination',guidePage,data.total,10,p=>{guidePage=p;loadGuides();});
  } catch(e){document.getElementById('guideTableWrap').innerHTML=`<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>${e.message}</p></div>`;}
}

let editingGuideId = null;
function openGuideModal(guide=null){
  editingGuideId=guide?.GuideID||null;
  document.getElementById('guideModalTitle').textContent=guide?'Edit Guide':'Add Guide';
  document.getElementById('gf-fname').value=guide?.FirstName||'';
  document.getElementById('gf-lname').value=guide?.LastName||'';
  document.getElementById('gf-phone').value=guide?.Phone||'';
  document.getElementById('gf-exp').value=guide?.ExperienceYears||'';
  document.getElementById('gf-langs').value=guide?.Languages||'';
  new bootstrap.Modal(document.getElementById('guideModal')).show();
}
async function editGuide(id){try{const g=await apiGet(`/tourguides/${id}`);openGuideModal(g);}catch(e){showToast(e.message,'error');}}
async function saveGuide(){
  const langs=document.getElementById('gf-langs').value.split(',').map(l=>l.trim()).filter(Boolean);
  const payload={FirstName:document.getElementById('gf-fname').value.trim(),LastName:document.getElementById('gf-lname').value.trim(),Phone:document.getElementById('gf-phone').value.trim(),ExperienceYears:parseInt(document.getElementById('gf-exp').value)||null,Languages:langs};
  if(!payload.FirstName||!payload.Phone){showToast('Name and phone are required','warning');return;}
  try{
    editingGuideId?await apiPut(`/tourguides/${editingGuideId}`,payload):await apiPost('/tourguides',payload);
    showToast(editingGuideId?'Guide updated':'Guide added','success');
    bootstrap.Modal.getInstance(document.getElementById('guideModal')).hide();
    loadGuides();
  }catch(e){showToast(e.message,'error');}
}
async function deleteGuide(id){
  if(!await confirmDelete(`Delete guide #${id}?`))return;
  try{await apiDelete(`/tourguides/${id}`);showToast('Guide deleted','success');loadGuides();}catch(e){showToast(e.message,'error');}
}


// ===== LOCATIONS =====
let locPage=1,locSearch='';
async function renderLocations(){
  const content=document.getElementById('page-content');
  content.innerHTML=`
    <div class="data-card">
      <div class="data-card-header">
        <h6><i class="bi bi-geo-alt me-2 text-danger"></i>Locations</h6>
        <div class="d-flex gap-2 flex-wrap">
          <div class="search-box"><i class="bi bi-search"></i><input type="text" class="form-control-custom" placeholder="Search locations..." oninput="debouncedLocSearch(this.value)"></div>
          <button class="btn-primary-custom" onclick="openLocModal()"><i class="bi bi-plus-lg"></i> Add Location</button>
        </div>
      </div>
      <div id="locTableWrap"><div class="loading-overlay"><div class="spinner"></div></div></div>
      <div class="p-3 d-flex justify-content-between align-items-center border-top" style="flex-wrap:wrap;gap:8px;">
        <small id="locInfo" class="text-muted"></small><div id="locPagination"></div>
      </div>
    </div>
    <div class="modal fade" id="locModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header"><h5 class="modal-title" id="locModalTitle">Add Location</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-12"><label class="form-label-custom">Place Name *</label><input id="lf-place" class="form-control-custom" placeholder="Place name"></div>
              <div class="col-md-6"><label class="form-label-custom">Area</label><input id="lf-area" class="form-control-custom" placeholder="Area"></div>
              <div class="col-md-6"><label class="form-label-custom">District</label><input id="lf-district" class="form-control-custom" placeholder="District"></div>
              <div class="col-md-6"><label class="form-label-custom">Division</label><input id="lf-division" class="form-control-custom" placeholder="Division"></div>
              <div class="col-md-6">
                <label class="form-label-custom">Best Season</label>
                <select id="lf-season" class="form-control-custom"><option value="">Select</option><option>Winter</option><option>Summer</option><option>Monsoon</option><option>All Year</option></select>
              </div>
              <div class="col-12"><label class="form-label-custom">Description</label><textarea id="lf-desc" class="form-control-custom" rows="3" placeholder="Describe this location..."></textarea></div>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button class="btn-primary-custom" onclick="saveLoc()"><i class="bi bi-check-lg"></i> Save</button>
          </div>
        </div>
      </div>
    </div>`;
  window.debouncedLocSearch=debounce(v=>{locSearch=v;locPage=1;loadLocations();});
  loadLocations();
}

async function loadLocations(){
  document.getElementById('locTableWrap').innerHTML=`<div class="loading-overlay"><div class="spinner"></div></div>`;
  try{
    const data=await apiGet('/locations',{search:locSearch,page:locPage,limit:10});
    if(!data.data.length){document.getElementById('locTableWrap').innerHTML=`<div class="empty-state"><i class="bi bi-geo-alt"></i><p>No locations found</p></div>`;return;}
    document.getElementById('locTableWrap').innerHTML=`
      <div class="table-wrapper">
        <table class="tms-table">
          <thead><tr><th>ID</th><th>Place Name</th><th>Area</th><th>District</th><th>Division</th><th>Best Season</th><th>Description</th><th>Actions</th></tr></thead>
          <tbody>${data.data.map(l=>`
            <tr>
              <td><span class="text-muted">#${l.LocationID}</span></td>
              <td><span class="fw-600">${l.PlaceName}</span></td>
              <td>${l.Area||'-'}</td>
              <td>${l.District||'-'}</td>
              <td>${l.Division||'-'}</td>
              <td><span class="badge-status badge-confirmed">${l.BestSeason||'-'}</span></td>
              <td style="max-width:200px;"><div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="${l.Description||''}">${l.Description||'-'}</div></td>
              <td><div class="d-flex gap-1">
                <button class="btn-icon btn-icon-edit" onclick="editLoc(${l.LocationID})"><i class="bi bi-pencil"></i></button>
                <button class="btn-icon btn-icon-delete" onclick="deleteLoc(${l.LocationID})"><i class="bi bi-trash"></i></button>
              </div></td>
            </tr>`).join('')}</tbody>
        </table>
      </div>`;
    document.getElementById('locInfo').textContent=`Showing ${(locPage-1)*10+1}-${Math.min(locPage*10,data.total)} of ${data.total}`;
    buildPagination('locPagination',locPage,data.total,10,p=>{locPage=p;loadLocations();});
  }catch(e){document.getElementById('locTableWrap').innerHTML=`<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>${e.message}</p></div>`;}
}

let editingLocId=null;
function openLocModal(loc=null){
  editingLocId=loc?.LocationID||null;
  document.getElementById('locModalTitle').textContent=loc?'Edit Location':'Add Location';
  ['place','area','district','division','desc'].forEach(f=>{const el=document.getElementById('lf-'+f);const map={place:loc?.PlaceName,area:loc?.Area,district:loc?.District,division:loc?.Division,desc:loc?.Description};if(el)el.value=map[f]||'';});
  document.getElementById('lf-season').value=loc?.BestSeason||'';
  new bootstrap.Modal(document.getElementById('locModal')).show();
}
async function editLoc(id){try{const l=await apiGet(`/locations/${id}`);openLocModal(l);}catch(e){showToast(e.message,'error');}}
async function saveLoc(){
  const payload={PlaceName:document.getElementById('lf-place').value.trim(),Area:document.getElementById('lf-area').value.trim()||null,District:document.getElementById('lf-district').value.trim()||null,Division:document.getElementById('lf-division').value.trim()||null,BestSeason:document.getElementById('lf-season').value||null,Description:document.getElementById('lf-desc').value.trim()||null};
  if(!payload.PlaceName){showToast('Place name is required','warning');return;}
  try{
    editingLocId?await apiPut(`/locations/${editingLocId}`,payload):await apiPost('/locations',payload);
    showToast(editingLocId?'Location updated':'Location added','success');
    bootstrap.Modal.getInstance(document.getElementById('locModal')).hide();
    loadLocations();
  }catch(e){showToast(e.message,'error');}
}
async function deleteLoc(id){
  if(!await confirmDelete(`Delete location #${id}?`))return;
  try{await apiDelete(`/locations/${id}`);showToast('Location deleted','success');loadLocations();}catch(e){showToast(e.message,'error');}
}


// ===== HOTELS =====
let hotelPage=1,hotelSearch='';
async function renderHotels(){
  const content=document.getElementById('page-content');
  content.innerHTML=`
    <div class="data-card">
      <div class="data-card-header">
        <h6><i class="bi bi-building me-2 text-secondary"></i>Hotels</h6>
        <div class="d-flex gap-2 flex-wrap">
          <div class="search-box"><i class="bi bi-search"></i><input type="text" class="form-control-custom" placeholder="Search hotels..." oninput="debouncedHotelSearch(this.value)"></div>
          <button class="btn-primary-custom" onclick="openHotelModal()"><i class="bi bi-plus-lg"></i> Add Hotel</button>
        </div>
      </div>
      <div id="hotelTableWrap"><div class="loading-overlay"><div class="spinner"></div></div></div>
      <div class="p-3 d-flex justify-content-between align-items-center border-top" style="flex-wrap:wrap;gap:8px;">
        <small id="hotelInfo" class="text-muted"></small><div id="hotelPagination"></div>
      </div>
    </div>
    <div class="modal fade" id="hotelModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header"><h5 class="modal-title" id="hotelModalTitle">Add Hotel</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-12"><label class="form-label-custom">Hotel Name *</label><input id="hf-name" class="form-control-custom" placeholder="Hotel name"></div>
              <div class="col-md-6"><label class="form-label-custom">Star Rating (1-5)</label><input id="hf-star" type="number" min="1" max="5" class="form-control-custom" placeholder="Stars"></div>
              <div class="col-md-6"><label class="form-label-custom">Price Per Night (BDT)</label><input id="hf-price" type="number" class="form-control-custom" placeholder="Price"></div>
              <div class="col-12"><label class="form-label-custom">Location *</label><select id="hf-location" class="form-control-custom"><option value="">Loading...</option></select></div>
            </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button class="btn-primary-custom" onclick="saveHotel()"><i class="bi bi-check-lg"></i> Save</button>
          </div>
        </div>
      </div>
    </div>`;
  window.debouncedHotelSearch=debounce(v=>{hotelSearch=v;hotelPage=1;loadHotels();});
  loadHotels();
}

async function loadHotels(){
  document.getElementById('hotelTableWrap').innerHTML=`<div class="loading-overlay"><div class="spinner"></div></div>`;
  try{
    const data=await apiGet('/hotels',{search:hotelSearch,page:hotelPage,limit:10});
    if(!data.data.length){document.getElementById('hotelTableWrap').innerHTML=`<div class="empty-state"><i class="bi bi-building"></i><p>No hotels found</p></div>`;return;}
    document.getElementById('hotelTableWrap').innerHTML=`
      <div class="table-wrapper">
        <table class="tms-table">
          <thead><tr><th>ID</th><th>Hotel Name</th><th>Location</th><th>Stars</th><th>Price/Night</th><th>Actions</th></tr></thead>
          <tbody>${data.data.map(h=>`
            <tr>
              <td><span class="text-muted">#${h.HotelID}</span></td>
              <td><span class="fw-600">${h.HotelName}</span></td>
              <td>${h.PlaceName||'-'}, ${h.District||'-'}</td>
              <td>${renderStars(h.StarRating)} <small class="text-muted">${h.StarRating||0}★</small></td>
              <td><span class="fw-bold text-primary">${fmtCurrency(h.PricePerNight)}</span></td>
              <td><div class="d-flex gap-1">
                <button class="btn-icon btn-icon-edit" onclick="editHotel(${h.HotelID})"><i class="bi bi-pencil"></i></button>
                <button class="btn-icon btn-icon-delete" onclick="deleteHotel(${h.HotelID})"><i class="bi bi-trash"></i></button>
              </div></td>
            </tr>`).join('')}</tbody>
        </table>
      </div>`;
    document.getElementById('hotelInfo').textContent=`Showing ${(hotelPage-1)*10+1}-${Math.min(hotelPage*10,data.total)} of ${data.total}`;
    buildPagination('hotelPagination',hotelPage,data.total,10,p=>{hotelPage=p;loadHotels();});
  }catch(e){document.getElementById('hotelTableWrap').innerHTML=`<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>${e.message}</p></div>`;}
}

let editingHotelId=null;
async function openHotelModal(hotel=null){
  editingHotelId=hotel?.HotelID||null;
  document.getElementById('hotelModalTitle').textContent=hotel?'Edit Hotel':'Add Hotel';
  try{
    const locs=await apiGet('/locations/all');
    document.getElementById('hf-location').innerHTML=`<option value="">Select Location</option>`+locs.map(l=>`<option value="${l.LocationID}" ${hotel?.LocationID==l.LocationID?'selected':''}>${l.PlaceName} - ${l.District}</option>`).join('');
  }catch(e){}
  document.getElementById('hf-name').value=hotel?.HotelName||'';
  document.getElementById('hf-star').value=hotel?.StarRating||'';
  document.getElementById('hf-price').value=hotel?.PricePerNight||'';
  new bootstrap.Modal(document.getElementById('hotelModal')).show();
}
async function editHotel(id){try{const h=await apiGet(`/hotels/${id}`);await openHotelModal(h);}catch(e){showToast(e.message,'error');}}
async function saveHotel(){
  const payload={HotelName:document.getElementById('hf-name').value.trim(),StarRating:parseInt(document.getElementById('hf-star').value)||null,PricePerNight:parseFloat(document.getElementById('hf-price').value)||null,LocationID:parseInt(document.getElementById('hf-location').value)};
  if(!payload.HotelName||!payload.LocationID){showToast('Hotel name and location are required','warning');return;}
  try{
    editingHotelId?await apiPut(`/hotels/${editingHotelId}`,payload):await apiPost('/hotels',payload);
    showToast(editingHotelId?'Hotel updated':'Hotel added','success');
    bootstrap.Modal.getInstance(document.getElementById('hotelModal')).hide();
    loadHotels();
  }catch(e){showToast(e.message,'error');}
}
async function deleteHotel(id){
  if(!await confirmDelete(`Delete hotel #${id}?`))return;
  try{await apiDelete(`/hotels/${id}`);showToast('Hotel deleted','success');loadHotels();}catch(e){showToast(e.message,'error');}
}
