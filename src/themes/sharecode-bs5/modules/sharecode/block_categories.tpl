<div class="sharecode-block-categories">
    <div class="category-item">
        <div class="category-icon">
            <i class="fa fa-folder"></i>
        </div>
        <div class="category-content">
            <h4 class="category-title">
                <a href="{CATEGORY.link}" title="{CATEGORY.title}">{CATEGORY.title}</a>
            </h4>
            <p class="category-description">{CATEGORY.description_short}</p>
            <div class="category-count">
                <i class="fa fa-file-code-o"></i> {CATEGORY.num_sources} mã nguồn
            </div>
            </div>
    </div>
    </div>

<style>
.sharecode-block-categories {
    margin-bottom: 15px;
}

.category-item {
    border: 1px solid #eee;
    border-radius: 6px;
    padding: 15px;
    margin-bottom: 10px;
    display: flex;
    align-items: flex-start;
    gap: 12px;
    transition: all 0.3s ease;
    background: #fff;
}

.category-item:hover {
    border-color: #337ab7;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transform: translateY(-1px);
}

.category-item:last-child {
    margin-bottom: 0;
}

.category-icon {
    flex-shrink: 0;
    width: 40px;
    height: 40px;
    background: #f8f9fa;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #337ab7;
    font-size: 18px;
    transition: all 0.3s ease;
}

.category-item:hover .category-icon {
    background: #337ab7;
    color: white;
}

.category-content {
    flex: 1;
    min-width: 0;
}

.category-title {
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 5px;
    line-height: 1.3;
}

.category-title a {
    color: #333;
    text-decoration: none;
}

.category-title a:hover {
    color: #337ab7;
}

.category-description {
    font-size: 12px;
    color: #666;
    margin-bottom: 5px;
    line-height: 1.4;
}

.category-count {
    font-size: 11px;
    color: #999;
    font-weight: 500;
}

/* Compact layout for sidebar */
.sidebar .sharecode-block-categories .category-item {
    padding: 10px;
    gap: 8px;
}

.sidebar .sharecode-block-categories .category-icon {
    width: 32px;
    height: 32px;
    font-size: 14px;
}

.sidebar .sharecode-block-categories .category-title {
    font-size: 13px;
}

.sidebar .sharecode-block-categories .category-description {
    font-size: 11px;
}

/* Grid layout for main content */
.main-content .sharecode-block-categories {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 15px;
}

.main-content .sharecode-block-categories .category-item {
    margin-bottom: 0;
}

/* Responsive */
@media (max-width: 768px) {
    .main-content .sharecode-block-categories {
        grid-template-columns: 1fr;
    }

    .category-item {
        padding: 12px;
    }

    .category-icon {
        width: 36px;
        height: 36px;
        font-size: 16px;
    }
}

/* List style variant */
.sharecode-block-categories.list-style .category-item {
    border: none;
    border-bottom: 1px solid #eee;
    border-radius: 0;
    padding: 10px 0;
    background: transparent;
}

.sharecode-block-categories.list-style .category-item:hover {
    background: #f8f9fa;
    border-color: #eee;
    transform: none;
    box-shadow: none;
}

.sharecode-block-categories.list-style .category-item:last-child {
    border-bottom: none;
}
</style>
