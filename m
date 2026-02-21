Return-Path: <linux-acpi+bounces-21038-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIowIKJkmWk4TgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21038-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Feb 2026 08:54:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E44AE16C63B
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Feb 2026 08:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E433017C0F
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Feb 2026 07:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5F32BD01B;
	Sat, 21 Feb 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8rsZQ8+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F11F419A;
	Sat, 21 Feb 2026 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771660443; cv=none; b=tkDfyntK1W5GII+uvfgogxiPMT9783uGtgAeNAfh29cTABB7AyABlgKnN3BB5rjlE2nPg9WkpgKlDSVsDWMlUgr7I75jOabg9zabAonukRmGa2eTP+wdkBqw9uC8ta3Th5aGZjAALu18BgdGz9cuElvyqA4WwUeMyBDHivumV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771660443; c=relaxed/simple;
	bh=9W4sBRvHy5K/uL8G1bZ0gBGiB20AYSP7DIe3j80LOUg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M+YJ+Vrx9/IIqHd4Zy4e7CFJA4YGxPyORVoHP97mnIHtF+TKVqu+705SsGki5N9pWqKnJZQamNhm/YOH5R/oVjcVDOPk9Q/rSy3n/cnJeTMSjyOdVtKrhOUr81ecyALbzu8BajuxySAHfCtcvHJG2b+B30HI30oVyJE679heAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8rsZQ8+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771660441; x=1803196441;
  h=date:from:to:cc:subject:message-id;
  bh=9W4sBRvHy5K/uL8G1bZ0gBGiB20AYSP7DIe3j80LOUg=;
  b=A8rsZQ8+lZsucYHgQuluZTtfjLmvzCuFe3bXBu3nc+Zx2r2nKFv7c7cm
   fbHFFXRwgrZ++NTReJ03tUaL9c9B7hd8rhBBIIXUvCcumFIACfR2kcl6D
   abY0LigwqqaeeFi6sR0MdLa0n0lFJoL1SEuCGIvKVwkq+SR/tLULX/ZLl
   7QFYHOiBBYtqsxvy9xAsbQNAx+EvW57DKGl5ZaZIqLtst3iqd+X0YiSCX
   qTgZetgHBcYGnEINoYVDwzEqRSQoePZQQQJ3gPiKDS7etQkNKnecx4HzU
   wriaeHl4gKKaoo8VDsJKyg25UcdU3s2pHb+NznlP8v//C50wLHTGS94Mp
   Q==;
X-CSE-ConnectionGUID: L8iPanmiR9GizDwGbXXCvQ==
X-CSE-MsgGUID: /0awjcYYQumAAeaa9vbD/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72804391"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72804391"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 23:54:00 -0800
X-CSE-ConnectionGUID: 5C0qGtb8RR2lVEsy3couAA==
X-CSE-MsgGUID: pM/Jqe/4S0+zkpr0hb6+Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214305671"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 23:53:58 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vthoK-000000014nU-156B;
	Sat, 21 Feb 2026 07:53:56 +0000
Date: Sat, 21 Feb 2026 15:53:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 618af498f0dd83a001d344973f8ebaaf94e9f960
Message-ID: <202602211525.ZQdI0hns-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-21038-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E44AE16C63B
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 618af498f0dd83a001d344973f8ebaaf94e9f960  Merge branch 'pm-runtime' into bleeding-edge

elapsed time: 887m

