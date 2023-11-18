Return-Path: <linux-acpi+bounces-1589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40527F01F7
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 19:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72D9280E57
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6BF1D697
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YWg8XCld"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA87C5;
	Sat, 18 Nov 2023 09:48:58 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6CA56DA7;
	Sat, 18 Nov 2023 18:48:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700329708;
	bh=gv7BZ1cWzZD4SGo3P2LtWqP2L13lwUy+e9n0VS8QOzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWg8XCldXYen+V7Ii8eZSi2fcYNhxl+To20iNk+FXI7apT3U2LTsqlchBN4Bj8Ycs
	 +wrkeaPlza96CnA2O4mXzoqAvm73sJHb+eqE1XXWJxOb5AvjLpaaOkUSz0PpyhzAmC
	 I/2imyAFEx84O+MkpjWrEdpTMMj2E2kZ4EnbX3IY=
Date: Sat, 18 Nov 2023 19:49:03 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 2/7] pm: runtime: Add
 pm_runtime_put_mark_busy_autosusp() helper
Message-ID: <20231118174903.GF20846@pendragon.ideasonboard.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-3-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231117111433.1561669-3-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Fri, Nov 17, 2023 at 01:14:28PM +0200, Sakari Ailus wrote:
> Add pm_runtime_put_mark_busy_autosusp() helper function for users that
> wish to set the last_busy timestamp to current time and put the
> usage_count of the device and set the autosuspend timer.
> 
> Essentially calling pm_runtime_suspend_mark_busy_autosusp() equal to
> calling first pm_runtime_mark_last_busy() and then
> pm_runtime_put_autosuspend().

The vast majority if the pm_runtime_put_autosuspend() users call
pm_runtime_mark_last_busy() right before. Let's make the
pm_runtime_put_autosuspend() function do that by default, and add a
__pm_runtime_put_autosuspend() (name to be bikshedded) for the minority
of cases where updating the last busy timestamp isn't desired. We want
to simplify the API, not make it more complex.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/linux/pm_runtime.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 13cd526634c1..4afe7b0b9d7e 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -495,6 +495,23 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
>  	    RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
>  }
>  
> +/**
> + * pm_runtime_put_mark_busy_autosusp - Update the last access time of a device
> + *				       and drop device usage counter and queue
> + *				       autosuspend if 0.
> + * @dev: Target device.
> + *
> + * Update the last access time of @dev using pm_runtime_mark_last_busy(), then
> + * decrement the runtime PM usage counter of @dev and if it turns out to be
> + * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
> + */
> +static inline int pm_runtime_put_mark_busy_autosusp(struct device *dev)
> +{
> +	pm_runtime_mark_last_busy(dev);
> +
> +	return pm_runtime_autosuspend(dev);
> +}
> +
>  /**
>   * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
>   * @dev: Target device.

-- 
Regards,

Laurent Pinchart

