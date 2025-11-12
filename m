Return-Path: <linux-acpi+bounces-18825-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1BC53E45
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 19:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C4DE4EA4DD
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD4347BC4;
	Wed, 12 Nov 2025 18:13:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D0E34575A;
	Wed, 12 Nov 2025 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971205; cv=none; b=kSSK+j2yyoYcwqr5UNqmPy99GGfjtm9kwWTw/mq0A4mNiN5hnw8chefilLLuEJ7YORIl4acNJuw37JYbj1NSrAxaSmOm5m+IJIBUQ47sQ1zvDhiD2eI5Sz8BQ/8OFS44RcizROr7RIY1v7j0sJQpLReefZL8dM/NzcwjtraJp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971205; c=relaxed/simple;
	bh=/1PJ1i8JUkAb12Mt1GVCayhNAx3IxRmlR4TZVdJPJEE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TE90o3pj2qFuoWDcZ9sI2hfVTEPKnZul+ThG/kO3i4ji4jEQIplsR5oyOVONtsYHfO5J0oN5/CQr7GUAIr/HSd3swczAbWsW8L6YtJSW8MrRkFysxmDB8nS5ZpJ1i3xlqIw/+ohGTr/bwauwPsSfeZHEdy+9rcByZ3xx79ZzegU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6BMg65WmzJ46bC;
	Thu, 13 Nov 2025 02:12:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id ADCDA1400D9;
	Thu, 13 Nov 2025 02:13:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 18:13:19 +0000
Date: Wed, 12 Nov 2025 18:13:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Mark
 Rutland" <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
	<j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
	<james.clark@linaro.org>, Jinjie Ruan <ruanjinjie@huawei.com>, "Alexandru
 Elisei" <alexandru.elisei@arm.com>
Subject: Re: [PATCH v4 14/26] genirq: Add affinity to percpu_devid interrupt
 requests
Message-ID: <20251112181318.000064be@huawei.com>
In-Reply-To: <20251020122944.3074811-15-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
	<20251020122944.3074811-15-maz@kernel.org>
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

On Mon, 20 Oct 2025 13:29:31 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Add an affinity field to both the irqaction structure and the interrupt
> request primitives. Nothing is making use of it yet, and the only value
> used it NULL, which is used as a shorthand for cpu_possible_mask.

used is NULL

> 
> This will shortly get used with actual affinities.
> 
> Tested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

With trivial bit of documentation added
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  include/linux/interrupt.h |  5 +++--
>  kernel/irq/manage.c       | 14 ++++++++++----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 0ec1a71ab4e84..52147d5f432b3 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -125,6 +125,7 @@ struct irqaction {
>  		void		*dev_id;
>  		void __percpu	*percpu_dev_id;
>  	};
> +	const struct cpumask	*affinity;

This structure has kernel-doc that needs an update.

>  	struct irqaction	*next;
>  	irq_handler_t		thread_fn;
>  	struct task_struct	*thread;



