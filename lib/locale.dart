import "package:get/get.dart";

///
/// The texts used in the app is stored in locale file.
///
class AppLocale extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          'text001':'Unknown error occurred.Please try again',
          'text002':'John Doe',
          'text003':'Please enter your name',
          'text004':'Next',
          'text004.error':'*Wrong mobile number Entered. ',
          'text005':'What’s Your Full Name?',
          'text006':'Create new task',
          'text007':'Title',
          'text008':'Date',
          'text009':'Start time',
          'text010':'End time',
          'text011':'Description',
          'text012':'Create task',
          'text013':'Full name',
          'text014':'Update',
          'text015':'Task added successfully!',
          'text016':'Task deleted successfully!',
          'text017':'Completed',
          'text018':'Mark completed',
          'text019':'Today',
          'text020':'Upcoming',
          'text021':'Completed task',
          'text022':'Mark completed',
          'text023':'Are you sure?',
          'text024':'You need to sign out',
          'text025':'No any tasks found!',
          'text026':'Make something awesome',
          'text027':'Add product categories',
          'text028':'Due date',


        }
      };
}
