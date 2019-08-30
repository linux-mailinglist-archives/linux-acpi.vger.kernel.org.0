Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39FCA377A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfH3NDy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 09:03:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:58577 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfH3NDy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 09:03:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 06:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="182646184"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2019 06:03:51 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3gZB-0007i1-OP; Fri, 30 Aug 2019 16:03:49 +0300
Date:   Fri, 30 Aug 2019 16:03:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 09/10] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190830130349.GJ2680@smile.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-10-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829101043.24963-10-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 29, 2019 at 01:10:42PM +0300, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.
> 
> On ACPI based systems the resulting strings look like
> 
> 	\_SB.PCI0.CIO2.port@1.endpoint@0
> 
> where the nodes are separated by a dot (".") and the first three are
> ACPI device nodes and the latter two ACPI data nodes.

Couple of comments below, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  Documentation/core-api/printk-formats.rst | 24 +++++++++++++++
>  lib/vsprintf.c                            | 37 +++++++++++++++++++++++
>  scripts/checkpatch.pl                     |  3 +-
>  3 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 922a29eb70e6c..abba210f67567 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -418,6 +418,30 @@ Examples::
>  
>  Passed by reference.
>  
> +Fwnode handles
> +--------------
> +
> +::
> +
> +	%pfw[fP]

I'm not familiar with all flavours of the OF case, the question is do we use
same letters for analogues?

> +
> +For printing information on fwnode handles. The default is to print the full
> +node name, including the path. The modifiers are functionally equivalent to
> +%pOF above.
> +
> +	- f - full name of the node, including the path
> +	- P - the name of the node including an address (if there is one)
> +
> +Examples (ACPI):
> +
> +	%pfwf	\_SB.PCI0.CIO2.port@1.endpoint@0	- Full node name
> +	%pfwP	endpoint@0				- Node name
> +
> +Examples (OF):
> +
> +	%pfwf	/ocp@68000000/i2c@48072000/camera@10/port/endpoint - Full name
> +	%pfwP	endpoint				- Node name
> +
>  Time and date (struct rtc_time)
>  -------------------------------
>  
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 19f9b3f30623e..79dacd0b9e124 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1978,6 +1978,37 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +static noinline_for_stack
> +char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> +		    struct printf_spec spec, const char *fmt)
> +{
> +	struct printf_spec str_spec = spec;
> +	char *buf_start = buf;
> +
> +	str_spec.field_width = -1;
> +
> +	if (*fmt != 'w')
> +		return error_string(buf, end, "(%pfw?)", spec);
> +
> +	if (check_pointer(&buf, end, fwnode, spec))
> +		return buf;
> +
> +	fmt++;
> +
> +	switch (*fmt) {
> +	case 'f':	/* full_name */
> +	default:
> +		buf = fwnode_full_name_string(fwnode, buf, end);
> +		break;
> +	case 'P':	/* name */

> +		buf = string(buf, end, fwnode_get_name(fwnode),
> +			     str_spec);

Perfectly one line.

> +		break;
> +	}
> +
> +	return widen_string(buf, buf - buf_start, end, spec);
> +}
> +
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -2080,6 +2111,10 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>   *                  F device node flags
>   *                  c major compatible string
>   *                  C full compatible string
> + * - 'fw[fP]'	For a firmware node (struct fwnode_handle) pointer
> + *		Without an option prints the full name of the node
> + *		f full name
> + *		P node name, including a possible unit address
>   * - 'x' For printing the address. Equivalent to "%lx".
>   *
>   * ** When making changes please also update:
> @@ -2157,6 +2192,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		return flags_string(buf, end, ptr, spec, fmt);
>  	case 'O':
>  		return device_node_string(buf, end, ptr, spec, fmt + 1);
> +	case 'f':
> +		return fwnode_string(buf, end, ptr, spec, fmt + 1);
>  	case 'x':
>  		return pointer_string(buf, end, ptr, spec);
>  	}
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a60c241112cd4..8df50911ff4e9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5995,7 +5995,8 @@ sub process {
>  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
>  					$specifier = $1;
>  					$extension = $2;
> -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
> +					    $extension =~ /^f[^w]/) {
>  						$bad_specifier = $specifier;
>  						last;
>  					}
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


