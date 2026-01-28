CKEDITOR.editorConfig = function (config) {
	config.language = 'vi';
	config.height = 400;
	config.filebrowserBrowseUrl = '/Fruitshop_Web/assets/ckfinder/ckfinder/ckfinder.html';
	config.filebrowserImageBrowseUrl = '/Fruitshop_Web/assets/ckfinder/ckfinder/ckfinder.html?type=Images';
	config.filebrowserUploadUrl = '/Fruitshop_Web/ckfinder/connector?command=QuickUpload&type=Files';
	config.filebrowserImageUploadUrl = '/Fruitshop_Web/ckfinder/connector?command=QuickUpload&type=Images';
	config.removeDialogTabs = 'link:upload;image:Upload';
	config.toolbar = [
		{ name: 'clipboard', items: ['Undo', 'Redo'] },
		{ name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat'] },
		{ name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'] },
		{ name: 'links', items: ['Link', 'Unlink'] },
		{ name: 'insert', items: ['Image', 'Table', 'HorizontalRule', 'SpecialChar'] },
		{ name: 'styles', items: ['Format', 'Font', 'FontSize'] },
		{ name: 'colors', items: ['TextColor', 'BGColor'] },
		{ name: 'tools', items: ['Maximize', 'Source'] }
	];
};
