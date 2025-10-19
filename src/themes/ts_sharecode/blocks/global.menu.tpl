<!-- BEGIN: tree -->
<li class="{MENUTREE.class}">
    <!-- BEGIN: icon -->
    <img src="{MENUTREE.icon}" />&nbsp;
    <!-- END: icon -->
    <a title="{MENUTREE.note}" href="{MENUTREE.link}" {MENUTREE.target}>{MENUTREE.title_trim}</a>
    <!-- BEGIN: tree_content -->
    <ul>
        {TREE_CONTENT}
    </ul>
    <!-- END: tree_content -->
</li>
<!-- END: tree -->

<!-- BEGIN: main -->
<nav class="nav-menu d-none d-lg-block">
    <ul>
        <!-- BEGIN: loopcat1 -->
        <!-- {CAT1.class}  -->
        <li class="{CAT1.class_sub} {CAT1.class}">
            <!-- BEGIN: icon -->
            <img src="{CAT1.icon}" />&nbsp;
            <!-- END: icon -->
            <a title="{CAT1.note}" href="{CAT1.link}" {CAT1.target}>{CAT1.title_trim}</a>
            <!-- BEGIN: expand -->
            <!-- END: expand -->
            <!-- BEGIN: cat2 -->
                <ul>
                    {HTML_CONTENT}
                </ul>
            <!-- END: cat2 -->
        </li>
        <!-- END: loopcat1 -->
    </ul>
</nav>
<!-- END: main -->
