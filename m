Return-Path: <linux-acpi+bounces-9879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A750D9E09EA
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 18:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B73BC0118
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051C148826;
	Mon,  2 Dec 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tly6BIIZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7613CFA8;
	Mon,  2 Dec 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155206; cv=none; b=aPpVhYVLn9WnLfdcRcaOCs0xWNfMxJDsurSJyRJys8/CdbASeIV3USyC9rFh9j1ASOx1VUiczGzl+/hPBMvW/DWJ8fEejhMxXjI4fGlNCs6HcYzA6VtH/jqqyq/KZYqGU6gpJemTJNmkR1Y/rALqJdimf/Vaaaer7tn4+OPi25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155206; c=relaxed/simple;
	bh=jwFkINJKzZ/sB6LcTpliw8jxBgl+f+o3H72qiwyiS6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrG/dFH3RdR8ZjRmYvPN+/fX91RBef+kR3D3rakfPxBdFejUV/Z8W3e4wcQ8It60Exs0EkMgD4YQgWoTutbva4x0LUZ/upiok27sITtKTLa9PqsLT7pBqv9QngDVBfIXYRvjgMJsRnK3UjY4ErDWlW8SlUWt+NS9DyeiQlDMSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tly6BIIZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qJdX4p3CGkapW21MdDcnSCR9NN49ym504eCw+/R0/hQ=; b=tly6BIIZpi4/awGcjyEWCFadRV
	COO5+8pL6DNDJuddGgvzd+SnCsCVfKI+lo2KqbJzD0G1k7VC1JPawyrZ7vqcRz+QDLEn8kf2ziy5u
	Bm2MtX+aAk6vleCe3Al5nRWGKI6b9vfqHmYX0gNjGoHig0/zM8wBcAKWJHkzY6Ss6vuHePZvcYjr5
	7y40GkEmI44cOpJf1hhgCMNLm0j01FBDR63BmAPY1M7K1Nu1bQtL6Alh36Km14y/OTy8pwFvvYSCU
	oBoiiOAF144yTTwI75i0+xv9wYBCnE3eIrj0ozH3yTfeYKQPHmYICq36+JEPfSY/Z5P5i4v8+IsIL
	lfG5g+Hw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI8py-00000008GKq-2EZe;
	Mon, 02 Dec 2024 15:59:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 325E7300402; Mon,  2 Dec 2024 16:59:51 +0100 (CET)
Date: Mon, 2 Dec 2024 16:59:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v7 09/12] x86/process: Clear hardware feedback history
 for AMD processors
Message-ID: <20241202155951.GH35539@noisy.programming.kicks-ass.net>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-10-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130140703.557-10-mario.limonciello@amd.com>

On Sat, Nov 30, 2024 at 08:07:00AM -0600, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> Incorporate a mechanism within the context switching code to reset
> the hardware history for AMD processors. Specifically, when a task
> is switched in, the class ID was read and reset the hardware workload
> classification history of CPU firmware and then it start to trigger
> workload classification for the next running thread.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 226472332a70d..371e0e8f987fa 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -709,6 +709,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in(next_p);
>  
> +	/* Reset hw history on AMD CPUs */
> +	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
> +		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
> +
>  	return prev_p;
>  }

BTW, how many cycles for this WRMSR ?

And, as already stated, I'm failing to find the actual classification
code, but assuming that's RDMSR(s?), how much for them?



