const gulp = require('gulp');
const shell = require('gulp-shell');

gulp.task('default', function(done) {
  console.log("Hello :)");
  done();
});

gulp.task('show-tables',
    shell.task('aws dynamodb list-tables --endpoint-url http://localhost:8000')
);

gulp.task('create-tables',
    shell.task('aws dynamodb create-table --cli-input-json file://dynamodb/config/tables/table.json --endpoint-url http://localhost:8000')
);

gulp.task('add-data',
    shell.task('aws dynamodb put-item --table-name fruitsTable --item file://dynamodb/config/tables/data.json --return-consumed-capacity TOTAL --endpoint-url http://localhost:8000')
);

gulp.task('get-data',
    shell.task('aws dynamodb get-item --table-name fruitsTable --key file://dynamodb/config/tables/key.json --endpoint-url http://localhost:8000')
);

gulp.task('setup-db', gulp.series('create-tables', 'add-data', function(done) {
    done();
}));
