Return-Path: <linux-acpi+bounces-9108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB669B5F2B
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 10:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFBDB2255B
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E601E0DE5;
	Wed, 30 Oct 2024 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0DJmS1z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E6199E89;
	Wed, 30 Oct 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281760; cv=none; b=tASgdgDs4GMIukFwIaw2YoVCNJYkIkCqFcnfR1+TI8vjBGek4dnTPQyt3vt7M+mQ85xGRXaCIWQTvFqku+FqnUDE2VPfl/cYiG0wmZ85yGLvQJkai+Zus4tvltb3pGMfPEJXvQwHFaDmPVgn9bNOV3X/qo9iifhaMCjYm38VkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281760; c=relaxed/simple;
	bh=NDw0InURcJy7Z0GoHumZQCjg5VAENS9N1S5pr0z2yb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHyXhx8EdmWCxVoMai/5Gzx2so3ScwRbFv2GRmiaeLnpG6HVE7+tzb/Tv1xxNTklaYnoBAKY6F4QhQXx2BfZl2JyLv9ZWsNDb7qZGhI5xdxMme3sv1LYQuSVWVV6UywiZYSTzapc0bI2GUZG+vKBgSl3Sjt07V/ffFLFm9Xc0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0DJmS1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C323FC4CEE5;
	Wed, 30 Oct 2024 09:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730281758;
	bh=NDw0InURcJy7Z0GoHumZQCjg5VAENS9N1S5pr0z2yb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0DJmS1zCBPUEjiPHvT4etc+FpuqaQI/KH7l25dsJAYubGrzFCR0ZoQlAvYpYgKOn
	 cOVUEMwVPVsgYdwl46rgLrJi4L0wXh4qorl48s4x2C/7i2rjtnNrgxlRteFOPPnHNw
	 UqCDsVbUlr3jNbnmcba08gJ37c51+ZdkNU/qp4Ajfx0oSmp2ak3jzb6gyOml17iNXs
	 FQBFj/i6whwIfTCKB3N/6Kqa8rpeD47HaH0rhzjwA1pCQoAmOG9afgtj/FE9C+C5cX
	 v72xlIfJDYcNroim9cDUyQb3k4HQ0hL19/9Z6FBE2wF81fDBmwao/3Nm7msjEKPWDh
	 43x9XTHhi+p+g==
Date: Wed, 30 Oct 2024 10:49:13 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Zheng Zengkai <zhengzengkai@huawei.com>, will@kernel.org,
	catalin.marinas@arm.com
Cc: guohanjun@huawei.com, sudeep.holla@arm.com, mark.rutland@arm.com,
	maz@kernel.org, rafael@kernel.org, lenb@kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: GTDT: Tighten the check for the array of
 platform timer structures
Message-ID: <ZyIBGRv/10kpOcOl@lpieralisi>
References: <20241016095458.34126-1-zhengzengkai@huawei.com>
 <Zw+O4nZisbkdvNtz@lpieralisi>
 <3bf1fe29-e135-c1ba-2774-d1e98c8b92b3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bf1fe29-e135-c1ba-2774-d1e98c8b92b3@huawei.com>

[+Catalin/Will]

On Tue, Oct 29, 2024 at 10:16:41PM +0800, Zheng Zengkai wrote:
> 
> Gentle ping.
> 
> This patch still can be applied to upstream now.

Hi Catalin, Will,

this patch is a clean-up - not a fix, it could be merged
for v6.13, please consider it if there is still time.

Thanks,
Lorenzo

