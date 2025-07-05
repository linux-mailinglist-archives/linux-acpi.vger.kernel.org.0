Return-Path: <linux-acpi+bounces-15034-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D070AF9E54
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jul 2025 06:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C95C1C81E5F
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jul 2025 04:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071DD254876;
	Sat,  5 Jul 2025 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8meLcFP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC051E8345;
	Sat,  5 Jul 2025 04:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751691203; cv=none; b=CrEfg07LhlxahoAVdXCaa5AqOoDx6/s3c0tuJrpFkZwp3L1kXcdQekxtzp8RuadMl6iKy4ZIwrZbB4aI0DxDHJflSgiW7qsDoi1Pg1onakTh78v6CEIceQgFJkIUaxAo5o/k1m32RHpHOFOFQtC3pTADWt8TJlkidfCzUhjd4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751691203; c=relaxed/simple;
	bh=EuKtamQQ27OLcMbtXoG2rLkjpE86u+EOB8Ffj07OrQA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P/kbjlAMvpFyi+J6GuTmaeW3QMTJk3Jg7p6V1p+tz1+qoe/L9fPf90VtuQkr0rwpRMtBP6QT2laJHF3TU68xngMKiwlUwyPAPkiSyavIHo3Mm9Ry82sms/cSI4tnfka8D01AEbVNhhoALVmnEC5dk02mhWGc1d2sm1ztcR7+J0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8meLcFP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751691201; x=1783227201;
  h=date:from:to:cc:subject:message-id;
  bh=EuKtamQQ27OLcMbtXoG2rLkjpE86u+EOB8Ffj07OrQA=;
  b=E8meLcFPVk7Z/XdhBl3Zzj8OevW+0J7/TKCPPjJAHd1cRTT0YhuMDVMx
   SqTpYtvpX/MFsX6NaQWG8ZAsM0OpGvAlTv6EpWjhlWC1X4FcuG47i9Nd0
   i0R7d8/Je+mJiPBy/q7VLIo8GN/hPj2FNEgnr97N413ZDL8cuG714wBvB
   9EzPkcl6PdL3dpQaQbzqmEVlPCrgUA4L9iiNpeEbnqq8Xw/PSS5RzvguR
   iLLWhX3NnbqWpDUeULe3neOUo2zWHL9/+z0JCmsH5CB5u62iAldSQI+Q/
   hIFAttca0MexbbAYnooK64YYRVVuTcvgP9jUvsliHXiyzsIPkWsTXb6dA
   w==;
X-CSE-ConnectionGUID: pTkIZzfVSMK+en14WVc5FA==
X-CSE-MsgGUID: VifDfQzJQ3+It92WbYrzlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="54147414"
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="54147414"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 21:53:21 -0700
X-CSE-ConnectionGUID: uXYEPBpwTEyo19MavoQ4Nw==
X-CSE-MsgGUID: UL3hvgsAR7S9MJcaSaJcMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="160308945"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Jul 2025 21:53:19 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXutp-0004IJ-1Q;
	Sat, 05 Jul 2025 04:53:17 +0000
Date: Sat, 05 Jul 2025 12:52:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 876e29f5a7f5038ca8a89f976bd644a37fb642b8
Message-ID: <202507051225.g3cNdOz0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 876e29f5a7f5038ca8a89f976bd644a37fb642b8  Merge branches 'acpi-processor' and 'acpi-apei' into linux-next

elapsed time: 1087m

