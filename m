Return-Path: <linux-acpi+bounces-8956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1409B9AFC82
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 10:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB49B22FD8
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86CF1CFECE;
	Fri, 25 Oct 2024 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJ3TQn3o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB130146588;
	Fri, 25 Oct 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844873; cv=none; b=hdhpN3zOPReAxiQEARLPWUzzPgQ32OsUJTAyRJZAkiNamsnpzFXJA6jFdZFgQsYuZyHBL9j0A9DyE1kZj+maqKbd9DHOiHZUK7L9krVXh5sZbs6WVHM96LIyAP0OIG1lYY72odHLZz/yCyCj/azOM54KGqDhtTNLg+LIbOjdjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844873; c=relaxed/simple;
	bh=HEWZoLklbXIu2HmJ9WcEXauoMOq689zCnSqczzPSMfc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mRffspucb8059BFLariwvWloL+MBNaSCv0qGcDc4Y+92Bv0xJHSw1e6S6CUoAiOxHt8Mz3eeR8MMmCttKsYRUNm0mBxPNdsZCIBRKZxq9iKzQTKpt25+uXP2b3Dviwr5zheR9QBFSKrhYJP2z13W+xyDgX0GL58xv9brSqMYPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJ3TQn3o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844871; x=1761380871;
  h=date:from:to:cc:subject:message-id;
  bh=HEWZoLklbXIu2HmJ9WcEXauoMOq689zCnSqczzPSMfc=;
  b=MJ3TQn3owDB9fQEYohJfxzYC5/7/LZyiiZGJVMdBF4lnLiGizLN95iJ/
   UQ2reBoUYatVFwL9KwebvSAA+F6FzJ35EHzR1TGHw5ofSurVbAKv+kkqt
   xiSmbl/MTyr/sP/jAzlu/h9hZwH1ykMl58uySzMiKt1/u/cj/IAzUcKiw
   qqF9iVM8pSX61Fv4hKF52fNQFG6PBDjT8EA5EFDHqSl3y/aA2URUpcaot
   R9hAGYi2sKyuad2TmP/LwbEOlS/FoMDKu79350wTFG8hyBxqnVYqZOKVS
   W50P2yTSl3aGLUJOusKprrOXRM1cT7IATS0sGAwYvIS26aMhzU4uFsshh
   g==;
X-CSE-ConnectionGUID: uiruxZ7yRaq9i8qJle8D+A==
X-CSE-MsgGUID: s7mzCV3ATreFl0tjufJy3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33417798"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="33417798"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:27:51 -0700
X-CSE-ConnectionGUID: W6dzVM66TAu0x0P4S/Mh8A==
X-CSE-MsgGUID: xh0he07PR7WK9jLGFPQ8BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="84812248"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Oct 2024 01:27:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4Fff-000Xqy-2P;
	Fri, 25 Oct 2024 08:27:47 +0000
Date: Fri, 25 Oct 2024 16:27:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 0bb2cdfc8e286443621aa323ac01c9fe1f0069e8
Message-ID: <202410251626.6nJgSiCW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 0bb2cdfc8e286443621aa323ac01c9fe1f0069e8  Merge branch 'pm-cpufreq-fixes' into fixes

