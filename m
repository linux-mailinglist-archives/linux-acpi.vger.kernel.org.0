Return-Path: <linux-acpi+bounces-17020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D29DB59BBC
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F6C7A639F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222230DD31;
	Tue, 16 Sep 2025 15:14:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D920DD42;
	Tue, 16 Sep 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035687; cv=none; b=P2YHezqoSl14Vc2wEjEXoTg5TZWGvL/bIwXDqy8etCwkvHThnMj7QuQ02cQ5Z75B1PQiS6/CrdBoWgmnTjeagjw72xO6AN1cTJHzJ5iiPX44S34o8P4ao6+cyyiggVwIAfy4Lc6VQICs3PA07K1MUA6gEyjO4jbMXcHq7Zgazzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035687; c=relaxed/simple;
	bh=20RBLfRYEQ3Ms+slM0SmtO9IunpLQPQy9nACa/Usmtw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQxoy0dnLH+tioHanz67OBo93IKv+K4tsBdCZzO95yZWGHEpusSQTDKKDI7cOaeOrqtLBLx/sbhuGbI0MjpzZz8uSWmwjvAr/N7i6kxI5QZ9JZN6wnCtjiris4IVQLA9a4K/4VIYb4GN44duQVqi7SwgDvu9DeH1jdEw6yAszvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR51H4rn2z6K6F8;
	Tue, 16 Sep 2025 23:10:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E3CB31402F5;
	Tue, 16 Sep 2025 23:14:40 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 17:14:40 +0200
Date: Tue, 16 Sep 2025 16:14:38 +0100
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
Subject: Re: [PATCH v2 01/25] irqdomain: Add firmware info reporting
 interface
Message-ID: <20250916161438.00007ba0@huawei.com>
In-Reply-To: <20250915085702.519996-2-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
	<20250915085702.519996-2-maz@kernel.org>
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

On Mon, 15 Sep 2025 09:56:38 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Allow an irqdomain callback to report firmware-provided information
> that is otherwise not available in a generic way. This is reported
> using a new data structure (struct irq_fwspec_info).
> 
> This callback is optional and the only information that can be
> reported currently is the affinity of an interrupt. However, the
> containing structure is designed to be extensible, allowing other
> potentially relevant information to be reported in the future.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Hi Marc,

> ---
>  include/linux/irqdomain.h | 28 ++++++++++++++++++++++++++++
>  kernel/irq/irqdomain.c    | 32 +++++++++++++++++++++++++++-----
>  2 files changed, 55 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 4a86e6b915dd6..34993bf8293c4 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -44,6 +44,24 @@ struct irq_fwspec {
>  	u32			param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
>  };
>  
> +/**
> + * struct irq_fwspec_info - firmware provided IRQ information structure
> + *
> + * @fwspec:		Firmware-specific interrupt specifier

Not aligning with what is in the structure that I can see.

> + * @cpumask:		Affinity mask for this interrupt
> + * @flags:		Information validity flags
> + *
> + * This structure reports firmware-specific information about an
> + * interrupt. The only significant information is the affinity of a
> + * per-CPU interrupt, but this is designed to be extended as required.
> + */
> +struct irq_fwspec_info {
> +	unsigned long		flags;
> +	const struct cpumask	*affinity;
> +};



