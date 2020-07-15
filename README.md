# mvpTemplateProj
在iOS项目使用MVP模式的demo

1：说明，项目文件分为3种，model，view，presenter。分别是数据，视图和控制层。model全部继承于BaseRecord，view包括控制器viewcontroller和view。继承于BaseViewController和BaseView，presenter继承于BasePresenter.这里命名习惯的关系,所有的model类项目里均命名为record后缀。

2:之前的MVC中控制器内既展示页面也负责网络数据请求和处理,各种异常状态的判断,页面更新等等,逻辑较多,结构较乱,本demo将MVC中的viewcontroller内的部分拆分,将其中的网络请求,请求回调,数据转换的代码提出来,放到了presenter文件中.这样viewcontroller内只负责创建视图和更新视图即可，数据转换，数据的初始化都在record内进行，,每个viewcontroller都会绑定一个对应的presenter和record。

3:示例:
    viewcontroller内代码：
    由于所有的viewcontroller都继承BaseViewcontroller，在BaseViewcontroller内将viewdidload方法后加入两个自定义方法 initData和initViews，后面所有的子类的初始化数据和初始化页面视图可以分别写在这两个方法中，当然如果不习惯也可以继续写在viewdidload方法内。
    
    #import "GasStationViewController.h"

    @interface GasStationViewController ()<UITableViewDelegate,UITableViewDataSource>

    ProStrong UITableView *tableView;

    @end

    @implementation GasStationViewController
    buildMVPInControllerM;

    - (void)initNavis{
        self.title = @"列表";
    }

    - (void)initViews{
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView];
        
        [_tableView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.presenter.dataArray.count;
    }

    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return W(100);
    }

    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        GasStationRecord *record = self.presenter.dataArray[indexPath.row];
        cell.textLabel.text = record.address;
        return cell;
    }

    - (void)handleSuccess{
        [_tableView reloadData];
    }

    @end

presenter内的代码：
presenter内有两个方法：controllerWillAppear和controllerDidLoad，此2个方法使P层跟控制器生命周期绑定，方便自定义网络请求的位置。 
比如本来要在controller内的viewdidload请求或者viewwillappear里面发送请求
现在在该presenter文件的下两个方法内执行也有同样的效果。进一步分离p层和v层代码

    #import "GasStationPresenter.h"

    @implementation GasStationPresenter
    buildMVPInPresenterM;

    - (void)controllerWillAppear{
        [self task:GAS_STATION_LIST param:@{@"brand_id":@"0"} type:Post];
    }

    - (void)taskBegin{
        
    }

    - (void)taskDone:(id)resp fromUrl:(NSString *)url{
        self.dataArray = [NSMutableArray arrayWithArray:[GasStationRecord mj_objectArrayWithKeyValuesArray:resp]];
    }

    - (void)taskError:(NSString *)msg code:(NSInteger)code{
        [HBHUDTool showMessageCenter:msg];
    }

    @end

model文件：
    
    #import "BaseRecord.h"

    NS_ASSUME_NONNULL_BEGIN

    @interface GasStationRecord : BaseRecord

    ProCopy NSString *address;
    ProCopy NSString *city;
    ProCopy NSString *close_desc;
    ProCopy NSString *discount;
    ProCopy NSString *distance;
    ProCopy NSString *id;
    ProCopy NSString *name;
    ProCopy NSString *position;
    ProCopy NSString *price;
    ProCopy NSString *thumb;
    ProCopy NSString *is_open;
    ProCopy NSString *is_top;

    @end

这样就是一个简单的MVP的全部内容了，使用的时候注意在viewcontroller的.h内写上
        
        @interface GasStationViewController : BaseViewController
        buildMVPInControllerH(GasStationPresenter);

        @end
其中        buildMVPInControllerH(GasStationPresenter);
是用来绑定viewcontroller和presenter用的，是个宏，意思是在头文件声明一个presenter的属性，在实现文件中也要写一个宏：buildMVPInControllerM;意思是这个presenter的get方法我自己写。

在presenter的头文件和实现文件中要分别写上对应的record的声明：
    
    @interface GasStationPresenter : BasePresenter
    buildMVPInPresenterH(GasStationRecord);

    ProStrong NSMutableArray *dataArray;

    @end
功能同上，绑定presenter和record，分离record和viewcontroller，在实现文件中：buildMVPInPresenterM;

这种写法是必须要有的。然后使用方法可以参照demo中的即可，在BasePresenter中封装了一些网络请求的方法和错误处理，具体可根据需求自己写定制，在baseviewcontroller中写了一些自定义的方法和属性，可根据需要定制。

其他的就是项目的文件目录和相关的类的设计了，比如在APPdelegate中我写了两个category，分别把原appdelegate要做的繁复的工作分离到了两个分类中，这样一来代码变得整洁清晰，改动和添加功能都不用到处翻代码了。
其他的就是一些工具类和宏的定义的使用，也不复杂。

有任何问题请提issue，或者联系我，QQ：892750407.欢迎大家提出批评~
