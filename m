Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CBF484393
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jan 2022 15:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiADOl4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Jan 2022 09:41:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:8304 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234304AbiADOl4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Jan 2022 09:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641307316; x=1672843316;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ALkibHjsClqfYfZP3YOyjyWa+8oE9fy3FXzt+mGIh/U=;
  b=Qn5ini/BcyZyj7xbytbVaarMzd8g0v0mbAlz+gCUplabjNKez2QetqSI
   o9rzLoy6XUyR1y+z+AEOT1aqYskjzr2Hm9cfWtm3TZMCIShH0z4l3NJ1K
   M5wgMBqFeA/FZGxx6NCmsTqM5CPFwkPBDwvw/plqQiiHCyXm5Sh07RQep
   8e9dbaN62q0YmI5Y0EncOoZGwHaggAhEJ5BXBhEZlDPv/hRZi8gUdphin
   pyBCiFckVlxKA0k35anUJGLON584BNxTq8q52Izwbb3mmJsgHG95TbVpH
   1XODDMniXuJyoCTVDFlK8k6XtCgrd4fY2N2UfbpTGGnS0soVuQ3PB8jUe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="241051201"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="241051201"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 06:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="488214451"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2022 06:41:54 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4l0b-000FUC-K9; Tue, 04 Jan 2022 14:41:53 +0000
Date:   Tue, 04 Jan 2022 22:41:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3d72f8341423038eaf304155884dda9989a2fc58
Message-ID: <61d45c90.hMXKGWYzXg8ixuFr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3d72f8341423038eaf304155884dda9989a2fc58  Merge branches 'thermal' and 'thermal-int340x' into linux-next

possible Warning in current branch (please contact us if interested):

sound/soc/sh/rz-ssi.c:1023:9: warning: ignoring return value of 'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-Wunused-result]

Warning ids grouped by kconfigs:

gcc_recent_errors
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
|-- parisc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- powerpc-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- powerpc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
|-- s390-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result
`-- sparc-allyesconfig
    `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_resume_and_get-declared-with-attribute-warn_unused_result

elapsed time: 1467m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
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
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
