Return-Path: <linux-acpi+bounces-1592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7F87F02E4
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 21:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73744280CD0
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8391E51E
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CRpvpJRw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F09B7;
	Sat, 18 Nov 2023 10:52:43 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8D2049B6;
	Sat, 18 Nov 2023 19:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700333533;
	bh=J+seCFtredfCQziT/OitLEnL5PB+R3wRmiHFUZuhNDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRpvpJRwBw/0y0FoqkuTdGBBMnDZpAoc/snQFazl8rxiOISAWqeoqp6QcHyRDMPEh
	 CGIyBwkYZFbbYLpnqD0JvYEDFDRkvkdKMbf6sjz4Nz8BQVyFpDbipx/uSSibZaH1Zv
	 7NBSYY6PuOOOVoPRXapkWvt17Jj+MqYBmAQYSIVI=
Date: Sat, 18 Nov 2023 20:52:48 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 6/7] media: imx319: Put usage_count correctly in
 s_ctrl callback
Message-ID: <20231118185248.GI20846@pendragon.ideasonboard.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-7-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231117111433.1561669-7-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Fri, Nov 17, 2023 at 01:14:32PM +0200, Sakari Ailus wrote:
> pm_runtime_get_if_in_use() returns an error if Runtime PM is disabled for
> the device, in which case it won't increment the use count.
> pm_runtime_put() does that unconditionally however. Only call
> pm_runtime_put() in case pm_runtime_get_if_in_use() has returned a value >
> 0.

Why don't you use pm_runtime_get_if_active() ?

Other than that, same comment as for patch 5/7, I don't like the
increased complexity.

These comments apply to 7/7 as well.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/i2c/imx319.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx319.c b/drivers/media/i2c/imx319.c
> index 5378f607f340..e7b2d0c20d29 100644
> --- a/drivers/media/i2c/imx319.c
> +++ b/drivers/media/i2c/imx319.c
> @@ -1880,8 +1880,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
>  	struct imx319 *imx319 = container_of(ctrl->handler,
>  					     struct imx319, ctrl_handler);
>  	struct i2c_client *client = v4l2_get_subdevdata(&imx319->sd);
> +	int ret, pm_status;
>  	s64 max;
> -	int ret;
>  
>  	/* Propagate change of current control to all related controls */
>  	switch (ctrl->id) {
> @@ -1898,7 +1898,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
>  	 * Applying V4L2 control value only happens
>  	 * when power is up for streaming
>  	 */
> -	if (!pm_runtime_get_if_in_use(&client->dev))
> +	pm_status = pm_runtime_get_if_in_use(&client->dev);
> +	if (!pm_status)
>  		return 0;
>  
>  	switch (ctrl->id) {
> @@ -1937,7 +1938,8 @@ static int imx319_set_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	}
>  
> -	pm_runtime_put(&client->dev);
> +	if (pm_status > 0)
> +		pm_runtime_put(&client->dev);
>  
>  	return ret;
>  }

-- 
Regards,

Laurent Pinchart

