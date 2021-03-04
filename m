Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE03032D979
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 19:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhCDSag (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 13:30:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232311AbhCDSaP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 13:30:15 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359EE64F62;
        Thu,  4 Mar 2021 18:29:35 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lHsj7-00HJII-32; Thu, 04 Mar 2021 18:29:33 +0000
Date:   Thu, 04 Mar 2021 18:29:32 +0000
Message-ID: <87lfb2zsab.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] irqdomain: Introduce irq_domain_create_simple() API
In-Reply-To: <20210304150215.80652-2-andriy.shevchenko@linux.intel.com>
References: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com>
        <20210304150215.80652-2-andriy.shevchenko@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, mika.westerberg@linux.intel.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, corbet@lwn.net, bgolaszewski@baylibre.com, tglx@linutronix.de, rafael@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Andy,

On Thu, 04 Mar 2021 15:02:11 +0000,
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> Linus Walleij pointed out that ird_domain_add_simple() gained
> additional functionality and can't be anymore replaced with
> a simple conditional. In preparation to upgrade GPIO library
> to use fwnode, introduce irq_domain_create_simple() API which is
> functional equivalent to the existing irq_domain_add_simple(),
> but takes a pointer to the struct fwnode_handle as a parameter.
> 
> While at it, amend documentation to mention irq_domain_create_*()
> functions where it makes sense.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[...]

> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 42d196805f58..1d4a8e7c5d5f 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -265,6 +265,11 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
>  					 unsigned int first_irq,
>  					 const struct irq_domain_ops *ops,
>  					 void *host_data);
> +struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
> +					    unsigned int size,
> +					    unsigned int first_irq,
> +					    const struct irq_domain_ops *ops,
> +					    void *host_data);
>  struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
>  					 unsigned int size,
>  					 unsigned int first_irq,
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 288151393a06..418548ea13cf 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -317,10 +317,20 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
>  					 unsigned int first_irq,
>  					 const struct irq_domain_ops *ops,
>  					 void *host_data)
> +{
> +	return irq_domain_create_simple(of_node_to_fwnode(of_node), size, first_irq, ops, host_data);
> +}
> +EXPORT_SYMBOL_GPL(irq_domain_add_simple);

Please move this as an inline helper in linux/irqdomain.h, so that we
can drop this export altogether.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
