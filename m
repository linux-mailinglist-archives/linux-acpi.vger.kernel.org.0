Return-Path: <linux-acpi+bounces-8812-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687F9A0656
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 12:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23081F215E3
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717981B0F1C;
	Wed, 16 Oct 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFL5+1eU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985B21E3DC;
	Wed, 16 Oct 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072872; cv=none; b=OG2Vw/Z0LG2qoO/7/k2UQoeNu+OQmITtkVcwI1op5r1hESK3fUaVH9aZmCaMw6/fsc73wVp2pq4gTR8ZRH+u6XF6jaS0nw7Ed5/Fil4nkF/Q7I53Fbk8ak7ur3fUpw86YbE02a0uF8HeZOZXqnWXMcvIaMXHMBv1YiidORLhUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072872; c=relaxed/simple;
	bh=D39NBDdVFY1jqqBfci4OkEy41KSDh8bapxuV2d7f1Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHAM9smOPyXWDxw+420mNoZFyfpSY1FIBTbkKXicIKiWrJOcqOYEYCT843GvFcMYZwBARww9qxU9umVNb5OFzaUrUu45HM7NPFLrt7Z6YD+BKqoqH7FkdalXwtMHJmsNEcv/RWJfhQA43rTa91fPR7laS5hbeJk5Ka+G+KwrRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFL5+1eU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B4CC4CEC5;
	Wed, 16 Oct 2024 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729072871;
	bh=D39NBDdVFY1jqqBfci4OkEy41KSDh8bapxuV2d7f1Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFL5+1eUB/7QVL7nq53SyV6YL2Oz5Do7vcTbjSkcuZ6Re3Js90pykGY6b3OxJRdkr
	 xJ+i+izBe0aBS8VOKfz6KWl5qEqh9xYcxg5VfIGJN4lLfyaV8LsM/oud5hx9p/f8KS
	 Ypk4C1qsvB3dSX1dAZyFuLxgKjwtmEBpvw6hECSr/qcptdcbClqFXR9JQApm71FBgD
	 n5FombtcGen+fWJS/8QGUtt3X29UdQmM0y20DP0XZiqVXAhkVkVaIi2sf0e+TNFYSd
	 Vu8NvcvCGpGhnbB5ftgIkHn8zbwd6fsKzUnxAxxJgObO90hgAKlr+KELaagNPlvmfH
	 Sm73QXNUsNu3A==
Date: Wed, 16 Oct 2024 12:01:06 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Zheng Zengkai <zhengzengkai@huawei.com>
Cc: guohanjun@huawei.com, sudeep.holla@arm.com, mark.rutland@arm.com,
	maz@kernel.org, rafael@kernel.org, lenb@kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: GTDT: Tighten the check for the array of
 platform timer structures
Message-ID: <Zw+O4nZisbkdvNtz@lpieralisi>
References: <20241016095458.34126-1-zhengzengkai@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016095458.34126-1-zhengzengkai@huawei.com>

On Wed, Oct 16, 2024 at 05:54:58PM +0800, Zheng Zengkai wrote:
> As suggested by Marc and Lorenzo, first we need to check whether the
> platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
> de-referencing what it points at to detect the length of the platform
> timer struct and then check that the length of current platform_timer
> struct is also valid, i.e. the length is not zero and within gtdt_end.
> Now next_platform_timer() only checks against gtdt_end for the entry of
> subsequent platform timer without checking the length of it and will
> not report error if the check failed and the existing check in function
> acpi_gtdt_init() is also not enough.
> 
> Modify the for_each_platform_timer() iterator and use it combined with
> a dedicated check function platform_timer_valid() to do the check
> against table length (gtdt_end) for each element of platform timer
> array in function acpi_gtdt_init(), making sure that both their entry
> and length actually fit in the table.
> 
> Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Co-developed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> ---
> Changes in v4:
> - remove the tmp pointer to make the code more concise.
> 
> Changes in v3:
> - based on Marc's patch and reuse the for_each_platform_timer() loop
> Link to v3: https://lore.kernel.org/linux-arm-kernel/20241015152602.184108-1-zhengzengkai@huawei.com/
> 
> Changes in v2:
> - Check against gtdt_end for both entry and len of each array element
> Link to v2: https://lore.kernel.org/linux-arm-kernel/20241012085343.6594-1-zhengzengkai@huawei.com/
> 
> Link to v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
> 
> Link to previous related patches:
> https://lore.kernel.org/all/20241008082429.33646-1-zhengzengkai@huawei.com/
> https://lore.kernel.org/all/20240930030716.179992-1-zhengzengkai@huawei.com/
> ---
>  drivers/acpi/arm64/gtdt.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index c0e77c1c8e09..d7c4e1b9915b 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -36,19 +36,25 @@ struct acpi_gtdt_descriptor {
>  
>  static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
>  
> -static inline __init void *next_platform_timer(void *platform_timer)
> +static __init bool platform_timer_valid(void *platform_timer)
>  {
>  	struct acpi_gtdt_header *gh = platform_timer;
>  
> -	platform_timer += gh->length;
> -	if (platform_timer < acpi_gtdt_desc.gtdt_end)
> -		return platform_timer;
> +	return (platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
> +		platform_timer < acpi_gtdt_desc.gtdt_end &&
> +		gh->length != 0 &&
> +		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
> +}
> +
> +static __init void *next_platform_timer(void *platform_timer)
> +{
> +	struct acpi_gtdt_header *gh = platform_timer;
>  
> -	return NULL;
> +	return platform_timer + gh->length;
>  }
>  
>  #define for_each_platform_timer(_g)				\
> -	for (_g = acpi_gtdt_desc.platform_timer; _g;	\
> +	for (_g = acpi_gtdt_desc.platform_timer; platform_timer_valid(_g);\
>  	     _g = next_platform_timer(_g))
>  
>  static inline bool is_timer_block(void *platform_timer)
> @@ -157,6 +163,7 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>  {
>  	void *platform_timer;
>  	struct acpi_table_gtdt *gtdt;
> +	int cnt = 0;
>  
>  	gtdt = container_of(table, struct acpi_table_gtdt, header);
>  	acpi_gtdt_desc.gtdt = gtdt;
> @@ -176,12 +183,16 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>  		return 0;
>  	}
>  
> -	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
> +	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> +	for_each_platform_timer(platform_timer)
> +		cnt++;
> +
> +	if (cnt != gtdt->platform_timer_count) {
> +		acpi_gtdt_desc.platform_timer = NULL;
>  		pr_err(FW_BUG "invalid timer data.\n");
>  		return -EINVAL;
>  	}
> -	acpi_gtdt_desc.platform_timer = platform_timer;
> +
>  	if (platform_timer_count)
>  		*platform_timer_count = gtdt->platform_timer_count;
>  
> -- 
> 2.20.1
> 

