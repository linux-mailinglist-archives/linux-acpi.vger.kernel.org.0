Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39AB4C9B77
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Mar 2022 03:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiCBCwT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 21:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiCBCwT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 21:52:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183FDAB450;
        Tue,  1 Mar 2022 18:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646189497; x=1677725497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tm4+8lizUr2xgEpaQ+EdlRF/QIwp9cOAif5S+psZgdk=;
  b=G6uyvcYyvXANKqi+hTDwFd15UtK5IQ6tNa3AJ5YIxF6aFMzJSYsBr5cL
   LCEGvLELMQc9ePt1DOXTxHQXTZ1GgpehPX8latyPWyh2Bqu64lip9HtIA
   8/tdwjGykA5dUd4SK2+iAm0T9LP5uiFI9skR69x37vv/a761B/EnnCQcy
   VJPG7A/4/TXTAG3JSD2kFmAE+/vYOUEhmzJD3UBreBEVroZ2ofkenGAJZ
   n6dDxiq7LWGWjAj85twiU43V19MSwRR4oWCWB/lnaiLNkUCKhpaPWLgQU
   n1vYDfjYjwmjX2OhS2muc/nSlkWzGlWaRULrPqfK1CHZQCnkr+ZyovOe4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253219464"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253219464"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="510826971"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Mar 2022 18:51:34 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPF5R-0000wI-Ga; Wed, 02 Mar 2022 02:51:33 +0000
Date:   Wed, 2 Mar 2022 10:51:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Cilissen <mark@yotsuba.nl>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [rafael-pm:bleeding-edge 113/118]
 include/linux/mod_devicetable.h:587:25: warning: excess elements in array
 initializer
Message-ID: <202203020750.Uq6hGay2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f7307721a01f4f14d21c699b270a870370cf34b9
commit: ed00b2b8d737f87a2437d7bd7c7f90124b50da05 [113/118] x86 / ACPI: Work around broken XSDT on SEGA AALE board
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220302/202203020750.Uq6hGay2-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=ed00b2b8d737f87a2437d7bd7c7f90124b50da05
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout ed00b2b8d737f87a2437d7bd7c7f90124b50da05
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/acpi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/of.h:18,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from arch/x86/kernel/acpi/boot.c:11:
>> include/linux/mod_devicetable.h:587:25: warning: excess elements in array initializer
     587 | #define DMI_MATCH(a, b) { .slot = a, .substr = b }
         |                         ^
   arch/x86/kernel/acpi/boot.c:1476:8: note: in expansion of macro 'DMI_MATCH'
    1476 |        DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
         |        ^~~~~~~~~
   include/linux/mod_devicetable.h:587:25: note: (near initialization for 'acpi_dmi_table[6].matches')
     587 | #define DMI_MATCH(a, b) { .slot = a, .substr = b }
         |                         ^
   arch/x86/kernel/acpi/boot.c:1476:8: note: in expansion of macro 'DMI_MATCH'
    1476 |        DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
         |        ^~~~~~~~~


vim +587 include/linux/mod_devicetable.h

d945b697d0eea5 David Woodhouse 2008-09-16  586  
5017b2851373ee Jani Nikula     2013-07-03 @587  #define DMI_MATCH(a, b)	{ .slot = a, .substr = b }
5017b2851373ee Jani Nikula     2013-07-03  588  #define DMI_EXACT_MATCH(a, b)	{ .slot = a, .substr = b, .exact_match = 1 }
d2653e92732bd3 Jean Delvare    2008-04-29  589  

:::::: The code at line 587 was first introduced by commit
:::::: 5017b2851373ee15c7035151853bb1448800cae2 dmi: add support for exact DMI matches in addition to substring matching

:::::: TO: Jani Nikula <jani.nikula@intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
