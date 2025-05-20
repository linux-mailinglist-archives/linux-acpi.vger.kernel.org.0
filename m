Return-Path: <linux-acpi+bounces-13826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC73DABDA01
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C8E3BD196
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978AF242D93;
	Tue, 20 May 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cx+J2GuH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226024394B;
	Tue, 20 May 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749167; cv=none; b=p5qmdjmJ1VDYpBhd66Xc2yWtD4QEghwacQ9sI7zIAITqLy2AecN57mF5eBEcE/asmYRuhdzfkcZglEbXWJEFllO4ck19KptdSm2okqMXH+pHPAcim/eSFBUydi7ThWtor6cZ3JYTBSEe2brtCABvW7Q7ceRLSW4pKDlOLSyKCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749167; c=relaxed/simple;
	bh=p1fp+Ks76sAjH6g3qcT8KBvJWtglmFskqOibnKGyx8k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pFvO9Oq4vtk74S70QKILXyLg2mdCE81rbgYfzeSprygHU3CQEqxASDOzqRKhkXa3ALBvuYVR4iSF4BszWkkfqWBdU2czKRaDRhr2QbNpzhqhxZksA93RBqVTJGBdlIHGKyv1YZQJEnAQVJvppExAyuaQFA5491yWF9Npg/xhsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cx+J2GuH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747749165; x=1779285165;
  h=date:from:to:cc:subject:message-id;
  bh=p1fp+Ks76sAjH6g3qcT8KBvJWtglmFskqOibnKGyx8k=;
  b=cx+J2GuHS2nrsmHzK3niv5GQjOp6vJt3G6UBHBNB/KBYnHeRIKcgO0xF
   MqfEsKBrh347mkakJsIVvcv1vSp04fUHElzixB1qxWafHcEnelgSkiie2
   OfbbRhy+taDcWoaJ37EeXkAUdu6tvN0OXkJQXVpHMWvqyAw0/F8yA/0tU
   6xVv8i+tLdkuw42pwGcqG6vzGkDdzmYpjeh7cpVT+RXGiysgPRMwJzpr8
   4C3WpEvSEOASqiiEs/iSjzPHg8dN2nspWE8wOt8gtAtWhpKUJZ8le4Lrr
   qBnZWubPr8I6rJ4q8qen1kC1Lg/Qi1qtF9SPQ0NMbe5hY8zHbM1O72pFk
   A==;
X-CSE-ConnectionGUID: wSG1b682QIymXx55godctg==
X-CSE-MsgGUID: MNIJBICPSseOxwz6o+5fsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49381422"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49381422"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 06:52:43 -0700
X-CSE-ConnectionGUID: 6raNHU9uTrOkSBsf9i4IQQ==
X-CSE-MsgGUID: jO89LYDeRbGATf0ZyuCRsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="170715745"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 06:52:41 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHNOZ-000Mdo-0d;
	Tue, 20 May 2025 13:52:39 +0000
Date: Tue, 20 May 2025 21:51:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 72740ce9e1da3c18cfd30fc2820bd89515016068
Message-ID: <202505202140.6TgM4PMa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 72740ce9e1da3c18cfd30fc2820bd89515016068  Merge branch 'linux-next' into bleeding-edge

elapsed time: 1102m

