Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD72E6C96
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgL1XsJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 18:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgL1XsJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 18:48:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36140C0613D6;
        Mon, 28 Dec 2020 15:47:29 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e2so8229634pgi.5;
        Mon, 28 Dec 2020 15:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9PxOAS2DmrspCrz1Cyvj65Rb5q+CF7ttmZsI+IxekQ=;
        b=p1/ggYh+XBo6E6oqdFhDRpK3Wl7SW7b/5Zo+EUFPjqdVvXarPF6hFKXlbYLPvuAX8s
         5UqRVhrnYnRj0KxsXYMvP/NRe6Uoluir1l9FppzpouKgPVQh5DaKs/G2JBxY7YKzPX47
         odeKCbZ7JqtlVrArTyHqZEATiKBZh5ukkc2AgxTyFetrZ95SrQLKHDj5/td0S47G9O5l
         8FoVoKKgkkVIlo2x48mAM3t+SsZD96zYaHOlM1hyqtzhzJHGXzMWp9cz44wxabDznx5D
         qWm7LBgBvsxv9y4wrEoHC0KOGJhrT4ZCZHf0tQ102i3wRS+Q1PahsD/DYf7x/+CC6Wt+
         +eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9PxOAS2DmrspCrz1Cyvj65Rb5q+CF7ttmZsI+IxekQ=;
        b=Pclzr32whY3tNxC7RexM7qmvjbjFQeMXiUUOtEEEgqL5794jgg7vIyfsMhveJ8uRNl
         ByCWeMdyBsLWVC1sjyHEHLYz3X9iMuxBSCwG2Fo2gzKASyAoS53aeBtfJDgpcWoGd617
         3iMzEA+wvX/meF3TnJgZwWkuIHB71c1uiDMlzo3NCa9z7qDI79eoA2RWR901zbjqoaua
         TpE/ipUsD+KZHhkk3QZyt5VaegAF7ST/perlOsDhGylL0LrhQgnXXj8Uqe7G0M2CJkpn
         oTJF2GlOka/H3b1IITvdYKTWIzRU0GVTGni0REApS6NJcawHUTTxMx0R6o8aaJ3Bm+lP
         bFoQ==
X-Gm-Message-State: AOAM5312cJ3UkRC8cCflIkhtQhMbJxrZQpFLHEeEwUNqwOG3dmqclvNR
        YL/ECERKdN8xzCyLrow7fNkU4R1ohhypilEFE64=
X-Google-Smtp-Source: ABdhPJwKZSy88Kpgg3DxCCmB4FZY8GeeG1TnB+uTmT4vDDeMxoIhwibr7vDIVsaZhh8YzlAnYwWorLr6xdU5gb5gadE=
X-Received: by 2002:a63:74b:: with SMTP id 72mr45667221pgh.4.1609199248618;
 Mon, 28 Dec 2020 15:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20201224010907.263125-1-djrscally@gmail.com> <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
 <20201228170521.GZ26370@paasikivi.fi.intel.com> <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
 <20201228225544.GH4077@smile.fi.intel.com> <1b6ffc66-d16e-8ab4-64c8-b92bfac557f0@gmail.com>
In-Reply-To: <1b6ffc66-d16e-8ab4-64c8-b92bfac557f0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Dec 2020 01:47:12 +0200
Message-ID: <CAHp75VeCbmUXagxwfn55tqicJoWqdHjN8_sirBtBbxueCV88Pw@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 29, 2020 at 1:30 AM Daniel Scally <djrscally@gmail.com> wrote:
>
> Hi Andy
>
> On 28/12/2020 22:55, Andy Shevchenko wrote:
> > On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
> >> On 28/12/2020 17:05, Sakari Ailus wrote:
> >>> On Thu, Dec 24, 2020 at 02:54:44PM +0200, Andy Shevchenko wrote:
> > ...
> >
> >>>>> +#include <linux/property.h>
> >>>>> +
> >>>>> +#define CIO2_HID                               "INT343E"
> >>>>> +#define CIO2_NUM_PORTS                         4
> >>> This is already defined in ipu3-cio2.h. Could you include that instead?
> >> Yes; but I'd need to also include media/v4l2-device.h and
> >> media/videobuf2-dma-sg.h (they're included in ipu3-cio2-main.c at the
> >> moment). It didn't seem worth it; but I can move those two includes from
> >> the .c to the .h and then include ipu3-cio2.h in cio2-bridge.h
> >>
> >> Which do you prefer?

> > I think here should be a
> > compromise variant, split out something like ipu3-cio2-defs.h which can be
> > included in both ipu3-cio2.h and cio2-bridge.h.
>
> And just including all the things that need to be in both files you mean?

Something which may be logically grouped together. It may include
something which cio2-bridge doesn't need, but at least it will be in
one place (for example, if you move one CIO2_PCI_* constant, that
means you better move all, or so, the rest CIO2_PCI_* constants as
well).


-- 
With Best Regards,
Andy Shevchenko
