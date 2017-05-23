//
//  StockVW.m
//  digitalmarketing
//
//  Created by Mango SW on 16/05/2017.
//  Copyright © 2017 jkinfoway. All rights reserved.
//

#import "StockVW.h"
#import "Stock_Cell.h"
#import "digitalMarketing.pch"
@interface StockVW ()

@end

@implementation StockVW
@synthesize SearchBackView,TitleBack_View,StockTable;
@synthesize SerachBar;


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    StockTable.layer.borderWidth = 1.0f;
    StockTable.layer.cornerRadius=2.0f;
    [StockTable.layer setMasksToBounds:YES];
    StockTable.layer.borderColor = [UIColor colorWithRed:(132/255.0) green:(132/255.0) blue:(132/255.0) alpha:1.0].CGColor;
    
    SerachBar.layer.borderWidth = 1;
    SerachBar.layer.borderColor = [UIColor whiteColor].CGColor;
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    
    [SearchBackView.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [SearchBackView.layer setShadowOpacity:0.8];
    [SearchBackView.layer setShadowRadius:1.0];
    [SearchBackView.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
    [TitleBack_View.layer setShadowColor:[UIColor colorWithRed:(218/255.0) green:(219/255.0) blue:(225/255.0) alpha:1.0].CGColor];
    [TitleBack_View.layer setShadowOpacity:0.8];
    [TitleBack_View.layer setShadowRadius:1.0];
    [TitleBack_View.layer setShadowOffset:CGSizeMake(0.3,0.3)];
    
    
    UINib *nib = [UINib nibWithNibName:@"Stock_Cell" bundle:nil];
    Stock_Cell *cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    StockTable.rowHeight = cell.frame.size.height;
    [StockTable registerNib:nib forCellReuseIdentifier:@"Stock_Cell"];
    
    BOOL internet=[AppDelegate connectedToNetwork];
    if (internet)
    {
        [self getStock];
    }
    else
        [AppDelegate showErrorMessageWithTitle:@"" message:@"Please check your internet connection or try again later." delegate:nil];
}

-(void)getStock
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] init];
    [dictParams setObject:Base_Key  forKey:@"key"];
    [dictParams setObject:get_stock  forKey:@"s"];
    
    [CommonWS AAwebserviceWithURL:[NSString stringWithFormat:@"%@",BaseUrl] withParam:dictParams withCompletion:^(NSDictionary *response, BOOL success1)
     {
         [self handleGetResponse:response];
     }];
}
- (void)handleGetResponse:(NSDictionary*)response
{
    if ([[[response objectForKey:@"ack"]stringValue ] isEqualToString:@"1"])
    {
        StockDict=[response valueForKey:@"result"];
        Searchdic=[response valueForKey:@"result"];
        
        [StockTable reloadData];
    }
    else
    {
        [StockTable reloadData];
        [AppDelegate showErrorMessageWithTitle:AlertTitleError message:[response objectForKey:@"ack_msg"] delegate:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return StockDict.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Stock_Cell";
    Stock_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    cell.ProductName.text=[[StockDict valueForKey:@"material_name"]objectAtIndex:indexPath.section];
    cell.StockQTY_lbl.text=[NSString stringWithFormat:@"%@",[[StockDict valueForKey:@"stock_qty"]objectAtIndex:indexPath.section]];
    cell.PendingQTY_lbl.text=[NSString stringWithFormat:@"%@",[[StockDict valueForKey:@"Order_remaining_qty"]objectAtIndex:indexPath.section]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (IBAction)SearchBtn_action:(id)sender
{
    [SerachBar resignFirstResponder];
}
#pragma mark - SerachBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
   // topCategoriesDic=[Searchdic mutableCopy];
    [searchBar resignFirstResponder];
    [StockTable reloadData];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
   // searchBar.showsCancelButton = YES;
   // [searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [StockTable reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    StockDict=[Searchdic mutableCopy];
    if([searchText isEqualToString:@""] || searchText==nil)
    {
        StockDict=[Searchdic mutableCopy];
        [StockTable reloadData];
        return;
    }
    
    NSMutableArray *resultObjectsArray = [NSMutableArray array];
    for(NSDictionary *wine in StockDict)
    {
        NSString *wineName = [wine objectForKey:@"material_name"];
        NSRange range = [wineName rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if(range.location != NSNotFound)
            [resultObjectsArray addObject:wine];
    }
    
    StockDict=[resultObjectsArray mutableCopy];
    [StockTable reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    StockDict=[Searchdic mutableCopy];
    if([searchBar.text isEqualToString:@""] || searchBar.text==nil)
    {
        StockDict=[Searchdic mutableCopy];
        [StockTable reloadData];
        return;
    }
    NSMutableArray *resultObjectsArray = [NSMutableArray array];
    for(NSDictionary *wine in StockDict)
    {
        NSString *wineName = [wine objectForKey:@"material_name"];
        NSRange range = [wineName rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
        if(range.location != NSNotFound)
            [resultObjectsArray addObject:wine];
    }
    
    StockDict=[resultObjectsArray mutableCopy];
    [StockTable reloadData];
    [searchBar resignFirstResponder];
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
