Return-Path: <linux-acpi+bounces-15313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC3BB10CA4
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E757A7CFC
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148A0190676;
	Thu, 24 Jul 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOaaqcuD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6BE14286;
	Thu, 24 Jul 2025 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365994; cv=none; b=fH+BwHOR/vaaFAofzOnZUKFYHSicifnKraWlirUUMd1RNei0d1XXmUIF4qxzD02r7MQR5NRDerhMY0avsaWzIuwxUmJ9uueegRteL/1ntakGcLqcTekYXpBafLqgof39Z3EFbNjM1fr3r+d1MUWKO8AR/hez25JlLUY5C7BoykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365994; c=relaxed/simple;
	bh=xQo5KEqoF1PffvNp9AFrbP5Uz2nyeKq2oyhFi5dQqxg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=igmrmCm2aNdfYaVJLz3fE9fpX3LQZDV31ZmZSePQiRyG6obp4vLtFdo8WyszlBfud4BkMyCmK+0TTIYwFcrz+CmDLh7Ffp8533cuM+HZpt9xBajTypMd60RLnkuRzpTXzYniPZ99aPztNkObXvaRwpd5oTJChFMB0JJLZ7nsoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOaaqcuD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753365992; x=1784901992;
  h=date:from:to:cc:subject:message-id;
  bh=xQo5KEqoF1PffvNp9AFrbP5Uz2nyeKq2oyhFi5dQqxg=;
  b=iOaaqcuDpg+1m5i4FYUv9CEEZwXaF7lRtXttV/drbvpyU7WXl3wLMJlg
   W39+MkshjVMyn6Ri/g/O51ODbatiVhkYpfn6vOdCLVdBEHv9orI2rCRtF
   EtJvttupmjxsPzglZDxXYfpD/LENvsm+lGJ/UhxDq0KASt0LJAKLXiJol
   MCdkzjPy1rfuZ6bVNPZZXupIa7s5h5BVrB73/EVjBONxhO3eCxBnRat6P
   ej06KtskfZolkpPFOBbVBThmOq2B+KegQjAz6wlnj4SP6wOrDkWcKSfOr
   FYZCEFxAsQZmKzIFHf7jEw6mWZQepnUrx6+ba9VafJd/vsLC4crMZdaW/
   g==;
X-CSE-ConnectionGUID: PJg9C+jkRv2ENSwmzX3d8Q==
X-CSE-MsgGUID: t5UFlC+oRH6q+b3bfRFSkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66382240"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="66382240"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:06:31 -0700
X-CSE-ConnectionGUID: nd9DgN1LQqG+Kc3PwLL8Ow==
X-CSE-MsgGUID: vf7GIPvARfG26Wiatij3HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="191175796"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Jul 2025 07:06:30 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uewaa-000KVn-0b;
	Thu, 24 Jul 2025 14:06:28 +0000
Date: Thu, 24 Jul 2025 22:06:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 77d832285656c59238e7992f12296e18657251ee
Message-ID: <202507242258.lSgpTN9e-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 77d832285656c59238e7992f12296e18657251ee  Merge branch 'pm-cpufreq' into linux-next

elapsed time: 1447m

