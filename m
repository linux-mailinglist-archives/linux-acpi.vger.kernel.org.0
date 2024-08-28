Return-Path: <linux-acpi+bounces-7920-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356B6962307
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FAB284A1D
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7115E5AB;
	Wed, 28 Aug 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlENJn2L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1715A849;
	Wed, 28 Aug 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836193; cv=none; b=h95SsuimP1XRpYG62sEnn5gU4E3ALA4Qo8rNFC3Wt8sYhGkbr8DSxILclXOczaNhC6jQcSjhgwVQzSSJ3oI8tsv0Po+LPCaXsWVnQMo0/GAbJGnUgUWwmNlcFAH5XFmYwIE27CpKXZQ60xQmTOhki2npfubXkyLTZt5ltDYKD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836193; c=relaxed/simple;
	bh=2EC+oPQzFSSuT7cYAzMjwtmQRGQcrLbG+8LOjwHTbGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELFDY0Aqmad1pLRH59HO6Vv8tKhy4tFqQgqYOsIiAKs7/B3R2szcamBNxMJ+25Iah3x0fvB+LE4SyaYuAavpjJlhMUFIi3TIi2yVCo1IUhXOnmCNwVj7/ldIVnfYG2hvn4YllfMXpszt+SyoI+9mCz3qqSaI0pb7dtclCE5edIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlENJn2L; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724836192; x=1756372192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2EC+oPQzFSSuT7cYAzMjwtmQRGQcrLbG+8LOjwHTbGE=;
  b=PlENJn2LDOs7lrcYoqyPLhpTZOKX4lvhf+U+qzILMU8HSF5TC3wxNYtT
   QBwMDGw9bw/u+/62IkiXEbRls6Y9D4VFfehEA+Ba9hCwLI2c3F050FjpM
   TSMcD4wP+pkuNk0w7lA0lhBj75t68N335PDWBQ66QSJNnEAB97Lv1K5uX
   3hxZFsmV7bA583meRA4JvaJOPlzR67w+I7RWlUqfR5YKWfFWTy8II0zMJ
   Ab7sNF9dksXc0u7pgE5xFAIl3PQkJQ6+tHbDHz2ObcIKCP+Z2bTqsz5Cq
   NcLJALRbu+IBknM/Tw25ZqgVUH1pauKA29Pl2t8V/ceu7Y70w0y5ILH2p
   g==;
X-CSE-ConnectionGUID: RMGkT3juRtCfgKokVwku9g==
X-CSE-MsgGUID: R0kC9JtYS+KjXccwd45Kxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23534453"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="23534453"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 02:09:51 -0700
X-CSE-ConnectionGUID: bkTH4lYKRG+sP7JLtfigoQ==
X-CSE-MsgGUID: U9bIU00SReCU4tYxuw8v0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="68044850"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Aug 2024 02:09:48 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjEgU-000KiY-0I;
	Wed, 28 Aug 2024 09:09:46 +0000
Date: Wed, 28 Aug 2024 17:09:30 +0800
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
Subject: Re: [PATCH 2/8] x86/amd: Rename amd_get_highest_perf() to
 amd_get_boost_ratio_numerator()
Message-ID: <202408281637.ssIOSO7H-lkp@intel.com>
References: <20240826211358.2694603-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-3-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge tip/x86/core tip/master linus/master v6.11-rc5 next-20240827]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/x86-amd-Move-amd_get_highest_perf-from-amd-c-to-cppc-c/20240827-051648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240826211358.2694603-3-superm1%40kernel.org
patch subject: [PATCH 2/8] x86/amd: Rename amd_get_highest_perf() to amd_get_boost_ratio_numerator()
config: x86_64-randconfig-074-20240828 (https://download.01.org/0day-ci/archive/20240828/202408281637.ssIOSO7H-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408281637.ssIOSO7H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408281637.ssIOSO7H-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/acpi/cppc.c:133:5: error: redefinition of 'amd_get_boost_ratio_numerator'
     133 | int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/kernel/acpi/cppc.c:7:
   include/acpi/cppc_acpi.h:142:19: note: previous definition of 'amd_get_boost_ratio_numerator' with type 'int(unsigned int,  u64 *)' {aka 'int(unsigned int,  long long unsigned int *)'}
     142 | static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator) { return -ENODEV; }
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/amd_get_boost_ratio_numerator +133 arch/x86/kernel/acpi/cppc.c

   121	
   122	/**
   123	 * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
   124	 * @cpu: CPU to get numerator for.
   125	 * @numerator: Output variable for numerator.
   126	 *
   127	 * Determine the numerator to use for calculating the boost ratio on
   128	 * a CPU. On systems that support preferred cores, this will be a hardcoded
   129	 * value. On other systems this will the highest performance register value.
   130	 *
   131	 * Return: 0 for success, negative error code otherwise.
   132	 */
 > 133	int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