elapsed time: 979m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                     allnoconfig    gcc-14.1.0
alpha                    allyesconfig    clang-20
alpha                       defconfig    gcc-14.1.0
arc                      allmodconfig    clang-20
arc                       allnoconfig    gcc-14.1.0
arc                      allyesconfig    clang-20
arm                      allmodconfig    clang-20
arm                       allnoconfig    gcc-14.1.0
arm                      allyesconfig    clang-20
arm               aspeed_g5_defconfig    clang-20
arm                 lpc32xx_defconfig    gcc-14.1.0
arm                 s3c6400_defconfig    gcc-14.1.0
arm                   sama5_defconfig    clang-20
arm                  sp7021_defconfig    gcc-14.1.0
arm            vt8500_v6_v7_defconfig    gcc-14.1.0
arm64                    allmodconfig    clang-20
arm64                     allnoconfig    gcc-14.1.0
csky                      allnoconfig    gcc-14.1.0
hexagon                  allmodconfig    clang-20
hexagon                   allnoconfig    gcc-14.1.0
hexagon                  allyesconfig    clang-20
i386                     alldefconfig    gcc-14.1.0
i386                     allmodconfig    clang-19
i386                      allnoconfig    clang-19
i386                     allyesconfig    clang-19
i386                        defconfig    clang-19
loongarch                allmodconfig    gcc-14.1.0
loongarch                 allnoconfig    gcc-14.1.0
m68k                     allmodconfig    gcc-14.1.0
m68k                      allnoconfig    gcc-14.1.0
m68k                     allyesconfig    gcc-14.1.0
m68k                   sun3_defconfig    clang-20
microblaze               allmodconfig    gcc-14.1.0
microblaze                allnoconfig    gcc-14.1.0
microblaze               allyesconfig    gcc-14.1.0
mips                      allnoconfig    gcc-14.1.0
mips                bcm63xx_defconfig    clang-20
mips                 bigsur_defconfig    clang-20
mips                    gpr_defconfig    clang-20
mips                    gpr_defconfig    gcc-14.1.0
mips                   jazz_defconfig    gcc-14.1.0
mips                omega2p_defconfig    clang-20
nios2                     allnoconfig    gcc-14.1.0
openrisc                  allnoconfig    clang-20
openrisc                 allyesconfig    gcc-14.1.0
openrisc                    defconfig    gcc-12
parisc                   allmodconfig    gcc-14.1.0
parisc                    allnoconfig    clang-20
parisc                   allyesconfig    gcc-14.1.0
parisc                      defconfig    gcc-12
powerpc            adder875_defconfig    clang-20
powerpc                  allmodconfig    gcc-14.1.0
powerpc                   allnoconfig    clang-20
powerpc                  allyesconfig    gcc-14.1.0
powerpc            ge_imp3a_defconfig    clang-20
powerpc         mpc832x_rdb_defconfig    clang-20
powerpc             sequoia_defconfig    gcc-14.1.0
powerpc             tqm8560_defconfig    clang-20
powerpc              tqm8xx_defconfig    gcc-14.1.0
powerpc                warp_defconfig    gcc-14.1.0
riscv                    allmodconfig    gcc-14.1.0
riscv                     allnoconfig    clang-20
riscv                    allyesconfig    gcc-14.1.0
riscv                       defconfig    gcc-12
s390                     allmodconfig    gcc-14.1.0
s390                      allnoconfig    clang-20
s390                     allyesconfig    gcc-14.1.0
s390                        defconfig    gcc-12
s390               zfcpdump_defconfig    clang-20
sh                       allmodconfig    gcc-14.1.0
sh                        allnoconfig    gcc-14.1.0
sh                       allyesconfig    gcc-14.1.0
sh                          defconfig    gcc-12
sh                 ecovec24_defconfig    gcc-14.1.0
sh                edosk7705_defconfig    gcc-14.1.0
sh                  kfr2r09_defconfig    gcc-14.1.0
sh             magicpanelr2_defconfig    gcc-14.1.0
sh              rts7751r2d1_defconfig    clang-20
sh                   se7619_defconfig    gcc-14.1.0
sh                   se7705_defconfig    clang-20
sh                   se7705_defconfig    gcc-14.1.0
sh          sh7785lcr_32bit_defconfig    clang-20
sh                     shx3_defconfig    clang-20
sparc                    allmodconfig    gcc-14.1.0
sparc64                     defconfig    gcc-12
um                       allmodconfig    clang-20
um                        allnoconfig    clang-20
um                       allyesconfig    clang-20
um                          defconfig    gcc-12
um                     i386_defconfig    gcc-12
um                   x86_64_defconfig    gcc-12
x86_64                    allnoconfig    clang-19
x86_64                   allyesconfig    clang-19
x86_64                      defconfig    clang-19
x86_64                          kexec    clang-19
x86_64                          kexec    gcc-12
x86_64                       rhel-8.3    gcc-12
xtensa                    allnoconfig    gcc-14.1.0
xtensa          cadence_csp_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

