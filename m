Return-Path: <linux-acpi+bounces-16557-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92CB511AE
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 10:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E520E1C26093
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 08:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2949306D52;
	Wed, 10 Sep 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GakfzISA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61402D660E;
	Wed, 10 Sep 2025 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493729; cv=none; b=gRpWl0WcVp0TnisBGTmwrp4hezAY8b2gVLVJzClDJZ2wBE9CO3prJPohge9BvkkRp8bXYn1RZ02A0Ld8t2kPJdGvEjp/dqlPR47Xt8lJ5JbiSuG39vI0H2RxEAVIvMbY/YJbN4T8sbutqwskU/su87fTf4zfvuqcxHecNFAU3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493729; c=relaxed/simple;
	bh=4q67+pWeLlSAu51L6TViziPoi9rJqZ9TwSujrrbjcug=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j76l5W1lILRT7w9hP6d8EE5V/HIe2aINC4Cr4VqqIg32/wbq3dveMm5wI0t8b/joh4/07I+Jv1JsPjyU3lJLx3BPa2CiwYpN89TfxNHxV2r/k/2JvVj+Ka3cAVM8Jii+pu6E/P+w2KfmmTUgkZf/e8C6pi2oUmQr2kA6+b0weoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GakfzISA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757493728; x=1789029728;
  h=date:from:to:cc:subject:message-id;
  bh=4q67+pWeLlSAu51L6TViziPoi9rJqZ9TwSujrrbjcug=;
  b=GakfzISAfMzF5GOD7YkyrJIYFYu7PsGmzZEEeesxZYKrN8tEWnGfFrwh
   eWVoSLKcTrBqm6qkbYfAoq2IkoG+6zXIYHLS4eRAGtEvY+3bTW2hDwqj5
   oFRhZBaH6YYEGk2JEs0SnHfE5sGc31tN31sbD9D8OglTN5/y9xhR6wwMz
   7pHdPBP9HvLqxJ/Mn86euph7g3Zk9ABKtHi0dcLzySFsMLLdhZ3dreXnW
   rgOGzpPyj/dqUl53n3TTbF6Ccn/LKF9Wij6mtnc/A1BGm/wJfnf3syTAd
   Upvkv7m50CrTY3n0MsEGKDoK8Y6zXC9iFt47TDKgJdhWpAHmy0XcdKlAp
   A==;
X-CSE-ConnectionGUID: LAHI2TriRByKj8gQPSYtYw==
X-CSE-MsgGUID: PqsaOstlSRKJqfoFwcZPiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="58837601"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="58837601"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 01:41:53 -0700
X-CSE-ConnectionGUID: GRWlW+9+QqSNnXHMpzxDBg==
X-CSE-MsgGUID: NkrCMSO/RD69iqZTcGW48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="172923661"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Sep 2025 01:41:51 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwGOj-0005hi-1H;
	Wed, 10 Sep 2025 08:41:49 +0000
Date: Wed, 10 Sep 2025 16:41:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 871659d21a82efeef7fbcf62ac740798960dc786
Message-ID: <202509101624.b8PJgYjk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 871659d21a82efeef7fbcf62ac740798960dc786  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 1227m

