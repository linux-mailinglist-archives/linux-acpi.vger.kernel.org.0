Return-Path: <linux-acpi+bounces-20792-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNRODWG1fWlOTQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20792-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 08:55:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 707C9C1287
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 08:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0C4E300BDB4
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0022EDD4D;
	Sat, 31 Jan 2026 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2w7oR2K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4A28B4FD;
	Sat, 31 Jan 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769846098; cv=none; b=RqrDDi1UNJBfBARpXVXZxFd59QBu1xr5RPdh/iSJkhY579wJknia0NvIRtzPlnVO8dRQ1oeOppZWdCJcLMlauUeocGBKwnCWJFNTI0GgTDVoymD+wNy8ItcPlQ0sc/w1xmdPq2em0szvjJ0DetfOiD8D0Rogpt3SpAIDPRqRwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769846098; c=relaxed/simple;
	bh=fNAZejsGbFsi4Wd15/kqM/iZA+FLvlB7Xi/1ja+b58g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AIQylbYNBZhBDmYsgt3rl+ld2VyY1/iE40czAmMtvhrqXdwT7DsY3UieqcxvgoV8T0NsXjGPGUeRKpluiE414xwLV60KRujyjIatMfYgiyRXwrl0WvM3+i7XjxSEeVoIrw6/pAQTgnG6Wci0DXsu/jIEKIG1KknamPfHVI8WUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2w7oR2K; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769846096; x=1801382096;
  h=date:from:to:cc:subject:message-id;
  bh=fNAZejsGbFsi4Wd15/kqM/iZA+FLvlB7Xi/1ja+b58g=;
  b=g2w7oR2KV1/+7fJtTovDgVrj7r3CAiZxpx/OnDsh8cffS8rT/kgtriZR
   GsvUhwK2IAJ0noe9PHVI57qfgJEa8nfAYdw9rLYw+bKpEB4DAYJ5bNSWZ
   snK/jNLME0pJHwh7K+symTkJLmOt9ESDsPm3NQOsLfr5tyvBg7wJkJ81J
   l9eRVH2O19yV1e8jRhV53W4hw/HptXgytGmgr1rYo9usegGFCNhWcgeu9
   SWhy6UCd1G4PNzq78YoAnj/BolvpE+QTf2+88fwDvnGLFFT0oA5AQQDOh
   sG2fie8c1fo4pLVXHLLzLz35+0+55a1B1RBYwgxtTvMgZArWAEaLeEhj0
   Q==;
X-CSE-ConnectionGUID: B1xipiOhSZ6nxFfm6/bYEQ==
X-CSE-MsgGUID: cYN9qjI2RJixB4r6dDEd6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71249021"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71249021"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 23:54:56 -0800
X-CSE-ConnectionGUID: gqvc/8HFT7mUTwXoJbK8AQ==
X-CSE-MsgGUID: TRLKDDsnQ3WokloZ9c6EBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="209029937"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Jan 2026 23:54:55 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vm5oi-00000000dni-1vIt;
	Sat, 31 Jan 2026 07:54:52 +0000
Date: Sat, 31 Jan 2026 15:54:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c0be52333b2b518d73c77408cee2822c1e50f13c
Message-ID: <202601311508.TKd4Pe93-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20792-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 707C9C1287
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c0be52333b2b518d73c77408cee2822c1e50f13c  Merge branch 'pm-em' into bleeding-edge

elapsed time: 721m

