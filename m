Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0CC421B42
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 02:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhJEAmi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Oct 2021 20:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhJEAmb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Oct 2021 20:42:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC49C061760;
        Mon,  4 Oct 2021 17:40:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w11so1065630plz.13;
        Mon, 04 Oct 2021 17:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tKgqXXG73CzULsxyKb5wq0Cn+T+h97sDk9iXBCRPZGU=;
        b=To4755TxZIUEHC3QpxDsJtv0JuyIZtkNf6t9E6FqTy7RHVdYsc400NBaAsmQLGPese
         KLEFIWSQt7r0oHPTljaOvbFuDJZ+d4b9HAek6gBMT8pvUPCBypUfxcIfblU7DRHUpBwe
         HM/866OA/N6FijvEpZT2FyAZB8X06fHh+1FMoJp2ZLMeWUBuOzxMHrScgPKPy2KrCD0J
         0RhRggRhRnVs8NsLQT6SKuOVW2Brrk57iiDGf4phvIfAvAaWePUpppqjY+TL642aiSjs
         9COl0LeBBZKe+z1piEu5LcqqsFnoafkd009cTTqRRAY220x7kC2DKz6hsCnYp7BoFJzv
         gm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKgqXXG73CzULsxyKb5wq0Cn+T+h97sDk9iXBCRPZGU=;
        b=DV8O3XbNtSDcfER3P0QGbM1Jm3s3uwvpUZSl1qjyyNbWrnC3NOnYWjM85SNi6hfKtB
         /gxeLHulEz996lW1mNvshhQ4Kcu9k7gcHDp/a4fV+7T1NCxTYMDB7uEQDku+nOotT5Xf
         RDLfGkfj4pAyHhVtMEPfn9qZqlNG4JMvY66oooW7TlEdM8mwUneOQ2KYNR304liZMmCy
         vwq1Dwf1tlUlyFGN3xV8eKdU1eYgRhThuByd6GA5NT2/W4Sra/NZiMDbqr08RNazLeuJ
         aOtjkOVPRsAGWT/u4ET9ICn8yH/9xmhs0Or7ezuEN79DnqGZ+PfUcLZ4Kl4W4ozyM3ZL
         hbGw==
X-Gm-Message-State: AOAM531/ch6HS8lNzvGxsUInIA5y8s2NUMox36g60VhMAOxRnO2HIyGY
        SnHI8bHC+sE2C8ZXMm7G6D8=
X-Google-Smtp-Source: ABdhPJw+/Ha2IWwXKOXOlwgAEhEbGLJmfEw0ATCQY0Kqcv+J+46O6xh8FuJwQd4g+wdNwbiCtnRs2Q==
X-Received: by 2002:a17:90b:33c8:: with SMTP id lk8mr200733pjb.208.1633394441402;
        Mon, 04 Oct 2021 17:40:41 -0700 (PDT)
Received: from sol (106-69-170-56.dyn.iinet.net.au. [106.69.170.56])
        by smtp.gmail.com with ESMTPSA id d9sm15095560pgn.64.2021.10.04.17.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:40:40 -0700 (PDT)
Date:   Tue, 5 Oct 2021 08:40:35 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <20211005004035.GA29779@sol>
References: <20211004093416.GA2513199@sol>
 <YVrM8VdLKZUt0i8R@kroah.com>
 <20211004121942.GA3343713@sol>
 <YVrz86m3+7wDSYlh@kuha.fi.intel.com>
 <20211004124701.GA3418302@sol>
 <YVr/t7AbmP/h08GX@kuha.fi.intel.com>
 <20211004141754.GA3510607@sol>
 <20211004152844.GA3825382@sol>
 <CAHp75VeBc3AN+5f680LeK8V6NpiiaPUTgE14FFonUM1W-xrjNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeBc3AN+5f680LeK8V6NpiiaPUTgE14FFonUM1W-xrjNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 04, 2021 at 10:56:00PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 4, 2021 at 8:51 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Mon, Oct 04, 2021 at 10:17:54PM +0800, Kent Gibson wrote:
