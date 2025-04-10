Return-Path: <linux-acpi+bounces-12955-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8B4A84F0A
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 23:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39559A0470
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD220D4F2;
	Thu, 10 Apr 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNYunpwU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F166EB79;
	Thu, 10 Apr 2025 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319305; cv=none; b=tWNEk00KREZY3trBK3KT/XmKpUQSLpIj/J4nR6HEhNPpoVW72dQRBvCc4WgQDRceqGshrZ4rpFT29HMWahyXsHjTlNKv3jBkpkHzQZfv3UJCHaOF8Y5l61uLL7Mcr52bXu8Cr3Ouq74WDkLGN4FWbpmGDuwUXQqSArO+xn6aN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319305; c=relaxed/simple;
	bh=AXULqvRgC41HjmINbBvSwAi4chezdqQR9xOvCcyIzAI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iEKVyFSsxhmSW5ogvxTqREKYhBmfsufo6XjlyazWy/7VnjjKgGhsZaJY0jrr9kQqYJDueMbhPck4WcMzktuQbpfIquRvg6l2TZ9RJRrvr61c6jxRpAgfl2qlhTQg72XyTv+EKz1PEZ+KY2mEEqUuCJMlwqlSukU6+5lamypvg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNYunpwU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744319303; x=1775855303;
  h=date:from:to:cc:subject:message-id;
  bh=AXULqvRgC41HjmINbBvSwAi4chezdqQR9xOvCcyIzAI=;
  b=iNYunpwUA0tEMn7edg3k1Xq1u1bcYOadL0i8k3NMn3+xv0a1p21eFprf
   34QXXjD2Ska3gSJDCZI8zFTaejf3m4ltPzIQG0hlFn+q7i9hzorlPIXtT
   b7xP7ZnIh1F4zN+QC3aRv1xXSx+HDjSZU61J/z0KYRb0WGyuHDVYMWuRD
   h1RvOZrgcVmw38M8n5jozNefeMc8xASt9YhefT+Nv7IkxqSTC8A0TAuPV
   B+bGJn2I7xjwhIyZnts97CnTVYuT5bpS0048ZfMOrEvKCst1DTA9aTfyU
   DacfpbYaKUJ2pFrtfCd+fdq5VXbP9A3Hgn3aW4iG8ZVLQjz9shQpKAbuA
   g==;
X-CSE-ConnectionGUID: pgSBt0MdSW2+ESy6fxfWcA==
X-CSE-MsgGUID: Qc7Sj5syTh+8POF08X6rNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="71249471"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="71249471"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 14:08:22 -0700
X-CSE-ConnectionGUID: RioAwGbHQ9S1Sp78YpC3cA==
X-CSE-MsgGUID: 1aGHZdX0T1Wc0pnBiPqi1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129978110"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2025 14:08:21 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2z8E-000AXE-2U;
	Thu, 10 Apr 2025 21:08:18 +0000
Date: Fri, 11 Apr 2025 05:07:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 655d33f14d6cebcf46e422bcb9d225d791bba42f
Message-ID: <202504110526.uJySTlEH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 655d33f14d6cebcf46e422bcb9d225d791bba42f  Merge branch 'acpi-apei' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202504101106.hPCEcoHr-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202504101132.pgiDBR2Q-lkp@intel.com

    drivers/acpi/processor_idle.c:464:15: warning: unused variable 'i' [-Wunused-variable]
    drivers/acpi/processor_idle.c:464:22: warning: unused variable 'i' [-Wunused-variable]
    drivers/pinctrl/pinctrl-amd.c:1213:26: error: use of undeclared identifier 'pinctrl_amd_s2idle_dev_ops'
    drivers/pinctrl/pinctrl-amd.c:40:25: warning: unused variable 'pinctrl_dev' [-Wunused-variable]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- hexagon-allmodconfig
