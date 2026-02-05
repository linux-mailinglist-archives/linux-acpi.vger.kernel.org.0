Return-Path: <linux-acpi+bounces-20863-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMj5BrJghGny2gMAu9opvQ
	(envelope-from <linux-acpi+bounces-20863-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 10:19:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA8F0859
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 10:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3084302B23B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B238BF89;
	Thu,  5 Feb 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMvihA9b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5A38B98D;
	Thu,  5 Feb 2026 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282903; cv=none; b=W4fD3BW1bMmuoHZHa6NbsYdhhtnS9bFjQQbte/VDtpjSZKm/tw845BlR0r15rurnCX8JgxezcuBEsKTslTpedIIgy2TcQ86KBKC8UV2rt7RX1yUTju1BVR8auUdZBXQl0a8GgVVIBGUOgTitSLBNKxwXfNJwCKayLp/CTTREXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282903; c=relaxed/simple;
	bh=OFbzOngjzMnAN9Xcajy/8Jh5FmGtJAZtg5JWLPi+hxY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sdYSkbb/6kQNLA4zxmb1a8KRuRUDnllx4AQbzKY+xagmILN8kg0uQJKi07gVE5p34FoUpVQlzFZBwGib2AH2p5CgHmg2sQ+U3oymT5UQ/lmVJdQKFnGJTyjesGe8MDRrWLxGlKdmZalat8ol3MMkL6VMzuxy4u5ciwEc1/kSxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMvihA9b; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770282903; x=1801818903;
  h=date:from:to:cc:subject:message-id;
  bh=OFbzOngjzMnAN9Xcajy/8Jh5FmGtJAZtg5JWLPi+hxY=;
  b=BMvihA9bhe19BEG738U3nyPnOtCvNUfWSoOh2HhLWEnL1yMGg51F1Dtb
   own4sfgrm5OOsTTiEgTykgg+Nl9oL7RPj7CmCctb2kZjecKA1NLg6KbSH
   EO/YrrCSS3GV3UHEerH4CdgHJ9AG6tSM/HYiQ3p3AjogxSi7Tn0u3/S0A
   dZYr7ygWadRzQN5SuNoEjr9P/1zGj7I+ylQWb6g8ndwNq8oQ87rYroGlv
   hrExQ0iOeVmbKj6RgvxWmfjlR38EXQZ1F2KzWoY07Z9ZUOw+arf5YpXge
   9rTb36oqR05UW5NkgCJzWXKqr2E95Ty6gtmqTdzZzQMv4IVHlwdN6DCGM
   w==;
X-CSE-ConnectionGUID: vly3jkNtTV22Afj2SeQKew==
X-CSE-MsgGUID: Z2JTlZ0+RhSA92aUOHp37A==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71376743"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71376743"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:15:03 -0800
X-CSE-ConnectionGUID: 7YMlevMzSL2ICDYQVSuMHQ==
X-CSE-MsgGUID: PxFYtggAR2iAlX9PCOqlAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="209548474"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Feb 2026 01:15:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnvRx-00000000jf6-3dMd;
	Thu, 05 Feb 2026 09:14:57 +0000
Date: Thu, 05 Feb 2026 17:14:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 520775612d60d24e626d80747926e7978fda86b2
Message-ID: <202602051746.ZHFbC4Bm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20863-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 83EA8F0859
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 520775612d60d24e626d80747926e7978fda86b2  Merge branch 'pm-runtime-cleanup' into bleeding-edge

elapsed time: 1222m

configs tested: 321
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    clang-18
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260204    gcc-8.5.0
arc                   randconfig-001-20260205    gcc-8.5.0
arc                   randconfig-002-20260204    gcc-8.5.0
arc                   randconfig-002-20260205    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                       aspeed_g4_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           imxrt_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                          pxa168_defconfig    gcc-15.2.0
arm                            qcom_defconfig    gcc-15.2.0
arm                   randconfig-001-20260204    gcc-8.5.0
arm                   randconfig-001-20260205    gcc-8.5.0
arm                   randconfig-002-20260204    gcc-8.5.0
arm                   randconfig-002-20260205    gcc-8.5.0
arm                   randconfig-003-20260204    gcc-8.5.0
arm                   randconfig-003-20260205    gcc-8.5.0
arm                   randconfig-004-20260204    gcc-8.5.0
arm                   randconfig-004-20260205    gcc-8.5.0
arm                             rpc_defconfig    gcc-15.2.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           sunxi_defconfig    gcc-15.2.0
arm                        vexpress_defconfig    gcc-15.2.0
arm64                            alldefconfig    gcc-14
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260204    gcc-11.5.0
arm64                 randconfig-001-20260205    gcc-10.5.0
arm64                 randconfig-002-20260204    gcc-11.5.0
arm64                 randconfig-002-20260205    gcc-10.5.0
arm64                 randconfig-003-20260204    gcc-11.5.0
arm64                 randconfig-003-20260205    gcc-10.5.0
arm64                 randconfig-004-20260204    gcc-11.5.0
arm64                 randconfig-004-20260205    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260204    gcc-11.5.0
csky                  randconfig-001-20260205    gcc-10.5.0
csky                  randconfig-002-20260204    gcc-11.5.0
csky                  randconfig-002-20260205    gcc-10.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260204    gcc-15.2.0
hexagon               randconfig-001-20260205    gcc-15.2.0
hexagon               randconfig-002-20260204    gcc-15.2.0
hexagon               randconfig-002-20260205    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260204    gcc-14
i386        buildonly-randconfig-001-20260205    gcc-14
i386        buildonly-randconfig-002-20260204    gcc-14
i386        buildonly-randconfig-002-20260205    gcc-14
i386        buildonly-randconfig-003-20260204    gcc-14
i386        buildonly-randconfig-003-20260205    gcc-14
i386        buildonly-randconfig-004-20260204    gcc-14
i386        buildonly-randconfig-004-20260205    gcc-14
i386        buildonly-randconfig-005-20260204    gcc-14
i386        buildonly-randconfig-005-20260205    gcc-14
i386        buildonly-randconfig-006-20260204    gcc-14
i386        buildonly-randconfig-006-20260205    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260204    gcc-14
i386                  randconfig-001-20260205    gcc-13
i386                  randconfig-002-20260204    gcc-14
i386                  randconfig-002-20260205    gcc-13
i386                  randconfig-003-20260204    gcc-14
i386                  randconfig-003-20260205    gcc-13
i386                  randconfig-004-20260204    gcc-14
i386                  randconfig-004-20260205    gcc-13
i386                  randconfig-005-20260204    gcc-14
i386                  randconfig-005-20260205    gcc-13
i386                  randconfig-006-20260204    gcc-14
i386                  randconfig-006-20260205    gcc-13
i386                  randconfig-007-20260204    gcc-14
i386                  randconfig-007-20260205    gcc-13
i386                  randconfig-011-20260204    clang-20
i386                  randconfig-011-20260205    clang-20
i386                  randconfig-012-20260204    clang-20
i386                  randconfig-012-20260205    clang-20
i386                  randconfig-013-20260204    clang-20
i386                  randconfig-013-20260205    clang-20
i386                  randconfig-014-20260204    clang-20
i386                  randconfig-014-20260205    clang-20
i386                  randconfig-015-20260204    clang-20
i386                  randconfig-015-20260205    clang-20
i386                  randconfig-016-20260204    clang-20
i386                  randconfig-016-20260205    clang-20
i386                  randconfig-017-20260204    clang-20
i386                  randconfig-017-20260205    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260204    gcc-15.2.0
loongarch             randconfig-001-20260205    gcc-15.2.0
loongarch             randconfig-002-20260204    gcc-15.2.0
loongarch             randconfig-002-20260205    gcc-15.2.0
m68k                             alldefconfig    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         amcore_defconfig    clang-18
m68k                                defconfig    clang-19
m68k                        m5307c3_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-14
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-14
mips                         db1xxx_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                          eyeq6_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
mips                           ip22_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-14
mips                     loongson2k_defconfig    clang-18
mips                      loongson3_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-14
mips                      malta_kvm_defconfig    gcc-15.2.0
mips                      pic32mzda_defconfig    clang-18
mips                         rt305x_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260204    gcc-15.2.0
nios2                 randconfig-001-20260205    gcc-15.2.0
nios2                 randconfig-002-20260204    gcc-15.2.0
nios2                 randconfig-002-20260205    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260204    gcc-8.5.0
parisc                randconfig-001-20260205    gcc-9.5.0
parisc                randconfig-002-20260204    gcc-8.5.0
parisc                randconfig-002-20260205    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    gcc-14
powerpc                   lite5200b_defconfig    gcc-14
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc                     mpc512x_defconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    gcc-15.2.0
powerpc                      ppc44x_defconfig    gcc-15.2.0
powerpc                       ppc64_defconfig    gcc-15.2.0
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260204    gcc-8.5.0
powerpc               randconfig-001-20260205    gcc-9.5.0
powerpc               randconfig-002-20260204    gcc-8.5.0
powerpc               randconfig-002-20260205    gcc-9.5.0
powerpc                     tqm8548_defconfig    gcc-15.2.0
powerpc                         wii_defconfig    gcc-15.2.0
powerpc64                        alldefconfig    clang-18
powerpc64             randconfig-001-20260204    gcc-8.5.0
powerpc64             randconfig-001-20260205    gcc-9.5.0
powerpc64             randconfig-002-20260204    gcc-8.5.0
powerpc64             randconfig-002-20260205    gcc-9.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260204    gcc-8.5.0
riscv                 randconfig-001-20260205    clang-19
riscv                 randconfig-002-20260204    gcc-8.5.0
riscv                 randconfig-002-20260205    clang-19
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260204    gcc-8.5.0
s390                  randconfig-001-20260205    clang-19
s390                  randconfig-002-20260204    gcc-8.5.0
s390                  randconfig-002-20260205    clang-19
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    clang-18
sh                    randconfig-001-20260204    gcc-8.5.0
sh                    randconfig-001-20260205    clang-19
sh                    randconfig-002-20260204    gcc-8.5.0
sh                    randconfig-002-20260205    clang-19
sh                          rsk7201_defconfig    gcc-15.2.0
sh                   secureedge5410_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                             shx3_defconfig    clang-18
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260204    gcc-8.5.0
sparc                 randconfig-001-20260205    gcc-12.5.0
sparc                 randconfig-002-20260204    gcc-8.5.0
sparc                 randconfig-002-20260205    gcc-12.5.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260204    gcc-8.5.0
sparc64               randconfig-001-20260205    gcc-12.5.0
sparc64               randconfig-002-20260204    gcc-8.5.0
sparc64               randconfig-002-20260205    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-15.2.0
um                    randconfig-001-20260204    gcc-8.5.0
um                    randconfig-001-20260205    gcc-12.5.0
um                    randconfig-002-20260204    gcc-8.5.0
um                    randconfig-002-20260205    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260204    clang-20
x86_64      buildonly-randconfig-001-20260205    gcc-14
x86_64      buildonly-randconfig-002-20260204    clang-20
x86_64      buildonly-randconfig-002-20260205    gcc-14
x86_64      buildonly-randconfig-003-20260204    clang-20
x86_64      buildonly-randconfig-003-20260205    gcc-14
x86_64      buildonly-randconfig-004-20260204    clang-20
x86_64      buildonly-randconfig-004-20260205    gcc-14
x86_64      buildonly-randconfig-005-20260204    clang-20
x86_64      buildonly-randconfig-005-20260205    gcc-14
x86_64      buildonly-randconfig-006-20260204    clang-20
x86_64      buildonly-randconfig-006-20260205    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260204    gcc-14
x86_64                randconfig-001-20260205    clang-20
x86_64                randconfig-002-20260204    gcc-14
x86_64                randconfig-002-20260205    clang-20
x86_64                randconfig-003-20260204    gcc-14
x86_64                randconfig-003-20260205    clang-20
x86_64                randconfig-004-20260204    gcc-14
x86_64                randconfig-004-20260205    clang-20
x86_64                randconfig-005-20260204    gcc-14
x86_64                randconfig-005-20260205    clang-20
x86_64                randconfig-006-20260204    gcc-14
x86_64                randconfig-006-20260205    clang-20
x86_64                randconfig-011-20260204    clang-20
x86_64                randconfig-011-20260205    clang-20
x86_64                randconfig-012-20260204    clang-20
x86_64                randconfig-012-20260205    clang-20
x86_64                randconfig-013-20260204    clang-20
x86_64                randconfig-013-20260205    clang-20
x86_64                randconfig-014-20260204    clang-20
x86_64                randconfig-014-20260205    clang-20
x86_64                randconfig-015-20260204    clang-20
x86_64                randconfig-015-20260205    clang-20
x86_64                randconfig-016-20260204    clang-20
x86_64                randconfig-016-20260205    clang-20
x86_64                randconfig-071-20260204    gcc-14
x86_64                randconfig-071-20260205    clang-20
x86_64                randconfig-072-20260204    gcc-14
x86_64                randconfig-072-20260205    clang-20
x86_64                randconfig-073-20260204    gcc-14
x86_64                randconfig-073-20260205    clang-20
x86_64                randconfig-074-20260204    gcc-14
x86_64                randconfig-074-20260205    clang-20
x86_64                randconfig-075-20260204    gcc-14
x86_64                randconfig-075-20260205    clang-20
x86_64                randconfig-076-20260204    gcc-14
x86_64                randconfig-076-20260205    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260204    gcc-8.5.0
xtensa                randconfig-001-20260205    gcc-12.5.0
xtensa                randconfig-002-20260204    gcc-8.5.0
xtensa                randconfig-002-20260205    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

