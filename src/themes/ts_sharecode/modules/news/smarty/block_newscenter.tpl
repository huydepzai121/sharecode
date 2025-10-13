{if empty($CONFIGS.tooltip_length) || $CONFIGS.tooltip_length < 50}
{$CONFIGS.tooltip_length = 150}
{/if}
<div class="container">
    <div id="hot-news">
        <div class="panel panel-default news_column">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <h1>Tin tức nổi bật của showroom Mercedes Haxaco Láng Hạ</h1>
                        <h2 class="hidden">Tin tức nổi bật</h2>
                        <div class="hot-news-others margin-bottom-lg">
        {if !empty($OTHER_ROWS)}
                            <ul class="column-margin-left list-none">
                                <li class="icon_list">
                                    <h3 style="display: flex; gap: 15px">
                                        <a href="{$MAIN_ROW.link}" title="{$MAIN_ROW.title}"{if $MAIN_ROW.external_link} target="_blank"{/if}><img src="{$MAIN_ROW.imgsource}" alt="{$MAIN_ROW.title}" style="max-width: 150px;" class="img-thumbnail"/></a>

                                        <div>
                                            <div class="h2 margin-bottom-sm"><a href="{$MAIN_ROW.link}" title="{$MAIN_ROW.title}"{if $MAIN_ROW.external_link} target="_blank"{/if}>{if $CONFIGS.length_othertitle > 0}{$MAIN_ROW.title|truncate:$CONFIGS.length_othertitle:"..."}{else}{$MAIN_ROW.title}{/if}</a></div>
                                            <p class="h5">{$MAIN_ROW.hometext|strip_tags}</p>
                                            <p><a href="{$MAIN_ROW.link}"><em class="fa fa-sign-out"></em>{$LANG->getModule('more')}</a></p>
                                        </div>
                                    </h3>
                                </li>
                                
        {foreach $OTHER_ROWS as $other_row}
                                <li class="icon_list">
                                    <h3 style="display: flex; gap: 15px;">
                                        <img src="{$other_row.imgsource}" alt="{$other_row.title}" class="img-thumbnail pull-right margin-left-sm" style="max-width: 150px;"/>
                                        <a class="show black h4 clearfix" href="{$other_row.link}"{if $other_row.external_link} target="_blank"{/if}{if $CONFIGS.showtooltip} data-placement="{$CONFIGS.tooltip_position|default:"bottom"}" data-content="{$other_row.hometext|truncate:$CONFIGS.tooltip_length:"..."}" data-img="{$other_row.imgsource}" data-rel="tooltip"{else} title="{$other_row.title}"{/if}>
                                            <span>{if $CONFIGS.length_othertitle > 0}{$other_row.title|truncate:$CONFIGS.length_othertitle:"..."}{else}{$other_row.title}{/if}</span>
                                            <p class="h5">{$other_row.hometext|strip_tags}</p>
                                        </a>
                                    </h3>
                                </li>
        {/foreach}
                            </ul>
        {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    #hot-news li a span {
        text-indent: 0px;
    }
</style>