Return-Path: <linux-acpi+bounces-4337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B287BA3A
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Mar 2024 10:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2BBB21832
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Mar 2024 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB666CDA1;
	Thu, 14 Mar 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+lC8+FD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8B4D9F9;
	Thu, 14 Mar 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407907; cv=none; b=pAj2t3nI1A4woVSQO+M0JIEqO/witfkQE26YRkObU7kbCdaGroTyOQGydX6oSY8ZamWWEpYLTj1+E1/WLQvUgM0c5nl0e9qKBQqhFK1QPAKIsDoYYYjX9FdLNfxQ8hpfER4oZOviNZRvQlhUjWY2frOJzj0g8qTvAKFSOlk2OGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407907; c=relaxed/simple;
	bh=sq/yvGM/nsEiRMZE0p7321EHa4f22Vwc25D6DyM9/lw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iBE5PiUNE7N/cXb97nCmmhC/xKrK9/I0NOlkx84c688yZGx0pwDdxi5KsgTQcXvOHBbCQ33GI/SXEON71ShCLn/Xgm2fEyVzlUrytuDnyUjJS7gu3x/haIgKCvpM67Zm7raE667IQSmwjh5p0gj8J31KzM/l3GJABF2SLM0wt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+lC8+FD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710407905; x=1741943905;
  h=date:from:to:cc:subject:message-id;
  bh=sq/yvGM/nsEiRMZE0p7321EHa4f22Vwc25D6DyM9/lw=;
  b=j+lC8+FDQq7Khj6Z6mixPnYr7cvtymlog7NkCfw1BHziag31SAORm7BD
   pAcre3lqhh7iSClvqjMf1TZbi4udBhumnYigUGPzX9lNDljrGfklooEHE
   qDqSA4ylFKZRJ4Fs+NQFqWUAaK2dknp7kFhJ2OVQwg45nyhBXF3zOnNOv
   7+Nq0oubOpurH0heYdpgFLCFKw/gJ5eMaIDpN9LNx12p0MbIjtLALa0EB
   Rqe9wkalirClaF+53lzyeYfpIF+kDQmbP1+joeAhJ6UeWwian9gggkRlA
   g/yKWYTU72OGGG5m1E0WoCcAlHkP45haURja34NKTorSl/X8zlB8gsyUr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5077105"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="5077105"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 02:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="35357882"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 14 Mar 2024 02:18:23 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkhEC-000DHw-2X;
	Thu, 14 Mar 2024 09:18:20 +0000
Date: Thu, 14 Mar 2024 17:17:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 014f1ca82c04a9cf5fce6e8a20d763d4c31532f5
Message-ID: <202403141727.xI7CduVW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 014f1ca82c04a9cf5fce6e8a20d763d4c31532f5  Merge branch 'acpi-misc' into bleeding-edge

elapsed time: 739m

configs tested: 169
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240314   gcc  
arc                   randconfig-002-20240314   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240314   gcc  
arm                   randconfig-002-20240314   gcc  
arm                   randconfig-003-20240314   clang
arm                   randconfig-004-20240314   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240314   gcc  
arm64                 randconfig-002-20240314   gcc  
arm64                 randconfig-003-20240314   clang
arm64                 randconfig-004-20240314   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240314   gcc  
csky                  randconfig-002-20240314   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240314   clang
hexagon               randconfig-002-20240314   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240314   clang
i386         buildonly-randconfig-002-20240314   clang
i386         buildonly-randconfig-003-20240314   gcc  
i386         buildonly-randconfig-004-20240314   gcc  
i386         buildonly-randconfig-005-20240314   gcc  
i386         buildonly-randconfig-006-20240314   clang
i386                                defconfig   clang
i386                  randconfig-001-20240314   gcc  
i386                  randconfig-002-20240314   clang
i386                  randconfig-003-20240314   gcc  
i386                  randconfig-004-20240314   clang
i386                  randconfig-005-20240314   gcc  
i386                  randconfig-006-20240314   gcc  
i386                  randconfig-011-20240314   clang
i386                  randconfig-012-20240314   gcc  
i386                  randconfig-013-20240314   clang
i386                  randconfig-014-20240314   gcc  
i386                  randconfig-015-20240314   clang
i386                  randconfig-016-20240314   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240314   gcc  
loongarch             randconfig-002-20240314   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                      bmips_stb_defconfig   clang
mips                  decstation_64_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240314   gcc  
nios2                 randconfig-002-20240314   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240314   gcc  
parisc                randconfig-002-20240314   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc               randconfig-001-20240314   gcc  
powerpc               randconfig-002-20240314   gcc  
powerpc               randconfig-003-20240314   clang
powerpc64             randconfig-001-20240314   gcc  
powerpc64             randconfig-002-20240314   clang
powerpc64             randconfig-003-20240314   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240314   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240314   clang
s390                  randconfig-002-20240314   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                    randconfig-001-20240314   gcc  
sh                    randconfig-002-20240314   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240314   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240314   clang
x86_64       buildonly-randconfig-002-20240314   clang
x86_64       buildonly-randconfig-003-20240314   clang
x86_64       buildonly-randconfig-004-20240314   gcc  
x86_64       buildonly-randconfig-005-20240314   clang
x86_64       buildonly-randconfig-006-20240314   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240314   gcc  
x86_64                randconfig-002-20240314   gcc  
x86_64                randconfig-003-20240314   clang
x86_64                randconfig-004-20240314   clang
x86_64                randconfig-005-20240314   clang
x86_64                randconfig-006-20240314   clang
x86_64                randconfig-011-20240314   clang
x86_64                randconfig-012-20240314   gcc  
x86_64                randconfig-013-20240314   gcc  
x86_64                randconfig-014-20240314   gcc  
x86_64                randconfig-015-20240314   clang
x86_64                randconfig-016-20240314   gcc  
x86_64                randconfig-071-20240314   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

