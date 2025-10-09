Return-Path: <linux-acpi+bounces-17689-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD50BCA504
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A68D353B2E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6D23371B;
	Thu,  9 Oct 2025 17:03:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55822B584;
	Thu,  9 Oct 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029439; cv=none; b=hc37KkTuQr/Db3Z4VvIBNQOTEGaEBTLcHnaj02b1vi135TvnTvSye/5rUdoEv1FAXak9nVFgKg0BwdSYXqG0IJk3zOu3orE0q2qhdVj7BhSxGPESTxyhnngQtTyhpSipMu08Ej4Gdf/nIGtdDa+NlteLBh/4Rrxnt7xcsBe35Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029439; c=relaxed/simple;
	bh=yMqD7LmueVOI1G4KF/wczSdi+WjbyGueTtyV+hDePzU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx7FbC9lpktuUAusXMagdRGwd/SUpigyTazyv5XNepxKZyu4ct3wguAj8O4FkHGqaa/4V2TWieE2lrPLZIWfzDG2wG15Vjvey88rM5pBf3Cn0XJWOY7X6P5mqePxnuK3u6U7OmHARg65jXQUP+OyDdW9SJhQRTSkGwyhfloy0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjGR31Pj7z67KQK;
	Fri, 10 Oct 2025 01:03:11 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 530081402E9;
	Fri, 10 Oct 2025 01:03:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 18:03:53 +0100
Date: Thu, 9 Oct 2025 18:03:51 +0100
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
Subject: Re: [PATCH v3 04/26] platform: Add firmware-agnostic irq and
 affinity retrieval interface
Message-ID: <20251009180351.00000d3d@huawei.com>
In-Reply-To: <20250922082833.2038905-5-maz@kernel.org>
References: <20250922082833.2038905-1-maz@kernel.org>
	<20250922082833.2038905-5-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 22 Sep 2025 09:28:11 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Expand platform_get_irq_optional() to also return an affinity if
> available, renaming it to platform_get_irq_affinity() in the
> process.
> 
> platform_get_irq_optional() is preserved with its current semantics
> by calling into the new helper with a NULL affinity pointer.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Maybe a breadcrumb of a comment for those of us who can't be bothered
to figure out why this needs the ifndef CONFIG_SPARC?

Otherwise a question on whether it's worth spinning a fwnode.h handler
to hide away the fwnode type in get_irq_affinity.
I think not given the complexity already there for the platform device
irq stuff, but thought I'd mention it.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/base/platform.c         | 60 +++++++++++++++++++++++++++------
>  include/linux/platform_device.h |  2 ++
>  2 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 09450349cf323..3a058f63ef0d3 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -150,25 +150,37 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
>  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
>  #endif /* CONFIG_HAS_IOMEM */
>  
> +static const struct cpumask *get_irq_affinity(struct platform_device *dev,
> +					      unsigned int num)
> +{
> +	const struct cpumask *mask = NULL;
> +#ifndef CONFIG_SPARC
> +	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
> +
> +	if (is_of_node(fwnode))
> +		mask = of_irq_get_affinity(to_of_node(fwnode), num);
> +	else if (is_acpi_device_node(fwnode))
> +		mask = acpi_irq_get_affinity(ACPI_HANDLE_FWNODE(fwnode), num);

Not sure how useful it will be more generally, but maybe use fwnode.h and
appropriate callback rather than opencoding here?

Mind you the extra handling in existing platform_get_irq_optional()
for corner cases doesn't really fit with that model.

> +#endif
> +
> +	return mask ?: cpu_possible_mask;
> +}


