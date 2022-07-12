Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830C2571299
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jul 2022 08:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiGLG5H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jul 2022 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGLG5G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2022 02:57:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDAB951CC;
        Mon, 11 Jul 2022 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657609025; x=1689145025;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XiX0tAoOsmukuEMZ85nx4bGEwQxa5zwVfKa1CMZ4aRs=;
  b=RLS2LEsDxc2sFIfFDVb5RFr/eWplbWibTTXeis3AS9xwdpLabAjBnVCx
   stFjCwJocVuYL2m6K/MyC9tc9GovfxO/Sdv51YaE8FpcN0Tu/nL0KCz+w
   HMWpxZ/HATaVOat8hblK1UbbQXMNvgChj4ARYIGawSGMHh5FNm5wYNO/Q
   nyp5QQjXGw0sTwFi0ZutghLDml7AaF8BAah7TiVpzQXh/aXF8iwvAYGTx
   p2aaamZYXwsR3S8vBI4B8UXM/Fn9bZ6pbw9CWH6RosNZbbPRxK9fJpgF5
   +71K9fejx4BPccWepvtRKGRkgqxUE+SBJlpsErtNe6J1T+plnA0BOlmch
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284882241"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="284882241"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 23:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="922087011"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 23:57:03 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB9pP-0001qv-8W;
        Tue, 12 Jul 2022 06:57:03 +0000
Date:   Tue, 12 Jul 2022 14:56:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e71c5921cc5005d866e7acd0b501faff1f548897
Message-ID: <62cd1b0a.0xr7VHPcLploJ134%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e71c5921cc5005d866e7acd0b501faff1f548897  Merge branch 'thermal-core' into linux-next

elapsed time: 724m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220710
s390                 randconfig-r044-20220710
riscv                randconfig-r042-20220710
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220710
hexagon              randconfig-r045-20220710

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
