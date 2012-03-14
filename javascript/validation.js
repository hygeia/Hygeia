$(document).ready(function () {

  $("#update_profile_form").validate({
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
      user_weight: { required:true, number:true },
      hip1: { required:true, number:true },
      hip2: { required:true, number:true },
      hip3: { required:true, number:true },
      waist1: { required:true, number:true },
      waist2: { required:true, number:true },
      waist3: { required:true, number:true },
      ft: { required:true, number:true },
      inches: { required:true, number:true },
      wrist: { required:true, number:true }
   }
  });

  $("#signupform").validate({

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
        username: { required: true, rangelength: [2, 20] },
        user_password: { required: true, rangelength: [6, 16], number: false }, 
        reenter_password: { required: true, equalTo: "#user_password" }, 
        user_email: { required: true, email: true },
        reenter_email: { required: true, email: true, equalTo: "#user_email" },
        user_weight: { required:true, number:true },
        user_height_ft: { required:true, number:true },
        user_height_in: { required:true, number:true },
        user_sex: { required:true }
      },
      messages: {
          user_password: {
              required: 'You must have a password between 6 and 16 characters that contains a digit.',
              rangelength: 'Your password must be between 6 and 16 characters long',
              number: 'Your password must contain a digit'
          },
          reenter_password: 'Passwords must match',
          email: 'Please enter a valid email address',
          reenter_email: 'Emails must match'
      }   
  });
  
  $("#add_meal_form").validate({

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
      name:{ required:true },
      daydropdown:{ required:true },
      monthdropdown:{ required:true },
      yeardropdown:{ required:true },
      timedropdown:{ required:true },
      timedropdown:{ required:true },
      mealType:{ required:true }
    }
  });
});
