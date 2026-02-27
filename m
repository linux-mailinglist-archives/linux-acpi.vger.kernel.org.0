Return-Path: <linux-acpi+bounces-21197-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xH94G0w1oWnRrAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21197-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 07:10:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BC1B30AF
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 07:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC29530C3666
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 06:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6E36EAA5;
	Fri, 27 Feb 2026 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7Iv2PlG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807BF331A73;
	Fri, 27 Feb 2026 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172616; cv=none; b=Whu6HeOzxFlfJm7KDStkLBS46hZKLcfCy0qwyehOHK4fAA1De/amdTK7Tgltc6oHYNoUpWu+l6WYhLzNvYQHqxZlIn+q3c1X+em1VVfErpSDYze7pHa38ey7NqclXHR+zpwVkGFYMRV+EhNjLsBNEWbcX9eHBtxqB9QdezDT4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172616; c=relaxed/simple;
	bh=gI572p0SvvhIN+spENtfYcCEnjVfiV2tWUklIp6vTec=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tGaqAl+L2gY6a3hGNhKVCNNDMXMVTuVbr4cwlPUZNzUEFPy10NA0BtwiEhouikUAjHsAW+ATlG49E9t94r+RxjkoDvlYYsTR5Ohu5RDUOnMNJ2eHCHXw1ZT+AVOIVAU7CdILo6YUB46YoC9nNPT8kXGjTM3kRGbm+Z/ZFPNjc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7Iv2PlG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772172613; x=1803708613;
  h=date:from:to:cc:subject:message-id;
  bh=gI572p0SvvhIN+spENtfYcCEnjVfiV2tWUklIp6vTec=;
  b=Y7Iv2PlG8GPS1tji2D/gquygr/u8KwBrDqI06mh8kryVEf6trecxRSST
   oSWnTpv4rthK9y/Wxvq+cExDouJZDwxCIVclPh10sHct8IafVySWUEE9J
   qzcKscq3WZBsXZn4Rl/3xCoANS1F7p9DU98ijS4KdEo90MuhlXIWjR5wn
   Pn0jO+kY1Whzaki3oXvGpygZmUsNHsuI2iliI298ceSeSqGKbcX5lT+1u
   qgNeBKbnP+rUrxfPXdmN42J0QIKEbTneIYz8Z904UI2zkH87QCPm/qGB+
   I+QLd9mEtLz9bqA64xtXrd+dE83grq8DEPenni6u9VTDCQwWYpkPb/LU8
   w==;
X-CSE-ConnectionGUID: Ms+6tD9QSxuer3BScP/jxg==
X-CSE-MsgGUID: nL/Itx0BRGKzHIgLNAkcug==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73316388"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73316388"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 22:10:12 -0800
X-CSE-ConnectionGUID: w/EIlAmnRtWGCOZTPQ2/tw==
X-CSE-MsgGUID: LsP3fMh/Qz2syMKbmuEtSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="214262273"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 26 Feb 2026 22:10:11 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvr30-00000000AEf-0sGv;
	Fri, 27 Feb 2026 06:10:02 +0000
Date: Fri, 27 Feb 2026 14:09:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a6813a28450b6882d850d0f1ab06fbe38a155bbd
Message-ID: <202602271406.QHZoji2j-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-21197-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: B66BC1B30AF
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a6813a28450b6882d850d0f1ab06fbe38a155bbd  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 729m