> 
> Thanks!
> 
> 
> 在 2024/10/16 18:01, Lorenzo Pieralisi 写道:
> > On Wed, Oct 16, 2024 at 05:54:58PM +0800, Zheng Zengkai wrote:
> > > As suggested by Marc and Lorenzo, first we need to check whether the
> > > platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
> > > de-referencing what it points at to detect the length of the platform
> > > timer struct and then check that the length of current platform_timer
> > > struct is also valid, i.e. the length is not zero and within gtdt_end.
> > > Now next_platform_timer() only checks against gtdt_end for the entry of
> > > subsequent platform timer without checking the length of it and will
> > > not report error if the check failed and the existing check in function
> > > acpi_gtdt_init() is also not enough.
> > > 
> > > Modify the for_each_platform_timer() iterator and use it combined with
> > > a dedicated check function platform_timer_valid() to do the check
> > > against table length (gtdt_end) for each element of platform timer
> > > array in function acpi_gtdt_init(), making sure that both their entry
> > > and length actually fit in the table.
> > > 
> > > Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Co-developed-by: Marc Zyngier <maz@kernel.org>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> > > ---
> > > Changes in v4:
> > > - remove the tmp pointer to make the code more concise.
> > > 
> > > Changes in v3:
> > > - based on Marc's patch and reuse the for_each_platform_timer() loop
> > > Link to v3: https://lore.kernel.org/linux-arm-kernel/20241015152602.184108-1-zhengzengkai@huawei.com/
> > > 
> > > Changes in v2:
> > > - Check against gtdt_end for both entry and len of each array element
> > > Link to v2: https://lore.kernel.org/linux-arm-kernel/20241012085343.6594-1-zhengzengkai@huawei.com/
> > > 
> > > Link to v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
> > > 
> > > Link to previous related patches:
> > > https://lore.kernel.org/all/20241008082429.33646-1-zhengzengkai@huawei.com/
> > > https://lore.kernel.org/all/20240930030716.179992-1-zhengzengkai@huawei.com/
> > > ---
> > >   drivers/acpi/arm64/gtdt.c | 29 ++++++++++++++++++++---------
> > >   1 file changed, 20 insertions(+), 9 deletions(-)
> > Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > 
> > > diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> > > index c0e77c1c8e09..d7c4e1b9915b 100644
> > > --- a/drivers/acpi/arm64/gtdt.c
> > > +++ b/drivers/acpi/arm64/gtdt.c
> > > @@ -36,19 +36,25 @@ struct acpi_gtdt_descriptor {
> > >   static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
> > > -static inline __init void *next_platform_timer(void *platform_timer)
> > > +static __init bool platform_timer_valid(void *platform_timer)
> > >   {
> > >   	struct acpi_gtdt_header *gh = platform_timer;
> > > -	platform_timer += gh->length;
> > > -	if (platform_timer < acpi_gtdt_desc.gtdt_end)
> > > -		return platform_timer;
> > > +	return (platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
> > > +		platform_timer < acpi_gtdt_desc.gtdt_end &&
> > > +		gh->length != 0 &&
> > > +		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
> > > +}
> > > +
> > > +static __init void *next_platform_timer(void *platform_timer)
> > > +{
> > > +	struct acpi_gtdt_header *gh = platform_timer;
> > > -	return NULL;
> > > +	return platform_timer + gh->length;
> > >   }
> > >   #define for_each_platform_timer(_g)				\
> > > -	for (_g = acpi_gtdt_desc.platform_timer; _g;	\
> > > +	for (_g = acpi_gtdt_desc.platform_timer; platform_timer_valid(_g);\
> > >   	     _g = next_platform_timer(_g))
> > >   static inline bool is_timer_block(void *platform_timer)
> > > @@ -157,6 +163,7 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
> > >   {
> > >   	void *platform_timer;
> > >   	struct acpi_table_gtdt *gtdt;
> > > +	int cnt = 0;
> > >   	gtdt = container_of(table, struct acpi_table_gtdt, header);
> > >   	acpi_gtdt_desc.gtdt = gtdt;
> > > @@ -176,12 +183,16 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
> > >   		return 0;
> > >   	}
> > > -	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> > > -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
> > > +	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> > > +	for_each_platform_timer(platform_timer)
> > > +		cnt++;
> > > +
> > > +	if (cnt != gtdt->platform_timer_count) {
> > > +		acpi_gtdt_desc.platform_timer = NULL;
> > >   		pr_err(FW_BUG "invalid timer data.\n");
> > >   		return -EINVAL;
> > >   	}
> > > -	acpi_gtdt_desc.platform_timer = platform_timer;
> > > +
> > >   	if (platform_timer_count)
> > >   		*platform_timer_count = gtdt->platform_timer_count;
> > > -- 
> > > 2.20.1
> > > 
> > .
> > 

