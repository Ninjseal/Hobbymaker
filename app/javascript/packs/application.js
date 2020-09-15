// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'bootstrap'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("trix")
require("@rails/actiontext")
require("chartkick")
require("chart.js")
require("select2/dist/css/select2")
require("select2-bootstrap-theme/dist/select2-bootstrap")

import '../trix-editor-overrides'
import Select2 from "select2";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import App from '../components/app.vue'

Vue.use(TurbolinksAdapter)

Vue.component('app', App)

Vue.component('blog-post', {
  props: ['title'],
  template: '<h3>{{ title }}</h3>'
})

var default_event_thumbnail_src;
var default_post_thumbnail_src;

document.addEventListener('turbolinks:load', () => {
  $("body").tooltip({ selector: '[data-toggle="tooltip"]' });
  $("[data-form-prepend]").click(form_prepend_new_record);
  $(".btn-like-event-show .icon-heart, .btn-like-event .icon-heart").click(favorite_event_toggle);
  $(".btn-like-post-show .icon-heart, .btn-like-post .icon-heart").click(favorite_post_toggle);
  $(".btn-follow").click(follow_user);
  $(".btn-unfollow").click(unfollow_user);
  $(".btn-withdraw").click(withdraw_event);
  $(".btn-participate").click(join_event);
  $(".btn-subscribe").click(interest_subscribe);
  $(".btn-unsubscribe").click(interest_unsubscribe);
  // New Event
  $("#event_interest_ids").select2({ theme: "bootstrap", placeholder: "Select Interests", allowClear: true });
  $("#event_organizer_ids").select2({ theme: "bootstrap", placeholder: "Select Organizers", allowClear: true });
  $("#event_kind").change(changed_event_kind);
  $("#event_country_id").change(event_fetch_regions);
  $("#event_thumbnail").change(selected_event_thumbnail);
  $("#event-thumbnail-reset").click(clear_event_thumbnail);
  default_event_thumbnail_src = $('#event-thumbnail-preview').attr('src');
  // New Post
  $("#post_interest_ids").select2({ theme: "bootstrap", placeholder: "Select Interests", allowClear: true });
  $("#post_thumbnail").change(selected_post_thumbnail);
  $("#post-thumbnail-reset").click(clear_post_thumbnail);
  default_post_thumbnail_src = $('#post-thumbnail-preview').attr('src');
  // Show Poll
  setTimeout(display_progress, 100); // Wait .1 s before showing progress
  $("input:checkbox[id^='poll_option_ids_']").click(toggle_required);
  $(".poll-vote-form").not(".is-multi").find("input:checkbox[id^='poll_option_ids_']").click(restrict_check);
  // Show Interest

});

function restrict_check() {
  if ($(this).is(':checked'))
    $("input:checkbox[id^='poll_option_ids_']").not(this).prop('checked', false);
}

function toggle_required() {
  if (!($("input:checkbox[id^='poll_option_ids_']").is(':checked')))
    $("input:checkbox[id^='poll_option_ids_']").prop('required', true);
  else if ($(this).is(':required'))
    $("input:checkbox[id^='poll_option_ids_']").prop('required', false);
}

function display_progress() {
  $(".progress-bar[data-result-percent]").each(function() {
    var percentage_value = $(this).attr("data-result-percent");
    $(this).width(`${percentage_value}%`);
  });
}

function remove_poll_option() {
  $(this).parent().parent().remove();
}

function preview_event_thumbnail() {
  $('#event-thumbnail-preview').attr('src', this.result);
}

function preview_post_thumbnail() {
  $('#post-thumbnail-preview').attr('src', this.result);
}

function readURL(input, callback) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = callback;
    reader.readAsDataURL(input.files[0]); // convert to base64 string
  }
}

function clear_post_thumbnail() {
  $(this).attr('disabled', true);
  $(this).tooltip('hide');
  $('#post_thumbnail').val('');
  $('#post_thumbnail').siblings('.custom-file-label').removeClass('selected').html('Event Thumbnail');
  $('#post-thumbnail-preview').attr('src', default_post_thumbnail_src);
}

function selected_post_thumbnail() {
  var fileName = $(this).val().split("\\").pop();
  if (fileName === "") return;
  $(this).siblings('.custom-file-label').addClass('selected').html(fileName);
  readURL(this, preview_post_thumbnail);
  $('#post-thumbnail-reset').attr('disabled', false);
}

function clear_event_thumbnail() {
  $(this).attr('disabled', true);
  $(this).tooltip('hide');
  $('#event_thumbnail').val('');
  $('#event_thumbnail').siblings('.custom-file-label').removeClass('selected').html('Event Thumbnail');
  $('#event-thumbnail-preview').attr('src', default_event_thumbnail_src);
}

function selected_event_thumbnail() {
  var fileName = $(this).val().split("\\").pop();
  if (fileName === "") return;
  $(this).siblings('.custom-file-label').addClass('selected').html(fileName);
  readURL(this, preview_event_thumbnail);
  $('#event-thumbnail-reset').attr('disabled', false);
}

