Return-Path: <linux-acpi+bounces-3207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D620B84887B
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Feb 2024 20:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85948282A89
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Feb 2024 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C502744C;
	Sat,  3 Feb 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+p+Q7F8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24325EE83;
	Sat,  3 Feb 2024 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706988146; cv=none; b=evFJnB4pX0Bg8Cbwv5gaEkUE69F0l/soBlgPTpM0b3nFGcWj90SDGMB7wW68znEuz5nyyiFUa34yuRoeUCH1Dq2IzvoS98brZOJSY4y25HBwVwNMiejCoz7Jx0dff2ZnJYQpg/30SKjgOXD1DOjZ8w0CF9Z3fV8FhxaVVLZxuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706988146; c=relaxed/simple;
	bh=JRO18VtPszTZtjS0EDkVL01iqcJ1gDjLNBblFzPM6PA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PIbhRiwZDtAdMvJ53/7FOFU2DWARlS2l6P/acMr0BQcVCw6iEp3xDPfpGlzqWryVHutNfCXb6imjiUMMWwBX9NQjiAdalb3VlUkU5gaHlrkVorEbwmOAFj7LT5KUmJQjhJDgr3eWN2+n1kx5sgTT6Mg65j3lZ+tZ0PzJd5D1Q90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+p+Q7F8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706988145; x=1738524145;
  h=date:from:to:cc:subject:message-id;
  bh=JRO18VtPszTZtjS0EDkVL01iqcJ1gDjLNBblFzPM6PA=;
  b=G+p+Q7F8XLKU58Pf0rYQ0QlriLP4KlXqXAgARLS4/otZklForvZkSlh0
   fttHbYKnaJsLORKKtq2NYJkoX5R+/oiSS15Q39AbJPY+oiMNu4lTjbH+b
   ibvMorA+rE5Kfz4u0L49RiehCfWkEkFEE33Sgn0XBvnYrQx/vl35ivhSk
   HtpSEypxagl8BxHBfVas90tXfhYrTKFd+NDHc3MFdYVp0sOo9C1t4sy74
   pcjO00o1RNQyKzXyW+r1k12kQjs9mnQ/5UTVrmLgWvIZ0Ws8g6VHeSANc
   DFx8v3TtZfoj94/vFCKNB72vhSTxhRFePnW6SM5rXXOPAMoQS3Aft7U8s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4140678"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="4140678"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 11:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="373464"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 03 Feb 2024 11:22:22 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWLak-0005VI-2o;
	Sat, 03 Feb 2024 19:22:18 +0000
Date: Sun, 04 Feb 2024 03:22:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 7f82463a4ec5fd466fa00e93d627b38da5d43ae2
Message-ID: <202402040356.rcRnBxRW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 7f82463a4ec5fd466fa00e93d627b38da5d43ae2  Merge branch 'thermal-core' into bleeding-edge

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- drivers-char-apm-emulation.c:error:redeclaration-of-enumerator-SUSPEND_NONE
`-- arm-allyesconfig
    `-- drivers-char-apm-emulation.c:error:redeclaration-of-enumerator-SUSPEND_NONE

elapsed time: 1450m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240203   gcc  
arc                   randconfig-002-20240203   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   clang
arm                           imxrt_defconfig   clang
arm                        mvebu_v7_defconfig   clang
arm                   randconfig-001-20240203   clang
arm                   randconfig-002-20240203   clang
arm                   randconfig-003-20240203   gcc  
arm                   randconfig-004-20240203   clang
arm                        realview_defconfig   clang
arm                         socfpga_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240203   clang
arm64                 randconfig-002-20240203   clang
arm64                 randconfig-003-20240203   gcc  
arm64                 randconfig-004-20240203   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240203   gcc  
csky                  randconfig-002-20240203   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240203   clang
hexagon               randconfig-002-20240203   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240203   clang
i386         buildonly-randconfig-002-20240203   gcc  
i386         buildonly-randconfig-003-20240203   clang
i386         buildonly-randconfig-004-20240203   clang
i386         buildonly-randconfig-005-20240203   clang
i386         buildonly-randconfig-006-20240203   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240203   clang
i386                  randconfig-002-20240203   gcc  
i386                  randconfig-003-20240203   clang
i386                  randconfig-004-20240203   gcc  
i386                  randconfig-005-20240203   clang
i386                  randconfig-006-20240203   gcc  
i386                  randconfig-011-20240203   clang
i386                  randconfig-012-20240203   gcc  
i386                  randconfig-013-20240203   gcc  
i386                  randconfig-014-20240203   gcc  
i386                  randconfig-015-20240203   gcc  
i386                  randconfig-016-20240203   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240203   gcc  
loongarch             randconfig-002-20240203   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                           ci20_defconfig   clang
mips                           jazz_defconfig   clang
mips                      maltaaprp_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240203   gcc  
nios2                 randconfig-002-20240203   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240203   gcc  
parisc                randconfig-002-20240203   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240203   clang
powerpc               randconfig-002-20240203   clang
powerpc               randconfig-003-20240203   clang
powerpc                     skiroot_defconfig   clang
powerpc64             randconfig-001-20240203   clang
powerpc64             randconfig-002-20240203   gcc  
powerpc64             randconfig-003-20240203   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240203   clang
riscv                 randconfig-002-20240203   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240203   gcc  
s390                  randconfig-002-20240203   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240203   gcc  
sh                    randconfig-002-20240203   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240203   gcc  
sparc64               randconfig-002-20240203   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240203   clang
um                    randconfig-002-20240203   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240203   gcc  
x86_64       buildonly-randconfig-002-20240203   gcc  
x86_64       buildonly-randconfig-003-20240203   gcc  
x86_64       buildonly-randconfig-004-20240203   gcc  
x86_64       buildonly-randconfig-005-20240203   gcc  
x86_64       buildonly-randconfig-006-20240203   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240203   gcc  
x86_64                randconfig-002-20240203   gcc  
x86_64                randconfig-003-20240203   clang
x86_64                randconfig-004-20240203   gcc  
x86_64                randconfig-005-20240203   gcc  
x86_64                randconfig-006-20240203   gcc  
x86_64                randconfig-011-20240203   gcc  
x86_64                randconfig-012-20240203   gcc  
x86_64                randconfig-013-20240203   clang
x86_64                randconfig-014-20240203   clang
x86_64                randconfig-015-20240203   clang
x86_64                randconfig-016-20240203   clang
x86_64                randconfig-071-20240203   clang
x86_64                randconfig-072-20240203   gcc  
x86_64                randconfig-073-20240203   clang
x86_64                randconfig-074-20240203   clang
x86_64                randconfig-075-20240203   clang
x86_64                randconfig-076-20240203   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240203   gcc  
xtensa                randconfig-002-20240203   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

