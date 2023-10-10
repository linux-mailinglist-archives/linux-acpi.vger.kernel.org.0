Return-Path: <linux-acpi+bounces-564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A37BF8C0
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 12:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20335280EC1
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C1FBED
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="htxhTZCG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E8182BE
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 10:30:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F927C4;
	Tue, 10 Oct 2023 03:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j0tKrd13x+vWl+pYbS4/PK06TRwyo2NxnIpkIOOXqKc=; b=htxhTZCGyOZ3etFbWskmZIJtSe
	Tq78kImhii3bptFi4H2I9Mq1kRQDKLMRl5CJtKaJBVS/QZidbgjBAiAJbdq5TkUkfmjtLiI6BKyKH
	5zmvplUiNziEZO7CRYqcoFctqGhx1AqwIhlU50MQ7p2McHXQuVpDcyqRTcoX4b4Lng8+pIZzQIxAm
	XlEIU6y8bxZnNbpKDtv3MmpxyUNxX+41l/gVSNoQho0c6ntF7gbRtM2vXbQDXZ0lQWXR94LyZ8w8K
	C5uI2EDzp7p58FGKy7KeRzoiWHBPk658vEkqVrd7HZ5e217TVzUQskX5ti05z/yXsa1DtigbmPLA9
	ymBrmKlA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qqA0S-00GmiM-19;
	Tue, 10 Oct 2023 10:30:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 77582300392; Tue, 10 Oct 2023 12:30:29 +0200 (CEST)
Date: Tue, 10 Oct 2023 12:30:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Meng Li <li.meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Shimmer Huang <shimmer.huang@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V8 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
Message-ID: <20231010103029.GH377@noisy.programming.kicks-ass.net>
References: <20231009024932.2563622-1-li.meng@amd.com>
 <20231009024932.2563622-2-li.meng@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009024932.2563622-2-li.meng@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 10:49:26AM +0800, Meng Li wrote:
> amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
> of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
> without Intel CPU support.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  arch/x86/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 66bfabae8814..a2e163acf623 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1054,8 +1054,9 @@ config SCHED_MC
>  
>  config SCHED_MC_PRIO
>  	bool "CPU core priorities scheduler support"
> -	depends on SCHED_MC && CPU_SUP_INTEL
> -	select X86_INTEL_PSTATE
> +	depends on SCHED_MC
> +	select X86_INTEL_PSTATE if CPU_SUP_INTEL
> +	select X86_AMD_PSTATE if CPU_SUP_AMD && ACPI
>  	select CPU_FREQ
>  	default y
>  	help

The pedantic side of me wants to point out that:

	depends on SCHED_MC
	depends on CPU_SUP_INTEL || CPU_SUP_AMD

would be more accurate, as we still have a pile of other SUPs.

Anyway, no real objection, distros will have them all set anyway.

