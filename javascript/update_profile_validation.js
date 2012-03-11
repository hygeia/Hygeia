$(document).ready(function () {
  $('#form').validate({
    /* Prevent double submissions */
    submitHandler: function(form){
      if(!this.wasSent){
        this.wasSent = true;
        $(':submit', form).val('Please wait...')
                          .attr('disabled', 'disabled')
                          .addClass('disabled');
        form.submit();
      } else {
        return false;
      }
    },
    rules: {
    }
  });
});
