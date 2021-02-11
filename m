Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E648318B6D
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 14:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBKNDw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 08:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhBKNBe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Feb 2021 08:01:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C44664E2F;
        Thu, 11 Feb 2021 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613048453;
        bh=R1wXfHp/mtHayjhLTRFV8J+RaQB8xzJF+ECpMM3qItM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T87s8o56OYCjh7+2IySoSf6EQzX/8ghjZ9UEoEO8tL3PT5O/iMYBB6llgADANOEcv
         veO7DEsSwUQ+cciKl7+wJvOIp7q/FXfpIOgVYudhHYxDo8UX+BV0KUoN1JWCKSmoiY
         w5GN1sGoLrMTXKprbTvrp9IuvP4D6QUg646ZKY8w=
Date:   Thu, 11 Feb 2021 14:00:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     corbet@lwn.net, rafael@kernel.org, khilman@kernel.org,
        ulf.hansson@linaro.org, len.brown@intel.com, lenb@kernel.org,
        pavel@ucw.cz, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, frowand.list@gmail.com, maz@kernel.org,
        tglx@linutronix.de, saravanak@google.com,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        m.szyprowski@samsung.com, geert@linux-m68k.org,
        kernel-team@android.com
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
Message-ID: <YCUqgwrCREvPqEz+@kroah.com>
References: <20210205222644.2357303-9-saravanak@google.com>
 <20210210114435.122242-1-tudor.ambarus@microchip.com>
 <20210210114435.122242-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210114435.122242-2-tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 01:44:35PM +0200, Tudor Ambarus wrote:
> This is a follow-up for:
> commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> 
> The above commit updated the deprecated of_clk_add_provider(),
> but missed to update the preferred of_clk_add_hw_provider().
> Update it now.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/clk/clk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 27ff90eacb1f..9370e4dfecae 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4594,6 +4594,8 @@ int of_clk_add_hw_provider(struct device_node *np,
>  	if (ret < 0)
>  		of_clk_del_provider(np);
>  
> +	fwnode_dev_initialized(&np->fwnode, true);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_clk_add_hw_provider);
> -- 
> 2.25.1
> 

Any objection for me taking this in my tree as well?

thanks,

greg k-h
