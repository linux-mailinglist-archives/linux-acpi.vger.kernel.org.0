Return-Path: <linux-acpi+bounces-19628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E38CC7C00
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 14:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B838304F679
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA034C13B;
	Wed, 17 Dec 2025 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpDTLyEU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7434BA54;
	Wed, 17 Dec 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975120; cv=none; b=bFg5xdb0CGM2uFKeiBogf4fBhaErFkT6hL7KdTXzQTHX3w8oWHbMeDL1LgDtts0/t0EbiHH/3vXF5gJy8iJj5pBCTih6cpfKOMO4HFTpTOq8EDC0PhKqXKdWQTe3AdIVajTLp+idJChjvqKdbgBaXZZ35S9czurqKRjfgMyqddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975120; c=relaxed/simple;
	bh=eeUnqeI6tLQv+2V0Y1miyui0jNaQQlncVAbnq6o2Kmk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TFUuifiDreclvO9TTmz+5jP/UZszaQYM9uaz9hSKWbFFc/H9V19M0Y0ocE3qo34eX0JryiPVScgmv0sxy+BcAk5yrRRtc1i31pxKaCyGLRDDjn/+ZaPRGdhFD0tCpfvxzy+SWx8zvWZssbHhRM4bQhPpZeI8Y/DVwWtnQBByLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpDTLyEU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765975119; x=1797511119;
  h=date:from:to:cc:subject:message-id;
  bh=eeUnqeI6tLQv+2V0Y1miyui0jNaQQlncVAbnq6o2Kmk=;
  b=CpDTLyEU8EC51kwW7MUSK0Wp6HYUUFnWuf6XbaLvO6KuCF7J1TLBm7zk
   BfSSTBfL7K+USKMt0uINLT1HjLLJBLcLDziyxX3esNs8vwLEym76kJzyE
   kBHCiuvQuNGZbTE/ob45O0al4dYsd869ot6ZdoB9NM5LtCkz5iY57juZl
   yjiSlybI4lyK0j7gjUavIu502zwvwJ8C8eyO8xjFJ3A+F5WfeHeYbEQ87
   sfjDPPUN1+C8vV7oZ3dwYF3RykqZnxPoMXkGIDCHbIchU2MSeyWbAddYZ
   LqBC3U1GB1k2hpRtVaCA480oayPlbqS7EF2KWXltHQTx0DsYwSk7fA4yu
   Q==;
X-CSE-ConnectionGUID: 6Epx+DJBSFS9mSLvOfgFPQ==
X-CSE-MsgGUID: uGjfDQUYSE2dd/C+Zz373w==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67951383"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="67951383"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:38:38 -0800
X-CSE-ConnectionGUID: xLHlDevLTuKV9DzRj19iww==
X-CSE-MsgGUID: 2pYf90vgSjehZjhDeNJqYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="198548429"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Dec 2025 04:38:37 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVqnb-000000000Xd-0vVa;
	Wed, 17 Dec 2025 12:38:35 +0000
Date: Wed, 17 Dec 2025 20:37:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 58f624da50dfe607d0c90d062d9558130e97e763
Message-ID: <202512172045.GgV6ZBcX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 58f624da50dfe607d0c90d062d9558130e97e763  Merge branch 'pm-runtime' into fixes

elapsed time: 1449m

configs tested: 106
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251217    gcc-8.5.0
arc                   randconfig-002-20251217    gcc-10.5.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251217    clang-18
arm                   randconfig-002-20251217    clang-22
arm                   randconfig-003-20251217    clang-22
arm                   randconfig-004-20251217    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251217    gcc-8.5.0
arm64                 randconfig-002-20251217    clang-22
arm64                 randconfig-003-20251217    clang-22
arm64                 randconfig-004-20251217    clang-20
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251217    gcc-15.1.0
csky                  randconfig-002-20251217    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251217    clang-22
hexagon               randconfig-002-20251217    clang-22
i386                             allmodconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251217    clang-20
i386        buildonly-randconfig-002-20251217    gcc-14
i386        buildonly-randconfig-003-20251217    gcc-13
i386        buildonly-randconfig-004-20251217    clang-20
i386        buildonly-randconfig-005-20251217    gcc-14
i386        buildonly-randconfig-006-20251217    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251217    clang-20
i386                  randconfig-002-20251217    clang-20
i386                  randconfig-003-20251217    clang-20
i386                  randconfig-004-20251217    gcc-14
i386                  randconfig-005-20251217    gcc-13
i386                  randconfig-006-20251217    clang-20
i386                  randconfig-007-20251217    clang-20
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251217    clang-22
loongarch             randconfig-002-20251217    clang-22
m68k                                defconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
m68k                       m5475evb_defconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251217    gcc-11.5.0
nios2                 randconfig-002-20251217    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251217    gcc-15.1.0
parisc                randconfig-002-20251217    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    clang-22
powerpc               randconfig-001-20251217    gcc-8.5.0
powerpc               randconfig-002-20251217    clang-22
powerpc64             randconfig-001-20251217    gcc-14.3.0
powerpc64             randconfig-002-20251217    clang-18
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251217    gcc-14.3.0
riscv                 randconfig-002-20251217    clang-18
s390                                defconfig    clang-22
s390                  randconfig-001-20251217    gcc-10.5.0
s390                  randconfig-002-20251217    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20251217    gcc-15.1.0
sh                    randconfig-002-20251217    gcc-12.5.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251217    clang-20
x86_64      buildonly-randconfig-004-20251217    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251217    clang-20
x86_64                randconfig-002-20251217    gcc-14
x86_64                randconfig-003-20251217    clang-20
x86_64                randconfig-004-20251217    clang-20
x86_64                randconfig-005-20251217    clang-20
x86_64                randconfig-006-20251217    gcc-14
x86_64                randconfig-011-20251217    clang-20
x86_64                randconfig-012-20251217    gcc-14
x86_64                randconfig-013-20251217    clang-20
x86_64                randconfig-014-20251217    gcc-14
x86_64                randconfig-015-20251217    gcc-14
x86_64                randconfig-016-20251217    gcc-14
x86_64                randconfig-071-20251217    clang-20
x86_64                randconfig-072-20251217    gcc-13
x86_64                randconfig-073-20251217    gcc-14
x86_64                randconfig-074-20251217    clang-20
x86_64                randconfig-075-20251217    clang-20
x86_64                randconfig-076-20251217    gcc-14
x86_64                          rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

