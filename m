Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670D56CB1A
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2019 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfGRIn0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jul 2019 04:43:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42886 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfGRIn0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jul 2019 04:43:26 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id dfed748a61dd19f0; Thu, 18 Jul 2019 10:43:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] acpi: blacklist: fix clang warning for unused dmi table
Date:   Thu, 18 Jul 2019 10:43:24 +0200
Message-ID: <1742900.Dcq75AOoeW@kreacher>
In-Reply-To: <20190710130555.1829974-1-arnd@arndb.de>
References: <20190710130555.1829974-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, July 10, 2019 3:05:43 PM CEST Arnd Bergmann wrote:
> When CONFIG_DMI is disabled, we only have a tentative declaration,
> which causes a warning from clang:
> 
> drivers/acpi/blacklist.c:20:35: error: tentative array definition assumed to have one element [-Werror]
> static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;
> 
> As the variable is not actually used here, hide it entirely
> in an #ifdef to shut up the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/blacklist.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index ad2c565f5cbe..a86a770c9b79 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -17,7 +17,9 @@
>  
>  #include "internal.h"
>  
> +#ifdef CONFIG_DMI
>  static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;
> +#endif
>  
>  /*
>   * POLICY: If *anything* doesn't work, put it on the blacklist.
> @@ -61,7 +63,9 @@ int __init acpi_blacklisted(void)
>  	}
>  
>  	(void)early_acpi_osi_init();
> +#ifdef CONFIG_DMI
>  	dmi_check_system(acpi_rev_dmi_table);
> +#endif
>  
>  	return blacklisted;
>  }
> 

Applied, thanks!




