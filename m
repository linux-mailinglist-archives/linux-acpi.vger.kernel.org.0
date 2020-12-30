Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE192E7C4E
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Dec 2020 21:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL3Ust (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Dec 2020 15:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3Ust (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2020 15:48:49 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F28C061573;
        Wed, 30 Dec 2020 12:48:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id h10so9295795pfo.9;
        Wed, 30 Dec 2020 12:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRVdipqMo3SGkScdVCSY0NCVDydJxCZXUp0vL0ss0j8=;
        b=Ex8hVNUWqY+rbyZwRHu0Z8ZFDWv3n6GCNQ6/oKC9ORvHkbkiVNGzdB91SjAk392fsg
         s3ED8sOmsckgJOxTaNfYxosbDaaMTahyn8teOd4ojTAUMBd0JUPKX5HzCwG4Hhbis73B
         uRuMcfr3NQT5ekO4VMFxihb+mdcnRnFki6aY9LJt3PYKLZkgwrGw4VeNdH9ioFHjsks1
         vbOzj6pKww4PqUZL4f29Bi4HnqOfCxVzr4w0ISFjRmcq4dfx2pLhCVAB43Q8usle0KNN
         XoU1DpgnpDL8QwmG6+owvGJ/TZUxTIGNNavC1HalaTQByK0CRPAB+fhq7VP0yAqWMm5L
         wt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRVdipqMo3SGkScdVCSY0NCVDydJxCZXUp0vL0ss0j8=;
        b=EvKOt2D2oKqHTPO5ECfCGDcGPZ/Mbx08uNO1GIA/DrfNwAMXzjq1gjhaz7jsMzcrDb
         WcOjDyFGLUj3FbBeEHViVCpxk32HKfZeoqVcJ7eAGlBDqfBFxh1Ee55QOyeTfJrrH79T
         51ibimUaLZuv9ZtE6/AIIOT7kyXfr/iW1Tti6s8DTecrnbHjHiJP+rUL2axyGHbbL4xb
         6ib/1VVZOcgq/eI6HmOhtOgS+pdi4HB0F6b5b+umvKghnxsnWYyeMyEuYa6cqsY3rcH5
         A1ZNW/TwuLOkvwvRk1HNboy2XIyBcy0JwKFcKr6PZtM0A3Mq7Jo0eAdj2fsAKXswx66Y
         ypxA==
X-Gm-Message-State: AOAM531K/Ev6mIXZCkokCn4f4uqC4EiEjFgnlJNiq9kNNkx1sBUOrr0C
        0fVAuJzt3YkLKoEwLhzJ62RQL9cXZsTi/XqjnroaXIlKC6/9wA==
X-Google-Smtp-Source: ABdhPJxSMf4/TA4B3IeFbMjgSsLR1NtTgwkka1CnQ1qojXL0WNjbTMpocAhYi5Qhs2jjwKkiX06W8HtrgHf96sok07s=
X-Received: by 2002:a63:c04b:: with SMTP id z11mr53914993pgi.74.1609361287808;
 Wed, 30 Dec 2020 12:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20201224010907.263125-1-djrscally@gmail.com> <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
 <20201228170521.GZ26370@paasikivi.fi.intel.com> <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
 <20201228225544.GH4077@smile.fi.intel.com> <X+plTyUFhfHi7eIE@pendragon.ideasonboard.com>
 <CAHp75Vdzk7i+QzkTxLJUUkw3xZot9F7QT8pyu6b5yjkCVzMXEA@mail.gmail.com> <X+pzKDNWpiQWenHy@pendragon.ideasonboard.com>
In-Reply-To: <X+pzKDNWpiQWenHy@pendragon.ideasonboard.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Dec 2020 22:47:51 +0200
Message-ID: <CAHp75Vf18sse_QQGSy+E2qK-N_B=ky83x36HiNfmUKmya_CS9Q@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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
        Jordan Hand <jorhand@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 29, 2020 at 2:07 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, Dec 29, 2020 at 01:54:59AM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 29, 2020 at 1:08 AM Laurent Pinchart wrote:

...

> > +#include <linux/videodev2.h>
>
> I think this can be dropped.

I dropped above (I noticed it's included by a half of the headers listed below.

> > +#include <media/media-device.h>
> > +#include <media/media-entity.h>
> > +#include <media/v4l2-async.h>
> > +#include <media/v4l2-dev.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-subdev.h>
> > +#include <media/videobuf2-core.h>
> > +#include <media/videobuf2-v4l2.h>

...

> How about grouping all forward declarations at the top ?

Done.

> Otherwise this looks good,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!
I just sent a formal patch with your tag included.

-- 
With Best Regards,
Andy Shevchenko
