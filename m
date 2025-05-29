Return-Path: <linux-acpi+bounces-13923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A3DAC79D2
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 09:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89643A6DA2
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BD1386DA;
	Thu, 29 May 2025 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6yoa/w1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342A2DCBE6;
	Thu, 29 May 2025 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748503906; cv=none; b=t7IP8/eac4OMU210t9r9n7B8Mm1zdZiVmtvYtrXdfemNydGjNavBM1RUAMFwOLKvrUq4km8Hw57ds8OkbGqc7jx1C0fgv5uQw9RxhaFQH8TJZ+6AdM8GQs0CK4/qp3KS9fjjgcKHr/CCQWYZ96yNnVfSVuF3BNamsS9CzssiqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748503906; c=relaxed/simple;
	bh=BmpTxAwkPDoypxd4eN/wqZL67FUYMr2NQp11HiGVh2E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gupZR2YcNX7WTuAcX762590R7mdZFdCm3bpWJ/Wlq7If7e6XLHp4ek/KWL68XA5YaWzVV/V4yvo45kv5b6vwAxXx7C0P9Kr8Th2jMnEs8+ep63ar1uHGzK0jLtc7lFAOhWZUfCuLICp6sNgD7qfcA2VqFjhtgBRZDI/EGYUGJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6yoa/w1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748503905; x=1780039905;
  h=date:from:to:cc:subject:message-id;
  bh=BmpTxAwkPDoypxd4eN/wqZL67FUYMr2NQp11HiGVh2E=;
  b=W6yoa/w1o9RVQCF6DnNl34R7E+K+f7vIl0qZepY3zpe4Gk/K6uOAI1WF
   L2FODhqqxpFX5JfXEiCOMG5uqleNhs8CETqn2VBEYwsHB/8MNX2c5XY9Q
   0teMklhAHHIRvJqNTMrdXa/ZPfM+ZSAj83bpef/tsHixwHj8ZFABdCYai
   PM6skHYq/0RQNdO+i8vuESkkfM3UF1yaCA2Z1vTOOIdbMOjOnVzvobDGG
   SfLx7Yh8lZsljVA9j2Yh9BuhDMgglXeqkchmRhi8Z8MwaiKJ0AyZcWuT3
   mroT1neyrtSOtN0hFqXCRAFE4HfjQtDmdhRHqvvi/megvOHg1jx95iXjq
   Q==;
X-CSE-ConnectionGUID: qRLJV2sfR6Cl1VmgW48lmw==
X-CSE-MsgGUID: w137TlxjSPatAGzk+jbquQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50478677"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="50478677"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 00:31:44 -0700
X-CSE-ConnectionGUID: OCzeX7KXTx+vXzjGvLLxZg==
X-CSE-MsgGUID: VsE4SDp7TtSLsIWFt/MgNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="180681149"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 May 2025 00:31:42 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKXjo-000WRA-1z;
	Thu, 29 May 2025 07:31:40 +0000
Date: Thu, 29 May 2025 15:31:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 1d91abb8433c448e8e493c4e175968c1e6585934
Message-ID: <202505291516.fNFeSlMT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 1d91abb8433c448e8e493c4e175968c1e6585934  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 1116m

