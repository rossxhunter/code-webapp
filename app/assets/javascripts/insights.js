// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


if ( $("#code_lesson_chart").length > 0 ) {
    var code_lesson_id =  $("#code_lesson_chart").attr('data-code-lesson-id');
  $.ajax({
    type: 'POST',
    url: '/insights/get-code-lesson-submissions',
    data: {
      code_lesson_id: code_lesson_id
    }
  }).done(function(data) {
    var parsed_data = JSON.parse(data);

    var students = parsed_data.students
    var student_names = [];
    var submission_counts = [];
    var times_in_minutes = [];

    for (var i = 0; i < students.length; i++) {
      student_names.push(students[i].name);
      submission_counts.push(students[i].submissions_count);
      times_in_minutes.push(students[i].time_taken / 60);
    }

    var avg = submission_counts.reduce(function(acc, val) { return acc + val; }) / (submission_counts.length);
    var avg_time = times_in_minutes.reduce(function(acc, val) { return acc + val;}) / (times_in_minutes.length);
    myColours = []
    colours_time = []
    $.each(submission_counts, function (
      index, value) {
        if (value > avg) {
            myColours[index] = "orange";
        }else {
          myColours[index] = "green";
        }
      });

      $.each(times_in_minutes, function (
        index, value) {
          if (value > avg_time) {
              colours_time[index] = "orange";
          }else {
            colours_time[index] = "green";
          }
        });

    var myChart = new Chart(document.getElementById("code_lesson_chart"), {
        type: 'bar',
        data: {
            labels: student_names,
            datasets: [{
                label: '# of Submissions',
                backgroundColor: myColours,
                data: submission_counts,
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });
    var myChartTime = new Chart(document.getElementById("code_lesson_chart_time"), {
        type: 'line',
        data: {
            labels: student_names,
            datasets: [{
                label: 'Time taken in minutes',
                borderColor: "blue",
                borderWidth: 3,
                fill: false,
                data: times_in_minutes,
                pointHoverBackgroundColor: "red",
                pointHoverBorderColor: "red"
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });
  });

}
if ( $("#track_chart").length > 0 ) {
    var track_id =  $("#track_chart").attr('data-track-id');
  $.ajax({
    type: 'POST',
    url: '/insights/get-track-submissions',
    data: {
      track_id: track_id
    }
  }).done(function(data) {
    var parsed_data = JSON.parse(data);

    var code_lessons = parsed_data.code_lessons;
    var submission_counts = parsed_data.submission_counts;
    var code_lesson_names = [];
    var avg_times_in_minutes = parsed_data.avg_times;

    for (var i = 0; i < code_lessons.length; i++) {
      code_lesson_names.push(code_lessons[i].name);
    }

    var avg = submission_counts.reduce(function(acc, val) { return acc + val; }) / (submission_counts.length);

    myColours = []
    $.each(submission_counts, function (
      index, value) {
        if (value > avg) {
            myColours[index] = "orange";
        }else {
          myColours[index] = "green";
        }
      });

    var myChart = new Chart(document.getElementById("track_chart"), {
        type: 'bar',
        data: {
            labels: code_lesson_names,
            datasets: [{
                label: '# of Submissions',
                backgroundColor: myColours,
                data: submission_counts,
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });

    var myChartTime = new Chart(document.getElementById("track_chart_time"), {
        type: 'line',
        data: {
            labels: code_lesson_names,
            datasets: [{
                label: 'Average time taken in minutes',
                borderColor: "blue",
                borderWidth: 3,
                fill: false,
                data: avg_times_in_minutes,
                pointHoverBackgroundColor: "red",
                pointHoverBorderColor: "red"
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });
  });

}

if ( $("#course_chart").length > 0 ) {
    var course_id =  $("#course_chart").attr('data-course-id');
  $.ajax({
    type: 'POST',
    url: '/insights/get-course-submissions',
    data: {
      course_id: course_id
    }
  }).done(function(data) {
    var parsed_data = JSON.parse(data);

    var tracks = parsed_data.tracks;
    var submission_counts = parsed_data.submission_counts;
    var track_names = [];
    var avg_times = parsed_data.avg_times;

    for (var i = 0; i < tracks.length; i++) {
      track_names.push(tracks[i].name);
    }

    var avg = submission_counts.reduce(function(acc, val) { return acc + val; }) / (submission_counts.length);

    myColours = []
    $.each(submission_counts, function (
      index, value) {
        if (value > avg) {
            myColours[index] = "orange";
        }else {
          myColours[index] = "green";
        }
      });

    var myChart = new Chart(document.getElementById("course_chart"), {
        type: 'bar',
        data: {
            labels: track_names,
            datasets: [{
                label: '# of Submissions',
                backgroundColor: myColours,
                data: submission_counts,
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });


    var myChartTime = new Chart(document.getElementById("course_chart_time"), {
        type: 'line',
        data: {
            labels: track_names,
            datasets: [{
                label: 'Average time taken for student to complete tracks',
                data: avg_times,
                borderColor: "blue",
                borderWidth: 3,
                fill: false,
                pointHoverBackgroundColor: "red",
                pointHoverBorderColor: "red"
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });

  });
}

if ( $(".student_submission_graph").length > 0){
  $(".student_submission_graph").each(function(index){
    var graph = $(this);
    var student_id = graph.attr('data-student-id');
    var track_id = graph.attr('data-track-id');
  $.ajax({
    type: 'POST',
    url: '/insights/get-student-submissions',
    data: {
      student_id: student_id,
      track_id: track_id
    }
  }).done(function(data) {
    var parsed_data = JSON.parse(data);
    var code_lessons_name = parsed_data.code_lessons_name
    var submissions = parsed_data.submission_counts
    var myLineChart = new Chart(document.getElementById("student_submissions_line_graph"+track_id), {
        type: 'line',
        data: {
          labels: code_lessons_name,
          datasets: [{
              label: '# of Submissions',
              data: submissions,
              backgroundColor: "rgb(96, 209, 167,0.5)",
              borderWidth: 1
          }]
        },options: {
          elements: {
              line: {
                tension: 0,
              }
          }
      }
      });
    });
  })

}


if ( $(".student_time_graph").length > 0 ) {
  $(".student_time_graph").each(function(index){
    var graph = $(this);
    var student_id =  graph.attr('data-student-id');
    var track_id = graph.attr('data-track-id');
    $.ajax({
      type: 'POST',
      url: '/insights/get-student-time-spent',
      data: {
        student_id: student_id,
        track_id: track_id
      }
    }).done(function(data) {
      var parsed_data = JSON.parse(data);
      var code_lessons_name = parsed_data.code_lessons_name
      var time_spent_lessons = parsed_data.time_spent_lessons
      var myLineChart = new Chart(document.getElementById("student_time_line_graph"+track_id), {
          type: 'line',
          data: {
            labels: code_lessons_name,
            datasets: [{
                label: 'Time Spent On Each Lesson',
                data: time_spent_lessons,
                backgroundColor: "rgb(96, 209, 167,0.5)",
                borderWidth: 1
            }]
          },
          options: {
            elements: {
              line: {
                  tension: 0
              }
            }
          }
        });
    });
  });
}
