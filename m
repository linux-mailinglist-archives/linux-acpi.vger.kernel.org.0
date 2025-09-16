Return-Path: <linux-acpi+bounces-17022-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D95B59BFC
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 17:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6743B11FF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24AB30C624;
	Tue, 16 Sep 2025 15:23:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376F2264B9;
	Tue, 16 Sep 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036233; cv=none; b=ELeMpoNuA2oUpBQzQXL1oxfBKhhYc8DxkMCDQ9qsNBbWe4haT/Xd97oz3GbWiI2sAjshHv+wh8aBRahYuusn7w/O7btl6Dcj65g2rgFHfr7yrqyeLFB7vP9wPAULuKvC/J1JDgAbPAqGqeOT2hsUD4CznWVrfTTlLfOn2Qj/6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036233; c=relaxed/simple;
	bh=g4i0GbhV8Gupkl6+HCLJ4rS1FEPqKZJWM/iUZMNtrjI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKR6SuzWx2p20qOn9QEMZvvJu8c4lyIwN1t4BoM62DRevoZ219cC7yF4Eo/AMA3WdCONhGgUbExmWArJR7z8xzGtQNYuxYKKVGZSxA72fjLjkB1alKA2GcgC7r1ldr4g3c5BoQsHq3f/ag0L7eAySWjJ3Yp1uj4fWi07x8w8TbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR5Fn6LWLz6K9K9;
	Tue, 16 Sep 2025 23:21:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A43D1402F0;
	Tue, 16 Sep 2025 23:23:49 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 17:23:48 +0200
Date: Tue, 16 Sep 2025 16:23:46 +0100
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
Subject: Re: [PATCH v2 04/25] platform: Add firmware-agnostic irq and
 affinity retrieval interface
Message-ID: <20250916162346.0000782a@huawei.com>
In-Reply-To: <20250915085702.519996-5-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
	<20250915085702.519996-5-maz@kernel.org>
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

On Mon, 15 Sep 2025 09:56:41 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Expand platform_get_irq_optional() to also return an affinity if
> available, renaming it to platform_get_irq_affinity() in the
> process.
> 
> platform_get_irq_optional() is preserved with its current semantics
> by calling into the new helper with a NULL affinity pointer.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/base/platform.c         | 60 +++++++++++++++++++++++++++------
>  include/linux/platform_device.h |  2 ++
>  2 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 09450349cf323..fad33d6b2349a 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c

>  /**
> - * platform_get_irq_optional - get an optional IRQ for a device
> + * platform_get_irq_affinity - get an optional IRQ and its affnity for a device

affinity

>   * @dev: platform device
>   * @num: IRQ number index
> + * @affinity: optional cpumask pointer to get the affinity of a per-cpu IRQ
>   *


> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 074754c23d330..ad66333ce85ce 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -102,6 +102,8 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
>  
>  extern int platform_get_irq(struct platform_device *, unsigned int);
>  extern int platform_get_irq_optional(struct platform_device *, unsigned int);
> +extern int platform_get_irq_affinity(struct platform_device *, unsigned int,
> +				     const struct cpumask **);
>  extern int platform_irq_count(struct platform_device *);
>  extern int devm_platform_get_irqs_affinity(struct platform_device *dev,
>  					   struct irq_affinity *affd,


