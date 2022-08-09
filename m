Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD758D3FE
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Aug 2022 08:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiHIGot (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Aug 2022 02:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiHIGos (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Aug 2022 02:44:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6DB201B6;
        Mon,  8 Aug 2022 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660027485; x=1691563485;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dExwSIWLQG4fAZxi/foT2PEZFM/JrpjVCycSyFAiDhc=;
  b=iWz/G4r59GhjoZmACPrx3+kQ6xkw6jgapilTUm2GXXhLIob8TdGZt63G
   vYqQY480kh5DIMLQ32QKZr8EyyL+Yk6tU2tlYbWo6kDwIxrgsqm+qO/Ho
   KXraTiRh4pA87n92KDZz2ta2axYjwtvSw8VBDZAqHb7xRWTZp96h8RHuL
   qissUhOAmaJEImuqVMOfpks91JSsRwaPwKcIO1c/KAGeponPKokQU3IAr
   St21sT48sGEJELGaQbLnYCb6sJTUP+mfl3ms3iKT3sUuUAzLMzjU6oki2
   36vwRxcReF9s+jLaIRNTvsxjaV1f12mDZU+uaiH0MeC/QGDxlsfBcvEer
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="292007275"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="292007275"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 23:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="731029611"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2022 23:44:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLIyo-000Mo9-1g;
        Tue, 09 Aug 2022 06:44:42 +0000
Date:   Tue, 09 Aug 2022 14:43:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2c461d8f205740fbdcbb8f7c72ea3468d89c7b1e
Message-ID: <62f2022d.h43xFjfErjTiFA43%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2c461d8f205740fbdcbb8f7c72ea3468d89c7b1e  Merge branch 'acpi-tables' into bleeding-edge

elapsed time: 721m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a001-20220808
i386                 randconfig-a002-20220808
i386                 randconfig-a003-20220808
i386                 randconfig-a004-20220808
i386                 randconfig-a005-20220808
i386                 randconfig-a006-20220808
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
powerpc                           allnoconfig
i386                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                                 defconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64               randconfig-a003-20220808
arc                              allyesconfig
x86_64               randconfig-a004-20220808
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220808
alpha                            allyesconfig
x86_64               randconfig-a001-20220808
x86_64                           rhel-8.3-syz
x86_64               randconfig-a005-20220808
x86_64               randconfig-a002-20220808
x86_64               randconfig-a006-20220808
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm                              allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220808
riscv                randconfig-r042-20220808
hexagon              randconfig-r041-20220808
s390                 randconfig-r044-20220808
x86_64               randconfig-a013-20220808
x86_64               randconfig-a015-20220808
x86_64               randconfig-a016-20220808
x86_64               randconfig-a012-20220808
x86_64               randconfig-a011-20220808
x86_64               randconfig-a014-20220808
i386                 randconfig-a013-20220808
i386                 randconfig-a012-20220808
i386                 randconfig-a014-20220808
i386                 randconfig-a011-20220808
i386                 randconfig-a016-20220808
i386                 randconfig-a015-20220808

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
