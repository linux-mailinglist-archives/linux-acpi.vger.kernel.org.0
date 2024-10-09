Return-Path: <linux-acpi+bounces-8654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60B0996B65
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF8A1F21226
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B24D1922DC;
	Wed,  9 Oct 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfFPoU37"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5378291E;
	Wed,  9 Oct 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479417; cv=none; b=P0DBsCHXiDA+IAHbUbW2XHyLuM8Vcmp6qRQqcIGUnaWEzbLIx8HamNrO37nINM2U303hAbSCoEkNuSDP5zN0Ulb2Jb8EENmnivirRKIiIp7Naw+MiyN84gSosfFq8QEePF2ArLPjwK8BWofJ/ilTymJdCR0IZ3sO4vCJh46/n2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479417; c=relaxed/simple;
	bh=3rSk0qpMy3mRiaF8HFu8PwiCPAK8Cf3r5DxZutgdUBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldnns2wacm/Pvxk2qv3vUv00EYrJ+JetIt3xBDsrqZUPnMDUygHN8FsLPJRnnU2eyq4cVYsuDGV4iob1iXO647yB6amGCNinD4lwFC6D3KkgWGgXZtvMGOQGVMT9jSMnoE6dHRW3no416NDystqsZW3g0n3rwusKuF6gDk5LbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfFPoU37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99636C4CEC5;
	Wed,  9 Oct 2024 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728479416;
	bh=3rSk0qpMy3mRiaF8HFu8PwiCPAK8Cf3r5DxZutgdUBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfFPoU37rt3pJvQ42mzAS+9f4v18U+dqeeaV9a4URYhutlLffKuInN0zqt+3Jsxpb
	 Qjvcr5iqzzwC2PLKNUpvkve7KhykeKSTFQRvUceuQS34e2vaQQ92uj1tQSy1sXR4A0
	 v7pRy9PD6lPq61d1JLkVZHEZE1I3hcFmF39bMwx3ycVnH/gOX+bWBV2tP6FQ/fXWoy
	 y3F0l5swnwgmtQFnQwO/XwulXBsOnZCnvIiFJDJnHuvg3+3GwOkKej5oSzF7zlCYcX
	 sQvoVyIEGs17g21lNOgBoUKiEXs7cXhs2vCClkWB19p83dKZt37BO/YNgB/aOwLlOk
	 R3QqAJfGpJwCA==
Date: Wed, 9 Oct 2024 15:10:11 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Zheng Zengkai <zhengzengkai@huawei.com>, guohanjun@huawei.com,
	sudeep.holla@arm.com, mark.rutland@arm.com, rafael@kernel.org,
	lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: GTDT: simplify acpi_gtdt_init() implementation
Message-ID: <ZwaAsyQnI0a0gTtL@lpieralisi>
References: <20241008082429.33646-1-zhengzengkai@huawei.com>
 <86v7y355zr.wl-maz@kernel.org>
 <57e9adb8-a34a-6d63-24b8-4ad0abb74bf9@huawei.com>
 <86r08p5x4g.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86r08p5x4g.wl-maz@kernel.org>

