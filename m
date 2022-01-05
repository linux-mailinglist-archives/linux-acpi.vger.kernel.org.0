Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7B0484F61
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jan 2022 09:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiAEIdd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jan 2022 03:33:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:10990 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbiAEIdc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Jan 2022 03:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641371612; x=1672907612;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Yb2rvcoqRLow4ev5sn49PX+MkzguxeiBq3oN2yYL0wU=;
  b=iHs7VEY3BIarRXDtfnYEHyG1pcG27zSXOa8VFJ2PhyNc3p3sqJuN6rlb
   zvub3ic9lS9TtkQynASaXyui8usVz1gdkLS2GS6GfdnnXDNklKlz5ZRSK
   yJpFW9V0kmw2yjKWP69F+UwEcE8JoMupoCpmzNmXEYjc3wxHoCJHIcMDy
   g3ohyS14Q4DDGWCHnn0sEgduep8qfLSl40sINL3nTj2j6y9nK98/5WtNn
   Wa+oqhRhltxObLSI6FBF3GJjPz1yIjfAfxEsc5HJG5gfLCi1EbyvFUxZa
   c/kYqmYABaaDN55qR4HaolM9c1Q7Xe+Tur2aofOhZopPmbDbbo0zn0OM3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242196218"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242196218"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 00:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="574314295"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jan 2022 00:33:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n51jd-000GQ0-Pe; Wed, 05 Jan 2022 08:33:29 +0000
Date:   Wed, 05 Jan 2022 16:32:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bcb051d6e10a9f7171d96984a1d65cf8feb29071
Message-ID: <61d557b2.lItPPsQeH5WBLhSj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bcb051d6e10a9f7171d96984a1d65cf8feb29071  Merge branch 'acpi-pcc' into bleeding-edge

possible Warning in current branch (please contact us if interested):

sound/soc/sh/rz-ssi.c:1023:9: warning: ignoring return value of 'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-Wunused-result]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- arc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- arm-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- arm-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- arm64-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- arm64-defconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- h8300-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- ia64-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- m68k-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- m68k-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- mips-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- mips-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- nios2-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- parisc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- powerpc-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- powerpc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- riscv-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- riscv-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- s390-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- sh-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- sparc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
`-- xtensa-allyesconfig
    `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result

elapsed time: 723m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
