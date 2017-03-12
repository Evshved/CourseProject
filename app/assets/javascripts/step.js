$(document).ready(() => {
  var myDropzone = '';
  var index = '';
  var image = '';


  let cloudinarySettings = {
    url: "https://api.cloudinary.com/v1_1/dtbx6e5eb/image/upload",
    api_key: "564565819495146",
    upload_preset: "zcxhugnt"
  };


  var myDropzone = new Dropzone(document.getElementById('direct_upload'), {
    uploadMultiple: false,
    acceptedFiles:'.jpg,.png,.jpeg,.gif',
    parallelUploads: 1,
    url: cloudinarySettings.url
  });

  myDropzone.on('sending', (file, xhr, formData) => {
    formData.append('api_key', cloudinarySettings.api_key);
    formData.append('timestamp', Date.now() / 1000 | 0);
    formData.append('upload_preset', cloudinarySettings.upload_preset);
  });

  myDropzone.on('success', (file, response) => {
    sendImage(response);
  });

  myDropzone.on('complete', (file) => {
    myDropzone.removeFile(file);
  });

  function formatString(fullUrl, signature){
    var index = fullUrl.indexOf("image/upload");
    return `${fullUrl.substring(index)}#${signature}`;
  }

  function sendImage(data){
    setImageData(data);
    submitForm(data);
    clearImageData();
  }

  function setImageData(data){
    var image = formatString(data.secure_url, data.signature);
    $('<input/>').attr({ name: 'photo[image]', value: image, type: "hidden"}).appendTo('form');
    $('#photo_bytes').val(data.bytes);
  }

  function submitForm(response){
    $.post($("form").attr("action"), $("form").serialize())
      .done((photo) => createImageElement(response, photo.id));
  }

  function clearImageData(){
    $('input[name="photo[image]"]').remove();
    $(".basic-form").hide("fast");
  }

  $(".btn.btn-primary").on('click',function(){
    window.location.href=window.location.href;
  })

// $(".image-settings").hide().fast;

  $(document).on('click', 'a.delete-btn', function(e){
    if(confirm("You sure?")){
      var id = $(this).attr('data-id');
      $.when(deletePhoto(id))
        .then(removeImageElement(this));
    }
  });

  $('#direct_upload').on('drop',function(e){
    var imgUrl = e.originalEvent.dataTransfer.getData('Text');
    if (imgUrl && !imgUrl.includes("cloudinary.com")) {
      let fd = new FormData();
      fd.append('api_key', cloudinarySettings.api_key);
      fd.append('timestamp', Date.now() / 1000 | 0);
      fd.append('upload_preset', cloudinarySettings.upload_preset);
      fd.append('file', imgUrl);
      sendToCloud(fd, sendImage);
    }
  });

  function sendToCloud(formData, callback){
    $.ajax({
        url : cloudinarySettings.url,
        type: "POST",
        data : formData,
        processData: false,
        contentType: false,
        success: callback
    });
  }

  function removeImageElement(element){
    $(element).parent(".col-lg-3.col-md-4.col-xs-6.photo").fadeOut(1000);
  }

  function deletePhoto(id){
    $.ajax({
      url: `photos/${id}`,
      type: 'DELETE'
    });
  }
});
