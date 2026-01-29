Return-Path: <linux-acpi+bounces-20765-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI5EHCFke2l2EQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20765-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 14:44:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D002B0842
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 14:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80B663002325
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825CF3093DD;
	Thu, 29 Jan 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZFGMK1o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F52874F5;
	Thu, 29 Jan 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694239; cv=none; b=jExDjRjGdrpGo2qwMhUhyUMD4FnREulUrbMqyyNwM9lbp7ZL+PTvi5aN9JePKNC/ZRsjCjMbaGoF2xAPYYkJODWEXcgXhJTtmUwShutjboSewqV/N6vVpvni055JJxwdXZ58yFS4Jas7LEH0FM3ufQFP19W/5leBQxUj0oerIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694239; c=relaxed/simple;
	bh=o3krQtW92gs+tlsy9qs9QNtUJ6Yl3bdlJ2sJ39B2J/k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MlW2ND3TQ8dBk4yV/aiKhZN3xPVG7bxl8f5Qq56nYw7HbQSoZQfqeWvTF/vuY6S4zYQXakxCLSd20VEiQusaOMkMw5a8mxugKkXpH4jrw7lW7QBuvMZ6TI1BQ+Yvueo7z3UMQu21lid4sp/EwgfFtEmWEPprf6PudFI6amRsl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZFGMK1o; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769694237; x=1801230237;
  h=date:from:to:cc:subject:message-id;
  bh=o3krQtW92gs+tlsy9qs9QNtUJ6Yl3bdlJ2sJ39B2J/k=;
  b=RZFGMK1o2ZaaIC6hxkbUgLfF04l65LKV562JHp8UFnfNTapQn9E0Ocmw
   jMCf9/hf1BQ6AwxUMiCWRXWPbuoV1lCk7r1lr2jP3pUUiQaUQy/o0awvH
   xXD5jnlNWsSduxrh0N2Aiy91gSUmLtBwDBOV+Q4Q/8HMdG9Z8dvCSM1Na
   TGXCviM3RlFObQCTR3MTFZl9/T68e6tzc9j+Pv1oXDvKVJafm8VgnrQi4
   75/Y3j4QyTy0mKSWx7tmzMrKX0DvT4X34dTz+UJTApoIFk24hdtOzi+hs
   wyMwqhF5MNnbvAtWHyp9zM0e7kN68Q/MWjO6jCsd/HY56R/8LP84rE6F9
   w==;
X-CSE-ConnectionGUID: cnH17zWXSRO3QqE/gHLCbQ==
X-CSE-MsgGUID: Mh75/MhoTbe6/ckfb0RBcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="69947839"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="69947839"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 05:43:57 -0800
X-CSE-ConnectionGUID: wiGyNAVcTfu33LvGrphSRQ==
X-CSE-MsgGUID: LUXMdVaNSiy0MVORagS6UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="213077726"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jan 2026 05:43:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlSJN-00000000bWC-26CJ;
	Thu, 29 Jan 2026 13:43:53 +0000
Date: Thu, 29 Jan 2026 21:43:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 839fb273827fea8eecbe62750cda06bc685dff2e
Message-ID: <202601292138.6cmJlVZ1-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20765-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D002B0842
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 839fb273827fea8eecbe62750cda06bc685dff2e  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 955m

