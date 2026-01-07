Return-Path: <linux-acpi+bounces-20000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06517CFE68B
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 15:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DE433065F5A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020F355819;
	Wed,  7 Jan 2026 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoqS/+DB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94F35581D;
	Wed,  7 Jan 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796494; cv=none; b=d2GPFU44UoqsN12h/9XrnwelX5Ih8p+vywsa+SMhp7ejaTCV34QcYOVuhXK9iV9zo7Cwkc7fpfMdIcEhwVgtJYz07g89/C4VXIz1AxlBDUhMh0RjiZb1a//uQW4hbsvOmJhd0oVw3YtA2YfghDy/uWBCVueXHBhZRq4mO+65P3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796494; c=relaxed/simple;
	bh=obs0bMymq6pRdaPxId+LvMY7rynWBJpnpw6jneCvzuo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WQR4h84Am1XqnkdGy2znkNLFuQGIRVEObFuUzEj6g+TonfJdryJPdvlPjigebZmvblKu9YrO2aKWUHflZV86s4KbYR0iw0FgU1QKxgk61aNdZDYLQnVjORrZTIsDCBHMo75fMia3yok4BXn542t4puAjySAWqUdomhgKUXfNIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoqS/+DB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767796492; x=1799332492;
  h=date:from:to:cc:subject:message-id;
  bh=obs0bMymq6pRdaPxId+LvMY7rynWBJpnpw6jneCvzuo=;
  b=NoqS/+DB65187XBpQVjHxWfUortFFesYM9MBc7H1KyLN31N9IXe9A4jN
   oVU+dBgaDW1R+ElWzp9Gw6oNVQ7zZnBDNeHWV42jsz/mGTXepYt+4g7n9
   zHXGIm8NFcp7FLt1M6mydX/NEO3SuxEOrAK8qH/aOx43Ac29Lxzwb826j
   FSxd4ReXSqCN7fo9nl/L4ku7ilMMF8ZPY4zPSOjpUVGp8IId/g/WxJm+I
   W9lQpu/V8arvOYX6WC7ldDb80/qVweAME4WripwLgp6Xn1NfDlyaeMzaV
   v0JCmcePGH6rfSt/R2qMcwuu9zdir1yBL48WznDOs8+nsi1jOG+ULx7Df
   A==;
X-CSE-ConnectionGUID: 1ERsWMENQh+H03+Dv4/prw==
X-CSE-MsgGUID: I14BsFytTYK/YgRVY1oeFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73013351"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="73013351"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 06:34:52 -0800
X-CSE-ConnectionGUID: ADovT2ROQKmkQ/NNkhlTrw==
X-CSE-MsgGUID: RT02NJzrTva9EooQGjj4vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="207407998"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Jan 2026 06:34:50 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdUcZ-000000003sr-2hBQ;
	Wed, 07 Jan 2026 14:34:47 +0000
Date: Wed, 07 Jan 2026 22:34:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e008713f0adaf69fba937cbde31ce368a626c3ac
Message-ID: <202601072231.eanPUudS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e008713f0adaf69fba937cbde31ce368a626c3ac  Merge branch 'pm-runtime-cleanup' into bleeding-edge

elapsed time: 1545m

