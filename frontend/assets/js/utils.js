// ===== CONFIGURATION =====
const API_BASE = window.API_BASE || 'http://localhost:8000/api';

// ===== API HELPERS =====
async function apiGet(endpoint, params = {}) {
  const url = new URL(API_BASE + endpoint);
  Object.entries(params).forEach(([k, v]) => { if (v !== undefined && v !== '') url.searchParams.append(k, v); });
  const res = await fetch(url);
  if (!res.ok) throw new Error((await res.json()).detail || 'Request failed');
  return res.json();
}

async function apiPost(endpoint, data) {
  const res = await fetch(API_BASE + endpoint, {
    method: 'POST', headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
  });
  if (!res.ok) throw new Error((await res.json()).detail || 'Request failed');
  return res.json();
}

async function apiPut(endpoint, data) {
  const res = await fetch(API_BASE + endpoint, {
    method: 'PUT', headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
  });
  if (!res.ok) throw new Error((await res.json()).detail || 'Request failed');
  return res.json();
}

async function apiDelete(endpoint) {
  const res = await fetch(API_BASE + endpoint, { method: 'DELETE' });
  if (!res.ok) throw new Error((await res.json()).detail || 'Request failed');
  return res.json();
}

// ===== TOAST =====
function showToast(message, type = 'success') {
  const container = document.getElementById('toast-container');
  const icons = { success: 'bi-check-circle-fill', error: 'bi-x-circle-fill', warning: 'bi-exclamation-triangle-fill', info: 'bi-info-circle-fill' };
  const toast = document.createElement('div');
  toast.className = `toast-msg toast-${type}`;
  toast.innerHTML = `<i class="bi ${icons[type] || icons.info}"></i> ${message}`;
  container.appendChild(toast);
  setTimeout(() => toast.remove(), 3100);
}

// ===== AVATAR COLOR =====
function avatarColor(name) {
  const colors = ['#2563eb','#7c3aed','#db2777','#d97706','#059669','#0891b2','#dc2626'];
  let hash = 0;
  for (let c of (name || 'U')) hash = (hash * 31 + c.charCodeAt(0)) % colors.length;
  return colors[Math.abs(hash)];
}

function avatarInitials(name) {
  if (!name) return '?';
  const parts = name.trim().split(' ');
  return (parts[0][0] + (parts[1]?.[0] || '')).toUpperCase();
}

// ===== STATUS BADGE =====
function statusBadge(status) {
  const map = { Confirmed: 'confirmed', Pending: 'pending', Cancelled: 'cancelled', Completed: 'completed', Paid: 'paid', Refunded: 'refunded', Unpaid: 'unpaid' };
  const cls = map[status] || 'pending';
  return `<span class="badge-status badge-${cls}">${status}</span>`;
}

// ===== STARS =====
function renderStars(rating) {
  rating = parseInt(rating) || 0;
  return Array.from({length: 5}, (_, i) =>
    `<i class="bi bi-star-fill ${i < rating ? 'star-rating' : 'star-empty'}"></i>`
  ).join('');
}

// ===== FORMAT DATE =====
function fmtDate(d) {
  if (!d) return '-';
  return new Date(d).toLocaleDateString('en-BD', { year: 'numeric', month: 'short', day: 'numeric' });
}

// ===== FORMAT CURRENCY =====
function fmtCurrency(v) {
  return 'BDT ' + Number(v || 0).toLocaleString('en-BD');
}

// ===== CONFIRM DELETE =====
function confirmDelete(message = 'Are you sure you want to delete this record?') {
  return new Promise(resolve => {
    const modal = new bootstrap.Modal(document.getElementById('confirmModal'));
    document.getElementById('confirmMessage').textContent = message;
    document.getElementById('confirmBtn').onclick = () => { modal.hide(); resolve(true); };
    document.getElementById('confirmModal').addEventListener('hidden.bs.modal', () => resolve(false), { once: true });
    modal.show();
  });
}

// ===== PAGINATION BUILDER =====
function buildPagination(containerId, currentPage, total, limit, onPageChange) {
  const totalPages = Math.ceil(total / limit);
  const container = document.getElementById(containerId);
  if (!container || totalPages <= 1) { if(container) container.innerHTML = ''; return; }
  let pages = [];
  pages.push(`<button ${currentPage === 1 ? 'disabled' : ''} onclick="(${onPageChange})(${currentPage - 1})"><i class="bi bi-chevron-left"></i></button>`);
  for (let i = 1; i <= totalPages; i++) {
    if (i === 1 || i === totalPages || Math.abs(i - currentPage) <= 1) {
      pages.push(`<button class="${i === currentPage ? 'active' : ''}" onclick="(${onPageChange})(${i})">${i}</button>`);
    } else if (pages[pages.length-1] !== '...') {
      pages.push('<span style="padding:0 4px;color:#94a3b8">…</span>');
    }
  }
  pages.push(`<button ${currentPage === totalPages ? 'disabled' : ''} onclick="(${onPageChange})(${currentPage + 1})"><i class="bi bi-chevron-right"></i></button>`);
  container.innerHTML = `<div class="pagination-custom">${pages.join('')}</div>`;
}

// ===== DEBOUNCE =====
function debounce(fn, delay = 400) {
  let t; return (...args) => { clearTimeout(t); t = setTimeout(() => fn(...args), delay); };
}
