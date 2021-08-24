Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BFB3F6205
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Aug 2021 17:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhHXPwS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Aug 2021 11:52:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:12636 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238287AbhHXPwR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Aug 2021 11:52:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="197586992"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="197586992"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 08:51:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="443843603"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 08:51:27 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 87B3B2021A;
        Tue, 24 Aug 2021 18:51:25 +0300 (EEST)
Date:   Tue, 24 Aug 2021 18:51:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org
Subject: Re: [RFC 1/3] imx258: Defer probing on ident register read fail (on
 ACPI)
Message-ID: <20210824155125.GJ3@paasikivi.fi.intel.com>
References: <20210819201936.7390-1-sakari.ailus@linux.intel.com>
 <20210819201936.7390-2-sakari.ailus@linux.intel.com>
 <YR7Mu76nlw4kKwE5@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YR7Mu76nlw4kKwE5@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Laurent,

On Fri, Aug 20, 2021 at 12:27:23AM +0300, Laurent Pinchart wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> On Thu, Aug 19, 2021 at 11:19:34PM +0300, Sakari Ailus wrote:
> > Return -EPROBE_DEFER if probing the device fails because of the I²C
> > transaction (-EIO only). This generally happens when the power on sequence
> > of the device has not been fully performed yet due to later probing of
> > other drivers.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/media/i2c/imx258.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> > index c249507aa2db..2751c12b6029 100644
> > --- a/drivers/media/i2c/imx258.c
> > +++ b/drivers/media/i2c/imx258.c
> > @@ -1109,6 +1109,14 @@ static int imx258_identify_module(struct imx258 *imx258)
> >  
> >  	ret = imx258_read_reg(imx258, IMX258_REG_CHIP_ID,
> >  			      IMX258_REG_VALUE_16BIT, &val);
> > +	if (ret == -EIO && is_acpi_device_node(dev_fwnode(&client->dev))) {
> > +		/*
> > +		 * If we get -EIO here and it's an ACPI device, there's a fair
> > +		 * likelihood it's because the drivers required to power this
> > +		 * device on have not probed yet. Thus return -EPROBE_DEFER.
> > +		 */
> > +		return -EPROBE_DEFER;
> 
> That's really a hack :-( The driver shouldn't have to deal with this. If
> power management is handled transparently for the driver, which is
> what's meant to happen with ACPI, then it should be fully transparent.
> An -EIO error may mean a real communication issue, turning it into
> infinite probe deferring isn't right. The ACPI subsystem should figure
> this out and not probe the driver until all the required resources that
> are managed transparently for the driver are available.
> 
> If this was a one-off hack I may be able to pretend I haven't noticed,
> but this would need to be copied to every single sensor driver, even
> every single I2C device driver. It should be fixed properly in the ACPI
> subsystem instead.

In practice such communication issues are rare and trying an I²C access
isn't expensive. The patch does solve two practical issues, namely
correctly probing a driver and making it possible to build more things as
modules.

That said, I agree with with you that ideally a driver would know whether a
device has been fully powered up or not. There could also be adverse side
effects as there have been no such checks previously.

-- 
Regards,

Sakari Ailus
