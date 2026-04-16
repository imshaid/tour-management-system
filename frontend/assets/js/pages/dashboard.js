async function renderDashboard() {
  const content = document.getElementById('page-content');
  content.innerHTML = `<div class="loading-overlay"><div class="spinner"></div><span>Loading dashboard...</span></div>`;
  try {
    const data = await apiGet('/analytics/dashboard');
    const s = data.stats;
    content.innerHTML = `
      <!-- STAT CARDS -->
      <div class="row g-3 mb-4">
        ${statCard('bi-people-fill', '#eff6ff', '#2563eb', 'Total Customers', s.total_customers, '')}
        ${statCard('bi-map-fill', '#f0fdf4', '#16a34a', 'Tour Packages', s.total_tours, '')}
        ${statCard('bi-calendar-check-fill', '#fefce8', '#ca8a04', 'Total Bookings', s.total_bookings, '')}
        ${statCard('bi-currency-exchange', '#fdf4ff', '#9333ea', 'Total Revenue', fmtCurrency(s.total_revenue), '')}
        ${statCard('bi-clock-history', '#fff7ed', '#ea580c', 'Pending Payments', s.pending_payments, '')}
        ${statCard('bi-star-fill', '#eff6ff', '#0891b2', 'Avg. Rating', (s.avg_rating || 0).toFixed(1) + ' / 5', '')}
      </div>

      <!-- CHARTS ROW -->
      <div class="row g-3 mb-4">
        <div class="col-md-6">
          <div class="data-card p-3">
            <h6 class="fw-bold mb-3">Bookings by Status</h6>
            <canvas id="statusChart" height="200"></canvas>
          </div>
        </div>
        <div class="col-md-6">
          <div class="data-card p-3">
            <h6 class="fw-bold mb-3">Revenue by Payment Method</h6>
            <canvas id="revenueChart" height="200"></canvas>
          </div>
        </div>
      </div>

      <!-- BOTTOM ROW -->
      <div class="row g-3">
        <div class="col-md-7">
          <div class="data-card">
            <div class="data-card-header">
              <h6>Recent Bookings</h6>
              <button class="btn-primary-custom btn-sm" onclick="navigate('bookings')">View All</button>
            </div>
            <div class="table-wrapper">
              <table class="tms-table">
                <thead><tr><th>ID</th><th>Customer</th><th>Tour</th><th>Date</th><th>People</th><th>Status</th></tr></thead>
                <tbody>
                  ${data.recent_bookings.map(b => `
                    <tr>
                      <td><span class="text-muted">#${b.BookingID}</span></td>
                      <td>
                        <div class="d-flex align-items-center gap-2">
                          <div class="avatar" style="background:${avatarColor(b.CustomerName)};width:28px;height:28px;font-size:10px;">${avatarInitials(b.CustomerName)}</div>
                          <span>${b.CustomerName}</span>
                        </div>
                      </td>
                      <td>${b.TourName}</td>
                      <td>${fmtDate(b.BookingDate)}</td>
                      <td>${b.NoOfPeople}</td>
                      <td>${statusBadge(b.BookingStatus)}</td>
                    </tr>`).join('')}
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="col-md-5">
          <div class="data-card">
            <div class="data-card-header"><h6>Top Tour Packages</h6></div>
            <div class="table-wrapper">
              <table class="tms-table">
                <thead><tr><th>Tour</th><th>Bookings</th><th>Rating</th></tr></thead>
                <tbody>
                  ${data.top_tours.map(t => `
                    <tr>
                      <td style="max-width:160px;"><div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="${t.TourName}">${t.TourName}</div></td>
                      <td><span class="fw-bold">${t.bookings}</span></td>
                      <td>${renderStars(Math.round(t.avg_rating))} <small class="text-muted">${Number(t.avg_rating||0).toFixed(1)}</small></td>
                    </tr>`).join('')}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>`;

    // Charts
    const statusColors = { Confirmed: '#16a34a', Pending: '#ca8a04', Cancelled: '#dc2626', Completed: '#2563eb' };
    new Chart(document.getElementById('statusChart'), {
      type: 'doughnut',
      data: {
        labels: data.booking_by_status.map(s => s.BookingStatus),
        datasets: [{ data: data.booking_by_status.map(s => s.count), backgroundColor: data.booking_by_status.map(s => statusColors[s.BookingStatus] || '#94a3b8'), borderWidth: 0 }]
      },
      options: { plugins: { legend: { position: 'right' } }, cutout: '65%' }
    });

    new Chart(document.getElementById('revenueChart'), {
      type: 'bar',
      data: {
        labels: data.revenue_by_method.map(r => r.PaymentMethod),
        datasets: [{ label: 'Revenue (BDT)', data: data.revenue_by_method.map(r => r.total), backgroundColor: '#2563eb', borderRadius: 6 }]
      },
      options: { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { callback: v => 'BDT ' + (v/1000).toFixed(0) + 'k' } } } }
    });

  } catch (e) {
    content.innerHTML = `<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>Failed to load dashboard: ${e.message}</p></div>`;
  }
}

function statCard(icon, bgLight, color, label, value, change) {
  return `
    <div class="col-6 col-md-4 col-xl-2">
      <div class="stat-card">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <div class="stat-label">${label}</div>
            <div class="stat-value mt-1">${value}</div>
          </div>
          <div class="stat-icon" style="background:${bgLight};color:${color};"><i class="bi ${icon}"></i></div>
        </div>
      </div>
    </div>`;
}
