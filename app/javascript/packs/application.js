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

$(document).ready(function() {
  $("body").tooltip({
    selector: '[data-toggle="tooltip"]'
  });
});

document.addEventListener('turbolinks:load', () => {
  $(".icon-heart").click(favorite_event_toggle);
  $(".btn-follow").click(follow_user);
  $(".btn-unfollow").click(unfollow_user);
  $(".btn-withdraw").click(withdraw_event);
  $(".btn-participate").click(join_event);
});

function favorite_event_toggle() {
  var id = parseInt($(this).attr("data-id"));
  $.post({ url: `/events/${id}/add_to_favorites`,
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
  });
  if ($(this).hasClass("far")) {
    $(this).addClass("fas");
    $(this).removeClass("far");
  } else if ($(this).hasClass("fas")) {
    $(this).addClass("far");
    $(this).removeClass("fas");
  }
  $(this).toggleClass("favorited");
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
