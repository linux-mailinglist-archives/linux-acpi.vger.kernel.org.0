Return-Path: <linux-acpi+bounces-20986-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i/oyM2pBkGkIYAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20986-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 10:33:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9140113B923
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 341EF3005331
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Feb 2026 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931D327A907;
	Sat, 14 Feb 2026 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjSaP4D8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA411EA84;
	Sat, 14 Feb 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771061605; cv=none; b=r68QB0TBhd7szvPmAbYpIK6/3XTgwLlfCo7it8G9a9FvjAWvVUzqv/Jt5aC2OeTy3Qpc7aYcViSF/CDTMs44tQ1F8BmxTP4Pm+4tO3nMMpFRaFYtOnqowQQ4cc3KGdvi/UohEHDTGB4WjuaOkgpetUt2lN8FM6FuqABsaP2n0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771061605; c=relaxed/simple;
	bh=zioWcV3yrMxkUlRYSxMwx/s62WR4glZRFVrG0KOpf6g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dlHcr2qAYiKAfNJdXiH/RM+J1Xen4ETx9Gkhk2Kh+1LcsNlEA9Hi6GMZ7eawHfdxNIhXXV6f+29yv2dLyu1z9dMATEJcQqbEW0deyGI//f0eLMNFmDyZJDtrstjEVLbVzAzVY+Lye4WD8FKdJuWE91nZmOTQy26Ot/4Y7xlpbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjSaP4D8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771061603; x=1802597603;
  h=date:from:to:cc:subject:message-id;
  bh=zioWcV3yrMxkUlRYSxMwx/s62WR4glZRFVrG0KOpf6g=;
  b=IjSaP4D8K6HMyCoKCKrlDppFKzaqaKS2yhP15h6G88UvUuiNZrUM9B9W
   H9Rm4b8kTyX4W4tgnx/PoPiBQJo20gijjAl0dWdb0iQ97sKeIZ2E6g1rZ
   4rGaC0Dpj8bT8wAFw1BSZCQyoUWi/1Bvxt1m14lvPAnl7U4DF8pkDQ4NK
   u6wqLD/sY3HaT18OAUlfFvLakZzyszTLDFhmktgzz1YLJ3xojFjTvAtnL
   i2csf6K847pKRDgTreGd981iuXNLs5NP3HVqTjxE6Ozn82ZTQt3VDdoy3
   I2qS/TQFMu5vaizMXLlog0K603jzeXeI+xU7q+n/IIyug9+aRsWHmfNgt
   g==;
X-CSE-ConnectionGUID: Rn7VJVW5Ti+LKLP7/xOaqw==
X-CSE-MsgGUID: d+lnOsJOR9K86WVO9KzRWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="76080360"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="76080360"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 01:33:23 -0800
X-CSE-ConnectionGUID: uftb2b7kQZODM7FqR34F9g==
X-CSE-MsgGUID: uUaKBo7OReaMeZFekl0XRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="213154862"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Feb 2026 01:33:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrC1d-00000000wQG-3n49;
	Sat, 14 Feb 2026 09:33:17 +0000
Date: Sat, 14 Feb 2026 17:32:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 98a6068a3cb1c13d125abed7f2623665d74c2730
Message-ID: <202602141736.CKfQKGmg-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20986-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 9140113B923
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 98a6068a3cb1c13d125abed7f2623665d74c2730  Merge branch 'acpi-driver' into bleeding-edge

elapsed time: 731m

configs tested: 201
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260214    clang-22
arc                   randconfig-002-20260214    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    gcc-15.2.0
arm                         lpc32xx_defconfig    clang-22
arm                            mps2_defconfig    clang-22
arm                   randconfig-001-20260214    clang-22
arm                   randconfig-002-20260214    clang-22
arm                   randconfig-003-20260214    clang-22
arm                   randconfig-004-20260214    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260214    gcc-8.5.0
arm64                 randconfig-002-20260214    gcc-8.5.0
arm64                 randconfig-003-20260214    gcc-8.5.0
arm64                 randconfig-004-20260214    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260214    gcc-8.5.0
csky                  randconfig-002-20260214    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260214    clang-22
hexagon               randconfig-002-20260214    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260214    clang-20
i386        buildonly-randconfig-002-20260214    clang-20
i386        buildonly-randconfig-003-20260214    clang-20
i386        buildonly-randconfig-004-20260214    clang-20
i386        buildonly-randconfig-005-20260214    clang-20
i386        buildonly-randconfig-006-20260214    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-011-20260214    gcc-14
i386                  randconfig-012-20260214    gcc-14
i386                  randconfig-013-20260214    gcc-14
i386                  randconfig-014-20260214    gcc-14
i386                  randconfig-015-20260214    gcc-14
i386                  randconfig-016-20260214    gcc-14
i386                  randconfig-017-20260214    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260214    clang-22
loongarch             randconfig-002-20260214    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-22
mips                           ip22_defconfig    gcc-15.2.0
mips                       lemote2f_defconfig    clang-22
mips                      malta_kvm_defconfig    clang-22
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260214    clang-22
nios2                 randconfig-002-20260214    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260214    clang-22
parisc                randconfig-002-20260214    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                          g5_defconfig    gcc-15.2.0
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc               randconfig-001-20260214    clang-22
powerpc               randconfig-002-20260214    clang-22
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260214    clang-22
powerpc64             randconfig-002-20260214    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260214    clang-20
riscv                 randconfig-001-20260214    gcc-8.5.0
riscv                 randconfig-002-20260214    clang-20
riscv                 randconfig-002-20260214    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260214    clang-20
s390                  randconfig-002-20260214    clang-20
s390                  randconfig-002-20260214    gcc-9.5.0
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    clang-22
sh                    randconfig-001-20260214    clang-20
sh                    randconfig-001-20260214    gcc-10.5.0
sh                    randconfig-002-20260214    clang-20
sh                    randconfig-002-20260214    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260214    gcc-14.3.0
sparc                 randconfig-001-20260214    gcc-8.5.0
sparc                 randconfig-002-20260214    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260214    gcc-14.3.0
sparc64               randconfig-001-20260214    gcc-9.5.0
sparc64               randconfig-002-20260214    gcc-14.3.0
sparc64               randconfig-002-20260214    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260214    gcc-14
um                    randconfig-001-20260214    gcc-14.3.0
um                    randconfig-002-20260214    clang-22
um                    randconfig-002-20260214    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260214    clang-20
x86_64      buildonly-randconfig-001-20260214    gcc-13
x86_64      buildonly-randconfig-002-20260214    clang-20
x86_64      buildonly-randconfig-002-20260214    gcc-14
x86_64      buildonly-randconfig-003-20260214    clang-20
x86_64      buildonly-randconfig-004-20260214    clang-20
x86_64      buildonly-randconfig-005-20260214    clang-20
x86_64      buildonly-randconfig-006-20260214    clang-20
x86_64      buildonly-randconfig-006-20260214    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20260214    clang-20
x86_64                randconfig-072-20260214    clang-20
x86_64                randconfig-073-20260214    clang-20
x86_64                randconfig-074-20260214    clang-20
x86_64                randconfig-075-20260214    clang-20
x86_64                randconfig-075-20260214    gcc-14
x86_64                randconfig-076-20260214    clang-20
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
xtensa                randconfig-001-20260214    gcc-14.3.0
xtensa                randconfig-001-20260214    gcc-15.2.0
xtensa                randconfig-002-20260214    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

