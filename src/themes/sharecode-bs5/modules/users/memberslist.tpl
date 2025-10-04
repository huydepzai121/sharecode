<!-- BEGIN: main -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <!-- Header -->
            <div class="d-flex align-items-center mb-4">
                <div class="me-3">
                    <i class="fa fa-users fa-2x text-primary"></i>
                </div>
                <div>
                    <h2 class="mb-0 fw-bold">{LANG.listusers}</h2>
                    <p class="text-muted mb-0">Danh sách thành viên trong hệ thống</p>
                </div>
            </div>

            <!-- Search and Filter Section -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">
                                <i class="fa fa-search text-primary me-2"></i>Tìm kiếm thành viên
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light">
                                    <i class="fa fa-search text-muted"></i>
                                </span>
                                <input type="text" class="form-control" placeholder="Nhập tên đăng nhập hoặc họ tên..." id="memberSearch">
                                <button class="btn btn-outline-secondary" type="button" id="clearSearch">
                                    <i class="fa fa-times"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">
                                <i class="fa fa-filter text-success me-2"></i>Lọc theo giới tính
                            </label>
                            <select class="form-select" id="genderFilter">
                                <option value="">Tất cả</option>
                                <option value="Nam">Nam</option>
                                <option value="Nữ">Nữ</option>
                                <option value="Khác">Khác</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-primary w-100" type="button" id="applyFilter">
                                <i class="fa fa-filter me-2"></i>Áp dụng bộ lọc
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Members Table -->
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-primary text-white">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0">
                            <i class="fa fa-list me-2"></i>Danh sách thành viên
                        </h5>
                        <div class="d-flex align-items-center gap-3">
                            <span class="badge bg-light text-dark">
                                <i class="fa fa-users me-1"></i>
                                <span id="memberCount">Đang tải...</span> thành viên
                            </span>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-outline-light btn-sm" id="gridView" title="Xem dạng lưới">
                                    <i class="fa fa-th"></i>
                                </button>
                                <button type="button" class="btn btn-light btn-sm active" id="listView" title="Xem dạng danh sách">
                                    <i class="fa fa-list"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <!-- List View -->
                    <div id="listViewContainer" class="table-responsive">
                        <table class="table table-hover mb-0" id="membersTable">
                            <thead class="table-light">
                                <tr>
                                    <th class="border-0">
                                        <a href="{username}" class="text-decoration-none text-dark fw-bold sortable" data-sort="username">
                                            <i class="fa fa-user me-2"></i>{LANG.account}
                                            <i class="fa fa-sort ms-1 text-muted sort-icon"></i>
                                        </a>
                                    </th>
                                    <th class="text-center border-0" style="width:20%">
                                        <a href="{gender}" class="text-decoration-none text-dark fw-bold sortable" data-sort="gender">
                                            <i class="fa fa-venus-mars me-2"></i>{LANG.gender}
                                            <i class="fa fa-sort ms-1 text-muted sort-icon"></i>
                                        </a>
                                    </th>
                                    <th class="text-center border-0" style="width:25%">
                                        <a href="{regdate}" class="text-decoration-none text-dark fw-bold sortable" data-sort="regdate">
                                            <i class="fa fa-calendar me-2"></i>{LANG.regdate}
                                            <i class="fa fa-sort ms-1 text-muted sort-icon"></i>
                                        </a>
                                    </th>
                                    <th class="text-center border-0" style="width:15%">
                                        <span class="text-dark fw-bold">
                                            <i class="fa fa-cog me-2"></i>Thao tác
                                        </span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="membersTableBody">
                                <!-- BEGIN: list -->
                                <tr class="border-bottom member-row" data-username="{USER.username}" data-fullname="{USER.full_name}" data-gender="{USER.gender}" data-regdate="{USER.regdate}">
                                    <td class="py-3">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-placeholder bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3 position-relative" style="width: 45px; height: 45px; font-size: 18px;">
                                                {USER.username|substr:0:1|upper}
                                                <div class="position-absolute bottom-0 end-0 bg-success rounded-circle" style="width: 12px; height: 12px; border: 2px solid white;" title="Đang hoạt động"></div>
                                            </div>
                                            <div>
                                                <a href="{USER.link}" class="text-decoration-none fw-semibold text-primary d-flex align-items-center">
                                                    {USER.username}
                                                    <i class="fa fa-external-link-alt ms-2 small text-muted"></i>
                                                </a>
                                                <!-- BEGIN: fullname -->
                                                <div class="small text-muted">
                                                    <i class="fa fa-id-card me-1"></i>{USER.full_name}
                                                </div>
                                                <!-- END: fullname -->
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center py-3">
                                        <span class="badge bg-light text-dark border">
                                            <i class="fa fa-{USER.gender == 'Nam' ? 'mars text-primary' : (USER.gender == 'Nữ' ? 'venus text-danger' : 'genderless text-secondary')} me-1"></i>
                                            {USER.gender}
                                        </span>
                                    </td>
                                    <td class="text-center py-3">
                                        <div class="d-flex flex-column align-items-center">
                                            <span class="text-muted small">
                                                <i class="fa fa-clock me-1"></i>{USER.regdate}
                                            </span>
                                            <span class="badge bg-info text-white small mt-1">
                                                Thành viên
                                            </span>
                                        </div>
                                    </td>
                                    <td class="text-center py-3">
                                        <div class="btn-group" role="group">
                                            <a href="{USER.link}" class="btn btn-outline-primary btn-sm" title="Xem hồ sơ">
                                                <i class="fa fa-eye"></i>
                                            </a>
                                            <button type="button" class="btn btn-outline-success btn-sm" title="Gửi tin nhắn">
                                                <i class="fa fa-envelope"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <!-- END: list -->
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <!-- BEGIN: generate_page -->
                    <div class="card-footer bg-light border-0">
                        <div class="d-flex justify-content-center">
                            {GENERATE_PAGE}
                        </div>
                    </div>
                    <!-- END: generate_page -->
                </div>
            </div>

            <!-- Navigation Links -->
            <div class="mt-4">
                <div class="card border-0 bg-light">
                    <div class="card-body">
                        <h6 class="card-title text-muted mb-3">
                            <i class="fa fa-link me-2"></i>Liên kết khác
                        </h6>
                        <div class="d-flex flex-wrap gap-2">
                            <!-- BEGIN: navbar -->
                            <a href="{NAVBAR.href}" class="btn btn-outline-primary btn-sm">
                                <i class="fa fa-caret-right me-1"></i>{NAVBAR.title}
                            </a>
                            <!-- END: navbar -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Enhanced JavaScript for Members List -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Update member count
    const memberRows = document.querySelectorAll('.member-row');
    const memberCount = document.getElementById('memberCount');
    if (memberCount) {
        memberCount.textContent = memberRows.length;
    }

    // Search functionality
    const searchInput = document.getElementById('memberSearch');
    const clearSearch = document.getElementById('clearSearch');
    const genderFilter = document.getElementById('genderFilter');
    const applyFilter = document.getElementById('applyFilter');

    function filterMembers() {
        const searchTerm = searchInput.value.toLowerCase();
        const selectedGender = genderFilter.value;
        let visibleCount = 0;

        memberRows.forEach(row => {
            const username = row.dataset.username.toLowerCase();
            const fullname = row.dataset.fullname.toLowerCase();
            const gender = row.dataset.gender;

            const matchesSearch = username.includes(searchTerm) || fullname.includes(searchTerm);
            const matchesGender = !selectedGender || gender === selectedGender;

            if (matchesSearch && matchesGender) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });

        // Update count
        if (memberCount) {
            memberCount.textContent = visibleCount;
        }

        // Show/hide clear button
        clearSearch.style.display = searchTerm ? 'block' : 'none';
    }

    // Event listeners
    if (searchInput) {
        searchInput.addEventListener('input', filterMembers);
    }

    if (clearSearch) {
        clearSearch.addEventListener('click', function() {
            searchInput.value = '';
            filterMembers();
            searchInput.focus();
        });
    }

    if (genderFilter) {
        genderFilter.addEventListener('change', filterMembers);
    }

    if (applyFilter) {
        applyFilter.addEventListener('click', filterMembers);
    }

    // View toggle functionality
    const gridView = document.getElementById('gridView');
    const listView = document.getElementById('listView');
    const listContainer = document.getElementById('listViewContainer');

    if (gridView && listView) {
        gridView.addEventListener('click', function() {
            // Switch to grid view (placeholder for future implementation)
            gridView.classList.add('active');
            listView.classList.remove('active');
            // TODO: Implement grid view
        });

        listView.addEventListener('click', function() {
            // Switch to list view
            listView.classList.add('active');
            gridView.classList.remove('active');
        });
    }

    // Sort functionality
    const sortableHeaders = document.querySelectorAll('.sortable');
    let currentSort = { column: '', direction: 'asc' };

    sortableHeaders.forEach(header => {
        header.addEventListener('click', function(e) {
            e.preventDefault();
            const column = this.dataset.sort;

            // Toggle direction if same column
            if (currentSort.column === column) {
                currentSort.direction = currentSort.direction === 'asc' ? 'desc' : 'asc';
            } else {
                currentSort.direction = 'asc';
            }
            currentSort.column = column;

            // Update sort icons
            sortableHeaders.forEach(h => {
                const icon = h.querySelector('.sort-icon');
                icon.className = 'fa fa-sort ms-1 text-muted sort-icon';
            });

            const currentIcon = this.querySelector('.sort-icon');
            currentIcon.className = `fa fa-sort-${currentSort.direction === 'asc' ? 'up' : 'down'} ms-1 text-primary sort-icon`;

            // Sort rows
            sortTable(column, currentSort.direction);
        });
    });

    function sortTable(column, direction) {
        const tbody = document.getElementById('membersTableBody');
        const rows = Array.from(tbody.querySelectorAll('.member-row'));

        rows.sort((a, b) => {
            let aVal = a.dataset[column] || '';
            let bVal = b.dataset[column] || '';

            // Convert to lowercase for case-insensitive sorting
            aVal = aVal.toLowerCase();
            bVal = bVal.toLowerCase();

            if (direction === 'asc') {
                return aVal.localeCompare(bVal);
            } else {
                return bVal.localeCompare(aVal);
            }
        });

        // Re-append sorted rows
        rows.forEach(row => tbody.appendChild(row));
    }

    // Initialize clear button state
    if (clearSearch) {
        clearSearch.style.display = 'none';
    }
});
</script>

<!-- Custom Styles for Enhanced Members List -->
<style>
.member-row:hover {
    background-color: rgba(0, 123, 255, 0.05);
    transform: translateY(-1px);
    transition: all 0.2s ease;
}

.avatar-placeholder {
    transition: all 0.3s ease;
}

.member-row:hover .avatar-placeholder {
    transform: scale(1.1);
}

.sortable {
    cursor: pointer;
    transition: color 0.2s ease;
}

.sortable:hover {
    color: var(--bs-primary) !important;
}

.sort-icon {
    transition: all 0.2s ease;
}

.btn-group .btn {
    transition: all 0.2s ease;
}

.btn-group .btn:hover {
    transform: translateY(-1px);
}

@media (max-width: 768px) {
    .member-row td:nth-child(4) {
        display: none;
    }

    .member-row td:nth-child(3) .badge {
        display: none;
    }
}
</style>
<!-- END: main -->