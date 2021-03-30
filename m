Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0410634EDC1
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 18:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhC3Q1Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 12:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhC3Q04 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2021 12:26:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D196C061762
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2021 09:26:56 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id w8so18058304ybt.3
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2021 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E84xiuP96qdI7CJTKEoKUbx5Tud8k1cz/vlbjHEw4u0=;
        b=NhyyBx3rsxS/8TIMF2Ga2ndhdkfALclaVvdMgUn9VzeEDA9vjUxsU0hrmepA76TfLt
         u0X4694RTY7cucG2E7Ff8cg8WyEZtc72CatSnkWj4BIkSv+WQ56l3wybCFVpC7oO8/aY
         n7JuOd68AJouHOTeOvP+UeSvFZ0DzJGOerJU8QYdsQ3N1WYHN/oNfRba5OmHqlCHvH3X
         O+u1FJyU6EET1HxP051/l4PrUVO0W7xz7dyvd7Eu54lhSOAPhAsK3Kb11A1ssyc9J65P
         MH/b7aHeZJaLunKWbnTsmaRedKpwTDaFc9GgNUVHXYtTbKTaLcBqisSEGID/TuBZAjHG
         wbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E84xiuP96qdI7CJTKEoKUbx5Tud8k1cz/vlbjHEw4u0=;
        b=ORqvSGe4FuIovh1nVWpaMDSkcDR9EJO/H+CQNZzA/z/YmwJLk2bE0+uaLQtn+bExga
         ZkLRo6OGFSD3u6xUP9zW+4nRSTgMg0j5em42rjsuwlF64CvkvSAwEA8IeX5X5e4IW9FR
         3H1p2BF0tWTCspryW43FXoEMLFIxg9CZUp3PxzcIU0kPFpUTr542uh6gissP+6bp243t
         S0S6In7xMGiWZ5QPri/zJPLeo2AkzPIJ07w/EjgzL5P0BofP0nb7RWhPGUiBoxRGhitq
         MknK4z+i0U78MglD6qW/iulzkTZUarqJqdyJC/d3csYXlfMReSUA88z2LM2aQW1BmoGE
         EPAQ==
X-Gm-Message-State: AOAM5304sjkPkgwWVbFVqkk98wMECAIP7f1zGkL9/yohVcFJXlKZpOhg
        ApXGCzm/bIFh9z+7GonN/2c0xurKVgqYgI2v1CMcLA==
X-Google-Smtp-Source: ABdhPJzRju2GzsjyNoiA4fXciYHN4xAXYF+zjvtaWtSDSt0ofrTYQWng9+AP3dlitSrOgxr9jUO9qbtBbt2EI9ZSqHM=
X-Received: by 2002:a25:d3cf:: with SMTP id e198mr45556943ybf.228.1617121615342;
 Tue, 30 Mar 2021 09:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210205222644.2357303-9-saravanak@google.com>
 <20210210114435.122242-1-tudor.ambarus@microchip.com> <20210330154222.GA5411@roeck-us.net>
In-Reply-To: <20210330154222.GA5411@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Mar 2021 09:26:19 -0700
Message-ID: <CAGETcx_k2dAHRWn4914s32KSdJ=WLDe6DeD50V2kvR+2dUPrMw@mail.gmail.com>
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Brown, Len" <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 30, 2021 at 8:42 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Feb 10, 2021 at 01:44:34PM +0200, Tudor Ambarus wrote:
> > This is a follow-up for:
> > commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> >
> > The above commit updated the deprecated of_clk_add_provider(),
> > but missed to update the preferred of_clk_add_hw_provider().
> > Update it now.
> >
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > Reviewed-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/clk/clk.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 27ff90eacb1f..9370e4dfecae 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -4594,6 +4594,8 @@ int of_clk_add_hw_provider(struct device_node *np,
> >       if (ret < 0)
> >               of_clk_del_provider(np);
> >
> > +     fwnode_dev_initialized(&np->fwnode, true);
> > +
>
> This causes a crash when booting raspi2 images in qemu.
>
> [   22.123618] Unable to handle kernel NULL pointer dereference at virtual address 00000028
> [   22.123830] pgd = (ptrval)
> [   22.123992] [00000028] *pgd=00000000
> [   22.124579] Internal error: Oops: 5 [#1] SMP ARM
> ...
> [   22.141624] [<c0a2f4d8>] (of_clk_add_hw_provider) from [<c0a2f54c>] (devm_of_clk_add_hw_provider+0x48/0x80)
> [   22.141819] [<c0a2f54c>] (devm_of_clk_add_hw_provider) from [<c0a43ad8>] (raspberrypi_clk_probe+0x25c/0x384)
> [   22.141976] [<c0a43ad8>] (raspberrypi_clk_probe) from [<c0c18da0>] (platform_probe+0x5c/0xb8)
> [   22.142114] [<c0c18da0>] (platform_probe) from [<c0c16654>] (really_probe+0xf0/0x39c)
> [   22.142246] [<c0c16654>] (really_probe) from [<c0c16968>] (driver_probe_device+0x68/0xc0)
> [   22.142377] [<c0c16968>] (driver_probe_device) from [<c0c14834>] (bus_for_each_drv+0x84/0xc8)...
>
> np can (and will) be NULL here. See of_clk_set_defaults().

Thanks for the report. It was reported earlier by Marek and there's a
discussion going on about it in the thread.

-Saravana
