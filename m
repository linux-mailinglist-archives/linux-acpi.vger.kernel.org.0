Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11BE3F223B
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Aug 2021 23:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhHSV2K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Aug 2021 17:28:10 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60018 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhHSV2K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Aug 2021 17:28:10 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 69AFFDD;
        Thu, 19 Aug 2021 23:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1629408451;
        bh=82c7+9N3DOpOVO7TtTZmFCuEClko003ueimXqfKdT9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGvLs5rbMOYR1a2yJUArh88keTunA1pMUbRy9e/fLWXSP2RZAD8T57vbxVZlg7FKr
         YZbXILhwqTCHlRB+BThpRBCMPEsS2XX2xc50L+lqY1By+jTCPfgw8Gji/0O58emJS5
         OayKmetUZB/3KCInNGY1hJR1OIoGJUXcfVy8Dv2A=
Date:   Fri, 20 Aug 2021 00:27:23 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org
Subject: Re: [RFC 1/3] imx258: Defer probing on ident register read fail (on
 ACPI)
Message-ID: <YR7Mu76nlw4kKwE5@pendragon.ideasonboard.com>
References: <20210819201936.7390-1-sakari.ailus@linux.intel.com>
 <20210819201936.7390-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819201936.7390-2-sakari.ailus@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

Thank you for the patch.

On Thu, Aug 19, 2021 at 11:19:34PM +0300, Sakari Ailus wrote:
> Return -EPROBE_DEFER if probing the device fails because of the I²C
> transaction (-EIO only). This generally happens when the power on sequence
> of the device has not been fully performed yet due to later probing of
> other drivers.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/i2c/imx258.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index c249507aa2db..2751c12b6029 100644
> --- a/drivers/media/i2c/imx258.c
> +++ b/drivers/media/i2c/imx258.c
> @@ -1109,6 +1109,14 @@ static int imx258_identify_module(struct imx258 *imx258)
>  
>  	ret = imx258_read_reg(imx258, IMX258_REG_CHIP_ID,
>  			      IMX258_REG_VALUE_16BIT, &val);
> +	if (ret == -EIO && is_acpi_device_node(dev_fwnode(&client->dev))) {
> +		/*
> +		 * If we get -EIO here and it's an ACPI device, there's a fair
> +		 * likelihood it's because the drivers required to power this
> +		 * device on have not probed yet. Thus return -EPROBE_DEFER.
> +		 */
> +		return -EPROBE_DEFER;

That's really a hack :-( The driver shouldn't have to deal with this. If
power management is handled transparently for the driver, which is
what's meant to happen with ACPI, then it should be fully transparent.
An -EIO error may mean a real communication issue, turning it into
infinite probe deferring isn't right. The ACPI subsystem should figure
this out and not probe the driver until all the required resources that
are managed transparently for the driver are available.

If this was a one-off hack I may be able to pretend I haven't noticed,
but this would need to be copied to every single sensor driver, even
every single I2C device driver. It should be fixed properly in the ACPI
subsystem instead.

> +	}
>  	if (ret) {
>  		dev_err(&client->dev, "failed to read chip id %x\n",
>  			IMX258_CHIP_ID);

-- 
Regards,

Laurent Pinchart
