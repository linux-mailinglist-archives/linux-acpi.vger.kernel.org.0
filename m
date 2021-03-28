Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F934BBB2
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Mar 2021 10:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhC1In3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Mar 2021 04:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhC1InE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Mar 2021 04:43:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAECC61966;
        Sun, 28 Mar 2021 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616920983;
        bh=C12zvsMmJIgwjjVR8lLlhOry1XH7ndkALgxogosrSII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQhfvQuGN0orJE2YPxaMD3P141ZcKFgBS32IkIPZsIbWQi8eUrVED8bPB4ye4jDRJ
         wYoz2Rsqkbz3HgKXjbRZ+2FHfNYGjwN+OqCO/js5DN5mogusiK+T0LtJwmgyP8UTa4
         mOTVDiCH7JqlrL9sjT0NpCGrj8M/K3MqL/qFGmQc=
Date:   Sun, 28 Mar 2021 10:43:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 5/8] software node: Imply kobj_to_swnode() to be no-op
Message-ID: <YGBBlCBMp0P4mVJG@kroah.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327222012.54103-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 28, 2021 at 12:20:09AM +0200, Andy Shevchenko wrote:
> Since we don't use structure field layout randomization
> the manual shuffling can affect some macros, in particular
> kobj_to_swnode(), which becomes a no-op when kobj member
> is the first one in the struct swnode.
> 
> Bloat-o-meter statistics:
> 
>   add/remove: 0/0 grow/shrink: 2/10 up/down: 9/-100 (-91)
>   Total: Before=7217, After=7126, chg -1.26%
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/swnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 22f81688af2c..ae53c48f84b1 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -13,10 +13,10 @@
>  #include <linux/sysfs.h>
>  
>  struct swnode {
> -	int id;
>  	struct kobject kobj;
>  	struct fwnode_handle fwnode;
>  	const struct software_node *node;
> +	int id;

So you remove one math operation on a pointer and get a 1% size decrease
of the whole kernel?  Or just one file?

thanks,

greg k-h
