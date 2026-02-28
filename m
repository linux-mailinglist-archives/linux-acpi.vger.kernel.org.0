Return-Path: <linux-acpi+bounces-21244-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F6dI5q1omma5AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21244-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 10:30:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B81C1BED
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 10:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A599E303F060
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00A39448B;
	Sat, 28 Feb 2026 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiVo4bFH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4993612FA;
	Sat, 28 Feb 2026 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772271000; cv=none; b=HKVXnSzZR3iaP0jONe/dmSQpOUAZxOiiDD2rDgPDPAeYKPWb7tXe1aXhEOWP6uekRZA3ekVwZtZul/eulGuMEUyjrJWW3cd5gqnPoMFzIf7fQ8LYdxqB/A2TgFtgEoOOiiH3aIdN4TgsZGs/jLkLaNlu6Ft+j5VJx7GOX1+A0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772271000; c=relaxed/simple;
	bh=liO+HmHg9QqPELGlojRhHiEKl9/vetrdZ8Kqh4CgOW4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JSyRR4u4gbqZ/p5TogGfPdJ+dTa+Ily+pGfZd3YWPqvVEIute0hYzalv2ESK9KKFi+5X3a7rG5o3HmObsSo1WPtNR+hJVR04pcT/LWa8Za/rYT1NjwSWNa06FK6Z+lJqymeMqtfiaP2gJGbXDOzE4oJ9m4v/V7gwLzelwDa5Wdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiVo4bFH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772270997; x=1803806997;
  h=date:from:to:cc:subject:message-id;
  bh=liO+HmHg9QqPELGlojRhHiEKl9/vetrdZ8Kqh4CgOW4=;
  b=CiVo4bFH6xBuAbRfr+kZTKEKrcQFbYB5QpaZYOENzRvY24EDLKveGK07
   4dc9TvxNKUJ+ks+sXMRq/jeMbkhodNgKMY0jOqhRp3ZHAaThzI1wqBAJm
   ein0OrCdgL6EyBxGoMRC5p5GdoUv8dmihIY9GGgKLDLLhj/QL9Ac3YrYO
   3nv5EKu2gW1OfHOm44XENpqajdECHza1uUi80ZwuOB+8ZGpiuul9gLj/+
   LYobMxJBfCTrfL3yRoySYpbDffeq4eSonKwgW3/cbz8lf8zfUapr1i+UY
   W2wAYxQIw/8TDSSB9FtGsXybQUMkJ7BpVGBL5zGP/VD6XA8DP7htK8uRc
   w==;
X-CSE-ConnectionGUID: YVMs8awDS5S1+rOi0YpPDw==
X-CSE-MsgGUID: HD0f/8c5SCi7CoCbKq4Gmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73051838"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73051838"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 01:29:56 -0800
X-CSE-ConnectionGUID: UzBlxNqeTfGB5MSGcN6RjQ==
X-CSE-MsgGUID: q93DO59WTIC/FkJewxiTnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="215708660"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 28 Feb 2026 01:29:54 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwGe0-00000000BQl-06LG;
	Sat, 28 Feb 2026 09:29:52 +0000
Date: Sat, 28 Feb 2026 17:29:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 578311c81f9516a6e85c7e7144fad076857f2ba1
Message-ID: <202602281752.DPRtl2Sl-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21244-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F09B81C1BED
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 578311c81f9516a6e85c7e7144fad076857f2ba1  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 757m

