Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031E9BC5B7
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409485AbfIXKid (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 06:38:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409464AbfIXKid (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 06:38:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D918AADAA;
        Tue, 24 Sep 2019 10:38:30 +0000 (UTC)
Date:   Tue, 24 Sep 2019 12:38:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 08/13] lib/vsprintf: Remove support for %pF and %pf in
 favour of %pS and %ps
Message-ID: <20190924103829.uk4mr3z23hwhqdpe@pathway.suse.cz>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
 <20190918133419.7969-9-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918133419.7969-9-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 2019-09-18 16:34:14, Sakari Ailus wrote:
> %pS and %ps are now the preferred conversion specifiers to print function
> names. The functionality is equivalent; remove the old, deprecated %pF
> and %pf support.
> 
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

IMHO, we should do the same also in vbin_printf().

The compatibility with traceevent tools was discussed in the thread
https://lkml.kernel.org/r/20190910084707.18380-2-sakari.ailus@linux.intel.com

If I understand it correctly the tools should be able to handle stored
'f' and 'F' modifiers because they might be produced by
older kernels. But new kernels should not longer produce them.

Otherwise the patch looks good to me. I am getting used to the fact
that we will remove the obsolete specifiers completely.

Best Regards,
Petr
