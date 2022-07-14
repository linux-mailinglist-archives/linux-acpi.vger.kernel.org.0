Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912A8574CAE
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 14:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiGNMAQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 08:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbiGNMAP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 08:00:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F27F39B84;
        Thu, 14 Jul 2022 05:00:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r186so1358338pgr.2;
        Thu, 14 Jul 2022 05:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E2VOjluf3ek/MQbgtRalDmdAiynIGxs26XFpbrqNpRA=;
        b=BH8Eo1QKxCh29juExb3iCbmsHL1j4WmUkp9pZ/uE8D00211uY/uajvH5IPuMxvzUv2
         rjK59xnQuYBDo/0UbQupa7mDGyKnNLqliXsFkK4nfz5re3e8/UrLGGnylyejiW+p/g+F
         Cn3JssDBmTYq6cKeJv+B9FW04lBHtM3ky443F1mzQPK7rulUpAW1G7BVWp4wC7Xn9Zoq
         SMc+kBOa/vErA9d8uzqT12FjQxdceks3jPGRBhkPbxHXIgoZs+lCvHTA/AI/NmFw6JIE
         jOdsKpqVdODhDtaO6eXr7HT2PGgTO1finH+Gcfud2qHXxP8mo2LQnKAp5mfYJSxfmq2Q
         BmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E2VOjluf3ek/MQbgtRalDmdAiynIGxs26XFpbrqNpRA=;
        b=Ha84iMzJlBM3pv35Gpfw8jSgZ3A4ks6H6dg6Tzf6pDuPPqpcVrhdWX+XvVGBxR6X7E
         z1BkYFALxONsPSTXboCRt8oougPRI4OUgkGHU6LwsDLTFdQxXkTko/Vx28Uv7VexM7fb
         mv7R76vx3egYOf/W96cWgoNchlU1Qb4wz+cHFhhxAUAtQl4A5JlGght+SMp9HNzVoCck
         rOUinkhZ652lENFOAmJrfhvSHX9CG81Dp2HkTu9W+hCsSwL6r5sPNcoX77l552tfLd+u
         /MDMGrGeZnMay1/a2QGp7XcBG+RnJtdY7k1zYIZAamAwN+YEC610QXpWmWW4gN0w+fMY
         eLew==
X-Gm-Message-State: AJIora9gOYj6UWkujh+0QhTUaa9qIO3ZduGRebxIZFy0D+AKu9EVt+ls
        EBzUSS/paJEvF8YSnOjD0D0=
X-Google-Smtp-Source: AGRyM1uwFhSe52o11EuF7r4fNwvDiFP4mDw29hA5fAor2v+tXf2Q8VHfU9T/1nyN1rmyE+RJL81Skg==
X-Received: by 2002:aa7:8186:0:b0:528:c344:ed6e with SMTP id g6-20020aa78186000000b00528c344ed6emr7908173pfi.35.1657800013446;
        Thu, 14 Jul 2022 05:00:13 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id md14-20020a17090b23ce00b001ef7bcb7e61sm3596464pjb.47.2022.07.14.05.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:00:12 -0700 (PDT)
Date:   Thu, 14 Jul 2022 20:00:05 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] gpiolib: add support for bias pull disable
Message-ID: <20220714120005.GA105609@sol>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
 <20220713131421.1527179-2-nuno.sa@analog.com>
 <Ys8CpqYhWp7zVNC8@smile.fi.intel.com>
 <20220714042050.GA76737@sol>
 <4bf06ba5994f559499c45275cd7f44bfee1bbde1.camel@gmail.com>
 <20220714082710.GA103849@sol>
 <35e8020f513a77b8a8eb12a45d48a2b1390cce7c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e8020f513a77b8a8eb12a45d48a2b1390cce7c.camel@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 14, 2022 at 10:47:27AM +0200, Nuno Sá wrote:
