Return-Path: <linux-acpi+bounces-17383-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4298BA7CB4
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 04:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAAA18968E0
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 02:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0053189F3B;
	Mon, 29 Sep 2025 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2KGJ+yy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB692C859;
	Mon, 29 Sep 2025 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759112482; cv=none; b=Kz1tQX40Rn33n/hIi1YgDCOPqiKFfii76dBntPoGOCEulIhpgdq2/8zT/KVf73lswrZPWj+M9sVWbQhSaeZTb4wrakXNMby2mjk8BjoYz+Shj/LUDdJO+OV77XLefDbV2JVTDIqwq79tsnrVCEH/k0iyawYCnUFCofHFbZmaw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759112482; c=relaxed/simple;
	bh=tn9NtpT1P8MR1X+Hws/JjTxgFP9iNTztBRAjFyokYzw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LiXJxDDAdgDkHb9YfGzvarK5WrMN0Lf13mhQmYZivOFb00Tl5Zz4sf57CDEvwJj6I7rw1jmC5yXkSkIrzSJBrm1LQZqfh6lbXs27KuQ5x41wKkxsayQA3yn4oZcXEGtoWCs7l4jz+nMm8oXrwgI+crHXXL6642Vh35UT9QDnHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2KGJ+yy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759112481; x=1790648481;
  h=date:from:to:cc:subject:message-id;
  bh=tn9NtpT1P8MR1X+Hws/JjTxgFP9iNTztBRAjFyokYzw=;
  b=U2KGJ+yyPs7nXkm1QpUSZL5B2IoylwvmNMlcqeRL0+Q5iF10DY/A3/aL
   h7qj10gYyUPwXcaakcweLtITiuYVZqXazSVsE5biGIlAbLmFc1IeY/95o
   D3xSbLsmXpnsx7GXFoWcbF2l4vjKloS4H1gEgDZTEXvq3sY/ewkPQTsC7
   M4pP6mxB6GwMcnIC1zQdKpIovRERUIOnGVuXiQ3wNer3aRnoipAF0o3Xy
   PjejybRDXOL4oqpACGcn/CAt35aP5fh37KweCNs0/NqFkVv4JdZv92hJn
   h1MUDVaG2Epjg+qunO8zU1ykYIwHbbj2Y1GXwa9tv/R6EhZ7s+jt6yolQ
   g==;
X-CSE-ConnectionGUID: +nvVQVEkQEipVMMzNAFTjQ==
X-CSE-MsgGUID: qP6dRi9gRyqWfa+GG7NyFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="61461140"
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; 
   d="scan'208";a="61461140"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 19:21:18 -0700
X-CSE-ConnectionGUID: CmuwAIVXRN+MTcOH/SsDpg==
X-CSE-MsgGUID: iyHQxwqETJewYct5gyMKlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; 
   d="scan'208";a="178162197"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 28 Sep 2025 19:21:17 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v33Tl-00089V-31;
	Mon, 29 Sep 2025 02:19:53 +0000
Date: Mon, 29 Sep 2025 10:16:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 11c0c0dd019710f162cd5d246a4efdbaefdac48b
Message-ID: <202509291053.mDUYX1In-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 11c0c0dd019710f162cd5d246a4efdbaefdac48b  Merge branch 'acpi-apei-next' into bleeding-edge

Unverified Warning (likely false positive, kindly check if interested):

    drivers/base/power/runtime-test.c:182 pm_runtime_error_test() warn: pm_runtime_get_sync() also returns 1 on success
    drivers/base/power/runtime-test.c:22 pm_runtime_depth_test() warn: pm_runtime_get_sync() also returns 1 on success
    drivers/base/power/runtime-test.c:78 pm_runtime_idle_test() warn: pm_runtime_get_sync() also returns 1 on success
    include/linux/pm_runtime.h:628 class_pm_runtime_active_try_constructor() warn: passing zero to 'ERR_PTR'
    include/linux/pm_runtime.h:630 class_pm_runtime_active_try_constructor() warn: passing zero to 'ERR_PTR'

Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-141-20250929
|   |-- drivers-base-power-runtime-test.c-pm_runtime_depth_test()-warn:pm_runtime_get_sync()-also-returns-on-success
|   |-- drivers-base-power-runtime-test.c-pm_runtime_error_test()-warn:pm_runtime_get_sync()-also-returns-on-success
|   |-- drivers-base-power-runtime-test.c-pm_runtime_idle_test()-warn:pm_runtime_get_sync()-also-returns-on-success
|   `-- include-linux-pm_runtime.h-class_pm_runtime_active_try_constructor()-warn:passing-zero-to-ERR_PTR
|-- x86_64-randconfig-161-20250928
|   `-- include-linux-pm_runtime.h-class_pm_runtime_active_try_constructor()-warn:passing-zero-to-ERR_PTR
`-- x86_64-randconfig-161-20250929
    `-- include-linux-pm_runtime.h-class_pm_runtime_active_try_constructor()-warn:passing-zero-to-ERR_PTR

