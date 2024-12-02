Return-Path: <linux-acpi+bounces-9872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D636E9E0104
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 12:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB76B24202
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A2C1FC0E8;
	Mon,  2 Dec 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dF0vqT0I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF421D932F;
	Mon,  2 Dec 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139618; cv=none; b=W3aXfFvYLoOkyZ3fK2P9RgIygr/OQNLnpvlAAJyx76QBwP1Yr7WpzT6xtR2NZSEBZzYx31ICsDqEIw67leGE25miiAlQ/VNTkxIffKF8sK9bzSerrRlLtbPDhtS5rO23UYgN3G6JGwEW/0mWK9GcnE2P/6ZSZOwQ3bidvMlqXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139618; c=relaxed/simple;
	bh=sVjfGzbM8GkA7FgUwyXuWWLlTiQo1APuR3f5at2NHJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUMRFSYEttfGTOuixPiOO76+TB4GEsvzpNzvo4bX83k/91s93ywuk0wpGYDOhWdS7ZYVNcoqZDKjny6rV56iYGIQJADT0JRYAgKDHulVRBov2g/HEpmOtR6ciunE4mGJBB7FcHZIUZYpqGJDGm8t/LEnxotPwqVsOBlfwMUAj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dF0vqT0I; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dqsBUO2AtrBbl+piXnLKZ7wdM4LFuVUZ403tmHUrMW0=; b=dF0vqT0I7NWiSXHruEeDOFETCh
	Dipy63vWKGBwNCNvUpfNBxrOjm5OJDdiBL1tG+cPSbgInDAX6Y75JnwPfJahzAXn1Cx1ZJn6US0nV
	ocVY54wF+1aVkBTw8YQNBbNhV8O/Nd894BNLQwSGM4GfcWD82yEsCHn0YzQijzUuOHuKJ4LuiFcxM
	9fe5sfqshiQCKNvFQ5crhsW+BsPw2RF7CZX00jDvXs3sce+s3WPMmPjZ40lG4yTz5NEiSmoAlID8S
	NmuQbrXo+fS/mZ0/6ie0AlM7yHyn15huP5pNvRoqUwKv7NXp6xvhPzr1Uo0OTHDa0+9CKjxxs0ng/
	Nc556o8g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI4ma-00000002AFx-0hTS;
	Mon, 02 Dec 2024 11:40:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F211300402; Mon,  2 Dec 2024 12:40:03 +0100 (CET)
Date: Mon, 2 Dec 2024 12:40:03 +0100
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
Message-ID: <20241202114003.GC8562@noisy.programming.kicks-ass.net>
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
>  arch/x86/kernel/process_32.c | 4 ++++
>  arch/x86/kernel/process_64.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 0917c7f25720b..0bb6391b9089b 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -213,6 +213,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in(next_p);
>  
> +	/* Reset hw history on AMD CPUs */
> +	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
> +		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
> +
>  	return prev_p;
>  }

Are you really going to support all this jazz on 32bit builds?

