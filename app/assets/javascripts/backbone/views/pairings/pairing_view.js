PairingView = Backbone.View.extend({
  template: JST['pairings/pairing'],
  template1: JST['pairings/team_pairing'],
  tagName: 'tr',
  
  events: {
    'submit form': 'update_pairing',
    'change input': 'changed',
  },
  
  initialize: function(){
    var that = this
    _.bindAll(this, "render");
    //this.model.bind('change:player1_id change:player2_id', that.render, this);
    this.model.bind('change', that.render, this);
  },

  render: function(){
    var that = this;
    if (gon.for_teams) {
      this.$el.html(this.template1(this.model.toJSON()));
    } else {
      this.$el.html(this.template(this.model.toJSON()));
    }
    
    if (this.model.get('player1_match_points') || this.model.get('player2_match_points') 
        || this.model.get('pausing') || this.model.get('team1_match_points') 
        || this.model.get('team2_match_points')){
      this.$el.addClass('completed');
    }
    if (this.model.get('pausing')){
      this.$el.addClass('pausing')
    }
    
    if (!this.$el.hasClass('completed') || this.$el.hasClass('pausing') ){
      this.$el.find('.draggable').draggable({ 
          axis: 'y', 
          containment: '#round' + this.model.get('round'),
          helper: function( event ){
            return $( "<div class='ui-widget-header player'>Przeciągnij aby zamienić z " + $(this).text() + "</div>" );
          }, 
      });
      this.$el.find('.draggable').droppable({ 
          drop: function( event, ui ){
            that.model.collection.swapPairings(ui.draggable, $(this));
            ui.draggable.detach();
          },
          hoverClass: "draggable-hover",
      });
    }
    return this
  },

  update_pairing: function(event){
    var id = this.model.id
    var that = this
    event.preventDefault();
    this.model.save(null,{
      success: function(model, results){ 
        $('#modal_' + id).modal('hide'); 
        that.$el.addClass('completed');
        Dmp40k.resultsList.fetch({reset: true});
        Dmp40k.tournament.fetch({reset: true});
      },
      error: function(model, results){
        $('#modal_' + id).find('.errors').text(JSON.parse(results.responseText)['msg']);
      }
    });
  },

  changed: function(evt) {
     var id = this.model.id
     var changed = evt.currentTarget;
     var value = $("#modal_" + id + " #"+changed.id).val();
     var obj = "{\""+changed.id +"\":\""+value+"\"}";
     var objInst = JSON.parse(obj);
     this.model.set(objInst, {silent: true});   
     if (!gon.for_teams){
       this.update_match_points(value, changed.id)
     }
  },

  update_match_points: function(val, field_id){
    var winner_points
    var modal = "#modal_" + this.model.id
    var match_field1 =  $(modal + ' #player1_match_points')
    var match_field2 =  $(modal + ' #player2_match_points')
    points1 = parseInt(this.model.get('player1_game_points')) || 0
    points2 = parseInt(this.model.get('player2_game_points')) || 0
    points = [points1, points2]
    var diff = Math.abs(points1 - points2)
    var won = _.indexOf(points,_.max(points)) + 1
    if( diff >= 10 ){
      winner_points = 20
    } else {
      winner_points = 10 + diff
    }
    if( won == 1 ) {
      match_field1.val(winner_points)
      match_field2.val(20 -winner_points)
    } else {
      match_field2.val(winner_points)
      match_field1.val(20 -winner_points)
    }
  }
});

