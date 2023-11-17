Return-Path: <linux-acpi+bounces-1585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98E27EF64E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 17:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AA6B209DD
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681606AB6
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="blLMrax6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E4BD67;
	Fri, 17 Nov 2023 07:30:21 -0800 (PST)
Received: from ideasonboard.com (unknown [IPv6:2001:b07:5d2e:52c9:cc1e:e404:491f:e6ea])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DDFA4922;
	Fri, 17 Nov 2023 16:29:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700234991;
	bh=utT3/dTTeL7oLW2POSo7P38xjokH9LBGVLKIoVrvtng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blLMrax6OMTC2IRDTmb5SxQ/cJnbEia45xWI+FoO7My0uNMDBdfii/xJRinwJfBIt
	 xLYvQjnjN/H0CSwUdOri6ZYHBYnAhfn2tvxKUh+BqOSIs4dvJQEPS1TmPUzPEPZp7J
	 Pvgh6yr65wxwO75A6DgyuRGx1O/bSD21FUpKhcXg=
Date: Fri, 17 Nov 2023 16:30:15 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org, 
	rafael@kernel.org, jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v2 5/7] media: ov8858: Use pm_runtime_get_if_active(),
 put usage_count correctly
Message-ID: <ledwhthyoc6h5ccmwdvyl7cqrp3kdwijcpkzxpp4jvemd6iz2a@na2elf7674a5>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-6-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231117111433.1561669-6-sakari.ailus@linux.intel.com>

Hi Sakari

On Fri, Nov 17, 2023 at 01:14:31PM +0200, Sakari Ailus wrote:
> Use pm_runtime_get_if_active() to get the device's runtime PM usage_count
> and set controls, then use runtime PM autosuspend once the controls have
> been set (instead of likely transitioning to suspended state immediately).
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/i2c/ov8858.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
> index 3af6125a2eee..a99b91700a8d 100644
> --- a/drivers/media/i2c/ov8858.c
> +++ b/drivers/media/i2c/ov8858.c
> @@ -1538,7 +1538,7 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
>  	struct v4l2_subdev_state *state;
>  	u16 digi_gain;
>  	s64 max_exp;
> -	int ret;
> +	int ret, pm_status;
>
>  	/*
>  	 * The control handler and the subdev state use the same mutex and the
> @@ -1561,7 +1561,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	}
>
> -	if (!pm_runtime_get_if_in_use(&client->dev))
> +	pm_status = pm_runtime_get_if_active(&client->dev);
> +	if (!pm_status)
>  		return 0;
>
>  	switch (ctrl->id) {
> @@ -1601,7 +1602,8 @@ static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	}
>
> -	pm_runtime_put(&client->dev);
> +	if (pm_status > 0)

I'm not 100% sure I get this bit.

If we get here it means pm_status is either -EINVAL or > 0, otherwise
we would have exited earlier.

What's the point of checking for > 0 here ?

There are two cases where pm_status is -EINVAL, either !CONFIG_PM and
the the below call is a nop, or if pm_runtime has not been enabled by
the driver, which means the driver doesn't use pm_runtime at all.

Are there other cases I have missed that require checking here for
pm_status > 0 ?

> +		pm_runtime_mark_busy_autosusp(&client->dev);
>
>  	return ret;
>  }
> --
> 2.39.2
>

