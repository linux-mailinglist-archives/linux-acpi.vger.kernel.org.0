Return-Path: <linux-acpi+bounces-562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF197BF8BE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3461C209F3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCABFBF8
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W96m1l9n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BAC171DD
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 09:43:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952F94;
	Tue, 10 Oct 2023 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696931034; x=1728467034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ABVJ/HsrIXFckFMfaqVuY7HMZK5cmb/9vsBsVL3RHYs=;
  b=W96m1l9n++shi4kt77FVrzChWWCbJlRDax8I1u+xHCEm/m+zzfDn21cu
   P2AE7/tgLK4AGfoV0xX0Lqnzn0iDCMzz+NuUXltV+YuPLGic2yntU8lna
   h0Vd54Xil3X8cZWRxFXsdOVEwdf9dMBf9GDKqCyfWzKTK5bhOy+XOLlDZ
   Rj+GnhzW6I+0+WYK+iBPHTStE09V1URbTgV0ROpr1nncV9wLf3mf/X2sR
   ysGu5gQsBW6giEqy0dY5YmoMVF/OGfgziGNlO2HCUceN32FJpcO4BAkD5
   c4B/uqH7jxUxbsdUNrj/AUZxBijrZVOuPMdc8Jl0hoYACqvBWd7youvbm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="388220620"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="388220620"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 02:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="730020342"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="730020342"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Oct 2023 02:43:32 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qq9H0-0000Es-1F;
	Tue, 10 Oct 2023 09:43:30 +0000
Date: Tue, 10 Oct 2023 17:42:31 +0800
From: kernel test robot <lkp@intel.com>
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org, rui.zhang@intel.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com,
	bbasu@nvidia.com, sumitg@nvidia.com, sanjayc@nvidia.com,
	ksitaraman@nvidia.com, srikars@nvidia.com, jbrasen@nvidia.com
Subject: Re: [Patch v4 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Message-ID: <202310101725.z21V2yNG-lkp@intel.com>
References: <20231009171839.12267-3-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009171839.12267-3-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sumit,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on next-20231010]
[cannot apply to linus/master v6.6-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-thermal-Add-Thermal-fast-Sampling-Period-_TFP-support/20231010-012229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231009171839.12267-3-sumitg%40nvidia.com
patch subject: [Patch v4 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20231010/202310101725.z21V2yNG-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310101725.z21V2yNG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310101725.z21V2yNG-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/sysctl.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: kernel/power/main.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/core.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/platform.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/cpu.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/property.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/cacheinfo.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/power/common.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/input/mouse/synaptics.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here


vim +1546 include/linux/acpi.h

  1541	
  1542	#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
  1543	int acpi_thermal_cpufreq_pctg(void);
  1544	#else
  1545	inline int acpi_thermal_cpufreq_pctg(void)
> 1546	{
  1547		return 0;
  1548	}
  1549	#endif
  1550	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

