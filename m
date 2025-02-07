Return-Path: <linux-acpi+bounces-10941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDFA2CE58
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2025 21:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A8164895
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2025 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207B1B0409;
	Fri,  7 Feb 2025 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H20oJs2L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342FB1AB528;
	Fri,  7 Feb 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960941; cv=none; b=N/INmLnfu9HS3TPhmSVuQO4kzkYwtRGHJqAy9726mcTTAKDeZJOmOZ2A1g2II+an8zd+Lxs8XakmSdWLnHXfcdhLV4Umo+mDuo5IKL2ezbR9IqyqdPNEPb2rffYvIPdeWNcBEFDhFKyVBCXkLcMLnbK9nXbQmStwCXEW/f6pnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960941; c=relaxed/simple;
	bh=N9SsJxnbLK3PQG2/jSzl4yhGMj9K6XVmd6Iv2/FIiQM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BXGD/68AA7eXGBeJhtRAv4vIATtxD0Pnv8Go/wLJbAab+XHfT1I9LOiSAShdr5mqvCL7KEUhJ7wuwg1jEA8GYFtWGN25fETjr+Syovpv0USG8p8RYs5k+LDzMG4p3tcSvjnSpi/IWdcQMA2HwLc+RZ45DzF/ksGIayBeXa0BcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H20oJs2L; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738960939; x=1770496939;
  h=date:from:to:cc:subject:message-id;
  bh=N9SsJxnbLK3PQG2/jSzl4yhGMj9K6XVmd6Iv2/FIiQM=;
  b=H20oJs2LW/9k1gn4fLEVuhGpexFiUQXh2nSrjOlZPIIvPlbfu5ZWsn6Z
   JZb9oxOLgA3X2DQjp4ZUmhxcttZRJuqjuIK/EnyvFLcNzgoHEVQb2NWbr
   DbVuWhfW6uyT+bDd5iquia6F/MxRFY/QhS4tCTuqprOS0wAnA2qAuBz7v
   0y02Lfgq/EOGeUgZrVmmhfuSLywPyAsGJbXgE5VeW/FRIKT670s/XlDNn
   9ggNgZ55CsYTSNZnfImiViO0Xw8dmdPXAe85ht2bqcIn41FgL7emtbkdD
   bFA0zjy4a2wCt23XuvQIZTCfQZmmbrZ/Pp8NdLxywPO9TD6D68bOVPiJG
   Q==;
X-CSE-ConnectionGUID: e3jZ5JY7SNK2sodo0SK82A==
X-CSE-MsgGUID: n0zACT2eQ+OWnNCp+hBoag==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="57031366"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="57031366"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 12:42:16 -0800
X-CSE-ConnectionGUID: sgjsIl5XSLqI/YuMaDFieg==
X-CSE-MsgGUID: 9EKbbPCzTbC0hY52w5TL/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="142497555"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Feb 2025 12:42:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgVAp-000z0x-0T;
	Fri, 07 Feb 2025 20:42:03 +0000
Date: Sat, 08 Feb 2025 04:41:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 b25e8c92425da18cb049244c4d930eff6414d6e2
Message-ID: <202502080417.iKsKY38r-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: b25e8c92425da18cb049244c4d930eff6414d6e2  Merge branch 'experimental/teo-tweak' into bleeding-edge

elapsed time: 1448m

