Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A549162929C
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Nov 2022 08:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiKOHnE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Nov 2022 02:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKOHnE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2022 02:43:04 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E653FBBA;
        Mon, 14 Nov 2022 23:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668498181; x=1700034181;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oKTZy0MT8rZr6FDINCECGLb1+1ZH94JhfUwq+2xKvQ8=;
  b=mHD9TnqIkbyIxY99d4Lxk3lZSkzKkk4rdSwCORAZQor4t13cAlSswUDA
   b/Xcx5xQF7knv/tqfUVlkxScDy72R9v8V2UfXFhxvWUIMVExljZG84gN/
   +t//LouLF6ucnsvuDW2OEqX9vn1Lcv80iSXYUskFJp3/Jg7FLzktc0Dyd
   kLrycHe2fKZ5rhnKRU/e5JeyWaTGXFqiEJekAWT2qySKysRuCL13XHFKw
   CFKVOtnJplwircr5HBdbr5rVoIMvDxicXqNZ6P9J02X/vjFwa1yG9LnpB
   zGlwWTku8UXXmo/Yw1dv/6RGWrakub3lOrHPxUJW+wG18bbLhygBf8FIS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="291899419"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="291899419"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 23:43:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="707640387"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="707640387"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2022 23:43:00 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ouqax-0001At-1t;
        Tue, 15 Nov 2022 07:42:59 +0000
Date:   Tue, 15 Nov 2022 15:42:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 8992b8d17e6c314a528a5bce386de28701f2a2ef
Message-ID: <637342fd.RhRuSQOunz8IKuR7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8992b8d17e6c314a528a5bce386de28701f2a2ef  Merge branch 'acpi-bus' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202211150900.CUzIO2xF-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/arm64/kernel/acpi.c:433:5: warning: no previous prototype for 'acpi_ffh_address_space_arch_setup' [-Wmissing-prototypes]
arch/arm64/kernel/acpi.c:476:5: warning: no previous prototype for 'acpi_ffh_address_space_arch_handler' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm64-allyesconfig
    |-- arch-arm64-kernel-acpi.c:warning:no-previous-prototype-for-acpi_ffh_address_space_arch_handler
    `-- arch-arm64-kernel-acpi.c:warning:no-previous-prototype-for-acpi_ffh_address_space_arch_setup

elapsed time: 722m

configs tested: 56
configs skipped: 2

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
arm                               allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
arc                  randconfig-r043-20221115
riscv                randconfig-r042-20221115
s390                 randconfig-r044-20221115
m68k                             allyesconfig
x86_64                              defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
x86_64                           allyesconfig
mips                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
i386                 randconfig-a001-20221114
i386                 randconfig-a004-20221114
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a002-20221114
i386                 randconfig-a005-20221114
sh                               allmodconfig
x86_64                           rhel-8.3-syz
arm                                 defconfig
i386                 randconfig-a006-20221114
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a003-20221114
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
x86_64               randconfig-a012-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a011-20221114
x86_64               randconfig-a014-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a015-20221114
i386                 randconfig-a011-20221114
i386                 randconfig-a013-20221114
i386                 randconfig-a012-20221114
i386                 randconfig-a014-20221114
i386                 randconfig-a015-20221114
i386                 randconfig-a016-20221114

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
