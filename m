Return-Path: <linux-acpi+bounces-21176-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKg9BgGpn2mddAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21176-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 02:59:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB8C19FF73
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 02:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0285B300D4D8
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 01:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD5372B44;
	Thu, 26 Feb 2026 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpOADs8A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5863F2CCB9;
	Thu, 26 Feb 2026 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071166; cv=none; b=AgvAClOvWQf40vTRVLAxcYln9vqoq/2qTZbXAHg/d+YP0S73PXpajHqlmc1lvaDUK0/eEYDWX2ZRkZWk5CXZS4SSAU9Z7xoQs2wIK0ziVHT99UCQR8mtTAUHfdH2f71HZ/PTzlvH086M1eoOSkOzy9UI1FtcYWOVKEr+6FmdgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071166; c=relaxed/simple;
	bh=uYSQVuyVd3FwAy+UGxuusxgD3G4ANeTiq0Ie1Nulkg0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=L3K4d3I4leRMDS0xuL3H47RM8aaACLgDhmNMwfRQEhxP2a2ogMccpYdAiWdAt+hWh3HxxuOciPmU2vL6Q16oKhQ/3+SajEpQzx0BIJ0hSAM0Zv7sDWtGlXfpMvs8Ar8je7QCDrsPBvqJq+/2NKhQGA9AoME5gRlvi5KSLngMT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpOADs8A; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772071165; x=1803607165;
  h=date:from:to:cc:subject:message-id;
  bh=uYSQVuyVd3FwAy+UGxuusxgD3G4ANeTiq0Ie1Nulkg0=;
  b=DpOADs8AZVy1IzR/fa0NyM/prBnIVF6OOFCigwmyHdXfECzAsTLY5tdy
   msHLyrLwGTR/jstiE4G/xlC5ATG+b2gQYUobMfdbjVX6DpZztIma0gx+e
   vi6npCF6Curk04CucnHznFxq4ZBmEfUCzu5MGrpwvjRMSnPUx7NlGCK2t
   LUvRQaHKU3uT9AZSGO+OilWNv3pVErnb+GfZOpL7KiR/9NpElHc/ucveJ
   eM5UpqK4zdLyt1z+NsVyFn9Mvv0Ft517mOaKFa41jOSozfCNj8Oxbi2Ea
   RaqwDnzbr/nAMG76ber5Zyw+L6Id5J/4WhUbuMRc8sWriKwAqIclTRHm8
   w==;
X-CSE-ConnectionGUID: aq+ueOwwTEK7V7UqGnuCgQ==
X-CSE-MsgGUID: qsrsYzEGSjGqIVV9VV9vjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="90705664"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="90705664"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 17:59:24 -0800
X-CSE-ConnectionGUID: m0tzRaWFSZCA0ysGXpNnxA==
X-CSE-MsgGUID: 8MIJj7nfTf2qzNrW/DV/og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="214459031"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 25 Feb 2026 17:59:22 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvQeu-000000007sL-07oI;
	Thu, 26 Feb 2026 01:59:20 +0000
Date: Thu, 26 Feb 2026 09:59:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 8b4537a870e1fd9476a138587c93c9999c7b0a4f
Message-ID: <202602260910.OkDzyXRj-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-21176-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: ADB8C19FF73
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 8b4537a870e1fd9476a138587c93c9999c7b0a4f  Merge branch 'pm-cpufreq' into fixes

elapsed time: 722m