configs tested: 197
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260129    clang-18
arc                   randconfig-002-20260129    clang-18
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                       imx_v6_v7_defconfig    clang-22
arm                         mv78xx0_defconfig    clang-22
arm                        mvebu_v5_defconfig    clang-22
arm                   randconfig-001-20260129    clang-18
arm                   randconfig-002-20260129    clang-18
arm                   randconfig-003-20260129    clang-18
arm                   randconfig-004-20260129    clang-18
arm                    vt8500_v6_v7_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260129    gcc-11.5.0
arm64                 randconfig-002-20260129    gcc-11.5.0
arm64                 randconfig-003-20260129    gcc-11.5.0
arm64                 randconfig-004-20260129    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260129    gcc-11.5.0
csky                  randconfig-002-20260129    gcc-11.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260129    clang-22
hexagon               randconfig-002-20260129    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260129    clang-20
i386        buildonly-randconfig-002-20260129    clang-20
i386        buildonly-randconfig-003-20260129    clang-20
i386        buildonly-randconfig-004-20260129    clang-20
i386        buildonly-randconfig-005-20260129    clang-20
i386        buildonly-randconfig-006-20260129    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260129    clang-20
i386                  randconfig-002-20260129    clang-20
i386                  randconfig-003-20260129    clang-20
i386                  randconfig-004-20260129    clang-20
i386                  randconfig-005-20260129    clang-20
i386                  randconfig-006-20260129    clang-20
i386                  randconfig-007-20260129    clang-20
i386                  randconfig-011-20260129    clang-20
i386                  randconfig-012-20260129    clang-20
i386                  randconfig-013-20260129    clang-20
i386                  randconfig-014-20260129    clang-20
i386                  randconfig-015-20260129    clang-20
i386                  randconfig-016-20260129    clang-20
i386                  randconfig-017-20260129    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260129    clang-22
loongarch             randconfig-002-20260129    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          atari_defconfig    clang-22
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ip28_defconfig    clang-22
mips                      pic32mzda_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260129    clang-22
nios2                 randconfig-002-20260129    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260129    gcc-8.5.0
parisc                randconfig-002-20260129    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                     ep8248e_defconfig    clang-22
powerpc               randconfig-001-20260129    gcc-8.5.0
powerpc               randconfig-002-20260129    gcc-8.5.0
powerpc                    sam440ep_defconfig    clang-22
powerpc64             randconfig-001-20260129    gcc-8.5.0
powerpc64             randconfig-002-20260129    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20260129    gcc-15.2.0
riscv                 randconfig-002-20260129    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260129    gcc-15.2.0
s390                  randconfig-002-20260129    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260129    gcc-15.2.0
sh                    randconfig-002-20260129    gcc-15.2.0
sh                          rsk7201_defconfig    clang-22
sh                           se7705_defconfig    clang-22
sh                           se7722_defconfig    clang-22
sh                             shx3_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260129    gcc-15.2.0
sparc                 randconfig-002-20260129    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260129    gcc-15.2.0
sparc64               randconfig-002-20260129    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260129    gcc-15.2.0
um                    randconfig-002-20260129    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260129    gcc-13
x86_64      buildonly-randconfig-002-20260129    gcc-13
x86_64      buildonly-randconfig-003-20260129    gcc-13
x86_64      buildonly-randconfig-004-20260129    gcc-13
x86_64      buildonly-randconfig-005-20260129    gcc-13
x86_64      buildonly-randconfig-006-20260129    gcc-13
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260129    clang-20
x86_64                randconfig-002-20260129    clang-20
x86_64                randconfig-003-20260129    clang-20
x86_64                randconfig-004-20260129    clang-20
x86_64                randconfig-005-20260129    clang-20
x86_64                randconfig-006-20260129    clang-20
x86_64                randconfig-011-20260129    clang-20
x86_64                randconfig-012-20260129    clang-20
x86_64                randconfig-013-20260129    clang-20
x86_64                randconfig-014-20260129    clang-20
x86_64                randconfig-015-20260129    clang-20
x86_64                randconfig-016-20260129    clang-20
x86_64                randconfig-071-20260129    gcc-14
x86_64                randconfig-072-20260129    gcc-14
x86_64                randconfig-073-20260129    gcc-14
x86_64                randconfig-074-20260129    gcc-14
x86_64                randconfig-075-20260129    gcc-14
x86_64                randconfig-076-20260129    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260129    gcc-15.2.0
xtensa                randconfig-002-20260129    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

