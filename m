Return-Path: <linux-acpi+bounces-17023-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C4B59C21
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 17:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9141C02A97
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CFF368086;
	Tue, 16 Sep 2025 15:34:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC635AAA6;
	Tue, 16 Sep 2025 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036862; cv=none; b=jni01H1lyrs+yPJ40+mHYsteLu8FhbtY2Q4dhdnX5YYYtd6CBzGJp+xq3PfXI71cqCin3mAcq1p9gMPqAWyQp9SXnxWcAHw8GmrefKrFQb1lu8ONOc/t+3MBZ7p87v4lBsBR/eIZ7Q+XjzszsKlMrjVi9WK+Y8kKNbo6GwBTEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036862; c=relaxed/simple;
	bh=WMNZWQPLraTq95QhBCPX0vhvrO6yH76oEZItWV5IJ+w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1hl58sqAIm9Sm8sJRzWwHFb2CwHbctafp9IEn9KLiDIv9FVwGUy18RhpU6ze9s3pWYVpd4XbVFwa9d91gdRxiawBm4i21CCbI/Eio/szJZAXrwlJU+OBSRyf4NmHSFY4l7ixJ5LqZ7NLK21JbttpE2es4VoS9G2ZNFduPrCi3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR5Ts2J1Zz6K9H6;
	Tue, 16 Sep 2025 23:31:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 959C21402FC;
	Tue, 16 Sep 2025 23:34:16 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 17:34:15 +0200
Date: Tue, 16 Sep 2025 16:34:13 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Mark
 Rutland" <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
	<j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
	<james.clark@linaro.org>
Subject: Re: [PATCH v2 05/25] irqchip/gic-v3: Add FW info retrieval support
Message-ID: <20250916163413.000062f0@huawei.com>
In-Reply-To: <20250915085702.519996-6-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
	<20250915085702.519996-6-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 15 Sep 2025 09:56:42 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Plug the new .get_info() callback into the GICv3 core driver,
> using some of the existing PPI affinity handling infrastructure.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Hi Marc,

Yet another trivial comment. It's one of those days it seems :)

> ---
>  drivers/irqchip/irq-gic-v3.c | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index dbeb85677b08c..71c278ddd1e39 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -69,6 +69,8 @@ struct gic_chip_data {
>  	bool			has_rss;
>  	unsigned int		ppi_nr;
>  	struct partition_desc	**ppi_descs;
> +	struct partition_affinity *parts;
> +	unsigned int		nr_parts;
>  };
>  
>  #define T241_CHIPS_MAX		4
> @@ -1796,11 +1798,58 @@ static int gic_irq_domain_select(struct irq_domain *d,
>  	return d == partition_get_domain(gic_data.ppi_descs[ppi_idx]);
>  }
>  
> +static int gic_irq_get_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_info *info)
> +{
> +	const struct cpumask *mask = NULL;
> +
> +	info->flags = 0;
> +	info->affinity = NULL;
> +
> +	/* ACPI is not capable of describing PPI affinity -- yet */
> +	if (!is_of_node(fwspec->fwnode))
> +		return 0;
> +
> +	/* If the specifier provides an affinity, use it */
> +	if (fwspec->param_count == 4 && fwspec->param[3]) {
> +		struct fwnode_handle *fw;
> +
> +		switch (fwspec->param[0]) {
> +		case 1:			/* PPI */
> +		case 3:			/* EPPI */
> +			break;
> +		default:
> +			return 0;
> +		}
> +
> +		fw = of_node_to_fwnode(of_find_node_by_phandle(fwspec->param[3]));

of_node_to_fwnode() has a note that says it'll be removed in the merge window.
It was enough of an oddity I wondered why it existed.

Of course it did say it would be removed in the previous merge window and wasn't...
Probably want of_fwnode_handle()



> +		if (!fw)
> +			return -ENOENT;
> +
> +		for (int i = 0; i < gic_data.nr_parts; i++) {
> +			if (gic_data.parts[i].partition_id == fw) {
> +				mask = &gic_data.parts[i].mask;
> +				break;
> +			}
> +		}
> +
> +		if (!mask)
> +			return -ENOENT;
> +	} else {
> +		mask = cpu_possible_mask;
> +	}
> +
> +	info->affinity = mask;
> +	info->flags = IRQ_FWSPEC_INFO_AFFINITY_VALID;
> +
> +	return 0;