configs tested: 161
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250723    gcc-8.5.0
arc                   randconfig-001-20250724    gcc-13.4.0
arc                   randconfig-002-20250723    gcc-9.5.0
arc                   randconfig-002-20250724    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250723    gcc-13.4.0
arm                   randconfig-001-20250724    gcc-10.5.0
arm                   randconfig-002-20250723    gcc-13.4.0
arm                   randconfig-002-20250724    clang-22
arm                   randconfig-003-20250723    clang-16
arm                   randconfig-003-20250724    gcc-8.5.0
arm                   randconfig-004-20250723    clang-22
arm                   randconfig-004-20250724    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250723    clang-22
arm64                 randconfig-001-20250724    gcc-8.5.0
arm64                 randconfig-002-20250723    clang-16
arm64                 randconfig-002-20250724    clang-22
arm64                 randconfig-003-20250723    clang-16
arm64                 randconfig-003-20250724    gcc-13.4.0
arm64                 randconfig-004-20250723    clang-22
arm64                 randconfig-004-20250724    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250723    gcc-12.5.0
csky                  randconfig-001-20250724    gcc-13.4.0
csky                  randconfig-002-20250723    gcc-14.3.0
csky                  randconfig-002-20250724    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250723    clang-22
hexagon               randconfig-001-20250724    clang-22
hexagon               randconfig-002-20250723    clang-22
hexagon               randconfig-002-20250724    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250723    clang-20
i386        buildonly-randconfig-001-20250724    gcc-12
i386        buildonly-randconfig-002-20250723    clang-20
i386        buildonly-randconfig-002-20250724    clang-20
i386        buildonly-randconfig-003-20250723    clang-20
i386        buildonly-randconfig-003-20250724    clang-20
i386        buildonly-randconfig-004-20250723    clang-20
i386        buildonly-randconfig-004-20250724    clang-20
i386        buildonly-randconfig-005-20250723    gcc-11
i386        buildonly-randconfig-005-20250724    clang-20
i386        buildonly-randconfig-006-20250723    clang-20
i386        buildonly-randconfig-006-20250724    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250723    gcc-15.1.0
loongarch             randconfig-001-20250724    clang-22
loongarch             randconfig-002-20250723    clang-22
loongarch             randconfig-002-20250724    gcc-13.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250723    gcc-8.5.0
nios2                 randconfig-001-20250724    gcc-11.5.0
nios2                 randconfig-002-20250723    gcc-11.5.0
nios2                 randconfig-002-20250724    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250723    gcc-8.5.0
parisc                randconfig-001-20250724    gcc-14.3.0
parisc                randconfig-002-20250723    gcc-15.1.0
parisc                randconfig-002-20250724    gcc-8.5.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250723    gcc-10.5.0
powerpc               randconfig-001-20250724    clang-22
powerpc               randconfig-002-20250723    gcc-8.5.0
powerpc               randconfig-002-20250724    gcc-8.5.0
powerpc               randconfig-003-20250723    gcc-12.5.0
powerpc               randconfig-003-20250724    clang-22
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250723    clang-22
powerpc64             randconfig-001-20250724    clang-22
powerpc64             randconfig-002-20250723    clang-22
powerpc64             randconfig-002-20250724    gcc-13.4.0
powerpc64             randconfig-003-20250723    clang-22
powerpc64             randconfig-003-20250724    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250723    gcc-9.5.0
riscv                 randconfig-002-20250723    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250723    clang-22
s390                  randconfig-002-20250723    clang-20
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250723    gcc-12.5.0
sh                    randconfig-002-20250723    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250723    gcc-8.5.0
sparc                 randconfig-002-20250723    gcc-8.5.0
sparc64               randconfig-001-20250723    gcc-12.5.0
sparc64               randconfig-002-20250723    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                    randconfig-001-20250723    gcc-12
um                    randconfig-002-20250723    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250723    gcc-12
x86_64      buildonly-randconfig-001-20250724    gcc-12
x86_64      buildonly-randconfig-002-20250723    gcc-11
x86_64      buildonly-randconfig-002-20250724    clang-20
x86_64      buildonly-randconfig-003-20250723    gcc-11
x86_64      buildonly-randconfig-003-20250724    gcc-12
x86_64      buildonly-randconfig-004-20250723    clang-20
x86_64      buildonly-randconfig-004-20250724    gcc-12
x86_64      buildonly-randconfig-005-20250723    gcc-12
x86_64      buildonly-randconfig-005-20250724    clang-20
x86_64      buildonly-randconfig-006-20250723    gcc-12
x86_64      buildonly-randconfig-006-20250724    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250723    gcc-13.4.0
xtensa                randconfig-002-20250723    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

