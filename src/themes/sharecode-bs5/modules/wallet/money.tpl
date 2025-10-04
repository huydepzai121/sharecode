<!-- BEGIN: main -->
<div class="row">
    <div class="col-xl-12">
        <div class="card">
            <div class="card-body">
                    <div class="ribbon-title ribbon-primary">{LANG.money}</div>
                    <div class="mt-4"></div>
                    <!-- BEGIN: loop -->
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td class="w250">{LANG.datecreate}</td>
                                <td><strong class="pull-right">{ROW.created_time}</strong></td>
                            </tr>
                            <tr>
                                <td>{LANG.totalmoneyin}</td>
                                <td><strong class="pull-right text-danger">{ROW.money_in} {ROW.money_unit}</strong></td>
                            </tr>
                            <tr>
                                <td>{LANG.totalmoneyout}</td>
                                <td><strong class="pull-right text-danger">{ROW.money_out} {ROW.money_unit}</strong></td>
                            </tr>
                            <tr>
                                <td>{LANG.totalmoney}</td>
                                <td><strong class="pull-right text-danger">{ROW.money_total} {ROW.money_unit}</strong></td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- END: loop -->
                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=historyexchange"><i class="fa fa-eye" aria-hidden="true"></i> {LANG.exchangedetail}</a>
            </div>
        </div>
    </div>

    <div class="col-xl-12">
        <div class="card">
            <div class="card-body">
                <div class="ribbon-title ribbon-primary">
                    {LANG.historyexchange}
                </div>
                <div class="mt-4"></div>
                <div class="">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th class="text-center" style="width: 120px;">{LANG.transaction_code}</th>
                                <th class="text-right" style="width: 130px;">{LANG.moneytransaction}</th>
                                <th class="text-right">{LANG.title_sodu}</th>
                                <th class="text-right hidden" style="width: 130px;">{LANG.mymoneychange}</th>
                                <th class="text-right" style="width: 140px;">{LANG.datetransaction}</th>
                                <th class="text-left" style="width: 130px;">{LANG.transition_status}</th>
                                <th class="text-left">{LANG.infotransaction}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- BEGIN: loop_history -->
                            <tr>
                                <td class="text-center">{ROW.transaction_code}</td>
                                <td class="text-right"><strong class="text-danger">{ROW.status}{ROW.money_net} {ROW.money_unit}</strong></td>
                                <td class="text-right">
                                    <strong class="sodu_his">{ROW.detail} </strong>
                                </td>
                                <td class="text-right hidden"><strong class="text-danger">{ROW.status}{ROW.money_total} {ROW.money_unit}</strong></td>
                                <td class="text-right">{ROW.created_time}</td>
                                <td class="text-left">{ROW.transaction_status}</td>
                                <td class="text-left">{ROW.transaction_info}</td>
                            </tr>
                            <!-- END: loop_history -->
                        </tbody>
                    </table>
                </div>
                <!-- BEGIN: generate_page -->
                <div class="text-center">
                    {GENERATE_PAGE}
                </div>
                <!-- END: generate_page -->
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