elapsed time: 934m

configs tested: 169
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250928    gcc-8.5.0
arc                   randconfig-002-20250928    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       multi_v4t_defconfig    clang-16
arm                   randconfig-001-20250928    clang-22
arm                   randconfig-002-20250928    clang-22
arm                   randconfig-003-20250928    clang-22
arm                   randconfig-004-20250928    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250928    gcc-15.1.0
arm64                 randconfig-002-20250928    gcc-9.5.0
arm64                 randconfig-003-20250928    clang-17
arm64                 randconfig-004-20250928    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250928    gcc-14.3.0
csky                  randconfig-001-20250929    clang-18
csky                  randconfig-002-20250928    gcc-15.1.0
csky                  randconfig-002-20250929    clang-18
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250928    clang-22
hexagon               randconfig-001-20250929    clang-18
hexagon               randconfig-002-20250928    clang-22
hexagon               randconfig-002-20250929    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250928    clang-20
i386        buildonly-randconfig-002-20250928    clang-20
i386        buildonly-randconfig-003-20250928    gcc-14
i386        buildonly-randconfig-004-20250928    clang-20
i386        buildonly-randconfig-005-20250928    clang-20
i386        buildonly-randconfig-006-20250928    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20250929    gcc-14
i386                  randconfig-012-20250929    gcc-14
i386                  randconfig-013-20250929    gcc-14
i386                  randconfig-014-20250929    gcc-14
i386                  randconfig-015-20250929    gcc-14
i386                  randconfig-016-20250929    gcc-14
i386                  randconfig-017-20250929    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250928    gcc-15.1.0
loongarch             randconfig-001-20250929    clang-18
loongarch             randconfig-002-20250928    gcc-15.1.0
loongarch             randconfig-002-20250929    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250928    gcc-11.5.0
nios2                 randconfig-001-20250929    clang-18
nios2                 randconfig-002-20250928    gcc-8.5.0
nios2                 randconfig-002-20250929    clang-18
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250928    gcc-14.3.0
parisc                randconfig-001-20250929    clang-18
parisc                randconfig-002-20250928    gcc-15.1.0
parisc                randconfig-002-20250929    clang-18
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                       holly_defconfig    clang-22
powerpc               randconfig-001-20250928    gcc-8.5.0
powerpc               randconfig-001-20250929    clang-18
powerpc               randconfig-002-20250928    clang-22
powerpc               randconfig-002-20250929    clang-18
powerpc               randconfig-003-20250928    gcc-8.5.0
powerpc               randconfig-003-20250929    clang-18
powerpc64             randconfig-001-20250928    gcc-10.5.0
powerpc64             randconfig-001-20250929    clang-18
powerpc64             randconfig-002-20250928    clang-20
powerpc64             randconfig-002-20250929    clang-18
powerpc64             randconfig-003-20250928    clang-22
powerpc64             randconfig-003-20250929    clang-18
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250928    gcc-11.5.0
riscv                 randconfig-002-20250928    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-14
s390                  randconfig-001-20250928    gcc-8.5.0
s390                  randconfig-002-20250928    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250928    gcc-15.1.0
sh                    randconfig-002-20250928    gcc-11.5.0
sh                             sh03_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250928    gcc-15.1.0
sparc                 randconfig-002-20250928    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250928    gcc-8.5.0
sparc64               randconfig-002-20250928    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250928    gcc-14
um                    randconfig-002-20250928    clang-19
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250928    gcc-14
x86_64      buildonly-randconfig-002-20250928    gcc-14
x86_64      buildonly-randconfig-003-20250928    gcc-14
x86_64      buildonly-randconfig-004-20250928    gcc-14
x86_64      buildonly-randconfig-005-20250928    clang-20
x86_64      buildonly-randconfig-006-20250928    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250928    gcc-8.5.0
xtensa                randconfig-002-20250928    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

