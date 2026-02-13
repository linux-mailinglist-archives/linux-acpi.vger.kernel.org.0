Return-Path: <linux-acpi+bounces-20970-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOyyOPH2jmnbGAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20970-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 11:03:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D2134D3C
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 11:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED91D30117C1
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAD4319601;
	Fri, 13 Feb 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjXzC+X4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B973128C0;
	Fri, 13 Feb 2026 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977007; cv=none; b=o2BV14CODBs51/jZ7GOx8uBzBUvPubLlNev+ngHcMMpAmywpHAKjp7Gqow/ijDGbbTiU9nZVJ2GHWT78gT/J6siz0PmKAj1BTf3b2xMwPBDTpxzurzA5989MbJr2XAyzL2smlEcJqKr3GcXvxYRdNxEa4c4zeifZUm9pQPcXw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977007; c=relaxed/simple;
	bh=yhvrpL7Kle0Q3tvVSV5470YlfHzm8tO16cLAJn7SiVo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Eu8F2kx+bSRsfzjrwDD5GuEBReJs5ahzjtdo4KvWieNyd/n2jauUz+3Do0WMBlpsddYd/GfX4OebWpMmQ0T88LXpnBFtnjUornTT9Gu0QAdGCIaKpPB36FdqAvt+bCQ0oUZ8oVcuJY39c9nZLOw/q/4XPStI0IMcDiuLkCktDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjXzC+X4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770977006; x=1802513006;
  h=date:from:to:cc:subject:message-id;
  bh=yhvrpL7Kle0Q3tvVSV5470YlfHzm8tO16cLAJn7SiVo=;
  b=jjXzC+X4w922uzLSn9mr86/ZnDqZTUBGQf+VsvG3z5BXkiq4bmMSkSpl
   UJGRCU/syCXKLu0PafVcpo8pRkxQ/Mut9nFVt6gct4oOtwVrnQ7650ld/
   lou0RwHuUkrZMoGQ6DmoSKN7j2qeffk2zS3UoF+z46QtZ2x8slqd5/OMm
   yvK/HVy63FLFcuT8xOK20XZJINUVJo79djZ6orWwy3w2cakhDJXS52aog
   Q/DwsQOm/MIPMVwFYouNuXbKucNYPKGjjAIyOYDyExLmP8fbEWkzQs65B
   UeelnWrCl9WGXElywkxIaX2FINOJzuImdFzrkVQYpesVv7NS4d6G3ltce
   A==;
X-CSE-ConnectionGUID: HQWe3U9lQFeS2hBqSxYk3A==
X-CSE-MsgGUID: B/zVt+LeSN2ZzLJmwVYIWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71359297"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="71359297"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 02:03:25 -0800
X-CSE-ConnectionGUID: quvtwC0ZS4+avrSKJtiIkA==
X-CSE-MsgGUID: FXQzoG2JSSuwbvs0A8nwSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="250548349"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Feb 2026 02:03:23 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqq1B-00000000vHw-3LAt;
	Fri, 13 Feb 2026 10:03:21 +0000
Date: Fri, 13 Feb 2026 18:03:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9e046413910681463c51b1a7940e1536e38a12ae
Message-ID: <202602131801.9ut3wLJh-lkp@intel.com>
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
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20970-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 878D2134D3C
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9e046413910681463c51b1a7940e1536e38a12ae  Merge branch 'pm-powercap' into bleeding-edge

elapsed time: 1190m

