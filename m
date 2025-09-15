Return-Path: <linux-acpi+bounces-16922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475F7B574FA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BA33B6F94
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2AE2F4A15;
	Mon, 15 Sep 2025 09:37:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94952DF130;
	Mon, 15 Sep 2025 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929040; cv=none; b=Pv4oID/dy1DWh/zJPc4JX6idDl7tS1NC5c94qK3WecJPVK8eLm8zc7GRtdH8Fx+DCRoB8eyzfwxEVFCk/Fv1Xe8OzMaFk3TeLYohmBH8BXMIFSdGlmX+JGccWGsrSsuLfIFFpSuQh2+f6ByQUvV4vlZ8Tl9o8Q699tRCUCcIt28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929040; c=relaxed/simple;
	bh=feqERkl152005nHRlY1OYwqKLp/PPMp9wruSJrfeQA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQ3bH9r8XPfojmVFrHmyAYkPeKcP2iY1CFbrdspKL5zMupiiN/pvFBQyUX1l7UcvLnAdyJ0QF8Zheu9eQdvUGoXDlx95l7Fzvs9vozwcarmmcYbagjzR+5+DRTLYXIs9gWkg+uUEJzEfDHWgGhifS3KaEUy2m4qzh/US3pR9ICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 983EA1063;
	Mon, 15 Sep 2025 02:37:09 -0700 (PDT)
Received: from [10.1.35.47] (unknown [10.1.35.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 702B13F694;
	Mon, 15 Sep 2025 02:37:15 -0700 (PDT)
Message-ID: <5341c539-d03f-4a29-80bc-cd3deaab9a07@arm.com>
Date: Mon, 15 Sep 2025 10:37:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/25] coresight: trbe: Request specific affinities for
 percpu IRQ
Content-Language: en-GB
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sven Peter
 <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 James Clark <james.clark@linaro.org>
References: <20250915085702.519996-1-maz@kernel.org>
 <20250915085702.519996-21-maz@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250915085702.519996-21-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 09:56, Marc Zyngier wrote:
> Let the TRBE driver request IRQs with an affinity mask matching
> the TRBE implementation affinity.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index c512f8faa6012..4a84a6bc2e8fc 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1492,7 +1492,8 @@ static int arm_trbe_probe_irq(struct platform_device *pdev,
>   	if (!drvdata->handle)
>   		return -ENOMEM;
>   
> -	ret = request_percpu_irq(drvdata->irq, arm_trbe_irq_handler, DRVNAME, drvdata->handle);
> +	ret = request_percpu_irq_affinity(drvdata->irq, arm_trbe_irq_handler, DRVNAME,
> +					  affinity, drvdata->handle);
>   	if (ret) {
>   		free_percpu(drvdata->handle);
>   		return ret;


Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


