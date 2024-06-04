Return-Path: <linux-acpi+bounces-6157-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C09158FAAB7
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDE01F22B91
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 06:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F80D13D8B5;
	Tue,  4 Jun 2024 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1LGcJSQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12E65F;
	Tue,  4 Jun 2024 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482453; cv=none; b=GJGyHGn/QLyJXSx3B5VIRoUcplBmdeeF4HQMgSfvaE+thBmtRHK/Gwa6L2mcY81WKjMvzViDwS60ounxt0NrSRr0g2ppMcc/eF3DAV+o6ALhqJlwEAuoICyjj2K4SuA9fYVh37AuVy3LjcutUPP+Mxf1L43A14XvNwChVWYWUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482453; c=relaxed/simple;
	bh=X4u0YpDyGN4nCMNs7fkbt4yVU2N8nuR/5MvPUtHU5IQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mdgnj8vfMUlqhyZC+VUbjpBmR1yFq9rGcdKI+BJxzSSRbzy8aY5ZfVkUSL8zUdWG2PItnRPk03YMg1H115tkix5qnKvPShKjvDdr3Y2O6VfJN4JxODsVvVdJ6N7wOcge0f16Juk8oCy8wRb6zekV5y0bMg+lIV7p8kwT61TaWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1LGcJSQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717482451; x=1749018451;
  h=date:from:to:cc:subject:message-id;
  bh=X4u0YpDyGN4nCMNs7fkbt4yVU2N8nuR/5MvPUtHU5IQ=;
  b=e1LGcJSQuUuVKqN2zkgNZexp0HNBSCiva1cLp0hGk7/nbmgx9sGu/UOV
   W0iBpTG+dJIkg9qWBNGUQEdhF+aDWglZLjWnuaPwodqHo3+B0TlSGSh2H
   W42faUQ1Q1MtxN0pdbsizS/MyRdTLoBNEfqJexxO3DfS6WZVynu44vr0v
   90ReHEh9n/+THT5MnNvOsvGBhGvUF/cF1ttUShQYIjwpzuqQ9iiCfaGmY
   1iehlpdSM2AaedqtQ/xVzer74BFjCZWhkFz8il1A6oJU14t/8JCOck8RF
   d1uXMlQY1uqhjIOqLE/TkcArBaVU2NSMkz5lHpJA4NtuRrBhvrjoK5Kt4
   g==;
X-CSE-ConnectionGUID: HVMEMDe1S16cdcbQYz3k1Q==
X-CSE-MsgGUID: iwLzrBUGSvSwpYQvGNGhtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="36524585"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="36524585"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 23:27:30 -0700
X-CSE-ConnectionGUID: JLH9DIOFThm6mnU1Wi7R8w==
X-CSE-MsgGUID: 6DCSTeSMRvyJUgswQBM05g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37761601"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2024 23:27:28 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sENdl-000MeV-2v;
	Tue, 04 Jun 2024 06:27:25 +0000
Date: Tue, 04 Jun 2024 14:26:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bee90ea64016cea44f68649393bfe8e8c0c7fb0a
Message-ID: <202406041430.r5WLYa8l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bee90ea64016cea44f68649393bfe8e8c0c7fb0a  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 787m

configs tested: 172
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
arc                   randconfig-001-20240604   gcc  
arc                   randconfig-002-20240604   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                   randconfig-001-20240604   clang
arm                   randconfig-002-20240604   gcc  
arm                   randconfig-003-20240604   clang
arm                   randconfig-004-20240604   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240604   clang
arm64                 randconfig-002-20240604   gcc  
arm64                 randconfig-003-20240604   gcc  
arm64                 randconfig-004-20240604   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240604   gcc  
csky                  randconfig-002-20240604   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240604   clang
hexagon               randconfig-002-20240604   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240604   gcc  
i386         buildonly-randconfig-002-20240604   clang
i386         buildonly-randconfig-003-20240604   clang
i386         buildonly-randconfig-004-20240604   gcc  
i386         buildonly-randconfig-005-20240604   clang
i386         buildonly-randconfig-006-20240604   clang
i386                                defconfig   clang
i386                  randconfig-001-20240604   clang
i386                  randconfig-002-20240604   clang
i386                  randconfig-003-20240604   clang
i386                  randconfig-004-20240604   clang
i386                  randconfig-005-20240604   gcc  
i386                  randconfig-006-20240604   gcc  
i386                  randconfig-011-20240604   clang
i386                  randconfig-012-20240604   gcc  
i386                  randconfig-013-20240604   gcc  
i386                  randconfig-014-20240604   clang
i386                  randconfig-015-20240604   clang
i386                  randconfig-016-20240604   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240604   gcc  
loongarch             randconfig-002-20240604   gcc  
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
mips                          ath79_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                        omega2p_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240604   gcc  
nios2                 randconfig-002-20240604   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240604   gcc  
parisc                randconfig-002-20240604   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240604   gcc  
powerpc               randconfig-002-20240604   gcc  
powerpc               randconfig-003-20240604   gcc  
powerpc64             randconfig-001-20240604   gcc  
powerpc64             randconfig-002-20240604   gcc  
powerpc64             randconfig-003-20240604   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240604   clang
riscv                 randconfig-002-20240604   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240604   clang
s390                  randconfig-002-20240604   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240604   gcc  
sh                    randconfig-002-20240604   gcc  
sh                          rsk7201_defconfig   gcc  
sh                              ul2_defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240604   clang
x86_64       buildonly-randconfig-002-20240604   clang
x86_64       buildonly-randconfig-003-20240604   gcc  
x86_64       buildonly-randconfig-004-20240604   clang
x86_64       buildonly-randconfig-005-20240604   gcc  
x86_64       buildonly-randconfig-006-20240604   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240604   clang
x86_64                randconfig-002-20240604   gcc  
x86_64                randconfig-003-20240604   gcc  
x86_64                randconfig-004-20240604   gcc  
x86_64                randconfig-005-20240604   gcc  
x86_64                randconfig-006-20240604   gcc  
x86_64                randconfig-011-20240604   clang
x86_64                randconfig-012-20240604   clang
x86_64                randconfig-013-20240604   clang
x86_64                randconfig-014-20240604   clang
x86_64                randconfig-015-20240604   clang
x86_64                randconfig-016-20240604   clang
x86_64                randconfig-071-20240604   clang
x86_64                randconfig-072-20240604   gcc  
x86_64                randconfig-073-20240604   gcc  
x86_64                randconfig-074-20240604   clang
x86_64                randconfig-075-20240604   clang
x86_64                randconfig-076-20240604   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

