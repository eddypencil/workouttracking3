class Regex{

    static const String email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    static const String password = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    static const String name = r'^[a-zA-Z]{3,}$';
    static const String phone = r'^[0-9]{10}$';
    static const String otp = r'^[0-9]{6}$';
    static const String pincode = r'^[0-9]{6}$';
    static const String aadhar = r'^[0-9]{12}$';
    static const String pan = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    static const String ifsc = r'^[A-Z]{4}0[A-Z0-9]{6}$';
    static const String account = r'^[0-9]{9,18}$';
    static const String amount = r'^[0-9]{1,}$';
    static const String address = r'^[a-zA-Z0-9\s\,\.\-]{10,}$';
    static const String city = r'^[a-zA-Z]{3,}$';
    static const String state = r'^[a-zA-Z]{3,}$';
    static const String country = r'^[a-zA-Z]{3,}$';
    static const String landmark = r'^[a-zA-Z0-9\s\,\.\-]{10,}$';

}