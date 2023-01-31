Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F62D682642
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Jan 2023 09:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAaIVt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Jan 2023 03:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaIVs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2023 03:21:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D2730295;
        Tue, 31 Jan 2023 00:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675153307; x=1706689307;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1MaYJmPUSYhetegXNdBKmt7HpT3Yme2jdiORoNVOiMg=;
  b=jtFn4Lit2KE5OpT/K7g9K6aUpmyr9b1e7Z+vUnJovp5xslvpJoTexY13
   RURuWXoKno0cwxav6427j+XXSDKmS+A78j8VcRL59qgrBhpO+iwHc1Q30
   oeB0SPfxcKTGLAcZ1A1DIgMHcDKuoBWwaLhG/VcLx5nvwnjsK53Nvd3cI
   5jdEEWj2/QXV53fbEUdVKn+yFx3tjElgcVSZDaGvDkXsz87D7HDc3LMc4
   qCUoccxH/NI+owZMiy5I433DQ+Ut51Z9mxn3RQ/7H4pvWkXyK3ZIJsvMw
   Z5oaqkAaPUp+exMD9/7xofxjh91XeEkKfT0C0ZZNdS5E2KMkSpwbcoM7b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327800050"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="327800050"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 00:21:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="664415449"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="664415449"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2023 00:21:44 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMltf-0004It-2s;
        Tue, 31 Jan 2023 08:21:43 +0000
Date:   Tue, 31 Jan 2023 16:21:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 80ca19df0fe5cc0906c8731f63dbf2c31a9caf6b
Message-ID: <63d8cf7d.y7FmdjPRcg5k/MtU%lkp@intel.com>
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
branch HEAD: 80ca19df0fe5cc0906c8731f63dbf2c31a9caf6b  Merge branch 'pm-docs' into bleeding-edge

elapsed time: 726m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
x86_64                            allnoconfig
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
m68k                             allmodconfig
alpha                               defconfig
alpha                            allyesconfig
s390                                defconfig
m68k                             allyesconfig
mips                             allyesconfig
arc                              allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64                           allyesconfig
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
riscv                             allnoconfig
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-bpf
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                                defconfig
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
arm                                 defconfig
arm64                            allyesconfig
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
i386                             allyesconfig
arm                              allyesconfig
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
