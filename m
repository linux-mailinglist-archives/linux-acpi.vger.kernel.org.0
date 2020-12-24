Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D882E2705
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 14:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgLXM7c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 07:59:32 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:46390 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgLXM7b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 07:59:31 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E3DDEA1D;
        Thu, 24 Dec 2020 13:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608814729;
        bh=NyE9Xog7WUOcMlr2CsciXfyQZEiqb7pmT8cHhyWHcAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wS1uUT75bk0spPut70rJAmR164Mpm7/YndNehxOGBZgmiIsbwc+/+MX6HR4Bg0927
         +vAEb6CpjMAkFm+LBFWNDQt8wF745mUOB32sx6cJuAKmef3S/fYp4Gw0Ro9oOOecU7
         8Ng9LdriaVPgX2Md1l9sFbM4EL6YgGQVswT5rqo4=
Date:   Thu, 24 Dec 2020 14:58:39 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: Re: [PATCH v3 13/14] include: media: v4l2-fwnode: Include
 v4l2_fwnode_bus_type
Message-ID: <X+SQf9qypl3k06Vn@pendragon.ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-14-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201224010907.263125-14-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

Thank you for the patch.

On Thu, Dec 24, 2020 at 01:09:06AM +0000, Daniel Scally wrote:
> V4L2 fwnode bus types are enumerated in v4l2-fwnode.c, meaning they aren't
> available to the rest of the kernel. Move the enum to the corresponding
> header so that I can use the label to refer to those values.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v3
> 	- Patch introduced
> 
>  drivers/media/v4l2-core/v4l2-fwnode.c | 11 -----------
>  include/media/v4l2-fwnode.h           | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index 5353e37eb950..c1c2b3060532 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -28,17 +28,6 @@
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-subdev.h>
>  
> -enum v4l2_fwnode_bus_type {
> -	V4L2_FWNODE_BUS_TYPE_GUESS = 0,
> -	V4L2_FWNODE_BUS_TYPE_CSI2_CPHY,
> -	V4L2_FWNODE_BUS_TYPE_CSI1,
> -	V4L2_FWNODE_BUS_TYPE_CCP2,
> -	V4L2_FWNODE_BUS_TYPE_CSI2_DPHY,
> -	V4L2_FWNODE_BUS_TYPE_PARALLEL,
> -	V4L2_FWNODE_BUS_TYPE_BT656,
> -	NR_OF_V4L2_FWNODE_BUS_TYPE,
> -};
> -
>  static const struct v4l2_fwnode_bus_conv {
>  	enum v4l2_fwnode_bus_type fwnode_bus_type;
>  	enum v4l2_mbus_type mbus_type;
> diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
> index 4365430eea6f..d306a28bda96 100644
> --- a/include/media/v4l2-fwnode.h
> +++ b/include/media/v4l2-fwnode.h
> @@ -213,6 +213,28 @@ struct v4l2_fwnode_connector {
>  	} connector;
>  };
>  
> +/**
> + * enum v4l2_fwnode_bus_type - Video bus types defined by firmware properties
> + * @V4L2_FWNODE_BUS_TYPE_GUESS: Default value if no bus-type fwnode property
> + * @V4L2_FWNODE_BUS_TYPE_CSI2_CPHY: MIPI CSI-2 bus, C-PHY physical layer
> + * @V4L2_FWNODE_BUS_TYPE_CSI1: MIPI CSI-1 bus
> + * @V4L2_FWNODE_BUS_TYPE_CCP2: SMIA Compact Camera Port 2 bus
> + * @V4L2_FWNODE_BUS_TYPE_CSI2_DPHY: MIPI CSI-2 bus, D-PHY physical layer
> + * @V4L2_FWNODE_BUS_TYPE_PARALLEL: Camera Parallel Interface bus
> + * @V4L2_FWNODE_BUS_TYPE_BT656: BT656 video format bus-type

s/BT656 video/BT.656 video/

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> + * @NR_OF_V4L2_FWNODE_BUS_TYPE: Number of bus-types
> + */
> +enum v4l2_fwnode_bus_type {
> +	V4L2_FWNODE_BUS_TYPE_GUESS = 0,
> +	V4L2_FWNODE_BUS_TYPE_CSI2_CPHY,
> +	V4L2_FWNODE_BUS_TYPE_CSI1,
> +	V4L2_FWNODE_BUS_TYPE_CCP2,
> +	V4L2_FWNODE_BUS_TYPE_CSI2_DPHY,
> +	V4L2_FWNODE_BUS_TYPE_PARALLEL,
> +	V4L2_FWNODE_BUS_TYPE_BT656,
> +	NR_OF_V4L2_FWNODE_BUS_TYPE,
> +};
> +
>  /**
>   * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
>   * @fwnode: pointer to the endpoint's fwnode handle

-- 
Regards,

Laurent Pinchart
