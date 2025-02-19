Return-Path: <linux-acpi+bounces-11325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABDDA3C965
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 21:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3013B308C
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3455822DFA0;
	Wed, 19 Feb 2025 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq6uS+bj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700B22D7AE;
	Wed, 19 Feb 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995906; cv=none; b=O5CkDpI+zkP8Fz6M9/OjGDiRE8sKzWMBJal6Z9ak1wtlH/+1r1GEe0E21TpifHV5eHsn7JBVkysAcPnezfeijtCsdy1AnWrCp3a2IWJ16Nb+EScc7bfxoCRFtD5Ay/Uvcy3euToMNPzGFSsc9pJJqhOP60QkgNXZDXUZqUQVhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995906; c=relaxed/simple;
	bh=g5h/L5c4m5ie/+2vSmDWWSe3o5PhwXyQcgTXMORN2ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpsToFxAkU+S/Qd5GdpDqZ/nJfEnV2e//5I7V64NhELBbwrnpuyKp7OflQi894is6OgGkwI7i2Rmeu4kT0wNYv37DGStvl885yF/IqS35bhBo/xY04sD1xaYay8+NBoCZsiDIat0pefwWqlh+43WycWoAhYRHrNCrqTsEv1XYdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq6uS+bj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739995904; x=1771531904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g5h/L5c4m5ie/+2vSmDWWSe3o5PhwXyQcgTXMORN2ws=;
  b=Oq6uS+bjtNHUqP/7dUKFOqYfcIgR0a9f/6eI427lP02Dt1fs46/2AWTp
   g18Nq74emT7HHDMF65WX8wlj+4rQ4z2UKnmMhmk81UwMIG7Maze3ZK1Ir
   YcgyTDuFYvdvp1Q/VqaRZZrERI/hG4xdFl70oESRqe1aORISR3v88XWLh
   YzLU1dEAJbbNU4zcmBVyvdOEfEP3XaHnyjEBMNPkmdIuDpIv+jLS5n4qb
   AgMh8sgkhSmZjAySU7rLIse4kZWUi3LmhPQ6YgoTnlNlsfQnhundxdMF1
   dP88aB5X3vKk7jDh+t1HWOy1ScsU0jEu6+S6a52llD+dTikvCoDA3hmbR
   Q==;
X-CSE-ConnectionGUID: HQlepjy5ToCk3E/s8Ic6rw==
X-CSE-MsgGUID: TMJ0sYgyRSO207oZK9Yvyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51392312"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51392312"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:11:43 -0800
X-CSE-ConnectionGUID: VDFCx7MrQDmlew8iW0VnGw==
X-CSE-MsgGUID: BpxQDej4RuanYncBJU0ZsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115725340"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:11:43 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A42FB20B5713;
	Wed, 19 Feb 2025 12:11:39 -0800 (PST)
Message-ID: <6a33e1b1-0371-4a4e-a04d-2d76595362ab@linux.intel.com>
Date: Wed, 19 Feb 2025 15:11:37 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] perf/x86/p4: Replace Pentium 4 model checks with
 VFM ones
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
 <20250219184133.816753-16-sohil.mehta@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250219184133.816753-16-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-19 1:41 p.m., Sohil Mehta wrote:
> Introduce names for some old pentium 4 models and replace x86_model
> checks with VFM ones.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>


Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> v3: No change.
> v2: No change.
> ---
>  arch/x86/events/intel/p4.c          | 7 ++++---
>  arch/x86/include/asm/intel-family.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
> index 844bc4fc4724..fb726c6fc6e7 100644
> --- a/arch/x86/events/intel/p4.c
> +++ b/arch/x86/events/intel/p4.c
> @@ -10,6 +10,7 @@
>  #include <linux/perf_event.h>
>  
>  #include <asm/perf_event_p4.h>
> +#include <asm/cpu_device_id.h>
>  #include <asm/hardirq.h>
>  #include <asm/apic.h>
>  
> @@ -732,9 +733,9 @@ static bool p4_event_match_cpu_model(unsigned int event_idx)
>  {
>  	/* INSTR_COMPLETED event only exist for model 3, 4, 6 (Prescott) */
>  	if (event_idx == P4_EVENT_INSTR_COMPLETED) {
> -		if (boot_cpu_data.x86_model != 3 &&
> -			boot_cpu_data.x86_model != 4 &&
> -			boot_cpu_data.x86_model != 6)
> +		if (boot_cpu_data.x86_vfm != INTEL_P4_PRESCOTT &&
> +		    boot_cpu_data.x86_vfm != INTEL_P4_PRESCOTT_2M &&
> +		    boot_cpu_data.x86_vfm != INTEL_P4_CEDARMILL)
>  			return false;
>  	}
>  
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 6621d796bb3d..89cb545d521b 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -193,6 +193,7 @@
>  /* Family 15 - NetBurst */
>  #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
>  #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
> +#define INTEL_P4_PRESCOTT_2M		IFM(15, 0x04)
>  #define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
>  
>  /* Family 19 */


