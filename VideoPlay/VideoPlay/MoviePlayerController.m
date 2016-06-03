//
//  MoviePlayerController.m
//  VideoPlay
//
//  Created by SmileLife on 16/6/2.
//  Copyright © 2016年 SmileLife. All rights reserved.
//

#import "MoviePlayerController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MoviePlayerController ()

@property(nonatomic, strong) MPMoviePlayerController *playerVC;//视频播放控制器

@end

@implementation MoviePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNotification];//添加通知
    [self.playerVC play];//播放
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  获取视频的URL
 *
 *  @return NSURL 路劲
 */
- (NSURL *)getNetWorkURL{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",self.videoUrl];
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
    
}


/**
 *  创建媒体播放器
 *
 *  @return 媒体播放器
 */
- (MPMoviePlayerController *)playerVC{
    
    if (!_playerVC) {
        NSURL *url = [self getNetWorkURL];
        
        _playerVC = [[MPMoviePlayerController alloc]initWithContentURL:url];
        _playerVC.view.frame = self.view.bounds;
        _playerVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_playerVC.view];
    }
    
    
    return _playerVC;
}

/**
 *  添加通知监控播放器状态
 */

- (void)addNotification{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:self.playerVC];
    
    [center addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.playerVC];
}

/**
 *  移除通知
 */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.playerVC.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.playerVC.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */

-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.playerVC.playbackState);
}




@end
