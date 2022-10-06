Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B7A5F605C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Oct 2022 06:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJFE74 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Oct 2022 00:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJFE7z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2022 00:59:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6C167C7;
        Wed,  5 Oct 2022 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665032393; x=1696568393;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=81T7mOufefJg+2V/mGzWoXzQ4hLKKY86R/Gbl3MzZyc=;
  b=dJBVcI0oTYFfjwSbAqr43CQjao6THWXDHgMIcx4R3di1TnMEEezM8ou0
   tSWcnn7c5K96UgeJ30S7mYngOyZ/yLw7fU65ZPKzK9SOAwryODHSycs66
   QQgX6W/ncNZpx7HDUxkB1d/+EZBXpCoWHo1HzwOqVfwygyvOoLjPXI/R2
   mElwyKjAuduxPWt6inKgseopy3XRipNyrtDDW5y4GTAIwISSrkFCrPMJ7
   X4U0uf37Ubb+Auu7Iyq1W0BC2MmCf0yEhyBle8SuuJNNJS9OAPB+SO1Jg
   BkHfhKZB+hDFcb2y4hdX+Lm+XFsQTWnOsShlPgYhRqxsNuQg0lCZoxxFX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="283713147"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="283713147"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 21:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="713698744"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="713698744"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2022 21:59:49 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogIz7-0001wK-0F;
        Thu, 06 Oct 2022 04:59:49 +0000
Date:   Thu, 06 Oct 2022 12:59:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 b4d88401f829fc76ec736ec9ce44cdf4820629cf
Message-ID: <633e60af.oQiPOSi/yUwfHpaP%lkp@intel.com>
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
branch HEAD: b4d88401f829fc76ec736ec9ce44cdf4820629cf  Merge branch 'acpi-thermal' into bleeding-edge

elapsed time: 726m

configs tested: 72
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
x86_64                              defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                                defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
x86_64               randconfig-a011-20221003
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a014-20221003
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a012-20221003
arc                  randconfig-r043-20221003
arm                                 defconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a011-20221003
x86_64               randconfig-a013-20221003
i386                 randconfig-a013-20221003
i386                 randconfig-a012-20221003
s390                             allyesconfig
x86_64               randconfig-a015-20221003
x86_64               randconfig-a016-20221003
arc                  randconfig-r043-20221002
i386                 randconfig-a015-20221003
s390                 randconfig-r044-20221003
i386                 randconfig-a016-20221003
i386                             allyesconfig
i386                 randconfig-a014-20221003
arm64                            allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20221003
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
arm                           viper_defconfig
powerpc                      cm5200_defconfig

clang tested configs:
hexagon              randconfig-r041-20221003
hexagon              randconfig-r041-20221002
hexagon              randconfig-r045-20221002
i386                 randconfig-a004-20221003
i386                 randconfig-a003-20221003
hexagon              randconfig-r045-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
x86_64               randconfig-a003-20221003
i386                 randconfig-a006-20221003
x86_64               randconfig-a005-20221003
riscv                randconfig-r042-20221002
x86_64               randconfig-a002-20221003
i386                 randconfig-a005-20221003
s390                 randconfig-r044-20221002
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
powerpc                    mvme5100_defconfig
powerpc                     ppa8548_defconfig
powerpc                     akebono_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
