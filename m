Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360B258E765
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Aug 2022 08:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiHJGtr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Aug 2022 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJGtq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Aug 2022 02:49:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5171371722;
        Tue,  9 Aug 2022 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660114185; x=1691650185;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ng4aUm4odUinFQNAnLjcT37l1NPbArZDHokfS3Y2qgo=;
  b=CnY3yczirE47P6qijD4x+XXeyNxMsKKpNVf0rY9vcijJva0jwBeL/wfj
   yPA70sAqP9B9yizXSTgfLWupY9NA693/rexjJPGdQupYwlUoIFd/2yqU+
   EOXO3bsuWOAkJdbub0HmDYLgClC5I7OgXDzhxfsz0+mlhu5VmbDiG6EV0
   h/dGfTqqzDJPQjCO3XsellNqd7ueuG8IEhFCw/ZFdaHcvfQLPXZGzXSCk
   swGEi2O4YsDgpsKmJobfQP99RU24m6VrJtJv5x8suNQTx6uKQLlWEn5qY
   FVqtuNEG+R+aTugHABHv3Ri1IoQPnb5ngnDtKja0+/tPXLHgPu9GMrv/t
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291801113"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="291801113"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="932777087"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2022 23:49:42 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLfXC-00001P-03;
        Wed, 10 Aug 2022 06:49:42 +0000
Date:   Wed, 10 Aug 2022 14:49:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ad393690b235f40d3b4dc72d84e6fab3960edf9f
Message-ID: <62f354e5.j4wVK1ptuDBGM6vU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ad393690b235f40d3b4dc72d84e6fab3960edf9f  Merge branch 'acpi-properties' into linux-next

elapsed time: 729m

configs tested: 27
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20220810
riscv                randconfig-r042-20220810
s390                 randconfig-r044-20220810
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220810
hexagon              randconfig-r045-20220810

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
