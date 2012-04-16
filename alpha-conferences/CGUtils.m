//
//  CGUtils.m
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "CGUtils.h"

void drawLinearGradient(CGContextRef context, CGRect rect, UIColor *startColor, UIColor *endColor)
{    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = [NSArray arrayWithObjects:(id) startColor.CGColor, (id) endColor.CGColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    if (!CGContextIsPathEmpty(context)) {
        CGContextClip(context);
    }
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color) {
    
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);        
}

void draw1PxStrokeWithHighlight(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color, CGColorRef highlight) {
    draw1PxStroke(context,startPoint,endPoint,color);
    draw1PxStroke(context,CGPointMake(startPoint.x, startPoint.y+1.0),CGPointMake(endPoint.x, endPoint.y+1.0),highlight);
}

void drawGlossAndGradient(CGContextRef context, CGRect rect, UIColor *startColor, UIColor *endColor) {
    
    drawLinearGradient(context, rect, startColor, endColor);
    
    UIColor *glossColor1 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35];
    UIColor *glossColor2 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);
    
    drawLinearGradient(context, topHalf, glossColor1, glossColor2);
}

CGRect rectFor1PxStroke(CGRect rect) {
    return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, rect.size.width - 1, rect.size.height - 1);
}

void drawRoundedRect(CGContextRef c, CGRect rect, CGFloat radiusTopLeft, CGFloat radiusTopRight, CGFloat radiusBottomLeft, CGFloat radiusBottomRight) {
    
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGContextMoveToPoint(c, minX + radiusTopRight, minY);
    
    // top right
    CGContextAddArcToPoint(c, maxX, minY, maxX, minY + radiusTopRight, radiusTopRight);
    
    // bottom right
    CGContextAddArcToPoint(c, maxX, maxY, maxX - radiusBottomRight, maxY, radiusBottomRight);
    
    // bottom left
    CGContextAddArcToPoint(c, minX, maxY, minX, maxY - radiusBottomLeft, radiusBottomLeft);
    
    // top left
    CGContextAddArcToPoint(c, minX, minY, minX + radiusTopLeft, minY, radiusTopLeft);
}

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius) {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    CGPathCloseSubpath(path);
    
    return path;        
}

void drawLinearGloss(CGContextRef context, CGRect rect, BOOL reverse) {
    
	UIColor *highlightStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35];
	UIColor *highlightEnd = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    if (reverse) {
        
		CGRect half = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height/2, rect.size.width, rect.size.height/2);    
		drawLinearGradient(context, half, highlightEnd, highlightStart);
	}
	else {
		CGRect half = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);    
		drawLinearGradient(context, half, highlightStart, highlightEnd);
	}
    
}

void drawCurvedGloss(CGContextRef context, CGRect rect, CGFloat radius) {
    
	UIColor *glossStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
	UIColor *glossEnd = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
	CGMutablePathRef glossPath = CGPathCreateMutable();
    
	CGContextSaveGState(context);
    CGPathMoveToPoint(glossPath, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect)-radius+rect.size.height/2);
	CGPathAddArc(glossPath, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect)-radius+rect.size.height/2, radius, 0.75f*M_PI, 0.25f*M_PI, YES);	
	CGPathCloseSubpath(glossPath);
	CGContextAddPath(context, glossPath);
	CGContextClip(context);
    
	CGMutablePathRef buttonPath=createRoundedRectForRect(rect, 6.0f);
    
	CGContextAddPath(context, buttonPath);
	CGContextClip(context);
    
	CGRect half = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);    
    
	drawLinearGradient(context, half, glossStart, glossEnd);
	CGContextRestoreGState(context);
    
	CGPathRelease(buttonPath);
	CGPathRelease(glossPath);
}