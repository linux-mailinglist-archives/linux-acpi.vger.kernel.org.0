Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB83A377C
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfH3NEd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 09:04:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:58636 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfH3NEd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 09:04:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 06:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="182646301"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2019 06:04:31 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3gZq-0007iM-4Q; Fri, 30 Aug 2019 16:04:30 +0300
Date:   Fri, 30 Aug 2019 16:04:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 10/10] lib/test_printf: Add tests for %pfw printk
 modifier
Message-ID: <20190830130430.GK2680@smile.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-11-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829101043.24963-11-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 29, 2019 at 01:10:43PM +0300, Sakari Ailus wrote:
> Add a test for the %pfw printk modifier using software nodes.
> 

Having tests is always a good thing!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  lib/test_printf.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 944eb50f38625..9c6d716979fb1 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -22,6 +22,8 @@
>  #include <linux/gfp.h>
>  #include <linux/mm.h>
>  
> +#include <linux/property.h>
> +
>  #include "../tools/testing/selftests/kselftest_module.h"
>  
>  #define BUF_SIZE 256
> @@ -588,6 +590,40 @@ flags(void)
>  	kfree(cmp_buffer);
>  }
>  
> +static void __init fwnode_pointer(void)
> +{
> +	const struct software_node softnodes[] = {
> +		{ .name = "first", },
> +		{ .name = "second", .parent = &softnodes[0], },
> +		{ .name = "third", .parent = &softnodes[1], },
> +		{ NULL /* Guardian */ },
> +	};
> +	const char * const full_name = "/second/third";
> +	const char * const full_name_second = "/second";
> +	const char * const second_name = "second";
> +	const char * const third_name = "third";
> +	int rval;
> +
> +	rval = software_node_register_nodes(softnodes);
> +	if (rval) {
> +		pr_warn("cannot register softnodes; rval %d\n", rval);
> +		return;
> +	}
> +
> +	test(full_name_second, "%pfw",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> +	test(full_name, "%pfw",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> +	test(full_name, "%pfwf",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> +	test(second_name, "%pfwP",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> +	test(third_name, "%pfwP",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> +
> +	software_node_unregister_nodes(softnodes);
> +}
> +
>  static void __init
>  test_pointer(void)
>  {
> @@ -610,6 +646,7 @@ test_pointer(void)
>  	bitmap();
>  	netdev_features();
>  	flags();
> +	fwnode_pointer();
>  }
>  
>  static void __init selftest(void)
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


