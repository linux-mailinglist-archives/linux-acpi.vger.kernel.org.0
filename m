Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DDA66BC4
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfGLLrq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jul 2019 07:47:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:20311 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfGLLrq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jul 2019 07:47:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2019 04:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,482,1557212400"; 
   d="scan'208";a="157116847"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga007.jf.intel.com with ESMTP; 12 Jul 2019 04:47:42 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hlu1c-0006I1-3T; Fri, 12 Jul 2019 14:47:40 +0300
Date:   Fri, 12 Jul 2019 14:47:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Busch <keith.busch@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] acpi: fix false-positive -Wuninitialized warning
Message-ID: <20190712114740.GX9224@smile.fi.intel.com>
References: <20190712090148.36582-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712090148.36582-1-arnd@arndb.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 12, 2019 at 11:01:21AM +0200, Arnd Bergmann wrote:
> clang gets confused by an uninitialized variable in what looks
> to it like a never executed code path:
> 
> arch/x86/kernel/acpi/boot.c:618:13: error: variable 'polarity' is uninitialized when used here [-Werror,-Wuninitialized]
>         polarity = polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>                    ^~~~~~~~
> arch/x86/kernel/acpi/boot.c:606:32: note: initialize the variable 'polarity' to silence this warning
>         int rc, irq, trigger, polarity;
>                                       ^
>                                        = 0
> arch/x86/kernel/acpi/boot.c:617:12: error: variable 'trigger' is uninitialized when used here [-Werror,-Wuninitialized]
>         trigger = trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>                   ^~~~~~~
> arch/x86/kernel/acpi/boot.c:606:22: note: initialize the variable 'trigger' to silence this warning
>         int rc, irq, trigger, polarity;
>                             ^
>                              = 0
> 
> This is unfortunately a design decision in clang and won't be fixed.
> 
> Changing the acpi_get_override_irq() macro to an inline function
> reliably avoids the issue.

In this particular case it looks fine (perhaps in the future -1 shall be
replaced with proper error code).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But in general it looks like clang obscures use of pretty well working macros.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/acpi.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a95cce5e82e7..9426b9aaed86 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -324,7 +324,10 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
>  #ifdef CONFIG_X86_IO_APIC
>  extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
>  #else
> -#define acpi_get_override_irq(gsi, trigger, polarity) (-1)
> +static inline int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity)
> +{
> +	return -1;
> +}
>  #endif
>  /*
>   * This function undoes the effect of one call to acpi_register_gsi().
> -- 
> 2.20.0
> 

-- 
With Best Regards,
Andy Shevchenko


