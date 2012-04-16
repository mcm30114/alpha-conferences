//
//  CGUtils.h
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

void drawLinearGradient(CGContextRef context, CGRect rect, UIColor *startColor, UIColor  *endColor);
void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);
void draw1PxStrokeWithHighlight(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color, CGColorRef highlight);
void drawGlossAndGradient(CGContextRef context, CGRect rect, UIColor *startColor, UIColor *endColor);
void drawRoundedRect(CGContextRef c, CGRect rect, CGFloat radiusTopLeft, CGFloat radiusTopRight, CGFloat radiusBottomLeft, CGFloat radiusBottomRight);
void drawLinearGloss(CGContextRef context, CGRect rect, BOOL reverse);
void drawCurvedGloss(CGContextRef context, CGRect rect, CGFloat radius);
CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius);
CGRect rectFor1PxStroke(CGRect rect);