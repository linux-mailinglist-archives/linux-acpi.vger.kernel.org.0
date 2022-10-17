Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868CA6016CC
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Oct 2022 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJQTAk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Oct 2022 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJQTAj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2022 15:00:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7018774375;
        Mon, 17 Oct 2022 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666033237; x=1697569237;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UYwqn8lfrfS9iaOUz7zhvOyKhScwE6zhaTGCrMNhQhE=;
  b=dRAcy++e/e9kAQUmz+nJNsYWOgWffjzwEI3eG92ttXiHGC5giSamTder
   QRNLT8HMEvaoZy690ul7v82MbDCNRwWMd+26tcPY89hagMxm0Q8ft2Rze
   s15o1jaQfzr9xmrDkiNM88qd5J0Z7O45Hr/MoODujjxF3Ep0lKNYOU36H
   PKjmnY1BoxxAwU4i8+QwGD/JUNJDd/BFC3VVB/uoCGGa08u2hbG0Wh9Zp
   tJulN+f8vZ9hD/Qg3KMV3g8Eql6nzH2M+hV5z61qUU56QsrQ1JCTKtWve
   gRQxyXq7qK5sN52RjEv32c2M4uKTMnGa+tRd9c452k3/ly5GwP2iTGHQS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="332432244"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="332432244"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 12:00:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="579483303"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="579483303"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Oct 2022 12:00:34 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okVLl-0000oO-3C;
        Mon, 17 Oct 2022 19:00:33 +0000
Date:   Tue, 18 Oct 2022 02:59:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 da137aba6fe2ba43809c68e882d41e0a2bb3a774
Message-ID: <634da62f.Xx2C68NeB/s3GHYl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: da137aba6fe2ba43809c68e882d41e0a2bb3a774  Merge branch 'thermal-intel' into bleeding-edge

elapsed time: 957m

configs tested: 43
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                              defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                  randconfig-r043-20221017
i386                                defconfig
i386                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
i386                 randconfig-a001-20221017
i386                 randconfig-a002-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a005-20221017
i386                 randconfig-a004-20221017

clang tested configs:
hexagon              randconfig-r045-20221017
hexagon              randconfig-r041-20221017
riscv                randconfig-r042-20221017
s390                 randconfig-r044-20221017

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
