Return-Path: <linux-acpi+bounces-3250-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7325584B9F2
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE42280D6D
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7F13398B;
	Tue,  6 Feb 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdKqeKuD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE4133292;
	Tue,  6 Feb 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234254; cv=none; b=Gc2cSUoPWznLKQLCYuP0p4FRqed57WgPZ1xHWNHhdbO7Kdv5pnkqeeFmA1u0p9roCp0tY+KDHHF+FU67RT+oKXeEpA0BCOrR4VZ14ozadSqXBOTh+Aw6GcFgJ5Dby4ye5ODYZicjkKtBN32D1HfR0AtiWLtpOJnh3renrhX+/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234254; c=relaxed/simple;
	bh=rvnqUpaeyJmgXPiAr92M6ZRL5cnI/ob6JWStk9a+i1c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hWLL+eF8lXqmUEJQlgN2atwwT67NLLQ/NK+4xHozvMFvu81TaYRfhZGSEix9bzmjGLZryRldVovJpR38nAkeYktEZvpRCFxCnL6tmbh/xy4c5GqKhrgFxoBd0wBVI8fp5YKY+EhKiud1OwPVDOSi9D9rpFymv2efgsLB8avklpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdKqeKuD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707234252; x=1738770252;
  h=date:from:to:cc:subject:message-id;
  bh=rvnqUpaeyJmgXPiAr92M6ZRL5cnI/ob6JWStk9a+i1c=;
  b=RdKqeKuDdOHqnE9cTEhRY0QD8g7J4QbdPgot0+KVkLA65WOZpY8DjU9L
   zbBFyTlIm4Smmmt+LXfXbhpM9fLXyYqkw/5ZxNWV1Ky0+nNe0DFBK6lYG
   AV/xGi7ew5T/Mifl2t2W/Y4bKF/uQGCyJWectpWlCjcEaLS25Bq6z2qBh
   x6cF+MaitHZvHjjukxAC8iwJaz1DStqUkZ6Ji7x3Jo3zXGHGoZBfxqkdu
   i5bczBCgSB64AspcBnbEnY60Va4uXzsk0INKqr0mt+U+tIhv7Nk3YGovP
   J3Cv53jLzVwpX9MzymBRxIuEt4Z0/00WBJAhrB9+/eqvNIGAhJBb31zyA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="660974"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="660974"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:44:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909670563"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909670563"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2024 07:44:09 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXNcF-0001Xe-1k;
	Tue, 06 Feb 2024 15:44:07 +0000
Date: Tue, 06 Feb 2024 23:43:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d9fc9f690238b2b9c78361f1695ebe02921548e5
Message-ID: <202402062307.vTcXfgBY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d9fc9f690238b2b9c78361f1695ebe02921548e5  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 1499m

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
arc                   randconfig-001-20240206   gcc  
arc                   randconfig-002-20240206   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240206   clang
arm                   randconfig-002-20240206   gcc  
arm                   randconfig-003-20240206   gcc  
arm                   randconfig-004-20240206   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240206   gcc  
arm64                 randconfig-002-20240206   clang
arm64                 randconfig-003-20240206   gcc  
arm64                 randconfig-004-20240206   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240206   gcc  
csky                  randconfig-002-20240206   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240206   clang
hexagon               randconfig-002-20240206   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240205   clang
i386         buildonly-randconfig-002-20240205   clang
i386         buildonly-randconfig-003-20240205   clang
i386         buildonly-randconfig-004-20240205   clang
i386         buildonly-randconfig-005-20240205   clang
i386         buildonly-randconfig-006-20240205   clang
i386                                defconfig   clang
i386                  randconfig-001-20240205   clang
i386                  randconfig-002-20240205   clang
i386                  randconfig-003-20240205   clang
i386                  randconfig-004-20240205   gcc  
i386                  randconfig-005-20240205   clang
i386                  randconfig-006-20240205   gcc  
i386                  randconfig-011-20240205   gcc  
i386                  randconfig-012-20240205   clang
i386                  randconfig-013-20240205   gcc  
i386                  randconfig-014-20240205   gcc  
i386                  randconfig-015-20240205   clang
i386                  randconfig-016-20240205   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240206   gcc  
loongarch             randconfig-002-20240206   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240206   gcc  
nios2                 randconfig-002-20240206   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240206   gcc  
parisc                randconfig-002-20240206   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240206   clang
powerpc               randconfig-002-20240206   gcc  
powerpc               randconfig-003-20240206   clang
powerpc                      tqm8xx_defconfig   clang
powerpc                      walnut_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240206   gcc  
powerpc64             randconfig-002-20240206   clang
powerpc64             randconfig-003-20240206   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240206   gcc  
riscv                 randconfig-002-20240206   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240206   clang
s390                  randconfig-002-20240206   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240206   gcc  
sh                    randconfig-002-20240206   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240206   gcc  
sparc64               randconfig-002-20240206   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240206   clang
um                    randconfig-002-20240206   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240206   gcc  
x86_64       buildonly-randconfig-002-20240206   clang
x86_64       buildonly-randconfig-003-20240206   gcc  
x86_64       buildonly-randconfig-004-20240206   gcc  
x86_64       buildonly-randconfig-005-20240206   gcc  
x86_64       buildonly-randconfig-006-20240206   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240206   clang
x86_64                randconfig-002-20240206   clang
x86_64                randconfig-003-20240206   gcc  
x86_64                randconfig-004-20240206   gcc  
x86_64                randconfig-005-20240206   gcc  
x86_64                randconfig-006-20240206   clang
x86_64                randconfig-011-20240206   gcc  
x86_64                randconfig-012-20240206   clang
x86_64                randconfig-013-20240206   gcc  
x86_64                randconfig-014-20240206   clang
x86_64                randconfig-015-20240206   gcc  
x86_64                randconfig-016-20240206   clang
x86_64                randconfig-071-20240206   gcc  
x86_64                randconfig-072-20240206   gcc  
x86_64                randconfig-073-20240206   gcc  
x86_64                randconfig-074-20240206   gcc  
x86_64                randconfig-075-20240206   clang
x86_64                randconfig-076-20240206   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240206   gcc  
xtensa                randconfig-002-20240206   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