configs tested: 243
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250909    gcc-8.5.0
arc                   randconfig-001-20250910    gcc-13.4.0
arc                   randconfig-002-20250909    gcc-8.5.0
arc                   randconfig-002-20250910    gcc-13.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250909    clang-18
arm                   randconfig-001-20250910    gcc-13.4.0
arm                   randconfig-002-20250909    clang-17
arm                   randconfig-002-20250910    gcc-13.4.0
arm                   randconfig-003-20250909    clang-22
arm                   randconfig-003-20250910    gcc-13.4.0
arm                   randconfig-004-20250909    clang-19
arm                   randconfig-004-20250910    gcc-13.4.0
arm                           spitz_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-001-20250910    gcc-13.4.0
arm64                 randconfig-002-20250909    gcc-11.5.0
arm64                 randconfig-002-20250910    gcc-13.4.0
arm64                 randconfig-003-20250909    gcc-11.5.0
arm64                 randconfig-003-20250910    gcc-13.4.0
arm64                 randconfig-004-20250909    clang-22
arm64                 randconfig-004-20250910    gcc-13.4.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250909    gcc-15.1.0
csky                  randconfig-001-20250910    clang-22
csky                  randconfig-002-20250909    gcc-15.1.0
csky                  randconfig-002-20250910    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250909    clang-22
hexagon               randconfig-001-20250910    clang-22
hexagon               randconfig-002-20250909    clang-22
hexagon               randconfig-002-20250910    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250909    gcc-13
i386        buildonly-randconfig-001-20250910    clang-20
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-002-20250910    clang-20
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-003-20250910    clang-20
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-004-20250910    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-005-20250910    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
i386        buildonly-randconfig-006-20250910    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250910    clang-20
i386                  randconfig-002-20250910    clang-20
i386                  randconfig-003-20250910    clang-20
i386                  randconfig-004-20250910    clang-20
i386                  randconfig-005-20250910    clang-20
i386                  randconfig-006-20250910    clang-20
i386                  randconfig-007-20250910    clang-20
i386                  randconfig-011-20250910    clang-20
i386                  randconfig-012-20250910    clang-20
i386                  randconfig-013-20250910    clang-20
i386                  randconfig-014-20250910    clang-20
i386                  randconfig-015-20250910    clang-20
i386                  randconfig-016-20250910    clang-20
i386                  randconfig-017-20250910    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250909    gcc-15.1.0
loongarch             randconfig-001-20250910    clang-22
loongarch             randconfig-002-20250909    gcc-15.1.0
loongarch             randconfig-002-20250910    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250909    gcc-11.5.0
nios2                 randconfig-001-20250910    clang-22
nios2                 randconfig-002-20250909    gcc-8.5.0
nios2                 randconfig-002-20250910    clang-22
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-001-20250910    clang-22
parisc                randconfig-002-20250909    gcc-12.5.0
parisc                randconfig-002-20250910    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250909    clang-22
powerpc               randconfig-001-20250910    clang-22
powerpc               randconfig-002-20250909    clang-17
powerpc               randconfig-002-20250910    clang-22
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc               randconfig-003-20250910    clang-22
powerpc64             randconfig-001-20250909    clang-20
powerpc64             randconfig-002-20250909    gcc-10.5.0
powerpc64             randconfig-002-20250910    clang-22
powerpc64             randconfig-003-20250909    gcc-8.5.0
powerpc64             randconfig-003-20250910    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250909    clang-22
riscv                 randconfig-001-20250910    gcc-12.5.0
riscv                 randconfig-002-20250909    clang-22
riscv                 randconfig-002-20250910    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250909    gcc-11.5.0
s390                  randconfig-001-20250910    gcc-12.5.0
s390                  randconfig-002-20250909    clang-18
s390                  randconfig-002-20250910    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250909    gcc-15.1.0
sh                    randconfig-001-20250910    gcc-12.5.0
sh                    randconfig-002-20250909    gcc-9.5.0
sh                    randconfig-002-20250910    gcc-12.5.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-8.5.0
sparc                 randconfig-001-20250910    gcc-12.5.0
sparc                 randconfig-002-20250909    gcc-15.1.0
sparc                 randconfig-002-20250910    gcc-12.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250909    clang-22
sparc64               randconfig-001-20250910    gcc-12.5.0
sparc64               randconfig-002-20250909    gcc-8.5.0
sparc64               randconfig-002-20250910    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250909    gcc-14
um                    randconfig-001-20250910    gcc-12.5.0
um                    randconfig-002-20250909    gcc-14
um                    randconfig-002-20250910    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250909    clang-20
x86_64      buildonly-randconfig-001-20250910    gcc-14
x86_64      buildonly-randconfig-002-20250909    clang-20
x86_64      buildonly-randconfig-002-20250910    gcc-14
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-003-20250910    gcc-14
x86_64      buildonly-randconfig-004-20250909    clang-20
x86_64      buildonly-randconfig-004-20250910    gcc-14
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-005-20250910    gcc-14
x86_64      buildonly-randconfig-006-20250909    clang-20
x86_64      buildonly-randconfig-006-20250910    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250910    clang-20
x86_64                randconfig-002-20250910    clang-20
x86_64                randconfig-003-20250910    clang-20
x86_64                randconfig-004-20250910    clang-20
x86_64                randconfig-005-20250910    clang-20
x86_64                randconfig-006-20250910    clang-20
x86_64                randconfig-007-20250910    clang-20
x86_64                randconfig-008-20250910    clang-20
x86_64                randconfig-071-20250910    gcc-14
x86_64                randconfig-072-20250910    gcc-14
x86_64                randconfig-073-20250910    gcc-14
x86_64                randconfig-074-20250910    gcc-14
x86_64                randconfig-075-20250910    gcc-14
x86_64                randconfig-076-20250910    gcc-14
x86_64                randconfig-077-20250910    gcc-14
x86_64                randconfig-078-20250910    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-8.5.0
xtensa                randconfig-001-20250910    gcc-12.5.0
xtensa                randconfig-002-20250909    gcc-15.1.0
xtensa                randconfig-002-20250910    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

