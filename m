Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5835858E5
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Jul 2022 08:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiG3Gq5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 Jul 2022 02:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3Gq4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jul 2022 02:46:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3779560D1;
        Fri, 29 Jul 2022 23:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659163616; x=1690699616;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=agZBMiWJhTx0JPr8cNEQVxPQGftu22InmQ99LUpKtdA=;
  b=LGg4tqwaDRtDPw63sxLUKvxaYNtS6mvXL2RqcZVVwPOhPaYpMO4pWJKK
   rvFCeThpuslZz6UFEUOYmpKRuTJBGGemCltpOldrdsQ/qwH0z1e/lf34V
   hQVo9p9AvwkLHs8vQxgjgQD21AvccmKKql/fnIjUaCn5wURFrUsQNUE+2
   Ru/APN5JKoG7V8vE/kH3gppHWdaSMIMcBOKBaqLblm/4nfSmIS8e96JJb
   9yd72r5SmQR0v3wqB9g5e9l+cSZijHRXFrIHq9jl1NRD8UcZirubrC/I5
   0mQ+0yPaHxVaryW38KRY5Xv8IvvCDx7eUaf/oK3tS70TJMD5JveEDLzay
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="290100824"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="290100824"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="690947440"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jul 2022 23:46:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHgFR-000CYC-1m;
        Sat, 30 Jul 2022 06:46:53 +0000
Date:   Sat, 30 Jul 2022 14:45:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c58a7ee9d020676ef0f04782cc0ca5d0b0889df9
Message-ID: <62e4d3a4.gZtMY9Jhc1oCkQVv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c58a7ee9d020676ef0f04782cc0ca5d0b0889df9  Merge branch 'pm-cpuidle-next' into bleeding-edge

elapsed time: 710m

configs tested: 60
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220729
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                              allyesconfig
powerpc                           allnoconfig
alpha                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a006
powerpc                          allmodconfig
x86_64                        randconfig-a011
m68k                             allyesconfig
x86_64                        randconfig-a015
mips                             allyesconfig
sh                               allmodconfig
i386                          randconfig-a014
m68k                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
i386                          randconfig-a005
arm                                 defconfig
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                           sunxi_defconfig
sparc64                             defconfig

clang tested configs:
hexagon              randconfig-r041-20220729
riscv                randconfig-r042-20220729
hexagon              randconfig-r045-20220729
s390                 randconfig-r044-20220729
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                           mtx1_defconfig
powerpc                          g5_defconfig
mips                           ip28_defconfig
powerpc                  mpc866_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
