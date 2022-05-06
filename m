Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A070051D829
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392130AbiEFMvQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245378AbiEFMvQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 08:51:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A8733E1C;
        Fri,  6 May 2022 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841253; x=1683377253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lgRANVpIeYbETu3AmcMFp1S7V1/cZNNLTeeu8Vwuz7k=;
  b=K8fxmXhj7zMxjiI0h3kDihLUorFMXsHQzUU9zwoG3icseoIzc0MWb9pO
   eggcnKTpW3vaGaXaULG65586eRR4k27YbN3iN6BrRYWexONOUV3mW7dT+
   9rYaiLtU5JID0n1Qgn8YaTg0SIE5BrIXOXf3Zng+YSJhhe215RW1whosQ
   Wo39u4i6evVuPBao+25Go8bO6tWbJA0N01wL8OiTQLQ70C/GdB9kkVbMz
   XpJXZkjXyVRAZOd1VT0xOgGcB6PzTl/7iVVmS/uLcx8iI+wDpXB+5QUwB
   zb9y4hra7fSDHGh5RlFg/ZTegiOp9Yrg9Cod1bmRQP2aZDfM1a1zjghpy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267295609"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267295609"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="518024373"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2022 05:47:25 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmxMi-000DTo-H2;
        Fri, 06 May 2022 12:47:24 +0000
Date:   Fri, 6 May 2022 20:47:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, usama.anjum@collabora.com,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v9] platform/chrome: Add ChromeOS ACPI device driver
Message-ID: <202205062057.LDuKncYN-lkp@intel.com>
References: <YnTw/iQ1Asjjmsb9@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnTw/iQ1Asjjmsb9@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Muhammad,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on chrome-platform/for-next v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/platform-chrome-Add-ChromeOS-ACPI-device-driver/20220506-175951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220506/202205062057.LDuKncYN-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4f6407962feddc57bc7c80e5b29d5d339a1dba6c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/platform-chrome-Add-ChromeOS-ACPI-device-driver/20220506-175951
        git checkout 4f6407962feddc57bc7c80e5b29d5d339a1dba6c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/platform/chrome/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from drivers/platform/chrome/chromeos_acpi.c:13:
   drivers/platform/chrome/chromeos_acpi.c: In function 'chromeos_acpi_device_probe':
>> drivers/platform/chrome/chromeos_acpi.c:253:40: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'unsigned int' [-Wformat=]
     253 |                 dev_warn(&(pdev->dev), "Only %ld GPIO attr groups supported by the driver out of total %d.\n",
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:146:61: note: in expansion of macro 'dev_fmt'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/platform/chrome/chromeos_acpi.c:253:17: note: in expansion of macro 'dev_warn'
     253 |                 dev_warn(&(pdev->dev), "Only %ld GPIO attr groups supported by the driver out of total %d.\n",
         |                 ^~~~~~~~
   drivers/platform/chrome/chromeos_acpi.c:253:48: note: format string is defined here
     253 |                 dev_warn(&(pdev->dev), "Only %ld GPIO attr groups supported by the driver out of total %d.\n",
         |                                              ~~^
         |                                                |
         |                                                long int
         |                                              %d
   At top level:
   drivers/platform/chrome/chromeos_acpi.c:259:36: warning: 'chromeos_device_ids' defined but not used [-Wunused-const-variable=]
     259 | static const struct acpi_device_id chromeos_device_ids[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~


vim +253 drivers/platform/chrome/chromeos_acpi.c

   244	
   245	static int chromeos_acpi_device_probe(struct platform_device *pdev)
   246	{
   247		chromeos_acpi_gpio_groups = get_gpio_pkg_num(&pdev->dev);
   248	
   249		/* If platform has more GPIO attribute groups than the number of
   250		 * groups this driver supports, give out a warning message.
   251		 */
   252		if (chromeos_acpi_gpio_groups > (ARRAY_SIZE(chromeos_acpi_all_groups) - 2))
 > 253			dev_warn(&(pdev->dev), "Only %ld GPIO attr groups supported by the driver out of total %d.\n",
   254				 (ARRAY_SIZE(chromeos_acpi_all_groups) - 2), chromeos_acpi_gpio_groups);
   255		return 0;
   256	}
   257	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
