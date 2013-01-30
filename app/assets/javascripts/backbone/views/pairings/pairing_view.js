PairingView = Backbone.View.extend({
  template: JST['pairings/pairing'],
  tagName: 'tr',
  
  events: {
  },
  
  initialize: function(){
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this
  },

});

