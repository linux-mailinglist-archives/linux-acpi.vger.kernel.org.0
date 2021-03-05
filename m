Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F732EC48
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCENfK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 08:35:10 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44422 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhCENew (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 08:34:52 -0500
Received: by mail-oi1-f178.google.com with SMTP id x20so2470406oie.11;
        Fri, 05 Mar 2021 05:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Mx6ZToxOtXCF5d9Uj1GVvv2nmYAp8tY/BxTFwwTgYQ=;
        b=TnLw8Ne9mrDs6+dRbOyH2CJbNWEwZdakfqBASIH6ItoE/zDe832/EHbFNsg+blsxip
         6xT1+FkQosnUy4aLMRQA7tXmtZvnl2tlvmO9wCHz8Ntrm6MwPBlRoJjj7zGJsBYJQoeM
         vfdT0mraOkEVpucgunT98JnNAEUotWa2g8fR3Tya6CI3FsCDqdoei4GnJSAKM2pL+RzS
         qzKjNSTz3Vvc/mgBeWOBJ5P8GtC8kLkyYig93PgRhCWBfvVXy2pQQhdUiBp7q9L+BaTE
         3NqrPqqfCBkK834HF7YBiaq61azY+WyMcl6UgZjEXd+QSnfgLNzMpJ4tProipktXeX+F
         DIuA==
X-Gm-Message-State: AOAM5304wFjwu0B2IYkfxSXyM5jN5C1PuF9nDp7lXh/pDUjYhTEi1g4d
        gJYa2lVuSrvXBra+ojtBCzBhmwWTkJQRPa702Lo=
X-Google-Smtp-Source: ABdhPJzbtT78Lvi4GCyhCQlxyP4bAma6cv3iJOfvr/g4xDNpjEl0dKlTkHX5E/7XfVPZDtAhALDRV/S4NJ7HXmquwT0=
X-Received: by 2002:aca:f245:: with SMTP id q66mr6881439oih.69.1614951292035;
 Fri, 05 Mar 2021 05:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com> <20210304201253.14652-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210304201253.14652-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Mar 2021 14:34:40 +0100
Message-ID: <CAJZ5v0io925Fjua0GDKkCLnQZBjg=5ffRFzCc==_+ygSd7t4Ew@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] irqdomain: Introduce irq_domain_create_simple() API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 4, 2021 at 9:13 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
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

This requires an ACK from Marc or Thomas so I can apply it.

