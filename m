Return-Path: <linux-acpi+bounces-19365-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E41C94F82
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Nov 2025 13:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E88A344A7C
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Nov 2025 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FBC27C84E;
	Sun, 30 Nov 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Roz1E5KB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195F23A98E;
	Sun, 30 Nov 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764506217; cv=none; b=rvtcnTW9QCchM6q5ScCbYrMeh+lxGhrJWku/xPJuLYlAkxtD2ZQvGSbYp89bFgKid3kWU6oF5GqXNn2+Yg/CoqI/lJQbrGXIGXhsK2CRpQE1XFdi3MZbbX3IOCDj7WB0HQfOAz0chDFkmYrhk/relHjl17YJ6NcXs1ZCluHGOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764506217; c=relaxed/simple;
	bh=WiBLBlZ3PZ0mdxDQpPjqKx0x1HZfO+7FMgqLaV8JgWc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jw4WSpHz4IffwAokN9M8A+PO8bg+NgqTuN3ukInN40wnXxENZW111GgXQA9UsdhhcQrKBIGZ8hFl3wqOPhPRsqlRTgOn9/n46ugVhiicuq8aKkGckkIoR6zjqjzIa22FNmHp+xXxAExTyHUdYq1DjJHkJ9Vhds/A2Nf8G4uLrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Roz1E5KB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764506216; x=1796042216;
  h=date:from:to:cc:subject:message-id;
  bh=WiBLBlZ3PZ0mdxDQpPjqKx0x1HZfO+7FMgqLaV8JgWc=;
  b=Roz1E5KBLOv0hPB0/vEioVXK10NDvApyvYn7LXyGkNyyiJ91uv6loYX7
   ob9dL9oGXZKB4C5ipDQsvyBF9rTappROsdIdfr+Dx0RsXXQgazUyizjhh
   l5HVl0PBR8MAjDYQj3jvVu1iy5SZUkj0mnkt9zJdjajbKsOC3/o5q3CNg
   4ffkDPXyAeK8rqAFgE88LVUC5aQqB+qo7/nSq6XO1ZeXvzDN2/pQoa30K
   OSZUikm2SQQIqpdXows2LhTdA/dLsPD6tPaUInWKqL6EL4ePh95KwxJih
   7/pLXgK+5K96JVHtZozS3H/eawYf4+O2KyQvig8/UrN1ffEKqmZLyzsJH
   Q==;
X-CSE-ConnectionGUID: ov4VNui7Qe2QqVcF/VsqhA==
X-CSE-MsgGUID: wR+dAU96TyChLVk6wDEU3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11628"; a="84060878"
X-IronPort-AV: E=Sophos;i="6.20,238,1758610800"; 
   d="scan'208";a="84060878"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 04:36:55 -0800
X-CSE-ConnectionGUID: GGdA9P/tQOC7V3b6l3IyVQ==
X-CSE-MsgGUID: gj+vb/arSI+dsD1duCxLZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,238,1758610800"; 
   d="scan'208";a="193721276"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 30 Nov 2025 04:36:54 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vPgfb-000000007xF-2Urn;
	Sun, 30 Nov 2025 12:36:51 +0000
Date: Sun, 30 Nov 2025 20:35:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 b8ed7c24b81a7718f8b13f6b0c9147698b273180
Message-ID: <202511302046.4IFLS2nu-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: b8ed7c24b81a7718f8b13f6b0c9147698b273180  Merge branch 'thermal' into linux-next

elapsed time: 2882m

configs tested: 94
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251129    gcc-8.5.0
arc                   randconfig-002-20251129    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                   randconfig-001-20251129    clang-20
arm                   randconfig-002-20251129    gcc-10.5.0
arm                   randconfig-003-20251129    gcc-13.4.0
arm                   randconfig-004-20251129    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251129    clang-20
i386        buildonly-randconfig-002-20251129    clang-20
i386        buildonly-randconfig-003-20251129    gcc-14
i386        buildonly-randconfig-004-20251129    gcc-12
i386        buildonly-randconfig-005-20251129    gcc-14
i386        buildonly-randconfig-006-20251129    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20251129    clang-20
i386                  randconfig-012-20251129    gcc-13
i386                  randconfig-013-20251129    clang-20
i386                  randconfig-014-20251129    clang-20
i386                  randconfig-015-20251129    gcc-14
i386                  randconfig-016-20251129    clang-20
i386                  randconfig-017-20251129    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251129    gcc-10.5.0
parisc                randconfig-001-20251130    gcc-13.4.0
parisc                randconfig-002-20251129    gcc-13.4.0
parisc                randconfig-002-20251130    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251129    gcc-8.5.0
powerpc               randconfig-001-20251130    clang-22
powerpc               randconfig-002-20251129    clang-22
powerpc               randconfig-002-20251130    clang-16
powerpc64             randconfig-001-20251129    gcc-8.5.0
powerpc64             randconfig-001-20251130    gcc-14.3.0
powerpc64             randconfig-002-20251129    gcc-13.4.0
powerpc64             randconfig-002-20251130    gcc-14.3.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20251129    gcc-8.5.0
riscv                          randconfig-002    clang-22
riscv                 randconfig-002-20251129    gcc-11.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                           randconfig-001    gcc-11.5.0
s390                           randconfig-002    clang-22
s390                  randconfig-002-20251129    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                             randconfig-001    gcc-15.1.0
sh                    randconfig-001-20251129    gcc-12.5.0
sh                             randconfig-002    gcc-14.3.0
sh                    randconfig-002-20251129    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                randconfig-011-20251129    gcc-14
x86_64                randconfig-012-20251129    gcc-14
x86_64                randconfig-013-20251129    gcc-14
x86_64                randconfig-014-20251129    clang-20
x86_64                randconfig-015-20251129    gcc-12
x86_64                randconfig-016-20251129    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

