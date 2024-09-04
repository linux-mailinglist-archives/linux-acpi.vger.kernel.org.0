Return-Path: <linux-acpi+bounces-8158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86A96C97C
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 23:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02FC1F26634
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD244156F42;
	Wed,  4 Sep 2024 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5az4+5V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FC149DFF;
	Wed,  4 Sep 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484789; cv=none; b=s9fAHnGZLPYSaNIGvQj546DwlrDmi2XRJNxeYxucrwbJsw9bMoACp11MifkmHHBd0NEakcOTT1+RcPC8wyjOoy5qgBsY1WofRFULg1THRKrl8WPVOtOd0TNIZOdoFLwDlIquEFKvqpsUA2ZhrCUFqypov4F9qGWhV/n6aWz63K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484789; c=relaxed/simple;
	bh=I2LCAvm7Y0zo0WMz3B9ixJymul+nOF2oWdfEiM56SU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV9CcVaw5PxZrQ97YYzgTn19z/YxMuJOY0FqvO9IwX7qtyMZ2O4criC6YUEssOpu8BC/YDOYmaR9duzkMdBUItPrUVggCLvdIxMpIkXI8m6ffeOBH26HxsbkrlZ3DchGmTHrC4/8snabHEvZViHG0e7CdgzJDOW32Z9OidXM3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5az4+5V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725484784; x=1757020784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I2LCAvm7Y0zo0WMz3B9ixJymul+nOF2oWdfEiM56SU4=;
  b=m5az4+5Vz8n3WAyB5eOADQtoGNaOU8hHlugdz3BBVXegTRZ1DRszF6C7
   M8HPBQVokTu/xOFp2pBev7fgYVexjW7WpAelRkdJdTmpu/21wVj8nqRGt
   BOhJXrEkFOA7YYiYofQjc4BtdrxSRhVEwY3XPMBDy3S7u+fQy47bnBfvg
   MRn+0eM9uhFwuuzMTRXx8VvQK2P0pvH6apRY6txE0+sKP0vCwtthvg0gj
   zmm74/H6wnADZFYe1s9IYBZ+7XZtqfDKdGpWVH/g/akul2JNdqzNYSjbp
   MWkM3yfRvHhA/1SpUvFzabaTgSN1733Q0M3+xeJp0i52VwBRAuUcoBRgH
   g==;
X-CSE-ConnectionGUID: G5Ea6eBaQBOvLjIpWcVGKA==
X-CSE-MsgGUID: gQfQw5uyRmOGMtBNbb7CtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27961111"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="27961111"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 14:19:44 -0700
X-CSE-ConnectionGUID: TEbomKlNRKmO3hsT5T+YeA==
X-CSE-MsgGUID: sUpmoz9HTliFK7oUjoM7wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65227548"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Sep 2024 14:19:41 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slxPe-0008Z1-2k;
	Wed, 04 Sep 2024 21:19:38 +0000
Date: Thu, 5 Sep 2024 05:18:47 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"(maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"(open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 07/11] x86/amd: Detect preferred cores in
 amd_get_boost_ratio_numerator()
Message-ID: <202409050432.AoAbkkyJ-lkp@intel.com>
References: <20240903203701.2695040-8-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903203701.2695040-8-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge tip/x86/core tip/master linus/master v6.11-rc6 next-20240904]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/x86-amd-Move-amd_get_highest_perf-from-amd-c-to-cppc-c/20240904-044140
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240903203701.2695040-8-superm1%40kernel.org
patch subject: [PATCH v2 07/11] x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240905/202409050432.AoAbkkyJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409050432.AoAbkkyJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409050432.AoAbkkyJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cpufreq/amd-pstate.c:42:
>> include/acpi/cppc_acpi.h:242:19: error: static declaration of 'amd_get_highest_perf' follows non-static declaration
     242 | static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/acpi/cppc_acpi.h:141:12: note: previous declaration of 'amd_get_highest_perf' with type 'int(unsigned int,  u32 *)' {aka 'int(unsigned int,  unsigned int *)'}
     141 | extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
         |            ^~~~~~~~~~~~~~~~~~~~
>> include/acpi/cppc_acpi.h:246:19: error: static declaration of 'amd_get_boost_ratio_numerator' follows non-static declaration
     246 | static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/acpi/cppc_acpi.h:142:12: note: previous declaration of 'amd_get_boost_ratio_numerator' with type 'int(unsigned int,  u64 *)' {aka 'int(unsigned int,  long long unsigned int *)'}
     142 | extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/amd_get_highest_perf +242 include/acpi/cppc_acpi.h

