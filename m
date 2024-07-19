Return-Path: <linux-acpi+bounces-6959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD77937298
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jul 2024 04:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915B11C20F5D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jul 2024 02:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31EF1863E;
	Fri, 19 Jul 2024 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrgqXVmo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF85C144;
	Fri, 19 Jul 2024 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721357225; cv=none; b=LrKI7ro6gcWvAP4Sf3LWMqFK8ZYt8tgbqay9xV14/3kghnq+NHENiXZkO86twrnhAxFRs76XLHfDbu3oAohfSsSbfwWCUbYY1TZtoja8GaA20OpOCVHVPO7vkCLW03ijDflXu9J+yhOSy+d8w4uAUJB1w3kuPRi+5MBIM8jhmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721357225; c=relaxed/simple;
	bh=pw4sl6hud00QHQmqaszBEUW5UJlWWjNWPMfq+LF8kpA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F/a2q5YktGnlXB8SsqvHK8Ngb02f0XkzhGGa7FZEXZwkxbKpwibzfAzd4eyYQLGAG/unHwDh46M5iDK9uI2tO85EfCdPSuvnhCfb9HTUIl+mQl0EKpfgugxaU3+lCXco6gPCT9cRztLRLo0vS6SLBf2H6jnCoLFmu0t9n5XoPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrgqXVmo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721357224; x=1752893224;
  h=date:from:to:cc:subject:message-id;
  bh=pw4sl6hud00QHQmqaszBEUW5UJlWWjNWPMfq+LF8kpA=;
  b=OrgqXVmo+Op4aHhaP1iDLmn2W22JITYrAdlMNApgJlGv0pRCK6AhCKwp
   DFvIrUPwxMgbwhUiVB+jFEwCjGuiK2BzWP9VPPWPWwiBtJPns8Skd0vjb
   XZHK4tGYmisaUYZQfrUekIbyqKmFgVhUckTt3QeJyGkZgPfXhURaf1T3G
   b5HWnpwDEHEvXCBTwQCU59ttDbWAmuLYb/o74Av66W5qMjuR9/dIpWBX0
   i8rO/XOjv+sh3tfmHFfDrUtUFZ4OKSHWc4Hqn168r7SuM3lNtruxjlW8q
   YKOm+YsvIwp/osBQWTvEp6nD/bgKhcMlSpEtOyLBeiuzAKVhXPtN2ZAaY
   w==;
X-CSE-ConnectionGUID: Yvn/RtC0SluBSXbN/6F59Q==
X-CSE-MsgGUID: 2ln3pS9AQr6dITkvmpJuoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="30375825"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="30375825"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 19:47:03 -0700
X-CSE-ConnectionGUID: iT4aUr50SFC37gTpl1B+wA==
X-CSE-MsgGUID: o0mxam5tTDmsSKiGfh9m1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="50843347"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Jul 2024 19:47:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUde7-000hlu-2l;
	Fri, 19 Jul 2024 02:46:59 +0000
Date: Fri, 19 Jul 2024 10:46:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 41f11a809ce70487211305636f9fd1e00ddec1a9
Message-ID: <202407191052.lgjB8xrh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 41f11a809ce70487211305636f9fd1e00ddec1a9  Merge branch 'thermal-fixes' into linux-next

