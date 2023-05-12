Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B08700F8C
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 22:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbjELUKA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 16:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjELUJ6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 16:09:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A38E26B5
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683922197; x=1715458197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tp2xh46A913lFUtWLvAyyxQWldT4ytG5KViNS+ZuCAU=;
  b=VwtMIMFS7h56svmkRNBgiYmjHNiynzkYku+EfIY+sTa7+mP+8isGX5vQ
   VpGpKq3HDFBGQaXcg6Jl/WezILrQPjnOWjn8f2+iw9Tk0F4olEhvMC1cD
   JjCFn1hkg2QLuk9GRO6UBCHTYjwTZudbXb/Estnwt2fOfTMRb62tl9v6R
   /8+uxuOQTWAg3/THtMwSZ2BxBjO5JPz4IIxX6rLph0Tr5jbyO2OXwOjFV
   Sx8H5Whj+6FOWTl0BmYxGtvCnpOdXyO38rogHeB0+7w07tDdt47a6ck+Y
   p+N1w/yJiHMZWPGc9faGHYTS3PqexJA0106n3VCQx8VJUdimO+Xc63Kkr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="354010204"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="354010204"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 13:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="765276042"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765276042"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2023 13:09:55 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxZ5P-00055Q-01;
        Fri, 12 May 2023 20:09:55 +0000
Date:   Sat, 13 May 2023 04:09:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: Re: [PATCH v1 09/34] acpi/tiny-power-button: Move handler installing
 logic to driver
Message-ID: <202305130350.ZEskVtFO-lkp@intel.com>
References: <20230512140222.124868-10-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512140222.124868-10-michal.wilczynski@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Michal,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on chrome-platform/for-next groeck-staging/hwmon-next linus/master v6.4-rc1 next-20230512]
[cannot apply to jic23-iio/togreg nvdimm/libnvdimm-for-next nvdimm/dax-misc crng-random/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230512140222.124868-10-michal.wilczynski%40intel.com
patch subject: [PATCH v1 09/34] acpi/tiny-power-button: Move handler installing logic to driver
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20230513/202305130350.ZEskVtFO-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e12cdb4ace4a523a569590ecc95f782f3d6fa98f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
        git checkout e12cdb4ace4a523a569590ecc95f782f3d6fa98f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305130350.ZEskVtFO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/tiny-power-button.c: In function 'acpi_tiny_power_button_add':
>> drivers/acpi/tiny-power-button.c:25:51: error: 'acpi_tiny_power_button_notify' undeclared (first use in this function); did you mean 'acpi_tiny_power_button_add'?
      25 |                                                   acpi_tiny_power_button_notify);
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                   acpi_tiny_power_button_add
   drivers/acpi/tiny-power-button.c:25:51: note: each undeclared identifier is reported only once for each function it appears in
   drivers/acpi/tiny-power-button.c: In function 'acpi_tiny_power_button_remove':
   drivers/acpi/tiny-power-button.c:31:42: error: 'acpi_tiny_power_button_notify' undeclared (first use in this function); did you mean 'acpi_tiny_power_button_remove'?
      31 |                                          acpi_tiny_power_button_notify);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          acpi_tiny_power_button_remove
   drivers/acpi/tiny-power-button.c: In function 'acpi_tiny_power_button_add':
   drivers/acpi/tiny-power-button.c:26:1: error: control reaches end of non-void function [-Werror=return-type]
      26 | }
         | ^
   drivers/acpi/tiny-power-button.c: At top level:
   drivers/acpi/tiny-power-button.c:34:13: warning: 'acpi_tiny_power_button_notify' defined but not used [-Wunused-function]
      34 | static void acpi_tiny_power_button_notify(acpi_handle handle, u32 event, void *data)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +25 drivers/acpi/tiny-power-button.c

    21	
    22	static int acpi_tiny_power_button_add(struct acpi_device *device)
    23	{
    24		return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
  > 25							  acpi_tiny_power_button_notify);
    26	}
    27	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