configs tested: 185
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    gcc-14
arc                   randconfig-001-20260131    gcc-8.5.0
arc                   randconfig-002-20260131    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                       aspeed_g4_defconfig    gcc-15.2.0
arm                         bcm2835_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            hisi_defconfig    gcc-14
arm                   randconfig-001-20260131    gcc-8.5.0
arm                   randconfig-002-20260131    gcc-8.5.0
arm                   randconfig-003-20260131    gcc-8.5.0
arm                   randconfig-004-20260131    gcc-8.5.0
arm                         vf610m4_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260131    clang-22
arm64                 randconfig-002-20260131    clang-22
arm64                 randconfig-003-20260131    clang-22
arm64                 randconfig-004-20260131    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260131    clang-22
csky                  randconfig-002-20260131    clang-22
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260131    gcc-11.5.0
hexagon               randconfig-002-20260131    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260131    clang-20
i386        buildonly-randconfig-002-20260131    clang-20
i386        buildonly-randconfig-003-20260131    clang-20
i386        buildonly-randconfig-004-20260131    clang-20
i386        buildonly-randconfig-005-20260131    clang-20
i386        buildonly-randconfig-006-20260131    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260131    gcc-14
i386                  randconfig-002-20260131    gcc-14
i386                  randconfig-003-20260131    gcc-14
i386                  randconfig-004-20260131    gcc-14
i386                  randconfig-005-20260131    gcc-14
i386                  randconfig-006-20260131    gcc-14
i386                  randconfig-007-20260131    gcc-14
i386                  randconfig-011-20260131    gcc-14
i386                  randconfig-012-20260131    gcc-14
i386                  randconfig-013-20260131    gcc-14
i386                  randconfig-014-20260131    gcc-14
i386                  randconfig-015-20260131    gcc-14
i386                  randconfig-016-20260131    gcc-14
i386                  randconfig-017-20260131    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260131    gcc-11.5.0
loongarch             randconfig-002-20260131    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-14
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      loongson1_defconfig    gcc-14
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260131    gcc-11.5.0
nios2                 randconfig-002-20260131    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260131    gcc-8.5.0
parisc                randconfig-002-20260131    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                 mpc8313_rdb_defconfig    gcc-15.2.0
powerpc                     mpc83xx_defconfig    gcc-15.2.0
powerpc                      pmac32_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260131    gcc-8.5.0
powerpc               randconfig-002-20260131    gcc-8.5.0
powerpc                      tqm8xx_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260131    gcc-8.5.0
powerpc64             randconfig-002-20260131    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260131    gcc-8.5.0
riscv                 randconfig-002-20260131    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260131    gcc-8.5.0
s390                  randconfig-002-20260131    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260131    gcc-8.5.0
sh                    randconfig-002-20260131    gcc-8.5.0
sh                           se7750_defconfig    gcc-14
sh                   sh7770_generic_defconfig    gcc-14
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260131    gcc-14
sparc                 randconfig-002-20260131    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260131    gcc-14
sparc64               randconfig-002-20260131    gcc-14
um                               alldefconfig    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260131    gcc-14
um                    randconfig-002-20260131    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260131    gcc-14
x86_64      buildonly-randconfig-002-20260131    gcc-14
x86_64      buildonly-randconfig-003-20260131    gcc-14
x86_64      buildonly-randconfig-004-20260131    gcc-14
x86_64      buildonly-randconfig-005-20260131    gcc-14
x86_64      buildonly-randconfig-006-20260131    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260131    clang-20
x86_64                randconfig-002-20260131    clang-20
x86_64                randconfig-003-20260131    clang-20
x86_64                randconfig-004-20260131    clang-20
x86_64                randconfig-005-20260131    clang-20
x86_64                randconfig-006-20260131    clang-20
x86_64                randconfig-011-20260131    clang-20
x86_64                randconfig-012-20260131    clang-20
x86_64                randconfig-013-20260131    clang-20
x86_64                randconfig-014-20260131    clang-20
x86_64                randconfig-015-20260131    clang-20
x86_64                randconfig-016-20260131    clang-20
x86_64                randconfig-071-20260131    gcc-14
x86_64                randconfig-072-20260131    gcc-14
x86_64                randconfig-073-20260131    gcc-14
x86_64                randconfig-074-20260131    gcc-14
x86_64                randconfig-075-20260131    gcc-14
x86_64                randconfig-076-20260131    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260131    gcc-14
xtensa                randconfig-002-20260131    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

