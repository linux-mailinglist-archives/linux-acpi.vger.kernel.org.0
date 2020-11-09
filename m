Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4393A2AC42D
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgKISxK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 13:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgKISxK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 13:53:10 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F3C0613CF;
        Mon,  9 Nov 2020 10:53:09 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i26so7921766pgl.5;
        Mon, 09 Nov 2020 10:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R/ksnRozjHK49M+dG1bF8DYVJ1cjdA9PgQbho/O6SMM=;
        b=JZ6aw/VlbAMrfwwELD4gRczHxAMcagzXPzIikS+yDjTy9JyUTdY74BDX1DednbB0Dm
         1nl4N/W/xTL2NUqiQ2u/8DVWE7ErG6A4ppGREGofo6vGJlJiNQHNGnGYKKvZMHiToCLQ
         mq5dy21+hXhdDSLr1rg0bzg8cFh/gih7ZMcG913HDreCq6lyAKl7H78AjfDAnscAKMK+
         o5+99bcvP24Jg43EoboX1pwpNpALoZkDBYPLlunJVKYdBmWX4Xb2v7feLGBBj5ntCH2X
         T3qo/yS47JyJjmOJtVej6bvN/5nryIc1qna6Ke4beqHN1i1IvdHNMFxOxdBL2jjyZm17
         jS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/ksnRozjHK49M+dG1bF8DYVJ1cjdA9PgQbho/O6SMM=;
        b=EVRZSkqJXZKdy/iCfiB+S/VOAbNjO4hez6wSjXKSFzaGCO0my9yfRDvJpOdhglMdaq
         T5uNuIC+PiF5XR4wYxZEKo+ttHOhtFFSHG200guX6qGBAqp83rCL7zkmUd2081UrlIAx
         f+RJc2xy+jFylnaxEXib/fF6H4bXAXkUzC1unR5LTTp8MMUaUTPFYh0riX0A+L29iKOn
         TtS1YWFPVUGYhyam+HUmwFpgM3YTQ8vvS9WR7jaPZy9abMOVy9CleXNEVNJ77I2OhqL6
         qUQr14S5TL/Vp+JjVp3V1v3PZ7QggFH+xr4LAg7SoFUJ+L1BzGgzksEhax5Oep7MVb2P
         WF1w==
X-Gm-Message-State: AOAM532kqJdCYkVsiDrKzOVu3AOmRuRg2JReNCKH2tMxuMmSDh0oRDw7
        CEs1on3PTZIwmb64I0A/D+I=
X-Google-Smtp-Source: ABdhPJwa2KiN4rLnPKPNt8Ut1jioyw4g3vGVqobS1ccmwI7DW1M/fX2psEtEAmYkcOpNgc3LWPwOBg==
X-Received: by 2002:a17:90a:9dcb:: with SMTP id x11mr586198pjv.132.1604947988719;
        Mon, 09 Nov 2020 10:53:08 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id d18sm11846470pfo.133.2020.11.09.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:53:08 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:53:05 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v8 3/6] software node: implement reference properties
Message-ID: <20201109185305.GT1003057@dtor-ws>
References: <20201109172435.GJ4077@smile.fi.intel.com>
 <CGME20201109181851eucas1p241de8938e399c0b603c764593b057c41@eucas1p2.samsung.com>
 <dleftj4klypf5u.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dleftj4klypf5u.fsf%l.stelmach@samsung.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 09, 2020 at 07:18:37PM +0100, Lukasz Stelmach wrote:
> It was <2020-11-09 pon 19:24>, when Andy Shevchenko wrote:
> > On Mon, Nov 09, 2020 at 06:02:29PM +0100, Lukasz Stelmach wrote:
> >> It was <2019-11-07 czw 20:22>, when Dmitry Torokhov wrote:
> >> > It is possible to store references to software nodes in the same fashion as
> >> > other static properties, so that users do not need to define separate
> >> > structures:
> >> >
> >> > static const struct software_node gpio_bank_b_node = {
> >> > 	.name = "B",
> >> > };
> >> >
> >> > static const struct property_entry simone_key_enter_props[] = {
> >> > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> >> > 	PROPERTY_ENTRY_STRING("label", "enter"),
> >> > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> >> > 	{ }
> >> > };
> >> >
> >> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> > ---
> >> 
> >> I am writing a piece that needs to provide a list of gpios to a
> >> diriver. The above example looks like what I need.
> >
> > Nope.
> >
> > It mustn't be used for GPIOs or PWMs or whatever that either should come via
> > lookup tables or corresponding firmware interface.
> >
> 
> May I ask why? I've read commit descriptions for drivers/base/swnode.c
> and the discussion on lkml and I understand software nodes as a way to
> provide (synthesize) a description for a device that is missing a
> description in the firmware. Another use case seems to be to replace (in
> the long run) platform data. That is what I am trying to use it for.
> 
> I want my device to be configured with either DT or software_nodes
> created at run time with configfs. My device is going to use GPIOs
> described in the DT and it is going to be configured via configfs at run
> time. I could use platform_data to pass structures from configfs but
> software nodes would let me save some code in the device driver and use
> the same paths for both static (DT) and dynamic (configfs)
> configuration.
> 
> Probably I have missed something and I will be greatful, if you tell me
> where I can find more information about software nodes. There are few
> users in the kernel and it isn't obvious for me how to use software
> nodes properly.

Yeah, I disagree with Andy here. The lookup tables are a crutch that we
have until GPIO and PWM a taught to support software nodes (I need to
resurrect my patch series for GPIO, if you have time to test that would
be awesome).

Thanks.

-- 
Dmitry