function event_fetch_regions() {
  if ($(this).val() === "") {
    $("#event_region_id").empty().append('<option value>Select Region</option>');
    $(`#event_city_id`).empty().append('<option value>Select City</option>');
  } else {
    var id = $(this).val();
    $.post({ url: `/regions/${id}`, data: { resource: "event" },
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(data, status, xhr) {
        $(`#event_region_id`).replaceWith(data);
        $("#event_region_id").change(event_fetch_cities);
        $(`#event_city_id`).empty().append('<option value>Select City</option>');
      }
    });
  }
}

function event_fetch_cities() {
  if ($(this).val() === "") {
    $(`#event_city_id`).empty().append('<option value>Select City</option>');
  } else {
    var id = $(this).val();
    $.post({ url: `/cities/${id}`, data: { resource: "event" },
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(data, status, xhr) {
        $(`#event_city_id`).replaceWith(data);
      }
    });
  }
}

function changed_event_kind() {
  if ($(this).val() == "online")
    $(".field.venue").addClass("hide");
  else
    $(".field.venue").removeClass("hide");
}

function favorite_event_toggle() {
  var id = parseInt($(this).attr("data-id"));
  $.post({ url: `/events/${id}/add_to_favorites`,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
  });
  $(this).tooltip("disable");
  if ($(this).hasClass("far")) { // Favorite
    $(this).addClass("fas");
    $(this).removeClass("far");
    $(this).attr("title", "Unfavorite event");
    $(this).attr("data-original-title", "Unfavorite event");
  } else if ($(this).hasClass("fas")) { // Unfavorite
    $(this).addClass("far");
    $(this).removeClass("fas");
    $(this).attr("title", "Favorite event");
    $(this).attr("data-original-title", "Favorite event");
  }
  $(this).toggleClass("favorited");
  $(this).tooltip("enable");
  $(this).tooltip('hide');
}

function favorite_post_toggle() {
  var id = parseInt($(this).attr("data-id"));
  $.post({ url: `/posts/${id}/add_to_favorites`,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
  });
  $(this).tooltip("disable");
  if ($(this).hasClass("far")) { // Favorite
    $(this).addClass("fas");
    $(this).removeClass("far");
    $(this).attr("title", "Unfavorite post");
    $(this).attr("data-original-title", "Unfavorite post");
  } else if ($(this).hasClass("fas")) { // Unfavorite
    $(this).addClass("far");
    $(this).removeClass("fas");
    $(this).attr("title", "Favorite post");
    $(this).attr("data-original-title", "Favorite post");
  }
  $(this).toggleClass("favorited");
  $(this).tooltip("enable");
  $(this).tooltip('hide');
}

function follow_user() {
  var id = parseInt($(this).attr("data-id"));
  $.post({ url: `/follow_user/${id}`,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(data, status, xhr) {
      var id = $(data).attr("data-id");
      $(`button.btn-follow[data-id='${id}']`).replaceWith(data);
      $(`button.btn-unfollow[data-id='${id}']`).click(unfollow_user);
    }
  });
}

function unfollow_user() {
  var id = parseInt($(this).attr("data-id"));
  $.post({ url: `/unfollow_user/${id}`,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(data, status, xhr) {
      var id = $(data).attr("data-id");
      $(`button.btn-unfollow[data-id='${id}']`).replaceWith(data);
      $(`button.btn-follow[data-id='${id}']`).click(follow_user);
    }
  });
}

function join_event() {
  var id = parseInt($(this).attr("data-id"));
  $.post({ url: `/events/${id}/join`,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(data, status, xhr) {
      var id = $(data).attr("data-id");
      $(`button.btn-participate[data-id='${id}']`).replaceWith(data);
      $(`button.btn-withdraw[data-id='${id}']`).click(withdraw_event);
    }
  });
}

function withdraw_event() {
  var id = parseInt($(this).attr("data-id"));
  $.post({ url: `/events/${id}/withdraw`,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(data, status, xhr) {
      var id = $(data).attr("data-id");
      $(`button.btn-withdraw[data-id='${id}']`).replaceWith(data);
      $(`button.btn-participate[data-id='${id}']`).click(join_event);
    }
  });
}

function interest_subscribe() {
  var id = parseInt($(this).attr("data-id"));
  $.post({ url: `/interests/${id}/subscribe`,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(data, status, xhr) {
      var id = $(data).attr("data-id");
      $(`button.btn-subscribe[data-id='${id}']`).replaceWith(data);
      $(`button.btn-unsubscribe[data-id='${id}']`).click(interest_unsubscribe);
    }
  });
}

function interest_unsubscribe() {
  var id = parseInt($(this).attr("data-id"));
  $.post({ url: `/interests/${id}/unsubscribe`,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(data, status, xhr) {
      var id = $(data).attr("data-id");
      $(`button.btn-unsubscribe[data-id='${id}']`).replaceWith(data);
      $(`button.btn-subscribe[data-id='${id}']`).click(interest_subscribe);
    }
  });
}

function form_prepend_new_record() {
  var obj = $($(this).attr("data-form-prepend"));
  obj.find("input, select, textarea").each(function() {
    var time = new Date().getTime();
    $(this).attr("name", function() {
      return $(this)
        .attr("name")
        .replace("new_record", time);
    });
    $(this).attr("id", function() {
      return $(this)
        .attr("id")
        .replace("new_record", time);
    });
  });
  obj.insertBefore(this);
  obj.find(".remove-poll-option").click(remove_poll_option);
  return false;
}