> On Thu, 2022-07-14 at 16:27 +0800, Kent Gibson wrote:
> > On Thu, Jul 14, 2022 at 09:14:21AM +0200, Nuno Sá wrote:
> > > On Thu, 2022-07-14 at 12:20 +0800, Kent Gibson wrote:
> > > > On Wed, Jul 13, 2022 at 08:36:38PM +0300, Andy Shevchenko wrote:
> > > > > On Wed, Jul 13, 2022 at 03:14:18PM +0200, Nuno Sá wrote:
> > > > > > This change prepares the gpio core to look at firmware flags
> > > > > > and
> > > > > > set
> > > > > > 'FLAG_BIAS_DISABLE' if necessary. It works in similar way to
> > > > > > 'GPIO_PULL_DOWN' and 'GPIO_PULL_UP'.
> > > > > 
> > > > > ...
> > > > > 
> > > > > >         GPIO_PULL_UP                    = (1 << 4),
> > > > > >         GPIO_PULL_DOWN                  = (1 << 5),
> > > > > > +       GPIO_PULL_DISABLE               = (1 << 6),
> > > > > 
> > > > > To me it seems superfluous. You have already two flags:
> > > > > PUp
> > > > > PDown
> > > > > When none is set --> Pdisable
> > > > > 
> > > > 
> > > > Agree with Andy on this.  The FLAG_BIAS_DISABLE was added, by me,
> > > > to
> > > > allow the cdev interface to support bias.  cdev requires a "don't
> > > > care"
> > > > state, distinct from an explicit BIAS_DISABLE.
> > > > The FLAG_BIAS_DISABLE allows gpiolib-cdev to communicate that to
> > > > gpiolib, without altering the interpretation of the existing
> > > > PULL_UP
> > > > and
> > > > PULL_DOWN flags.
> > > > That is not an issue on the machine interface, where the two
> > > > GPIO_PULL
> > > > flags suffice.
> > > > 
> > > 
> > > I see, but this means we can only disable the pin BIAS through
> > > userspace. I might be wrong but I don't see a reason why it
> > > wouldn't be
> > > valid to do it from an in kernel path as we do for PULL-UPS and
> > > PULL-
> > > DOWNS 
> > > 
> > 
> > > > If you are looking for the place where FLAG_BIAS_DISABLE is set
> > > > it is
> > > > in
> > > > gpio_v2_line_config_flags_to_desc_flags() in gpiolib-cdev.c.
> > > > 
> > > > Referring to gpio_set_bias(), the only place in gpiolib the
> > > > FLAG_BIAS_DISABLE is used, if neither FLAG_PULL_UP,
> > > > FLAG_PULL_DOWN,
> > > > nor FLAG_BIAS_DISABLE are set then the bias configuration remains
> > > > unchanged (the don't care case) - no change is passed to the
> > > > driver.
> > > > Otherwise the corresponding PIN_CONFIG_BIAS flag is passed to the
> > > > driver.
> > > > 
> > > 
> > > Exactly, but note FLAG_BIAS_DISABLE can only be set from userspace
> > > at
> > > this point (IIUTC). If everyone agrees that should be case, so be
> > > it.
> > > But as I said, I just don't see why it's wrong to do it within the
> > > kernel.
> > > 
> > 
> > Believe it or not gpiolib-cdev is part of the kernel, not userspace -
> > it
> > just provides an interface to userspace.
> > 
> 
> Yes, I do know that. But don't you still need a userspace process to
> open the cdev and do the ioctl()?
> 

Only if you want to drive the cdev interface, so not in this case.
You would not use cdev, you would use gpiolib directly.

> > Bias can be disabled by calling gpiod_direction_input() or
> > gpiod_direction_output() after setting the FLAG_BIAS_DISABLE, as
> > gpiolib-cdev does.
> > 
> > Does that work for you?
> > 
> 
> I'm not seeing how would this work... We would need to make gpiod
> consumers having to do this. Something like:
> 
> 
> desc = giod_get();
> set_bit(FLAG_BIAS_DISABLE, &desc->flags);
> set_direction...
> 
> 

In a nutshell.

If that solves your immediate problem then you need to decide what
problem your patch is trying to address.

Cheers,
Kent.
