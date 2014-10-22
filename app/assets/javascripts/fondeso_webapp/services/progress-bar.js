'use strict';

angular.module('questionaryApp')
  .service('ProgressBar', function(){
    return {
      progress: '0%',
      setProgress: function( current, total ){
        var percentage = ( current / total ) * 100;

        if (percentage > 100){
          this.progress = '100%';
        } else if (percentage < 0){
          this.progress = '0%';
        } else {
          this.progress = percentage + '%';
        }

        return this.progress;
      }
    };
  });
