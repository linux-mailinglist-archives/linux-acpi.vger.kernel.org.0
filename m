Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97CBDA3715
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 14:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfH3MsW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 08:48:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:23308 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfH3MsV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 08:48:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 05:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="172227004"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2019 05:48:18 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3gK9-0007ax-2O; Fri, 30 Aug 2019 15:48:17 +0300
Date:   Fri, 30 Aug 2019 15:48:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/10] lib/vsprintf: Remove support for %pF and %pf in
 favour of %pS and %ps
Message-ID: <20190830124817.GF2680@smile.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-7-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829101043.24963-7-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 29, 2019 at 01:10:39PM +0300, Sakari Ailus wrote:
> %pS and %ps are now the preferred conversion specifiers to print function
> %names. The functionality is equivalent; remove the old, deprecated %pF
> %and %pf support.
> 

> Depends-on: ("treewide: Switch printk users from %pf and %pF to %ps and
> 	      %pS, respectively")

Same comment for multi-line tags, besides that it misses hash, and since it's
in upstream, no need for it anymore?

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  Documentation/core-api/printk-formats.rst | 10 ----------
>  lib/vsprintf.c                            |  8 ++------
>  scripts/checkpatch.pl                     |  1 -
>  3 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index c6224d039bcbe..922a29eb70e6c 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -86,8 +86,6 @@ Symbols/Function Pointers
>  
>  	%pS	versatile_init+0x0/0x110
>  	%ps	versatile_init
> -	%pF	versatile_init+0x0/0x110
> -	%pf	versatile_init
>  	%pSR	versatile_init+0x9/0x110
>  		(with __builtin_extract_return_addr() translation)
>  	%pB	prev_fn_of_versatile_init+0x88/0x88
> @@ -97,14 +95,6 @@ The ``S`` and ``s`` specifiers are used for printing a pointer in symbolic
>  format. They result in the symbol name with (S) or without (s)
>  offsets. If KALLSYMS are disabled then the symbol address is printed instead.
>  
> -Note, that the ``F`` and ``f`` specifiers are identical to ``S`` (``s``)
> -and thus deprecated. We have ``F`` and ``f`` because on ia64, ppc64 and
> -parisc64 function pointers are indirect and, in fact, are function
> -descriptors, which require additional dereferencing before we can lookup
> -the symbol. As of now, ``S`` and ``s`` perform dereferencing on those
> -platforms (when needed), so ``F`` and ``f`` exist for compatibility
> -reasons only.
> -
>  The ``B`` specifier results in the symbol name with offsets and should be
>  used when printing stack backtraces. The specifier takes into
>  consideration the effect of compiler optimisations which may occur
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b0967cf17137d..b00b57f9f911f 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -909,7 +909,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
>  #ifdef CONFIG_KALLSYMS
>  	if (*fmt == 'B')
>  		sprint_backtrace(sym, value);
> -	else if (*fmt != 'f' && *fmt != 's')
> +	else if (*fmt != 's')
>  		sprint_symbol(sym, value);
>  	else
>  		sprint_symbol_no_offset(sym, value);
> @@ -2007,9 +2007,7 @@ static char *kobject_string(char *buf, char *end, void *ptr,
>   *
>   * - 'S' For symbolic direct pointers (or function descriptors) with offset
>   * - 's' For symbolic direct pointers (or function descriptors) without offset
> - * - 'F' Same as 'S'
> - * - 'f' Same as 's'
> - * - '[FfSs]R' as above with __builtin_extract_return_addr() translation
> + * - '[Ss]R' as above with __builtin_extract_return_addr() translation
>   * - 'B' For backtraced symbolic direct pointers with offset
>   * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
>   * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]
> @@ -2112,8 +2110,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  	      struct printf_spec spec)
>  {
>  	switch (*fmt) {
> -	case 'F':
> -	case 'f':
>  	case 'S':
>  	case 's':
>  		ptr = dereference_symbol_descriptor(ptr);
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 93a7edfe0f059..a60c241112cd4 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6012,7 +6012,6 @@ sub process {
>  					my $ext_type = "Invalid";
>  					my $use = "";
>  					if ($bad_specifier =~ /p[Ff]/) {
> -						$ext_type = "Deprecated";
>  						$use = " - use %pS instead";
>  						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
>  					}
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


