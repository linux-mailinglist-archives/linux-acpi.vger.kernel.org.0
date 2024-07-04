Return-Path: <linux-acpi+bounces-6761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CAD926CCD
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 02:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94F2B22CE5
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 00:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758E23BB;
	Thu,  4 Jul 2024 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLOAvsQi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9520DDA8;
	Thu,  4 Jul 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720054183; cv=none; b=pOCKuUZyNltogrCC9F10rXN6T8djS84FD2TugdkwRQa2XqKFrsnFC57pk+HC9eNzveqh6vE4H3JWu+fy0ZRQf310bMZ/by6ziFcnjvJWadZIokkdxm8Q1p5GV5roayBsdoc2js9bMPVGTk7WTHVqKRlOqY8PvIDqKLPajZsdUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720054183; c=relaxed/simple;
	bh=NVxE39N0+4FOUx97XPpDZQElkyLHMg5X2JBskG87SM8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FzQT6gyJdEIBZANCEDo56QoIg1LPnl0Iem1Je2t6XHuKUcuFG8KAMTDj8lhUM2tcj23+lGuqUS56gx+aVRGlPUP8ej9B6z5TgQU8B6fxZXAGJsXwA0dREBo+DUjEVpextXOm6JaxelC3xZJj/r9ykFTh8HrJpNJVtwVl+4rvJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLOAvsQi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720054182; x=1751590182;
  h=date:from:to:cc:subject:message-id;
  bh=NVxE39N0+4FOUx97XPpDZQElkyLHMg5X2JBskG87SM8=;
  b=mLOAvsQi/WIG+FteEcbIZnm34hx7IrhJBL/aLLYh0/Q7fuRoABqlCsbY
   MMdvT1OELbGRtihYkLUJ26lzR0MzlRc6HTHLLFe52ybvGEJLE4j/0CJjM
   tpHfWnuOSLw18eNBUQcXAOWiadzVWfLXhX3LrpjD33pgWQHAUDDvI+nTJ
   R/Q0jtPSysL1TvkmglZztA1wUWq7tKEOMOMHQkFNkeHygPggUg/tbQRP2
   o2/NgTqWSJWGHfiMzDuSRrkv8OghFOYvCNDXGgwtGMwigvbYTmDQH3mwG
   R74ei0hZLyu+vuF1ag12M9eqPF1A4P7mO9HuVgp4jb7uFMHWFvSSySGNu
   A==;
X-CSE-ConnectionGUID: C4wH8VTNSY2SAor52Gmpdw==
X-CSE-MsgGUID: va5r5RopT76Ae9uCbCzbXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="21119680"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="21119680"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:49:42 -0700
X-CSE-ConnectionGUID: T4no1clUTVKpYsxxIJn2XA==
X-CSE-MsgGUID: My1BkSLBQjmHHlBmDbAtoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46366604"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Jul 2024 17:49:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPAfJ-000QNB-1x;
	Thu, 04 Jul 2024 00:49:37 +0000
