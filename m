Return-Path: <linux-acpi+bounces-8929-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D69ABCF6
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 06:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA13284AD2
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 04:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFD136353;
	Wed, 23 Oct 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYhq+N44"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E102861FE9;
	Wed, 23 Oct 2024 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729658431; cv=none; b=IdYnKwk/eovbqhu1bY48PHn3hBHWZbUCBg6UfZRmsynUHbEZfxlg5djPW3taKoDFTqi2fkXJ6XKY7WSYpxrTPJE3XOwqHKkAbm7OyOWUeyZN7vJLFSO9Sn/WKAUDgLnHNSVppU6E3R0TTabbKNBqTg5XlHbfOF6Le2VmWT24rMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729658431; c=relaxed/simple;
	bh=k45OVjGs9iuv8KVRrCMRpY3MSx0/BYB9+/YH2TkqHU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvV5Eh4tT7hTaQ+DD30VW+XhdYvQARAlgpTNIwTAZWUzogAn0TRDj2OsR0tterE58B9ea4+S8OSt9UxaGWqkEic9JUwi2EqpIlnkdDiMW5ljYpwEFA1sylgPdV9Nsmz0OZbWJaOhQXHGNn/f2MkJsrY/LfbwmoalRA+Xgool4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYhq+N44; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729658430; x=1761194430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k45OVjGs9iuv8KVRrCMRpY3MSx0/BYB9+/YH2TkqHU0=;
  b=UYhq+N44yCaIzjmpg5g+k20cAiOVZUpW9RhQTP+LyKR2EtQANKGm6Jpv
   o7cn27jymf06zUTXKROLXTYEnSWTQwMqeI8LqS9xR3c3CTSITfsd2zWac
   CU6fCptagvBjfI9Ef/lTA6jHTV7cm3mhtuIRMOEJdm7fisuL5qEnCnoIn
   AyrVroCy13nla1RZ/9nuAGFh8USXrXGBtGak8ejlA5nTzU7dMukoCz1bp
   wZ4jc7eWZ9DIWmEvfa4QsJW6nuNMx57vSqzhAHxPmgz810u0KG8efprVo
   iCAxas8bfQ0wVOQbzzbWEGeJ8qqFDhfkK0kvf9nGSUW6DzfPsqAW7zSZ5
   w==;
X-CSE-ConnectionGUID: 4ruDwtNBQSSXOrevrAD77A==
X-CSE-MsgGUID: oACUs4tCRk20/niGH+Qvyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29008269"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29008269"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:40:29 -0700
X-CSE-ConnectionGUID: 0b/Sj7WoTTedAdyShq+o2w==
X-CSE-MsgGUID: 10RlyhItQByXd72KbMQ7ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84057874"
Received: from jwolwowi-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:40:28 -0700
Date: Tue, 22 Oct 2024 21:40:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
Message-ID: <20241023044015.r3uc5s3g35s7y6ad@desk>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
 <20241022034608.32396-5-mario.limonciello@amd.com>
 <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>

