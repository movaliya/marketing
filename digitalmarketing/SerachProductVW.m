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
@synthesize StoreID;
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
    if ([self.CheckDispatch isEqualToString:@"DISPATCH"])
    {
        [dictParams setObject:Base_Key  forKey:@"key"];
        [dictParams setObject:Dispatch_Product  forKey:@"s"];
        [dictParams setObject:self.DispatchCutomerID  forKey:@"customer_id"];
    }
    else if ([self.CheckDispatch isEqualToString:@"INWARD"])
    {
        [dictParams setObject:Base_Key  forKey:@"key"];
        [dictParams setObject:get_store_product  forKey:@"s"];
        [dictParams setObject:self.DispatchCutomerID  forKey:@"store_id"];
    }
    else
    {
        [dictParams setObject:Base_Key  forKey:@"key"];
        [dictParams setObject:get_stock  forKey:@"s"];
    }
    
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
        
        if ([self.CheckDispatch isEqualToString:@"DISPATCH"])
        {
            SelectAll=NO;
        }
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
    if ([self.CheckDispatch isEqualToString:@"DISPATCH"])
    {
        if (ProductDict.count>0)
        {
            return ProductDict.count+1;
        }
    }
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
    
    if ([self.CheckDispatch isEqualToString:@"DISPATCH"])
    {
        if (indexPath.section==0)
        {
            if (ProductDict.count>0)
            {
                cell.ProductNameLBL.text=@"All";
                cell.PriceLBL.hidden=YES;
                if (SelectAll==YES)
                {
                    [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"EnbleCheckBox"] forState:UIControlStateNormal];
                }
                else
                {
                    [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"UncheckBox"] forState:UIControlStateNormal];
                }
            }
            
        }
        else
        {
            cell.ProductNameLBL.text=[[ProductDict valueForKey:@"pro_name"]objectAtIndex:indexPath.section-1];
            cell.PriceLBL.text=[NSString stringWithFormat:@"%@",[[ProductDict valueForKey:@"unitprice"]objectAtIndex:indexPath.section-1]];
            if ([[WithSelectArr objectAtIndex:indexPath.section-1] isEqualToString:[[ProductDict valueForKey:@"pro_id"] objectAtIndex:indexPath.section-1]])
            {
                [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"EnbleCheckBox"] forState:UIControlStateNormal];
            }
            else
            {
                [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"UncheckBox"] forState:UIControlStateNormal];
            }
        }
    }
    else if ([self.CheckDispatch isEqualToString:@"INWARD"])
    {
        cell.ProductNameLBL.text=[[ProductDict valueForKey:@"material_name"]objectAtIndex:indexPath.section];
        cell.PriceLBL.text=[NSString stringWithFormat:@"%@",[[ProductDict valueForKey:@"sell_price"]objectAtIndex:indexPath.section]];
        if ([[WithSelectArr objectAtIndex:indexPath.section] isEqualToString:[[ProductDict valueForKey:@"product_id"] objectAtIndex:indexPath.section]])
        {
            [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"EnbleCheckBox"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"UncheckBox"] forState:UIControlStateNormal];
        }
    }
    else
    {
        cell.ProductNameLBL.text=[[ProductDict valueForKey:@"material_name"]objectAtIndex:indexPath.section];
        cell.PriceLBL.text=[NSString stringWithFormat:@"%@",[[ProductDict valueForKey:@"sell_price"]objectAtIndex:indexPath.section]];
        
        if ([WithSelectArr containsObject:[[ProductDict valueForKey:@"id"] objectAtIndex:indexPath.section]])
        {
            int idx=[WithSelectArr indexOfObject:[[ProductDict valueForKey:@"id"] objectAtIndex:indexPath.section]];
            
            if ([[WithSelectArr objectAtIndex:idx] isEqualToString:[[ProductDict valueForKey:@"id"] objectAtIndex:indexPath.section]])
            {
                [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"EnbleCheckBox"] forState:UIControlStateNormal];
            }
            else
            {
                [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"UncheckBox"] forState:UIControlStateNormal];
            }
            
        }
        else
        {
             [cell.CheckBoxBtn setImage:[UIImage imageNamed:@"UncheckBox"] forState:UIControlStateNormal];
        }
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
        if ([self.CheckDispatch isEqualToString:@"DISPATCH"])
        {
            if (indexPath.section==0)
            {
                if (SelectAll==NO)
                {
                    [withSelectMain removeAllObjects];
                    for (int i=0; i<Searchdic.count; i++)
                    {
                        SelectAll=YES;
                        
                        [WithSelectArr replaceObjectAtIndex:i withObject:[[Searchdic valueForKey:@"pro_id"] objectAtIndex:i]];
                        
                        NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
                        
                        [Productdict setObject:[[Searchdic valueForKey:@"pro_name"]objectAtIndex:i] forKey:@"name"];
                        [Productdict setObject:[[Searchdic valueForKey:@"pro_id"]objectAtIndex:i] forKey:@"id"];
                        [Productdict setObject:[[Searchdic valueForKey:@"unitprice"]objectAtIndex:i] forKey:@"price"];
                        [Productdict setObject:@"1" forKey:@"qty"];
                         [Productdict setObject:[[ProductDict valueForKey:@"product_stock"]objectAtIndex:i] forKey:@"product_stock"];
                        [Productdict setObject:StoreID forKey:@"store_id"];
                        
                        [withSelectMain addObject:Productdict];
                    }
                }
                else
                {
                    for (int i=0; i<Searchdic.count; i++)
                    {
                        [WithSelectArr replaceObjectAtIndex:i withObject:@"NO"];
                        [withSelectMain removeAllObjects];
                        
                        SelectAll=NO;
                    }
                }
            }
            else
            {
                
                NSString *ID=[[ProductDict valueForKey:@"pro_id"] objectAtIndex:indexPath.section-1];
                
                NSMutableArray *Arr=[Searchdic valueForKey:@"pro_id"];
                int idint=[Arr indexOfObject:ID];
                if (![[WithSelectArr objectAtIndex:idint] isEqualToString:@"NO"])
                {
                    [WithSelectArr replaceObjectAtIndex:idint withObject:@"NO"];
                    
                    NSArray *idarr=[withSelectMain valueForKey:@"id"];
                    NSInteger indx=[idarr indexOfObject:[[ProductDict valueForKey:@"pro_id"] objectAtIndex:indexPath.section-1]];
                    [withSelectMain removeObjectAtIndex:indx];
                }
                else
                {
                    //
                    
                    [WithSelectArr replaceObjectAtIndex:idint withObject:[[ProductDict valueForKey:@"pro_id"] objectAtIndex:indexPath.section-1]];
                    
                    NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
                    
                    [Productdict setObject:[[ProductDict valueForKey:@"pro_name"]objectAtIndex:indexPath.section-1] forKey:@"name"];
                    [Productdict setObject:[[ProductDict valueForKey:@"pro_id"]objectAtIndex:indexPath.section-1] forKey:@"id"];
                    [Productdict setObject:[[ProductDict valueForKey:@"unitprice"]objectAtIndex:indexPath.section-1] forKey:@"price"];
                    [Productdict setObject:@"1" forKey:@"qty"];
                    [Productdict setObject:[[ProductDict valueForKey:@"product_stock"]objectAtIndex:indexPath.section-1] forKey:@"product_stock"];
                    [Productdict setObject:StoreID forKey:@"store_id"];
                    [withSelectMain addObject:Productdict];
                    
                }
            }
            
        }
        else if ([self.CheckDispatch isEqualToString:@"INWARD"])
        {
            NSString *ID=[[ProductDict valueForKey:@"product_id"] objectAtIndex:indexPath.section];
            
            NSMutableArray *Arr=[Searchdic valueForKey:@"product_id"];
            int idint=[Arr indexOfObject:ID];
            if (![[WithSelectArr objectAtIndex:idint] isEqualToString:@"NO"])
            {
                [WithSelectArr replaceObjectAtIndex:idint withObject:@"NO"];
                
                NSArray *idarr=[withSelectMain valueForKey:@"id"];
                NSInteger indx=[idarr indexOfObject:[[ProductDict valueForKey:@"product_id"] objectAtIndex:indexPath.section]];
                [withSelectMain removeObjectAtIndex:indx];
            }
            else
            {
                [WithSelectArr replaceObjectAtIndex:idint withObject:[[ProductDict valueForKey:@"product_id"] objectAtIndex:indexPath.section]];
                
                NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
                
                [Productdict setObject:[[ProductDict valueForKey:@"material_name"]objectAtIndex:indexPath.section] forKey:@"name"];
                [Productdict setObject:[[ProductDict valueForKey:@"product_id"]objectAtIndex:indexPath.section] forKey:@"id"];
                [Productdict setObject:[[ProductDict valueForKey:@"sell_price"]objectAtIndex:indexPath.section] forKey:@"price"];
                [Productdict setObject:@"1" forKey:@"qty"];
                [Productdict setObject:[[ProductDict valueForKey:@"store_id"]objectAtIndex:indexPath.section] forKey:@"store_id"];
                [withSelectMain addObject:Productdict];
                
            }
        }
        else
        {
            NSString *ID=[[ProductDict valueForKey:@"id"] objectAtIndex:indexPath.section];
            
            NSMutableArray *Arr=[Searchdic valueForKey:@"id"];
            int idint=[Arr indexOfObject:ID];
            
            if (![[WithSelectArr objectAtIndex:idint] isEqualToString:@"NO"])
            {
                [WithSelectArr replaceObjectAtIndex:idint withObject:@"NO"];
                
                NSArray *idarr=[withSelectMain valueForKey:@"id"];
                NSInteger indx=[idarr indexOfObject:[[ProductDict valueForKey:@"id"] objectAtIndex:indexPath.section]];
                [withSelectMain removeObjectAtIndex:indx];
            }
            else
            {
                [WithSelectArr replaceObjectAtIndex:idint withObject:[[ProductDict valueForKey:@"id"] objectAtIndex:indexPath.section]];
                
                
                
                NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
                
                [Productdict setObject:[[ProductDict valueForKey:@"material_name"]objectAtIndex:indexPath.section] forKey:@"name"];
                [Productdict setObject:[[ProductDict valueForKey:@"id"]objectAtIndex:indexPath.section] forKey:@"id"];
                [Productdict setObject:[[ProductDict valueForKey:@"sell_price"]objectAtIndex:indexPath.section] forKey:@"price"];
                //[Productdict setObject:[[ProductDict valueForKey:@a"minimum_stock_qty"]objectAtIndex:indexPath.section] forKey:@"qty"];
                [Productdict setObject:@"1" forKey:@"qty"];
                [withSelectMain addObject:Productdict];
            }
        }
        
        [_delegate ChkProductValue:withSelectMain];
        [ProductTable reloadData];
    }
}

