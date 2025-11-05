Return-Path: <linux-acpi+bounces-18552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA7C36513
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 16:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E1BA348C7E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC532F774;
	Wed,  5 Nov 2025 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I28A3+Df"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8332E727;
	Wed,  5 Nov 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356101; cv=none; b=oBiBzTlCUZitg3IAugWDoRdDurqbrcuQqM8+jYC0etPb9cfNuMmVakmrqOH4orNPeW4yAF2bvZSU1efsRtn0K45Lh08nPoIlirHoWpIgi4TmULkfgoUHWr3jlEFSG2xTBI1CeMz/EVev9w089xByxVyvRflYkT9oMvtjBze+4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356101; c=relaxed/simple;
	bh=RQ1O2EzQ1F8TeS9e2AbNF2vUfarNRvPpKWzjV8HsmvQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ums8fPE3oggF03wBYnJwVll5m71YS/l3ymNiLsRfhoyk+BAM2ouCSGLriMABdGrD16Wzaxqvy4EHY7CDxyMAnwNGAW/SiAD4AxufJ7RH3stLXQdkX6wJDImU04kKjkszppVmy/XvYRaOrvTZw0C/JthGa3FhQCTpV8841KGrn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I28A3+Df; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762356100; x=1793892100;
  h=date:from:to:cc:subject:message-id;
  bh=RQ1O2EzQ1F8TeS9e2AbNF2vUfarNRvPpKWzjV8HsmvQ=;
  b=I28A3+DfhMV2Azb0vDtwo1BVr3L7fVfLbHWrpgoS3IHFe+3APvvJVthZ
   F8fJggo+JCL2k4izXcSPAxXYvgt68+k1kbTpqXOjqa4fRbQxMxtmbJZ4s
   iBn0shf3RzmZHH4UNtneAGmX1Z/3oVvQwNcD5TXRj+8m8cr5CKcO4Ddre
   aefiKcyv4BxykkZ2vRQmUUdTSDoP4MvLHg1/s5xBe4u1kPEzoo7uoo3Vo
   Xtkl92hWGK8TTL/PQ7WtSoRieMgDFMll7p8+tTFBVrRN+jqbNvTAjFAnv
   0sBcN1oCDL1+jBjSq3jJXcWyNaa5nRrKvYbKoVfvOPFccoBJVbEaxzd8k
   A==;
X-CSE-ConnectionGUID: sv8IrzbJRla9AYsf+WvTng==
X-CSE-MsgGUID: g5jqouJtSACxGYQP8RDTag==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75825485"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75825485"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:21:39 -0800
X-CSE-ConnectionGUID: JkmfBjRsRXiO0N9xlOCLlg==
X-CSE-MsgGUID: SCMSl1eHS6eSfRURxLQaRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="188204695"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 05 Nov 2025 07:21:38 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGfKK-000Skn-1X;
	Wed, 05 Nov 2025 15:21:36 +0000
Date: Wed, 05 Nov 2025 23:17:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c9e0884e77a837123f29b699646cb2cecf773b7d
Message-ID: <202511052307.CvTRRg5d-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c9e0884e77a837123f29b699646cb2cecf773b7d  Merge branches 'pm-sleep' and 'pm-cpufreq' into linux-next

elapsed time: 1451m

configs tested: 147
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251105    gcc-8.5.0
arc                   randconfig-002-20251105    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                        multi_v7_defconfig    gcc-15.1.0
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20251105    clang-22
arm                   randconfig-002-20251105    clang-22
arm                   randconfig-003-20251105    clang-22
arm                   randconfig-004-20251105    gcc-12.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251105    clang-17
arm64                 randconfig-002-20251105    gcc-13.4.0
arm64                 randconfig-003-20251105    gcc-8.5.0
arm64                 randconfig-004-20251105    clang-17
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251105    gcc-15.1.0
csky                  randconfig-002-20251105    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251105    clang-22
hexagon               randconfig-002-20251105    clang-20
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251105    gcc-14
i386        buildonly-randconfig-002-20251105    gcc-14
i386        buildonly-randconfig-003-20251105    clang-20
i386        buildonly-randconfig-004-20251105    gcc-14
i386        buildonly-randconfig-005-20251105    gcc-14
i386        buildonly-randconfig-006-20251105    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251105    clang-20
i386                  randconfig-002-20251105    gcc-14
i386                  randconfig-003-20251105    clang-20
i386                  randconfig-004-20251105    clang-20
i386                  randconfig-005-20251105    clang-20
i386                  randconfig-006-20251105    gcc-13
i386                  randconfig-007-20251105    clang-20
i386                  randconfig-011-20251105    clang-20
i386                  randconfig-012-20251105    clang-20
i386                  randconfig-013-20251105    clang-20
i386                  randconfig-014-20251105    clang-20
i386                  randconfig-015-20251105    clang-20
i386                  randconfig-016-20251105    clang-20
i386                  randconfig-017-20251105    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251105    clang-18
loongarch             randconfig-002-20251105    clang-20
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                         db1xxx_defconfig    clang-22
mips                      maltaaprp_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251105    gcc-9.5.0
nios2                 randconfig-002-20251105    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251105    gcc-12.5.0
parisc                randconfig-002-20251105    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251105    gcc-14.3.0
powerpc               randconfig-002-20251105    gcc-12.5.0
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251105    clang-22
powerpc64             randconfig-002-20251105    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251105    gcc-8.5.0
riscv                 randconfig-002-20251105    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251105    gcc-8.5.0
s390                  randconfig-002-20251105    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251105    gcc-10.5.0
sh                    randconfig-002-20251105    gcc-11.5.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251105    clang-20
x86_64      buildonly-randconfig-002-20251105    gcc-13
x86_64      buildonly-randconfig-003-20251105    gcc-14
x86_64      buildonly-randconfig-004-20251105    gcc-13
x86_64      buildonly-randconfig-005-20251105    gcc-14
x86_64      buildonly-randconfig-006-20251105    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251105    clang-20
x86_64                randconfig-012-20251105    clang-20
x86_64                randconfig-013-20251105    clang-20
x86_64                randconfig-014-20251105    gcc-14
x86_64                randconfig-015-20251105    clang-20
x86_64                randconfig-016-20251105    gcc-14
x86_64                randconfig-071-20251105    gcc-14
x86_64                randconfig-072-20251105    clang-20
x86_64                randconfig-073-20251105    clang-20
x86_64                randconfig-074-20251105    clang-20
x86_64                randconfig-075-20251105    gcc-14
x86_64                randconfig-076-20251105    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-002-20251105    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

