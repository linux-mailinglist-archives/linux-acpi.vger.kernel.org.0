Return-Path: <linux-acpi+bounces-11329-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E52A3CA4A
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 21:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4140D18977EE
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9978B241C8C;
	Wed, 19 Feb 2025 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUe/osxj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8E22CBFD;
	Wed, 19 Feb 2025 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997917; cv=none; b=TNJcfdHySi4FPCeTJYxF4131M3hHp5zef04aY3mZ0HHW8hdvySyjuiqgw5kVU5gcWQ+mIwuPiq2K1VannSesXxs8SD80Jh99Yl6HHjSBTwYYTUIKQ/c9TwR8HaFxJIWmrwKYR8CVJR1Gdp2gD5RQGpemZq4pkyhscCHguZOB+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997917; c=relaxed/simple;
	bh=s2wMZfJnaUf8IXcD+1yWyWxgV8ejMUDjh5RD4X1K350=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MepeP4ZdhwlbX8BnhbUMd48PDiBHk2903aApmNFSrVl+NEhWRLPwxxwVEjMDPgNNi09IK5X6zn2uuZ4Ie1iYrsIGKo443Axd9NMEpidq0hf+MbHwaB1DCrTyqEZ8yzX6JwewzOHCuiU/bPU2ETVPxA0kMeiJS/nauYqHL/Qbm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUe/osxj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739997915; x=1771533915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s2wMZfJnaUf8IXcD+1yWyWxgV8ejMUDjh5RD4X1K350=;
  b=KUe/osxjA48klQDraA1O19A/3wx+ctqBwPpbuN0SaiQKTb8esAJeyOp9
   NRxQoSB+5MMx/MBcU+XcuWxKnIvMcJBM6rdSuR3ZiHcSZbaKU0G3VetMj
   OO29FbtP/OSPNBAidGK0rExVQZtuWce4IMrNz7OQZqGlKe3k3QJelK+14
   ygVdCNLsBiiF35Y+GgNIjjuSwAT3RtRUmhslRhMwJ8WF8kjrFpyvDizJC
   SsYXez9sAWsWDkTPwd0mNtmtL0dJyjibS1k0giKk3uqWHDTfc9KR64lP9
   J+SKNOqrmZOjy4iJr6enu9M5HtIOY/2s3zT2330OSH2myvr7EU4tNEoZk
   Q==;
X-CSE-ConnectionGUID: kN9dCS7wTASW6oHx/LxfDw==
X-CSE-MsgGUID: +D19A1nqSQuHKkNwrsrm/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="43584298"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="43584298"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:45:14 -0800
X-CSE-ConnectionGUID: 68490pQeSbq6RD0AznNXTw==
X-CSE-MsgGUID: cexZMoqjRCKs7t3r0TpYVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114660155"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:45:13 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9220420B5713;
	Wed, 19 Feb 2025 12:45:09 -0800 (PST)
Message-ID: <490badc1-443b-4f90-a06e-da19ba77583a@linux.intel.com>
Date: Wed, 19 Feb 2025 15:45:08 -0500
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
 <49c59a81-015f-46a1-88b9-f043ca2710d0@linux.intel.com>
 <3f3f6589-8074-4a9a-936f-513013c43477@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <3f3f6589-8074-4a9a-936f-513013c43477@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-19 3:31 p.m., Sohil Mehta wrote:
> On 2/19/2025 12:10 PM, Liang, Kan wrote:
>>
>>
>> On 2025-02-19 1:41 p.m., Sohil Mehta wrote:
>>> Architectural Perfmon was introduced on the Family 6 "Core" processors
>>> starting with Yonah. Processors before Yonah need their own customized
>>> PMU initialization.
>>>
>>> p6_pmu_init() is expected to provide that initialization for early
>>> Family 6 processors. But, due to the unrestricted call to p6_pmu_init(),
>>> it could get called for any Family 6 processor if the architectural
>>> perfmon feature is disabled on that processor.
>>>
>>> To simplify, restrict the call to p6_pmu_init() to early Family 6
>>> processors that do not have architectural perfmon support. As a result,
>>> the "unsupported" console print becomes practically unreachable because
>>> all the released P6 processors are covered by the switch cases.
>>>
>>> Move the console print to a common location where it can cover all
>>> modern processors that do not have architectural perfmon support.
>>>
>>> Also, use this opportunity to get rid of the unnecessary switch cases in
>>> p6_pmu_init().  Only the Pentium Pro processor needs a quirk, and the
>>> rest of the processors do not need any special handling. The gaps in the
>>> case numbers are only due to no processor with those model numbers being
>>> released.
>>>
>>> Converting to a VFM based check gets rid of one last few Intel x86_model
>>> comparisons.
>>>
>>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>>> ---
>>> v3: Restrict calling p6_pmu_init() to only when needed.
>>>     Move the console print to a common location.
>>>
>>> v2: No change.
>>> ---
>>>  arch/x86/events/intel/core.c | 16 +++++++++++-----
>>>  arch/x86/events/intel/p6.c   | 26 +++-----------------------
>>>  2 files changed, 14 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 7601196d1d18..c645d8c8ab87 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -6466,16 +6466,22 @@ __init int intel_pmu_init(void)
>>>  	char *name;
>>>  	struct x86_hybrid_pmu *pmu;
>>>  
>>> +	/* Architectural Perfmon was introduced starting with INTEL_CORE_YONAH */
>>>  	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
>>>  		switch (boot_cpu_data.x86) {
>>> -		case 0x6:
>>> -			return p6_pmu_init();
>>> -		case 0xb:
>>> +		case 6:
>>> +			if (boot_cpu_data.x86_vfm < INTEL_CORE_YONAH)
>>> +				return p6_pmu_init();
>>> +			break;
>>
>> We may need a return -ENODEV here.
>>
> 
> That makes sense. See below.
> 
>> I think it's possible that some weird hypervisor doesn't enumerate the
>> ARCH_PERFMON for a modern CPU. Perf should not touch the leaf 10 if the
>> ARCH_PERFMON is not supported.
>>
>> Thanks,
>> Kan
>>
>>> +		case 11:
>>>  			return knc_pmu_init();
>>> -		case 0xf:
>>> +		case 15:
>>>  			return p4_pmu_init();
>>> +		default:
>>> +			pr_cont("unsupported CPU family %d model %d ",
>>> +				boot_cpu_data.x86, boot_cpu_data.x86_model);
>>> +			return -ENODEV;
>>>  		}
>>> -		return -ENODEV;
>>>  	}
>>>  
> 
> 
> How about moving the default case out of the switch statement as shown?
> That would make sure that the unsupported print would also get included
> with the -ENODEV.
> 
> 	/* Architectural Perfmon was introduced starting with INTEL_CORE_YONAH */
> 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
> 		switch (boot_cpu_data.x86) {
> 		case 6:
> 			if (boot_cpu_data.x86_vfm < INTEL_CORE_YONAH)
> 				return p6_pmu_init();
> 			break;
> 		case 11:
> 			return knc_pmu_init();
> 		case 15:
> 			return p4_pmu_init();
> 		}
> 
> 		pr_cont("unsupported CPU family %d model %d ",
> 			boot_cpu_data.x86, boot_cpu_data.x86_model);
> 		return -ENODEV;
> 	}

It looks good to me.

With the above change,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

