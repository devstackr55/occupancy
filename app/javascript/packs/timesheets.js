console.log("========should call=========", moment().fotmat());
//
// function loadForm(new_path, list_path){
//   document.addEventListener('DOMContentLoaded', function() {
//     var calendarEl = document.getElementById('calendar');
//     var calendar = new FullCalendar.Calendar(calendarEl, {
//
//       initialView: 'dayGridMonth',
//       displayEventTime : false,
//       headerToolbar: {
//         left: 'prev,next today',
//         center: 'title',
//         right: 'dayGridMonth,timeGridWeek,listWeek'
//       },
//       dateClick: function(info) {
//       },
//       events: list_path,
//       // eventColor: '#378006',
//       // eventTextColor: "Yellow",
//       selectable: true,
//       select: function(start, end) {
//         console.log("===============ddd==================0")
//         console.log(start.startStr)
//         $.ajax({
//           url: new_path,
//           method: "GET",
//           async: true,
//           dataType: "script",
//           success: function(result){
//             // $("#employee_timesheet_form").modal("show");
//             $("#timesheet_on_date").val(start.startStr);
//             let formatTime = moment(start.startStr).format("MMM Do YY");
//             $("#timesheet-form-title").text(`Time log for ${formatTime}`);
//           }
//         })
//       }
//     });
//     calendar.render();
//   });
// }
