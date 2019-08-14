Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A168E046
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 00:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfHNWE7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 18:04:59 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59414 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbfHNWE6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 18:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yZJZc6bPnymXOyRmv25X7N9D2emSqLB8ZfiOEQ7nToU=; b=ddv6iy3IQteNIqV/iXD9158oZ
        LroheE2bDRFtnRZGMGvT+ILxG1FnK+z2Y8o9E22Jy9CPSoFq5oWWWsrb50iCXzt9yVVVJhobjV6aw
        i0pZ7OO825u8L0btv0Orsvl5X79891J+4KPyJaaYdziN3zk1WapKJuwARQL7ZjfgO/4mO+tR09iEa
        tMw4KBGQcsq8WmX4Mqn9Ib0nluWlvsXBzW9FA9BlKDoFfMhRgYqCwSw2Oalg0c6EGyWEIrVg5BkY5
        Jk6GMTFgfuRf1+fLAT+n0kEHmhlFG0FONX9aPwbqiAJixkpRma6Y7WavtJqzRAV4n+Zr3cJCEKN9+
        JpLMnFeCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56662)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hy1Nu-0000L9-Jm; Wed, 14 Aug 2019 23:04:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hy1Nl-0000Lf-AN; Wed, 14 Aug 2019 23:04:37 +0100
Date:   Wed, 14 Aug 2019 23:04:37 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Len Brown <lenb@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Enrico Weigelt <info@metux.net>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 04/22] media: Move v4l2_fwnode_parse_link from v4l2 to
 driver base
Message-ID: <20190814220437.GJ13294@shell.armlinux.org.uk>
References: <20190805233505.21167-1-slongerbeam@gmail.com>
 <20190805233505.21167-5-slongerbeam@gmail.com>
 <CAHp75VcOh8bOf_s6t0ehwGtcYn64QFGj303SVvpHrztEOhTRgg@mail.gmail.com>
 <4750b347-b421-6569-600f-0ced8406460e@gmail.com>
 <20190814103054.GI13294@shell.armlinux.org.uk>
 <e0a19469-af9d-d9de-499f-4ffbf04542b3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a19469-af9d-d9de-499f-4ffbf04542b3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 14, 2019 at 12:04:41PM -0700, Steve Longerbeam wrote:
> 
> 
> On 8/14/19 3:30 AM, Russell King - ARM Linux admin wrote:
> > On Tue, Aug 06, 2019 at 09:53:41AM -0700, Steve Longerbeam wrote:
> > > The full patchset doesn't seem to be up yet, but see [1] for the cover
> > > letter.
> > Was the entire series copied to the mailing lists, or just selected
> > patches?  I only saw 4, 9, 11 and 13-22 via lakml.
> 
> The whole series was posted to the linux-media ML, see [1]. At the time,
> none of the linux-media ML archives had the whole series.
> 
> > In the absence of the other patches, will this solve imx-media binding
> > the internal subdevs of sensor devices to the CSI2 interface?
> 
> "internal subdevs of sensor devices" ?? That doesn't make any sense.

Sorry, but it makes complete sense when you consider that sensor
devices may have more than one subdev, but there should be only one
that is the "output" to whatever the camera is attached to.  The
other subdevs are internal to the sensor.

subdevs are not purely the remit of SoC drivers.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
