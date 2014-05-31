# SleipnirActivity

![Screenshot](./screenshot.png)

## Usage


    NSArray* activityItems = [NSArray arrayWithObjects:
                              self.post.title,
                              self.post.url,
                              nil];

    SleipnirActivity* sleipnirActivity             = [[SleipnirActivity alloc] init];

    UIActivityViewController *activityView = [[UIActivityViewController alloc]
                                               initWithActivityItems:activityItems
                                               applicationActivities:@[
                                                                       sleipnirActivity
                                                                       ]
                                              ];

    [self presentViewController:activityView animated:YES completion:^{

    }];