configs tested: 121
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.3.0
alpha                            allyesconfig    gcc-14.3.0
arc                              allmodconfig    gcc-14.3.0
arc                               allnoconfig    gcc-14.3.0
arc                              allyesconfig    gcc-14.3.0
arc                 nsimosci_hs_smp_defconfig    gcc-14.3.0
arc                   randconfig-001-20250528    gcc-15.1.0
arc                   randconfig-002-20250528    gcc-13.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.3.0
arm                            dove_defconfig    gcc-14.3.0
arm                             pxa_defconfig    gcc-14.3.0
arm                   randconfig-001-20250528    clang-21
arm                   randconfig-002-20250528    clang-17
arm                   randconfig-003-20250528    clang-19
arm                   randconfig-004-20250528    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.3.0
arm64                 randconfig-001-20250528    gcc-9.5.0
arm64                 randconfig-002-20250528    gcc-7.5.0
arm64                 randconfig-003-20250528    gcc-7.5.0
arm64                 randconfig-004-20250528    gcc-9.5.0
csky                              allnoconfig    gcc-14.3.0
csky                                defconfig    gcc-14.3.0
csky                  randconfig-001-20250528    gcc-15.1.0
csky                  randconfig-002-20250528    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250528    clang-21
hexagon               randconfig-002-20250528    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250528    gcc-12
i386        buildonly-randconfig-002-20250528    clang-20
i386        buildonly-randconfig-003-20250528    clang-20
i386        buildonly-randconfig-004-20250528    clang-20
i386        buildonly-randconfig-005-20250528    gcc-12
i386        buildonly-randconfig-006-20250528    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.3.0
loongarch                         allnoconfig    gcc-14.3.0
loongarch             randconfig-001-20250528    gcc-15.1.0
loongarch             randconfig-002-20250528    gcc-13.3.0
m68k                             allmodconfig    gcc-14.3.0
m68k                              allnoconfig    gcc-14.3.0
m68k                             allyesconfig    gcc-14.3.0
microblaze                       allmodconfig    gcc-14.3.0
microblaze                        allnoconfig    gcc-14.3.0
microblaze                       allyesconfig    gcc-14.3.0
mips                              allnoconfig    gcc-14.3.0
mips                          eyeq6_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-14.3.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250528    gcc-13.3.0
nios2                 randconfig-002-20250528    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.3.0
openrisc                         allyesconfig    gcc-14.3.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-14.3.0
parisc                            allnoconfig    gcc-14.3.0
parisc                           allyesconfig    gcc-14.3.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250528    gcc-6.5.0
parisc                randconfig-002-20250528    gcc-14.3.0
powerpc                          allmodconfig    gcc-14.3.0
powerpc                           allnoconfig    gcc-14.3.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250528    clang-21
powerpc               randconfig-002-20250528    gcc-7.5.0
powerpc               randconfig-003-20250528    gcc-7.5.0
powerpc                     tqm8555_defconfig    gcc-14.3.0
powerpc64             randconfig-001-20250528    gcc-7.5.0
powerpc64             randconfig-002-20250528    clang-21
powerpc64             randconfig-003-20250528    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.3.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250528    gcc-9.3.0
riscv                 randconfig-002-20250528    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.3.0
s390                  randconfig-001-20250528    clang-21
s390                  randconfig-002-20250528    clang-21
sh                               allmodconfig    gcc-14.3.0
sh                                allnoconfig    gcc-14.3.0
sh                               allyesconfig    gcc-14.3.0
sh                        apsh4ad0a_defconfig    gcc-14.3.0
sh                    randconfig-001-20250528    gcc-9.3.0
sh                    randconfig-002-20250528    gcc-5.5.0
sh                        sh7785lcr_defconfig    gcc-14.3.0
sh                          urquell_defconfig    gcc-14.3.0
sparc                            allmodconfig    gcc-14.3.0
sparc                             allnoconfig    gcc-14.3.0
sparc                 randconfig-001-20250528    gcc-14.3.0
sparc                 randconfig-002-20250528    gcc-14.3.0
sparc64               randconfig-001-20250528    gcc-8.5.0
sparc64               randconfig-002-20250528    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250528    clang-21
um                    randconfig-002-20250528    gcc-11
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250528    clang-20
x86_64      buildonly-randconfig-002-20250528    clang-20
x86_64      buildonly-randconfig-003-20250528    gcc-12
x86_64      buildonly-randconfig-004-20250528    gcc-12
x86_64      buildonly-randconfig-005-20250528    gcc-12
x86_64      buildonly-randconfig-006-20250528    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.3.0
xtensa                generic_kc705_defconfig    gcc-14.3.0
xtensa                randconfig-001-20250528    gcc-14.3.0
xtensa                randconfig-002-20250528    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

