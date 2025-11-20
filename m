Return-Path: <linux-acpi+bounces-19156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 865EDC747A2
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 15:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDFD54F84F7
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3D30F7E8;
	Thu, 20 Nov 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCJt5uCo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB53BB4A;
	Thu, 20 Nov 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647240; cv=none; b=pvhrpACRCiCEExKBXUQpePj3dZOMMM5/MuVh6gHJ2I/2O6QWTJhTkCjGnahz47BdhBUQemXxgzqU7BAbDQIMFzv6AqiHOkMEzYsQC3QhwUyToDaWZpLFmC452jltOzP2RDFsW1YEoeo6l1+h4t8BYSItTREfjy7z5D5Lj8xOmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647240; c=relaxed/simple;
	bh=RfpS+pqgpVU1AgHmDJmemq+dFNmDZU2FJ+FBrijKSwU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Z7VsvFeUL7pzN3xSqzMgX0+o1rsRRer3iSd2NI96+sX6bYe7eZEKl2h65LY+N+hF6UbKeIMmj7VF9aMSVz1nS2WmqUFq8s8Wjg3kQGsT06PYG57jh4TYA2AQ5+lwYKhi4r93hcXF7bGRtwDeDmJpGaM9tRqacmuCcsD3d70quE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCJt5uCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD32C4CEF1;
	Thu, 20 Nov 2025 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763647240;
	bh=RfpS+pqgpVU1AgHmDJmemq+dFNmDZU2FJ+FBrijKSwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCJt5uCojQcqCK0JgIVDl9su1pwb1QXwjCQ9oaGIZDjzVftUTHgN/3HShpHczGWz+
	 sbk09nDYFDpAgY7hGVHyn/ooDAPM4aeppdUIlneNewG+rnoPTwzs4a+23b55rasE+A
	 JQ7I5PalwYdiT+8v8g3jVeIOjiU9T/srlScQsNQjRVe+N4sT2wkCVC8X0yWYB3qQnb
	 BjNxu4+lySdB/3Zm1W+WK1v6hwNY8FGcf2h4bdXBbeJiZnWyIcS8swzSdeTnEwQE7l
	 d6CfxgJqf9ErisUzM9KRWTIDzWrhFP428GKldzITZa/wxCzd1rwBUC19+Rwp8WcNYo
	 ONXlXhrjXuVIw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vM5DC-00000006u6K-0YPi;
	Thu, 20 Nov 2025 14:00:38 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Nov 2025 14:00:37 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark
 Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ACPI: GTDT: Get rid of acpi_arch_timer_mem_init()
In-Reply-To: <20251030110137.1843007-1-maz@kernel.org>
References: <20251030110137.1843007-1-maz@kernel.org>
Message-ID: <31d7fffeeddc8b811412af3ddf7f4850@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2025-10-30 11:01, Marc Zyngier wrote:
> Since 0f67b56d84b4c ("clocksource/drivers/arm_arch_timer_mmio: Switch
> over to standalone driver"), acpi_arch_timer_mem_init() is unused.
> 
> Remove it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  drivers/acpi/arm64/gtdt.c | 34 ----------------------------------
>  include/linux/acpi.h      |  1 -
>  2 files changed, 35 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index 8cc8af8fd408c..ffc867bac2d60 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -303,40 +303,6 @@ static int __init gtdt_parse_timer_block(struct 
> acpi_gtdt_timer_block *block,
>  	return -EINVAL;
>  }
> 
> -/**
> - * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT 
> table.
> - * @timer_mem:	The pointer to the array of struct arch_timer_mem for 
> returning
> - *		the result of parsing. The element number of this array should
> - *		be platform_timer_count(the total number of platform timers).
> - * @timer_count: It points to a integer variable which is used for 
> storing the
> - *		number of GT blocks we have parsed.
> - *
> - * Return: 0 if success, -EINVAL/-ENODEV if error.
> - */
> -int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
> -				    int *timer_count)
> -{
> -	int ret;
> -	void *platform_timer;
> -
> -	*timer_count = 0;
> -	for_each_platform_timer(platform_timer) {
> -		if (is_timer_block(platform_timer)) {
> -			ret = gtdt_parse_timer_block(platform_timer, timer_mem);
> -			if (ret)
> -				return ret;
> -			timer_mem++;
> -			(*timer_count)++;
> -		}
> -	}
> -
> -	if (*timer_count)
> -		pr_info("found %d memory-mapped timer block(s).\n",
> -			*timer_count);
> -
> -	return 0;
> -}
> -
>  /*
>   * Initialize a SBSA generic Watchdog platform device info from GTDT
>   */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 5ff5d99f6ead5..22b377c3a3196 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -755,7 +755,6 @@ int acpi_reconfig_notifier_unregister(struct 
> notifier_block *nb);
>  int acpi_gtdt_init(struct acpi_table_header *table, int 
> *platform_timer_count);
>  int acpi_gtdt_map_ppi(int type);
>  bool acpi_gtdt_c3stop(int type);
> -int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int 
> *timer_count);
>  #endif
> 
>  #ifndef ACPI_HAVE_ARCH_SET_ROOT_POINTER

This isn't urgent, but would be a good 6.19 candidate.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

