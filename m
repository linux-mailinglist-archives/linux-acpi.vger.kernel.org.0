Return-Path: <linux-acpi+bounces-15184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B65B0733B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CE63AC579
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 10:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D890D2F3C25;
	Wed, 16 Jul 2025 10:19:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351F22F365C;
	Wed, 16 Jul 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661190; cv=none; b=JTR4Moa+PsaDkWVnWm7ZY9wUbyXp59zRgnwRikZsvEdZuzj1vXPuBL9+XuoQjTLXWJqv9xPVsgGmGaTjwXwfpkAQXCGKSKNvjZp/kdy/oGUtdCZ44lM1BQzbL23OZ49p/6ol9NV26EoDXKBJWaIJk5Pa8cavKb+UOxhTF4a0hxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661190; c=relaxed/simple;
	bh=GU87xhkdBDpExOBMbJ4fKdt9ZysCHC+dF/RFFvA7GxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAjFe7PEYswEF59WVLsk2PJoF+KW1pLMwxgVssHXwm8gmu+dfYC8DpMmelw2mFIjLLcOlNe2pQb3ZLctqgBFYAmtXNVoAWU/Mx5r53JRRUH7jhLeyQkNL+kNX0olNDk91o+pi/9vEQ2AinMa2pwMYq+TGGDCLY+IRam6igGDblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F5A112FC;
	Wed, 16 Jul 2025 03:19:38 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251AC3F694;
	Wed, 16 Jul 2025 03:19:44 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:19:38 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	kernel-team@meta.com, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, osandov@fb.com, leo.yan@arm.com,
	rmikey@meta.com
Subject: Re: [PATCH v2] arm64: Mark kernel as tainted on SAE and SError panic
Message-ID: <aHd8uvMegWXHyhvN@J2N7QTR9R3>
References: <20250716-vmcore_hw_error-v2-1-f187f7d62aba@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-vmcore_hw_error-v2-1-f187f7d62aba@debian.org>

Hi Breno,

On Wed, Jul 16, 2025 at 02:42:01AM -0700, Breno Leitao wrote:
> Set TAINT_MACHINE_CHECK when SError or Synchronous External Abort (SEA)
> interrupts trigger a panic to flag potential hardware faults. This
> tainting mechanism aids in debugging and enables correlation of
> hardware-related crashes in large-scale deployments.
> 
> This change aligns with similar patches[1] that mark machine check
> events when the system crashes due to hardware errors.
> 
> Link: https://lore.kernel.org/all/20250702-add_tain-v1-1-9187b10914b9@debian.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Also taint the kernel on Synchronous External Abort panics (Will Deacon)
> - Link to v1: https://lore.kernel.org/r/20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org

I think something went wrong when respinning this patch, because the v1
link above is incorrect, and should be:

  https://lore.kernel.org/linux-arm-kernel/20250710-arm_serror-v1-1-2a3def3740d7@debian.org/

The Cc header for this posting matches that of the unrelated patch (and
excludes Will, Catalin, etc), rather than that of the real v1. The
change-id trailer also doesn't match v1.

The actual patch and commit message look fine to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I assume that Will or Catalin will be happy to pick this up. I've added
those missing folk to this reply, so I don't imagine this should need a
respin.

Mark.

> ---
>  arch/arm64/kernel/traps.c | 1 +
>  arch/arm64/mm/fault.c     | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 9bfa5c944379d..7468b22585cef 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -931,6 +931,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
>  
>  void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
>  {
> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
>  	console_verbose();
>  
>  	pr_crit("SError Interrupt on CPU%d, code 0x%016lx -- %s\n",
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index ec0a337891ddf..004106ff4bd03 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -826,6 +826,7 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
>  		 */
>  		siaddr  = untagged_addr(far);
>  	}
> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
>  	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
>  
>  	return 0;
> 
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250707-vmcore_hw_error-322429e6c316
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
> 

