//
//  DDSendCommunityController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSendCommunityController.h"
#import "DDSelectImageCell.h"
#import "DNImagePickerController.h"
#import "DNAsset.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>


static NSString * const imageCell = @"imageCell";
@interface DDSendCommunityController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,DNImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@end

@implementation DDSendCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"发布状态";
    _imageArray = [NSMutableArray arrayWithCapacity:0];
    [_imageArray addObject:[UIImage imageNamed:@"community_add"]];
    [_collectionview registerNib:[UINib nibWithNibName:@"DDSelectImageCell" bundle:nil] forCellWithReuseIdentifier:imageCell];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isValidString]) {
        _valueLabel.hidden = YES;
    }
    else
    {
        _valueLabel.hidden = NO;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDSelectImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCell forIndexPath:indexPath];
    cell.imageView.image = _imageArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==_imageArray.count-1) {
        if (_imageArray.count>=4) {
            [self showErrorHUD:@"最多只能选择3张照片"];
            return;
        }
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
        [actionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        [self takingPhoto];
    }
    if (buttonIndex == 1) {
        [self showSelectPickerController];
    }
}

- (void)takingPhoto{
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
    imagePickerController.view.frame = self.view.bounds;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
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
    UIImage *messageImage = [[image scaledToSize:CGSizeMake(720, 720 * 9.0 / 16.0)] fixOrientation];
    [_imageArray insertObject:image atIndex:0];
    messageImage = nil;
    @WeakObj(self);
    [self dismissViewControllerAnimated:YES completion:^{
        [selfWeak.collectionview reloadData];
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

- (void)showSelectPickerController{
    DNImagePickerController *imagePicker = [[DNImagePickerController alloc] init];
    imagePicker.imagePickerDelegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - DNImagePickerControllerDelegate

- (void)dnImagePickerController:(DNImagePickerController *)imagePickerController sendImages:(NSArray *)imageAssets isFullImage:(BOOL)fullImage
{
    @WeakObj(self);
    for (DNAsset *asset in imageAssets) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                @try {
                    @synchronized (asset) {
                        ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
                        [assetslibrary assetForURL:asset.url
                                       resultBlock:^(ALAsset *asset){
                                           ALAssetRepresentation *rep = [asset defaultRepresentation];
                                           CGImageRef iref = [rep fullScreenImage];
                                           if (iref) {
                                               [selfWeak.imageArray insertObject:[[UIImage alloc] initWithCGImage:iref] atIndex:0];
                                           }
                                           
                                       }
                                      failureBlock:^(NSError *error) {
                                          
                                          
                                          
                                      }];
                    }
                } @catch (NSException *e) {
                    
                }
            }
        });
        
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [selfWeak.collectionview reloadData];
    }];
}
- (void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)publishDynamic:(id)sender {
    if (![_contentTextView.text isValidString]) {
        [self showErrorHUD:@"请输入动态"];
        return;
    }
    @WeakObj(self);
    [self showLoadHUD:@"发布中..."];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (int i =0;i<_imageArray.count;i++) {
        UIImage *img = _imageArray[i];
        NSString *key = [NSString stringWithFormat:@"pic%d",i+1];
        [dic setValue:UIImageJPEGRepresentation(img, 0.5) forKey:key];
    }
    [dic setValue:@"1" forKey:@"type"];
    [dic setValue:_contentTextView.text forKey:@"message"];
    [dic setValue:@"" forKey:@"groupid"];
    [self Network_Post:@"do_forumpost"
                   tag:Do_forumpost_Tag
                 param:dic success:^(id result) {
                     [selfWeak hideHUD];
                     if ([result[@"code"]integerValue]==200) {
                         [selfWeak showSuccessHUD:@"发布成功"];
                         [selfWeak.navigationController popViewControllerAnimated:YES];
                         
                     }else
                     {
                         [selfWeak showErrorHUD:result[@"message"]];
                     }
                 } failure:^(NSError *error) {
                     [selfWeak hideHUD];
                     [selfWeak showErrorHUD:@"网络异常"];
                 }];
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
