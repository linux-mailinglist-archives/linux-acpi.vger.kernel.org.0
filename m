Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E056750FB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 10:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjATJ0r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 04:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjATJ0o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 04:26:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6789740FE;
        Fri, 20 Jan 2023 01:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674206778; x=1705742778;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=udIPImkCh/9a7qDyIWXLa5eBinnKrc5ccOlD3i7ngTE=;
  b=EUoW+FsnCd8H/crq8BCBIqFkHSFigfa4TAQpOEMJlddneCn+mN0wEHDy
   XujwL0Uyzr7Agiz4qCw4ZXxbKLBYXDVxvjppi9ynXE00LQiQFBZCIWmCj
   XI3DKqxNaCKvNZ7IutBcx5buK316wK/0Xpg3KKfpIUudXknj9wNg/nGLo
   EceZDlVVGof8DZKDCeAVns7AFRchtbSZlnoUqIWOqbUDnttEFVELa0g9k
   RevdTYzU8OJqGoV0MifzD5E4udCaJS2U03O6dfYkBEWhfkPmjIWTXi0fs
   ymUb32PyiAnQDdbcYlLPvMTno37Vk7AfVi44li2SUM5bkRvaZO7dpLF2F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305216143"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="305216143"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 01:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="803016157"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="803016157"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2023 01:22:53 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pInbo-0002Qq-1A;
        Fri, 20 Jan 2023 09:22:52 +0000
Date:   Fri, 20 Jan 2023 17:22:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ee391c142b7e153701eb16fcc63fb9ed9624a572
Message-ID: <63ca5d61./KDTaptyyzmqazxX%lkp@intel.com>
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
branch HEAD: ee391c142b7e153701eb16fcc63fb9ed9624a572  Merge branch 'thermal-core' into bleeding-edge

elapsed time: 722m

configs tested: 55
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                          randconfig-a001
i386                          randconfig-a003
arc                                 defconfig
s390                             allmodconfig
i386                          randconfig-a005
arc                               allnoconfig
powerpc                           allnoconfig
alpha                               defconfig
um                             i386_defconfig
alpha                             allnoconfig
i386                              allnoconfig
s390                                defconfig
arm                               allnoconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
arm64                            allyesconfig
i386                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
riscv                             allnoconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20230119
s390                 randconfig-r044-20230119
hexagon              randconfig-r045-20230119
riscv                randconfig-r042-20230119
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