configs tested: 236
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260106    gcc-13.4.0
arc                   randconfig-001-20260107    gcc-14.3.0
arc                   randconfig-002-20260106    gcc-8.5.0
arc                   randconfig-002-20260107    gcc-14.3.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                       aspeed_g5_defconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                          ep93xx_defconfig    clang-22
arm                   randconfig-001-20260106    gcc-11.5.0
arm                   randconfig-001-20260107    gcc-14.3.0
arm                   randconfig-002-20260106    clang-22
arm                   randconfig-002-20260107    gcc-14.3.0
arm                   randconfig-003-20260106    gcc-10.5.0
arm                   randconfig-003-20260107    gcc-14.3.0
arm                   randconfig-004-20260106    gcc-8.5.0
arm                   randconfig-004-20260107    gcc-14.3.0
arm                        vexpress_defconfig    clang-18
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260106    clang-22
arm64                 randconfig-001-20260107    clang-22
arm64                 randconfig-002-20260106    gcc-8.5.0
arm64                 randconfig-002-20260107    clang-22
arm64                 randconfig-003-20260106    gcc-9.5.0
arm64                 randconfig-003-20260107    clang-22
arm64                 randconfig-004-20260106    gcc-10.5.0
arm64                 randconfig-004-20260107    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260106    gcc-10.5.0
csky                  randconfig-001-20260107    clang-22
csky                  randconfig-002-20260106    gcc-11.5.0
csky                  randconfig-002-20260107    clang-22
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20260106    clang-22
hexagon               randconfig-001-20260107    gcc-8.5.0
hexagon               randconfig-002-20260107    gcc-8.5.0
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20260106    clang-20
i386        buildonly-randconfig-001-20260107    gcc-14
i386        buildonly-randconfig-002-20260106    clang-20
i386        buildonly-randconfig-002-20260107    gcc-14
i386        buildonly-randconfig-003-20260106    gcc-14
i386        buildonly-randconfig-003-20260107    gcc-14
i386        buildonly-randconfig-004-20260106    clang-20
i386        buildonly-randconfig-004-20260107    gcc-14
i386        buildonly-randconfig-005-20260106    gcc-14
i386        buildonly-randconfig-005-20260107    gcc-14
i386        buildonly-randconfig-006-20260106    clang-20
i386        buildonly-randconfig-006-20260107    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20260106    clang-20
i386                  randconfig-001-20260107    clang-20
i386                  randconfig-002-20260106    gcc-14
i386                  randconfig-002-20260107    clang-20
i386                  randconfig-003-20260106    clang-20
i386                  randconfig-003-20260107    clang-20
i386                  randconfig-004-20260106    clang-20
i386                  randconfig-004-20260107    clang-20
i386                  randconfig-005-20260106    clang-20
i386                  randconfig-005-20260107    clang-20
i386                  randconfig-006-20260106    clang-20
i386                  randconfig-006-20260107    clang-20
i386                  randconfig-007-20260106    clang-20
i386                  randconfig-007-20260107    clang-20
i386                  randconfig-011-20260106    clang-20
i386                  randconfig-011-20260107    clang-20
i386                  randconfig-012-20260106    gcc-14
i386                  randconfig-012-20260107    clang-20
i386                  randconfig-013-20260106    gcc-14
i386                  randconfig-013-20260107    clang-20
i386                  randconfig-014-20260106    clang-20
i386                  randconfig-014-20260107    clang-20
i386                  randconfig-015-20260106    gcc-14
i386                  randconfig-015-20260107    clang-20
i386                  randconfig-016-20260106    clang-20
i386                  randconfig-016-20260107    clang-20
i386                  randconfig-017-20260106    gcc-14
i386                  randconfig-017-20260107    clang-20
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260106    gcc-15.1.0
loongarch             randconfig-001-20260107    gcc-8.5.0
loongarch             randconfig-002-20260106    gcc-15.1.0
loongarch             randconfig-002-20260107    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-18
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260106    gcc-8.5.0
nios2                 randconfig-001-20260107    gcc-8.5.0
nios2                 randconfig-002-20260106    gcc-11.5.0
nios2                 randconfig-002-20260107    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260106    gcc-8.5.0
parisc                randconfig-001-20260107    clang-22
parisc                randconfig-002-20260106    gcc-11.5.0
parisc                randconfig-002-20260107    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          g5_defconfig    clang-18
powerpc                   lite5200b_defconfig    clang-18
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20260106    clang-22
powerpc               randconfig-001-20260107    clang-22
powerpc               randconfig-002-20260106    gcc-8.5.0
powerpc               randconfig-002-20260107    clang-22
powerpc64             randconfig-001-20260106    gcc-8.5.0
powerpc64             randconfig-001-20260107    clang-22
powerpc64             randconfig-002-20260106    gcc-8.5.0
powerpc64             randconfig-002-20260107    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260106    gcc-8.5.0
riscv                 randconfig-001-20260107    clang-22
riscv                 randconfig-002-20260106    clang-22
riscv                 randconfig-002-20260107    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20260106    gcc-8.5.0
s390                  randconfig-001-20260107    clang-22
s390                  randconfig-002-20260106    gcc-14.3.0
s390                  randconfig-002-20260107    clang-22
sh                               alldefconfig    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20260106    gcc-15.1.0
sh                    randconfig-001-20260107    clang-22
sh                    randconfig-002-20260106    gcc-10.5.0
sh                    randconfig-002-20260107    clang-22
sh                           se7722_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260106    gcc-11.5.0
sparc                 randconfig-001-20260107    gcc-15.1.0
sparc                 randconfig-002-20260106    gcc-15.1.0
sparc                 randconfig-002-20260107    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260106    clang-22
sparc64               randconfig-001-20260107    gcc-15.1.0
sparc64               randconfig-002-20260106    gcc-15.1.0
sparc64               randconfig-002-20260107    gcc-15.1.0
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260106    clang-22
um                    randconfig-001-20260107    gcc-15.1.0
um                    randconfig-002-20260106    clang-22
um                    randconfig-002-20260107    gcc-15.1.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20260106    clang-20
x86_64      buildonly-randconfig-001-20260107    gcc-14
x86_64      buildonly-randconfig-002-20260106    gcc-14
x86_64      buildonly-randconfig-002-20260107    gcc-14
x86_64      buildonly-randconfig-003-20260106    clang-20
x86_64      buildonly-randconfig-003-20260107    gcc-14
x86_64      buildonly-randconfig-004-20260106    gcc-14
x86_64      buildonly-randconfig-004-20260107    gcc-14
x86_64      buildonly-randconfig-005-20260106    clang-20
x86_64      buildonly-randconfig-005-20260107    gcc-14
x86_64      buildonly-randconfig-006-20260106    gcc-14
x86_64      buildonly-randconfig-006-20260107    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260106    gcc-14
x86_64                randconfig-002-20260106    gcc-14
x86_64                randconfig-003-20260106    clang-20
x86_64                randconfig-004-20260106    clang-20
x86_64                randconfig-005-20260106    gcc-14
x86_64                randconfig-006-20260106    gcc-14
x86_64                randconfig-011-20260106    gcc-14
x86_64                randconfig-011-20260107    clang-20
x86_64                randconfig-012-20260106    gcc-13
x86_64                randconfig-012-20260107    clang-20
x86_64                randconfig-013-20260106    gcc-14
x86_64                randconfig-013-20260107    clang-20
x86_64                randconfig-014-20260106    gcc-14
x86_64                randconfig-014-20260107    clang-20
x86_64                randconfig-015-20260106    clang-20
x86_64                randconfig-015-20260107    clang-20
x86_64                randconfig-016-20260106    clang-20
x86_64                randconfig-016-20260107    clang-20
x86_64                randconfig-071-20260107    clang-20
x86_64                randconfig-072-20260107    clang-20
x86_64                randconfig-073-20260107    clang-20
x86_64                randconfig-074-20260107    clang-20
x86_64                randconfig-075-20260107    clang-20
x86_64                randconfig-076-20260107    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                  nommu_kc705_defconfig    clang-18
xtensa                randconfig-001-20260106    gcc-8.5.0
xtensa                randconfig-001-20260107    gcc-15.1.0
xtensa                randconfig-002-20260106    gcc-8.5.0
xtensa                randconfig-002-20260107    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

