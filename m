Return-Path: <linux-acpi+bounces-7256-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E2946A63
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Aug 2024 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A19A281D38
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Aug 2024 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153A137750;
	Sat,  3 Aug 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJ4JP1TV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B571ABEA7;
	Sat,  3 Aug 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699547; cv=none; b=r8vLAbDedsBfL/FApvydKS4/66nLMI2+Qdawz0+NEHDix7CTRyMVs6XAGNtZQLWkOStlXv2MsHhpPA6DClM3/JgSF5/jcQ3G4mC3oXzXWtkLjtlrN67nhVWa4bjxgWF2lQZzCf6VzOJnQoXJN48J2wjRC+2quUxeIqgdlNNgI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699547; c=relaxed/simple;
	bh=n528SYeVMZGR6AZRKbL7XTNFp4/Z4n6TNeo/OsWCLFg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ky5tdt8BAMX0Mv4IEq33jwjHzoJEwu0UoZTw22lZkvm/qlA1hCDIsPW7VZZNSUhZ7hYDCPW2MoxnenEnDLsWdLt32XD+0lHBPnQa/Ys04oYOsCGCJ3q99e5QvTDA1NBDPlHHDfvdJsV3ddzapltFx5qvmVm36H5z1A4bp5Bie64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJ4JP1TV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722699546; x=1754235546;
  h=date:from:to:cc:subject:message-id;
  bh=n528SYeVMZGR6AZRKbL7XTNFp4/Z4n6TNeo/OsWCLFg=;
  b=aJ4JP1TV5U+KtFwZ0RJXmVG/1j24sfCzkgcium/mdF1WqMJp72mUfJVJ
   yFUQG+os6ojdWt+WBYLFaIBlOQ6DzdjK6KGmHRYzmGMMMGfP3VGmMZ4Gl
   n1alQydwdzL4mmACTq463N+GcYKUL1j9VEOFMKZ5wNreSCL5HQSgg9o/+
   I2ch92++oE+aywgIKNHNAkBni8L1bkE2FRKvz6ZoJzBXHTLJCXYX/cNuW
   iOQAApczNpubfdjQbf/rGMqklqtmqyqD/9i8imc4SUWWQWyQ/Q7CkrntG
   cABMrIWeEYXUlJ95AZsQMuTHa0c4Z4cUexkbHcZt1sK942sDC2XEVx+kL
   Q==;
X-CSE-ConnectionGUID: MmECsmRKTm6KFc4YKBLgEg==
X-CSE-MsgGUID: lH/1L27RQp2DBKSFuMI1lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="38207026"
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="38207026"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 08:39:05 -0700
X-CSE-ConnectionGUID: cZDKF7MPTv6Aw9YRedqSiw==
X-CSE-MsgGUID: 3lyLR9utRkCUuvhHFoicbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="79004137"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 03 Aug 2024 08:39:04 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saGqU-0000dC-0h;
	Sat, 03 Aug 2024 15:39:02 +0000
Date: Sat, 03 Aug 2024 23:38:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bc51a513ebf760f50371d3771321f27f4a65c755
Message-ID: <202408032318.3VbdRCAf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bc51a513ebf760f50371d3771321f27f4a65c755  Merge branch 'acpi-pmic' into bleeding-edge

Warning ids grouped by kconfigs:

recent_errors
`-- arm-randconfig-051-20240803
    |-- arch-arm-boot-dts-nxp-ls-ls1021a-iot.dtb:soc-tmu-1f00000:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    |-- arch-arm-boot-dts-nxp-ls-ls1021a-moxa-uc-8410a.dtb:soc-tmu-1f00000:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    |-- arch-arm-boot-dts-nxp-ls-ls1021a-qds.dtb:soc-tmu-1f00000:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    |-- arch-arm-boot-dts-nxp-ls-ls1021a-tqmls1021a-mbls1021a.dtb:soc-tmu-1f00000:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    |-- arch-arm-boot-dts-nxp-ls-ls1021a-tsn.dtb:soc-tmu-1f00000:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu
    `-- arch-arm-boot-dts-nxp-ls-ls1021a-twr.dtb:soc-tmu-1f00000:failed-to-match-any-schema-with-compatible:fsl-qoriq-tmu

elapsed time: 1446m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240803   gcc-13.2.0
arc                   randconfig-002-20240803   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240803   gcc-14.1.0
arm                   randconfig-002-20240803   gcc-14.1.0
arm                   randconfig-003-20240803   clang-20
arm                   randconfig-004-20240803   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240803   clang-20
arm64                 randconfig-002-20240803   clang-20
arm64                 randconfig-003-20240803   clang-20
arm64                 randconfig-004-20240803   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240803   gcc-14.1.0
csky                  randconfig-002-20240803   gcc-14.1.0
hexagon                           allnoconfig   clang-20
hexagon               randconfig-001-20240803   clang-20
hexagon               randconfig-002-20240803   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-002-20240803   gcc-12
i386         buildonly-randconfig-003-20240803   gcc-12
i386         buildonly-randconfig-004-20240803   gcc-12
i386         buildonly-randconfig-005-20240803   clang-18
i386         buildonly-randconfig-006-20240803   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240803   gcc-12
i386                  randconfig-002-20240803   gcc-12
i386                  randconfig-003-20240803   clang-18
i386                  randconfig-004-20240803   gcc-12
i386                  randconfig-005-20240803   clang-18
i386                  randconfig-006-20240803   clang-18
i386                  randconfig-011-20240803   gcc-12
i386                  randconfig-012-20240803   gcc-11
i386                  randconfig-013-20240803   clang-18
i386                  randconfig-014-20240803   clang-18
i386                  randconfig-015-20240803   gcc-12
i386                  randconfig-016-20240803   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240803   gcc-14.1.0
loongarch             randconfig-002-20240803   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240803   gcc-14.1.0
nios2                 randconfig-002-20240803   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                randconfig-001-20240803   gcc-14.1.0
parisc                randconfig-002-20240803   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-001-20240803   gcc-14.1.0
powerpc               randconfig-003-20240803   clang-20
powerpc64             randconfig-001-20240803   gcc-14.1.0
powerpc64             randconfig-002-20240803   clang-20
powerpc64             randconfig-003-20240803   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                 randconfig-001-20240803   gcc-14.1.0
riscv                 randconfig-002-20240803   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240803   gcc-14.1.0
s390                  randconfig-002-20240803   clang-16
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                    randconfig-001-20240803   gcc-14.1.0
sh                    randconfig-002-20240803   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64               randconfig-001-20240803   gcc-14.1.0
sparc64               randconfig-002-20240803   gcc-14.1.0
um                                allnoconfig   clang-17
um                    randconfig-001-20240803   gcc-12
um                    randconfig-002-20240803   clang-17
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240803   gcc-14.1.0
xtensa                randconfig-002-20240803   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

