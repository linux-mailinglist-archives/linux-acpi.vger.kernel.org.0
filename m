Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA66CB14
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2019 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbfGRImq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jul 2019 04:42:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58046 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRImq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jul 2019 04:42:46 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 52ae64ba30307854; Thu, 18 Jul 2019 10:42:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Busch <keith.busch@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] acpi: fix false-positive -Wuninitialized warning
Date:   Thu, 18 Jul 2019 10:42:43 +0200
Message-ID: <7785979.oluxICSiVJ@kreacher>
In-Reply-To: <20190712090148.36582-1-arnd@arndb.de>
References: <20190712090148.36582-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, July 12, 2019 11:01:21 AM CEST Arnd Bergmann wrote:
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
> 

Applied, thanks!