configs tested: 173
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250520    gcc-11.5.0
arc                   randconfig-001-20250520    gcc-8.5.0
arc                   randconfig-002-20250520    gcc-14.2.0
arc                   randconfig-002-20250520    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-18
arm                   milbeaut_m10v_defconfig    clang-19
arm                   randconfig-001-20250520    gcc-6.5.0
arm                   randconfig-001-20250520    gcc-8.5.0
arm                   randconfig-002-20250520    gcc-10.5.0
arm                   randconfig-002-20250520    gcc-8.5.0
arm                   randconfig-003-20250520    clang-19
arm                   randconfig-003-20250520    gcc-8.5.0
arm                   randconfig-004-20250520    gcc-7.5.0
arm                   randconfig-004-20250520    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250520    clang-21
arm64                 randconfig-001-20250520    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-9.5.0
arm64                 randconfig-003-20250520    clang-18
arm64                 randconfig-003-20250520    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250520    gcc-14.2.0
csky                  randconfig-002-20250520    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250520    clang-21
hexagon               randconfig-002-20250520    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250520    gcc-12
i386        buildonly-randconfig-002-20250520    gcc-12
i386        buildonly-randconfig-003-20250520    clang-20
i386        buildonly-randconfig-003-20250520    gcc-12
i386        buildonly-randconfig-004-20250520    gcc-12
i386        buildonly-randconfig-005-20250520    clang-20
i386        buildonly-randconfig-005-20250520    gcc-12
i386        buildonly-randconfig-006-20250520    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250520    gcc-12
i386                  randconfig-002-20250520    gcc-12
i386                  randconfig-003-20250520    gcc-12
i386                  randconfig-004-20250520    gcc-12
i386                  randconfig-005-20250520    gcc-12
i386                  randconfig-006-20250520    gcc-12
i386                  randconfig-007-20250520    gcc-12
i386                  randconfig-011-20250520    gcc-12
i386                  randconfig-012-20250520    gcc-12
i386                  randconfig-013-20250520    gcc-12
i386                  randconfig-014-20250520    gcc-12
i386                  randconfig-015-20250520    gcc-12
i386                  randconfig-016-20250520    gcc-12
i386                  randconfig-017-20250520    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-14.2.0
loongarch             randconfig-002-20250520    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250520    gcc-9.3.0
nios2                 randconfig-002-20250520    gcc-13.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250520    gcc-10.5.0
parisc                randconfig-002-20250520    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-19
powerpc                      pcm030_defconfig    clang-21
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250520    gcc-5.5.0
powerpc               randconfig-002-20250520    clang-17
powerpc               randconfig-003-20250520    gcc-7.5.0
powerpc64             randconfig-001-20250520    clang-21
powerpc64             randconfig-002-20250520    gcc-7.5.0
powerpc64             randconfig-003-20250520    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250520    gcc-12.4.0
riscv                 randconfig-001-20250520    gcc-9.3.0
riscv                 randconfig-002-20250520    clang-21
riscv                 randconfig-002-20250520    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250520    clang-21
s390                  randconfig-001-20250520    gcc-12.4.0
s390                  randconfig-002-20250520    clang-21
s390                  randconfig-002-20250520    gcc-12.4.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                    randconfig-001-20250520    gcc-12.4.0
sh                    randconfig-001-20250520    gcc-9.3.0
sh                    randconfig-002-20250520    gcc-12.4.0
sh                    randconfig-002-20250520    gcc-9.3.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250520    gcc-12.4.0
sparc                 randconfig-001-20250520    gcc-8.5.0
sparc                 randconfig-002-20250520    gcc-12.4.0
sparc64               randconfig-001-20250520    gcc-12.4.0
sparc64               randconfig-001-20250520    gcc-8.5.0
sparc64               randconfig-002-20250520    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250520    clang-21
um                    randconfig-001-20250520    gcc-12.4.0
um                    randconfig-002-20250520    clang-21
um                    randconfig-002-20250520    gcc-12.4.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250520    gcc-12
x86_64      buildonly-randconfig-002-20250520    gcc-12
x86_64      buildonly-randconfig-003-20250520    gcc-12
x86_64      buildonly-randconfig-004-20250520    gcc-12
x86_64      buildonly-randconfig-005-20250520    gcc-12
x86_64      buildonly-randconfig-006-20250520    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250520    gcc-12
x86_64                randconfig-002-20250520    gcc-12
x86_64                randconfig-003-20250520    gcc-12
x86_64                randconfig-004-20250520    gcc-12
x86_64                randconfig-005-20250520    gcc-12
x86_64                randconfig-006-20250520    gcc-12
x86_64                randconfig-007-20250520    gcc-12
x86_64                randconfig-008-20250520    gcc-12
x86_64                randconfig-071-20250520    gcc-12
x86_64                randconfig-072-20250520    gcc-12
x86_64                randconfig-073-20250520    gcc-12
x86_64                randconfig-074-20250520    gcc-12
x86_64                randconfig-075-20250520    gcc-12
x86_64                randconfig-076-20250520    gcc-12
x86_64                randconfig-077-20250520    gcc-12
x86_64                randconfig-078-20250520    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250520    gcc-12.4.0
xtensa                randconfig-001-20250520    gcc-6.5.0
xtensa                randconfig-002-20250520    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

