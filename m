Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C2421806
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Oct 2021 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhJDT63 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Oct 2021 15:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhJDT62 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Oct 2021 15:58:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0660BC061745;
        Mon,  4 Oct 2021 12:56:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b8so34805876edk.2;
        Mon, 04 Oct 2021 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCCDh+U1zrUHq6glv/Bdn6xFc5vH12HjK2xn4fS1O/A=;
        b=nW8qksxCsT7x0jA3ogbSmWySg2PCKkcHMmN7GA+bVrijSIWbEAprO5Qs9NpstJtRC5
         V8KbtPuiXeUYat9UexziOxpk40/EkLP0GDl68bJ1BKJLcR7raqe4FvxP6r6vTPiQSO7o
         x6kSvtBerK4EgmbL9ICeNIUbkABQdscEvAQEFAA9URx/LB1X2nbePxgrdNnlB4y8lwQ+
         1vJ666b1e+VoeCl1/2cnbs8RH/+jDyQe6xicoKIeC3+HFS8GBjFL9qdfjxHrtBLG3mLs
         QaOiNspyu+FXXMYPZ5h+1+MJejoSFEi11A/HQs75FYPnpxVaPdGrWX9ppxcMEYs054e6
         2vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCCDh+U1zrUHq6glv/Bdn6xFc5vH12HjK2xn4fS1O/A=;
        b=6pvxsrjQrqYgD7KocC6ujy89s6JpQcTdC76n3zFQF513uUNTgbXrmr7Yrgb69UUSwx
         o+eNjGTGddhR/5FxkDvIAHWT4JkkkD2XdNfA1gG04R59d5JHcn7jgGKsKESCE0/e4+kw
         1o/3W2WAKvwB6C+8eBwRHmRDayalOa5WoGvwgqAfFKCXmWiAPf9x1kqlCnc2xLKp4cLx
         NWS5cbXbHtJsNLbsnwex3n5GrI99EqmamxRw78QuwbAll2fyfQ7pmrYIBpYlm8hBzmSQ
         Nf1Z4yT7b4dD3/4Qwkt7qmCC0Y9a79egeqlu7ekqalONuvVAM2tUZHvyrQIuoJNXy/B4
         Q3nQ==
X-Gm-Message-State: AOAM530l0o4voutzHzcauZe6ORgc6ni30S3Z0MjIgmFCbWBDHkeAcZUX
        MJ/rc2nhzWpAl2ZXUgtZYSzKG6BkY1wdvd1lQvw=
X-Google-Smtp-Source: ABdhPJxmkoLW2xwyhUzs7C1ISM3doFFwcVTDdp2aV657anr3G376mIdSqsWOpL6/Pz7P70dAXwqo26O+JwbYEz31H6s=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr19538323ejc.69.1633377397338;
 Mon, 04 Oct 2021 12:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211004093416.GA2513199@sol> <YVrM8VdLKZUt0i8R@kroah.com>
 <20211004121942.GA3343713@sol> <YVrz86m3+7wDSYlh@kuha.fi.intel.com>
 <20211004124701.GA3418302@sol> <YVr/t7AbmP/h08GX@kuha.fi.intel.com>
 <20211004141754.GA3510607@sol> <20211004152844.GA3825382@sol>
In-Reply-To: <20211004152844.GA3825382@sol>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Oct 2021 22:56:00 +0300
Message-ID: <CAHp75VeBc3AN+5f680LeK8V6NpiiaPUTgE14FFonUM1W-xrjNA@mail.gmail.com>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 4, 2021 at 8:51 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Mon, Oct 04, 2021 at 10:17:54PM +0800, Kent Gibson wrote:
> > On Mon, Oct 04, 2021 at 04:20:55PM +0300, Heikki Krogerus wrote:
> > > On Mon, Oct 04, 2021 at 08:47:01PM +0800, Kent Gibson wrote:
> > > > On Mon, Oct 04, 2021 at 03:30:43PM +0300, Heikki Krogerus wrote:
> > > > > On Mon, Oct 04, 2021 at 08:19:42PM +0800, Kent Gibson wrote:
> > > > > > On Mon, Oct 04, 2021 at 11:44:17AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Mon, Oct 04, 2021 at 05:34:16PM +0800, Kent Gibson wrote:
> > > > > > > > Hi,
> > > > > > > >
>
> [snip]
>
> > > > Looking at the offending patch, it effectively replaces a call to
> > > > device_add_properties() with one to
> > > > device_create_managed_software_node(), and those two functions appear
> > > > quite different - at least at first glance.
> > > > Is that correct?
> > >
> > > The only real difference between the two functions is that
> > > device_create_managed_software_node() marks the software node it
> > > creates (and it does it exactly the same way as
> > > device_add_properties()) as "managed" with a specific flag.
> > >
> >
>
> That managed flag makes all the difference.
>
> I've tried to find a fix along the same lines as Laurentiu Tudor's
> 5aeb05b27f8 software node: balance refcount for managed software nodes
> but haven't found anything that works.
>
> What does work for me is to revert the call to
> device_create_managed_software_node() to a call to
> device_add_properties():
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 652531f67135..2f30bdb94fab 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -826,8 +826,7 @@ struct platform_device *platform_device_register_full(
>                 goto err;
>
>         if (pdevinfo->properties) {
> -               ret = device_create_managed_software_node(&pdev->dev,
> -                                                         pdevinfo->properties, NULL);
> +               ret = device_add_properties(&pdev->dev, pdevinfo->properties);
>                 if (ret)
>                         goto err;
>         }
>
> That obviously wont work with your latest series that removes
> device_add_properties(), but that is the simplest, and only, solution
> that I've found so far.

Here is debug prints of what happens

# modprobe gpio-mockup gpio_mockup_ranges=-1,10
[  212.850993]  (null): device_create_managed_software_node <<< 0
[  212.858177] platform gpio-mockup.0: software_node_notify 0 <<<
[  212.865264] platform gpio-mockup.0: software_node_notify 1 <<< 1
[  212.874159] gpio-mockup gpio-mockup.0: no of_node; not parsing pinctrl DT
[  212.882962] gpiochip_find_base: found new base at 840
[  212.889873] gpio gpiochip3: software_node_notify 0 <<<
[  212.896164] gpio gpiochip3: software_node_notify 1 <<< 1
[  212.905099] gpio gpiochip3: (gpio-mockup-A): added GPIO chardev (254:3)
[  212.913313] gpio gpiochip840: software_node_notify 0 <<<
[  212.920676] gpio gpiochip3: registered GPIOs 840 to 849 on gpio-mockup-A
[  212.935601] modprobe (185) used greatest stack depth: 12744 bytes left

As I read it the software node is created for gpio-mockup device and
then _shared_ with the GPIO device, since it's managed it's gone when
GPIO device gone followed by UAF when mockup (platform) device itself
gone. I.o.w. this software node mustn't be managed because it covers
the lifetime of two different objects. The correct fix is to create
manually software node and assign it to the pdev and manually free in
gpio_mockup_unregister_pdevs()/

Tl;DR: it's a bug in gpio-mockup.


-- 
With Best Regards,
Andy Shevchenko
