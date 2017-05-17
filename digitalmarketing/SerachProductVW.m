//
//  SerachProductVW.m
//  digitalmarketing
//
//  Created by Mango SW on 17/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "SerachProductVW.h"
#import "Product_Cell.h"
#import "digitalMarketing.pch"

@interface SerachProductVW ()

@end

@implementation SerachProductVW
@synthesize SearchBR,SearchBackView,ProductTable;
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    SearchBR.layer.borderWidth = 1;
    SearchBR.layer.borderColor = [UIColor whiteColor].CGColor;
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    
    [SearchBackView.layer setCornerRadius:3.0f];
    SearchBackView.layer.borderWidth = 1.0f;
    SearchBackView.layer.borderColor = [UIColor clearColor].CGColor;
    [SearchBackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [SearchBackView.layer setShadowOpacity:0.8];
    [SearchBackView.layer setShadowRadius:3.0];
    [SearchBackView.layer setShadowOffset:CGSizeMake(2,2)];
    
    UINib *nib = [UINib nibWithNibName:@"Product_Cell" bundle:nil];
    ProductTable.estimatedRowHeight = 183;
    ProductTable.rowHeight = UITableViewAutomaticDimension;
    [ProductTable registerNib:nib forCellReuseIdentifier:@"Product_Cell"];
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self getProduct];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
    
}
-(void)getProduct
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_stock  forKey:@"s"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleGetPROResponse:response];
     }];
}
- (void)handleGetPROResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        ProductDict=[response valueForKey:@"result"];
        Searchdic=[response valueForKey:@"result"];
        
        WithSelectArr=[[NSMutableArray alloc]init];
        withSelectMain=[[NSMutableArray alloc] init];
        for (int i=0; i<ProductDict.count; i++)
        {
            [WithSelectArr addObject:@"NO"];
        }
        
        [ProductTable reloadData];
    }
    else
    {
        [ProductTable reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ProductDict.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 13.0; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Product_Cell";
    Product_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.ProductNameLBL.text=[[ProductDict valueForKey:@"material_name"]objectAtIndex:indexPath.section];
    cell.PriceLBL.text=[NSString stringWithFormat:@"%@",[[ProductDict valueForKey:@"sell_price"]objectAtIndex:indexPath.section]];
    
    
    if ([[WithSelectArr objectAtIndex:indexPath.section] isEqualToString:@"YES"])
    {
        [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"EnbleCheckBox"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"UncheckBox"] forState:UIControlStateNormal];
    }
    
    [cell.CheckBoxBtn addTarget:self action:@selector(Chkbox_click:) forControlEvents:UIControlEventTouchUpInside];
     cell.CheckBoxBtn.tag=indexPath.section;
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (tableView==ProductTable)
    {
        if ([[WithSelectArr objectAtIndex:indexPath.section] isEqualToString:@"YES"])
        {
            [WithSelectArr replaceObjectAtIndex:indexPath.section withObject:@"NO"];
            NSInteger indx=[withSelectMain indexOfObject:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
            [withSelectMain removeObjectAtIndex:indx];
        }
        else
        {
            [WithSelectArr replaceObjectAtIndex:indexPath.section withObject:@"YES"];
            [withSelectMain addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        }
        
        [ProductTable reloadData];
    }
}

-(void)Chkbox_click:(id)sender
{
    UIButton *senderButton = (UIButton *)sender;
    NSLog(@"%ld",(long)senderButton.tag);
    
    if ([[WithSelectArr objectAtIndex:senderButton.tag] isEqualToString:@"YES"])
    {
        [WithSelectArr replaceObjectAtIndex:senderButton.tag withObject:@"NO"];
        NSInteger indx=[withSelectMain indexOfObject:[NSString stringWithFormat:@"%ld",(long)senderButton.tag]];
        [withSelectMain removeObjectAtIndex:indx];
    }
    else
    {
        [WithSelectArr replaceObjectAtIndex:senderButton.tag withObject:@"YES"];
        
        NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
        
        [Productdict setObject:[[ProductDict valueForKey:@"material_name"]objectAtIndex:senderButton.tag] forKey:@"name"];
        [Productdict setObject:[[ProductDict valueForKey:@"id"]objectAtIndex:senderButton.tag] forKey:@"id"];
        [Productdict setObject:[[ProductDict valueForKey:@"sell_price"]objectAtIndex:senderButton.tag] forKey:@"price"];
        [Productdict setObject:[[ProductDict valueForKey:@"minimum_stock_qty"]objectAtIndex:senderButton.tag] forKey:@"qty"];
        [withSelectMain addObject:Productdict];
        
    }
    [_delegate ChkProductValue:withSelectMain];

    [ProductTable reloadData];
    
      NSLog(@"withSelectMain---%@",withSelectMain);
}

#pragma mark - SerachBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // topCategoriesDic=[Searchdic mutableCopy];
    [searchBar resignFirstResponder];
    [ProductTable reloadData];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // searchBar.showsCancelButton = YES;
    // [searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [ProductTable reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    ProductDict=[Searchdic mutableCopy];
    if([searchText isEqualToString:@""] || searchText==nil)
    {
        ProductDict=[Searchdic mutableCopy];
        [ProductTable reloadData];
        return;
    }
    
    NSMutableArray *resultObjectsArray = [NSMutableArray array];
    for(NSDictionary *wine in ProductDict)
    {
        NSString *wineName = [wine objectForKey:@"material_name"];
        NSRange range = [wineName rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if(range.location != NSNotFound)
            [resultObjectsArray addObject:wine];
    }
    
    ProductDict=[resultObjectsArray mutableCopy];
    [ProductTable reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    ProductDict=[Searchdic mutableCopy];
    if([searchBar.text isEqualToString:@""] || searchBar.text==nil)
    {
        ProductDict=[Searchdic mutableCopy];
        [ProductTable reloadData];
        return;
    }
    NSMutableArray *resultObjectsArray = [NSMutableArray array];
    for(NSDictionary *wine in ProductDict)
    {
        NSString *wineName = [wine objectForKey:@"material_name"];
        NSRange range = [wineName rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
        if(range.location != NSNotFound)
            [resultObjectsArray addObject:wine];
    }
    
    ProductDict=[resultObjectsArray mutableCopy];
    [ProductTable reloadData];
    [searchBar resignFirstResponder];
}
- (IBAction)CancelSearchBtn_Action:(id)sender
{
     [SearchBR resignFirstResponder];
}
- (IBAction)BackBtn_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
