//
//  StringComponent.m
//  XDYCar
//
//  Created by zhangqiang on 2017/12/13.
//  Copyright © 2017年 xindongyuan. All rights reserved.
//

#import "StringComponent.h"

@implementation StringOffset


@end

@interface StringComponent ()

ProUnsafe UIFont *font;
ProStrong NSString *text;
ProUnsafe BOOL html;
ProStrong UIColor *color;
ProStrong NSArray *range;
ProUnsafe CGFloat blurRadius;
ProStrong UIImage *attachImage;
ProStrong UIColor *shadowColor;
ProUnsafe NSTextAlignment alignment;
ProUnsafe CGFloat  seperateNum;
ProUnsafe CGFloat lineSpace;
ProUnsafe BOOL orderBaseLine;//是否无富文本的文字和富文本文字水平x轴对齐
ProUnsafe BOOL strike;//显示删除线
ProUnsafe StringOffset  *shadowOffSet;
@end

@implementation StringComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
    }else{
        @throw [[NSException alloc] initWithName:@"请把该类初始化后使用" reason:@"" userInfo:nil];
    }
    return self;
}

-(NSMutableAttributedString *)attribuString{
    if (!_attribuString) {
        NSMutableDictionary *defaultDic = [NSMutableDictionary dictionary];
        NSInteger fontSize1 = 21;
        NSInteger fontSize2 = 12;
        CGFloat fontRatio = 0.26;//基线偏移比率
        
        defaultDic[NSForegroundColorAttributeName] = self.color;
        defaultDic[NSFontAttributeName] = self.font;
        
        if (self.shadowOffSet && self.shadowColor) {
            NSShadow *shadow = [[NSShadow alloc] init];
            shadow.shadowColor = self.shadowColor;
            shadow.shadowOffset = CGSizeMake(self.shadowOffSet.x, self.shadowOffSet.y);
            shadow.shadowBlurRadius = self.blurRadius;
            defaultDic[NSShadowAttributeName] = shadow;
        }
        
        NSTextAttachment *attchment = nil;
        NSAttributedString *attachString;
        if (self.attachImage) {
            attchment = [[NSTextAttachment alloc] init];
            attchment.image = self.attachImage;
            CGFloat paddingTop = self.font.lineHeight - self.font.pointSize;
            attchment.bounds = CGRectMake(0, -paddingTop, self.font.lineHeight, self.font.lineHeight);
            attachString = [NSAttributedString attributedStringWithAttachment:attchment];
        }
        
        if (self.seperateNum > 0) {
            defaultDic[NSKernAttributeName] = @(self.seperateNum);
        }

        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
        if (self.range.count > 1) {
            NSRange range = NSMakeRange([self.range[0] integerValue], [self.range[1] integerValue]);
            attr = [[NSMutableAttributedString alloc] initWithString:self.text];
            [attr addAttributes:defaultDic range:range];
            if (self.orderBaseLine) {
                if ([self.range.firstObject integerValue] > 0) {
                    [attr addAttribute:NSBaselineOffsetAttributeName value:@(fontRatio * (fontSize1 - fontSize2)) range:NSMakeRange(0, [self.range.firstObject integerValue])];
                }else{
                    [attr addAttribute:NSBaselineOffsetAttributeName value:@(fontRatio * (fontSize1 - fontSize2)) range:NSMakeRange([self.range[1] integerValue], self.text.length-[self.range[1] integerValue])];
                }
            }
            if (self.strike) {
                [attr addAttributes:@{
                    NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                    NSStrikethroughColorAttributeName : ColorRGB(153, 153, 153),
                    NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange([self.range[0] integerValue], [self.range[1] integerValue])];
            }
        }else{
            if (self.html) {
                NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
                NSData *data = [self.text dataUsingEncoding:NSUTF8StringEncoding];
                attr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
                [attr addAttributes:defaultDic range:NSMakeRange(0, attr.length)];
            }else{
                if (defaultDic.allValues.count > 0) {
                    attr = [[NSMutableAttributedString alloc] initWithString:self.text attributes:defaultDic];
                }else if(self.text.length > 0){
                    attr = [[NSMutableAttributedString alloc] initWithString:self.text];
                }else{
                    attr = [[NSMutableAttributedString alloc] init];
                }
                if (self.strike) {
                    [attr addAttributes:@{
                        NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                        NSStrikethroughColorAttributeName : ColorRGB(153, 153, 153),
                        NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange([self.range[0] integerValue], [self.range[1] integerValue])];
                }
            }
        }
        if (attchment != nil) {
            [attr insertAttributedString:[NSMutableAttributedString attributedStringWithAttachment:attchment] atIndex:0];
            [attr insertAttributedString:[[NSMutableAttributedString alloc] initWithString:@"  "] atIndex:1];
        }
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        if (self.alignment || self.lineSpace) {
            style.alignment = self.alignment;
            style.lineSpacing = self.lineSpace;
            defaultDic[NSParagraphStyleAttributeName] = style;
            [attr addAttributes:@{NSParagraphStyleAttributeName:style} range:NSMakeRange(0, self.text.length)];
        }
        _attribuString = attr;
    }
    return _attribuString;
}

-(StringComponentChain)COMFont{
    return ^(id font){
        self.font = font;
        return self;
    };
}

-(StringComponentChain)COMText{
    return ^(id text){
        self.text = text;
        return self;
    };
}

-(StringComponentChain)COMHtml{
    return ^(id text){
        self.html = [text boolValue];
        return self;
    };
}

-(StringComponentChain)COMColor{
    return ^(id color){
        self.color = color;
        return self;
    };
}

- (StringComponentChain)COMRange{
    return ^(id range){
        self.range = [NSArray arrayWithArray:range];
        return self;
    };
}

-(StringComponentChain)COMShadowColor{
    return ^(id color){
        self.shadowColor = color;
        return self;
    };
}

-(StringComponentChain)COMShadowOffSet{
    return ^(id offset){
        self.shadowOffSet = offset;
        return self;
    };
}

-(StringComponentChain)COMBlurRadius{
    return ^(id blurRadius){
        self.blurRadius = [blurRadius floatValue];
        return self;
    };
}

-(StringComponentChain)COMAttachImage{
    return ^(id image){
        self.attachImage = image;
        return self;
    };
}

-(StringComponentChain)COMSeperateSpace{
    return ^(id seperate){
        self.seperateNum = [seperate floatValue];
        return self;
    };
}

-(StringComponentChain)COMTextAlignment{
    return ^(id alignment){
        self.alignment = [alignment integerValue];
        return self;
    };
}

-(StringComponentChain)COMLineSpace{
    return ^(id lineNum){
        self.lineSpace = [lineNum floatValue];
        return self;
    };
}

- (StringComponentChain)COMBaseLine{
    return ^(id baseLine){
        self.orderBaseLine = [baseLine boolValue];
        return self;
    };
}

- (StringComponentChain)COMStrikeLine{
    return ^(id strike){
        self.strike = [strike boolValue];
        return self;
    };
}

-(StringComponent *)appendingStringWithString:(StringComponent *)com{
    StringComponent *newcom = [StringComponent new];
    [self.attribuString appendAttributedString:com.attribuString];
    newcom.attribuString = self.attribuString;
    return newcom;
}
@end
