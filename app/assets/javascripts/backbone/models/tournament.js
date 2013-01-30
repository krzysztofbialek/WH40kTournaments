Tournament = Backbone.Model.extend({

  urlRoot: '/tournaments',

  generatePairings: function(){
    $.post('/tournaments/' + Dmp40k.getTournamentId() + '/generate_pairings', function(data){
      alert(data.inspect);
    });
  },

});
