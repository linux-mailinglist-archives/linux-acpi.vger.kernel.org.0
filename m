Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7E34BC6B
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Mar 2021 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhC1Mu6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Mar 2021 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhC1Mud (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Mar 2021 08:50:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A151C061762;
        Sun, 28 Mar 2021 05:50:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so4653273pjb.0;
        Sun, 28 Mar 2021 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wjdr4p4c1SUhVLd42l0vy2P5QT8htThYmXSTsLM/fJM=;
        b=o+3GRxcoDW09J9XuRpWqYVZNLsNnexx1amFimstXIXPvIFYXrrhVtxgiYk9xAm3dDP
         37AX/agnG8YByg3X5SZtOzbrZxTEeMmx/I0+nDiCbYlwhfA745FZHluNPaeOeW1Z+4B3
         uAB+4z/gZfJb5LEiKZoNI0tk9E8ZbJ8CceQl/2Jsucf4Wz9WLTW/g1IUhmP3AipPPs7+
         HRq+l6e0Y9J2BB42U75J5/L94XjbH3pryplAmlCgA7dfC/xejazIuo+xr+y6IuqdOJb0
         sxx4xqIF7USlKJvpLAouwxSwJDwfYAopybJ869thrlW9gwqWggZE1IC02/EKH6Uw58hL
         qPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjdr4p4c1SUhVLd42l0vy2P5QT8htThYmXSTsLM/fJM=;
        b=AuR/K/VMLH+T+MA2m2XdoV/vPutgjU6G9DNNyqu2IGabl0KM45lTwvDeMGV8XW+14K
         Gn86AnUvjdFfTsfhcq35NOEmCaSek44vcxPtWvqMuqd+87w6v+srwOEzrQtFMGtJpsh0
         Cy/ZT/nCc1Oa9SQXQKJvXw7EGiQJpjBbzNvxfaE73Qtui4IucixoSNZxVIhXPuRnF2pF
         +BYPf+RofmhWomBT38IjV62xqLK8mmb3ti7Muy0TyjRqg5StDMTytD6ORqM2+Xv58hVD
         xyS0+9DijHS2I7Hb54ZjN/kBT1SVLX0Xeymle9m3XC74m3ssRLt0RBKFc/wHlQcR7LaD
         KUJg==
X-Gm-Message-State: AOAM533OUfw6wj0yvvHHPQOjg9Ms336PoYtf8ByTUMiB8AmObr7TW7Ob
        riggtMnU2z3A0qVzUloXjFlw5os7hoYLXgjNXcHe4eETGaA=
X-Google-Smtp-Source: ABdhPJyaQZAMk4Pim1F4UnINI1LvuiRAQwnNfXpaKdOnxG4TX4cwldUQ+wH57otF3+J6Xa3zonGF/4hg7yJdjaCko1c=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr23030584pjx.181.1616935832529;
 Sun, 28 Mar 2021 05:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-5-andriy.shevchenko@linux.intel.com> <YGBBlCBMp0P4mVJG@kroah.com>
In-Reply-To: <YGBBlCBMp0P4mVJG@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Mar 2021 15:50:16 +0300
Message-ID: <CAHp75Vf2h1s-p43q41+Dnw6FP0L-vtb0YkjGHpSdkERYJW6xZw@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] software node: Imply kobj_to_swnode() to be no-op
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 28, 2021 at 11:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Mar 28, 2021 at 12:20:09AM +0200, Andy Shevchenko wrote:
> > Since we don't use structure field layout randomization
> > the manual shuffling can affect some macros, in particular
> > kobj_to_swnode(), which becomes a no-op when kobj member
> > is the first one in the struct swnode.
> >
> > Bloat-o-meter statistics:
> >
> >   add/remove: 0/0 grow/shrink: 2/10 up/down: 9/-100 (-91)
> >   Total: Before=7217, After=7126, chg -1.26%
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/base/swnode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 22f81688af2c..ae53c48f84b1 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -13,10 +13,10 @@
> >  #include <linux/sysfs.h>
> >
> >  struct swnode {
> > -     int id;
> >       struct kobject kobj;
> >       struct fwnode_handle fwnode;
> >       const struct software_node *node;
> > +     int id;
>
> So you remove one math operation on a pointer and get a 1% size decrease
> of the whole kernel?  Or just one file?

One file, swnode.o. I'll clarify this in the commit message.

-- 
With Best Regards,
Andy Shevchenko
