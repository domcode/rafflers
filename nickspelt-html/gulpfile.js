var gulp = require('gulp'),
    sass = require('gulp-sass'),
    autoprefixer = require('gulp-autoprefixer'),
    preprocess = require('gulp-preprocess'),
    minimist = require('minimist');


var acceptedOptions = {
  string: 'winner',
  default: { winner: 'test subject' }
};

var options = minimist(process.argv.slice(2), acceptedOptions);

gulp.task('css', function () {
    return gulp.src('scss/style.scss')
    .pipe(sass({errLogToConsole: true}))
    .pipe(preprocess({context: {WINNER: options.winner}}))
    .pipe(autoprefixer('last 4 version'))
    .pipe(gulp.dest('./'));
});

gulp.task('default', ['css'], function () {
    gulp.watch("scss/*.scss", ['css']);
});