elapsed time: 893m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              alldefconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240718   gcc-13.2.0
arc                   randconfig-002-20240718   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240718   clang-19
arm                   randconfig-002-20240718   gcc-14.1.0
arm                   randconfig-003-20240718   clang-19
arm                   randconfig-004-20240718   gcc-14.1.0
arm                         s3c6400_defconfig   gcc-14.1.0
arm                           sama5_defconfig   gcc-13.2.0
arm                         socfpga_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240718   clang-15
arm64                 randconfig-002-20240718   clang-19
arm64                 randconfig-003-20240718   gcc-14.1.0
arm64                 randconfig-004-20240718   clang-19
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240718   gcc-14.1.0
csky                  randconfig-002-20240718   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240718   clang-19
hexagon               randconfig-002-20240718   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240718   gcc-11
i386         buildonly-randconfig-001-20240719   clang-18
i386         buildonly-randconfig-002-20240718   gcc-7
i386         buildonly-randconfig-002-20240719   clang-18
i386         buildonly-randconfig-003-20240718   gcc-13
i386         buildonly-randconfig-003-20240719   clang-18
i386         buildonly-randconfig-004-20240718   clang-18
i386         buildonly-randconfig-004-20240719   clang-18
i386         buildonly-randconfig-005-20240718   gcc-9
i386         buildonly-randconfig-005-20240719   clang-18
i386         buildonly-randconfig-006-20240718   gcc-13
i386         buildonly-randconfig-006-20240719   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240718   gcc-13
i386                  randconfig-001-20240719   clang-18
i386                  randconfig-002-20240718   gcc-13
i386                  randconfig-002-20240719   clang-18
i386                  randconfig-003-20240718   clang-18
i386                  randconfig-003-20240719   clang-18
i386                  randconfig-004-20240718   clang-18
i386                  randconfig-004-20240719   clang-18
i386                  randconfig-005-20240718   clang-18
i386                  randconfig-005-20240719   clang-18
i386                  randconfig-006-20240718   clang-18
i386                  randconfig-006-20240719   clang-18
i386                  randconfig-011-20240718   gcc-13
i386                  randconfig-011-20240719   clang-18
i386                  randconfig-012-20240718   gcc-13
i386                  randconfig-012-20240719   clang-18
i386                  randconfig-013-20240718   gcc-10
i386                  randconfig-013-20240719   clang-18
i386                  randconfig-014-20240718   clang-18
i386                  randconfig-014-20240719   clang-18
i386                  randconfig-015-20240718   clang-18
i386                  randconfig-015-20240719   clang-18
i386                  randconfig-016-20240718   gcc-13
i386                  randconfig-016-20240719   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240718   gcc-14.1.0
loongarch             randconfig-002-20240718   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5272c3_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-14.1.0
mips                         cobalt_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   clang-19
mips                   sb1250_swarm_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240718   gcc-14.1.0
nios2                 randconfig-002-20240718   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-32bit_defconfig   gcc-14.1.0
parisc                randconfig-001-20240718   gcc-14.1.0
parisc                randconfig-002-20240718   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                    amigaone_defconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   gcc-13.2.0
powerpc                    gamecube_defconfig   clang-19
powerpc                 mpc837x_rdb_defconfig   gcc-14.1.0
powerpc                      ppc64e_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240718   clang-17
powerpc               randconfig-002-20240718   clang-19
powerpc               randconfig-003-20240718   gcc-14.1.0
powerpc                     tqm8555_defconfig   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          r7785rp_defconfig   gcc-14.1.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sh                        sh7763rdp_defconfig   gcc-13.2.0
sh                   sh7770_generic_defconfig   gcc-14.1.0
sh                             shx3_defconfig   gcc-14.1.0
sh                              ul2_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240719   gcc-13
x86_64       buildonly-randconfig-002-20240719   clang-18
x86_64       buildonly-randconfig-003-20240719   gcc-10
x86_64       buildonly-randconfig-004-20240719   gcc-13
x86_64       buildonly-randconfig-005-20240719   gcc-12
x86_64       buildonly-randconfig-006-20240719   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240719   gcc-13
x86_64                randconfig-002-20240719   clang-18
x86_64                randconfig-003-20240719   gcc-13
x86_64                randconfig-004-20240719   gcc-7
x86_64                randconfig-005-20240719   gcc-7
x86_64                randconfig-006-20240719   clang-18
x86_64                randconfig-011-20240719   gcc-13
x86_64                randconfig-012-20240719   gcc-13
x86_64                randconfig-013-20240719   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

