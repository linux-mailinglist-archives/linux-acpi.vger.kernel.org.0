Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3462D63B78F
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Nov 2022 03:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiK2CAN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Nov 2022 21:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiK2CAM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Nov 2022 21:00:12 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5458745A09;
        Mon, 28 Nov 2022 18:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669687211; x=1701223211;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kokUTO3pNOqizW3Qp3hAUb5tGZM254XvbpWoLKp5c9g=;
  b=CtnUcz1cDenVfJn6Q8ZRlA5m03LZ9DdFGrbZPgQBFQcB8homyusAYqRQ
   HPTfYs1JSINgkC26BMP9vMh9nyK287YxV4Z7pnrNipb15ZZa3ONcTQEEQ
   AmbPb6uZlyPIKp190ktxUyJONG2U2sLw88fqVRjWDtQNEd5D76tVYpc0E
   BG+0mglsqpTMK+ovV8O8wGs2s/uvCBMWzRqXbdLfVQ1pUtoY2IhYH7r0x
   Vc+Bq6THfNx0esNupWe9Zkiw0c8ucBNqQDYT/bRbj/feSCW2jyXeFJICV
   Rk4AMDjZIGkZT+xq5Nd5yNDbsPuyTjRSy6oVYdqArCLU/qOhofL+0oJAa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316831917"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="316831917"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 18:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643614243"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="643614243"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 18:00:09 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ozpuq-0008VP-1I;
        Tue, 29 Nov 2022 02:00:08 +0000
Date:   Tue, 29 Nov 2022 09:59:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 dee69e7005ce309e619155eb6372f287212e27f7
Message-ID: <63856782.i3rgzZuq5QnxURN3%lkp@intel.com>
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
branch HEAD: dee69e7005ce309e619155eb6372f287212e27f7  Merge branches 'thermal-core' and 'thermal-intel' into linux-next

elapsed time: 733m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                                 defconfig
arc                              allyesconfig
s390                             allmodconfig
alpha                            allyesconfig
x86_64                              defconfig
arc                  randconfig-r043-20221128
alpha                               defconfig
x86_64                          rhel-8.3-func
s390                                defconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a002-20221128
i386                 randconfig-a003-20221128
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
i386                 randconfig-a001-20221128
x86_64                         rhel-8.3-kunit
i386                                defconfig
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
x86_64                           rhel-8.3-kvm
i386                 randconfig-a004-20221128
arc                               allnoconfig
s390                             allyesconfig
x86_64                           allyesconfig
x86_64               randconfig-a002-20221128
alpha                             allnoconfig
x86_64               randconfig-a005-20221128
i386                              allnoconfig
x86_64               randconfig-a001-20221128
x86_64               randconfig-a006-20221128
x86_64               randconfig-a003-20221128
ia64                             allmodconfig
arm                               allnoconfig
x86_64               randconfig-a004-20221128
powerpc                           allnoconfig
mips                             allyesconfig
i386                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
x86_64               randconfig-a013-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a015-20221128
x86_64               randconfig-a012-20221128
i386                 randconfig-a016-20221128
x86_64               randconfig-a014-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