|   `-- drivers-pinctrl-pinctrl-amd.c:warning:unused-variable-pinctrl_dev
|-- hexagon-allyesconfig
|   `-- drivers-pinctrl-pinctrl-amd.c:warning:unused-variable-pinctrl_dev
|-- hexagon-randconfig-001-20250410
|   `-- drivers-pinctrl-pinctrl-amd.c:warning:unused-variable-pinctrl_dev
|-- i386-allmodconfig
|   `-- drivers-acpi-processor_idle.c:warning:unused-variable-i
|-- i386-allyesconfig
|   `-- drivers-acpi-processor_idle.c:warning:unused-variable-i
|-- i386-buildonly-randconfig-003-20250409
|   `-- drivers-acpi-processor_idle.c:warning:unused-variable-i
|-- i386-defconfig
|   `-- drivers-acpi-processor_idle.c:warning:unused-variable-i
|-- riscv-randconfig-001-20250410
|   `-- drivers-pinctrl-pinctrl-amd.c:error:use-of-undeclared-identifier-pinctrl_amd_s2idle_dev_ops
|-- s390-allmodconfig
|   `-- drivers-pinctrl-pinctrl-amd.c:warning:unused-variable-pinctrl_dev
|-- um-randconfig-001-20250410
|   `-- drivers-pinctrl-pinctrl-amd.c:warning:unused-variable-pinctrl_dev
|-- x86_64-allyesconfig
|   `-- drivers-acpi-processor_idle.c:warning:unused-variable-i
|-- x86_64-buildonly-randconfig-006-20250410
|   `-- drivers-acpi-processor_idle.c:warning:unused-variable-i
`-- x86_64-defconfig
    `-- drivers-acpi-processor_idle.c:warning:unused-variable-i

elapsed time: 1462m

configs tested: 74
configs skipped: 1

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250410    gcc-14.2.0
arc                   randconfig-002-20250410    gcc-12.4.0
arm                   randconfig-001-20250410    clang-21
arm                   randconfig-002-20250410    clang-18
arm                   randconfig-003-20250410    gcc-7.5.0
arm                   randconfig-004-20250410    gcc-8.5.0
arm64                 randconfig-001-20250410    clang-21
arm64                 randconfig-002-20250410    clang-21
arm64                 randconfig-003-20250410    gcc-6.5.0
arm64                 randconfig-004-20250410    gcc-8.5.0
csky                  randconfig-001-20250410    gcc-14.2.0
csky                  randconfig-002-20250410    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250410    clang-21
hexagon               randconfig-002-20250410    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250410    clang-20
i386        buildonly-randconfig-002-20250410    clang-20
i386        buildonly-randconfig-003-20250410    clang-20
i386        buildonly-randconfig-004-20250410    gcc-11
i386        buildonly-randconfig-005-20250410    clang-20
i386        buildonly-randconfig-006-20250410    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250410    gcc-12.4.0
loongarch             randconfig-002-20250410    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250410    gcc-14.2.0
nios2                 randconfig-002-20250410    gcc-10.5.0
parisc                randconfig-001-20250410    gcc-5.5.0
parisc                randconfig-002-20250410    gcc-11.5.0
powerpc               randconfig-001-20250410    gcc-6.5.0
powerpc               randconfig-002-20250410    gcc-6.5.0
powerpc               randconfig-003-20250410    clang-21
powerpc64             randconfig-001-20250410    clang-21
powerpc64             randconfig-002-20250410    clang-21
powerpc64             randconfig-003-20250410    clang-21
riscv                 randconfig-001-20250410    clang-21
riscv                 randconfig-002-20250410    gcc-8.5.0
s390                             allmodconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250410    clang-17
s390                  randconfig-002-20250410    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250410    gcc-12.4.0
sh                    randconfig-002-20250410    gcc-10.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250410    gcc-10.3.0
sparc                 randconfig-002-20250410    gcc-7.5.0
sparc64               randconfig-001-20250410    gcc-7.5.0
sparc64               randconfig-002-20250410    gcc-5.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250410    clang-19
um                    randconfig-002-20250410    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250410    clang-20
x86_64      buildonly-randconfig-002-20250410    gcc-12
x86_64      buildonly-randconfig-003-20250410    clang-20
x86_64      buildonly-randconfig-004-20250410    clang-20
x86_64      buildonly-randconfig-005-20250410    clang-20
x86_64      buildonly-randconfig-006-20250410    clang-20
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250410    gcc-14.2.0
xtensa                randconfig-002-20250410    gcc-7.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