337aadff8e4567 Ashwin Chaugule    2015-10-02  140  
7885bc49834406 Mario Limonciello  2024-09-03  141  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
7885bc49834406 Mario Limonciello  2024-09-03  142  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
8a02d99876362f Rafael J. Wysocki  2021-03-16  143  #ifdef CONFIG_ACPI_CPPC_LIB
1757d05f3112ac Xiongfeng Wang     2019-02-17  144  extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
0654cf05d17bc4 Rafael J. Wysocki  2021-09-04  145  extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
12753d71e8c5c3 Meng Li            2024-01-19  146  extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
337aadff8e4567 Ashwin Chaugule    2015-10-02  147  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
337aadff8e4567 Ashwin Chaugule    2015-10-02  148  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
fb0b00af04d083 Jinzhou Su         2021-12-24  149  extern int cppc_set_enable(int cpu, bool enable);
337aadff8e4567 Ashwin Chaugule    2015-10-02  150  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
ae2df912d1a557 Jeremy Linton      2022-09-12  151  extern bool cppc_perf_ctrs_in_pcc(void);
50b813b147e9eb Vincent Guittot    2023-12-11  152  extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
50b813b147e9eb Vincent Guittot    2023-12-11  153  extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
a28b2bfc099c6b Ionela Voinescu    2020-12-14  154  extern bool acpi_cpc_valid(void);
3cc30dd00a580c Pierre Gondois     2022-05-18  155  extern bool cppc_allow_fast_switch(void);
a28b2bfc099c6b Ionela Voinescu    2020-12-14  156  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
be8b88d7d98771 Prakash, Prashanth 2016-08-16  157  extern unsigned int cppc_get_transition_latency(int cpu);
ad3bc25a320742 Borislav Petkov    2018-12-05  158  extern bool cpc_ffh_supported(void);
8b356e536e69f3 Mario Limonciello  2022-07-05  159  extern bool cpc_supported_by_cpu(void);
ad3bc25a320742 Borislav Petkov    2018-12-05  160  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
ad3bc25a320742 Borislav Petkov    2018-12-05  161  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
7bc1fcd3990182 Perry Yuan         2023-01-31  162  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
7bc1fcd3990182 Perry Yuan         2023-01-31  163  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
c984f5d5d45bd5 Wyes Karny         2023-03-07  164  extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
c984f5d5d45bd5 Wyes Karny         2023-03-07  165  extern int cppc_set_auto_sel(int cpu, bool enable);
cfa6630658f7de Mario Limonciello  2024-09-03  166  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
402eea79aece78 Mario Limonciello  2024-09-03  167  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
7885bc49834406 Mario Limonciello  2024-09-03  168  extern int amd_detect_prefcore(bool *detected);
8a02d99876362f Rafael J. Wysocki  2021-03-16  169  #else /* !CONFIG_ACPI_CPPC_LIB */
8a02d99876362f Rafael J. Wysocki  2021-03-16  170  static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
8a02d99876362f Rafael J. Wysocki  2021-03-16  171  {
e224a868e488cf Mario Limonciello  2024-09-03  172  	return -EOPNOTSUPP;
8a02d99876362f Rafael J. Wysocki  2021-03-16  173  }
0654cf05d17bc4 Rafael J. Wysocki  2021-09-04  174  static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
0654cf05d17bc4 Rafael J. Wysocki  2021-09-04  175  {
e224a868e488cf Mario Limonciello  2024-09-03  176  	return -EOPNOTSUPP;
0654cf05d17bc4 Rafael J. Wysocki  2021-09-04  177  }
12753d71e8c5c3 Meng Li            2024-01-19  178  static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
12753d71e8c5c3 Meng Li            2024-01-19  179  {
e224a868e488cf Mario Limonciello  2024-09-03  180  	return -EOPNOTSUPP;
12753d71e8c5c3 Meng Li            2024-01-19  181  }
8a02d99876362f Rafael J. Wysocki  2021-03-16  182  static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
8a02d99876362f Rafael J. Wysocki  2021-03-16  183  {
e224a868e488cf Mario Limonciello  2024-09-03  184  	return -EOPNOTSUPP;
8a02d99876362f Rafael J. Wysocki  2021-03-16  185  }
8a02d99876362f Rafael J. Wysocki  2021-03-16  186  static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
8a02d99876362f Rafael J. Wysocki  2021-03-16  187  {
e224a868e488cf Mario Limonciello  2024-09-03  188  	return -EOPNOTSUPP;
8a02d99876362f Rafael J. Wysocki  2021-03-16  189  }
fb0b00af04d083 Jinzhou Su         2021-12-24  190  static inline int cppc_set_enable(int cpu, bool enable)
fb0b00af04d083 Jinzhou Su         2021-12-24  191  {
e224a868e488cf Mario Limonciello  2024-09-03  192  	return -EOPNOTSUPP;
fb0b00af04d083 Jinzhou Su         2021-12-24  193  }
8a02d99876362f Rafael J. Wysocki  2021-03-16  194  static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
8a02d99876362f Rafael J. Wysocki  2021-03-16  195  {
e224a868e488cf Mario Limonciello  2024-09-03  196  	return -EOPNOTSUPP;
8a02d99876362f Rafael J. Wysocki  2021-03-16  197  }
ae2df912d1a557 Jeremy Linton      2022-09-12  198  static inline bool cppc_perf_ctrs_in_pcc(void)
ae2df912d1a557 Jeremy Linton      2022-09-12  199  {
ae2df912d1a557 Jeremy Linton      2022-09-12  200  	return false;
ae2df912d1a557 Jeremy Linton      2022-09-12  201  }
8a02d99876362f Rafael J. Wysocki  2021-03-16  202  static inline bool acpi_cpc_valid(void)
8a02d99876362f Rafael J. Wysocki  2021-03-16  203  {
8a02d99876362f Rafael J. Wysocki  2021-03-16  204  	return false;
8a02d99876362f Rafael J. Wysocki  2021-03-16  205  }
3cc30dd00a580c Pierre Gondois     2022-05-18  206  static inline bool cppc_allow_fast_switch(void)
3cc30dd00a580c Pierre Gondois     2022-05-18  207  {
3cc30dd00a580c Pierre Gondois     2022-05-18  208  	return false;
3cc30dd00a580c Pierre Gondois     2022-05-18  209  }
8a02d99876362f Rafael J. Wysocki  2021-03-16  210  static inline unsigned int cppc_get_transition_latency(int cpu)
8a02d99876362f Rafael J. Wysocki  2021-03-16  211  {
8a02d99876362f Rafael J. Wysocki  2021-03-16  212  	return CPUFREQ_ETERNAL;
8a02d99876362f Rafael J. Wysocki  2021-03-16  213  }
8a02d99876362f Rafael J. Wysocki  2021-03-16  214  static inline bool cpc_ffh_supported(void)
8a02d99876362f Rafael J. Wysocki  2021-03-16  215  {
8a02d99876362f Rafael J. Wysocki  2021-03-16  216  	return false;
8a02d99876362f Rafael J. Wysocki  2021-03-16  217  }
8a02d99876362f Rafael J. Wysocki  2021-03-16  218  static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
8a02d99876362f Rafael J. Wysocki  2021-03-16  219  {
e224a868e488cf Mario Limonciello  2024-09-03  220  	return -EOPNOTSUPP;
8a02d99876362f Rafael J. Wysocki  2021-03-16  221  }
8a02d99876362f Rafael J. Wysocki  2021-03-16  222  static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
8a02d99876362f Rafael J. Wysocki  2021-03-16  223  {
e224a868e488cf Mario Limonciello  2024-09-03  224  	return -EOPNOTSUPP;
8a02d99876362f Rafael J. Wysocki  2021-03-16  225  }
7bc1fcd3990182 Perry Yuan         2023-01-31  226  static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
7bc1fcd3990182 Perry Yuan         2023-01-31  227  {
e224a868e488cf Mario Limonciello  2024-09-03  228  	return -EOPNOTSUPP;
7bc1fcd3990182 Perry Yuan         2023-01-31  229  }
7bc1fcd3990182 Perry Yuan         2023-01-31  230  static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
7bc1fcd3990182 Perry Yuan         2023-01-31  231  {
e224a868e488cf Mario Limonciello  2024-09-03  232  	return -EOPNOTSUPP;
7bc1fcd3990182 Perry Yuan         2023-01-31  233  }
c984f5d5d45bd5 Wyes Karny         2023-03-07  234  static inline int cppc_set_auto_sel(int cpu, bool enable)
c984f5d5d45bd5 Wyes Karny         2023-03-07  235  {
e224a868e488cf Mario Limonciello  2024-09-03  236  	return -EOPNOTSUPP;
c984f5d5d45bd5 Wyes Karny         2023-03-07  237  }
c984f5d5d45bd5 Wyes Karny         2023-03-07  238  static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
c984f5d5d45bd5 Wyes Karny         2023-03-07  239  {
e224a868e488cf Mario Limonciello  2024-09-03  240  	return -EOPNOTSUPP;
c984f5d5d45bd5 Wyes Karny         2023-03-07  241  }
cfa6630658f7de Mario Limonciello  2024-09-03 @242  static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
cfa6630658f7de Mario Limonciello  2024-09-03  243  {
cfa6630658f7de Mario Limonciello  2024-09-03  244  	return -ENODEV;
cfa6630658f7de Mario Limonciello  2024-09-03  245  }
402eea79aece78 Mario Limonciello  2024-09-03 @246  static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
402eea79aece78 Mario Limonciello  2024-09-03  247  {
402eea79aece78 Mario Limonciello  2024-09-03  248  	return -EOPNOTSUPP;
402eea79aece78 Mario Limonciello  2024-09-03  249  }
7885bc49834406 Mario Limonciello  2024-09-03  250  static inline int amd_detect_prefcore(bool *detected)
7885bc49834406 Mario Limonciello  2024-09-03  251  {
7885bc49834406 Mario Limonciello  2024-09-03  252  	return -ENODEV;
7885bc49834406 Mario Limonciello  2024-09-03  253  }
8a02d99876362f Rafael J. Wysocki  2021-03-16  254  #endif /* !CONFIG_ACPI_CPPC_LIB */
337aadff8e4567 Ashwin Chaugule    2015-10-02  255  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

