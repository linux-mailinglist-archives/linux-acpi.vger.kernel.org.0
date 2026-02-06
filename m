Return-Path: <linux-acpi+bounces-20875-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH/cMO2YhWmUDwQAu9opvQ
	(envelope-from <linux-acpi+bounces-20875-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 08:31:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A696FB012
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 08:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D93B330067B1
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161D73101B8;
	Fri,  6 Feb 2026 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixUvnWG7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877B30F95B;
	Fri,  6 Feb 2026 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363112; cv=none; b=Rm/46Ls4GjKkMx1DRxP+adoieso6kr+AJIDN6lJgVTPpRlNvVBeWRkT9qEychVn5ndTsafp9kF7xVUwHGX6B7eQ2PzRt1LblT6K76+VQul7Uu7Ej/L06QC1Ikbek4nxdYcU8MDDfIi5teHuygsOpqFrv6LYbRcvz4XwUrPmHxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363112; c=relaxed/simple;
	bh=33PIRn5WHfIZxzA12McqHPUCooE66ei6yt/D5Gcfy2w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YmVEwU+PwVVP1TE8BzL54t/iuddQO86wj7D+C7DucTmOr2ryC0jjEWIY8/FLDamT9Y3MSfWDZEDtGUCvZSVmlniemECApbMM3JPLCZKfKFoJkxzFUpTF/CDBLfV81VSdagZMuWfMDUTO3BRbRZxz0rqVg5t7BbDqWFzGS6z++kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixUvnWG7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770363111; x=1801899111;
  h=date:from:to:cc:subject:message-id;
  bh=33PIRn5WHfIZxzA12McqHPUCooE66ei6yt/D5Gcfy2w=;
  b=ixUvnWG7TBxU5Gl1qyroVgl+c/TR5k1vHtABxvIaPHhgMO++E/VWmtoq
   QqqCsd3qLltYaM94rLNnxHFRbp5eK+RVNl+Qmr9eCDeF3c99jnjLw4J0P
   dYS+16qnc4xO5Y9HT9RtyCe14lls7QkvWgctYJNGscwzOFjHXv1KfHG/u
   1PRjqlqhmWuzyHhmFCeeufgTArmJbF17kTsk61aP/daF8WmuszNgeoRJR
   vkoSmghYezSLJUiy6bXU7y9pvbaQyKNWpBFrhH5v03Gp4WbfTaFvZCHFe
   asziB3sHFtx24sLebOszF3dAC0cWxw0MvbssDMd9y9gZg5miq2Huoymrv
   g==;
X-CSE-ConnectionGUID: 9bSNd0fiR2SJi+jMcJTJ2g==
X-CSE-MsgGUID: 57V5JFh3RfyAUGrnkNK7oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71561458"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71561458"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 23:31:50 -0800
X-CSE-ConnectionGUID: pUQUuQteTUKA+sZPRKF9Dg==
X-CSE-MsgGUID: sXq0JteTRKC34v8CUw/0Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="241293819"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2026 23:31:48 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voGJe-00000000kXg-0Cgt;
	Fri, 06 Feb 2026 07:31:46 +0000
Date: Fri, 06 Feb 2026 15:31:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 cd15be4828c5585c8423b66d1ab9fb2d7b2db778
Message-ID: <202602061516.UJ5ICMTF-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-20875-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A696FB012
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: cd15be4828c5585c8423b66d1ab9fb2d7b2db778  Merge branch 'pm-runtime-cleanup' into bleeding-edge

elapsed time: 984m

configs tested: 255
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
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260206    gcc-8.5.0
arc                   randconfig-002-20260206    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    clang-22
arm                         axm55xx_defconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    clang-22
arm                          exynos_defconfig    clang-22
arm                       multi_v4t_defconfig    clang-22
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20260206    gcc-8.5.0
arm                   randconfig-002-20260206    gcc-8.5.0
arm                   randconfig-003-20260206    gcc-8.5.0
arm                   randconfig-004-20260206    gcc-8.5.0
arm                           sunxi_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260206    gcc-13.4.0
arm64                 randconfig-001-20260206    gcc-14.3.0
arm64                 randconfig-002-20260206    clang-18
arm64                 randconfig-002-20260206    gcc-13.4.0
arm64                 randconfig-003-20260206    clang-22
arm64                 randconfig-003-20260206    gcc-13.4.0
arm64                 randconfig-004-20260206    gcc-13.4.0
arm64                 randconfig-004-20260206    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260206    gcc-13.4.0
csky                  randconfig-001-20260206    gcc-15.2.0
csky                  randconfig-002-20260206    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260206    clang-22
hexagon               randconfig-002-20260206    clang-22
i386                             alldefconfig    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260206    clang-20
i386        buildonly-randconfig-002-20260206    clang-20
i386        buildonly-randconfig-003-20260206    clang-20
i386        buildonly-randconfig-004-20260206    clang-20
i386        buildonly-randconfig-005-20260206    clang-20
i386        buildonly-randconfig-006-20260206    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260206    gcc-14
i386                  randconfig-002-20260206    gcc-12
i386                  randconfig-002-20260206    gcc-14
i386                  randconfig-003-20260206    gcc-14
i386                  randconfig-004-20260206    gcc-14
i386                  randconfig-005-20260206    gcc-14
i386                  randconfig-006-20260206    gcc-14
i386                  randconfig-007-20260206    gcc-14
i386                  randconfig-011-20260206    clang-20
i386                  randconfig-012-20260206    clang-20
i386                  randconfig-012-20260206    gcc-14
i386                  randconfig-013-20260206    clang-20
i386                  randconfig-013-20260206    gcc-14
i386                  randconfig-014-20260206    clang-20
i386                  randconfig-015-20260206    clang-20
i386                  randconfig-016-20260206    clang-20
i386                  randconfig-017-20260206    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260206    clang-22
loongarch             randconfig-002-20260206    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    clang-22
mips                  decstation_64_defconfig    clang-22
mips                           ip28_defconfig    gcc-15.2.0
mips                      maltasmvp_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260206    clang-22
nios2                 randconfig-002-20260206    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           alldefconfig    clang-22
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260206    gcc-8.5.0
parisc                randconfig-002-20260206    gcc-12.5.0
parisc                randconfig-002-20260206    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    clang-22
powerpc                 canyonlands_defconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-22
powerpc                    gamecube_defconfig    clang-22
powerpc                  iss476-smp_defconfig    clang-22
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                  mpc866_ads_defconfig    gcc-15.2.0
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20260206    gcc-8.5.0
powerpc               randconfig-002-20260206    clang-20
powerpc               randconfig-002-20260206    gcc-8.5.0
powerpc64             randconfig-001-20260206    clang-22
powerpc64             randconfig-001-20260206    gcc-8.5.0
powerpc64             randconfig-002-20260206    gcc-10.5.0
powerpc64             randconfig-002-20260206    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260206    clang-22
riscv                 randconfig-002-20260206    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260206    clang-22
s390                  randconfig-002-20260206    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         ap325rxa_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-15.2.0
sh                    randconfig-001-20260206    clang-22
sh                    randconfig-002-20260206    clang-22
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-15.2.0
sh                   sh7724_generic_defconfig    gcc-15.2.0
sh                        sh7785lcr_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260206    gcc-12.5.0
sparc                 randconfig-001-20260206    gcc-8.5.0
sparc                 randconfig-002-20260206    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260206    gcc-10.5.0
sparc64               randconfig-001-20260206    gcc-12.5.0
sparc64               randconfig-002-20260206    clang-20
sparc64               randconfig-002-20260206    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260206    clang-22
um                    randconfig-001-20260206    gcc-12.5.0
um                    randconfig-002-20260206    gcc-12.5.0
um                    randconfig-002-20260206    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260206    gcc-14
x86_64      buildonly-randconfig-002-20260206    gcc-14
x86_64      buildonly-randconfig-003-20260206    gcc-14
x86_64      buildonly-randconfig-004-20260206    gcc-14
x86_64      buildonly-randconfig-005-20260206    gcc-14
x86_64      buildonly-randconfig-006-20260206    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260206    clang-20
x86_64                randconfig-001-20260206    gcc-14
x86_64                randconfig-002-20260206    gcc-14
x86_64                randconfig-003-20260206    gcc-14
x86_64                randconfig-004-20260206    clang-20
x86_64                randconfig-004-20260206    gcc-14
x86_64                randconfig-005-20260206    gcc-14
x86_64                randconfig-006-20260206    clang-20
x86_64                randconfig-006-20260206    gcc-14
x86_64                randconfig-011-20260206    gcc-14
x86_64                randconfig-012-20260206    clang-20
x86_64                randconfig-012-20260206    gcc-14
x86_64                randconfig-013-20260206    gcc-14
x86_64                randconfig-014-20260206    gcc-14
x86_64                randconfig-015-20260206    gcc-14
x86_64                randconfig-016-20260206    clang-20
x86_64                randconfig-016-20260206    gcc-14
x86_64                randconfig-071-20260206    gcc-14
x86_64                randconfig-072-20260206    clang-20
x86_64                randconfig-072-20260206    gcc-14
x86_64                randconfig-073-20260206    gcc-14
x86_64                randconfig-074-20260206    gcc-14
x86_64                randconfig-075-20260206    clang-20
x86_64                randconfig-075-20260206    gcc-14
x86_64                randconfig-076-20260206    gcc-14
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
xtensa                  cadence_csp_defconfig    clang-22
xtensa                randconfig-001-20260206    gcc-12.5.0
xtensa                randconfig-001-20260206    gcc-9.5.0
xtensa                randconfig-002-20260206    gcc-10.5.0
xtensa                randconfig-002-20260206    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

