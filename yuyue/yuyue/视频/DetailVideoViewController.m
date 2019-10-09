//
//  DetailVideoViewController.m
//  yuyue
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "DetailVideoViewController.h"
#import "CustomSearchView.h"

@interface DetailVideoViewController ()<UISearchBarDelegate>
@property(nonatomic,strong) CustomSearchView  *searchView;
@property(nonatomic,strong) UISearchBar  *searchBar;

@end

@implementation DetailVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSearchBarView];
}
-(void)initSearchBarView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREENWIDTH-100,32)];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 100, 32)];
    self.searchBar.placeholder = _searchStr;
    self.searchBar.layer.cornerRadius = 15;
    self.searchBar.layer.masksToBounds = YES;
    //设置背景图是为了去掉上下黑线
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的主题颜色
    //设置背景色
    self.searchBar.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1];
    // 修改cancel
    self.searchBar.showsCancelButton= NO;
    self.searchBar.barStyle=UIBarStyleDefault;
    self.searchBar.delegate=self;
    // 修改cancel
    self.searchBar.showsSearchResultsButton=NO;
    //5. 设置搜索Icon
    [self.searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    /*这段代码有个特别的地方就是通过KVC获得到UISearchBar的私有变量
     searchField（类型为UITextField），设置SearchBar的边框颜色和圆角实际上也就变成了设置searchField的边框颜色和圆角，你可以试试直接设置SearchBar.layer.borderColor和cornerRadius，会发现这样做是有问题的。*/
    //一下代码为修改placeholder字体的颜色和大小
    UITextField*searchField = [_searchBar valueForKey:@"_searchField"];
    //2. 设置圆角和边框颜色
    if(searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
        [searchField setValue:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    }
    // 输入文本颜色
    searchField.textColor= [UIColor blackColor];
    searchField.font= [UIFont systemFontOfSize:15];
    // 默认文本大小
    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    //只有编辑时出现出现那个叉叉
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
}
#pragma uisearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
//退出键盘之后退出
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_searchBar isExclusiveTouch]) {
       [_searchBar resignFirstResponder];
    }
}

@end
