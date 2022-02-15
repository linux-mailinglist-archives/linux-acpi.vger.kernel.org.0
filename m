Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00C84B64AF
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Feb 2022 08:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiBOHrv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Feb 2022 02:47:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiBOHrv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Feb 2022 02:47:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7718A302;
        Mon, 14 Feb 2022 23:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644911261; x=1676447261;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bKfn5cFC+4sCU4g1lSHUk5eDHm4O5lP5V0B5i3FL4vc=;
  b=YohNaK6p54AJsbiecAEN4JTYyuCtZt/jgO7/bnBZGSjkGjThr77YV0Qf
   zjsPeJV5uBYg+q+AMonHBAtwAuWQltPeXS/e/6mMkEu5Zdy0tUPa46oGx
   I2rqbP/nT318rruGBfZl6k9uGLuBjtSx/Lmve8HNCD4LqLK+JU8hGo6No
   KWPj3Mjxugx/QmNuqGw6w/rv28wVGJ4+sdoAwHgcM4VNurGBSavoUVRMK
   C05SvqGkqdDlOCbcK3EgBc7UuRMFHM/3NH42JgLdHzHTFRnM+GkqFEpLn
   eQadgTd3DRKT+KszE4SPRBoKSm5jhQ5VIozni2uta+Uex2NpVHEWTETws
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247866988"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="247866988"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 23:47:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="773394809"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2022 23:47:39 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJsYl-0009Qm-BC; Tue, 15 Feb 2022 07:47:39 +0000
Date:   Tue, 15 Feb 2022 15:47:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 41/47] ld.lld: error: undefined symbol:
 ghes_disable
Message-ID: <202202151504.jWpZGPaH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   9db71e8e3027d2026be1ea9b6cfce8fd7216fb01
commit: f521a6e687d139e5d33a3d92f5ba4cd0a825cc66 [41/47] ACPI: APEI: explicit init HEST and GHES in apci_init()
config: arm64-randconfig-r004-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151504.jWpZGPaH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=f521a6e687d139e5d33a3d92f5ba4cd0a825cc66
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout f521a6e687d139e5d33a3d92f5ba4cd0a825cc66
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ghes_notify_sea
   >>> referenced by acpi.c
   >>> kernel/acpi.o:(apei_claim_sea) in archive arch/arm64/built-in.a
--
>> ld.lld: error: undefined symbol: ghes_disable
   >>> referenced by bus.c
   >>> acpi/bus.o:(acpi_bus_init) in archive drivers/built-in.a
   >>> referenced by bus.c
   >>> acpi/bus.o:(acpi_bus_init) in archive drivers/built-in.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ACPI_APEI_GHES
   Depends on ACPI && ACPI_APEI
   Selected by
   - ARM_SDE_INTERFACE && ARM64

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
