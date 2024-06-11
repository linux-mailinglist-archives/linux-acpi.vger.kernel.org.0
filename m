Return-Path: <linux-acpi+bounces-6294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C68902F62
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 05:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3198428340B
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 03:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D317115B0E2;
	Tue, 11 Jun 2024 03:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUElb3E1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99D1E488;
	Tue, 11 Jun 2024 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718078171; cv=none; b=W9wijDH/8tDcTlg+kV30lSY5if5A8qu9EQLJpoOKkBRq34Y9QLlDD8i/moZEpVrka3W26pxEfTNuFEwCiw9hK55XfQ6/RlwYpkH9bQfHIKCZuaCxW/bUmLMiFiWTSpYcBu4FaiJJhRCbkw/cUZxHye84YUaT3vsaadOm2Nxr1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718078171; c=relaxed/simple;
	bh=LxA0+pauqoBHVNE9sufk+Q9oMMovE0B/erEz+SL0Yw4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zsz8Uk6H4tW0sdqWg2WlHAD33GweAfnbFvW4Q9QQwT0etAZeT1UMYP7nfyg97mVle8rIPQSoFnjHH0tyDWMZb8sv6JyJZONXXpw3paUjWRltjFjznrmPigNjnlcvmrHicdSrLOgKdT2lH6MR00Om0DKS8gZT4X+uVKDbKQLHlrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUElb3E1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718078170; x=1749614170;
  h=date:from:to:cc:subject:message-id;
  bh=LxA0+pauqoBHVNE9sufk+Q9oMMovE0B/erEz+SL0Yw4=;
  b=UUElb3E11Ig0tz/83jYvh1khmp88jOxdJqO1UtPKsBVV8RcJkOCe+7A0
   O1G8BSnWDuP7A9ql8kuUgC2/+0ZmeyA+M4okbXpfvaKBiUYSJbg55bITU
   /ct5G5ogCrcKMNEhvfw/uZyaUuUN/rltn90cPLrZzMZvz0th6ocLIdzjG
   fnNopUdgNC7TFtZmT654WjDja0LzjUhn3SU1BAASA5T0qBXm37gQXcYDw
   VIM8Jo2yOsiKvCd4W8Moy/Fga9UXiS2O+byHKe9ZdQVP1rdR3PWhk4cD4
   WCQbzhyUXqieGDu7E+wjyEwMHTXA6ApuSzJREaqhFV1S825auLRFRwR1t
   w==;
X-CSE-ConnectionGUID: IegiUIOwQQKhwJNFG1r8tw==
X-CSE-MsgGUID: pfLEmY4NSUqH68uW5ZQDmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25884929"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="25884929"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 20:56:09 -0700
X-CSE-ConnectionGUID: Uivkv5j0QQSFB+w7kl6KtQ==
X-CSE-MsgGUID: KHwuUmL5TemZJqIpAi9OGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39129911"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Jun 2024 20:56:05 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGsc6-0002mh-1u;
	Tue, 11 Jun 2024 03:56:02 +0000
Date: Tue, 11 Jun 2024 11:55:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 832acfc9b480f57d04215f536d82e268c51dfd88
Message-ID: <202406111140.DNYwKhaR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 832acfc9b480f57d04215f536d82e268c51dfd88  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 891m

configs tested: 170
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
arc                   randconfig-001-20240611   gcc  
arc                   randconfig-002-20240611   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   clang
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                         lpc18xx_defconfig   clang
arm                          pxa168_defconfig   clang
arm                          pxa3xx_defconfig   clang
arm                   randconfig-001-20240611   gcc  
arm                   randconfig-002-20240611   clang
arm                   randconfig-003-20240611   clang
arm                   randconfig-004-20240611   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240611   clang
arm64                 randconfig-002-20240611   clang
arm64                 randconfig-003-20240611   clang
arm64                 randconfig-004-20240611   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240611   gcc  
csky                  randconfig-002-20240611   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240611   clang
hexagon               randconfig-002-20240611   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240610   clang
i386         buildonly-randconfig-002-20240610   gcc  
i386         buildonly-randconfig-003-20240610   gcc  
i386         buildonly-randconfig-004-20240610   clang
i386         buildonly-randconfig-005-20240610   gcc  
i386         buildonly-randconfig-006-20240610   clang
i386                                defconfig   clang
i386                  randconfig-001-20240610   gcc  
i386                  randconfig-002-20240610   gcc  
i386                  randconfig-003-20240610   gcc  
i386                  randconfig-004-20240610   gcc  
i386                  randconfig-005-20240610   clang
i386                  randconfig-006-20240610   gcc  
i386                  randconfig-011-20240610   clang
i386                  randconfig-012-20240610   clang
i386                  randconfig-013-20240610   clang
i386                  randconfig-014-20240610   clang
i386                  randconfig-015-20240610   clang
i386                  randconfig-016-20240610   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240611   gcc  
loongarch             randconfig-002-20240611   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           jazz_defconfig   clang
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240611   gcc  
nios2                 randconfig-002-20240611   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240611   gcc  
parisc                randconfig-002-20240611   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                   motionpro_defconfig   clang
powerpc               randconfig-001-20240611   gcc  
powerpc               randconfig-002-20240611   clang
powerpc               randconfig-003-20240611   clang
powerpc64                        alldefconfig   clang
powerpc64             randconfig-001-20240611   gcc  
powerpc64             randconfig-002-20240611   clang
powerpc64             randconfig-003-20240611   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240611   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240611   gcc  
s390                  randconfig-002-20240611   gcc  
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240611   gcc  
x86_64       buildonly-randconfig-002-20240611   gcc  
x86_64       buildonly-randconfig-003-20240611   gcc  
x86_64       buildonly-randconfig-004-20240611   clang
x86_64       buildonly-randconfig-005-20240611   gcc  
x86_64       buildonly-randconfig-006-20240611   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240611   clang
x86_64                randconfig-002-20240611   gcc  
x86_64                randconfig-003-20240611   gcc  
x86_64                randconfig-004-20240611   clang
x86_64                randconfig-005-20240611   gcc  
x86_64                randconfig-006-20240611   clang
x86_64                randconfig-011-20240611   clang
x86_64                randconfig-012-20240611   gcc  
x86_64                randconfig-013-20240611   clang
x86_64                randconfig-014-20240611   clang
x86_64                randconfig-015-20240611   clang
x86_64                randconfig-016-20240611   gcc  
x86_64                randconfig-071-20240611   clang
x86_64                randconfig-072-20240611   gcc  
x86_64                randconfig-073-20240611   clang
x86_64                randconfig-074-20240611   gcc  
x86_64                randconfig-075-20240611   gcc  
x86_64                randconfig-076-20240611   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

