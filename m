Return-Path: <linux-acpi+bounces-17688-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B940CBCA3DB
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 18:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69E6D4E307E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2F2253B0;
	Thu,  9 Oct 2025 16:50:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7F224AE0;
	Thu,  9 Oct 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028609; cv=none; b=OaZaa2WhEQiHfLm4ncKvvPoFc4p38qbGIs2JCbDMU16CCGjzG9FiupimHE251lq5OtoJEXHO2yO713nZwEJA0ouA/niGdiO5ZGWuabXf7kPwCsC7L4spFUDuj0R3eKq3C4cSlob27iGdBQYGi20eve6cLw0XdjYP38wcjxLZrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028609; c=relaxed/simple;
	bh=Ijua6s934Zl2ettZf36i1T8SQcqvr2v/Nxn/3mnV42E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYF1CIswsV4uyPVoLtHMr/7F31YziRsk9qYjUtHlPH5E6eeZafKnrTBN98T8/ejC9kFY0dspQTjOJnFinHHbjC59q9Ntw4gS0R8TYRF1YaerTRiIWO1xLNLSGHQHkNt38SAwOoEb4RMoaBbC0IrJEF3NPRARY5xVuaqYdAUJGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjG4t1CR7z6L4yc;
	Fri, 10 Oct 2025 00:47:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 44B5B1402F0;
	Fri, 10 Oct 2025 00:50:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 17:50:01 +0100
Date: Thu, 9 Oct 2025 17:49:59 +0100
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
Subject: Re: [PATCH v3 03/26] of/irq: Add IRQ affinity reporting interface
Message-ID: <20251009174959.00001b05@huawei.com>
In-Reply-To: <20250922082833.2038905-4-maz@kernel.org>
References: <20250922082833.2038905-1-maz@kernel.org>
	<20250922082833.2038905-4-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 22 Sep 2025 09:28:10 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Plug the irq_populate_fwspec_info() helper into the OF layer
> to offer an IRQ affinity reporting function.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Trivial comment inline but I don't care that much.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/of/irq.c       | 20 ++++++++++++++++++++
>  include/linux/of_irq.h |  7 +++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 74aaea61de13c..9a205cb033bda 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -479,6 +479,26 @@ int of_irq_get(struct device_node *dev, int index)
>  }
>  EXPORT_SYMBOL_GPL(of_irq_get);
>  
> +const struct cpumask *of_irq_get_affinity(struct device_node *dev, int index)
> +{
> +	struct of_phandle_args oirq;
> +	struct irq_fwspec_info info;
> +	struct irq_fwspec fwspec;
> +	int rc;
> +
> +	rc = of_irq_parse_one(dev, index, &oirq);
> +	if (rc)
> +		return NULL;
> +
> +	of_phandle_args_to_fwspec(oirq.np, oirq.args, oirq.args_count,
> +				  &fwspec);
> +
> +	if (!irq_populate_fwspec_info(&fwspec, &info))
> +		return info.affinity;
My slightly picky mental consistency filter suggests that this would look
more like the ACPI version as

	if (irq_populate_fwspec_info(&fwspec, &info))
		return NULL;

	return info.affinity;

But I don't really care.

> +
> +	return NULL;
> +}
> +


