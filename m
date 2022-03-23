Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEBF4E5B51
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 23:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbiCWWjw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 18:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345267AbiCWWju (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 18:39:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A83A1B9;
        Wed, 23 Mar 2022 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648075099; x=1679611099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8W6j9MRzMqrTwJHwnu1KmnMFhXBPnNCWDanG0n2qgGU=;
  b=KIQN5SDe5OsxkS5nVugw2QZjcukf4ihPt4BBds6mHspeHhs6m+hZIwy7
   Ga5SoTSJog0JEGbdLSJ+PHYlcqdn62HspFXJagX+lDHv+dZqlB+KmHotz
   AX7uxevFDm1UHHWNnBThTU3VkuzMYWyQOaQAKlakIW4zXtc1wKBql/+UE
   KNy2P5GWnVuNCgfPHllAjPexPZgj6KRdSWO8ymSbK16uo6ZMp/MqvdMr5
   +rcKEyjo0ZjGqcvJkvdzADrxIFQ9u+Xzv2wnXB4L2KbBPHFuGVpymBVPB
   wKY/YvFq64dUArgVPycSpq/jLkUL39ZI4zFkkVJkjkJqkKv7PBmaeBfcY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="257952560"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="257952560"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 15:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="637641640"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Mar 2022 15:38:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX9cI-000KRL-Mn; Wed, 23 Mar 2022 22:38:10 +0000
Date:   Thu, 24 Mar 2022 06:37:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     kbuild-all@lists.01.org, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 3/4] device property: Add iomap to fwnode operations
Message-ID: <202203240648.x2upaXar-lkp@intel.com>
References: <20220323154737.169483-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323154737.169483-4-sakari.ailus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on next-20220323]
[cannot apply to driver-core/driver-core-testing robh/for-next v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sakari-Ailus/Shovel-firmware-specific-code-to-appropriate-locations/20220324-000256
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220324/202203240648.x2upaXar-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c9025bc8f89f50eaf9b9d628f1ac5d47b77c6bc8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sakari-Ailus/Shovel-firmware-specific-code-to-appropriate-locations/20220324-000256
        git checkout c9025bc8f89f50eaf9b9d628f1ac5d47b77c6bc8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x122): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x230): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x69c): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x7e): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x502): undefined reference to `iounmap'
   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   clk-fixed-mmio.c:(.text+0x90): undefined reference to `of_iomap'
   s390-linux-ld: clk-fixed-mmio.c:(.text+0xcc): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x144): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x76c): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x960): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
   timer-microchip-pit64b.c:(.init.text+0x67c): undefined reference to `of_iomap'
   s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0xcd2): undefined reference to `iounmap'
   s390-linux-ld: drivers/of/property.o: in function `of_fwnode_iomap':
>> property.c:(.text+0x1b8c): undefined reference to `of_iomap'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
