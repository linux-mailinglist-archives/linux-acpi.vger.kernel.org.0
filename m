Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8242E6B3E
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgL1XAV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 18:00:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:26745 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731775AbgL1W4W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Dec 2020 17:56:22 -0500
IronPort-SDR: CibDkYV6HPQ8IvcRrUfyqyR2b7Rv+OiZBORwJ6Rgs7MkcpdOYEPqiy3dYyPZNKO+S9OPK3Tfv+
 4U1D0Ns/qdjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="176529384"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="176529384"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 14:55:41 -0800
IronPort-SDR: RDA/+I/5GKfDFCkIf6tVgGIakOFgulH3t0Bbr6Yuf4NZbXXydFd6LHfppPZxTVQ6QxynaeSWuG
 XYBcblFDj7aA==
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="562962395"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 14:55:34 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1ku1RL-000Iqk-5E; Tue, 29 Dec 2020 00:56:35 +0200
Date:   Tue, 29 Dec 2020 00:56:35 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
Message-ID: <20201228225635.GI4077@smile.fi.intel.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
 <20201228170521.GZ26370@paasikivi.fi.intel.com>
 <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
 <20201228225544.GH4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228225544.GH4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 29, 2020 at 12:55:45AM +0200, Andy Shevchenko wrote:
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
> immediately noticed when scrolled over data types). I think here should be a
> compromise variant, split out something like ipu3-cio2-defs.h which can be

Seems like cio2-defs.h more plausible name.

> included in both ipu3-cio2.h and cio2-bridge.h.
> 
> And cio2-bridge.h needs more inclusions like types.h.

-- 
With Best Regards,
Andy Shevchenko


