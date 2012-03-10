$(document).ready(function(){
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
        user_password: { required: true, rangelength: [6, 16], number: true }, 
        reenter_password: { required: true, equalTo: "#user_password" }, 
        user_email: { required: true, email: true },
        reenter_email: { required: true, email: true, equalTo: "#user_email" },
        user_sex: { required: true }
      },
      messages: {
          password: {
              required: 'You must have a password',
              rangelength: 'Your password must be between 6 and 16 characters long',
              number: 'Your password must contain a number'
          },
          reenter_password: 'Passwords must match',
          email: 'Please enter a valid email address',
          reenter_email: 'Emails must match'
      }   
  });
});
