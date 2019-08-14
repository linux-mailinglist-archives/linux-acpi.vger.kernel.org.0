Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC58E122
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2019 01:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfHNXP2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 19:15:28 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60386 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfHNXP2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 19:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tz0pQIubSjrBkEAcJdqyZNPWs94fjEXm6DpnjbP7BU0=; b=ObOQkiQy/PcCPa+nKyx0YBGby
        4eY6JnBqjbXiq2oqnuoZg+DiMvD/sMGHCpW1d3dO/OjDQAH690r5eNnSMIiohMjuIuPWJcF5FcD/5
        SEqycguzmqMvkkGXa7n1R8mkvGVcB32aUH56ammp4E7btBTaNOqDsGvdtGF6Ls7qP5/+Xp1iWd9GF
        QAtyPFgKFgNZJPXkRHkZIj1eY1n6NVDDFjTtXdUWhQe6qDgB+FHL1EAnOYaVLylcsTb/BTweJn+hh
        bnsOH3f3NG5M5suM+U/GLdneycmpipFMWr8M2DU+GT3y16IBFtJRNlgKLSIBk8fXDoTj8MeEZIzDb
        6SfuRJCLg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56690)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hy2U8-0000f6-8R; Thu, 15 Aug 2019 00:15:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hy2U1-0000Pe-LG; Thu, 15 Aug 2019 00:15:09 +0100
Date:   Thu, 15 Aug 2019 00:15:09 +0100
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
Message-ID: <20190814231509.GK13294@shell.armlinux.org.uk>
References: <20190805233505.21167-1-slongerbeam@gmail.com>
 <20190805233505.21167-5-slongerbeam@gmail.com>
 <CAHp75VcOh8bOf_s6t0ehwGtcYn64QFGj303SVvpHrztEOhTRgg@mail.gmail.com>
 <4750b347-b421-6569-600f-0ced8406460e@gmail.com>
 <20190814103054.GI13294@shell.armlinux.org.uk>
 <e0a19469-af9d-d9de-499f-4ffbf04542b3@gmail.com>
 <20190814220437.GJ13294@shell.armlinux.org.uk>
 <1842bf8f-4f97-6294-41db-74f9f8e2befd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1842bf8f-4f97-6294-41db-74f9f8e2befd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 14, 2019 at 04:00:30PM -0700, Steve Longerbeam wrote:
> 
> 
> On 8/14/19 3:04 PM, Russell King - ARM Linux admin wrote:
> > On Wed, Aug 14, 2019 at 12:04:41PM -0700, Steve Longerbeam wrote:
> > > 
> > > On 8/14/19 3:30 AM, Russell King - ARM Linux admin wrote:
> > > > On Tue, Aug 06, 2019 at 09:53:41AM -0700, Steve Longerbeam wrote:
> > > > > The full patchset doesn't seem to be up yet, but see [1] for the cover
> > > > > letter.
> > > > Was the entire series copied to the mailing lists, or just selected
> > > > patches?  I only saw 4, 9, 11 and 13-22 via lakml.
> > > The whole series was posted to the linux-media ML, see [1]. At the time,
> > > none of the linux-media ML archives had the whole series.
> > > 
> > > > In the absence of the other patches, will this solve imx-media binding
> > > > the internal subdevs of sensor devices to the CSI2 interface?
> > > "internal subdevs of sensor devices" ?? That doesn't make any sense.
> > Sorry, but it makes complete sense when you consider that sensor
> > devices may have more than one subdev, but there should be only one
> > that is the "output" to whatever the camera is attached to.  The
> > other subdevs are internal to the sensor.
> 
> Ah, thanks for the clarification. Yes, by "internal subdevs" I understand
> what you mean now. The adv748x and smiapp are examples.
> 
> > 
> > subdevs are not purely the remit of SoC drivers.
> 
> So there is no binding of internal subdevs to the receiver CSI-2. The
> receiver CSI-2 subdev will create media links to the subdev that has an
> externally exposed fwnode endpoint that connects with the CSI-2 sink pad.

Maybe - with 5.2, I get:

- entity 15: imx6-mipi-csi2 (5 pads, 6 links)
             type V4L2 subdev subtype Unknown flags 0
             device node name /dev/v4l-subdev2
        pad0: Sink
...
                <- "imx219 0-0010":0 []
                <- "imx219 pixel 0-0010":0 []

Adding some debug in gives:

[   11.963362] imx-media: imx_media_create_of_links() for imx6-mipi-csi2
[   11.963396] imx-media: create_of_link(): /soc/aips-bus@2000000/iomuxc-gpr@20e0000/ipu1_csi0_mux
[   11.963422] imx-media: create_of_link(): /soc/ipu@2400000
[   11.963450] imx-media: create_of_link(): /soc/ipu@2800000
[   11.963478] imx-media: create_of_link(): /soc/aips-bus@2000000/iomuxc-gpr@20e0000/ipu2_csi1_mux
[   11.963489] imx-media: imx6-mipi-csi2:4 -> ipu2_csi1_mux:0
[   11.963522] imx-media: create_of_link(): /soc/aips-bus@2100000/i2c@21a0000/camera@10
[   11.963533] imx-media: imx219 0-0010:0 -> imx6-mipi-csi2:0
[   11.963549] imx-media: imx_media_create_of_links() for imx219 pixel 0-0010
[   11.963577] imx-media: create_of_link(): /soc/aips-bus@2100000/mipi@21dc000
[   11.963587] imx-media: imx219 pixel 0-0010:0 -> imx6-mipi-csi2:0
[   11.963602] imx-media: imx_media_create_of_links() for imx219 0-0010

Note that it's not created by imx6-mipi-csi2, but by imx-media delving
around in the imx219 subdevs.

From what I can see, smiapp does the same thing that I do in imx219 -
sets the subdev->dev member to point at the struct device, which then
means that v4l2_device_register_subdev() will associate the same fwnode
with both "imx219 pixel 0-0010" and "imx219 0-0010".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
