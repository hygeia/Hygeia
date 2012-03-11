$(document).ready(function () {
  $('update_profile_form').validate({
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
      sex_field: { required:true },
      activity: { required:true },
      user_weight: { required:true, digits:true },
      hip1: { required:true, digits:true },
      hip2: { required:true, digits:true },
      hip3: { required:true, digits:true },
      waist1: { required:true, digits:true },
      waist2: { required:true, digits:true },
      waist3: { required:true, digits:true },
      ft: { required:true, digits:true },
      in: { required:true, digits:true },
      wrist: { required:true, digits:true }
   }
  });
});