configs tested: 247
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    clang-23
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260221    gcc-14.3.0
arc                   randconfig-002-20260221    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                       aspeed_g5_defconfig    gcc-15.2.0
arm                         bcm2835_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-23
arm                           omap1_defconfig    gcc-15.2.0
arm                   randconfig-001-20260221    gcc-11.5.0
arm                   randconfig-001-20260221    gcc-14.3.0
arm                   randconfig-002-20260221    gcc-14.3.0
arm                   randconfig-002-20260221    gcc-8.5.0
arm                   randconfig-003-20260221    gcc-11.5.0
arm                   randconfig-003-20260221    gcc-14.3.0
arm                   randconfig-004-20260221    clang-23
arm                   randconfig-004-20260221    gcc-14.3.0
arm                         s3c6400_defconfig    gcc-15.2.0
arm                           sama5_defconfig    clang-23
arm                         vf610m4_defconfig    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260221    clang-23
arm64                 randconfig-002-20260221    clang-23
arm64                 randconfig-003-20260221    clang-23
arm64                 randconfig-003-20260221    gcc-8.5.0
arm64                 randconfig-004-20260221    clang-23
arm64                 randconfig-004-20260221    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260221    clang-23
csky                  randconfig-001-20260221    gcc-11.5.0
csky                  randconfig-002-20260221    clang-23
csky                  randconfig-002-20260221    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260221    clang-23
hexagon               randconfig-002-20260221    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260221    clang-20
i386        buildonly-randconfig-002-20260221    clang-20
i386        buildonly-randconfig-003-20260221    clang-20
i386        buildonly-randconfig-004-20260221    clang-20
i386        buildonly-randconfig-005-20260221    clang-20
i386        buildonly-randconfig-006-20260221    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260221    gcc-14
i386                  randconfig-002-20260221    gcc-14
i386                  randconfig-003-20260221    gcc-14
i386                  randconfig-004-20260221    gcc-14
i386                  randconfig-005-20260221    gcc-14
i386                  randconfig-006-20260221    gcc-14
i386                  randconfig-007-20260221    gcc-14
i386                  randconfig-011-20260221    gcc-14
i386                  randconfig-012-20260221    gcc-14
i386                  randconfig-013-20260221    gcc-14
i386                  randconfig-014-20260221    gcc-14
i386                  randconfig-015-20260221    gcc-14
i386                  randconfig-016-20260221    gcc-14
i386                  randconfig-017-20260221    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260221    clang-23
loongarch             randconfig-001-20260221    gcc-15.2.0
loongarch             randconfig-002-20260221    clang-18
loongarch             randconfig-002-20260221    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    clang-23
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    clang-23
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    clang-23
mips                         cobalt_defconfig    clang-23
mips                           jazz_defconfig    clang-23
mips                      loongson3_defconfig    clang-23
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                        omega2p_defconfig    clang-23
nios2                         10m50_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260221    clang-23
nios2                 randconfig-001-20260221    gcc-11.5.0
nios2                 randconfig-002-20260221    clang-23
nios2                 randconfig-002-20260221    gcc-10.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260221    gcc-9.5.0
parisc                randconfig-002-20260221    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    clang-23
powerpc                 linkstation_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260221    gcc-9.5.0
powerpc               randconfig-002-20260221    gcc-9.5.0
powerpc                        warp_defconfig    clang-23
powerpc                         wii_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260221    gcc-9.5.0
powerpc64             randconfig-002-20260221    gcc-9.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260221    gcc-10.5.0
riscv                 randconfig-001-20260221    gcc-8.5.0
riscv                 randconfig-002-20260221    gcc-10.5.0
riscv                 randconfig-002-20260221    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260221    clang-23
s390                  randconfig-001-20260221    gcc-10.5.0
s390                  randconfig-002-20260221    gcc-10.5.0
s390                  randconfig-002-20260221    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260221    gcc-10.5.0
sh                    randconfig-002-20260221    gcc-10.5.0
sh                    randconfig-002-20260221    gcc-15.2.0
sh                          rsk7269_defconfig    gcc-15.2.0
sh                          sdk7780_defconfig    clang-23
sh                           se7705_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-15.2.0
sh                   sh7770_generic_defconfig    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260221    gcc-8.5.0
sparc                 randconfig-002-20260221    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260221    gcc-8.5.0
sparc64               randconfig-002-20260221    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260221    gcc-8.5.0
um                    randconfig-002-20260221    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260221    clang-20
x86_64      buildonly-randconfig-002-20260221    clang-20
x86_64      buildonly-randconfig-003-20260221    clang-20
x86_64      buildonly-randconfig-004-20260221    clang-20
x86_64      buildonly-randconfig-004-20260221    gcc-14
x86_64      buildonly-randconfig-005-20260221    clang-20
x86_64      buildonly-randconfig-006-20260221    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260221    clang-20
x86_64                randconfig-001-20260221    gcc-14
x86_64                randconfig-002-20260221    gcc-14
x86_64                randconfig-003-20260221    gcc-14
x86_64                randconfig-004-20260221    clang-20
x86_64                randconfig-004-20260221    gcc-14
x86_64                randconfig-005-20260221    clang-20
x86_64                randconfig-005-20260221    gcc-14
x86_64                randconfig-006-20260221    gcc-14
x86_64                randconfig-011-20260221    gcc-14
x86_64                randconfig-012-20260221    gcc-14
x86_64                randconfig-013-20260221    gcc-14
x86_64                randconfig-014-20260221    gcc-14
x86_64                randconfig-015-20260221    gcc-14
x86_64                randconfig-016-20260221    gcc-14
x86_64                randconfig-071-20260221    clang-20
x86_64                randconfig-072-20260221    clang-20
x86_64                randconfig-073-20260221    clang-20
x86_64                randconfig-074-20260221    clang-20
x86_64                randconfig-075-20260221    clang-20
x86_64                randconfig-076-20260221    clang-20
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
xtensa                randconfig-001-20260221    gcc-8.5.0
xtensa                randconfig-002-20260221    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

