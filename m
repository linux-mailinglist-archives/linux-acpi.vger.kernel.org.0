Return-Path: <linux-acpi+bounces-5286-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C87C28ADD38
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Apr 2024 07:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A155B22855
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Apr 2024 05:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5420DE7;
	Tue, 23 Apr 2024 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNuCf0Ox"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181B1F94C;
	Tue, 23 Apr 2024 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851591; cv=none; b=Hid3lv1kEdxzm6ryR8s1n4/aCCUkgIBUwTJt1lWuPLkUB0dpTU0lyhbHLBCxSa+8KR3nToJMtMelOjIuvcPymxmBliq+apb9dD3ySs6ORAMQvXRgQegluupJljqmhzY+hel7do1F8hneCQpDxmOG0nFSTH0U1CGVcEkjITCLVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851591; c=relaxed/simple;
	bh=sGT4L6Z5KhifGcdd65hdpJQQsJN9LKcXPoN9XVvV3RE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pKS5dSI2JvxLbuF9UPz3MP2kaRn0oEw/8gYeFkRfGlKIEM0dfFOgzSfVUuGemhj/9RyCJTG+BsL00a7+1R6I3lLxBoJZlxHJ0/57PHBCWTw+Z794AYLlUOWUuISxgvJbaLSOE99i+b3ROuZ661netOwJ6Ug+2si/zzMEoGOJvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNuCf0Ox; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713851590; x=1745387590;
  h=date:from:to:cc:subject:message-id;
  bh=sGT4L6Z5KhifGcdd65hdpJQQsJN9LKcXPoN9XVvV3RE=;
  b=MNuCf0OxShWpoSgCbNIyBdch+lyscf0D5CfWqcvuJxOH7n1fh+jogsxp
   DPMyFqmMXltQJnCGEfKJ9FvASw2pycKwJK/lJuJ6ghevkXhQ7vI/bDGnc
   ym5Qw/eiwghLp2dNZCRo6HEpmJOmGL3U/BRgU2OlYDASkU+fY2CPNeORs
   nWNV9aUvFKLjsCNJenZ+XeZnVwD4bZ+VG+YQclFvLDlt2SZQ2D20ScaHM
   ym0XHGp8SstHc15955iWdF57szaD2w858FUjAnk4j2tdPt4DoDn7EhZoG
   2tZW1anv2LghPB6xYfzjno7LGxwOOzBtdkvBv0429pV9Luam7yBl2f6jA
   Q==;
X-CSE-ConnectionGUID: FzxBtj1WQyGz3u5rUCBxGg==
X-CSE-MsgGUID: LkVZwUe3SaGJBlESrjkorw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9527321"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9527321"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 22:53:08 -0700
X-CSE-ConnectionGUID: Qf527Mq6QWabJlKk9JT4hg==
X-CSE-MsgGUID: R/l9NACHSz6V9FF4uJEbpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24115848"
Received: from lkp-server01.sh.intel.com (HELO 01437695816f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 22 Apr 2024 22:53:06 -0700
Received: from kbuild by 01437695816f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rz95T-0000W2-1V;
	Tue, 23 Apr 2024 05:53:03 +0000
Date: Tue, 23 Apr 2024 13:52:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 35e04550ea4c787bbc615dc503645ae4458ef708
Message-ID: <202404231340.yjmoCkQL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 35e04550ea4c787bbc615dc503645ae4458ef708  Merge branch 'thermal-core-next' into bleeding-edge

elapsed time: 738m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240423   gcc  
arc                   randconfig-002-20240423   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20240423   clang
arm                   randconfig-002-20240423   clang
arm                   randconfig-003-20240423   clang
arm                   randconfig-004-20240423   gcc  
arm                         s5pv210_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240423   clang
arm64                 randconfig-002-20240423   gcc  
arm64                 randconfig-003-20240423   clang
arm64                 randconfig-004-20240423   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240423   gcc  
csky                  randconfig-002-20240423   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240423   clang
hexagon               randconfig-002-20240423   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240423   clang
i386         buildonly-randconfig-002-20240423   clang
i386         buildonly-randconfig-003-20240423   gcc  
i386         buildonly-randconfig-004-20240423   clang
i386         buildonly-randconfig-005-20240423   clang
i386         buildonly-randconfig-006-20240423   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240423   gcc  
i386                  randconfig-002-20240423   gcc  
i386                  randconfig-003-20240423   clang
i386                  randconfig-004-20240423   gcc  
i386                  randconfig-005-20240423   clang
i386                  randconfig-006-20240423   clang
i386                  randconfig-011-20240423   gcc  
i386                  randconfig-012-20240423   clang
i386                  randconfig-013-20240423   clang
i386                  randconfig-014-20240423   gcc  
i386                  randconfig-015-20240423   gcc  
i386                  randconfig-016-20240423   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240423   gcc  
loongarch             randconfig-002-20240423   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240423   gcc  
nios2                 randconfig-002-20240423   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240423   gcc  
parisc                randconfig-002-20240423   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      ppc44x_defconfig   clang
powerpc               randconfig-001-20240423   gcc  
powerpc               randconfig-002-20240423   gcc  
powerpc               randconfig-003-20240423   clang
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240423   gcc  
powerpc64             randconfig-003-20240423   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240423   clang
x86_64       buildonly-randconfig-002-20240423   clang
x86_64       buildonly-randconfig-003-20240423   gcc  
x86_64       buildonly-randconfig-004-20240423   gcc  
x86_64       buildonly-randconfig-005-20240423   clang
x86_64       buildonly-randconfig-006-20240423   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240423   clang
x86_64                randconfig-002-20240423   gcc  
x86_64                randconfig-003-20240423   gcc  
x86_64                randconfig-004-20240423   gcc  
x86_64                randconfig-005-20240423   gcc  
x86_64                randconfig-006-20240423   gcc  
x86_64                randconfig-011-20240423   gcc  
x86_64                randconfig-012-20240423   gcc  
x86_64                randconfig-013-20240423   clang
x86_64                randconfig-014-20240423   clang
x86_64                randconfig-015-20240423   clang
x86_64                randconfig-016-20240423   gcc  
x86_64                randconfig-071-20240423   clang
x86_64                randconfig-072-20240423   clang
x86_64                randconfig-073-20240423   clang
x86_64                randconfig-074-20240423   gcc  
x86_64                randconfig-075-20240423   gcc  
x86_64                randconfig-076-20240423   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

