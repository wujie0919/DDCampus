//
//  DDSetMineInfoController.m
//  DDCampus
//
//  Created by wu on 16/8/10.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSetMineInfoController.h"
#import "DDSetAvatarCell.h"
#import "DDSetAnthorCell.h"
#import "DDSetValueController.h"

static NSString * const avatarCell = @"avatarCell";
static NSString * const valueCell = @"valueCell";

@interface DDSetMineInfoController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet DDTableView *valueTable;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) UIImage *messageImage;
@end

@implementation DDSetMineInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_valueTable registerNib:[UINib nibWithNibName:@"DDSetAvatarCell" bundle:nil] forCellReuseIdentifier:avatarCell];
    [_valueTable registerNib:[UINib nibWithNibName:@"DDSetAnthorCell" bundle:nil] forCellReuseIdentifier:valueCell];
    [self setBackBarButtonItem];
    self.title = @"资料修改";
    _titleArray = @[@"昵称",@"手机号"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _array = @[appDelegate.userModel.nickname,appDelegate.userModel.mobile];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 90;
    if (indexPath.section == 1) {
        height = 50;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == 1) {
        height = 10;
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if (section  == 1) {
        row = 2;
    }
    return row;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = RGB(234, 233, 220);
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    return  headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DDSetAvatarCell *aCell = [tableView dequeueReusableCellWithIdentifier:avatarCell];
        aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [aCell.headerView getImageWithURL:[NSString stringWithFormat:@"%@%@",PicUrl,appDelegate.userModel.pic] placeholder:nil];
        return aCell;
    }
    else
    {
        DDSetAnthorCell *anCell = [tableView dequeueReusableCellWithIdentifier:valueCell];
        if (indexPath.row == 0) {
            anCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        anCell.title.text = _titleArray[indexPath.row];
        anCell.value.text = _array[indexPath.row];
        return anCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            DDSetValueController *valueController = [[DDSetValueController alloc]initWithNibName:@"DDSetValueController" bundle:nil];
            [self.navigationController pushViewController:valueController animated:YES];
        }
    }else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
        [actionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    if (![NSTools isCameraAvalible]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请在设置中开启相机权限" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alertView show];
        return;
    }
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warnning" message:@"The camera is not supported on this device" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        return;
    }
    
    //拍照
    if (buttonIndex==0) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }
    if (buttonIndex == 1) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePickerController.view.frame = self.view.bounds;
    
    imagePickerController.allowsEditing = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}


#pragma mark - imagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = nil;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        //获取图片
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //保存
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    _messageImage = [[image scaledToSize:CGSizeMake(720, 720 * 9.0 / 16.0)] fixOrientation];
    [self updateAvatar];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)updateAvatar{
    [self showLoadHUD:@"上传中..."];
    @WeakObj(self);
    [self Network_Post:@"do_saveheadpic" tag:Do_saveheadpic_Tag
                 param:@{@"headerimg":UIImageJPEGRepresentation(_messageImage, 0.5)} success:^(id result) {
                     [selfWeak hideHUD];
                     if ([result[@"code"]integerValue]==200) {
                         appDelegate.userModel.pic = result[DataKey];
                         NSMutableDictionary *dic = [[USER_DEFAULT objectForKey:UserInfo] mutableCopy];
                         [dic removeObjectForKey:@"pic"];
                         [dic setValue:result[DataKey] forKey:@"pic"];
                         [NSTools setObject:dic forKey:UserInfo];
                         selfWeak.messageImage = nil;
                         [selfWeak.valueTable reloadData];
                     }
                     else
                     {
                         [selfWeak showErrorHUD:result[@"message"]];
                     }
                     
                 } failure:^(NSError *error) {
                     [selfWeak hideHUD];
                 }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)info
{
    if (!error) {
    }else
    {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
