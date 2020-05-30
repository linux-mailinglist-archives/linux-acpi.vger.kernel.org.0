Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707C61E9019
	for <lists+linux-acpi@lfdr.de>; Sat, 30 May 2020 11:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgE3Jez (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 May 2020 05:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgE3Jez (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 30 May 2020 05:34:55 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 399D420776;
        Sat, 30 May 2020 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590831294;
        bh=cnzA5tk70oUMN1xavPXuXqS1gyDfBDfKfmW9R6LENeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=afSN9k+Pnz25M3k6V81ZfUhf+aa07mHbRs0ZOwQNgydwOI0qbGo+BG19nTp60pXxE
         RoU9Uyf0O90HOI4P6/L+Q/O88mjI2amYWp2qK5fo1AzcK/qRZkIQIpnDR2yN20caIB
         siiIVmR0CUTFH+Edx5VfoUxCArkPhJepzSJ0OfJM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jextE-00GTTu-5V; Sat, 30 May 2020 10:34:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 30 May 2020 10:34:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drivers/irqchip: Use new macro
 ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
In-Reply-To: <20200529171847.10267-3-oscar.carter@gmx.com>
References: <20200529171847.10267-1-oscar.carter@gmx.com>
 <20200529171847.10267-3-oscar.carter@gmx.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <590725ccfadc6e6c84c777f69ee02a62@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: oscar.carter@gmx.com, keescook@chromium.org, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lenb@kernel.org, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Oscar,

On 2020-05-29 18:18, Oscar Carter wrote:
> In an effort to enable -Wcast-function-type in the top-level Makefile 
> to
> support Control Flow Integrity builds, there are the need to remove all
> the function callback casts.
> 
> To do this, modify the IRQCHIP_ACPI_DECLARE macro to use the new 
> defined
> macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY instead of the macro
> ACPI_DECLARE_PROBE_ENTRY. This is necessary to be able to initialize 
> the
> the acpi_probe_entry struct using the probe_subtbl field instead of the
> probe_table field and avoid function cast mismatches.
> 
> Also, modify the prototype of the functions used by the invocation of 
> the
> IRQCHIP_ACPI_DECLARE macro to match all the parameters.
> 
> Co-developed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  drivers/irqchip/irq-gic.c    | 2 +-
>  include/linux/irqchip.h      | 5 +++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c 
> b/drivers/irqchip/irq-gic-v3.c
> index d7006ef18a0d..3870e9d4d3a8 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2117,7 +2117,7 @@ static void __init gic_acpi_setup_kvm_info(void)
>  }
> 
>  static int __init
> -gic_acpi_init(struct acpi_subtable_header *header, const unsigned long 
> end)
> +gic_acpi_init(union acpi_subtable_headers *header, const unsigned long 
> end)
>  {
>  	struct acpi_madt_generic_distributor *dist;
>  	struct fwnode_handle *domain_handle;
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 30ab623343d3..fc431857ce90 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1593,7 +1593,7 @@ static void __init gic_acpi_setup_kvm_info(void)
>  	gic_set_kvm_info(&gic_v2_kvm_info);
>  }
> 
> -static int __init gic_v2_acpi_init(struct acpi_subtable_header 
> *header,
> +static int __init gic_v2_acpi_init(union acpi_subtable_headers 
> *header,
>  				   const unsigned long end)
>  {
>  	struct acpi_madt_generic_distributor *dist;
> diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
> index 950e4b2458f0..447f22880a69 100644
> --- a/include/linux/irqchip.h
> +++ b/include647b532275bbe/linux/irqchip.h
> @@ -39,8 +39,9 @@
>   * @fn: initialization function
>   */
>  #define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
> -	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
> -				 subtable, validate, data, fn)
> +	ACPI_DECLARE_SUBTABLE_PROBE_ENTRY(irqchip, name,		\
> +					  ACPI_SIG_MADT, subtable,	\
> +					  validate, data, fn)
> 
>  #ifdef CONFIG_IRQCHIP
>  void irqchip_init(void);
> --
> 2.20.1

I can't help but notice that you have left the cast in 
ACPI_DECLARE_PROBE_ENTRY, which should definitely go. Probably worth a 
third patch.

Thanks,

         M.

-- 
Jazz is not dead. It just smells funny...
