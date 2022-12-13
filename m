Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2208864B006
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Dec 2022 07:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiLMGqY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Dec 2022 01:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLMGqX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Dec 2022 01:46:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB3EDF21;
        Mon, 12 Dec 2022 22:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670913982; x=1702449982;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CERc3Okb1nSH7mJUU1OJuEvxVUFeSI855RFu3APAyHY=;
  b=O5pjswJ7q6/nrygYhahHOYXJevn3PZAgQzLBJ3J06uLKHwg3prOMe4fD
   UGFDCUJLxFbnot2ekrdl/4pzWTSUu9OZqKfVHF2Zo/POiGnGd10hFuipU
   BAbMwdNZaQLIJMqV6hw5LgcrNzrA6syrWrYkwW+t1dCmgOePORNb3DyNu
   ETSyHYHvI7RxCNrCB9oKoqpY2rm4wCUXRPI6dNmZhIUkrT18zAUOlMpqw
   w2uu1h6mpRowlVEqYUYpYGR46hCbXo9jX8tu2PDkHFtekbFfERJAauIPa
   RqPCxI5cGcbNb4PO7PqkOnk2rjhL6lEiOX3FWmc+gOci87KJN/QalTb2x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="301471074"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="301471074"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 22:46:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="679204396"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="679204396"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2022 22:46:19 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p4z3S-000496-2Q;
        Tue, 13 Dec 2022 06:46:18 +0000
Date:   Tue, 13 Dec 2022 14:46:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d480bd09fb2e112ccfaca8989453c5c74dc585a8
Message-ID: <63981fab.82DZk2BamCFFqBIV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d480bd09fb2e112ccfaca8989453c5c74dc585a8  Merge branch 'thermal-next' into bleeding-edge

elapsed time: 724m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                           rhel-8.3-bpf
alpha                               defconfig
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm                                 defconfig
s390                             allyesconfig
x86_64                              defconfig
i386                 randconfig-a013-20221212
i386                 randconfig-a014-20221212
i386                 randconfig-a012-20221212
i386                 randconfig-a011-20221212
alpha                             allnoconfig
arm                              allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-rust
i386                              allnoconfig
arm64                            allyesconfig
arm                               allnoconfig
i386                 randconfig-a016-20221212
x86_64                               rhel-8.3
arc                               allnoconfig
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
ia64                             allmodconfig
i386                 randconfig-a015-20221212
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
riscv                randconfig-r042-20221212
powerpc                           allnoconfig
arc                  randconfig-r043-20221211
arc                  randconfig-r043-20221212
arm                  randconfig-r046-20221211
s390                 randconfig-r044-20221212
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a014-20221212
x86_64               randconfig-a012-20221212
x86_64               randconfig-a011-20221212
x86_64               randconfig-a015-20221212
x86_64               randconfig-a013-20221212
x86_64               randconfig-a016-20221212
x86_64                            allnoconfig
riscv                             allnoconfig

clang tested configs:
x86_64               randconfig-a002-20221212
x86_64               randconfig-a001-20221212
x86_64               randconfig-a004-20221212
x86_64               randconfig-a003-20221212
x86_64               randconfig-a006-20221212
i386                 randconfig-a002-20221212
x86_64               randconfig-a005-20221212
i386                 randconfig-a003-20221212
i386                 randconfig-a001-20221212
i386                 randconfig-a004-20221212
i386                 randconfig-a006-20221212
i386                 randconfig-a005-20221212
arm                  randconfig-r046-20221212
riscv                randconfig-r042-20221211
hexagon              randconfig-r045-20221211
hexagon              randconfig-r041-20221211
hexagon              randconfig-r045-20221212
s390                 randconfig-r044-20221211
hexagon              randconfig-r041-20221212

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
