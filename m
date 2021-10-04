Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B34212A8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Oct 2021 17:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhJDPal (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Oct 2021 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbhJDPak (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Oct 2021 11:30:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC9C061746;
        Mon,  4 Oct 2021 08:28:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so226746pjb.3;
        Mon, 04 Oct 2021 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tAWxpwl8doA0MMBNMY6fAunhMduG3WDPici+oeYzeOg=;
        b=k3h6Yt6kJllNxWx4Ua7SlpDwoN4iNNDUJOCbBqOw3/ylPLnJkFD0ev/KHCfbLX2FPW
         WDp8POMCKLwIxwzB50y5afICh4h1KA9ZZCW0+IaTltaAN0ItGuzNLPn882P4R5pUVN9O
         DZ4eHW3jsfBlDNynjq0+ZdSSMzy1nkxcL6yHRCiARRpzPeJMMb45wnDmFHuXaVTq6Wq/
         Ydy1pVQHuIGbovpUqlxqED5v/cEnYrBAhGEUHEbpmjyUQDUlVJRlsEDrBAzLYxjNH/Be
         96aap1eCmIv7IZCgqTWhH7FOJEhzGgwzz0+yKs3tnzuxoNU+0qX+QpgBHXKUAKg8taHG
         +1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tAWxpwl8doA0MMBNMY6fAunhMduG3WDPici+oeYzeOg=;
        b=Tyc6CGQWOK19NJGQKCU28TYPMzsHsiyvPLIeNxvcbRb7IrdeYv7eoQ4oNka6gxKRa2
         Y/yCdpjbSjfSL6NWikH8VA2uWTSvc/KOo8Re4nJqIRzC32LzPb06XosOW21dYYkY6M1y
         3PTP/YcCA/IJi3GqG7xywTIEyvE3aZD32Vwn7p/AOnsij5qQhu7z/VqFaxRGGf7p146V
         i6fUV1BMksOCkMtvR4r1cGDmvcpyYkXUOx9JBdFPU1WNgoq3hOUu0+EhzgyZtpG2WeWm
         ql/f89QRuQ4tmdb+eveGXQOZMyKRHUPFdobV+Fry0jZoq8ZhuYKeYzllcPtdD1jG6kGB
         BSxQ==
X-Gm-Message-State: AOAM530+J7u3o7zAs0MRhLdMxQGjuIJ6FY53zy9ah/y/qmfgYm8wz0b1
        jx3yljhDA/Xmy38Gs4gxGaw=
X-Google-Smtp-Source: ABdhPJzGNn2R0Ay4+On1xJhEeoNC3fTqEowaY5B+M+FEJ8CjEXgVHx1q7PF5Nv32i3y+BtX/7m1kcQ==
X-Received: by 2002:a17:902:bf0a:b0:13d:f4b8:111 with SMTP id bi10-20020a170902bf0a00b0013df4b80111mr271185plb.35.1633361330474;
        Mon, 04 Oct 2021 08:28:50 -0700 (PDT)
Received: from sol (106-69-170-56.dyn.iinet.net.au. [106.69.170.56])
        by smtp.gmail.com with ESMTPSA id f20sm8669029pga.12.2021.10.04.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:28:49 -0700 (PDT)
Date:   Mon, 4 Oct 2021 23:28:44 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <20211004152844.GA3825382@sol>
References: <20211004093416.GA2513199@sol>
 <YVrM8VdLKZUt0i8R@kroah.com>
 <20211004121942.GA3343713@sol>
 <YVrz86m3+7wDSYlh@kuha.fi.intel.com>
 <20211004124701.GA3418302@sol>
 <YVr/t7AbmP/h08GX@kuha.fi.intel.com>
 <20211004141754.GA3510607@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004141754.GA3510607@sol>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 04, 2021 at 10:17:54PM +0800, Kent Gibson wrote:
> On Mon, Oct 04, 2021 at 04:20:55PM +0300, Heikki Krogerus wrote:
> > On Mon, Oct 04, 2021 at 08:47:01PM +0800, Kent Gibson wrote:
> > > On Mon, Oct 04, 2021 at 03:30:43PM +0300, Heikki Krogerus wrote:
> > > > On Mon, Oct 04, 2021 at 08:19:42PM +0800, Kent Gibson wrote:
> > > > > On Mon, Oct 04, 2021 at 11:44:17AM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Mon, Oct 04, 2021 at 05:34:16PM +0800, Kent Gibson wrote:
> > > > > > > Hi,
> > > > > > > 

[snip]

> > > Looking at the offending patch, it effectively replaces a call to
> > > device_add_properties() with one to
> > > device_create_managed_software_node(), and those two functions appear
> > > quite different - at least at first glance.
> > > Is that correct?
> > 
> > The only real difference between the two functions is that
> > device_create_managed_software_node() marks the software node it
> > creates (and it does it exactly the same way as
> > device_add_properties()) as "managed" with a specific flag.
> > 
> 

That managed flag makes all the difference.

I've tried to find a fix along the same lines as Laurentiu Tudor's
5aeb05b27f8 software node: balance refcount for managed software nodes
but haven't found anything that works.

What does work for me is to revert the call to
device_create_managed_software_node() to a call to
device_add_properties():

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 652531f67135..2f30bdb94fab 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -826,8 +826,7 @@ struct platform_device *platform_device_register_full(
                goto err;

        if (pdevinfo->properties) {
-               ret = device_create_managed_software_node(&pdev->dev,
-                                                         pdevinfo->properties, NULL);
+               ret = device_add_properties(&pdev->dev, pdevinfo->properties);
                if (ret)
                        goto err;
        }

That obviously wont work with your latest series that removes
device_add_properties(), but that is the simplest, and only, solution
that I've found so far.

Cheers,
Kent.