> > > On Mon, Oct 04, 2021 at 04:20:55PM +0300, Heikki Krogerus wrote:
> > > > On Mon, Oct 04, 2021 at 08:47:01PM +0800, Kent Gibson wrote:
> > > > > On Mon, Oct 04, 2021 at 03:30:43PM +0300, Heikki Krogerus wrote:
> > > > > > On Mon, Oct 04, 2021 at 08:19:42PM +0800, Kent Gibson wrote:
> > > > > > > On Mon, Oct 04, 2021 at 11:44:17AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > On Mon, Oct 04, 2021 at 05:34:16PM +0800, Kent Gibson wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> >
> > [snip]
> >
> > > > > Looking at the offending patch, it effectively replaces a call to
> > > > > device_add_properties() with one to
> > > > > device_create_managed_software_node(), and those two functions appear
> > > > > quite different - at least at first glance.
> > > > > Is that correct?
> > > >
> > > > The only real difference between the two functions is that
> > > > device_create_managed_software_node() marks the software node it
> > > > creates (and it does it exactly the same way as
> > > > device_add_properties()) as "managed" with a specific flag.
> > > >
> > >
> >
> > That managed flag makes all the difference.
> >
> > I've tried to find a fix along the same lines as Laurentiu Tudor's
> > 5aeb05b27f8 software node: balance refcount for managed software nodes
> > but haven't found anything that works.
> >
> > What does work for me is to revert the call to
> > device_create_managed_software_node() to a call to
> > device_add_properties():
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 652531f67135..2f30bdb94fab 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -826,8 +826,7 @@ struct platform_device *platform_device_register_full(
> >                 goto err;
> >
> >         if (pdevinfo->properties) {
> > -               ret = device_create_managed_software_node(&pdev->dev,
> > -                                                         pdevinfo->properties, NULL);
> > +               ret = device_add_properties(&pdev->dev, pdevinfo->properties);
> >                 if (ret)
> >                         goto err;
> >         }
> >
> > That obviously wont work with your latest series that removes
> > device_add_properties(), but that is the simplest, and only, solution
> > that I've found so far.
> 
> Here is debug prints of what happens
> 
> # modprobe gpio-mockup gpio_mockup_ranges=-1,10
> [  212.850993]  (null): device_create_managed_software_node <<< 0
> [  212.858177] platform gpio-mockup.0: software_node_notify 0 <<<
> [  212.865264] platform gpio-mockup.0: software_node_notify 1 <<< 1
> [  212.874159] gpio-mockup gpio-mockup.0: no of_node; not parsing pinctrl DT
> [  212.882962] gpiochip_find_base: found new base at 840
> [  212.889873] gpio gpiochip3: software_node_notify 0 <<<
> [  212.896164] gpio gpiochip3: software_node_notify 1 <<< 1
> [  212.905099] gpio gpiochip3: (gpio-mockup-A): added GPIO chardev (254:3)
> [  212.913313] gpio gpiochip840: software_node_notify 0 <<<
> [  212.920676] gpio gpiochip3: registered GPIOs 840 to 849 on gpio-mockup-A
> [  212.935601] modprobe (185) used greatest stack depth: 12744 bytes left
> 
> As I read it the software node is created for gpio-mockup device and
> then _shared_ with the GPIO device, since it's managed it's gone when
> GPIO device gone followed by UAF when mockup (platform) device itself
> gone. I.o.w. this software node mustn't be managed because it covers
> the lifetime of two different objects. The correct fix is to create
> manually software node and assign it to the pdev and manually free in
> gpio_mockup_unregister_pdevs()/
> 
> Tl;DR: it's a bug in gpio-mockup.
> 

So the bug is in the behaviour of gpio_mockup_register_chip()?
That is out of my court, so I'll leave it to you and Bart to sort out.

Cheers,
Kent.