configs tested: 286
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
arc                          axs101_defconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-23
arc                        nsimosci_defconfig    clang-23
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260228    gcc-14.3.0
arc                   randconfig-002-20260228    gcc-14.3.0
arc                   randconfig-002-20260228    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                       imx_v6_v7_defconfig    gcc-15.2.0
arm                      integrator_defconfig    gcc-15.2.0
arm                        keystone_defconfig    gcc-15.2.0
arm                            mps2_defconfig    clang-23
arm                        multi_v5_defconfig    clang-23
arm                        mvebu_v5_defconfig    clang-23
arm                             mxs_defconfig    clang-23
arm                   randconfig-001-20260228    clang-16
arm                   randconfig-001-20260228    gcc-14.3.0
arm                   randconfig-002-20260228    clang-23
arm                   randconfig-002-20260228    gcc-14.3.0
arm                   randconfig-003-20260228    clang-23
arm                   randconfig-003-20260228    gcc-14.3.0
arm                   randconfig-004-20260228    gcc-11.5.0
arm                   randconfig-004-20260228    gcc-14.3.0
arm                           sama5_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    clang-23
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260228    clang-23
arm64                 randconfig-002-20260228    clang-23
arm64                 randconfig-003-20260228    clang-23
arm64                 randconfig-004-20260228    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260228    clang-23
csky                  randconfig-002-20260228    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260228    clang-23
hexagon               randconfig-002-20260228    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260228    clang-20
i386        buildonly-randconfig-002-20260228    clang-20
i386        buildonly-randconfig-003-20260228    clang-20
i386        buildonly-randconfig-004-20260228    clang-20
i386        buildonly-randconfig-005-20260228    clang-20
i386        buildonly-randconfig-006-20260228    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260228    gcc-13
i386                  randconfig-001-20260228    gcc-14
i386                  randconfig-002-20260228    gcc-14
i386                  randconfig-003-20260228    gcc-14
i386                  randconfig-004-20260228    clang-20
i386                  randconfig-004-20260228    gcc-14
i386                  randconfig-005-20260228    clang-20
i386                  randconfig-005-20260228    gcc-14
i386                  randconfig-006-20260228    clang-20
i386                  randconfig-006-20260228    gcc-14
i386                  randconfig-007-20260228    gcc-14
i386                  randconfig-011-20260228    gcc-14
i386                  randconfig-012-20260228    gcc-14
i386                  randconfig-013-20260228    gcc-14
i386                  randconfig-014-20260228    gcc-14
i386                  randconfig-015-20260228    gcc-14
i386                  randconfig-016-20260228    gcc-14
i386                  randconfig-017-20260228    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260228    clang-23
loongarch             randconfig-002-20260228    clang-23
loongarch             randconfig-002-20260228    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    clang-23
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                            q40_defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-15.2.0
mips                      loongson1_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-15.2.0
mips                          rm200_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260228    clang-23
nios2                 randconfig-001-20260228    gcc-11.5.0
nios2                 randconfig-002-20260228    clang-23
nios2                 randconfig-002-20260228    gcc-11.5.0
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
parisc                randconfig-001-20260228    gcc-8.5.0
parisc                randconfig-001-20260228    gcc-9.5.0
parisc                randconfig-002-20260228    gcc-8.5.0
parisc                randconfig-002-20260228    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    clang-23
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                          g5_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    clang-23
powerpc                     mpc5200_defconfig    clang-23
powerpc                  mpc866_ads_defconfig    clang-23
powerpc                     powernv_defconfig    clang-23
powerpc                         ps3_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260228    clang-23
powerpc               randconfig-001-20260228    gcc-8.5.0
powerpc               randconfig-002-20260228    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     sequoia_defconfig    clang-23
powerpc                     skiroot_defconfig    clang-23
powerpc                     taishan_defconfig    gcc-15.2.0
powerpc                      tqm8xx_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260228    gcc-12.5.0
powerpc64             randconfig-001-20260228    gcc-8.5.0
powerpc64             randconfig-002-20260228    gcc-10.5.0
powerpc64             randconfig-002-20260228    gcc-8.5.0
riscv                            alldefconfig    clang-23
riscv                            alldefconfig    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260228    gcc-11.5.0
riscv                 randconfig-001-20260228    gcc-15.2.0
riscv                 randconfig-002-20260228    gcc-15.2.0
riscv                 randconfig-002-20260228    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260228    gcc-15.2.0
s390                  randconfig-001-20260228    gcc-8.5.0
s390                  randconfig-002-20260228    gcc-15.2.0
s390                  randconfig-002-20260228    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    clang-23
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                        edosk7760_defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260228    gcc-15.2.0
sh                    randconfig-002-20260228    gcc-15.2.0
sh                           se7722_defconfig    gcc-15.2.0
sh                           se7751_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260228    gcc-12.5.0
sparc                 randconfig-001-20260228    gcc-9.5.0
sparc                 randconfig-002-20260228    gcc-15.2.0
sparc                 randconfig-002-20260228    gcc-9.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260228    gcc-15.2.0
sparc64               randconfig-001-20260228    gcc-9.5.0
sparc64               randconfig-002-20260228    gcc-9.5.0
um                               alldefconfig    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260228    clang-20
um                    randconfig-001-20260228    gcc-9.5.0
um                    randconfig-002-20260228    gcc-14
um                    randconfig-002-20260228    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260228    gcc-14
x86_64      buildonly-randconfig-002-20260228    gcc-14
x86_64      buildonly-randconfig-003-20260228    clang-20
x86_64      buildonly-randconfig-003-20260228    gcc-14
x86_64      buildonly-randconfig-004-20260228    clang-20
x86_64      buildonly-randconfig-004-20260228    gcc-14
x86_64      buildonly-randconfig-005-20260228    gcc-14
x86_64      buildonly-randconfig-006-20260228    clang-20
x86_64      buildonly-randconfig-006-20260228    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260228    clang-20
x86_64                randconfig-001-20260228    gcc-14
x86_64                randconfig-002-20260228    gcc-14
x86_64                randconfig-003-20260228    clang-20
x86_64                randconfig-003-20260228    gcc-14
x86_64                randconfig-004-20260228    gcc-14
x86_64                randconfig-005-20260228    gcc-14
x86_64                randconfig-006-20260228    gcc-14
x86_64                randconfig-011-20260228    clang-20
x86_64                randconfig-011-20260228    gcc-14
x86_64                randconfig-012-20260228    clang-20
x86_64                randconfig-012-20260228    gcc-14
x86_64                randconfig-013-20260228    gcc-13
x86_64                randconfig-013-20260228    gcc-14
x86_64                randconfig-014-20260228    gcc-14
x86_64                randconfig-015-20260228    clang-20
x86_64                randconfig-015-20260228    gcc-14
x86_64                randconfig-016-20260228    gcc-14
x86_64                randconfig-071-20260228    clang-20
x86_64                randconfig-071-20260228    gcc-14
x86_64                randconfig-072-20260228    gcc-14
x86_64                randconfig-073-20260228    gcc-14
x86_64                randconfig-074-20260228    gcc-14
x86_64                randconfig-075-20260228    clang-20
x86_64                randconfig-075-20260228    gcc-14
x86_64                randconfig-076-20260228    clang-20
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
xtensa                  nommu_kc705_defconfig    clang-23
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260228    gcc-8.5.0
xtensa                randconfig-001-20260228    gcc-9.5.0
xtensa                randconfig-002-20260228    gcc-12.5.0
xtensa                randconfig-002-20260228    gcc-9.5.0
xtensa                    smp_lx200_defconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

