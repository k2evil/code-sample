import 'package:digisina/features/profile/data/model/profile_model.dart';

enum Privilege {
  manager,
  ceo,
  employee,
  family,
  customer,
}

class UserProfile {
  final String id;
  final int personnelCode;
  final String firstName;
  final String lastName;
  final String nationalCode;
  final String phoneNumber;
  final String position;
  final String? dashboard;
  final String? family;
  final String branch;
  final String avatar;
  final Privilege privilege;

  String get fullName => "$firstName $lastName";

  const UserProfile(
      this.id,
      this.personnelCode,
      this.firstName,
      this.lastName,
      this.nationalCode,
      this.phoneNumber,
      this.position,
      this.dashboard,
      this.family,
      this.branch,
      this.privilege,
      this.avatar);

  UserProfile.fromModel(Profile model)
      : this.id = model.id ?? "",
        this.dashboard = model.dashboard,
        this.personnelCode = model.personnelCode ?? 0,
        this.firstName = model.firstName ?? model.fullName ?? "",
        this.lastName = model.lastName ?? "",
        this.family = model.family,
        this.nationalCode = model.nationalNumber.toString(),
        this.phoneNumber = model.phoneNumber ?? "",
        this.position = model.position ?? "",
        this.branch = model.branch ?? "",
        this.avatar = model.avatar?.large ?? model.avatar?.thumbnail ?? "",
        this.privilege = (model.role?.contains("ceo") ?? false)
            ? Privilege.ceo
            : (model.role?.contains("manager") ?? false)
                ? Privilege.manager
                : (model.role?.contains("employee") ?? false)
                    ? Privilege.employee
                    : (model.role?.contains("family") ?? false)
                        ? Privilege.family
                        : Privilege.customer;

  Profile toProfile() {
    return Profile(
        id,
        personnelCode,
        firstName,
        lastName,
        int.parse(nationalCode),
        phoneNumber,
        position,
        dashboard,
        family,
        privilege == Privilege.ceo
            ? "ceo"
            : privilege == Privilege.manager
                ? "manager"
                : privilege == Privilege.employee
                    ? "employee"
                    : privilege == Privilege.family
                        ? "family"
                        : "customer",
        branch,
        ProfileAvatar(thumbnail: avatar, large: avatar));
  }
}
