Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897312EFCF2
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 03:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbhAICCB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 21:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAICCB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 21:02:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489FCC061573;
        Fri,  8 Jan 2021 18:01:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD446DA;
        Sat,  9 Jan 2021 03:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1610157679;
        bh=jsI0Dp9o8mrHP2CblfN6r1QQaTwTWmysU4tURYPgUMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5QiHG9PHSftUYLy4cNy4+FFhCfqaahcrriQXDw5S0GoNFuyDf58VveyPSwEGqhPq
         XWvP4G1NkoVvO8QloEltriFbRw+f9BdyYsWl8JX+/SCOoJ+18b4avlLmY6iyf+w0JJ
         oAnqnVPXnkfQaTeSYpJagUn3auT7dgWhn1OE4xT4=
Date:   Sat, 9 Jan 2021 04:01:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        devel@acpica.org, rjw@rjwysocki.net, lenb@kernel.org,
        gregkh@linuxfoundation.org, mchehab@kernel.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, robert.moore@intel.com,
        erik.kaneda@intel.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v5 09/15] lib/test_printf.c: Use helper function to
 unwind array of software_nodes
Message-ID: <X/kOYeZtkCspoAC5@pendragon.ideasonboard.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-10-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-10-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Peter, Steven and Sergey,

Could you please let us know if you're fine with this patch getting
merged in v5.12 through the linux-media tree ? The cover letter contains
additional details (in a nutshell, this is a cross-tree series and we
would like to avoid topic branches if possible).

On Thu, Jan 07, 2021 at 01:28:32PM +0000, Daniel Scally wrote:
> Use the software_node_unregister_nodes() helper function to unwind this
> array in a cleaner way.
> 
> Acked-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v5:
> 
> 	- None
> 
>  lib/test_printf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 7ac87f18a10f..7d60f24240a4 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -644,9 +644,7 @@ static void __init fwnode_pointer(void)
>  	test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
>  	test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
>  
> -	software_node_unregister(&softnodes[2]);
> -	software_node_unregister(&softnodes[1]);
> -	software_node_unregister(&softnodes[0]);
> +	software_node_unregister_nodes(softnodes);
>  }
>  
>  static void __init

-- 
Regards,

Laurent Pinchart
