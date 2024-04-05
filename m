Return-Path: <linux-acpi+bounces-4665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10871899908
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Apr 2024 11:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278EF1C2140C
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Apr 2024 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73C715FCEC;
	Fri,  5 Apr 2024 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l69FFtXL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261115FCEA;
	Fri,  5 Apr 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308243; cv=none; b=j7MVSegKYh7qiGlwhZX01d0fAzYJxFXjd4S8DHp0JyPCAfPZu21hiUXM6LfcMcOBUtK+B3P5n6ECWlL+QE2+TblM7wvkGWCWoQTxZS0mw10VuhR3QXlTgcbOoQR/YFd5h70QZ6invHd8tCVQkvF6xBcWN4ddAW/DXlFP/YTTPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308243; c=relaxed/simple;
	bh=D8akveyv8EAH6aqRsyNERFGYx6Skd7Zb0+OXU3kvFCM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i+OOJ0n3VoEfRcAMuu24XUNSRJzSBhFJ/+eRbdG2ZP7zli8I1yY0frlXspzGmx4n/7SiNe42ltZquw2b2Pk5wHuU89MjMld1JLkuFDDVCI362jyOBAgc7g/gJMuieRwHT/w4kSBDKaJUgyOSGyxt2JMGoa5T7MajEu8d/E9pl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l69FFtXL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712308242; x=1743844242;
  h=date:from:to:cc:subject:message-id;
  bh=D8akveyv8EAH6aqRsyNERFGYx6Skd7Zb0+OXU3kvFCM=;
  b=l69FFtXLya1Fix0p8RriH0ApZdRFPtsZg277hJgovevSgPrGNlNP2t1A
   /S3MS5NzCYfgfLnSfKKcEyEzetHRWnCPpX6Xw2s6N4zQtYLNZQjLSOfOu
   nMVlQmcXwkjod6zMmEnTl29cCI675VA8nNaJGSNy2opv9XLb1BvRYrrpM
   kFELgv4Z7Cg9U9kMYm+Jl+ndMx9IOQ/MggWAsQKGURYMHOrl8eqKzMtEq
   NWD/Hd20PD66ExsvR+EU+hBiVzIsqRy1S67MZ5GCEmTOsTRmOw+KFWVUt
   5vNBztWNXjIBESitfilfJUiaA7XAo91SBpKsENmypEqUYHN/tePjvhuG+
   w==;
X-CSE-ConnectionGUID: D4B4FCn2TGqADH4jjALrCg==
X-CSE-MsgGUID: ug05L6IkSKKYNqWW8xFjmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7862881"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7862881"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 02:10:40 -0700
X-CSE-ConnectionGUID: 0AeZ+ajdQP+WOBXmTFjj3w==
X-CSE-MsgGUID: BXtnGWJpQ3++XU2Cue5QHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19174626"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Apr 2024 02:10:38 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsfak-00024W-33;
	Fri, 05 Apr 2024 09:10:34 +0000
Date: Fri, 05 Apr 2024 17:10:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 19c31f086fbfc78ea4f695d1d2e666448c35d42f
Message-ID: <202404051718.ClZ30LkL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 19c31f086fbfc78ea4f695d1d2e666448c35d42f  Merge branch 'acpi-scan' into bleeding-edge

elapsed time: 782m

configs tested: 179
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
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240405   gcc  
arc                   randconfig-002-20240405   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20240405   gcc  
arm                   randconfig-002-20240405   clang
arm                   randconfig-003-20240405   gcc  
arm                   randconfig-004-20240405   clang
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240405   gcc  
arm64                 randconfig-002-20240405   gcc  
arm64                 randconfig-003-20240405   gcc  
arm64                 randconfig-004-20240405   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240405   gcc  
csky                  randconfig-002-20240405   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240405   clang
hexagon               randconfig-002-20240405   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240405   gcc  
i386         buildonly-randconfig-002-20240405   gcc  
i386         buildonly-randconfig-003-20240405   clang
i386         buildonly-randconfig-004-20240405   gcc  
i386         buildonly-randconfig-005-20240405   clang
i386         buildonly-randconfig-006-20240405   clang
i386                                defconfig   clang
i386                  randconfig-001-20240405   clang
i386                  randconfig-002-20240405   gcc  
i386                  randconfig-003-20240405   clang
i386                  randconfig-004-20240405   clang
i386                  randconfig-005-20240405   clang
i386                  randconfig-006-20240405   gcc  
i386                  randconfig-011-20240405   clang
i386                  randconfig-012-20240405   gcc  
i386                  randconfig-013-20240405   gcc  
i386                  randconfig-014-20240405   gcc  
i386                  randconfig-015-20240405   gcc  
i386                  randconfig-016-20240405   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240405   gcc  
loongarch             randconfig-002-20240405   gcc  
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
mips                      bmips_stb_defconfig   clang
mips                        omega2p_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240405   gcc  
nios2                 randconfig-002-20240405   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240405   gcc  
parisc                randconfig-002-20240405   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc834x_itx_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc               randconfig-001-20240405   clang
powerpc               randconfig-002-20240405   clang
powerpc               randconfig-003-20240405   clang
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240405   gcc  
powerpc64             randconfig-002-20240405   gcc  
powerpc64             randconfig-003-20240405   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240405   clang
riscv                 randconfig-002-20240405   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240405   clang
s390                  randconfig-002-20240405   gcc  
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240405   gcc  
sh                    randconfig-002-20240405   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240405   gcc  
sparc64               randconfig-002-20240405   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240405   gcc  
um                    randconfig-002-20240405   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240405   clang
x86_64       buildonly-randconfig-002-20240405   clang
x86_64       buildonly-randconfig-003-20240405   gcc  
x86_64       buildonly-randconfig-004-20240405   gcc  
x86_64       buildonly-randconfig-005-20240405   clang
x86_64       buildonly-randconfig-006-20240405   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240405   clang
x86_64                randconfig-002-20240405   clang
x86_64                randconfig-003-20240405   clang
x86_64                randconfig-004-20240405   gcc  
x86_64                randconfig-005-20240405   clang
x86_64                randconfig-006-20240405   gcc  
x86_64                randconfig-011-20240405   clang
x86_64                randconfig-012-20240405   gcc  
x86_64                randconfig-013-20240405   gcc  
x86_64                randconfig-014-20240405   clang
x86_64                randconfig-015-20240405   gcc  
x86_64                randconfig-016-20240405   gcc  
x86_64                randconfig-071-20240405   gcc  
x86_64                randconfig-072-20240405   gcc  
x86_64                randconfig-073-20240405   gcc  
x86_64                randconfig-074-20240405   gcc  
x86_64                randconfig-075-20240405   gcc  
x86_64                randconfig-076-20240405   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240405   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

