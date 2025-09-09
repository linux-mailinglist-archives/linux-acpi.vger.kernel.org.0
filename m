Return-Path: <linux-acpi+bounces-16522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF873B4A802
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 11:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0BF1C612D4
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E8C29BD9B;
	Tue,  9 Sep 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ysdAX9a7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wuIsSYus"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC629B8E0;
	Tue,  9 Sep 2025 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409486; cv=none; b=c81iLxdYe1Feomgq99Tsubax8ovXFNBKd9ICRKDSnciazI5p9SOPeTkzPKS2WXLoKR8hgv0w1jfniO7eOtVdCxfQXiTaVOsXUHjxNJNgRgbt+KGa9ygigIjIWuNZ2L5u1BZkDil4Ft6G+IT/jrybwP2FBJaWYMQyGvchh6GAkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409486; c=relaxed/simple;
	bh=TNqOQENCwuVDFPKzAkcwPJNE66Ne4tfmwkG5kuFdEtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BLpxUZ7Iq84EhrzJdZPbxPSKDMvP88X/H/PJD1VRUmsZe6eARC35kU+YQjQv/J45t5RV/oHEhUAHOqFSOKihuXJNgeA7H7xqloNeW+NHlZq/vIQtioCW6X1nr3zqufL82SnL2oFFQtLd//4YxOEepUlqNJyqcfY5oRRnqAwIXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ysdAX9a7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wuIsSYus; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757409483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DyGoWBCJrIVU2lZonI26bVfo/Kr7IC665y1ClCQUDV4=;
	b=ysdAX9a7kn7T9QlMJmRJpgsDVriVX93E2TCUtnhpkYmACln7+MeOu/IkNoRCq3XmGB7ki2
	bbCNB9ZX8Xc+6obauVhjevhcE6OTbMNARbbUL5Fa4eOgFxnTR9PK32EBshHIwXqaoPD/cM
	5ziG8OQhT683Prb62Ap8AbWTPV9UXhdtfJ5jsPVVv0F7PETtY2WRWur4aDKnQaxIKS9hYT
	qLTe2zKno7QPu6O9tA9hGWrKjDLkitTp10IF0F0AOUPv6p6BrBPYNx5b5Y2Cf2QLvpDBPK
	QHUZI0tufr2Ji002cXTtvyZZ6Eu9zZyCjHIzARrC9dB2YyOGxSgisrHV5+53cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757409483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DyGoWBCJrIVU2lZonI26bVfo/Kr7IC665y1ClCQUDV4=;
	b=wuIsSYusPYyMgMlU/Aut0z+gBUeiKg4JHx72+DsH1XpcB2lw7TLJa4RQYNcqrVl5SeMkBW
	i4oPdIUi+1IEp/DQ==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
 <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
 <james.clark@linaro.org>
Subject: Re: [PATCH 01/25] irqdomain: Add firmware info reporting interface
In-Reply-To: <20250908163127.2462948-2-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
 <20250908163127.2462948-2-maz@kernel.org>
Date: Tue, 09 Sep 2025 11:18:01 +0200
Message-ID: <87ikhsvvau.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 08 2025 at 17:31, Marc Zyngier wrote:
> +/**
> + * struct irq_fwspec_info - firmware provided IRQ information structure
> + *
> + * @fwspec:		IRQ specifier

s/IRQ/interrupt/g

> + * @cpumask:		Affinity mask for this interrupt
> + * @flags:		Information validity flags
> + *
> + * This structure reports firmware-specific information about an
> + * interrupt. The only significant information is the affinity of a
> + * per-CPU interrupt, but this is designed to be extended as required.
> + */
> +struct irq_fwspec_info {
> +	struct irq_fwspec	fwspec;
> +	const struct cpumask	*affinity;
> +
> +#define IRQ_FWSPEC_INFO_FWSPEC_VALID	BIT(0)
> +#define IRQ_FWSPEC_INFO_AFFINITY_VALID	BIT(1)
> +
> +	unsigned long		flags;

Can you please not stick the defines into the struct. That makes my eyes
bleed.

Also the ordering looks strange as flags should be before the fields it
validates for readability sake, no?

> +};
> +
>  /* Conversion function from of_phandle_args fields to fwspec  */
>  void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
>  			       unsigned int count, struct irq_fwspec *fwspec);
> @@ -69,6 +90,8 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
>   * @translate:	Given @fwspec, decode the hardware irq number (@out_hwirq) and
>   *		linux irq type value (@out_type). This is a generalised @xlate
>   *		(over struct irq_fwspec) and is preferred if provided.
> + * @get_info: Given @info, report additional firmware-provided information.
> + *            Optional.

get_info() is pretty generic. Can we have some more descriptive name for
that? Also please keep the tabular formatting of the doc intact.

>   * @debug_show:	For domains to show specific data for an interrupt in debugfs.
>   *
>   * Functions below are provided by the driver and called whenever a new mapping
> @@ -96,6 +119,7 @@ struct irq_domain_ops {
>  	void	(*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
>  	int	(*translate)(struct irq_domain *d, struct irq_fwspec *fwspec,
>  			     unsigned long *out_hwirq, unsigned int *out_type);
> +	int (*get_info)(struct irq_fwspec_info *info);

TAB between int and '(*'

>  #endif
>  #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
>  	void	(*debug_show)(struct seq_file *m, struct irq_domain *d,
> @@ -602,6 +626,8 @@ void irq_domain_free_irqs_parent(struct irq_domain *domain, unsigned int irq_bas
>  
>  int irq_domain_disconnect_hierarchy(struct irq_domain *domain, unsigned int virq);
>  
> +int irq_populate_fwspec_info(struct irq_fwspec_info *info);
> +
> +
> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY

Stray TAB

> +int irq_populate_fwspec_info(struct irq_fwspec_info *info)
> +{
> +	struct irq_domain *domain;
> +
> +	domain = fwspec_to_domain(&info->fwspec);

Just move that to the declaration line

> +	if (!domain || !domain->ops->get_info) {
> +		info->flags = 0;
> +		return 0;
> +	}
> +
> +	return domain->ops->get_info(info);
> +}
> +#endif
> +
> +unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> +{
> +	struct irq_domain *domain;
> +	struct irq_data *irq_data;
> +	irq_hw_number_t hwirq;
> +	unsigned int type = IRQ_TYPE_NONE;

I know you moved it from the original function, but can you please
reorder it in reverse fir tree order?

> +	int virq;
> +
> +	domain = fwspec_to_domain(fwspec);
>  	if (!domain) {
>  		pr_warn("no irq domain found for %s !\n",
>  			of_node_full_name(to_of_node(fwspec->fwnode)));

Thanks,

        tglx

