Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7279344B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Sep 2023 06:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjIFEGi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Sep 2023 00:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIFEGi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2023 00:06:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D71B3;
        Tue,  5 Sep 2023 21:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693973195; x=1725509195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=amTDBVFkvTVeIeqLBgqSEueCBLGR8qIVrDnoTMqQ+VA=;
  b=iygvgnsg9NXZ3CpxYvn6pk833FYDh2nkWC6xJi84w3WlRBhFjoJabPJZ
   bs9lokeLP9jFP2CYz53UM4XDutjLXf3kH3AWAvLB8BYb4OGC7cK/o30R6
   NugPR4l2V8fEyNe1871xl9Wfivmz6FyE/OCCNafMgiV68CQXufDgRj2Sa
   gr6xdGK/3lBbUkoyr35l/NEFVdh8TeKC0A0BkLM6TTEyweEbzB+JQ/TaR
   2fC4WZzzYk6PxslgrVJEgyuNsRSlV37xj+G34OKQyF0DbDGKRPXRtU332
   4RkXN1O2YZfqXTdiCqka1BZduiEjAnh508tLvZ2SMHHzayQQxHLnKJMfn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407966094"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="407966094"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="691163739"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="691163739"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Sep 2023 21:05:02 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdjmk-0002Rf-2e;
        Wed, 06 Sep 2023 04:04:59 +0000
Date:   Wed, 6 Sep 2023 12:04:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>, rafael@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, bhelgaas@google.com,
        benjamin.cheatham@amd.com, yazen.ghannam@amd.com
Subject: Re: [PATCH v3 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Message-ID: <202309061156.nyIdvSmV-lkp@intel.com>
References: <20230905184406.135851-3-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905184406.135851-3-Benjamin.Cheatham@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ben,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.5 next-20230905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Cheatham/CXL-PCIE-Add-cxl_rcrb_addr-file-to-dport_dev/20230906-025405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230905184406.135851-3-Benjamin.Cheatham%40amd.com
patch subject: [PATCH v3 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type support
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20230906/202309061156.nyIdvSmV-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309061156.nyIdvSmV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309061156.nyIdvSmV-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: drivers/cxl/security.o: in function `cxl_find_rch_dport_by_rcrb':
>> (.text+0x8d0): multiple definition of `cxl_find_rch_dport_by_rcrb'; drivers/cxl/pmem.o:(.text+0x1090): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
