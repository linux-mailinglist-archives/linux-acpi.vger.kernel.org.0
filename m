Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2687FA3722
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfH3MxS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 08:53:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:56142 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfH3MxS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 08:53:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 05:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="183793140"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2019 05:53:15 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3gOw-0007cr-9c; Fri, 30 Aug 2019 15:53:14 +0300
Date:   Fri, 30 Aug 2019 15:53:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 07/10] lib/vsprintf: Make use of fwnode API to obtain
 node names and separators
Message-ID: <20190830125314.GG2680@smile.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-8-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829101043.24963-8-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 29, 2019 at 01:10:40PM +0300, Sakari Ailus wrote:
> Instead of implementing our own means of discovering parent nodes, node
> names or counting how many parents a node has, use the newly added
> functions in the fwnode API to obtain that information.
> 

Some style comments below.
Nevertheless,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  lib/vsprintf.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b00b57f9f911f..a04a2167101ef 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -38,6 +38,7 @@
>  #include <net/addrconf.h>
>  #include <linux/siphash.h>
>  #include <linux/compiler.h>
> +#include <linux/property.h>
>  #ifdef CONFIG_BLOCK
>  #include <linux/blkdev.h>
>  #endif
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

I would leave it on one line.

>  {
>  	int depth;
> -	const struct device_node *parent = np->parent;
>  
> -	/* special case for root node */
> -	if (!parent)
> -		return string_nocheck(buf, end, "/", default_str_spec);
> +	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
> +		struct fwnode_handle *__fwnode =
> +			fwnode_get_nth_parent(fwnode, depth);

Ditto if you name temporary variable like fw / fh / fn / etc.

>  
> -	for (depth = 0; parent->parent; depth++)
> -		parent = parent->parent;
> -
> -	for ( ; depth >= 0; depth--) {
> -		buf = string_nocheck(buf, end, "/", default_str_spec);
> -		buf = string(buf, end, device_node_name_for_depth(np, depth),

> +		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
> +			     default_str_spec);
> +		buf = string(buf, end, fwnode_get_name(__fwnode),
>  			     default_str_spec);

Ditto.

> +
> +		fwnode_handle_put(__fwnode);
>  	}
> +
>  	return buf;
>  }
>  
> @@ -1933,10 +1926,11 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  
>  		switch (*fmt) {
>  		case 'f':	/* full_name */
> -			buf = device_node_gen_full_name(dn, buf, end);

> +			buf = fwnode_full_name_string(of_fwnode_handle(dn), buf,
> +						      end);

Ditto, disregard checkpatch.

>  			break;
>  		case 'n':	/* name */
> -			p = kbasename(of_node_full_name(dn));
> +			p = fwnode_get_name(of_fwnode_handle(dn));
>  			precision = str_spec.precision;
>  			str_spec.precision = strchrnul(p, '@') - p;
>  			buf = string(buf, end, p, str_spec);
> @@ -1946,7 +1940,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  			buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
>  			break;
>  		case 'P':	/* path-spec */
> -			p = kbasename(of_node_full_name(dn));
> +			p = fwnode_get_name(of_fwnode_handle(dn));
>  			if (!p[1])
>  				p = "/";
>  			buf = string(buf, end, p, str_spec);
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