> ---
>  Documentation/core-api/irq/irq-domain.rst | 22 ++++++++++++----------
>  include/linux/irqdomain.h                 | 19 ++++++++++++++-----
>  kernel/irq/irqdomain.c                    | 20 ++++++++++----------
>  3 files changed, 36 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
> index a77c24c27f7b..8214e215a8bf 100644
> --- a/Documentation/core-api/irq/irq-domain.rst
> +++ b/Documentation/core-api/irq/irq-domain.rst
> @@ -42,10 +42,10 @@ irq_domain usage
>  ================
>
>  An interrupt controller driver creates and registers an irq_domain by
> -calling one of the irq_domain_add_*() functions (each mapping method
> -has a different allocator function, more on that later).  The function
> -will return a pointer to the irq_domain on success.  The caller must
> -provide the allocator function with an irq_domain_ops structure.
> +calling one of the irq_domain_add_*() or irq_domain_create_*() functions
> +(each mapping method has a different allocator function, more on that later).
> +The function will return a pointer to the irq_domain on success. The caller
> +must provide the allocator function with an irq_domain_ops structure.
>
>  In most cases, the irq_domain will begin empty without any mappings
>  between hwirq and IRQ numbers.  Mappings are added to the irq_domain
> @@ -147,6 +147,7 @@ Legacy
>         irq_domain_add_simple()
>         irq_domain_add_legacy()
>         irq_domain_add_legacy_isa()
> +       irq_domain_create_simple()
>         irq_domain_create_legacy()
>
>  The Legacy mapping is a special case for drivers that already have a
> @@ -169,13 +170,13 @@ supported.  For example, ISA controllers would use the legacy map for
>  mapping Linux IRQs 0-15 so that existing ISA drivers get the correct IRQ
>  numbers.
>
> -Most users of legacy mappings should use irq_domain_add_simple() which
> -will use a legacy domain only if an IRQ range is supplied by the
> -system and will otherwise use a linear domain mapping. The semantics
> -of this call are such that if an IRQ range is specified then
> +Most users of legacy mappings should use irq_domain_add_simple() or
> +irq_domain_create_simple() which will use a legacy domain only if an IRQ range
> +is supplied by the system and will otherwise use a linear domain mapping.
> +The semantics of this call are such that if an IRQ range is specified then
>  descriptors will be allocated on-the-fly for it, and if no range is
> -specified it will fall through to irq_domain_add_linear() which means
> -*no* irq descriptors will be allocated.
> +specified it will fall through to irq_domain_add_linear() or
> +irq_domain_create_linear() which means *no* irq descriptors will be allocated.
>
>  A typical use case for simple domains is where an irqchip provider
>  is supporting both dynamic and static IRQ assignments.
> @@ -186,6 +187,7 @@ that the driver using the simple domain call irq_create_mapping()
>  before any irq_find_mapping() since the latter will actually work
>  for the static IRQ assignment case.
>
> +irq_domain_add_simple() and irq_domain_create_simple() as well as
>  irq_domain_add_legacy() and irq_domain_create_legacy() are functionally
>  equivalent, except for the first argument is different - the former
>  accepts an Open Firmware specific 'struct device_node', while the latter
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 42d196805f58..6e78f5909723 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -260,11 +260,11 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
>                                     irq_hw_number_t hwirq_max, int direct_max,
>                                     const struct irq_domain_ops *ops,
>                                     void *host_data);
> -struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
> -                                        unsigned int size,
> -                                        unsigned int first_irq,
> -                                        const struct irq_domain_ops *ops,
> -                                        void *host_data);
> +struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
> +                                           unsigned int size,
> +                                           unsigned int first_irq,
> +                                           const struct irq_domain_ops *ops,
> +                                           void *host_data);
>  struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
>                                          unsigned int size,
>                                          unsigned int first_irq,
> @@ -329,6 +329,15 @@ static inline struct irq_domain *irq_find_host(struct device_node *node)
>         return d;
>  }
>
> +static inline struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
> +                                                      unsigned int size,
> +                                                      unsigned int first_irq,
> +                                                      const struct irq_domain_ops *ops,
> +                                                      void *host_data)
> +{
> +       return irq_domain_create_simple(of_node_to_fwnode(of_node), size, first_irq, ops, host_data);
> +}
> +
>  /**
>   * irq_domain_add_linear() - Allocate and register a linear revmap irq_domain.
>   * @of_node: pointer to interrupt controller's device tree node.
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 288151393a06..a7f4028971e4 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -295,8 +295,8 @@ void irq_domain_update_bus_token(struct irq_domain *domain,
>  EXPORT_SYMBOL_GPL(irq_domain_update_bus_token);
>
>  /**
> - * irq_domain_add_simple() - Register an irq_domain and optionally map a range of irqs
> - * @of_node: pointer to interrupt controller's device tree node.
> + * irq_domain_create_simple() - Register an irq_domain and optionally map a range of irqs
> + * @fwnode: firmware node for the interrupt controller
>   * @size: total number of irqs in mapping
>   * @first_irq: first number of irq block assigned to the domain,
>   *     pass zero to assign irqs on-the-fly. If first_irq is non-zero, then
> @@ -312,15 +312,15 @@ EXPORT_SYMBOL_GPL(irq_domain_update_bus_token);
>   * irqs get mapped dynamically on the fly. However, if the controller requires
>   * static virq assignments (non-DT boot) then it will set that up correctly.
>   */
> -struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
> -                                        unsigned int size,
> -                                        unsigned int first_irq,
> -                                        const struct irq_domain_ops *ops,
> -                                        void *host_data)
> +struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
> +                                           unsigned int size,
> +                                           unsigned int first_irq,
> +                                           const struct irq_domain_ops *ops,
> +                                           void *host_data)
>  {
>         struct irq_domain *domain;
>
> -       domain = __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, host_data);
> +       domain = __irq_domain_add(fwnode, size, size, 0, ops, host_data);
>         if (!domain)
>                 return NULL;
>
> @@ -328,7 +328,7 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
>                 if (IS_ENABLED(CONFIG_SPARSE_IRQ)) {
>                         /* attempt to allocated irq_descs */
>                         int rc = irq_alloc_descs(first_irq, first_irq, size,
> -                                                of_node_to_nid(of_node));
> +                                                of_node_to_nid(to_of_node(fwnode)));
>                         if (rc < 0)
>                                 pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>                                         first_irq);
> @@ -338,7 +338,7 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
>
>         return domain;
>  }
> -EXPORT_SYMBOL_GPL(irq_domain_add_simple);
> +EXPORT_SYMBOL_GPL(irq_domain_create_simple);
>
>  /**
>   * irq_domain_add_legacy() - Allocate and register a legacy revmap irq_domain.
> --
> 2.30.1
>
