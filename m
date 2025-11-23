Return-Path: <linux-acpi+bounces-19200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B32C7DE94
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Nov 2025 10:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839623A9305
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Nov 2025 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022272989A2;
	Sun, 23 Nov 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anwSxmGn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D221D599;
	Sun, 23 Nov 2025 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763889318; cv=none; b=FeblJNAneklLM8XtCK2jEmY+J/Mxkn6z+59ZDJJyDN44T3g0RCR9NPEWgNJbVlESxEYN7HQUYs8YigFZoq1TxhC7hQtad5mZyddqs+GeOd7sSN6Q17AMJICQLrytiVkQtxmszCO3KubKjq99aI9mUdai8awqlkfULCTuQoQ4GEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763889318; c=relaxed/simple;
	bh=JuPxxQXTDiyNd1j7EbbZC8GNvXHp6IKbo/BaLj32NNw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lh6AF3at+kV6TzPCOHejdPkL2Dp0NKBxwSHk9lzmSeslrrmaB8aWM+uK9+lIioHjFfKhYICbZrkWDypz5omZucECTICo3xwdtBfYj+WDY+ZhRcsSMwKYAl9Or//racDYkcttUllid+CWM2cQRH/BaMlr/JjkEK5b281xTzLWqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anwSxmGn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763889316; x=1795425316;
  h=date:from:to:cc:subject:message-id;
  bh=JuPxxQXTDiyNd1j7EbbZC8GNvXHp6IKbo/BaLj32NNw=;
  b=anwSxmGnhhKuDelL1krigDQ2OqZJa+hFeBMknmkEvYJt2n+hisK6og6p
   4lJ/KR/gDSmRuRcgeUZnW7kdeOT0AQlAHqHGADFJoN6TFsFX7SQCNBCP9
   BcSBIBxxC5G2hT1Jc8U5p7vu7vfouEvVXQCbQxMepanDsst5wFt3tXjzL
   qT3eygr2U4E2HjrLyo9jlV2K6DESs1K1N24/TiRCMDI7VhhwwMjC5uVYX
   9OybchD8DZ59K0E5v5Cx+hRJjhyTuGuyvdcgTSgzAIeHLYgtaL1KAk9ss
   Hz7sdKbkv95oolVL7lU8y8hWrJilHlpWA5Pzh/qvqOjpgHCJceDd/9bSw
   g==;
X-CSE-ConnectionGUID: HujUFtU0QOuEbE+Zy1F4Ug==
X-CSE-MsgGUID: gnzhy3UJTO+NaMoQ+3ZXBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="65810361"
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; 
   d="scan'208";a="65810361"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 01:15:14 -0800
X-CSE-ConnectionGUID: Uqyh/k87R1aIDtzLKbxraA==
X-CSE-MsgGUID: I6Lx5tGcR3CTeUFyKHBh1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; 
   d="scan'208";a="196231237"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 23 Nov 2025 01:15:13 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vN6Ba-0008AV-2o;
	Sun, 23 Nov 2025 09:15:10 +0000
Date: Sun, 23 Nov 2025 17:14:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3f50784b8159855ffd528f2ba346e006a4e3f48e
Message-ID: <202511231732.kRy3DfSa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3f50784b8159855ffd528f2ba346e006a4e3f48e  Merge branch 'pm-powercap' into bleeding-edge

elapsed time: 2169m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251122    gcc-14.3.0
arc                   randconfig-002-20251122    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20251122    clang-22
arm                   randconfig-002-20251122    clang-22
arm                   randconfig-003-20251122    clang-22
arm                   randconfig-004-20251122    gcc-12.5.0
arm                         s5pv210_defconfig    gcc-15.1.0
arm                           sama5_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251123    gcc-8.5.0
arm64                 randconfig-002-20251123    gcc-11.5.0
arm64                 randconfig-003-20251123    clang-22
arm64                 randconfig-004-20251123    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251123    gcc-15.1.0
csky                  randconfig-002-20251123    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251122    clang-22
hexagon               randconfig-002-20251122    clang-17
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251123    clang-20
i386        buildonly-randconfig-002-20251123    clang-20
i386        buildonly-randconfig-003-20251123    gcc-14
i386        buildonly-randconfig-004-20251123    gcc-14
i386        buildonly-randconfig-005-20251123    clang-20
i386        buildonly-randconfig-006-20251123    gcc-14
i386                  randconfig-001-20251123    gcc-14
i386                  randconfig-002-20251123    gcc-14
i386                  randconfig-003-20251123    gcc-14
i386                  randconfig-004-20251123    gcc-14
i386                  randconfig-005-20251123    gcc-14
i386                  randconfig-006-20251123    clang-20
i386                  randconfig-007-20251123    gcc-14
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251122    gcc-12.5.0
loongarch             randconfig-002-20251122    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251122    gcc-11.5.0
nios2                 randconfig-002-20251122    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251123    gcc-14.3.0
parisc                randconfig-002-20251123    gcc-14.3.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20251123    clang-22
powerpc               randconfig-002-20251123    gcc-8.5.0
powerpc64             randconfig-001-20251123    clang-22
powerpc64             randconfig-002-20251123    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251123    clang-20
riscv                 randconfig-002-20251123    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251123    gcc-8.5.0
s390                  randconfig-002-20251123    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20251123    gcc-12.5.0
sh                    randconfig-002-20251123    gcc-14.3.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251123    gcc-8.5.0
sparc                 randconfig-002-20251123    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251123    clang-22
sparc64               randconfig-002-20251123    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251123    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251123    gcc-14
x86_64      buildonly-randconfig-002-20251123    gcc-12
x86_64      buildonly-randconfig-003-20251123    gcc-14
x86_64      buildonly-randconfig-004-20251123    clang-20
x86_64      buildonly-randconfig-005-20251123    gcc-14
x86_64      buildonly-randconfig-006-20251123    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-071-20251123    clang-20
x86_64                randconfig-072-20251123    gcc-14
x86_64                randconfig-073-20251123    gcc-12
x86_64                randconfig-074-20251123    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251123    gcc-14.3.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