On Wed, Oct 09, 2024 at 12:33:35PM +0100, Marc Zyngier wrote:
> On Tue, 08 Oct 2024 15:04:52 +0100,
> Zheng Zengkai <zhengzengkai@huawei.com> wrote:
> > 
> > 
> > 在 2024/10/8 16:55, Marc Zyngier 写道:
> > > On Tue, 08 Oct 2024 09:24:29 +0100,
> > > Zheng Zengkai <zhengzengkai@huawei.com> wrote:
> > >> According to GTDT Table Structure of ACPI specification, the result of
> > >> expression '(void *)gtdt + gtdt->platform_timer_offset' will be same
> > >> with the expression '(void *)table + sizeof(struct acpi_table_gtdt)'
> > > There is no such language in the spec. It simply says "Offset to the
> > > Platform Timer Structure[] array from the start of this table".
> > OK, I mean that in current code, the condition of this check is redundant.
> 
> That's not my reading if it. Where do you see another validity check
> that makes this one superfluous?
> 
> > >> in function acpi_gtdt_init(), so the condition of the "invalid timer
> > >> data" check will never be true, remove the EINVAL error check branch
> > >> and change to void return type for acpi_gtdt_init() to simplify the
> > >> function implementation and error handling by callers.
> > > And ACPI tables are well known to be always correct, right?
> > Not always, check is needed, but should be changed.
> 
> You are not changing it, you are getting rid of it, and I don't see
> you replacing it with anything else.
> 
> > >> Besides, after commit c2743a36765d ("clocksource: arm_arch_timer: add
> > >> GTDT support for memory-mapped timer"), acpi_gtdt_init() currently will
> > >> not be called with parameter platform_timer_count set to NULL and we
> > >> can explicitly initialize the integer variable which is used for storing
> > >> the number of platform timers by caller to zero, so there is no need to
> > >> do null pointer check for platform_timer_count in acpi_gtdt_init(),
> > >> remove it to make code a bit more concise.
> > >> 
> > >> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> > >> ---
> > >> Changes in v2:
> > >> - initialize 'ret' in gtdt_sbsa_gwdt_init() to silence build warning
> > >> 
> > >> v1: https://lore.kernel.org/all/20240930030716.179992-1-zhengzengkai@huawei.com/
> > >> ---
> > >>   drivers/acpi/arm64/gtdt.c            | 31 +++++++---------------------
> > >>   drivers/clocksource/arm_arch_timer.c |  6 ++----
> > >>   include/linux/acpi.h                 |  2 +-
> > >>   3 files changed, 11 insertions(+), 28 deletions(-)
> > >> 
> > >> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> > >> index c0e77c1c8e09..7fe27c0edde7 100644
> > >> --- a/drivers/acpi/arm64/gtdt.c
> > >> +++ b/drivers/acpi/arm64/gtdt.c
> > >> @@ -147,45 +147,30 @@ bool __init acpi_gtdt_c3stop(int type)
> > >>    * @table:			The pointer to GTDT table.
> > >>    * @platform_timer_count:	It points to a integer variable which is used
> > >>    *				for storing the number of platform timers.
> > >> - *				This pointer could be NULL, if the caller
> > >> - *				doesn't need this info.
> > >> - *
> > >> - * Return: 0 if success, -EINVAL if error.
> > >>    */
> > >> -int __init acpi_gtdt_init(struct acpi_table_header *table,
> > >> +void __init acpi_gtdt_init(struct acpi_table_header *table,
> > >>   			  int *platform_timer_count)
> > >>   {
> > >> -	void *platform_timer;
> > >>   	struct acpi_table_gtdt *gtdt;
> > >>     	gtdt = container_of(table, struct acpi_table_gtdt, header);
> > >>   	acpi_gtdt_desc.gtdt = gtdt;
> > >>   	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
> > >>   	acpi_gtdt_desc.platform_timer = NULL;
> > >> -	if (platform_timer_count)
> > >> -		*platform_timer_count = 0;
> > >>     	if (table->revision < 2) {
> > >>   		pr_warn("Revision:%d doesn't support Platform Timers.\n",
> > >>   			table->revision);
> > >> -		return 0;
> > >> +		return;
> > >>   	}
> > >>     	if (!gtdt->platform_timer_count) {
> > >>   		pr_debug("No Platform Timer.\n");
> > >> -		return 0;
> > >> +		return;
> > >>   	}
> > >>   -	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> > >> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
> > >> -		pr_err(FW_BUG "invalid timer data.\n");
> > >> -		return -EINVAL;
> > >> -	}
> > >> -	acpi_gtdt_desc.platform_timer = platform_timer;
> > >> -	if (platform_timer_count)
> > >> -		*platform_timer_count = gtdt->platform_timer_count;
> > >> -
> > >> -	return 0;
> > >> +	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> > > And now you are trusting something that potentially points to some
> > > unexpected location, blindly using it. It is bad enough that the
> > > current checks are pretty poor (no check against the end of the
> > > table for the first timer entry), but you are making it worse.
> > > 
> > > 	M.
> > 
> > Can I use the second and third bytes (the length) of platform timer
> > structure to check against the end of the table ?
> 
> That's how it is supposed to be done indeed.

AFAICS I think first we need to check whether the platform_timer pointer
is within gtdt bounds (< gtdt_end) before de-referencing what it points
at to detect the (first) GT entry length and check that it is within
gtdt_end too. We do that only in next_platform_timer() for subsequent
GT blocks.

I agree with Marc, current check is fine, we should add to it, not
remove it.

Thanks,
Lorenzo