On Tue, Oct 22, 2024 at 01:57:20PM +0200, Borislav Petkov wrote:
> On Mon, Oct 21, 2024 at 10:46:07PM -0500, Mario Limonciello wrote:
> > * Take this patch from Pawan's series and fix up for feedback left on it.
> > * Add in AMD case as well
> 
> Yah, this one is adding way more boilerplate code than it should. IOW, I'm
> thinking of something simpler like this:
> 
> ---
> 
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index 98eced5084ca..44122b077932 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -53,6 +53,7 @@ static inline void bus_lock_init(void) {}
>  #ifdef CONFIG_CPU_SUP_INTEL
>  u8 get_this_hybrid_cpu_type(void);
>  u32 get_this_hybrid_cpu_native_id(void);
> +enum x86_topology_cpu_type get_intel_cpu_type(struct cpuinfo_x86 *c);
>  #else
>  static inline u8 get_this_hybrid_cpu_type(void)
>  {
> @@ -63,6 +64,18 @@ static inline u32 get_this_hybrid_cpu_native_id(void)
>  {
>  	return 0;
>  }
> +static enum x86_topology_cpu_type get_intel_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	return TOPO_CPU_TYPE_UNKNOWN;
> +}
> +#endif
> +#ifdef CONFIG_CPU_SUP_AMD
> +enum x86_topology_cpu_type get_amd_cpu_type(struct cpuinfo_x86 *c);
> +#else
> +static inline enum x86_topology_cpu_type get_amd_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	return TOPO_CPU_TYPE_UNKNOWN;
> +}
>  #endif
>  #ifdef CONFIG_IA32_FEAT_CTL
>  void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 4a686f0e5dbf..c0975815980c 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -105,6 +105,24 @@ struct cpuinfo_topology {
>  	// Cache level topology IDs
>  	u32			llc_id;
>  	u32			l2c_id;
> +
> +	// Hardware defined CPU-type
> +	union {
> +		u32		cpu_type;
> +		struct {
> +			// CPUID.1A.EAX[23-0]
> +			u32	intel_native_model_id	:24;
> +			// CPUID.1A.EAX[31-24]
> +			u32	intel_type		:8;
> +		};
> +		struct {
> +			// CPUID 0x80000026.EBX
> +			u32	amd_num_processors	:16,
> +				amd_power_eff_ranking	:8,
> +				amd_native_model_id	:4,
> +				amd_type		:4;
> +		};
> +	};
>  };
>  
>  struct cpuinfo_x86 {
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index aef70336d624..c43d4b3324bc 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -114,6 +114,12 @@ enum x86_topology_domains {
>  	TOPO_MAX_DOMAIN,
>  };
>  
> +enum x86_topology_cpu_type {
> +	TOPO_CPU_TYPE_PERFORMANCE,
> +	TOPO_CPU_TYPE_EFFICIENCY,
> +	TOPO_CPU_TYPE_UNKNOWN,
> +};
> +
>  struct x86_topology_system {
>  	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
>  	unsigned int	dom_size[TOPO_MAX_DOMAIN];
> @@ -149,6 +155,8 @@ extern unsigned int __max_threads_per_core;
>  extern unsigned int __num_threads_per_package;
>  extern unsigned int __num_cores_per_package;
>  
> +const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
> +
>  static inline unsigned int topology_max_packages(void)
>  {
>  	return __max_logical_packages;
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index fab5caec0b72..7d8d62fdc112 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1205,3 +1205,12 @@ void amd_check_microcode(void)
>  	if (cpu_feature_enabled(X86_FEATURE_ZEN2))
>  		on_each_cpu(zenbleed_check_cpu, NULL, 1);
>  }
> +
> +enum x86_topology_cpu_type get_amd_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	switch (c->topo.amd_type) {
> +	case 0:	return TOPO_CPU_TYPE_PERFORMANCE;
> +	case 1:	return TOPO_CPU_TYPE_EFFICIENCY;
> +	}
> +	return TOPO_CPU_TYPE_UNKNOWN;
> +}
> diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
> index 3baf3e435834..10719aba6276 100644
> --- a/arch/x86/kernel/cpu/debugfs.c
> +++ b/arch/x86/kernel/cpu/debugfs.c
> @@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
>  	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
>  	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
>  	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
> +	seq_printf(m, "cpu_type:            %s\n", get_topology_cpu_type_name(c));
>  	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
>  	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
>  	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index d1de300af173..7b1011d0b369 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -907,3 +907,12 @@ u32 get_this_hybrid_cpu_native_id(void)
>  	return cpuid_eax(0x0000001a) &
>  	       (BIT_ULL(X86_HYBRID_CPU_TYPE_ID_SHIFT) - 1);
>  }
> +
> +enum x86_topology_cpu_type get_intel_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	switch (c->topo.intel_type) {
> +	case 0x20: return TOPO_CPU_TYPE_EFFICIENCY;
> +	case 0x40: return TOPO_CPU_TYPE_PERFORMANCE;
> +	}
> +	return TOPO_CPU_TYPE_UNKNOWN;
> +}

The name of the function is a bit misleading, as it suggests that it
returns the Intel specific CPU type(ATOM/CORE), but it actually returns
the performance/efficiency generic types.

I would suggest to name the function based on what it returns, like:

get_generic_cpu_type(struct cpuinfo_x86 *c)
{
     enum x86_topology_cpu_type type;

	if (c->x86_vendor == X86_VENDOR_INTEL) {
	     switch (c->topo.intel_type) {
		     case 0x20: return TOPO_CPU_TYPE_EFFICIENCY;
		     case 0x40: return TOPO_CPU_TYPE_PERFORMANCE;
	}
	if (c->x86_vendor == X86_VENDOR_AMD) {
	     switch (c->topo.amd_type) {
		     case 0: return TOPO_CPU_TYPE_PERFORMANCE;
		     case 1: return TOPO_CPU_TYPE_EFFICIENCY;
	}

	return TOPO_CPU_TYPE_UNKNOWN;
}

get_intel_cpu_type(struct cpuinfo_x86 *c)
{
	return c->topo.intel_type;
}

get_amd_cpu_type(struct cpuinfo_x86 *c)
{
	return c->topo.amd_type;
}

