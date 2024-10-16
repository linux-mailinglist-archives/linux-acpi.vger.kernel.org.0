Return-Path: <linux-acpi+bounces-8811-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D09A05E8
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 11:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA14E1C22580
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECC7205139;
	Wed, 16 Oct 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc+odG0C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669AD1B78F3;
	Wed, 16 Oct 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072150; cv=none; b=aLfiZevAbRcofqfYluebv/dm7Vk1S+zrQzuH9mHO9V21KA42Hp2W/v6Qn3dXqIITUNe1bcl5l67ZkUj9fB6Ody94P36xq4IYcGm4nfvqRPaGu+wiEx9FiWIxVKF3Li5Am4eVoPZz3VQyudQLwp+o//nu2CIGlY7zsj40UQTv+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072150; c=relaxed/simple;
	bh=wSci2MEGt00ZwhkOLGWXi9O0iBhjY3moR0n+P6QCCAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ausSRA61JnISMu31qRhL2vxD15ZMSjCFDSiQGQORWR7+DC1xjOWP7NUx/PzBN7bOKt9d+ncBGZYiJS6nQtXluGRfUCIMD45k3umjJ8ylZwDGtE0f1WC6RefaswhuzNFDGyW1P0mtM0Ctew0j9gEhQXia4QKnZSQZ1wLoma5cw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc+odG0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250DFC4CEC5;
	Wed, 16 Oct 2024 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729072149;
	bh=wSci2MEGt00ZwhkOLGWXi9O0iBhjY3moR0n+P6QCCAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fc+odG0CSFtqwULyIvDfhZQuO8LmVcjkL3mGF8850X3+kB75fLBpRG02gJeS5awMw
	 CQL8XMkqSNIw8lhyRjRVtvKYUVyhuu3cpIEkhr0MacYCBWVDoKbeQCiWLg0qk5U396
	 jKXz8mlfBLM1FQq+f3bdnmx1Quj7Y7bbtTCMG6SCkIqPclFBMA+eKQXhCK9xC6d0XY
	 ThXgPleKceUnEMFFazA5VB+i63quAxCZxKzagqjDpV3LQt+RkfQL9Ga6Yzp3gZtQeT
	 DK8Mc39ZBzF65kw6+SAtZhKn8K+Q2UXIrBJM3TnNrkTkrMA5WP8e8dNL0eQkkW6Cx3
	 ML6a96coZWNTA==
Date: Wed, 16 Oct 2024 11:49:04 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Zheng Zengkai <zhengzengkai@huawei.com>
Cc: guohanjun@huawei.com, sudeep.holla@arm.com, mark.rutland@arm.com,
	maz@kernel.org, rafael@kernel.org, lenb@kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: GTDT: Tighten the check for the array of
 platform timer structures
Message-ID: <Zw+MENlZyrRzETX9@lpieralisi>
References: <20241015152602.184108-1-zhengzengkai@huawei.com>
 <Zw6b3V5Mk2tIGmy5@lpieralisi>
 <4cea2a07-49b0-7703-4cdf-49ded9a2c9e4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cea2a07-49b0-7703-4cdf-49ded9a2c9e4@huawei.com>

On Wed, Oct 16, 2024 at 04:49:36PM +0800, Zheng Zengkai wrote:
> Hi Lorenzo,
> 
> 在 2024/10/16 0:44, Lorenzo Pieralisi 写道:
> > On Tue, Oct 15, 2024 at 11:26:02PM +0800, Zheng Zengkai wrote:
> > > As suggested by Marc and Lorenzo, first we need to check whether the
> > I would just describe the change, the tags and Link: are there to
> > describe this patch history.
> 
> 
> Do you mean that the previous patch below also need to be listed in this
> change log history?
> 
> https://lore.kernel.org/all/20240930030716.179992-1-zhengzengkai@huawei.com/

No, it was just a comment referring to "As suggested by Marc and Lorenzo",
that's clear from the tags and a Link: to this thread will be added when
the patch is applied (though you can add it too, it would not hurt).

Never mind.

Lorenzo

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
> > > Changes in v3:
> > > - based on Marc's patch and reuse the for_each_platform_timer() loop
> > > 
> > > Changes in v2:
> > > - Check against gtdt_end for both entry and len of each array element
> > > Link to v2: https://lore.kernel.org/linux-arm-kernel/20241012085343.6594-1-zhengzengkai@huawei.com/
> > > 
> > > Link to v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
> > > ---
> > >   drivers/acpi/arm64/gtdt.c | 32 +++++++++++++++++++++-----------
> > >   1 file changed, 21 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> > > index c0e77c1c8e09..3583c99afb0d 100644
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
> > > -#define for_each_platform_timer(_g)				\
> > > -	for (_g = acpi_gtdt_desc.platform_timer; _g;	\
> > > +#define for_each_platform_timer(_g, first_entry)	\
> > > +	for (_g = first_entry; platform_timer_valid(_g);	\
> > >   	     _g = next_platform_timer(_g))
> > >   static inline bool is_timer_block(void *platform_timer)
> > > @@ -155,8 +161,9 @@ bool __init acpi_gtdt_c3stop(int type)
> > >   int __init acpi_gtdt_init(struct acpi_table_header *table,
> > >   			  int *platform_timer_count)
> > >   {
> > > -	void *platform_timer;
> > > +	void *platform_timer, *tmp;
> > It makes more sense - thank you and Marc.
> > 
> > Nit: you don't really need another pointer (ie tmp) but you may keep
> > it if that makes the code clearer - all you need to do is using
> > platform_timer as an iterator and initialize
> 
> 
> Yes, the tmp pointer can be removed for conciseness.
> 
> Thanks!
> 
> 
> > 
> > 	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> > 
> > if all checks passed (you are using tmp just because after the loop
> > platform_timer can't be used to initialize acpi_gtdt_desc.platform_timer).
> > 
> > Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > 
> > (now let's see if this survives GTDTs out there :))
> > >   	struct acpi_table_gtdt *gtdt;
> > > +	int cnt = 0;
> > >   	gtdt = container_of(table, struct acpi_table_gtdt, header);
> > >   	acpi_gtdt_desc.gtdt = gtdt;
> > > @@ -177,7 +184,10 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
> > >   	}
> > >   	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> > > -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
> > > +	for_each_platform_timer(tmp, platform_timer)
> > > +		cnt++;
> > > +
> > > +	if (cnt != gtdt->platform_timer_count) {
> > >   		pr_err(FW_BUG "invalid timer data.\n");
> > >   		return -EINVAL;
> > >   	}
> > > @@ -305,7 +315,7 @@ int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
> > >   	void *platform_timer;
> > >   	*timer_count = 0;
> > > -	for_each_platform_timer(platform_timer) {
> > > +	for_each_platform_timer(platform_timer, acpi_gtdt_desc.platform_timer) {
> > >   		if (is_timer_block(platform_timer)) {
> > >   			ret = gtdt_parse_timer_block(platform_timer, timer_mem);
> > >   			if (ret)
> > > @@ -398,7 +408,7 @@ static int __init gtdt_sbsa_gwdt_init(void)
> > >   	if (ret || !timer_count)
> > >   		goto out_put_gtdt;
> > > -	for_each_platform_timer(platform_timer) {
> > > +	for_each_platform_timer(platform_timer, acpi_gtdt_desc.platform_timer) {
> > >   		if (is_non_secure_watchdog(platform_timer)) {
> > >   			ret = gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
> > >   			if (ret)
> > > -- 
> > > 2.20.1
> > > 
> > .
> > 

