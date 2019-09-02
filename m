Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E847A53E3
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfIBKVZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 06:21:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:11447 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbfIBKVZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 06:21:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 03:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="381816054"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2019 03:21:22 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4jSb-0008Sn-VK; Mon, 02 Sep 2019 13:21:21 +0300
Date:   Mon, 2 Sep 2019 13:21:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 09/11] lib/vsprintf: OF nodes are first and foremost,
 struct device_nodes
Message-ID: <20190902102121.GD2680@smile.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-10-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902083240.20367-10-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 11:32:38AM +0300, Sakari Ailus wrote:
> Factor out static kobject_string() function that simply calls
> device_node_string(), and thus remove references to kobjects (as these are
> struct device_node).
> 

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  lib/vsprintf.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index a04a2167101ef..4ad9332d54ba6 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1905,6 +1905,9 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  	struct printf_spec str_spec = spec;
>  	str_spec.field_width = -1;
>  
> +	if (fmt[0] != 'F')
> +		return error_string(buf, end, "(%pO?)", spec);
> +
>  	if (!IS_ENABLED(CONFIG_OF))
>  		return error_string(buf, end, "(%pOF?)", spec);
>  
> @@ -1978,17 +1981,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> -static char *kobject_string(char *buf, char *end, void *ptr,
> -			    struct printf_spec spec, const char *fmt)
> -{
> -	switch (fmt[1]) {
> -	case 'F':
> -		return device_node_string(buf, end, ptr, spec, fmt + 1);
> -	}
> -
> -	return error_string(buf, end, "(%pO?)", spec);
> -}
> -
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -2167,7 +2159,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  	case 'G':
>  		return flags_string(buf, end, ptr, spec, fmt);
>  	case 'O':
> -		return kobject_string(buf, end, ptr, spec, fmt);
> +		return device_node_string(buf, end, ptr, spec, fmt + 1);
>  	case 'x':
>  		return pointer_string(buf, end, ptr, spec);
>  	}
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


