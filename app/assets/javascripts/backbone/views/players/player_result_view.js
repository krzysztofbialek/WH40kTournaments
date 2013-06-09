PlayerResultView = Backbone.View.extend({
  template: JST['players/player_result'],
  tagName: 'tr',
  
  events: {
    'click .player-army button' : 'removePlayer', 
    'submit form' : 'update_player'
  },
  
  initialize: function(){
    _.bindAll(this, "render");
    this.model.bind('change:extra_points change:penalty_points', this.render, this);
  },
  
  render: function(){
    this.$el.attr('id', this.model.id).html(this.template(this.model.toJSON()));
    return this
  },
  
  update_player: function(event){
    event.preventDefault();
    var modal = $("#result_modal_" + this.model.id)
    var extra_points =  modal.find('.extra-points input').val();
    var penalty_points =  modal.find('.penalty-points input').val();
    var that = this
    that.model.save({extra_points: extra_points, penalty_points: penalty_points}, {
      success: function(model, results){ 
        $('#result_modal_' + model.id).modal('hide');
        $('.modal-backdrop').remove(); 
      },
      error: function(model, results){
        $('#result_modal_' + model.id).find('.errors').text(JSON.parse(results.responseText)['msg']);
      }
    });
  },
});

