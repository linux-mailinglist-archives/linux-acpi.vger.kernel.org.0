Return-Path: <linux-acpi+bounces-20994-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJVUG5IBk2lr0wEAu9opvQ
	(envelope-from <linux-acpi+bounces-20994-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 12:37:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1E1430BC
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 12:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F05B300B47F
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B62EBBA9;
	Mon, 16 Feb 2026 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktqj8fpC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9004199920;
	Mon, 16 Feb 2026 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771241871; cv=none; b=lMYn7yjgDJ22NsMJCZ69apttKxi8es0E6wLdbuR+mwUwXsfYukWwBLNt+yUdmSraizEr4+J4+lQPqFF4E/nUpiICiOZdgi10wl7p7OJj4utwt08nvmEXNFFN6F13vtwg4O77/n6baHbOldVH9sL0/n1ZxkIRLN5x55ax4hROd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771241871; c=relaxed/simple;
	bh=+mC60yV6zUzAhuN8asVFNKW2VWsrmar0zmaB8uPzyck=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nMVMQbxyVANmQFwlVy/hlln6neOsoscvmosMEW5knoosD1ys4Rj3zCwQjrZ0nogWpQHjJibZdylRFf10w9wdSoj7GD0AYyu6zVSEpO3lIdImcbgAUrA4hYUxR74Xa5QDfwViljJ2HAi764gmOwmiT7zrSThs4M0wihuqYgNX6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktqj8fpC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771241870; x=1802777870;
  h=date:from:to:cc:subject:message-id;
  bh=+mC60yV6zUzAhuN8asVFNKW2VWsrmar0zmaB8uPzyck=;
  b=ktqj8fpCH1j3xPwdjM+xoGT7kiueHEYsNKoPcsAcpMFIf04oKZUS+bAJ
   VmLsjVbPJqeN1m4DaIFDyJhwNh+5kuDVFDD+IWml9RN/ydkYIUKUqpMg3
   8QonlAH7EtEjofHYr6XmWdkOmrqeugibSDNDWZY6zi7d2jBuLR/K02hp4
   leD4ffBeq7ffMHL83B3n0DafBXXeUjqpOGODInwfXRHmwLRsmyIpQy1Ag
   ekgVrXCry/SUjbUd6rPdbujMUEe9cZQySG3EBjaLuJxS25tulOGPtyyx0
   6WR/Mgy5q5GVyr/BfvHjNctJaJjNAhZcKnY8haMuv79Y4R2n9+X20fZCh
   Q==;
X-CSE-ConnectionGUID: TQ9V880nTUmy2dpmzGG6Kg==
X-CSE-MsgGUID: UuTTvIyFReyucUxNAoBAaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72416167"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; 
   d="scan'208";a="72416167"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 03:37:43 -0800
X-CSE-ConnectionGUID: Qi9vO9llTd2AaFmVa3cRFQ==
X-CSE-MsgGUID: lfIKhNZSTmOrkMrFezkwmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; 
   d="scan'208";a="212681475"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 16 Feb 2026 03:37:39 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrwv2-00000000ze4-0rpY;
	Mon, 16 Feb 2026 11:37:36 +0000
Date: Mon, 16 Feb 2026 19:36:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH UNVERIFIED
 WARNING 3cf2b08de92fc53cbd5632a8d47194932da78534
Message-ID: <202602161929.wbtohM5r-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20994-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0B1E1430BC
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3cf2b08de92fc53cbd5632a8d47194932da78534  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

Unverified Warning (likely false positive, kindly check if interested):

    drivers/platform/x86/toshiba_acpi.c:3574 toshiba_acpi_probe() warn: '&dev->miscdev' from misc_register() not released on lines: 3574.

Warning ids grouped by kconfigs:

recent_errors
`-- i386-randconfig-r072-20260216
    `-- drivers-platform-x86-toshiba_acpi.c-toshiba_acpi_probe()-warn:dev-miscdev-from-misc_register()-not-released-on-lines:.

elapsed time: 1298m

configs tested: 321
configs skipped: 24

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    clang-23
arc                   randconfig-001-20260215    clang-20
arc                   randconfig-001-20260216    gcc-12.5.0
arc                   randconfig-002-20260215    clang-20
arc                   randconfig-002-20260216    gcc-12.5.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arc                    vdk_hs38_smp_defconfig    clang-23
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    clang-23
arm                         bcm2835_defconfig    gcc-15.2.0
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-19
arm                          exynos_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                         lpc32xx_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    gcc-15.2.0
arm                   randconfig-001-20260215    clang-20
arm                   randconfig-001-20260216    gcc-12.5.0
arm                   randconfig-002-20260215    clang-20
arm                   randconfig-002-20260216    gcc-12.5.0
arm                   randconfig-003-20260215    clang-20
arm                   randconfig-003-20260216    gcc-12.5.0
arm                   randconfig-004-20260215    clang-20
arm                   randconfig-004-20260216    gcc-12.5.0
arm                           sama5_defconfig    clang-23
arm                       spear13xx_defconfig    gcc-15.2.0
arm                        vexpress_defconfig    clang-19
arm                        vexpress_defconfig    clang-23
arm                         wpcm450_defconfig    clang-19
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260215    gcc-13.4.0
arm64                 randconfig-001-20260216    clang-17
arm64                 randconfig-002-20260215    gcc-8.5.0
arm64                 randconfig-002-20260216    clang-17
arm64                 randconfig-003-20260215    gcc-14.3.0
arm64                 randconfig-003-20260216    clang-17
arm64                 randconfig-004-20260215    clang-22
arm64                 randconfig-004-20260216    clang-17
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260215    gcc-14.3.0
csky                  randconfig-001-20260216    clang-17
csky                  randconfig-002-20260215    gcc-15.2.0
csky                  randconfig-002-20260216    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260215    clang-22
hexagon               randconfig-001-20260216    clang-20
hexagon               randconfig-002-20260215    clang-22
hexagon               randconfig-002-20260216    clang-20
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260216    clang-20
i386        buildonly-randconfig-002-20260216    clang-20
i386        buildonly-randconfig-003-20260216    clang-20
i386        buildonly-randconfig-004-20260216    clang-20
i386        buildonly-randconfig-005-20260216    clang-20
i386        buildonly-randconfig-006-20260216    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260215    clang-20
i386                  randconfig-001-20260216    clang-20
i386                  randconfig-002-20260215    clang-20
i386                  randconfig-002-20260216    clang-20
i386                  randconfig-003-20260215    clang-20
i386                  randconfig-003-20260216    clang-20
i386                  randconfig-004-20260215    clang-20
i386                  randconfig-004-20260215    gcc-14
i386                  randconfig-004-20260216    clang-20
i386                  randconfig-005-20260215    clang-20
i386                  randconfig-005-20260215    gcc-14
i386                  randconfig-005-20260216    clang-20
i386                  randconfig-006-20260215    clang-20
i386                  randconfig-006-20260215    gcc-14
i386                  randconfig-006-20260216    clang-20
i386                  randconfig-007-20260215    clang-20
i386                  randconfig-007-20260215    gcc-14
i386                  randconfig-007-20260216    clang-20
i386                  randconfig-011-20260216    clang-20
i386                  randconfig-012-20260216    clang-20
i386                  randconfig-013-20260216    clang-20
i386                  randconfig-013-20260216    gcc-14
i386                  randconfig-014-20260216    clang-20
i386                  randconfig-014-20260216    gcc-14
i386                  randconfig-015-20260216    clang-20
i386                  randconfig-015-20260216    gcc-14
i386                  randconfig-016-20260216    clang-20
i386                  randconfig-016-20260216    gcc-14
i386                  randconfig-017-20260216    clang-20
i386                  randconfig-017-20260216    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson64_defconfig    clang-19
loongarch             randconfig-001-20260215    clang-22
loongarch             randconfig-001-20260216    clang-20
loongarch             randconfig-002-20260215    gcc-13.4.0
loongarch             randconfig-002-20260216    clang-20
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         apollo_defconfig    clang-19
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5208evb_defconfig    clang-19
m68k                       m5208evb_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          eyeq6_defconfig    clang-19
mips                           jazz_defconfig    gcc-15.2.0
mips                     loongson2k_defconfig    gcc-15.2.0
mips                          malta_defconfig    clang-23
mips                malta_qemu_32r6_defconfig    clang-19
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-23
mips                        maltaup_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-15.2.0
nios2                 randconfig-001-20260215    gcc-8.5.0
nios2                 randconfig-001-20260216    clang-20
nios2                 randconfig-002-20260215    gcc-8.5.0
nios2                 randconfig-002-20260216    clang-20
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    clang-23
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    clang-23
parisc                randconfig-001-20260215    clang-23
parisc                randconfig-001-20260216    clang-23
parisc                randconfig-002-20260215    clang-23
parisc                randconfig-002-20260216    clang-23
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    clang-19
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                       eiger_defconfig    clang-19
powerpc                       eiger_defconfig    clang-23
powerpc                     mpc512x_defconfig    clang-23
powerpc                 mpc8315_rdb_defconfig    clang-19
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    clang-23
powerpc               randconfig-001-20260215    clang-23
powerpc               randconfig-001-20260216    clang-23
powerpc               randconfig-002-20260215    clang-23
powerpc               randconfig-002-20260216    clang-23
powerpc                     skiroot_defconfig    clang-23
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20260215    clang-23
powerpc64             randconfig-001-20260216    clang-23
powerpc64             randconfig-002-20260215    clang-23
powerpc64             randconfig-002-20260216    clang-23
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    clang-23
riscv                 randconfig-001-20260215    gcc-13.4.0
riscv                 randconfig-001-20260216    clang-23
riscv                 randconfig-002-20260215    gcc-13.4.0
riscv                 randconfig-002-20260216    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260215    gcc-13.4.0
s390                  randconfig-001-20260216    clang-23
s390                  randconfig-002-20260215    gcc-13.4.0
s390                  randconfig-002-20260216    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                ecovec24-romimage_defconfig    clang-19
sh                               j2_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260215    gcc-13.4.0
sh                    randconfig-001-20260216    clang-23
sh                    randconfig-002-20260215    gcc-13.4.0
sh                    randconfig-002-20260216    clang-23
sh                          rsk7264_defconfig    clang-19
sh                           se7751_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260215    gcc-15.2.0
sparc                 randconfig-001-20260215    gcc-9.5.0
sparc                 randconfig-001-20260216    gcc-9.5.0
sparc                 randconfig-002-20260215    gcc-8.5.0
sparc                 randconfig-002-20260215    gcc-9.5.0
sparc                 randconfig-002-20260216    gcc-9.5.0
sparc                       sparc64_defconfig    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260215    gcc-9.5.0
sparc64               randconfig-001-20260216    gcc-9.5.0
sparc64               randconfig-002-20260215    clang-22
sparc64               randconfig-002-20260215    gcc-9.5.0
sparc64               randconfig-002-20260216    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260215    clang-23
um                    randconfig-001-20260215    gcc-9.5.0
um                    randconfig-001-20260216    gcc-9.5.0
um                    randconfig-002-20260215    gcc-14
um                    randconfig-002-20260215    gcc-9.5.0
um                    randconfig-002-20260216    gcc-9.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260216    gcc-13
x86_64      buildonly-randconfig-002-20260216    gcc-13
x86_64      buildonly-randconfig-003-20260216    gcc-13
x86_64      buildonly-randconfig-004-20260216    gcc-13
x86_64      buildonly-randconfig-005-20260216    gcc-13
x86_64      buildonly-randconfig-006-20260216    gcc-13
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260216    clang-20
x86_64                randconfig-002-20260216    clang-20
x86_64                randconfig-003-20260216    clang-20
x86_64                randconfig-004-20260216    clang-20
x86_64                randconfig-005-20260216    clang-20
x86_64                randconfig-006-20260216    clang-20
x86_64                randconfig-011-20260216    clang-20
x86_64                randconfig-012-20260216    clang-20
x86_64                randconfig-013-20260216    clang-20
x86_64                randconfig-014-20260216    clang-20
x86_64                randconfig-015-20260216    clang-20
x86_64                randconfig-016-20260216    clang-20
x86_64                randconfig-071-20260216    clang-20
x86_64                randconfig-072-20260216    clang-20
x86_64                randconfig-073-20260216    clang-20
x86_64                randconfig-074-20260216    clang-20
x86_64                randconfig-075-20260216    clang-20
x86_64                randconfig-076-20260216    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                  audio_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260215    gcc-12.5.0
xtensa                randconfig-001-20260215    gcc-9.5.0
xtensa                randconfig-001-20260216    gcc-9.5.0
xtensa                randconfig-002-20260215    gcc-9.5.0
xtensa                randconfig-002-20260216    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

