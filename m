Return-Path: <linux-acpi+bounces-13898-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6BAC3F01
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 14:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8D11891D1F
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578BF1AA1C4;
	Mon, 26 May 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1q2KIjI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1355EC5;
	Mon, 26 May 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260843; cv=none; b=Q0WvyBCSvOfjt6Tk2rZ2ExR/K0vnWnsP/MkofZ3X7grr7PhOg3MKdZtZBiDp21qYujVnr/E9sW+ZTwolbtxyGFf8FQIw3grxETjCKp6PylgFIi8jxc8RJNNmTgWgQuK7Qrs3uxh6dCUocmoj3ZtDiyjozgwrM5UEcfbd9v2AdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260843; c=relaxed/simple;
	bh=woS/yA+itLAIwyHAFbvuZKdAWdF9RD1dHk/05nYoQWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQ7VoI9azp5vvE8RfSZmBkwu3lEHYX/tdS6OTL+QezQ4rjbMXs6Updf3uxxuy/HHOKhSu+PLkn/LchwrkWsEe1/xghseVdkb8nDVVOZ2KLU8VxgIG7NumPCFyVEPlq8gPiQTpXUU61tAFvi6SL2bL/e7uRoxhYp55YX7rk1j9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A1q2KIjI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=30u2355utitA+JCnJu/Rhs866Jt2Gg9qvXCkeS+ZXFQ=; b=A1q2KIjI0Cxp+Lo+JqGI6U+Jyv
	hk9eDFo10o9KPOLh42VY+ath6P7QlhYq/N7Q0vovXVbr5ADfRHxWA6tF/R5VbCG+fHrORIKTqVUG3
	pxS0H77lAWPfJFYalqjtbpnSqYezPQF0Y/9OqRXXs/c31f/2ySCCq/dY5EeXuByAMaCafLeZfndIM
	KpSoPLIm7j32W4OQN09DmnZ5LmPfzB0hzGklq5EDntOjUej+8hDUQv0C6695le1VJ0Kx/v7njsq/n
	VWrdWxOkrzggMndHqwDx+2bRXkTp4zkfMIocaB/6T2Tf5FVdzjp+tpwCwuTdeVSp/3t3M0BoKZYfJ
	mzXR92rQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJWVK-00000001t7G-0hVA;
	Mon, 26 May 2025 12:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9AC5C300472; Mon, 26 May 2025 14:00:29 +0200 (CEST)
Date: Mon, 26 May 2025 14:00:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Khalid Ali <khaliidcaliy@gmail.com>
Cc: rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	x86@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ACPI: invalidate all cache lines on ACPI C-state
 transitions
Message-ID: <20250526120029.GR39944@noisy.programming.kicks-ass.net>
References: <20250525180052.1004-1-khaliidcaliy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525180052.1004-1-khaliidcaliy@gmail.com>

On Sun, May 25, 2025 at 06:00:42PM +0000, Khalid Ali wrote:
> From: Khalid Ali <khaliidcaliy@gmail.com>
> 
> According to ACPI spec 2.4 and 2.5, upon C-state
> transitions(specifically C2 and C3) it is required and explicitly
> mentioned to invalidate and writeback all modified cache line using
> WBINVD.
> 
> However the current ACPI C-state entry using monitor/mwait instructions
> it have been used CLFLUSH by flushing the cache line associated by
> monitored address. That what all about this patch addresses,
> invalidating all cache lines instead of single cache line.
> 
> Let me know if there any reason and decisions behind the current
> implementation.
> 
> Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
> ---
>  arch/x86/kernel/acpi/cstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index d5ac34186555..eb3d435e08ad 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -222,6 +222,9 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
>  	struct cstate_entry *percpu_entry;
>  
>  	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
> +	/* flush and invalidate all modified cache line on C3 and C2 state entry*/
> +	if (cx->type == ACPI_STATE_C3 || cx->type == ACPI_STATE_C2)
> +		wbinvd();

This is absolutely insane. This day and age, nobody should use WBINVD
ever. We've managed to not do this for decades, and I'm thinking that
either the SPEC is 'mistaken' or otherwise out of line with reality.

If you hate performance, and you want to break things like CAT, feel
free to put this in your own kernel.

>  	mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
>  	                      percpu_entry->states[cx->index].ecx);
>  }
> -- 
> 2.49.0
> 

