Return-Path: <linux-acpi+bounces-17122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EAFB871E3
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 23:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784011886EF0
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 21:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5E62F28EC;
	Thu, 18 Sep 2025 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTSjj3sT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC7E2E0905;
	Thu, 18 Sep 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230706; cv=none; b=OLpAVtRDqhivkdT4ingo0nbEvWTL7qfASH+k3FBQ7oKG2rCq2A1tpakEpJ+0VE9cf4rphG3QSqvzXCbDNY6eACWjQqe/9oxgbKQ2Tcw8qkxjp8uJauZWXx0brcgKh2S0wIRvcJb9OmUD1PRxZJtUIsKGCTU9O9WsWx5EUi0LU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230706; c=relaxed/simple;
	bh=uDWPrIRB0BZ6/hBSTOSpH6ZUTabeq0J+pelBRMLP/XU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l2SdOmIw/W/bhGYgsiaHsi7I8LZxqtqD8dalM0OhZ82OjEhYoe7TXzbuKiTCWcnIQqRNTUI41YvTDqtNqOETP1fzJUGZXRDZtF88WkloUc5NukIfU3pizoFC1r/BmH+RYLXtmn222h/dk696OSZIN5L1Th8gS6biYZnej4n6zqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTSjj3sT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758230704; x=1789766704;
  h=date:from:to:cc:subject:message-id;
  bh=uDWPrIRB0BZ6/hBSTOSpH6ZUTabeq0J+pelBRMLP/XU=;
  b=iTSjj3sT4GqFrCqEYnVIW95zKWtDYKdalf7ffWJVi5KCOmDv/FIRK2yL
   W3tRzyrmetMyM9SNxv+mOEBQHtc0OxUYhdTJYyT3cNmj0D020Mn8UWT4E
   YqRSkwH3febQio1zbzTXBLoXWBJ65sb9UtSPQ2AuNoMEPxKWK2F76o12m
   ZPMqb4hD12Qvgd142ervtQuWfmWBp432tMurH/8NHgsPrQtLVbCn0QmPm
   0k2de2lZ4iSgD5CRUblMXoqq7/gwPJvtdVSXi9sP9T59Ccz72kJvQZDwi
   K60PGLXjCYO3Ta3jC7oscDr+KDwtZwGfo+KmaCQlkuVMMsfdY0RG36+cy
   w==;
X-CSE-ConnectionGUID: G56zFcaKS6C/JYnWrlG8uA==
X-CSE-MsgGUID: Zkno/CldQtipMlxbWrQzQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64379723"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64379723"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:25:03 -0700
X-CSE-ConnectionGUID: BFlQ3YeYQJyA+wjTjLOybg==
X-CSE-MsgGUID: kmT3HXReQ8iULoU/UcXRuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="179658718"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Sep 2025 14:25:01 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzM7e-0003jH-32;
	Thu, 18 Sep 2025 21:24:58 +0000
Date: Fri, 19 Sep 2025 05:24:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 91ba4736fb2c9614b250ae532c133546a2cc717c
Message-ID: <202509190506.uYSA8ShY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 91ba4736fb2c9614b250ae532c133546a2cc717c  Merge branch 'acpi-processor' into bleeding-edge

elapsed time: 1456m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250918    gcc-8.5.0
arc                   randconfig-002-20250918    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-002-20250918    gcc-8.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-004-20250918    gcc-11.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-002-20250918    gcc-11.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-004-20250918    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250918    gcc-15.1.0
csky                  randconfig-002-20250918    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-002-20250918    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250918    clang-20
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-004-20250918    clang-20
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-006-20250918    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250918    clang-18
loongarch             randconfig-002-20250918    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250918    gcc-10.5.0
nios2                 randconfig-002-20250918    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250918    gcc-12.5.0
parisc                randconfig-002-20250918    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250918    gcc-9.5.0
powerpc               randconfig-002-20250918    clang-17
powerpc               randconfig-003-20250918    clang-19
powerpc64             randconfig-001-20250918    gcc-8.5.0
powerpc64             randconfig-002-20250918    gcc-14.3.0
powerpc64             randconfig-003-20250918    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-002-20250918    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-002-20250918    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250918    clang-22
um                    randconfig-002-20250918    clang-18
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

