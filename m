Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16B7792EE6
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbjIETbB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbjIETbB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:31:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570A6E5B;
        Tue,  5 Sep 2023 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693942244; x=1725478244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KcNUXs4+zMxG7TVyRLja8exWrEMSbmgUqcrWWaIjkpE=;
  b=c3UZSH9aixFOosXXR8zV18RAZhSEQGVmTrAQMDLeRgyCeQg3T7LQmKsW
   n576apHXX6CBTDzzJ08VaMU1P7jtKQ+JpC4RgyTd4wt4G+v0UZ4/91KFb
   b3vK0SWZqZpeKsYjQYeaBjjJCT6G9CoZTEqU2ud2BX/v54zULEU56JbZt
   0zIBx3QHSlNc7EWAOPSdVJIl3ikYijrj8QHRyIOKwA0xUwYccFpb5E4bK
   B6cFnjivZQxLgC9hCsRH5IGACQ04BDFQ8FLXDQVxOxZGSsWorsbAwIomd
   0GakQ9s9rMYD6l5HfNkNmtaPCdlurT/qpe3NQrYo7PFLHVhthqMRejRgN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="379604201"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="379604201"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 12:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="987944191"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="987944191"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Sep 2023 12:30:19 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdbkf-00020C-0g;
        Tue, 05 Sep 2023 19:30:17 +0000
Date:   Wed, 6 Sep 2023 03:29:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 1/5] include/linux/thermal.h:378:1: error:
 expected identifier or '(' before '{' token
Message-ID: <202309060300.8TA9PBXT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   3013f879e8da5a4cf707cdb0dfa927f89b9374cd
commit: 6c106aa9e0f7f8be4146c50bea5cd71052bebe3a [1/5] thermal: core: Clean up headers of thermal zone registration functions
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20230906/202309060300.8TA9PBXT-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309060300.8TA9PBXT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309060300.8TA9PBXT-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/acpi/processor.h:11,
                    from drivers/acpi/acpi_processor.c:22:
>> include/linux/thermal.h:378:1: error: expected identifier or '(' before '{' token
     378 | { return ERR_PTR(-ENODEV); }
         | ^
>> include/linux/thermal.h:370:43: warning: 'thermal_zone_device_register_with_trips' declared 'static' but never defined [-Wunused-function]
     370 | static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +378 include/linux/thermal.h

   369	
 > 370	static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
   371						const char *type,
   372						struct thermal_trip *trips,
   373						int num_trips, int mask,
   374						void *devdata,
   375						struct thermal_zone_device_ops *ops,
   376						const struct thermal_zone_params *tzp,
   377						int passive_delay, int polling_delay);
 > 378	{ return ERR_PTR(-ENODEV); }
   379	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