configs tested: 229
configs skipped: 6

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
arc                   randconfig-001-20260213    clang-22
arc                   randconfig-002-20260213    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20260213    clang-22
arm                   randconfig-002-20260213    clang-22
arm                   randconfig-003-20260213    clang-22
arm                   randconfig-004-20260213    clang-22
arm                         s3c6400_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260213    clang-17
arm64                 randconfig-001-20260213    clang-20
arm64                 randconfig-002-20260213    clang-20
arm64                 randconfig-003-20260213    clang-20
arm64                 randconfig-003-20260213    clang-22
arm64                 randconfig-004-20260213    clang-20
arm64                 randconfig-004-20260213    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260213    clang-20
csky                  randconfig-001-20260213    gcc-15.2.0
csky                  randconfig-002-20260213    clang-20
csky                  randconfig-002-20260213    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260213    clang-22
hexagon               randconfig-002-20260213    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260213    clang-20
i386        buildonly-randconfig-002-20260213    clang-20
i386        buildonly-randconfig-003-20260213    clang-20
i386        buildonly-randconfig-004-20260213    clang-20
i386        buildonly-randconfig-005-20260213    clang-20
i386        buildonly-randconfig-006-20260213    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260213    gcc-14
i386                  randconfig-002-20260213    gcc-14
i386                  randconfig-003-20260213    gcc-14
i386                  randconfig-004-20260213    gcc-14
i386                  randconfig-005-20260213    gcc-14
i386                  randconfig-006-20260213    gcc-14
i386                  randconfig-007-20260213    gcc-14
i386                  randconfig-011-20260213    gcc-14
i386                  randconfig-012-20260213    gcc-14
i386                  randconfig-013-20260213    gcc-14
i386                  randconfig-014-20260213    gcc-14
i386                  randconfig-015-20260213    gcc-14
i386                  randconfig-016-20260213    gcc-14
i386                  randconfig-017-20260213    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260213    clang-22
loongarch             randconfig-002-20260213    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                 decstation_r4k_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260213    gcc-11.5.0
nios2                 randconfig-002-20260213    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260213    clang-20
parisc                randconfig-001-20260213    gcc-15.2.0
parisc                randconfig-002-20260213    clang-20
parisc                randconfig-002-20260213    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    clang-22
powerpc                      pcm030_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260213    clang-20
powerpc               randconfig-001-20260213    gcc-14.3.0
powerpc               randconfig-002-20260213    clang-20
powerpc                     taishan_defconfig    clang-22
powerpc64             randconfig-001-20260213    clang-20
powerpc64             randconfig-001-20260213    gcc-15.2.0
powerpc64             randconfig-002-20260213    clang-20
powerpc64             randconfig-002-20260213    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260213    gcc-11.5.0
riscv                 randconfig-002-20260213    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260213    gcc-11.5.0
s390                  randconfig-002-20260213    clang-22
s390                  randconfig-002-20260213    gcc-11.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         ap325rxa_defconfig    clang-22
sh                        apsh4ad0a_defconfig    clang-22
sh                                  defconfig    gcc-14
sh                               j2_defconfig    clang-22
sh                    randconfig-001-20260213    gcc-11.5.0
sh                    randconfig-001-20260213    gcc-14.3.0
sh                    randconfig-002-20260213    gcc-11.5.0
sh                    randconfig-002-20260213    gcc-15.2.0
sh                           se7750_defconfig    clang-22
sh                           se7750_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260213    gcc-12.5.0
sparc                 randconfig-001-20260213    gcc-13.4.0
sparc                 randconfig-002-20260213    gcc-12.5.0
sparc                 randconfig-002-20260213    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260213    gcc-12.5.0
sparc64               randconfig-001-20260213    gcc-9.5.0
sparc64               randconfig-002-20260213    clang-22
sparc64               randconfig-002-20260213    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260213    gcc-12.5.0
um                    randconfig-001-20260213    gcc-14
um                    randconfig-002-20260213    clang-22
um                    randconfig-002-20260213    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260213    gcc-14
x86_64      buildonly-randconfig-002-20260213    gcc-14
x86_64      buildonly-randconfig-003-20260213    gcc-14
x86_64      buildonly-randconfig-004-20260213    gcc-14
x86_64      buildonly-randconfig-005-20260213    gcc-14
x86_64      buildonly-randconfig-006-20260213    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260213    gcc-14
x86_64                randconfig-002-20260213    gcc-14
x86_64                randconfig-003-20260213    gcc-14
x86_64                randconfig-004-20260213    gcc-14
x86_64                randconfig-005-20260213    gcc-14
x86_64                randconfig-006-20260213    gcc-14
x86_64                randconfig-011-20260213    gcc-12
x86_64                randconfig-012-20260213    gcc-12
x86_64                randconfig-013-20260213    gcc-12
x86_64                randconfig-014-20260213    gcc-12
x86_64                randconfig-015-20260213    gcc-12
x86_64                randconfig-016-20260213    gcc-12
x86_64                randconfig-071-20260213    clang-20
x86_64                randconfig-072-20260213    clang-20
x86_64                randconfig-073-20260213    clang-20
x86_64                randconfig-074-20260213    clang-20
x86_64                randconfig-075-20260213    clang-20
x86_64                randconfig-076-20260213    clang-20
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
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260213    gcc-12.5.0
xtensa                randconfig-001-20260213    gcc-8.5.0
xtensa                randconfig-002-20260213    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

