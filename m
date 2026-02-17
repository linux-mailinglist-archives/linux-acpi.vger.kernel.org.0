Return-Path: <linux-acpi+bounces-21001-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id znFrOHIElGl7+gEAu9opvQ
	(envelope-from <linux-acpi+bounces-21001-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 07:02:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A80148ED2
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 07:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0BD30136A0
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Feb 2026 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F45221FC6;
	Tue, 17 Feb 2026 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNR8OQaj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB61C4A20;
	Tue, 17 Feb 2026 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771308144; cv=none; b=NFdFBd+0+b7G6W6TDZxjexpxMmzGprvjzMAoFXJGS79O0wKpFoxGLokrfXO1EQRJf4O+1r14rN7CUJ14iQwdrQwZFFFaYsnfKQsuDHyga0AKCkvNZfAykco4+24EC1gGl8wrCdP2Fl24iBegQixDpPhQ0AfrJX9C7KD+fpEAdR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771308144; c=relaxed/simple;
	bh=Xsh5TWeCe+WZtweuJc9ctiNuJ4zVq7GRhLOzUOypm4Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Aw/hcOL3gT73o26V8dlBacUrNlEUKMnjK2qYupHZsnEVrPwH/8Vyrj84zt8JjhiLLBtXc0nNg7QlYNNJREDc/IWRZ2LucwJh0I6q3aFyFmNad8JHRE+fF2hoi6rwJK6FkTfzMXDBgUAG047EpgCcJn0Ppv2bjt63tCaPUKJ9/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNR8OQaj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771308139; x=1802844139;
  h=date:from:to:cc:subject:message-id;
  bh=Xsh5TWeCe+WZtweuJc9ctiNuJ4zVq7GRhLOzUOypm4Y=;
  b=JNR8OQajr636GPSuIF9K0XDMaSocWBIy32dtXHvidBOenCBZ5K8H4Lk1
   Xi1MYv2q5lnjam6R1I8IbzCAD+AKaBmVDD0POfhnI1a1db2OCV2p8uxCt
   /VhQC8cDExDO2Giy/9EwVmVeqTRTyEWge50tEIhYnv/sdUwmn1ZMC5b6o
   5hoaytVz0ViGfrpKqocint6rwVdZktpbtFYa2LS4ShQ/qBABzv+Dc2AB5
   V9xF+TRBu7i2qj2yi8gaGFUaHkaTz4Ri9EbyxljurX4rifURRXQnnl+OA
   xtyxM49nBtJAtwOi9i1jWUziT0aS/dxQxZb10mFp68KXr4pr/d0dbGzcA
   g==;
X-CSE-ConnectionGUID: 8Gvs/Tq+SDafMtX0Vbz4yw==
X-CSE-MsgGUID: bXymMMsxQI6BdIpGXNWkNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="97835022"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="97835022"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 22:02:19 -0800
X-CSE-ConnectionGUID: GQVGnea+Tw2oB2mLQ41vMg==
X-CSE-MsgGUID: KRjezBeZTZC8ts9JOcvpZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213066979"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Feb 2026 22:02:18 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsEA4-000000010fY-1dBg;
	Tue, 17 Feb 2026 06:02:16 +0000
Date: Tue, 17 Feb 2026 14:01:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f6cf88db984f90f5828d4945b5bf9ef1980414a1
Message-ID: <202602171451.yWPcZYCY-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21001-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 32A80148ED2
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f6cf88db984f90f5828d4945b5bf9ef1980414a1  Merge branch 'acpi-pm' into bleeding-edge

elapsed time: 728m

configs tested: 224
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260217    gcc-11.5.0
arc                   randconfig-002-20260217    gcc-11.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    gcc-15.2.0
arm                         bcm2835_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                           h3600_defconfig    gcc-14
arm                       imx_v6_v7_defconfig    clang-23
arm                        keystone_defconfig    gcc-14
arm                            mps2_defconfig    clang-23
arm                        multi_v7_defconfig    clang-23
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260217    gcc-11.5.0
arm                   randconfig-002-20260217    gcc-11.5.0
arm                   randconfig-003-20260217    gcc-11.5.0
arm                   randconfig-004-20260217    gcc-11.5.0
arm                           sama5_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                           u8500_defconfig    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260217    clang-23
arm64                 randconfig-002-20260217    clang-23
arm64                 randconfig-003-20260217    clang-23
arm64                 randconfig-004-20260217    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260217    clang-23
csky                  randconfig-002-20260217    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260217    clang-23
hexagon               randconfig-002-20260217    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260217    clang-20
i386        buildonly-randconfig-002-20260217    clang-20
i386        buildonly-randconfig-003-20260217    clang-20
i386        buildonly-randconfig-004-20260217    clang-20
i386        buildonly-randconfig-005-20260217    clang-20
i386        buildonly-randconfig-006-20260217    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260217    gcc-14
i386                  randconfig-002-20260217    gcc-14
i386                  randconfig-003-20260217    gcc-14
i386                  randconfig-004-20260217    gcc-14
i386                  randconfig-005-20260217    gcc-14
i386                  randconfig-006-20260217    gcc-14
i386                  randconfig-007-20260217    gcc-14
i386                  randconfig-011-20260217    clang-20
i386                  randconfig-012-20260217    clang-20
i386                  randconfig-013-20260217    clang-20
i386                  randconfig-014-20260217    clang-20
i386                  randconfig-015-20260217    clang-20
i386                  randconfig-016-20260217    clang-20
i386                  randconfig-017-20260217    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260217    clang-23
loongarch             randconfig-002-20260217    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    clang-23
m68k                         apollo_defconfig    clang-23
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        m5307c3_defconfig    clang-23
m68k                        mvme16x_defconfig    gcc-15.2.0
m68k                           virt_defconfig    gcc-15.2.0
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath79_defconfig    gcc-14
mips                 decstation_r4k_defconfig    clang-23
mips                           gcw0_defconfig    clang-23
mips                           ip28_defconfig    gcc-15.2.0
mips                      malta_kvm_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-23
mips                        qi_lb60_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260217    clang-23
nios2                 randconfig-002-20260217    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260217    clang-19
parisc                randconfig-002-20260217    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-23
powerpc               randconfig-001-20260217    clang-19
powerpc               randconfig-002-20260217    clang-19
powerpc                     stx_gp3_defconfig    clang-23
powerpc                     tqm8555_defconfig    clang-23
powerpc                         wii_defconfig    clang-23
powerpc                 xes_mpc85xx_defconfig    clang-23
powerpc                 xes_mpc85xx_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260217    clang-19
powerpc64             randconfig-002-20260217    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-14
riscv                 randconfig-001-20260217    gcc-10.5.0
riscv                 randconfig-002-20260217    gcc-10.5.0
s390                             alldefconfig    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260217    gcc-10.5.0
s390                  randconfig-002-20260217    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                            hp6xx_defconfig    gcc-14
sh                    randconfig-001-20260217    gcc-10.5.0
sh                    randconfig-002-20260217    gcc-10.5.0
sh                          rsk7264_defconfig    gcc-14
sh                        sh7763rdp_defconfig    clang-23
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                          urquell_defconfig    gcc-15.2.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260217    gcc-12.5.0
sparc                 randconfig-002-20260217    gcc-12.5.0
sparc                       sparc64_defconfig    clang-23
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260217    gcc-12.5.0
sparc64               randconfig-002-20260217    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260217    gcc-12.5.0
um                    randconfig-002-20260217    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260217    gcc-14
x86_64      buildonly-randconfig-002-20260217    gcc-14
x86_64      buildonly-randconfig-003-20260217    gcc-14
x86_64      buildonly-randconfig-004-20260217    gcc-14
x86_64      buildonly-randconfig-005-20260217    gcc-14
x86_64      buildonly-randconfig-006-20260217    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260217    clang-20
x86_64                randconfig-002-20260217    clang-20
x86_64                randconfig-003-20260217    clang-20
x86_64                randconfig-004-20260217    clang-20
x86_64                randconfig-005-20260217    clang-20
x86_64                randconfig-006-20260217    clang-20
x86_64                randconfig-011-20260217    gcc-14
x86_64                randconfig-012-20260217    gcc-14
x86_64                randconfig-013-20260217    gcc-14
x86_64                randconfig-014-20260217    gcc-14
x86_64                randconfig-015-20260217    gcc-14
x86_64                randconfig-016-20260217    gcc-14
x86_64                randconfig-071-20260217    gcc-14
x86_64                randconfig-072-20260217    gcc-14
x86_64                randconfig-073-20260217    gcc-14
x86_64                randconfig-074-20260217    gcc-14
x86_64                randconfig-075-20260217    gcc-14
x86_64                randconfig-076-20260217    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                       common_defconfig    clang-23
xtensa                randconfig-001-20260217    gcc-12.5.0
xtensa                randconfig-002-20260217    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