configs tested: 244
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260227    gcc-8.5.0
arc                   randconfig-002-20260227    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-23
arm                        neponset_defconfig    gcc-15.2.0
arm                   randconfig-001-20260227    gcc-8.5.0
arm                   randconfig-002-20260227    gcc-8.5.0
arm                   randconfig-003-20260227    gcc-8.5.0
arm                   randconfig-004-20260227    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260227    clang-23
arm64                 randconfig-002-20260227    clang-23
arm64                 randconfig-002-20260227    gcc-15.2.0
arm64                 randconfig-003-20260227    clang-23
arm64                 randconfig-004-20260227    clang-23
arm64                 randconfig-004-20260227    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    clang-23
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260227    clang-23
csky                  randconfig-001-20260227    gcc-15.2.0
csky                  randconfig-002-20260227    clang-23
csky                  randconfig-002-20260227    gcc-10.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260227    clang-23
hexagon               randconfig-002-20260227    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260227    clang-20
i386        buildonly-randconfig-002-20260227    clang-20
i386        buildonly-randconfig-003-20260227    clang-20
i386        buildonly-randconfig-004-20260227    clang-20
i386        buildonly-randconfig-005-20260227    clang-20
i386        buildonly-randconfig-006-20260227    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260227    clang-20
i386                  randconfig-002-20260227    clang-20
i386                  randconfig-003-20260227    clang-20
i386                  randconfig-004-20260227    clang-20
i386                  randconfig-005-20260227    clang-20
i386                  randconfig-006-20260227    clang-20
i386                  randconfig-007-20260227    clang-20
i386                  randconfig-011-20260227    clang-20
i386                  randconfig-011-20260227    gcc-14
i386                  randconfig-012-20260227    gcc-14
i386                  randconfig-013-20260227    clang-20
i386                  randconfig-013-20260227    gcc-14
i386                  randconfig-014-20260227    gcc-14
i386                  randconfig-015-20260227    gcc-13
i386                  randconfig-015-20260227    gcc-14
i386                  randconfig-016-20260227    clang-20
i386                  randconfig-016-20260227    gcc-14
i386                  randconfig-017-20260227    gcc-14
loongarch                        alldefconfig    clang-23
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260227    clang-23
loongarch             randconfig-002-20260227    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                          hp300_defconfig    gcc-15.2.0
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                           sun3_defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                       bmips_be_defconfig    clang-23
mips                           jazz_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260227    clang-23
nios2                 randconfig-002-20260227    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                   de0_nano_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    clang-23
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260227    clang-17
parisc                randconfig-002-20260227    clang-17
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    gcc-15.2.0
powerpc                     rainier_defconfig    clang-23
powerpc               randconfig-001-20260227    clang-17
powerpc               randconfig-002-20260227    clang-17
powerpc                    socrates_defconfig    clang-23
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc                     tqm8555_defconfig    clang-23
powerpc64             randconfig-001-20260227    clang-17
powerpc64             randconfig-002-20260227    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260227    gcc-12.5.0
riscv                 randconfig-002-20260227    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260227    gcc-12.5.0
s390                  randconfig-002-20260227    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          r7780mp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260227    gcc-12.5.0
sh                    randconfig-002-20260227    gcc-12.5.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                           se7343_defconfig    clang-23
sh                           se7705_defconfig    clang-23
sh                           se7750_defconfig    gcc-15.2.0
sh                   secureedge5410_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    clang-23
sh                     sh7710voipgw_defconfig    clang-23
sh                   sh7724_generic_defconfig    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260227    clang-23
sparc                 randconfig-001-20260227    gcc-11.5.0
sparc                 randconfig-002-20260227    clang-23
sparc                 randconfig-002-20260227    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260227    clang-23
sparc64               randconfig-002-20260227    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260227    clang-23
um                    randconfig-002-20260227    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260227    gcc-14
x86_64      buildonly-randconfig-002-20260227    gcc-14
x86_64      buildonly-randconfig-003-20260227    gcc-14
x86_64      buildonly-randconfig-004-20260227    gcc-14
x86_64      buildonly-randconfig-005-20260227    gcc-14
x86_64      buildonly-randconfig-006-20260227    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260227    gcc-13
x86_64                randconfig-002-20260227    gcc-13
x86_64                randconfig-003-20260227    gcc-13
x86_64                randconfig-004-20260227    gcc-13
x86_64                randconfig-005-20260227    gcc-13
x86_64                randconfig-006-20260227    gcc-13
x86_64                randconfig-011-20260227    gcc-14
x86_64                randconfig-012-20260227    gcc-14
x86_64                randconfig-013-20260227    gcc-14
x86_64                randconfig-014-20260227    gcc-14
x86_64                randconfig-015-20260227    gcc-14
x86_64                randconfig-016-20260227    gcc-14
x86_64                randconfig-071-20260227    gcc-14
x86_64                randconfig-072-20260227    gcc-14
x86_64                randconfig-073-20260227    gcc-14
x86_64                randconfig-074-20260227    gcc-14
x86_64                randconfig-075-20260227    gcc-14
x86_64                randconfig-076-20260227    gcc-14
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
xtensa                  audio_kc705_defconfig    gcc-15.2.0
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260227    clang-23
xtensa                randconfig-001-20260227    gcc-15.2.0
xtensa                randconfig-002-20260227    clang-23
xtensa                randconfig-002-20260227    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

