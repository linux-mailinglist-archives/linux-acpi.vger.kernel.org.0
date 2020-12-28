Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1E2E6B74
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgL1XI7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 18:08:59 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44536 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgL1XI4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 18:08:56 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 294F23E;
        Tue, 29 Dec 2020 00:08:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1609196890;
        bh=mB5ce02/kggJtcT6vhpDUNFdXXr9q+/WEv+XXlNQq74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4akwS4Igz+Bl+QldrRBKC0Ma5OLn8Xf+P4gQLIr58DO+D7jt/9Mi9IIkJHkt1Wmb
         DZJgR2n4toeSLgHZiibW1D1htMtMXko5RSyr+r0XrKgKyU17sEEj/Xyj5RKYJKsWuC
         cceBaSmnOQ/h8Jmh1QfjJgjrImAdyVRlOe3ZUFu0=
Date:   Tue, 29 Dec 2020 01:07:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
Message-ID: <X+plTyUFhfHi7eIE@pendragon.ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
 <20201228170521.GZ26370@paasikivi.fi.intel.com>
 <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
 <20201228225544.GH4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201228225544.GH4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 29, 2020 at 12:55:44AM +0200, Andy Shevchenko wrote:
> On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
> > On 28/12/2020 17:05, Sakari Ailus wrote:
> > > On Thu, Dec 24, 2020 at 02:54:44PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > >>> +#include <linux/property.h>
> > >>> +
> > >>> +#define CIO2_HID                               "INT343E"
> > >>> +#define CIO2_NUM_PORTS                         4
> > > 
> > > This is already defined in ipu3-cio2.h. Could you include that instead?
> > 
> > Yes; but I'd need to also include media/v4l2-device.h and
> > media/videobuf2-dma-sg.h (they're included in ipu3-cio2-main.c at the
> > moment). It didn't seem worth it; but I can move those two includes from
> > the .c to the .h and then include ipu3-cio2.h in cio2-bridge.h
> > 
> > Which do you prefer?
> 
> Actually ipu3-cio2.h misses a lot of inclusions (like mutex.h which I
> immediately noticed when scrolled over data types).

Then ipu3-cio2.h should be fixed :-)

> I think here should be a compromise variant, split out something like
> ipu3-cio2-defs.h which can be included in both ipu3-cio2.h and
> cio2-bridge.h.
> 
> And cio2-bridge.h needs more inclusions like types.h.

-- 
Regards,

Laurent Pinchart
