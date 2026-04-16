async function renderAnalytics() {
  const content = document.getElementById('page-content');
  content.innerHTML = `<div class="loading-overlay"><div class="spinner"></div><span>Loading analytics...</span></div>`;
  try {
    const [topTours, revenue, guides, locations, monthly] = await Promise.all([
      apiGet('/analytics/top-tours'),
      apiGet('/analytics/revenue-by-tour'),
      apiGet('/analytics/guide-performance'),
      apiGet('/analytics/location-popularity'),
      apiGet('/analytics/monthly-bookings'),
    ]);

    content.innerHTML = `
      <!-- Monthly Chart -->
      <div class="row g-3 mb-4">
        <div class="col-md-8">
          <div class="data-card p-3">
            <h6 class="fw-bold mb-3"><i class="bi bi-graph-up me-2 text-primary"></i>Monthly Bookings & Travelers</h6>
            <canvas id="monthlyChart" height="120"></canvas>
          </div>
        </div>
        <div class="col-md-4">
          <div class="data-card p-3">
            <h6 class="fw-bold mb-3"><i class="bi bi-geo-alt me-2 text-danger"></i>Location Popularity</h6>
            <canvas id="locationChart" height="220"></canvas>
          </div>
        </div>
      </div>

      <!-- Tables Row -->
      <div class="row g-3">
        <div class="col-md-6">
          <div class="data-card">
            <div class="data-card-header"><h6><i class="bi bi-trophy me-2 text-warning"></i>Top Tour Packages</h6></div>
            <div class="table-wrapper">
              <table class="tms-table">
                <thead><tr><th>#</th><th>Tour</th><th>Bookings</th><th>Travelers</th><th>Avg Rating</th></tr></thead>
                <tbody>${topTours.map((t,i)=>`
                  <tr>
                    <td><span class="fw-bold ${i<3?'text-warning':''}">${i+1}</span></td>
                    <td><div style="max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="${t.TourName}">${t.TourName}</div><small class="text-muted">${t.PlaceName||''}</small></td>
                    <td><span class="fw-bold">${t.total_bookings||0}</span></td>
                    <td>${t.total_travelers||0}</td>
                    <td>${renderStars(Math.round(t.avg_rating||0))} <small>${Number(t.avg_rating||0).toFixed(1)}</small></td>
                  </tr>`).join('')}</tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="data-card">
            <div class="data-card-header"><h6><i class="bi bi-cash-stack me-2 text-success"></i>Revenue by Tour</h6></div>
            <div class="table-wrapper">
              <table class="tms-table">
                <thead><tr><th>Tour</th><th>Revenue</th><th>Payments</th></tr></thead>
                <tbody>${revenue.map(r=>`
                  <tr>
                    <td><div style="max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="${r.TourName}">${r.TourName}</div></td>
                    <td><span class="fw-bold text-success">${fmtCurrency(r.total_revenue)}</span></td>
                    <td>${r.payments}</td>
                  </tr>`).join('')}</tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="data-card">
            <div class="data-card-header"><h6><i class="bi bi-person-badge me-2 text-info"></i>Guide Performance</h6></div>
            <div class="table-wrapper">
              <table class="tms-table">
                <thead><tr><th>Guide</th><th>Exp.</th><th>Tours</th><th>Bookings</th><th>Avg Rating</th></tr></thead>
                <tbody>${guides.map(g=>`
                  <tr>
                    <td>${g.GuideName}</td>
                    <td>${g.ExperienceYears} yrs</td>
                    <td>${g.total_tours||0}</td>
                    <td>${g.total_bookings||0}</td>
                    <td>${renderStars(Math.round(g.avg_rating||0))} <small>${Number(g.avg_rating||0).toFixed(1)}</small></td>
                  </tr>`).join('')}</tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="data-card">
            <div class="data-card-header"><h6><i class="bi bi-map me-2 text-primary"></i>Location Popularity</h6></div>
            <div class="table-wrapper">
              <table class="tms-table">
                <thead><tr><th>Location</th><th>Division</th><th>Season</th><th>Packages</th><th>Bookings</th></tr></thead>
                <tbody>${locations.slice(0,10).map(l=>`
                  <tr>
                    <td>${l.PlaceName}</td>
                    <td><small class="text-muted">${l.Division||'-'}</small></td>
                    <td><span class="badge-status badge-confirmed" style="font-size:10px;">${l.BestSeason||'-'}</span></td>
                    <td>${l.tour_packages||0}</td>
                    <td><span class="fw-bold">${l.total_bookings||0}</span></td>
                  </tr>`).join('')}</tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    `;

    // Monthly Chart
    const months = [...monthly].reverse();
    new Chart(document.getElementById('monthlyChart'), {
      type: 'line',
      data: {
        labels: months.map(m => m.month),
        datasets: [
          { label: 'Bookings', data: months.map(m => m.bookings), borderColor: '#2563eb', backgroundColor: 'rgba(37,99,235,0.08)', fill: true, tension: 0.4, pointRadius: 4 },
          { label: 'Travelers', data: months.map(m => m.travelers), borderColor: '#16a34a', backgroundColor: 'rgba(22,163,74,0.08)', fill: true, tension: 0.4, pointRadius: 4 },
        ]
      },
      options: { plugins: { legend: { position: 'top' } }, scales: { y: { beginAtZero: true } } }
    });

    // Location Pie
    const topLocs = locations.slice(0, 6);
    new Chart(document.getElementById('locationChart'), {
      type: 'pie',
      data: {
        labels: topLocs.map(l => l.PlaceName.length > 15 ? l.PlaceName.substring(0, 15) + '…' : l.PlaceName),
        datasets: [{ data: topLocs.map(l => l.total_bookings || 0), backgroundColor: ['#2563eb','#16a34a','#dc2626','#d97706','#9333ea','#0891b2'], borderWidth: 0 }]
      },
      options: { plugins: { legend: { position: 'bottom', labels: { font: { size: 10 } } } } }
    });

  } catch(e) {
    content.innerHTML = `<div class="empty-state"><i class="bi bi-exclamation-triangle"></i><p>Failed to load analytics: ${e.message}</p></div>`;
  }
}
