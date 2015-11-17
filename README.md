#TDLCommon

These are some common classes created by TDL.

##Installation

```
pod 'TDLCommon', :git => 'https://github.com/krinApc/TDLCommon.git'
```
##TDLActionView
A class that can use action sheet with block, and you don't have to care about the version of iOS.

**samle**

```
[TDLActionView showArgumentActionSheetWithTitle:nil message:nil completion:^(BOOL completed, NSInteger buttonIndex) {
        
        if (buttonIndex == 0) {
        	//do sth
        }
        
    } cancelButton:@"Cancle" buttons:@[@"Camery",@"Picture"]];
```
##TDLAlertView
A class that can use alert view with block, and you don't have to care about the version of iOS.

**samle**

```
[TDLAlertView showPromptAlertWithTitle:nil message:@"Failed" completion:^(BOOL completed) {
	//do sth
}];
```

##TDLFormat
A class has some validation methods

##TDLModelConverter
A class that can converter NSDictionary to model

**samle**

```
SomeModel *model = [TDLModelConverter setValues:dic typeObje:SomeModel];
```

##TDLNetworking
A sample class of how to use AFNetworking.
It is better to create new common class to merge your own project than use this one.

##TDLPlist
A class that can get plist data easier.

##TDLUserDefault
A class that can handler user default easier.

##TDLVersionMonitor
A class is similar to [SRGVersionUpdater](https://github.com/kazu0620/SRGVersionUpdater), but it doesn't use any third party lib.
