Return-Path: <linux-acpi+bounces-8804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A44F99F314
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 18:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBCC1C20B1B
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68D51F76AE;
	Tue, 15 Oct 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVs8Df2o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F21F6671;
	Tue, 15 Oct 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010659; cv=none; b=ryjYNaaQOA/t83wyK5gpELRjuyeWzXDbHjB61u3HrNzPpA/SSmL+Nk27lcM7qgOS5EyGfNGa8epgef+Bav7xEE+3LsqmZFmcHfTO2jwwnWbymW6s5+49WCdYU914LSeQx/tRPFB0NSvKbAKDymiNp6PcU6OHc0M1si2DvOl2Lf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010659; c=relaxed/simple;
	bh=1Yzhnbim0NFkYWi4viU/6zv+YCq/dxIxbqmb+G1U/uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKMM2nDe8EYIL9h9QvFpQmFklVXkXCVelP7yMM357j91vOZ66/qfmZuGj5mYpj7hXuvfDdNCf7cY1KydE4tGPYKBYo7LwyDc/FbP/cp2RVfwjsLjU8wZOpEGfgxwhesJi5ptHpNhrBL7z4dOrgLrmYbG/4byokTi8sba4PTfhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVs8Df2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10108C4CEC6;
	Tue, 15 Oct 2024 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729010659;
	bh=1Yzhnbim0NFkYWi4viU/6zv+YCq/dxIxbqmb+G1U/uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVs8Df2oWaAYxMWxxlXM02rbRSnryokH/HKXZjhOaLzdyuFgiQK98ogayz/SlLaI8
	 nR+vzjBRdvMqL7n9UF8q+UXAKU5pPF13q0UV3uAXRAv536lg+zYnXLwv0t0TIQuaNo
	 p8cxLNNhISYH2suyl//gZd7eyMvxWCfCBJ1NL4ruMh7h4neWE+2eQJLMFqXTfzL1v8
	 1FOvdv2bZIsGsTFGirrU0BBHw9Aw4im0cUlUbWrPjawYjSBkDBp67PFKImA3Bbk626
	 FoydSwzUvnWpxJ3lq0DtIqWnHGyHhsRxWqaGdJk1TXyMegxYx0uYKc3Ln+P8pmxqC2
	 62Yw+e8Cwab0A==
Date: Tue, 15 Oct 2024 18:44:13 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Zheng Zengkai <zhengzengkai@huawei.com>
Cc: guohanjun@huawei.com, sudeep.holla@arm.com, mark.rutland@arm.com,
	maz@kernel.org, rafael@kernel.org, lenb@kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: GTDT: Tighten the check for the array of
 platform timer structures
Message-ID: <Zw6b3V5Mk2tIGmy5@lpieralisi>
References: <20241015152602.184108-1-zhengzengkai@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015152602.184108-1-zhengzengkai@huawei.com>

On Tue, Oct 15, 2024 at 11:26:02PM +0800, Zheng Zengkai wrote:
> As suggested by Marc and Lorenzo, first we need to check whether the

I would just describe the change, the tags and Link: are there to
describe this patch history.

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
> Changes in v3:
> - based on Marc's patch and reuse the for_each_platform_timer() loop
> 
> Changes in v2:
> - Check against gtdt_end for both entry and len of each array element
> Link to v2: https://lore.kernel.org/linux-arm-kernel/20241012085343.6594-1-zhengzengkai@huawei.com/
> 
> Link to v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
> ---
>  drivers/acpi/arm64/gtdt.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index c0e77c1c8e09..3583c99afb0d 100644
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
> -#define for_each_platform_timer(_g)				\
> -	for (_g = acpi_gtdt_desc.platform_timer; _g;	\
> +#define for_each_platform_timer(_g, first_entry)	\
> +	for (_g = first_entry; platform_timer_valid(_g);	\
>  	     _g = next_platform_timer(_g))
>  
>  static inline bool is_timer_block(void *platform_timer)
> @@ -155,8 +161,9 @@ bool __init acpi_gtdt_c3stop(int type)
>  int __init acpi_gtdt_init(struct acpi_table_header *table,
>  			  int *platform_timer_count)
>  {
> -	void *platform_timer;
> +	void *platform_timer, *tmp;

It makes more sense - thank you and Marc.

Nit: you don't really need another pointer (ie tmp) but you may keep
it if that makes the code clearer - all you need to do is using
platform_timer as an iterator and initialize

	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;

if all checks passed (you are using tmp just because after the loop
platform_timer can't be used to initialize acpi_gtdt_desc.platform_timer).

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

(now let's see if this survives GTDTs out there :))

>  	struct acpi_table_gtdt *gtdt;
> +	int cnt = 0;
>  
>  	gtdt = container_of(table, struct acpi_table_gtdt, header);
>  	acpi_gtdt_desc.gtdt = gtdt;
> @@ -177,7 +184,10 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>  	}
>  
>  	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
> +	for_each_platform_timer(tmp, platform_timer)
> +		cnt++;
> +
> +	if (cnt != gtdt->platform_timer_count) {
>  		pr_err(FW_BUG "invalid timer data.\n");
>  		return -EINVAL;
>  	}
> @@ -305,7 +315,7 @@ int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
>  	void *platform_timer;
>  
>  	*timer_count = 0;
> -	for_each_platform_timer(platform_timer) {
> +	for_each_platform_timer(platform_timer, acpi_gtdt_desc.platform_timer) {
>  		if (is_timer_block(platform_timer)) {
>  			ret = gtdt_parse_timer_block(platform_timer, timer_mem);
>  			if (ret)
> @@ -398,7 +408,7 @@ static int __init gtdt_sbsa_gwdt_init(void)
>  	if (ret || !timer_count)
>  		goto out_put_gtdt;
>  
> -	for_each_platform_timer(platform_timer) {
> +	for_each_platform_timer(platform_timer, acpi_gtdt_desc.platform_timer) {
>  		if (is_non_secure_watchdog(platform_timer)) {
>  			ret = gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
>  			if (ret)
> -- 
> 2.20.1
> 

