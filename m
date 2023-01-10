Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EDE663C15
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jan 2023 10:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjAJJBM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Jan 2023 04:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjAJI75 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2023 03:59:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF54D721;
        Tue, 10 Jan 2023 00:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673341160; x=1704877160;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=y8eGB0bUm5BuFDRsQCDQVetCmvCEgJqPbi5tofxIzdU=;
  b=O2fffyLf1uDgmGxF8dsdhHE2dqFxmNZxwfXP9GuPWI5hKVDihkLTx7F/
   Rzf/C9GzkHTGX3qjmPFOxW3kX/hu56WBmCDyQ3p+d7bYdHDkdsbVyYbI2
   xnBukEYpN+00aCguoVUgF+O7MyBK51bI5iHDiI5CcmJdLSCwrDNY+ZIOM
   s3kZRVfgKzn5J5L6R0AkkDLU0EutdaIuGVK75kQdxjIxDWAKKVEXHJKtm
   jeP5mOaxYObYANaWXRQPvx6ZbgIhfSJtMxrO+mGOkhpsyeO/H+k0ii+eL
   RwGy08TMrmrxU8LRD2Oxi3j7WNQTgZA5iXhrAxSXcSbnucPGzlUh9cgFI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="387550148"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="387550148"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 00:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="606888054"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="606888054"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2023 00:59:16 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFATT-0007nr-2r;
        Tue, 10 Jan 2023 08:59:15 +0000
Date:   Tue, 10 Jan 2023 16:58:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 e73125f5e4d68eea0197f83c4943672d9c8cbd08
Message-ID: <63bd28c2.rdYyCKmjDXHO0xmK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e73125f5e4d68eea0197f83c4943672d9c8cbd08  Merge branch 'thermal-intel' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301101443.IqvnQKMN-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/thermal/intel/x86_pkg_temp_thermal.c:375:52: error: use of undeclared identifier 'tj_max'
drivers/thermal/intel/x86_pkg_temp_thermal.c:375:59: error: 'tj_max' undeclared (first use in this function)

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- x86_64-defconfig
|   `-- drivers-thermal-intel-x86_pkg_temp_thermal.c:error:tj_max-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-8.3-bpf
|   `-- drivers-thermal-intel-x86_pkg_temp_thermal.c:error:tj_max-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-8.3-func
|   `-- drivers-thermal-intel-x86_pkg_temp_thermal.c:error:tj_max-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-8.3-kunit
|   `-- drivers-thermal-intel-x86_pkg_temp_thermal.c:error:tj_max-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-8.3-kvm
|   `-- drivers-thermal-intel-x86_pkg_temp_thermal.c:error:tj_max-undeclared-(first-use-in-this-function)
`-- x86_64-rhel-8.3-syz
    `-- drivers-thermal-intel-x86_pkg_temp_thermal.c:error:tj_max-undeclared-(first-use-in-this-function)
clang_recent_errors
`-- x86_64-rhel-8.3-rust
    `-- drivers-thermal-intel-x86_pkg_temp_thermal.c:error:use-of-undeclared-identifier-tj_max

elapsed time: 726m

configs tested: 36
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
riscv                             allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                           allyesconfig
sh                               allmodconfig
i386                                defconfig
arm                                 defconfig
powerpc                          allmodconfig
i386                             allyesconfig
mips                             allyesconfig
x86_64                           rhel-8.3-bpf
arm                              allyesconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
