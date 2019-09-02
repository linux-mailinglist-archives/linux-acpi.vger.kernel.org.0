Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7154A5A5B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 17:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfIBPSF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 11:18:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:41588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729656AbfIBPSF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 11:18:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1BC1AE89;
        Mon,  2 Sep 2019 15:18:03 +0000 (UTC)
Date:   Mon, 2 Sep 2019 17:18:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 08/11] lib/vsprintf: Make use of fwnode API to obtain
 node names and separators
Message-ID: <20190902151803.wgt2x5rtpziggtgx@pathway.suse.cz>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-9-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902083240.20367-9-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon 2019-09-02 11:32:37, Sakari Ailus wrote:
> Instead of implementing our own means of discovering parent nodes, node
> names or counting how many parents a node has, use the newly added
> functions in the fwnode API to obtain that information.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b00b57f9f911f..a04a2167101ef 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1863,32 +1864,24 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
>  	return format_flags(buf, end, flags, names);
>  }
>  
> -static const char *device_node_name_for_depth(const struct device_node *np, int depth)
> -{
> -	for ( ; np && depth; depth--)
> -		np = np->parent;
> -
> -	return kbasename(np->full_name);
> -}
> -
>  static noinline_for_stack
> -char *device_node_gen_full_name(const struct device_node *np, char *buf, char *end)
> +char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
> +			      char *end)
>  {
>  	int depth;
> -	const struct device_node *parent = np->parent;
>  
> -	/* special case for root node */
> -	if (!parent)
> -		return string_nocheck(buf, end, "/", default_str_spec);
> +	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {

It looked suspicious that it iterated "depth + 1" times. It might be
obvious for people traversing paths every day but not for me ;-)
Please, add a comment, for example:

	/* Iterate over parents and current node. */

With the above comment:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
