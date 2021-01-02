Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9858D2E8814
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Jan 2021 18:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhABRJZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 Jan 2021 12:09:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:47109 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbhABRJZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 2 Jan 2021 12:09:25 -0500
IronPort-SDR: MoabWB71FKseD7fb+AdSUrQypGT5w9oJS1Wy2UwFW8Muk1cyFxbesU9x1q6ZWV904Aj+QmJzX0
 kSLzFC3qToGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9852"; a="261584912"
X-IronPort-AV: E=Sophos;i="5.78,470,1599548400"; 
   d="scan'208";a="261584912"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2021 09:07:39 -0800
IronPort-SDR: fwJSomnSF/y6+hHAl/Wvfe+88D95eUwIF55usTYH5kRi3sl+70frRvBRIA57qSnRaRAqdM3H0k
 t0W9ogWd1Yaw==
X-IronPort-AV: E=Sophos;i="5.78,470,1599548400"; 
   d="scan'208";a="401489679"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2021 09:07:33 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 9E9E0207BF; Sat,  2 Jan 2021 19:07:31 +0200 (EET)
Date:   Sat, 2 Jan 2021 19:07:31 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20210102170731.GD11878@paasikivi.fi.intel.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
 <20201228170521.GZ26370@paasikivi.fi.intel.com>
 <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
> >>> +#define CIO2_NUM_PORTS                         4
> > 
> > This is already defined in ipu3-cio2.h. Could you include that instead?
> 
> Yes; but I'd need to also include media/v4l2-device.h and
> media/videobuf2-dma-sg.h (they're included in ipu3-cio2-main.c at the
> moment). It didn't seem worth it; but I can move those two includes from
> the .c to the .h and then include ipu3-cio2.h in cio2-bridge.h
> 
> Which do you prefer?

Seems you got answers already... :-) splitting the header in two seems good
to me. But IMO it doesn't have to be a part of this set.

-- 
Sakari Ailus