configs tested: 254
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250704    gcc-8.5.0
arc                   randconfig-001-20250705    clang-21
arc                   randconfig-002-20250704    gcc-15.1.0
arc                   randconfig-002-20250705    clang-21
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                          gemini_defconfig    clang-20
arm                         orion5x_defconfig    clang-21
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20250704    gcc-8.5.0
arm                   randconfig-001-20250705    clang-21
arm                   randconfig-002-20250704    clang-21
arm                   randconfig-002-20250705    clang-21
arm                   randconfig-003-20250704    gcc-8.5.0
arm                   randconfig-003-20250705    clang-21
arm                   randconfig-004-20250704    gcc-13.4.0
arm                   randconfig-004-20250705    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250704    gcc-14.3.0
arm64                 randconfig-001-20250705    clang-21
arm64                 randconfig-002-20250704    clang-21
arm64                 randconfig-002-20250705    clang-21
arm64                 randconfig-003-20250704    clang-16
arm64                 randconfig-003-20250705    clang-21
arm64                 randconfig-004-20250704    gcc-10.5.0
arm64                 randconfig-004-20250705    clang-21
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250704    gcc-15.1.0
csky                  randconfig-001-20250705    gcc-9.3.0
csky                  randconfig-002-20250704    gcc-15.1.0
csky                  randconfig-002-20250705    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250704    clang-21
hexagon               randconfig-001-20250705    gcc-9.3.0
hexagon               randconfig-002-20250704    clang-21
hexagon               randconfig-002-20250705    gcc-9.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250704    gcc-12
i386        buildonly-randconfig-001-20250705    gcc-11
i386        buildonly-randconfig-001-20250705    gcc-12
i386        buildonly-randconfig-002-20250704    clang-20
i386        buildonly-randconfig-002-20250705    clang-20
i386        buildonly-randconfig-002-20250705    gcc-12
i386        buildonly-randconfig-003-20250704    clang-20
i386        buildonly-randconfig-003-20250705    gcc-12
i386        buildonly-randconfig-004-20250704    clang-20
i386        buildonly-randconfig-004-20250705    gcc-12
i386        buildonly-randconfig-005-20250704    clang-20
i386        buildonly-randconfig-005-20250705    gcc-12
i386        buildonly-randconfig-006-20250704    clang-20
i386        buildonly-randconfig-006-20250705    clang-20
i386        buildonly-randconfig-006-20250705    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250705    gcc-12
i386                  randconfig-002-20250705    gcc-12
i386                  randconfig-003-20250705    gcc-12
i386                  randconfig-004-20250705    gcc-12
i386                  randconfig-005-20250705    gcc-12
i386                  randconfig-006-20250705    gcc-12
i386                  randconfig-007-20250705    gcc-12
i386                  randconfig-011-20250705    clang-20
i386                  randconfig-012-20250705    clang-20
i386                  randconfig-013-20250705    clang-20
i386                  randconfig-014-20250705    clang-20
i386                  randconfig-015-20250705    clang-20
i386                  randconfig-016-20250705    clang-20
i386                  randconfig-017-20250705    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250704    gcc-15.1.0
loongarch             randconfig-001-20250705    gcc-9.3.0
loongarch             randconfig-002-20250704    gcc-15.1.0
loongarch             randconfig-002-20250705    gcc-9.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-21
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                     cu1000-neo_defconfig    clang-21
mips                      pic32mzda_defconfig    clang-21
mips                         rt305x_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250704    gcc-8.5.0
nios2                 randconfig-001-20250705    gcc-9.3.0
nios2                 randconfig-002-20250704    gcc-10.5.0
nios2                 randconfig-002-20250705    gcc-9.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250704    gcc-14.3.0
parisc                randconfig-001-20250705    gcc-9.3.0
parisc                randconfig-002-20250704    gcc-8.5.0
parisc                randconfig-002-20250705    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-21
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                       ppc64_defconfig    clang-21
powerpc               randconfig-001-20250704    clang-21
powerpc               randconfig-001-20250705    gcc-9.3.0
powerpc               randconfig-002-20250704    gcc-9.3.0
powerpc               randconfig-002-20250705    gcc-9.3.0
powerpc               randconfig-003-20250704    clang-21
powerpc               randconfig-003-20250705    gcc-9.3.0
powerpc64             randconfig-001-20250704    clang-18
powerpc64             randconfig-001-20250705    gcc-9.3.0
powerpc64             randconfig-002-20250704    gcc-10.5.0
powerpc64             randconfig-002-20250705    gcc-9.3.0
powerpc64             randconfig-003-20250704    clang-18
powerpc64             randconfig-003-20250705    gcc-9.3.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250704    clang-21
riscv                 randconfig-001-20250705    gcc-12
riscv                 randconfig-002-20250704    clang-21
riscv                 randconfig-002-20250705    gcc-12
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250704    gcc-15.1.0
s390                  randconfig-001-20250705    gcc-12
s390                  randconfig-002-20250704    gcc-8.5.0
s390                  randconfig-002-20250705    gcc-12
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250704    gcc-15.1.0
sh                    randconfig-001-20250705    gcc-12
sh                    randconfig-002-20250704    gcc-13.4.0
sh                    randconfig-002-20250705    gcc-12
sh                  sh7785lcr_32bit_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250704    gcc-11.5.0
sparc                 randconfig-001-20250705    gcc-12
sparc                 randconfig-002-20250704    gcc-8.5.0
sparc                 randconfig-002-20250705    gcc-12
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250704    gcc-13.4.0
sparc64               randconfig-001-20250705    gcc-12
sparc64               randconfig-002-20250704    clang-20
sparc64               randconfig-002-20250705    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250704    clang-21
um                    randconfig-001-20250705    gcc-12
um                    randconfig-002-20250704    clang-21
um                    randconfig-002-20250705    gcc-12
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250704    clang-20
x86_64      buildonly-randconfig-001-20250705    gcc-12
x86_64      buildonly-randconfig-002-20250704    gcc-12
x86_64      buildonly-randconfig-002-20250705    gcc-12
x86_64      buildonly-randconfig-003-20250704    clang-20
x86_64      buildonly-randconfig-003-20250705    clang-20
x86_64      buildonly-randconfig-003-20250705    gcc-12
x86_64      buildonly-randconfig-004-20250704    clang-20
x86_64      buildonly-randconfig-004-20250705    gcc-12
x86_64      buildonly-randconfig-005-20250704    clang-20
x86_64      buildonly-randconfig-005-20250705    gcc-12
x86_64      buildonly-randconfig-006-20250704    gcc-12
x86_64      buildonly-randconfig-006-20250705    clang-20
x86_64      buildonly-randconfig-006-20250705    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250705    clang-20
x86_64                randconfig-002-20250705    clang-20
x86_64                randconfig-003-20250705    clang-20
x86_64                randconfig-004-20250705    clang-20
x86_64                randconfig-005-20250705    clang-20
x86_64                randconfig-006-20250705    clang-20
x86_64                randconfig-007-20250705    clang-20
x86_64                randconfig-008-20250705    clang-20
x86_64                randconfig-071-20250705    clang-20
x86_64                randconfig-072-20250705    clang-20
x86_64                randconfig-073-20250705    clang-20
x86_64                randconfig-074-20250705    clang-20
x86_64                randconfig-075-20250705    clang-20
x86_64                randconfig-076-20250705    clang-20
x86_64                randconfig-077-20250705    clang-20
x86_64                randconfig-078-20250705    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250704    gcc-12.4.0
xtensa                randconfig-001-20250705    gcc-12
xtensa                randconfig-002-20250704    gcc-15.1.0
xtensa                randconfig-002-20250705    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

