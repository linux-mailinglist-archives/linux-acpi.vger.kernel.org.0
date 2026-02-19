Return-Path: <linux-acpi+bounces-21013-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLQgNpzUlmmVowIAu9opvQ
	(envelope-from <linux-acpi+bounces-21013-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Feb 2026 10:15:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B5915D3F0
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Feb 2026 10:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97989301CCD5
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Feb 2026 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B4233970F;
	Thu, 19 Feb 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTvL4otu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCB2C08C8;
	Thu, 19 Feb 2026 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771492471; cv=none; b=q0PJgNs3EjeSN3gghFXWlkKXpUTcDo36n40MTovLVdGHjMmHMG6/tuUeez0mdGV8nm8zwjFxQtHseNLDn1V0ks8j6UFj8HNonh0II0UTVWWIrUjvz380SEvoWPmTqI+zUTF0Dihu64yM4m1NuVbCkNnpz/EsebFr8FEUMKYIeZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771492471; c=relaxed/simple;
	bh=xgb3XqiajFVk4oAYSm4PhcMStO7iZusYq4uOOMe6VWM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=R7qCvoEr7yHDqwdDHJTVJRm42Ud9z0QdrDiy+3GIP61FaqnrJyLDIqjlQ3F4lTVM9O75xEDnUrP4pX76OtZ2h7obGc1FSDqYCxOJ3Xdiu1FGFYs0+FirAhYPoFd0JoZvoY+UUyGq1oK24sLynEcJkNd+yY4Bt0w1TVBiVW5pDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTvL4otu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771492470; x=1803028470;
  h=date:from:to:cc:subject:message-id;
  bh=xgb3XqiajFVk4oAYSm4PhcMStO7iZusYq4uOOMe6VWM=;
  b=HTvL4otu2ETWwpVNTGJagVhy5XViYfgAJ4VrxJCQ7i6rtiU3zk3V+G3O
   wdMy+c4lw83szDFKE+ggIIHhyUolhhZRjZ6XenwGS5+wFbhLtJTQ3WWut
   6Gewq3EDjFXwXaZOCctq/es/28OIDjf4ltykt3nvcc3rujc7bKw/Q+z64
   VoNRVr8aW9XwyIZVdy3KwQHFBFQlwJJFOgo6hjZ2kfTii3bzaqu4K5+kP
   0IzjbHMmX0UW/tplKoEMDN9UVA1JrceCjWHIBHOxFTJAYzGaHvsTHfGLw
   nCqFUTjQ5B5A1GrcIKQ/VeMWX0Y6KUzy7V3yDMdjecMams0RBYmxKOxNb
   A==;
X-CSE-ConnectionGUID: nDPkNZgnQKCzNmIdc13+7Q==
X-CSE-MsgGUID: MzAVYSRtTx2kcr1IpBQYoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76435270"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="76435270"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:14:29 -0800
X-CSE-ConnectionGUID: vGmeC1pVSQ2muRgi42MuVg==
X-CSE-MsgGUID: TOh6TGd8SluAJICHaeuQOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="252170122"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Feb 2026 01:14:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vt077-0000000135U-0NAH;
	Thu, 19 Feb 2026 09:14:25 +0000
Date: Thu, 19 Feb 2026 17:14:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 54f6171f5031bbbbd6aa29d48e8b7200b442533a
Message-ID: <202602191710.YjKu9x9I-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21013-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83B5915D3F0
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 54f6171f5031bbbbd6aa29d48e8b7200b442533a  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 731m

configs tested: 239
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    clang-23
arc                   randconfig-001-20260219    clang-23
arc                   randconfig-002-20260219    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                        clps711x_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    clang-18
arm                       imx_v4_v5_defconfig    clang-18
arm                            mps2_defconfig    clang-23
arm                        multi_v5_defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    clang-18
arm                           omap1_defconfig    clang-23
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260219    clang-23
arm                   randconfig-002-20260219    clang-23
arm                   randconfig-003-20260219    clang-23
arm                   randconfig-004-20260219    clang-23
arm                         s5pv210_defconfig    gcc-15.2.0
arm                         vf610m4_defconfig    clang-23
arm64                            alldefconfig    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260219    gcc-8.5.0
arm64                 randconfig-002-20260219    gcc-8.5.0
arm64                 randconfig-003-20260219    gcc-8.5.0
arm64                 randconfig-004-20260219    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260219    gcc-8.5.0
csky                  randconfig-002-20260219    gcc-8.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260219    clang-17
hexagon               randconfig-002-20260219    clang-17
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260219    gcc-14
i386        buildonly-randconfig-002-20260219    gcc-14
i386        buildonly-randconfig-003-20260219    gcc-14
i386        buildonly-randconfig-004-20260219    gcc-14
i386        buildonly-randconfig-005-20260219    clang-20
i386        buildonly-randconfig-005-20260219    gcc-14
i386        buildonly-randconfig-006-20260219    clang-20
i386        buildonly-randconfig-006-20260219    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260219    gcc-14
i386                  randconfig-002-20260219    gcc-14
i386                  randconfig-003-20260219    gcc-14
i386                  randconfig-004-20260219    gcc-14
i386                  randconfig-005-20260219    gcc-14
i386                  randconfig-006-20260219    gcc-14
i386                  randconfig-007-20260219    gcc-14
i386                  randconfig-011-20260219    clang-20
i386                  randconfig-012-20260219    clang-20
i386                  randconfig-013-20260219    clang-20
i386                  randconfig-014-20260219    clang-20
i386                  randconfig-015-20260219    clang-20
i386                  randconfig-016-20260219    clang-20
i386                  randconfig-017-20260219    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260219    clang-17
loongarch             randconfig-002-20260219    clang-17
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                          amiga_defconfig    clang-23
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                       m5475evb_defconfig    gcc-15.2.0
m68k                          multi_defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-23
mips                         bigsur_defconfig    gcc-15.2.0
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                           ip22_defconfig    clang-23
mips                          malta_defconfig    clang-23
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260219    clang-17
nios2                 randconfig-002-20260219    clang-17
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    clang-23
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260219    clang-23
parisc                randconfig-002-20260219    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-23
powerpc                     ep8248e_defconfig    clang-23
powerpc                      ep88xc_defconfig    clang-18
powerpc                          g5_defconfig    clang-23
powerpc                  iss476-smp_defconfig    clang-18
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-23
powerpc                      ppc44x_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260219    clang-23
powerpc               randconfig-002-20260219    clang-23
powerpc                     tqm8541_defconfig    clang-23
powerpc64             randconfig-001-20260219    clang-23
powerpc64             randconfig-002-20260219    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    clang-23
riscv                 randconfig-001-20260219    clang-17
riscv                 randconfig-002-20260219    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260219    clang-17
s390                  randconfig-002-20260219    clang-17
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                 kfr2r09-romimage_defconfig    clang-23
sh                          lboxre2_defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260219    clang-17
sh                    randconfig-002-20260219    clang-17
sh                          rsk7264_defconfig    gcc-15.2.0
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7705_defconfig    clang-18
sh                            titan_defconfig    clang-18
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260219    gcc-8.5.0
sparc                 randconfig-002-20260219    gcc-8.5.0
sparc64                          alldefconfig    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260219    gcc-8.5.0
sparc64               randconfig-002-20260219    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260219    gcc-8.5.0
um                    randconfig-002-20260219    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260219    gcc-14
x86_64      buildonly-randconfig-002-20260219    gcc-14
x86_64      buildonly-randconfig-003-20260219    gcc-14
x86_64      buildonly-randconfig-004-20260219    gcc-14
x86_64      buildonly-randconfig-005-20260219    gcc-14
x86_64      buildonly-randconfig-006-20260219    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260219    clang-20
x86_64                randconfig-002-20260219    clang-20
x86_64                randconfig-003-20260219    clang-20
x86_64                randconfig-004-20260219    clang-20
x86_64                randconfig-005-20260219    clang-20
x86_64                randconfig-006-20260219    clang-20
x86_64                randconfig-011-20260219    gcc-14
x86_64                randconfig-012-20260219    gcc-14
x86_64                randconfig-013-20260219    gcc-14
x86_64                randconfig-014-20260219    gcc-14
x86_64                randconfig-015-20260219    gcc-14
x86_64                randconfig-016-20260219    gcc-14
x86_64                randconfig-071-20260219    gcc-14
x86_64                randconfig-072-20260219    gcc-14
x86_64                randconfig-073-20260219    gcc-14
x86_64                randconfig-074-20260219    gcc-14
x86_64                randconfig-075-20260219    gcc-14
x86_64                randconfig-076-20260219    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260219    gcc-8.5.0
xtensa                randconfig-002-20260219    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