Date: Thu, 04 Jul 2024 08:49:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 afefac1395033609973da997224eceaece6dadf5
Message-ID: <202407040822.lxtNoC1y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: afefac1395033609973da997224eceaece6dadf5  Merge branch 'thermal-core' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407032000.Lvc01b58-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/thermal/uniphier_thermal.c:269:13: warning: unused variable 'i' [-Wunused-variable]

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- alpha-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- i386-buildonly-randconfig-002-20240703
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- i386-buildonly-randconfig-005-20240704
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- loongarch-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- m68k-allmodconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- m68k-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- mips-allmodconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- mips-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- parisc-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- powerpc-allmodconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- powerpc-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- riscv-allmodconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- riscv-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- s390-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- sh-allmodconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- sparc-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- x86_64-allmodconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
|-- x86_64-allyesconfig
|   `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i
`-- xtensa-randconfig-001-20240704
    `-- drivers-thermal-uniphier_thermal.c:warning:unused-variable-i

elapsed time: 1716m

configs tested: 103
configs skipped: 0

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240704   gcc-13.2.0
arc                   randconfig-002-20240704   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                             mxs_defconfig   clang-19
arm                         orion5x_defconfig   clang-19
arm                          pxa168_defconfig   clang-19
arm                   randconfig-001-20240704   gcc-13.2.0
arm                   randconfig-002-20240704   gcc-13.2.0
arm                   randconfig-003-20240704   clang-19
arm                   randconfig-004-20240704   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240704   clang-19
arm64                 randconfig-002-20240704   gcc-13.2.0
arm64                 randconfig-003-20240704   clang-19
arm64                 randconfig-004-20240704   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240704   gcc-13.2.0
csky                  randconfig-002-20240704   gcc-13.2.0
hexagon                          alldefconfig   clang-15
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240704   clang-19
hexagon               randconfig-002-20240704   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386         buildonly-randconfig-001-20240703   clang-18
i386         buildonly-randconfig-002-20240703   gcc-13
i386         buildonly-randconfig-003-20240703   gcc-13
i386         buildonly-randconfig-004-20240703   gcc-13
i386         buildonly-randconfig-005-20240703   clang-18
i386         buildonly-randconfig-006-20240703   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240703   gcc-13
i386                  randconfig-002-20240703   clang-18
i386                  randconfig-003-20240703   gcc-13
i386                  randconfig-004-20240703   gcc-11
i386                  randconfig-005-20240703   clang-18
i386                  randconfig-006-20240703   gcc-7
i386                  randconfig-011-20240703   gcc-13
i386                  randconfig-012-20240703   gcc-13
i386                  randconfig-013-20240703   gcc-13
i386                  randconfig-014-20240703   gcc-13
i386                  randconfig-015-20240703   gcc-13
i386                  randconfig-016-20240703   clang-18
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240704   gcc-13.2.0
loongarch             randconfig-002-20240704   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240704   gcc-13.2.0
nios2                 randconfig-002-20240704   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                randconfig-001-20240704   gcc-13.2.0
parisc                randconfig-002-20240704   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240704   gcc-13.2.0
powerpc               randconfig-002-20240704   gcc-13.2.0
powerpc               randconfig-003-20240704   clang-19
powerpc64             randconfig-001-20240704   gcc-13.2.0
powerpc64             randconfig-002-20240704   gcc-13.2.0
powerpc64             randconfig-003-20240704   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                 randconfig-001-20240704   clang-19
riscv                 randconfig-002-20240704   clang-16
s390                              allnoconfig   clang-19
s390                  randconfig-001-20240704   clang-19
s390                  randconfig-002-20240704   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                    randconfig-001-20240704   gcc-13.2.0
sh                    randconfig-002-20240704   gcc-13.2.0
sparc64               randconfig-001-20240704   gcc-13.2.0
sparc64               randconfig-002-20240704   gcc-13.2.0
um                                allnoconfig   clang-17
um                    randconfig-001-20240704   gcc-10
um                    randconfig-002-20240704   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240704   clang-18
x86_64       buildonly-randconfig-002-20240704   gcc-12
x86_64       buildonly-randconfig-003-20240704   clang-18
x86_64       buildonly-randconfig-004-20240704   gcc-13
x86_64       buildonly-randconfig-005-20240704   gcc-12
x86_64       buildonly-randconfig-006-20240704   gcc-13
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240704   clang-18
x86_64                randconfig-002-20240704   gcc-11
x86_64                randconfig-003-20240704   clang-18
x86_64                randconfig-004-20240704   clang-18
x86_64                randconfig-005-20240704   gcc-13
x86_64                randconfig-006-20240704   clang-18
x86_64                randconfig-011-20240704   gcc-13
x86_64                randconfig-012-20240704   gcc-10
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240704   gcc-13.2.0
xtensa                randconfig-002-20240704   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

