Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A41A645A
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfICIwg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Sep 2019 04:52:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbfICIwf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Sep 2019 04:52:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DDD4AC26;
        Tue,  3 Sep 2019 08:52:34 +0000 (UTC)
Date:   Tue, 3 Sep 2019 10:52:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 09/11] lib/vsprintf: OF nodes are first and foremost,
 struct device_nodes
Message-ID: <20190903085233.oksjcwqwdxb53eig@pathway.suse.cz>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <20190902135732.23455-10-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902135732.23455-10-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon 2019-09-02 16:57:30, Sakari Ailus wrote:
> Factor out static kobject_string() function that simply calls
> device_node_string(), and thus remove references to kobjects (as these are
> struct device_node).
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

I know that this come from from kobject_string(). But please, modify
it to follow the style used by other %p modifiers. I mean to pass
"fmt" as is and then use:

	if (fmt[1] != 'F')

With the above change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
