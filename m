Return-Path: <linux-acpi+bounces-10289-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF939FBA4F
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 08:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34787A14E2
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 07:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B9918CC13;
	Tue, 24 Dec 2024 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE4eCXS0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC98F66;
	Tue, 24 Dec 2024 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735026955; cv=none; b=nSLMiiyB6jEMxiRo0Xl3+JjWiDJzAGViVs6KwpQpoC9nDo0MqiqO0seMEUD1kxvWYgTBJsIfxi7f7SPDDsSHuoXOTMRs687UDgHGa0lag/MLbTRuVIUTT3NeLhG12XXom4tN4tShmC5MC3JFT7vYH0p7ZuOBQSnXoZnZj4sVxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735026955; c=relaxed/simple;
	bh=VIJW0ioJcLwkRd7kmwxledzpyZ22kH9m/2QI5TrXj+M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sSRfXFQNhQEGNDfTbu6xHkc5SfjSG+nXBbKcIJh31dBegdJmkfTAttZ/HxqZCvaHDQfHb0NONfkKyQlA35zyIhnTmxmM/+OnTr186vHo3Ghh8qiGEWLtPYGAo+OXmlFrpgNTEOx8NQ7y/75OACXY4qj+OuBrsqho/vDY+/VUac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE4eCXS0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735026953; x=1766562953;
  h=date:from:to:cc:subject:message-id;
  bh=VIJW0ioJcLwkRd7kmwxledzpyZ22kH9m/2QI5TrXj+M=;
  b=jE4eCXS0WPf8lG883kYxttntkljKcfXURrK88rHCpEhmHbg1Tnst/Fcn
   LINSQiIaUBaHEvRvVXSMR4a16vdPavAs4hVDr5gjtpNd1W2m0s20D0M5e
   nUlP1SsadXKyEjspl1hvlxuc/d6+xj3OHRH6ozFftNoszGIPjrh2Y1SH4
   RM3rsCPcl9aNlXsl1w5DZPMDDNI0OVVzPtxnAyKRcgpb4vKle7bgRPU9Y
   CiVkOme4mVaqlInvOL7hh6M+f6cxxCWQZ9gDDsS7OpF0O9eQzPkm2+5MA
   bBQ/AyK2l6jbkJhyfGDYNiIASxcvSPN9bSre9OiBzGyYPqs5Uoj2wQnTB
   w==;
X-CSE-ConnectionGUID: Kwg5iY9fTaivkEJPMapUmw==
X-CSE-MsgGUID: jXiutAHkQy65H9KTk7ci8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="35387709"
X-IronPort-AV: E=Sophos;i="6.12,259,1728975600"; 
   d="scan'208";a="35387709"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 23:55:52 -0800
X-CSE-ConnectionGUID: v/BNl69YRKycIkypmxZwzA==
X-CSE-MsgGUID: xfadkrtKReGAXMa4JMYJQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,259,1728975600"; 
   d="scan'208";a="99508819"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Dec 2024 23:55:50 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tPzlc-0000xL-0w;
	Tue, 24 Dec 2024 07:55:48 +0000
Date: Tue, 24 Dec 2024 15:55:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2a84c82a1f7b603e225c81aa7a3c5c3abbd48698
Message-ID: <202412241512.FKNY2A3K-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2a84c82a1f7b603e225c81aa7a3c5c3abbd48698  Merge branch 'experimental/intel_pstate-testing' into bleeding-edge

elapsed time: 1009m

configs tested: 140
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241223    gcc-13.2.0
arc                   randconfig-002-20241223    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                           h3600_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    clang-20
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20241223    gcc-14.2.0
arm                   randconfig-002-20241223    clang-16
arm                   randconfig-003-20241223    clang-20
arm                   randconfig-004-20241223    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241223    gcc-14.2.0
arm64                 randconfig-002-20241223    clang-18
arm64                 randconfig-003-20241223    gcc-14.2.0
arm64                 randconfig-004-20241223    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241224    gcc-14.2.0
csky                  randconfig-002-20241224    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241224    clang-20
hexagon               randconfig-002-20241224    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241224    clang-19
i386        buildonly-randconfig-002-20241224    gcc-12
i386        buildonly-randconfig-003-20241224    clang-19
i386        buildonly-randconfig-004-20241224    clang-19
i386        buildonly-randconfig-005-20241224    clang-19
i386        buildonly-randconfig-006-20241224    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241224    gcc-14.2.0
loongarch             randconfig-002-20241224    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241224    gcc-14.2.0
nios2                 randconfig-002-20241224    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241224    gcc-14.2.0
parisc                randconfig-002-20241224    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241224    clang-15
powerpc               randconfig-002-20241224    clang-20
powerpc               randconfig-003-20241224    gcc-14.2.0
powerpc64             randconfig-001-20241224    clang-20
powerpc64             randconfig-002-20241224    clang-20
powerpc64             randconfig-003-20241224    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241224    clang-17
riscv                 randconfig-002-20241224    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241224    gcc-14.2.0
s390                  randconfig-002-20241224    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241224    gcc-14.2.0
sh                    randconfig-002-20241224    gcc-14.2.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241224    gcc-14.2.0
sparc                 randconfig-002-20241224    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241224    gcc-14.2.0
sparc64               randconfig-002-20241224    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241224    gcc-12
um                    randconfig-002-20241224    clang-15
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241224    clang-19
x86_64      buildonly-randconfig-002-20241224    gcc-12
x86_64      buildonly-randconfig-003-20241224    gcc-12
x86_64      buildonly-randconfig-004-20241224    clang-19
x86_64      buildonly-randconfig-005-20241224    gcc-11
x86_64      buildonly-randconfig-006-20241224    gcc-11
x86_64                              defconfig    gcc-11
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241224    gcc-14.2.0
xtensa                randconfig-002-20241224    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

