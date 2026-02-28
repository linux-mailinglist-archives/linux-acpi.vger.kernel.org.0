Return-Path: <linux-acpi+bounces-21243-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPJ1CthFomn31QQAu9opvQ
	(envelope-from <linux-acpi+bounces-21243-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 02:33:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD71BFBDB
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 02:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEA3D3061131
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0997A2FB97A;
	Sat, 28 Feb 2026 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nt0G0n+n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BA21E087;
	Sat, 28 Feb 2026 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242388; cv=none; b=ldhMyIaKjhMPUTSYus30dRpR+4ZpuL6bEJV4avZUQrcix4jqdqC7TyRKCn9+CS6jByPBTcbuMWccNpbPnX+OZPDgdk66ZCiznwRUlJSA7PHpdpZYcAnaaxZ7/tX8Pd5DM4/Eh2dovaEKUVSu0vdVMg+YojjxuC859oH3GNpWaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242388; c=relaxed/simple;
	bh=Kof1tkNlHRP2o37ZKG6wXuCuJdPsgIv3BYuL8FeBKV4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sMD4VEeTuTls10mxKOx8WHB0DI9+fhJlwWG0B8HbQHTJc4quJW7LzJj3NgMCnJ1j+et8pRd4p2mbHY4hLWIA/2llIlXFI3YfbH2J0O6W1tpWJF3oCaX1tCtThH+1dXfvMEkW0kbhHxPc9bXCB3ou7U3fMIRzj0BjoafMMn2gdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nt0G0n+n; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772242387; x=1803778387;
  h=date:from:to:cc:subject:message-id;
  bh=Kof1tkNlHRP2o37ZKG6wXuCuJdPsgIv3BYuL8FeBKV4=;
  b=nt0G0n+n1gPZPN8rzJestiDxz6K/spOiu+EC/SyecI9y4fnPMb5+DBB6
   wiX6GRbBDP9yB/Wg2tGmSQdSb3n9J0lo2sYE6yo4UZ8ZUYZOvTuptCu6p
   HB3XXAMUWMBqD4/VbAD64X5Zpqg3hbZSusJLgkwyzgDepOXfpEGRIfKkq
   SEYR1RsONr3nkKI3okw5RcHWHDUYbI6qecs3e9uYGdWO+UtIPTVOOy5Y1
   uzuQ2e+jjXqXH+JHNpE2FqJj0jk8NU/gS3dYUqljmZaoenagWG7GqAKp/
   6zxBfupg14K0srnWxCCeCv7v0UAXDElc07rteZbjeNJfLpNWdxbtmvMvC
   g==;
X-CSE-ConnectionGUID: IEBsJwxURRaJDGlX3sQvpA==
X-CSE-MsgGUID: nOTEgJh5Rpi5TphLlWXH1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73237547"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73237547"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 17:33:06 -0800
X-CSE-ConnectionGUID: q/rbzHM9RRm3QvhfBD1HgQ==
X-CSE-MsgGUID: OF7F6IQwRWex/LNyjJFD9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="247562709"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Feb 2026 17:33:06 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vw9CY-00000000BEh-2fmg;
	Sat, 28 Feb 2026 01:33:02 +0000
Date: Sat, 28 Feb 2026 09:32:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 4ae4483c7626d85634a1877c17abb7df170c0dde
Message-ID: <202602280900.S90RxYKd-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21243-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: B5BD71BFBDB
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 4ae4483c7626d85634a1877c17abb7df170c0dde  Merge branch 'acpica' into fixes

elapsed time: 807m

configs tested: 378
configs skipped: 5

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
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-23
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260227    gcc-8.5.0
arc                   randconfig-001-20260228    gcc-14.3.0
arc                   randconfig-002-20260227    gcc-8.5.0
arc                   randconfig-002-20260228    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         axm55xx_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    gcc-14
arm                       imx_v6_v7_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                        keystone_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    clang-23
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                   randconfig-001-20260227    gcc-14.3.0
arm                   randconfig-001-20260227    gcc-8.5.0
arm                   randconfig-001-20260228    gcc-14.3.0
arm                   randconfig-002-20260227    clang-23
arm                   randconfig-002-20260227    gcc-8.5.0
arm                   randconfig-002-20260228    gcc-14.3.0
arm                   randconfig-003-20260227    gcc-15.2.0
arm                   randconfig-003-20260227    gcc-8.5.0
arm                   randconfig-003-20260228    gcc-14.3.0
arm                   randconfig-004-20260227    clang-23
arm                   randconfig-004-20260227    gcc-8.5.0
arm                   randconfig-004-20260228    gcc-14.3.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    clang-23
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260227    clang-23
arm64                 randconfig-001-20260228    clang-23
arm64                 randconfig-002-20260227    clang-23
arm64                 randconfig-002-20260227    gcc-15.2.0
arm64                 randconfig-002-20260228    clang-23
arm64                 randconfig-003-20260227    clang-23
arm64                 randconfig-003-20260228    clang-23
arm64                 randconfig-004-20260227    clang-23
arm64                 randconfig-004-20260227    gcc-8.5.0
arm64                 randconfig-004-20260228    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260227    clang-23
csky                  randconfig-001-20260227    gcc-15.2.0
csky                  randconfig-001-20260228    clang-23
csky                  randconfig-002-20260227    clang-23
csky                  randconfig-002-20260227    gcc-10.5.0
csky                  randconfig-002-20260228    clang-23
hexagon                          alldefconfig    gcc-14
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260227    clang-23
hexagon               randconfig-001-20260228    clang-23
hexagon               randconfig-002-20260227    clang-23
hexagon               randconfig-002-20260228    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260227    clang-20
i386        buildonly-randconfig-001-20260228    clang-20
i386        buildonly-randconfig-002-20260227    clang-20
i386        buildonly-randconfig-002-20260228    clang-20
i386        buildonly-randconfig-003-20260227    clang-20
i386        buildonly-randconfig-003-20260227    gcc-14
i386        buildonly-randconfig-003-20260228    clang-20
i386        buildonly-randconfig-004-20260227    clang-20
i386        buildonly-randconfig-004-20260227    gcc-14
i386        buildonly-randconfig-004-20260228    clang-20
i386        buildonly-randconfig-005-20260227    clang-20
i386        buildonly-randconfig-005-20260228    clang-20
i386        buildonly-randconfig-006-20260227    clang-20
i386        buildonly-randconfig-006-20260228    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260227    clang-20
i386                  randconfig-001-20260228    gcc-14
i386                  randconfig-002-20260227    clang-20
i386                  randconfig-002-20260228    gcc-14
i386                  randconfig-003-20260227    clang-20
i386                  randconfig-003-20260227    gcc-14
i386                  randconfig-003-20260228    gcc-14
i386                  randconfig-004-20260227    clang-20
i386                  randconfig-004-20260227    gcc-14
i386                  randconfig-004-20260228    gcc-14
i386                  randconfig-005-20260227    clang-20
i386                  randconfig-005-20260227    gcc-12
i386                  randconfig-005-20260228    gcc-14
i386                  randconfig-006-20260227    clang-20
i386                  randconfig-006-20260227    gcc-14
i386                  randconfig-006-20260228    gcc-14
i386                  randconfig-007-20260227    clang-20
i386                  randconfig-007-20260228    gcc-14
i386                  randconfig-011-20260227    clang-20
i386                  randconfig-011-20260227    gcc-14
i386                  randconfig-011-20260228    gcc-14
i386                  randconfig-012-20260227    gcc-14
i386                  randconfig-012-20260228    gcc-14
i386                  randconfig-013-20260227    clang-20
i386                  randconfig-013-20260227    gcc-14
i386                  randconfig-013-20260228    gcc-14
i386                  randconfig-014-20260227    gcc-14
i386                  randconfig-014-20260228    gcc-14
i386                  randconfig-015-20260227    gcc-13
i386                  randconfig-015-20260227    gcc-14
i386                  randconfig-015-20260228    gcc-14
i386                  randconfig-016-20260227    clang-20
i386                  randconfig-016-20260227    gcc-14
i386                  randconfig-016-20260228    gcc-14
i386                  randconfig-017-20260227    gcc-14
i386                  randconfig-017-20260228    gcc-14
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260227    clang-23
loongarch             randconfig-001-20260227    gcc-15.2.0
loongarch             randconfig-001-20260228    clang-23
loongarch             randconfig-002-20260227    clang-20
loongarch             randconfig-002-20260227    clang-23
loongarch             randconfig-002-20260228    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-14
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
m68k                            q40_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                      mmu_defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    gcc-14
mips                           ip30_defconfig    gcc-15.2.0
mips                      loongson1_defconfig    gcc-15.2.0
mips                          rm200_defconfig    gcc-15.2.0
nios2                         10m50_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260227    clang-23
nios2                 randconfig-001-20260227    gcc-11.5.0
nios2                 randconfig-001-20260228    clang-23
nios2                 randconfig-002-20260227    clang-23
nios2                 randconfig-002-20260227    gcc-11.5.0
nios2                 randconfig-002-20260228    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260227    clang-17
parisc                randconfig-001-20260227    gcc-8.5.0
parisc                randconfig-001-20260228    gcc-8.5.0
parisc                randconfig-002-20260227    clang-17
parisc                randconfig-002-20260227    gcc-8.5.0
parisc                randconfig-002-20260228    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    clang-23
powerpc                      bamboo_defconfig    clang-23
powerpc                   bluestone_defconfig    gcc-15.2.0
powerpc                        cell_defconfig    gcc-14
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    gcc-15.2.0
powerpc                     mpc5200_defconfig    clang-23
powerpc                     mpc83xx_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc                       ppc64_defconfig    clang-23
powerpc                         ps3_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260227    clang-17
powerpc               randconfig-001-20260227    gcc-11.5.0
powerpc               randconfig-001-20260228    gcc-8.5.0
powerpc               randconfig-002-20260227    clang-17
powerpc               randconfig-002-20260228    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     taishan_defconfig    gcc-15.2.0
powerpc                      tqm8xx_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260227    clang-17
powerpc64             randconfig-001-20260227    gcc-10.5.0
powerpc64             randconfig-001-20260228    gcc-8.5.0
powerpc64             randconfig-002-20260227    clang-17
powerpc64             randconfig-002-20260227    gcc-14.3.0
powerpc64             randconfig-002-20260228    gcc-8.5.0
riscv                            alldefconfig    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260227    clang-23
riscv                 randconfig-001-20260227    gcc-12.5.0
riscv                 randconfig-001-20260228    gcc-15.2.0
riscv                 randconfig-002-20260227    gcc-12.5.0
riscv                 randconfig-002-20260227    gcc-8.5.0
riscv                 randconfig-002-20260228    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260227    gcc-11.5.0
s390                  randconfig-001-20260227    gcc-12.5.0
s390                  randconfig-001-20260228    gcc-15.2.0
s390                  randconfig-002-20260227    gcc-12.5.0
s390                  randconfig-002-20260227    gcc-9.5.0
s390                  randconfig-002-20260228    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    gcc-15.2.0
sh                             espt_defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260227    gcc-12.5.0
sh                    randconfig-001-20260228    gcc-15.2.0
sh                    randconfig-002-20260227    gcc-12.5.0
sh                    randconfig-002-20260227    gcc-15.2.0
sh                    randconfig-002-20260228    gcc-15.2.0
sh                          sdk7780_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    clang-23
sh                              ul2_defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260227    clang-23
sparc                 randconfig-001-20260227    gcc-11.5.0
sparc                 randconfig-001-20260228    gcc-9.5.0
sparc                 randconfig-002-20260227    clang-23
sparc                 randconfig-002-20260227    gcc-15.2.0
sparc                 randconfig-002-20260228    gcc-9.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260227    clang-23
sparc64               randconfig-001-20260228    gcc-9.5.0
sparc64               randconfig-002-20260227    clang-23
sparc64               randconfig-002-20260228    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260227    clang-23
um                    randconfig-001-20260228    gcc-9.5.0
um                    randconfig-002-20260227    clang-23
um                    randconfig-002-20260228    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260227    gcc-14
x86_64      buildonly-randconfig-001-20260228    gcc-14
x86_64      buildonly-randconfig-002-20260227    gcc-14
x86_64      buildonly-randconfig-002-20260228    gcc-14
x86_64      buildonly-randconfig-003-20260227    clang-20
x86_64      buildonly-randconfig-003-20260227    gcc-14
x86_64      buildonly-randconfig-003-20260228    gcc-14
x86_64      buildonly-randconfig-004-20260227    gcc-14
x86_64      buildonly-randconfig-004-20260228    gcc-14
x86_64      buildonly-randconfig-005-20260227    gcc-14
x86_64      buildonly-randconfig-005-20260228    gcc-14
x86_64      buildonly-randconfig-006-20260227    gcc-14
x86_64      buildonly-randconfig-006-20260228    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260227    clang-20
x86_64                randconfig-001-20260227    gcc-13
x86_64                randconfig-001-20260228    gcc-14
x86_64                randconfig-002-20260227    clang-20
x86_64                randconfig-002-20260227    gcc-13
x86_64                randconfig-002-20260228    gcc-14
x86_64                randconfig-003-20260227    gcc-13
x86_64                randconfig-003-20260227    gcc-14
x86_64                randconfig-003-20260228    gcc-14
x86_64                randconfig-004-20260227    gcc-13
x86_64                randconfig-004-20260228    gcc-14
x86_64                randconfig-005-20260227    gcc-13
x86_64                randconfig-005-20260227    gcc-14
x86_64                randconfig-005-20260228    gcc-14
x86_64                randconfig-006-20260227    gcc-13
x86_64                randconfig-006-20260227    gcc-14
x86_64                randconfig-006-20260228    gcc-14
x86_64                randconfig-011-20260227    gcc-14
x86_64                randconfig-011-20260228    clang-20
x86_64                randconfig-011-20260228    gcc-14
x86_64                randconfig-012-20260227    gcc-14
x86_64                randconfig-012-20260228    clang-20
x86_64                randconfig-012-20260228    gcc-14
x86_64                randconfig-013-20260227    gcc-14
x86_64                randconfig-013-20260228    gcc-13
x86_64                randconfig-013-20260228    gcc-14
x86_64                randconfig-014-20260227    gcc-14
x86_64                randconfig-014-20260228    gcc-14
x86_64                randconfig-015-20260227    gcc-14
x86_64                randconfig-015-20260228    clang-20
x86_64                randconfig-015-20260228    gcc-14
x86_64                randconfig-016-20260227    gcc-14
x86_64                randconfig-016-20260228    gcc-14
x86_64                randconfig-071-20260227    gcc-12
x86_64                randconfig-071-20260227    gcc-14
x86_64                randconfig-071-20260228    gcc-14
x86_64                randconfig-072-20260227    clang-20
x86_64                randconfig-072-20260227    gcc-14
x86_64                randconfig-072-20260228    gcc-14
x86_64                randconfig-073-20260227    gcc-14
x86_64                randconfig-073-20260228    gcc-14
x86_64                randconfig-074-20260227    clang-20
x86_64                randconfig-074-20260227    gcc-14
x86_64                randconfig-074-20260228    gcc-14
x86_64                randconfig-075-20260227    clang-20
x86_64                randconfig-075-20260227    gcc-14
x86_64                randconfig-075-20260228    gcc-14
x86_64                randconfig-076-20260227    clang-20
x86_64                randconfig-076-20260227    gcc-14
x86_64                randconfig-076-20260228    gcc-14
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
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    clang-23
xtensa                randconfig-001-20260227    clang-23
xtensa                randconfig-001-20260227    gcc-15.2.0
xtensa                randconfig-001-20260228    gcc-9.5.0
xtensa                randconfig-002-20260227    clang-23
xtensa                randconfig-002-20260227    gcc-10.5.0
xtensa                randconfig-002-20260228    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

