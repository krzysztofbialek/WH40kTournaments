PairingView = Backbone.View.extend({
  template: JST['pairings/pairing'],
  tagName: 'tr',
  
  events: {
  },
  
  initialize: function(){
  },

  render: function(){
    this.$el.attr('id', this.model.id).html(this.template(this.model.toJSON()));
    return this
  },

});

