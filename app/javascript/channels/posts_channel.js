import consumer from "./consumer"

document.addEventListener("turbo:load", function() {
  if(document.querySelector('[post-channel-id]')) {
    var postsChannelId = document.querySelector('[post-channel-id]').getAttribute('post-channel-id');
    consumer.subscriptions.create({ channel: "PostsChannel", id: postsChannelId }, {
      connected() {
        console.log("Connected to the channel:", this);
      },

      disconnected() {
        console.log("Disconnected");
      },

      received(data) {
        if(data['comment_create']) {
          var parser = new DOMParser();
          var doc = parser.parseFromString(data['comment_create'], 'text/html');
          currentUserId = document.querySelector('[current-user-id]').getAttribute('current-user-id');
          document.querySelector("#comments").appendChild(doc.body);
          if(currentUserId == "") {
            document.querySelectorAll('[data-reactions]').forEach(e => e.remove());
          }
        } else if(data['post_update']) {
          document.querySelector('[post-title]').innerHTML = data['post_update'][0]
          document.querySelector('[post-description]').innerHTML = data['post_update'][1]
        } else if(data['post_destroy']) {
          if(parseInt(postsChannelId) == data['post_destroy']) {
            window.location.href = window.location.origin + '/posts'
          }
        } else if(data['comment_update']) {
          document.querySelector('[post-channel-comment="'+data['comment_update'][0]+'"] [comment-description]').innerHTML = data['comment_update'][1]
        } else if(data['comment_destroy']) {
          document.querySelector('[post-channel-comment="'+data['comment_destroy']+'"]').remove()
        } else if(data['removed_reaction']) {
          var kind = data['removed_reaction'][1];
          result = document.querySelector('[post-channel-comment="'+data['removed_reaction'][0]+'"] [data-reaction-'+kind+']')
          result.innerHTML = data['removed_reaction'][2];;
        } else if(data['added_reaction']) {
          var kind = data['added_reaction'][1];
          result = document.querySelector('[post-channel-comment="'+data['added_reaction'][0]+'"] [data-reaction-'+kind+']');
          result.innerHTML = data['added_reaction'][2];
        }
      }
    });
  }
});