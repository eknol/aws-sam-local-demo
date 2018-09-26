const gulp = require('gulp');
// const AWS = require('aws-sdk');
const shell = require('gulp-shell');

gulp.task('default', function(done) {
  // place code for your default task here
  console.log("Hooray it works!! ");
  done();
});

gulp.task('show-tables',
    shell.task('aws dynamodb list-tables --endpoint-url http://localhost:8000'
));

gulp.task('create-tables',
    shell.task('aws dynamodb create-table --cli-input-json file://dynamodb/config/tables/table.json --endpoint-url http://localhost:8000'
));
