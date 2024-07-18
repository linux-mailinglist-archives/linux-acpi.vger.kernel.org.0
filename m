Return-Path: <linux-acpi+bounces-6951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6E4934BC8
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2024 12:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008792844D6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2024 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC412C46D;
	Thu, 18 Jul 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koZ7hV1h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F02757FD;
	Thu, 18 Jul 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299118; cv=none; b=AwAzyIk3JOQ8n9Cv+QzJvjt8eXOF5vpbS7i+MZg1jei9MOLch+1Hn5Zr7xSsrxe7mibMDyTMok/hXxKo9lWx2TZGZeJLf+JRyk5oWOGX68W82ydr3AFChxNTGmQ5WxTAMqutHtER6Z1O77zpxN75I22HtO8eMdb0ci5rnaWtBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299118; c=relaxed/simple;
	bh=kcHGFsbV9dDcpTeaYJrHBqSMCCiYA8Qo+AbZsKpS7e0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SGPdAMQaJ7medQzY1Duy+dJuWwaqaXAkOpEh0301up4x7e5A4srm47t0XP6T2fk47ZR9MfnAGuXjJG3eelgOoM3OCxFk1lnupwsBLeMqsp343uuIKgD/m6CFhfCVKC4+1SqfhnBTnhbFgoZ2F6mHZiLQ5b4uVgpbFl/ZqtA32hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koZ7hV1h; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721299116; x=1752835116;
  h=date:from:to:cc:subject:message-id;
  bh=kcHGFsbV9dDcpTeaYJrHBqSMCCiYA8Qo+AbZsKpS7e0=;
  b=koZ7hV1h2T/HKsRSg4fYoJ9WexooVj1eNUcV7DuynJzyMA72gBCo38jT
   VmCofR8rw1AYsd0BpExSg4uHp3/64KR+hMFN0gdYtsapwo5bbbhlkr0On
   O6IvAHXGTiAXNdv4eLl6ZQ11iSqXQTttqGt9CherIKEXDQpYErJu0Vl2a
   JMmcHYkBk9uc9u8bSvAUbiDEicz2Xn3E56RVIZg+XEKRcSui0HIquAXp4
   s73OKJWjYni2BRzTKPQFu66mI0cBgzvNYWZF3I+NTZ+jzxmAOnkYFm+rw
   WnSZ1z6ohlmMVCJYY4xePvtzHUvNAiPQwTxZJqU+jxDOsJuH9FldMMLU/
   g==;
X-CSE-ConnectionGUID: o9JbP53dRwaxOGtrF7XBHg==
X-CSE-MsgGUID: BMH1BCycRZyFtIOqr/iPeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18556070"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18556070"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 03:38:36 -0700
X-CSE-ConnectionGUID: BUVWmtEnRYyRxk66aBM7vA==
X-CSE-MsgGUID: BjRy+ST3RKGB7f3lY++8Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="50590833"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Jul 2024 03:38:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUOWu-000h9e-1b;
	Thu, 18 Jul 2024 10:38:32 +0000
Date: Thu, 18 Jul 2024 18:37:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ec55178bd6157b96a8906eed065455c305d202db
Message-ID: <202407181844.C0XodsHY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ec55178bd6157b96a8906eed065455c305d202db  Merge branch 'thermal-fixes' into bleeding-edge

elapsed time: 843m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240718   gcc-13.2.0
arc                   randconfig-002-20240718   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                          ep93xx_defconfig   clang-14
arm                   randconfig-001-20240718   clang-19
arm                   randconfig-002-20240718   gcc-14.1.0
arm                   randconfig-003-20240718   clang-19
arm                   randconfig-004-20240718   gcc-14.1.0
arm                             rpc_defconfig   clang-19
arm                           sama7_defconfig   clang-19
arm                           sunxi_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240718   clang-15
arm64                 randconfig-002-20240718   clang-19
arm64                 randconfig-003-20240718   gcc-14.1.0
arm64                 randconfig-004-20240718   clang-19
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240718   gcc-14.1.0
csky                  randconfig-002-20240718   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240718   clang-19
hexagon               randconfig-002-20240718   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-7
i386         buildonly-randconfig-003-20240718   gcc-13
i386         buildonly-randconfig-004-20240718   clang-18
i386         buildonly-randconfig-005-20240718   gcc-9
i386         buildonly-randconfig-006-20240718   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240718   gcc-13
i386                  randconfig-002-20240718   gcc-13
i386                  randconfig-003-20240718   clang-18
i386                  randconfig-004-20240718   clang-18
i386                  randconfig-005-20240718   clang-18
i386                  randconfig-006-20240718   clang-18
i386                  randconfig-011-20240718   gcc-13
i386                  randconfig-012-20240718   gcc-13
i386                  randconfig-013-20240718   gcc-10
i386                  randconfig-014-20240718   clang-18
i386                  randconfig-015-20240718   clang-18
i386                  randconfig-016-20240718   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240718   gcc-14.1.0
loongarch             randconfig-002-20240718   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                        stmark2_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                        qi_lb60_defconfig   clang-19
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240718   gcc-14.1.0
nios2                 randconfig-002-20240718   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                 simple_smp_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240718   gcc-14.1.0
parisc                randconfig-002-20240718   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                      ppc44x_defconfig   clang-16
powerpc               randconfig-001-20240718   clang-17
powerpc               randconfig-002-20240718   clang-19
powerpc               randconfig-003-20240718   gcc-14.1.0
powerpc                     tqm5200_defconfig   gcc-14.1.0
powerpc                     tqm8548_defconfig   clang-19
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240718   clang-19
powerpc64             randconfig-002-20240718   gcc-14.1.0
powerpc64             randconfig-003-20240718   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240718   clang-17
riscv                 randconfig-002-20240718   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240718   clang-19
s390                  randconfig-002-20240718   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240718   gcc-14.1.0
sh                          rsk7203_defconfig   gcc-14.1.0
sh                           se7343_defconfig   gcc-14.1.0
sh                           se7619_defconfig   gcc-14.1.0
sh                           sh2007_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

