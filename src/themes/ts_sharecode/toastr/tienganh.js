function success(mess) {
	// toastr.options.showMethod = 'slideDown';
	toastr.options = {
	  "closeButton": false,
	  "debug": false,
	  "newestOnTop": false,
	  "progressBar": false,
	  "positionClass": "toast-top-right",
	  "preventDuplicates": false,
	  "onclick": null,
	  "showDuration": "300",
	  "hideDuration": "1000",
	  "timeOut": "5000",
	  "extendedTimeOut": "1000",
	  "showEasing": "swing",
	  "hideEasing": "linear",
	  "showMethod": "fadeIn",
	  "hideMethod": "fadeOut"
	}
	toastr.success(mess,'Thông báo');
}
function warning(mess) {
	toastr.options.hideMethod = 'slideUp';
	toastr.options.closeMethod = 'fadeOut';
	toastr.options.timeOut = 1000;
	
	toastr.warning(mess,'Thông báo');
}
function error(mess) {
	toastr.options.hideMethod = 'slideUp';
	toastr.options.closeMethod = 'fadeOut';
	toastr.options.timeOut = 5000;
	toastr.error(mess,'Thông báo');
}