-(void)Chkbox_click:(id)sender
{
    UIButton *senderButton = (UIButton *)sender;
    
    if ([self.CheckDispatch isEqualToString:@"DISPATCH"])
    {
        if (senderButton.tag==0)
        {
            if (SelectAll==NO)
            {
                [withSelectMain removeAllObjects];
                for (int i=0; i<Searchdic.count; i++)
                {
                    SelectAll=YES;
                    [WithSelectArr replaceObjectAtIndex:i withObject:[[Searchdic valueForKey:@"pro_id"] objectAtIndex:i]];
                    
                    NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
                    
                    [Productdict setObject:[[Searchdic valueForKey:@"pro_name"]objectAtIndex:i] forKey:@"name"];
                    [Productdict setObject:[[Searchdic valueForKey:@"pro_id"]objectAtIndex:i] forKey:@"id"];
                    [Productdict setObject:[[Searchdic valueForKey:@"unitprice"]objectAtIndex:i] forKey:@"price"];
                    [Productdict setObject:@"1" forKey:@"qty"];
                    [Productdict setObject:[[Searchdic valueForKey:@"product_stock"]objectAtIndex:i] forKey:@"product_stock"];
                    [Productdict setObject:StoreID forKey:@"store_id"];
                    [withSelectMain addObject:Productdict];
                }
            }
            else
            {
                for (int i=0; i<Searchdic.count; i++)
                {
                    [WithSelectArr replaceObjectAtIndex:i withObject:@"NO"];
                    [withSelectMain removeAllObjects];
                    
                    SelectAll=NO;
                }
            }

        }
        else
        {
            
            
            NSString *ID=[[ProductDict valueForKey:@"pro_id"] objectAtIndex:senderButton.tag-1];
            
            NSMutableArray *Arr=[Searchdic valueForKey:@"pro_id"];
            int idint=[Arr indexOfObject:ID];
            
            if (![[WithSelectArr objectAtIndex:idint] isEqualToString:@"NO"])
            {
                [WithSelectArr replaceObjectAtIndex:idint withObject:@"NO"];
                
                NSArray *idarr=[withSelectMain valueForKey:@"id"];
                NSInteger indx=[idarr indexOfObject:[[ProductDict valueForKey:@"pro_id"] objectAtIndex:senderButton.tag-1]];
                [withSelectMain removeObjectAtIndex:indx];
            }
            else
            {
                [WithSelectArr replaceObjectAtIndex:idint withObject:[[ProductDict valueForKey:@"pro_id"] objectAtIndex:senderButton.tag-1]];
                
                NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
                
                [Productdict setObject:[[ProductDict valueForKey:@"pro_name"]objectAtIndex:senderButton.tag-1] forKey:@"name"];
                [Productdict setObject:[[ProductDict valueForKey:@"pro_id"]objectAtIndex:senderButton.tag-1] forKey:@"id"];
                [Productdict setObject:[[ProductDict valueForKey:@"unitprice"]objectAtIndex:senderButton.tag-1] forKey:@"price"];
                [Productdict setObject:[[Searchdic valueForKey:@"product_stock"]objectAtIndex:senderButton.tag-1] forKey:@"product_stock"];
                [Productdict setObject:@"1" forKey:@"qty"];
                [Productdict setObject:StoreID forKey:@"store_id"];
                [withSelectMain addObject:Productdict];
            }

        }
    }
    else if ([self.CheckDispatch isEqualToString:@"INWARD"])
    {
        NSString *ID=[[ProductDict valueForKey:@"product_id"] objectAtIndex:senderButton.tag];
        
        NSMutableArray *Arr=[Searchdic valueForKey:@"product_id"];
        int idint=[Arr indexOfObject:ID];
        if (![[WithSelectArr objectAtIndex:idint] isEqualToString:@"NO"])
        {
            [WithSelectArr replaceObjectAtIndex:idint withObject:@"NO"];
            
            NSArray *idarr=[withSelectMain valueForKey:@"id"];
            NSInteger indx=[idarr indexOfObject:[[ProductDict valueForKey:@"product_id"] objectAtIndex:senderButton.tag]];
            [withSelectMain removeObjectAtIndex:indx];
        }
        else
        {
            [WithSelectArr replaceObjectAtIndex:idint withObject:[[ProductDict valueForKey:@"product_id"] objectAtIndex:senderButton.tag]];
            
            NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
            
            [Productdict setObject:[[ProductDict valueForKey:@"material_name"]objectAtIndex:senderButton.tag] forKey:@"name"];
            [Productdict setObject:[[ProductDict valueForKey:@"product_id"]objectAtIndex:senderButton.tag] forKey:@"id"];
            [Productdict setObject:[[ProductDict valueForKey:@"sell_price"]objectAtIndex:senderButton.tag] forKey:@"price"];
            [Productdict setObject:@"1" forKey:@"qty"];
            [Productdict setObject:[[ProductDict valueForKey:@"store_id"]objectAtIndex:senderButton.tag] forKey:@"store_id"];
            [withSelectMain addObject:Productdict];
        }
    }
    else
    {
        NSString *ID=[[ProductDict valueForKey:@"id"] objectAtIndex:senderButton.tag];
        
        NSMutableArray *Arr=[Searchdic valueForKey:@"id"];
        int idint=[Arr indexOfObject:ID];
        
        if (![[WithSelectArr objectAtIndex:idint] isEqualToString:@"NO"])
        {
            [WithSelectArr replaceObjectAtIndex:idint withObject:@"NO"];
            
            NSArray *idarr=[withSelectMain valueForKey:@"id"];
            NSInteger indx=[idarr indexOfObject:[[ProductDict valueForKey:@"id"] objectAtIndex:senderButton.tag]];
            [withSelectMain removeObjectAtIndex:indx];
        }
        else
        {
            NSString *ID=[[ProductDict valueForKey:@"id"] objectAtIndex:senderButton.tag];
            
            NSMutableArray *Arr=[Searchdic valueForKey:@"id"];
            int idint=[Arr indexOfObject:ID];
            
            [WithSelectArr replaceObjectAtIndex:idint withObject:[[ProductDict valueForKey:@"id"] objectAtIndex:senderButton.tag]];
            
            NSMutableDictionary *Productdict = [[NSMutableDictionary alloc] init];
            
            [Productdict setObject:[[ProductDict valueForKey:@"material_name"]objectAtIndex:senderButton.tag] forKey:@"name"];
            [Productdict setObject:[[ProductDict valueForKey:@"id"]objectAtIndex:senderButton.tag] forKey:@"id"];
            [Productdict setObject:[[ProductDict valueForKey:@"sell_price"]objectAtIndex:senderButton.tag] forKey:@"price"];
            //[Productdict setObject:[[ProductDict valueForKey:@"minimum_stock_qty"]objectAtIndex:senderButton.tag] forKey:@"qty"];
            [Productdict setObject:@"1" forKey:@"qty"];
            [withSelectMain addObject:Productdict];
        }
    }
    
    [_delegate ChkProductValue:withSelectMain];

    [ProductTable reloadData];
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
        NSString *wineName;
        if ([self.CheckDispatch isEqualToString:@"DISPATCH"])
        {
            wineName = [wine objectForKey:@"pro_name"];
        }
        else
        {
            wineName = [wine objectForKey:@"material_name"];
        }
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
        NSString *wineName;
        if ([self.CheckDispatch isEqualToString:@"DISPATCH"])
        {
            wineName = [wine objectForKey:@"pro_name"];
        }
        else
        {
            wineName = [wine objectForKey:@"material_name"];
        }
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

@end
