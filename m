Return-Path: <linux-acpi+bounces-11326-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63053A3C969
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 21:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3509A189827B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3522D7B0;
	Wed, 19 Feb 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnmgCWNJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F661BD00C;
	Wed, 19 Feb 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995975; cv=none; b=GUJtFbA90tnnbjN2niR58rh6YwvKJ8WPlz2iD6TFB+31Usq1ln6H1sV0oPkvsC02fG4u+k/NI9EyCmAAStqiNf6v8qpqExUPkh6LyuaibhvhXzeoFCJh6YndkzySi/UBwj3bt0h5+9+xR65t9vNUohzQ+Lfp4U+iA4GQ2sFA0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995975; c=relaxed/simple;
	bh=ND/8Wxv5gQFIoFsWtPtheJF33IR5DdoAJv/lL7RafJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bl5cgri923hnGEoZd/bCbeEIT7IAiatjp6t8LN0DvssE6BSYd5I7i7e4lUMABN9JDcOvqKcjmz7/gnz7OJFNwyG0rDzkK6WJ6FAw8Kl7co82PuQRorXaYZ3wKRgS65+7JSd4D2LArpUTTwrKMqg3kxgpAnfIaeNRWcFfmzY0i+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnmgCWNJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739995975; x=1771531975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ND/8Wxv5gQFIoFsWtPtheJF33IR5DdoAJv/lL7RafJE=;
  b=hnmgCWNJPE8qBDlG33mphgtS+E5GVm5/C6yPiWzgMEgKAyT2jIsoNlFS
   0LERw3zi69ahOaOpKPniKEWMldaxa+EAZB7wg5TkSf0DVeQiRM2tbtXmY
   QtYjK4+TKy+GIMQpZswQdo2XNfinzti3CWpb31WiWLeldScfn1FBXTV97
   gm1z7AIlzgoCyecHWBTKhBkATXpmGU89TxJwLMDxGEnVQYhXl0Ks4DhiS
   6GOgGA7WZxVAWmjXsEDfMDkP0UwCHL34s6hfcLvKBlZ92SH97Fq6Y8r8Z
   9M+FcrFrlwc/s1nIM3E4oTctCUkJn7O/l3kDVxjgh/pY1GoD2jMysmnaS
   Q==;
X-CSE-ConnectionGUID: Ib2z7kGEQ8yUKJOB7OBH0g==
X-CSE-MsgGUID: +X3WIQ8NTEafnITY/PyOig==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="50965958"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="50965958"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:12:53 -0800
X-CSE-ConnectionGUID: BZUk7FQcRcmkW+2oQKS2JA==
X-CSE-MsgGUID: ivcYCpZ+RN28xNfCPYJ9fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115480846"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:10:49 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 341C420B5713;
	Wed, 19 Feb 2025 12:10:43 -0800 (PST)
Message-ID: <49c59a81-015f-46a1-88b9-f043ca2710d0@linux.intel.com>
Date: Wed, 19 Feb 2025 15:10:42 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] perf/x86: Simplify Intel PMU initialization
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250219184133.816753-1-sohil.mehta@intel.com>
 <20250219184133.816753-15-sohil.mehta@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250219184133.816753-15-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-19 1:41 p.m., Sohil Mehta wrote:
> Architectural Perfmon was introduced on the Family 6 "Core" processors
> starting with Yonah. Processors before Yonah need their own customized
> PMU initialization.
> 
> p6_pmu_init() is expected to provide that initialization for early
> Family 6 processors. But, due to the unrestricted call to p6_pmu_init(),
> it could get called for any Family 6 processor if the architectural
> perfmon feature is disabled on that processor.
> 
> To simplify, restrict the call to p6_pmu_init() to early Family 6
> processors that do not have architectural perfmon support. As a result,
> the "unsupported" console print becomes practically unreachable because
> all the released P6 processors are covered by the switch cases.
> 
> Move the console print to a common location where it can cover all
> modern processors that do not have architectural perfmon support.
> 
> Also, use this opportunity to get rid of the unnecessary switch cases in
> p6_pmu_init().  Only the Pentium Pro processor needs a quirk, and the
> rest of the processors do not need any special handling. The gaps in the
> case numbers are only due to no processor with those model numbers being
> released.
> 
> Converting to a VFM based check gets rid of one last few Intel x86_model
> comparisons.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v3: Restrict calling p6_pmu_init() to only when needed.
>     Move the console print to a common location.
> 
> v2: No change.
> ---
>  arch/x86/events/intel/core.c | 16 +++++++++++-----
>  arch/x86/events/intel/p6.c   | 26 +++-----------------------
>  2 files changed, 14 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 7601196d1d18..c645d8c8ab87 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6466,16 +6466,22 @@ __init int intel_pmu_init(void)
>  	char *name;
>  	struct x86_hybrid_pmu *pmu;
>  
> +	/* Architectural Perfmon was introduced starting with INTEL_CORE_YONAH */
>  	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
>  		switch (boot_cpu_data.x86) {
> -		case 0x6:
> -			return p6_pmu_init();
> -		case 0xb:
> +		case 6:
> +			if (boot_cpu_data.x86_vfm < INTEL_CORE_YONAH)
> +				return p6_pmu_init();
> +			break;

We may need a return -ENODEV here.

I think it's possible that some weird hypervisor doesn't enumerate the
ARCH_PERFMON for a modern CPU. Perf should not touch the leaf 10 if the
ARCH_PERFMON is not supported.

Thanks,
Kan

> +		case 11:
>  			return knc_pmu_init();
> -		case 0xf:
> +		case 15:
>  			return p4_pmu_init();
> +		default:
> +			pr_cont("unsupported CPU family %d model %d ",
> +				boot_cpu_data.x86, boot_cpu_data.x86_model);
> +			return -ENODEV;
>  		}
> -		return -ENODEV;
>  	}
>  
>  	/*
> diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
> index a6cffb4f4ef5..65b45e9d7016 100644
> --- a/arch/x86/events/intel/p6.c
> +++ b/arch/x86/events/intel/p6.c
> @@ -2,6 +2,8 @@
>  #include <linux/perf_event.h>
>  #include <linux/types.h>
>  
> +#include <asm/cpu_device_id.h>
> +
>  #include "../perf_event.h"
>  
>  /*
> @@ -248,30 +250,8 @@ __init int p6_pmu_init(void)
>  {
>  	x86_pmu = p6_pmu;
>  
> -	switch (boot_cpu_data.x86_model) {
> -	case  1: /* Pentium Pro */
> +	if (boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO)
>  		x86_add_quirk(p6_pmu_rdpmc_quirk);
> -		break;
> -
> -	case  3: /* Pentium II - Klamath */
> -	case  5: /* Pentium II - Deschutes */
> -	case  6: /* Pentium II - Mendocino */
> -		break;
> -
> -	case  7: /* Pentium III - Katmai */
> -	case  8: /* Pentium III - Coppermine */
> -	case 10: /* Pentium III Xeon */
> -	case 11: /* Pentium III - Tualatin */
> -		break;
> -
> -	case  9: /* Pentium M - Banias */
> -	case 13: /* Pentium M - Dothan */
> -		break;
> -
> -	default:
> -		pr_cont("unsupported p6 CPU model %d ", boot_cpu_data.x86_model);
> -		return -ENODEV;
> -	}
>  
>  	memcpy(hw_cache_event_ids, p6_hw_cache_event_ids,
>  		sizeof(hw_cache_event_ids));