configs tested: 311
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
arc                              allyesconfig    clang-23
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260225    gcc-8.5.0
arc                   randconfig-001-20260226    gcc-15.2.0
arc                   randconfig-002-20260225    gcc-8.5.0
arc                   randconfig-002-20260226    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                       aspeed_g4_defconfig    gcc-15.2.0
arm                       aspeed_g5_defconfig    gcc-15.2.0
arm                         axm55xx_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260225    gcc-8.5.0
arm                   randconfig-001-20260226    gcc-15.2.0
arm                   randconfig-002-20260225    gcc-8.5.0
arm                   randconfig-002-20260226    gcc-15.2.0
arm                   randconfig-003-20260225    gcc-8.5.0
arm                   randconfig-003-20260226    gcc-15.2.0
arm                   randconfig-004-20260225    gcc-8.5.0
arm                   randconfig-004-20260226    gcc-15.2.0
arm                        shmobile_defconfig    gcc-15.2.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260225    gcc-9.5.0
arm64                 randconfig-001-20260226    gcc-14.3.0
arm64                 randconfig-002-20260225    gcc-9.5.0
arm64                 randconfig-002-20260226    gcc-14.3.0
arm64                 randconfig-003-20260225    gcc-9.5.0
arm64                 randconfig-003-20260226    gcc-14.3.0
arm64                 randconfig-004-20260225    gcc-9.5.0
arm64                 randconfig-004-20260226    gcc-14.3.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260225    gcc-9.5.0
csky                  randconfig-001-20260226    gcc-14.3.0
csky                  randconfig-002-20260225    gcc-9.5.0
csky                  randconfig-002-20260226    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260225    clang-23
hexagon               randconfig-001-20260226    clang-23
hexagon               randconfig-002-20260225    clang-23
hexagon               randconfig-002-20260226    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260225    clang-20
i386        buildonly-randconfig-001-20260226    gcc-14
i386        buildonly-randconfig-002-20260225    clang-20
i386        buildonly-randconfig-002-20260226    gcc-14
i386        buildonly-randconfig-003-20260225    clang-20
i386        buildonly-randconfig-003-20260226    gcc-14
i386        buildonly-randconfig-004-20260225    clang-20
i386        buildonly-randconfig-004-20260226    gcc-14
i386        buildonly-randconfig-005-20260225    clang-20
i386        buildonly-randconfig-005-20260226    gcc-14
i386        buildonly-randconfig-006-20260225    clang-20
i386        buildonly-randconfig-006-20260226    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260225    gcc-14
i386                  randconfig-001-20260226    clang-20
i386                  randconfig-002-20260225    gcc-14
i386                  randconfig-002-20260226    clang-20
i386                  randconfig-003-20260225    gcc-14
i386                  randconfig-003-20260226    clang-20
i386                  randconfig-004-20260225    gcc-14
i386                  randconfig-004-20260226    clang-20
i386                  randconfig-005-20260225    gcc-14
i386                  randconfig-005-20260226    clang-20
i386                  randconfig-006-20260225    gcc-14
i386                  randconfig-006-20260226    clang-20
i386                  randconfig-007-20260225    gcc-14
i386                  randconfig-007-20260226    clang-20
i386                  randconfig-011-20260225    gcc-13
i386                  randconfig-011-20260226    gcc-14
i386                  randconfig-012-20260225    gcc-13
i386                  randconfig-012-20260226    gcc-14
i386                  randconfig-013-20260225    gcc-13
i386                  randconfig-013-20260226    gcc-14
i386                  randconfig-014-20260225    gcc-13
i386                  randconfig-014-20260226    gcc-14
i386                  randconfig-015-20260225    gcc-13
i386                  randconfig-015-20260226    gcc-14
i386                  randconfig-016-20260225    gcc-13
i386                  randconfig-016-20260226    gcc-14
i386                  randconfig-017-20260225    gcc-13
i386                  randconfig-017-20260226    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    clang-23
loongarch             randconfig-001-20260225    clang-23
loongarch             randconfig-001-20260226    clang-23
loongarch             randconfig-002-20260225    clang-23
loongarch             randconfig-002-20260226    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    clang-23
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-15.2.0
m68k                            mac_defconfig    clang-23
m68k                          multi_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                          eyeq6_defconfig    gcc-15.2.0
mips                           ip22_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-23
mips                      maltasmvp_defconfig    clang-23
mips                        maltaup_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260225    clang-23
nios2                 randconfig-001-20260226    clang-23
nios2                 randconfig-002-20260225    clang-23
nios2                 randconfig-002-20260226    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260225    clang-19
parisc                randconfig-001-20260225    gcc-15.2.0
parisc                randconfig-001-20260226    clang-16
parisc                randconfig-002-20260225    clang-19
parisc                randconfig-002-20260225    gcc-8.5.0
parisc                randconfig-002-20260226    clang-16
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                      katmai_defconfig    gcc-15.2.0
powerpc                   lite5200b_defconfig    clang-23
powerpc               randconfig-001-20260225    clang-19
powerpc               randconfig-001-20260225    gcc-12.5.0
powerpc               randconfig-001-20260226    clang-16
powerpc               randconfig-002-20260225    clang-19
powerpc               randconfig-002-20260226    clang-16
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc                        warp_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260225    clang-19
powerpc64             randconfig-001-20260225    clang-23
powerpc64             randconfig-001-20260226    clang-16
powerpc64             randconfig-002-20260225    clang-19
powerpc64             randconfig-002-20260225    gcc-15.2.0
powerpc64             randconfig-002-20260226    clang-16
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260225    gcc-12.5.0
riscv                 randconfig-002-20260225    gcc-12.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260225    gcc-12.5.0
s390                  randconfig-002-20260225    gcc-12.5.0
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                         ap325rxa_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          landisk_defconfig    clang-23
sh                    randconfig-001-20260225    gcc-12.5.0
sh                    randconfig-002-20260225    gcc-12.5.0
sh                          sdk7780_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-15.2.0
sh                   sh7724_generic_defconfig    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260225    gcc-11.5.0
sparc                 randconfig-001-20260226    gcc-8.5.0
sparc                 randconfig-002-20260225    gcc-11.5.0
sparc                 randconfig-002-20260226    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260225    gcc-11.5.0
sparc64               randconfig-001-20260226    gcc-8.5.0
sparc64               randconfig-002-20260225    gcc-11.5.0
sparc64               randconfig-002-20260226    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260225    gcc-11.5.0
um                    randconfig-001-20260226    gcc-8.5.0
um                    randconfig-002-20260225    gcc-11.5.0
um                    randconfig-002-20260226    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260225    clang-20
x86_64      buildonly-randconfig-001-20260226    gcc-14
x86_64      buildonly-randconfig-002-20260225    clang-20
x86_64      buildonly-randconfig-002-20260226    gcc-14
x86_64      buildonly-randconfig-003-20260225    clang-20
x86_64      buildonly-randconfig-003-20260226    gcc-14
x86_64      buildonly-randconfig-004-20260225    clang-20
x86_64      buildonly-randconfig-004-20260226    gcc-14
x86_64      buildonly-randconfig-005-20260225    clang-20
x86_64      buildonly-randconfig-005-20260226    gcc-14
x86_64      buildonly-randconfig-006-20260225    clang-20
x86_64      buildonly-randconfig-006-20260226    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260225    gcc-14
x86_64                randconfig-001-20260226    gcc-14
x86_64                randconfig-002-20260225    gcc-14
x86_64                randconfig-002-20260226    gcc-14
x86_64                randconfig-003-20260225    gcc-14
x86_64                randconfig-003-20260226    gcc-14
x86_64                randconfig-004-20260225    gcc-14
x86_64                randconfig-004-20260226    gcc-14
x86_64                randconfig-005-20260225    gcc-14
x86_64                randconfig-005-20260226    gcc-14
x86_64                randconfig-006-20260225    gcc-14
x86_64                randconfig-006-20260226    gcc-14
x86_64                randconfig-011-20260225    gcc-14
x86_64                randconfig-011-20260226    gcc-14
x86_64                randconfig-012-20260225    gcc-14
x86_64                randconfig-012-20260226    gcc-14
x86_64                randconfig-013-20260225    gcc-14
x86_64                randconfig-013-20260226    gcc-14
x86_64                randconfig-014-20260225    gcc-14
x86_64                randconfig-014-20260226    gcc-14
x86_64                randconfig-015-20260225    gcc-14
x86_64                randconfig-015-20260226    gcc-14
x86_64                randconfig-016-20260225    gcc-14
x86_64                randconfig-016-20260226    gcc-14
x86_64                randconfig-071-20260225    clang-20
x86_64                randconfig-071-20260226    gcc-14
x86_64                randconfig-072-20260225    clang-20
x86_64                randconfig-072-20260226    gcc-14
x86_64                randconfig-073-20260225    clang-20
x86_64                randconfig-073-20260226    gcc-14
x86_64                randconfig-074-20260225    clang-20
x86_64                randconfig-074-20260226    gcc-14
x86_64                randconfig-075-20260225    clang-20
x86_64                randconfig-075-20260226    gcc-14
x86_64                randconfig-076-20260225    clang-20
x86_64                randconfig-076-20260226    gcc-14
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
xtensa                       common_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260225    gcc-11.5.0
xtensa                randconfig-001-20260226    gcc-8.5.0
xtensa                randconfig-002-20260225    gcc-11.5.0
xtensa                randconfig-002-20260226    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0
xtensa                         virt_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

