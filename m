Return-Path: <linux-acpi+bounces-21006-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id onyxL39DlWlsNwIAu9opvQ
	(envelope-from <linux-acpi+bounces-21006-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 05:43:43 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1848D1530E7
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 05:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C53D530470B8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 04:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89742F6927;
	Wed, 18 Feb 2026 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0hxy6ql"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8A2E8DEB;
	Wed, 18 Feb 2026 04:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389818; cv=none; b=Qg0lNLU8wtCXFek92L2W1KgI1gk1e+jX1wrUlQk6dJASNfPUj7h288xpGCIgLLwVLf/VNHGwWwoEqozEc6IzHW8zTfoRNHXf7D1DoXNZFrij8BamQnuqYcY/7AFnaUkpTWdU33Dn4uXKxxg8V0lRI8rwyv+V5NRRp74RcmkEs1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389818; c=relaxed/simple;
	bh=9cf/D73cO3zRhQnITncroy84Ca+wkhK1TtmVMFSTlNs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YkcjXoNd5G3OPv0flwQNuF93Mzxj5RO6AJpgpkhO7iegnLiXPhPwpoWJzCHWBKEN713b0LCzunAJB7uK97x/DQ20HutbrrOGwfImEk1S8u/Cj9Y7WJ87H+1xI5/6fxK1wbyqx8WhaHSr9zm4P9iKvfTOEkugy30+bE3oskt1Aig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0hxy6ql; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771389817; x=1802925817;
  h=date:from:to:cc:subject:message-id;
  bh=9cf/D73cO3zRhQnITncroy84Ca+wkhK1TtmVMFSTlNs=;
  b=c0hxy6qlF3/3IyuG9LqqxuNSey7Gf8VhpzCbxBAmz/3eL1vpYnWTMASb
   wR/l5rtLQUtYyBMSllHds5aO10849tWPCQpMfl7mbEcAFplNPBwAmuKn5
   jGuQ/m496uBtIt+Xq+P7J60TbuM3KDnktMmOz9Bg/bb2pYT0uax+/pYyv
   nMPxg86uwbuwTRjO9MUAdYJCrNZFOWTRs4YMx7sqJzlSIrQYBgoE6B3t7
   rluZozD5N8tgCUQrSFOJ3acqemQH0t3qNzIvd4hWd+GOMMNbZuayBJ3iT
   v2Vs8tcUfe1Plvvg0rq/lXfK/U8hjW0gqVFCmTBbXGtQ5HAXyJerT6fsY
   w==;
X-CSE-ConnectionGUID: hR5K6nTnQI+cE9WJqtAGqA==
X-CSE-MsgGUID: iLv0OO46SKWUGXSwbZzX2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83571391"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="83571391"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 20:43:36 -0800
X-CSE-ConnectionGUID: w/vuuIp1QHKpgxC/CB9q4g==
X-CSE-MsgGUID: UiYP0CfZTbieoPGHXOnYfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="213936676"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Feb 2026 20:43:34 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsZPQ-0000000123k-1Sye;
	Wed, 18 Feb 2026 04:43:32 +0000
Date: Wed, 18 Feb 2026 12:43:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2ea3c5304b219f05b937e7cab78dd788355a250e
Message-ID: <202602181210.WQzVX849-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-21006-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 1848D1530E7
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2ea3c5304b219f05b937e7cab78dd788355a250e  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 821m

configs tested: 205
configs skipped: 3

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
arc                     haps_hs_smp_defconfig    clang-23
arc                   randconfig-001-20260218    clang-23
arc                   randconfig-002-20260218    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                            hisi_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    clang-23
arm                         orion5x_defconfig    clang-23
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260218    clang-23
arm                   randconfig-002-20260218    clang-23
arm                   randconfig-003-20260218    clang-23
arm                   randconfig-004-20260218    clang-23
arm                         socfpga_defconfig    clang-23
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260218    clang-23
arm64                 randconfig-002-20260218    clang-23
arm64                 randconfig-003-20260218    clang-23
arm64                 randconfig-004-20260218    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260218    clang-23
csky                  randconfig-002-20260218    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260218    clang-16
hexagon               randconfig-002-20260218    clang-16
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260218    clang-20
i386        buildonly-randconfig-002-20260218    clang-20
i386        buildonly-randconfig-003-20260218    clang-20
i386        buildonly-randconfig-004-20260218    clang-20
i386        buildonly-randconfig-005-20260218    clang-20
i386        buildonly-randconfig-006-20260218    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260218    clang-20
i386                  randconfig-002-20260218    clang-20
i386                  randconfig-003-20260218    clang-20
i386                  randconfig-004-20260218    clang-20
i386                  randconfig-005-20260218    clang-20
i386                  randconfig-006-20260218    clang-20
i386                  randconfig-007-20260218    clang-20
i386                  randconfig-011-20260218    gcc-14
i386                  randconfig-012-20260218    gcc-14
i386                  randconfig-013-20260218    gcc-14
i386                  randconfig-014-20260218    gcc-14
i386                  randconfig-015-20260218    gcc-14
i386                  randconfig-016-20260218    gcc-14
i386                  randconfig-017-20260218    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260218    clang-16
loongarch             randconfig-002-20260218    clang-16
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260218    clang-16
nios2                 randconfig-002-20260218    clang-16
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260218    gcc-8.5.0
parisc                randconfig-002-20260218    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      ep88xc_defconfig    clang-23
powerpc                     kmeter1_defconfig    clang-23
powerpc                     ppa8548_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260218    gcc-8.5.0
powerpc               randconfig-002-20260218    gcc-8.5.0
powerpc64             randconfig-001-20260218    gcc-8.5.0
powerpc64             randconfig-002-20260218    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260218    clang-23
riscv                 randconfig-002-20260218    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260218    clang-23
s390                  randconfig-002-20260218    clang-23
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               alldefconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260218    clang-23
sh                    randconfig-002-20260218    clang-23
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260218    gcc-10.5.0
sparc                 randconfig-002-20260218    gcc-10.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260218    gcc-10.5.0
sparc64               randconfig-002-20260218    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260218    gcc-10.5.0
um                    randconfig-002-20260218    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260218    gcc-14
x86_64      buildonly-randconfig-002-20260218    gcc-14
x86_64      buildonly-randconfig-003-20260218    gcc-14
x86_64      buildonly-randconfig-004-20260218    gcc-14
x86_64      buildonly-randconfig-005-20260218    gcc-14
x86_64      buildonly-randconfig-006-20260218    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260218    gcc-14
x86_64                randconfig-002-20260218    gcc-14
x86_64                randconfig-003-20260218    gcc-14
x86_64                randconfig-004-20260218    gcc-14
x86_64                randconfig-005-20260218    gcc-14
x86_64                randconfig-006-20260218    gcc-14
x86_64                randconfig-011-20260218    gcc-13
x86_64                randconfig-012-20260218    gcc-13
x86_64                randconfig-013-20260218    gcc-13
x86_64                randconfig-014-20260218    gcc-13
x86_64                randconfig-015-20260218    gcc-13
x86_64                randconfig-016-20260218    gcc-13
x86_64                randconfig-071-20260218    clang-20
x86_64                randconfig-072-20260218    clang-20
x86_64                randconfig-073-20260218    clang-20
x86_64                randconfig-074-20260218    clang-20
x86_64                randconfig-075-20260218    clang-20
x86_64                randconfig-076-20260218    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260218    gcc-10.5.0
xtensa                randconfig-002-20260218    gcc-10.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

