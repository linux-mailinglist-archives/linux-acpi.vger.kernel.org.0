Return-Path: <linux-acpi+bounces-5132-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAE18A90FC
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Apr 2024 04:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080BC1F21B4D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Apr 2024 02:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024AA3A1D3;
	Thu, 18 Apr 2024 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOtVTtmu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412939FD4;
	Thu, 18 Apr 2024 02:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406199; cv=none; b=UiHQQ44UsxrkVXU9SEVyrtWqBDQ+m34M0jEmntmpbz/zMqkmxdk0mKV3E12sNxjwZ0qaCUiJkmSzlr9mOu5aqLZF2/X7i+sscBKDoIfc6XD5jyKU7kGfULe8vGek2K8BdHdEyIQ905FXFr8G0V+1MZtS8ufrfRx0o+wdkIybO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406199; c=relaxed/simple;
	bh=LnFKJYdVgGel22IHnzhi3QpN4JoMDAfM5pczqyxZ6YU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ejywn3++wGD3p+DOr8w/Z4WwWEXQgqAqkkizt+Xryjj8WzJD+H75Ld3ui8zl7WFxiQUrBARLkAzJORZci/c/Yd3wVgE2XEditzQmtB7pKb/1wK2cneIjJ0c/Jr7kEw2oMKNOU8gPTrzU+fV8rE+rqXeA15kMJzASq1JpeeD3JJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOtVTtmu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713406198; x=1744942198;
  h=date:from:to:cc:subject:message-id;
  bh=LnFKJYdVgGel22IHnzhi3QpN4JoMDAfM5pczqyxZ6YU=;
  b=BOtVTtmulUGrUameo/g4W3M8JQ++OUANPDE9koOfprkPVGRVnbMAx3OY
   Lo175rAzS4BK/nceLVCUIvfhRSl2rzDRmf7w8Bd+4mU6g4oUDPsn2bUZu
   u26/OxrjUi+0UnSJwEJHkvHoel2i/TJzc68AJY+cGyg90LJ52QUmZg2n3
   6JnovLtPoWKw9oWotSRUkNUjv96/CcfYxNqqikA2yn/Qb3+7iPh5Kpwzi
   rN4ROhBC8qDrpxuthiRFLWqqG2aoguUOFuN0QXl/81yPgf1sGsFEg+5Dk
   PDkH5UJKdNAHIF1pWVv+QXJCHa0b9YgXhoX2jVBplCw0N5Ju16Or1jcO6
   w==;
X-CSE-ConnectionGUID: dhPQpjS5THSjNfOu1JdDdQ==
X-CSE-MsgGUID: ewUrwrKHTOu81qkw5PBkWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8765136"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="8765136"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 19:09:57 -0700
X-CSE-ConnectionGUID: USqCVvQNSUuCqhhfqpo3vw==
X-CSE-MsgGUID: QK4kqVLfQyeeH2Xe0zVFUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="54025537"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 17 Apr 2024 19:09:55 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxHDk-0007BO-3A;
	Thu, 18 Apr 2024 02:09:52 +0000
Date: Thu, 18 Apr 2024 10:09:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c16b1bbc2b7459976a5ddf9075c8b9e58296b3c7
Message-ID: <202404181049.1PA6Q33A-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c16b1bbc2b7459976a5ddf9075c8b9e58296b3c7  Merge branch 'pm-powercap' into bleeding-edge

elapsed time: 729m

configs tested: 136
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
arc                   randconfig-001-20240418   gcc  
arc                   randconfig-002-20240418   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240418   gcc  
arm                   randconfig-002-20240418   gcc  
arm                   randconfig-003-20240418   gcc  
arm                   randconfig-004-20240418   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240418   clang
arm64                 randconfig-002-20240418   gcc  
arm64                 randconfig-003-20240418   gcc  
arm64                 randconfig-004-20240418   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240418   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240417   clang
i386         buildonly-randconfig-002-20240417   gcc  
i386         buildonly-randconfig-003-20240417   clang
i386         buildonly-randconfig-004-20240417   gcc  
i386         buildonly-randconfig-005-20240417   gcc  
i386         buildonly-randconfig-006-20240417   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240417   clang
i386                  randconfig-002-20240417   gcc  
i386                  randconfig-003-20240417   gcc  
i386                  randconfig-004-20240417   clang
i386                  randconfig-005-20240417   clang
i386                  randconfig-006-20240417   clang
i386                  randconfig-011-20240417   gcc  
i386                  randconfig-012-20240417   gcc  
i386                  randconfig-013-20240417   clang
i386                  randconfig-014-20240417   gcc  
i386                  randconfig-015-20240417   gcc  
i386                  randconfig-016-20240417   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
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
x86_64       buildonly-randconfig-001-20240418   clang
x86_64       buildonly-randconfig-002-20240418   clang
x86_64       buildonly-randconfig-003-20240418   clang
x86_64       buildonly-randconfig-004-20240418   clang
x86_64       buildonly-randconfig-005-20240418   gcc  
x86_64       buildonly-randconfig-006-20240418   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240418   gcc  
x86_64                randconfig-002-20240418   clang
x86_64                randconfig-003-20240418   gcc  
x86_64                randconfig-004-20240418   clang
x86_64                randconfig-005-20240418   gcc  
x86_64                randconfig-006-20240418   gcc  
x86_64                randconfig-011-20240418   clang
x86_64                randconfig-012-20240418   gcc  
x86_64                randconfig-013-20240418   clang
x86_64                randconfig-014-20240418   gcc  
x86_64                randconfig-015-20240418   gcc  
x86_64                randconfig-016-20240418   gcc  
x86_64                randconfig-071-20240418   gcc  
x86_64                randconfig-072-20240418   clang
x86_64                randconfig-073-20240418   clang
x86_64                randconfig-074-20240418   gcc  
x86_64                randconfig-075-20240418   gcc  
x86_64                randconfig-076-20240418   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

