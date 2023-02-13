import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/utils/app_logger.dart';

const channelKey = 'toDoChannelKey';
const channelKeyGroupName = 'toDoChannelGroup';

class NotificationController extends GetxController {
  @override
  void onInit() {
    initLocalNotification();
    super.onInit();
  }

  Future requestLocalNotificationPermission() async {
    await requestUserPermissions(channelKey: channelKey, permissionList: [
      NotificationPermission.Alert,
      NotificationPermission.Sound
    ]);
  }

  initLocalNotification() {
    //inti awesome notifications
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: channelKeyGroupName,
              channelKey: channelKey,
              channelName: 'ToDo app channel',
              criticalAlerts: true,
              importance: NotificationImportance.Max,
              playSound: true,
              channelDescription: 'Notification channel for ToDo app'),
        ],
        debug: true);
    requestLocalNotificationPermission();
  }

  Future createScheduledAlert(
      {required int vid,
      required String title,
      required String description,
      required DateTime date,
      required DateTime startTime}) async {
    ///create scheduled alert for tasks. Scheduled is added to task's start date with time
    ///
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    final dueDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        startTime.hour,
        startTime.minute,
        startTime.second,
        startTime.millisecond,
        startTime.microsecond);
    final secondInterval = dueDateTime.difference(DateTime.now()).inSeconds;
    AppLogger().warning(secondInterval);
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: vid,
            channelKey: channelKey,
            title: 'ToDo : $title',
            body: description,
            wakeUpScreen: true,
            roundedLargeIcon: true,
            category: NotificationCategory.Alarm,
            actionType: ActionType.KeepOnTop),
        schedule: NotificationInterval(
            interval: secondInterval,
            timeZone: localTimeZone,
            preciseAlarm: true));
  }

  Future cancelScheduledAlert(int vid) async {
    await AwesomeNotifications().cancelSchedule(vid);
  }

  static Future<List<NotificationPermission>> requestUserPermissions(
      {
      // if you only intends to request the permissions until app level, set the channelKey value to null
      required String? channelKey,
      required List<NotificationPermission> permissionList}) async {
    // Check which of the permissions you need are allowed at this time
    List<NotificationPermission> permissionsAllowed =
        await AwesomeNotifications().checkPermissionList(
            channelKey: channelKey, permissions: permissionList);

    // If all permissions are allowed, there is nothing to do
    if (permissionsAllowed.length == permissionList.length) {
      return permissionsAllowed;
    }

    // Refresh the permission list with only the disallowed permissions
    List<NotificationPermission> permissionsNeeded =
        permissionList.toSet().difference(permissionsAllowed.toSet()).toList();

    // Check if some of the permissions needed request user's intervention to be enabled
    List<NotificationPermission> lockedPermissions =
        await AwesomeNotifications().shouldShowRationaleToRequest(
            channelKey: channelKey, permissions: permissionsNeeded);

    // If there is no permissions depending on user's intervention, so request it directly
    if (lockedPermissions.isEmpty) {
      // Request the permission through native resources.
      await AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: channelKey, permissions: permissionsNeeded);

      // After the user come back, check if the permissions has successfully enabled
      permissionsAllowed = await AwesomeNotifications().checkPermissionList(
          channelKey: channelKey, permissions: permissionsNeeded);
    } else {
      // If you need to show a rationale to educate the user to conceived the permission, show it
      await Get.dialog(AlertDialog(
        backgroundColor: const Color(0xfffbfbfb),
        title: const Text(
          'ToDo needs your permission',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'To proceed, you need to enable the permissions above${channelKey?.isEmpty ?? true ? '' : ' on channel $channelKey'}:',
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              lockedPermissions
                  .join(', ')
                  .replaceAll('NotificationPermission.', ''),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Deny',
                style: TextStyle(color: Colors.red, fontSize: 18),
              )),
          TextButton(
            onPressed: () async {
              // Request the permission through native resources. Only one page redirection is done at this point.
              await AwesomeNotifications().requestPermissionToSendNotifications(
                  channelKey: channelKey, permissions: lockedPermissions);

              // After the user come back, check if the permissions has successfully enabled
              permissionsAllowed = await AwesomeNotifications()
                  .checkPermissionList(
                      channelKey: channelKey, permissions: lockedPermissions);

              Get.back();
            },
            child: const Text(
              'Allow',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ));
    }

    // Return the updated list of allowed permissions
    return permissionsAllowed;
  }
}
