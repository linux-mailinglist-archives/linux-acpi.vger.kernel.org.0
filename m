Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B51DC923
	for <lists+linux-acpi@lfdr.de>; Thu, 21 May 2020 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgEUJAA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 May 2020 05:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgEUJAA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 May 2020 05:00:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F88220738;
        Thu, 21 May 2020 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590051599;
        bh=OF167bw6TAO1xV/ri9mfdhSX8/TqgsxqTsszhaeYVdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KeCVzphIBaDgUS+6LJznJ8wiNmY8Akr6xMkMYcd1JAOfb2/Oi/J2nZAc8vhZTzNwg
         DEFCndWqrLgyluhcEJFf6/4ffV3dLi9Xl2aLNPQrJvdAK6Wz9F0r/D/fhwjFk2ExF5
         7Ah8nsBe6BQRRv41EihksT9U8HLjs8ei3N8oqDxM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jbh3V-00EBYj-Pi; Thu, 21 May 2020 09:59:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 May 2020 09:59:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 3/3] irqdomain: Allow software node to be correct one
 for IRQ domain
In-Reply-To: <20200520164927.39090-3-andriy.shevchenko@linux.intel.com>
References: <20200520164927.39090-1-andriy.shevchenko@linux.intel.com>
 <20200520164927.39090-3-andriy.shevchenko@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <c7432ac8e2564c1c2177ef6e71f252ac@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: andriy.shevchenko@linux.intel.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On 2020-05-20 17:49, Andy Shevchenko wrote:
> In some cases we might need to have an IRQ domain created out of 
> software node.
> One of such cases is DesignWare GPIO driver when it's instantiated from
> half-baked ACPI table (alas, we can't fix it for devices which are few 
> years
> on market) and thus using software nodes to quirk this up. But the 
> driver
> is using IRQ domains based on per GPIO port firmware nodes, which are 
> in
> the above case software ones. This brings a warning message to be 
> printed
> 
>   [   73.957183] irq: Invalid fwnode type for irqdomain
> 
> and creates an unknown IRQ domain.
> 
> When we allow software node to be correct one for IRQ domain we will
> get rid of the warning message and nice domain name at the same time:
> 
>   % ls -1 /sys/kernel/debug/irq/domains/
>   ...
>   intel-quark-dw-apb-gpio:portA
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/irq/irqdomain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index c6204bc606a2..e4ebc5398ef5 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -161,7 +161,8 @@ struct irq_domain *__irq_domain_add(struct
> fwnode_handle *fwnode, int size,
>  			domain->name = fwid->name;
>  			break;
>  		}
> -	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode)) {
> +	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
> +		   is_software_node(fwnode)) {
>  		char *name;
> 
>  		/*

Thanks for this. I've applied it to irqchip-next. In the future,
please consider adding a cover letter describing the overall
goal of the series.

Cheers,

         M.
-- 
Jazz is not dead. It just smells funny...