configs tested: 233
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    clang-19
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    clang-19
arc                   randconfig-001-20250207    gcc-13.2.0
arc                   randconfig-001-20250208    gcc-13.2.0
arc                   randconfig-002-20250207    gcc-13.2.0
arc                   randconfig-002-20250208    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                         at91_dt_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    clang-21
arm                         lpc32xx_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250207    gcc-13.2.0
arm                   randconfig-001-20250207    gcc-14.2.0
arm                   randconfig-001-20250208    gcc-13.2.0
arm                   randconfig-002-20250207    gcc-13.2.0
arm                   randconfig-002-20250207    gcc-14.2.0
arm                   randconfig-002-20250208    gcc-13.2.0
arm                   randconfig-003-20250207    gcc-13.2.0
arm                   randconfig-003-20250207    gcc-14.2.0
arm                   randconfig-003-20250208    gcc-13.2.0
arm                   randconfig-004-20250207    clang-21
arm                   randconfig-004-20250207    gcc-13.2.0
arm                   randconfig-004-20250208    gcc-13.2.0
arm                         s3c6400_defconfig    clang-19
arm                         wpcm450_defconfig    clang-19
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250207    gcc-13.2.0
arm64                 randconfig-001-20250207    gcc-14.2.0
arm64                 randconfig-001-20250208    gcc-13.2.0
arm64                 randconfig-002-20250207    gcc-13.2.0
arm64                 randconfig-002-20250207    gcc-14.2.0
arm64                 randconfig-002-20250208    gcc-13.2.0
arm64                 randconfig-003-20250207    clang-16
arm64                 randconfig-003-20250207    gcc-13.2.0
arm64                 randconfig-003-20250208    gcc-13.2.0
arm64                 randconfig-004-20250207    clang-21
arm64                 randconfig-004-20250207    gcc-13.2.0
arm64                 randconfig-004-20250208    gcc-13.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    clang-21
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250207    gcc-14.2.0
csky                  randconfig-002-20250207    gcc-14.2.0
hexagon                          alldefconfig    clang-21
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250207    clang-21
hexagon               randconfig-001-20250207    gcc-14.2.0
hexagon               randconfig-002-20250207    clang-17
hexagon               randconfig-002-20250207    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250207    gcc-12
i386        buildonly-randconfig-001-20250208    gcc-11
i386        buildonly-randconfig-002-20250207    gcc-12
i386        buildonly-randconfig-002-20250208    gcc-11
i386        buildonly-randconfig-003-20250207    gcc-12
i386        buildonly-randconfig-003-20250208    gcc-11
i386        buildonly-randconfig-004-20250207    gcc-12
i386        buildonly-randconfig-004-20250208    gcc-11
i386        buildonly-randconfig-005-20250207    clang-19
i386        buildonly-randconfig-005-20250207    gcc-12
i386        buildonly-randconfig-005-20250208    gcc-11
i386        buildonly-randconfig-006-20250207    clang-19
i386        buildonly-randconfig-006-20250207    gcc-12
i386        buildonly-randconfig-006-20250208    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20250207    gcc-12
i386                  randconfig-002-20250207    gcc-12
i386                  randconfig-003-20250207    gcc-12
i386                  randconfig-004-20250207    gcc-12
i386                  randconfig-005-20250207    gcc-12
i386                  randconfig-006-20250207    gcc-12
i386                  randconfig-007-20250207    gcc-12
i386                  randconfig-011-20250207    gcc-12
i386                  randconfig-012-20250207    gcc-12
i386                  randconfig-013-20250207    gcc-12
i386                  randconfig-014-20250207    gcc-12
i386                  randconfig-015-20250207    gcc-12
i386                  randconfig-016-20250207    gcc-12
i386                  randconfig-017-20250207    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250207    gcc-14.2.0
loongarch             randconfig-002-20250207    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-19
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250207    gcc-14.2.0
nios2                 randconfig-002-20250207    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-21
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250207    gcc-14.2.0
parisc                randconfig-002-20250207    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                 canyonlands_defconfig    clang-19
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250207    clang-21
powerpc               randconfig-001-20250207    gcc-14.2.0
powerpc               randconfig-002-20250207    clang-21
powerpc               randconfig-002-20250207    gcc-14.2.0
powerpc               randconfig-003-20250207    gcc-14.2.0
powerpc                     tqm5200_defconfig    clang-19
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250207    gcc-14.2.0
powerpc64             randconfig-002-20250207    clang-21
powerpc64             randconfig-002-20250207    gcc-14.2.0
powerpc64             randconfig-003-20250207    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250207    gcc-14.2.0
riscv                 randconfig-002-20250207    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250207    gcc-14.2.0
s390                  randconfig-002-20250207    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    clang-21
sh                    randconfig-001-20250207    gcc-14.2.0
sh                    randconfig-002-20250207    gcc-14.2.0
sh                   sh7770_generic_defconfig    clang-21
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250207    gcc-14.2.0
sparc                 randconfig-002-20250207    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250207    gcc-14.2.0
sparc64               randconfig-002-20250207    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250207    clang-21
um                    randconfig-002-20250207    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250207    clang-19
x86_64      buildonly-randconfig-001-20250207    gcc-12
x86_64      buildonly-randconfig-001-20250208    clang-19
x86_64      buildonly-randconfig-002-20250207    clang-19
x86_64      buildonly-randconfig-002-20250208    clang-19
x86_64      buildonly-randconfig-003-20250207    clang-19
x86_64      buildonly-randconfig-003-20250208    clang-19
x86_64      buildonly-randconfig-004-20250207    clang-19
x86_64      buildonly-randconfig-004-20250208    clang-19
x86_64      buildonly-randconfig-005-20250207    clang-19
x86_64      buildonly-randconfig-005-20250208    clang-19
x86_64      buildonly-randconfig-006-20250207    clang-19
x86_64      buildonly-randconfig-006-20250208    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250207    clang-19
x86_64                randconfig-002-20250207    clang-19
x86_64                randconfig-003-20250207    clang-19
x86_64                randconfig-004-20250207    clang-19
x86_64                randconfig-005-20250207    clang-19
x86_64                randconfig-006-20250207    clang-19
x86_64                randconfig-007-20250207    clang-19
x86_64                randconfig-008-20250207    clang-19
x86_64                randconfig-071-20250207    gcc-12
x86_64                randconfig-071-20250208    gcc-12
x86_64                randconfig-072-20250207    gcc-12
x86_64                randconfig-072-20250208    gcc-12
x86_64                randconfig-073-20250207    gcc-12
x86_64                randconfig-073-20250208    gcc-12
x86_64                randconfig-074-20250207    gcc-12
x86_64                randconfig-074-20250208    gcc-12
x86_64                randconfig-075-20250207    gcc-12
x86_64                randconfig-075-20250208    gcc-12
x86_64                randconfig-076-20250207    gcc-12
x86_64                randconfig-076-20250208    gcc-12
x86_64                randconfig-077-20250207    gcc-12
x86_64                randconfig-077-20250208    gcc-12
x86_64                randconfig-078-20250207    gcc-12
x86_64                randconfig-078-20250208    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250207    gcc-14.2.0
xtensa                randconfig-002-20250207    gcc-14.2.0
xtensa                         virt_defconfig    clang-19
xtensa                    xip_kc705_defconfig    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

