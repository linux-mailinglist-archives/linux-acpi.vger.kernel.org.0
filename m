Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A713792FE8
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 22:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbjIEUYc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 16:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjIEUY1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 16:24:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30AF12C;
        Tue,  5 Sep 2023 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693945463; x=1725481463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UFy2n3TxwS/KmbKsOKVVpz6t61msRHReKOMWJz59BNA=;
  b=lJSMVUvkYs0oslF6BS21VvVfy1WHfeS1JTyJgc3YGO8gUoVTApt04dEf
   VKfST9aFMm3N3TGgCSzIhV3F7PuR0QQ2CcTYgzyeaF9Xrc6jJnAdh2mgT
   VaRA2sRuT2peYSpJyJhUSz3MUME/98Bx3ZZJV6XAeeVgi9ZXmqvfIFdih
   RGnbdCiFe9+/wQo0EMA0xW8+w3Pzk3XpEi7hkNmVH1tH95WXysL4e0CS4
   C28MSY714vEtDaq2cmseotRlElj8DTTb5oSEK+a+up0CIXc5YIa1J5e+j
   LihwenW1a5/cwhmp0WPezXyny78CiATp6sHTTc+KcQ1W7AaCTsw6+i3jq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380702976"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="380702976"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 13:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="744410793"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="744410793"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 Sep 2023 13:24:04 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdcaY-00022d-0L;
        Tue, 05 Sep 2023 20:23:58 +0000
Date:   Wed, 6 Sep 2023 04:22:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>, rafael@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, bhelgaas@google.com,
        benjamin.cheatham@amd.com, yazen.ghannam@amd.com
Subject: Re: [PATCH v3 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Message-ID: <202309060435.NqPCZpql-lkp@intel.com>
References: <20230905184406.135851-2-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905184406.135851-2-Benjamin.Cheatham@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ben,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.5 next-20230905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Cheatham/CXL-PCIE-Add-cxl_rcrb_addr-file-to-dport_dev/20230906-025405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230905184406.135851-2-Benjamin.Cheatham%40amd.com
patch subject: [PATCH v3 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230906/202309060435.NqPCZpql-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309060435.NqPCZpql-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309060435.NqPCZpql-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cxl/core/port.c: In function 'cxl_rcrb_addr_show':
>> drivers/cxl/core/port.c:953:38: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     953 |         return sysfs_emit(buf, "0x%llx\n", dport->rcrb.base);
         |                                   ~~~^     ~~~~~~~~~~~~~~~~
         |                                      |                |
         |                                      |                resource_size_t {aka unsigned int}
         |                                      long long unsigned int
         |                                   %x


vim +953 drivers/cxl/core/port.c

   940	
   941	static ssize_t cxl_rcrb_addr_show(struct device *dev,
   942					  struct device_attribute *attr, char *buf)
   943	{
   944		struct cxl_dport *dport;
   945	
   946		if (!cxl_root)
   947			return -ENODEV;
   948	
   949		dport = cxl_find_dport_by_dev(cxl_root, dev);
   950		if (!dport)
   951			return -ENODEV;
   952	
 > 953		return sysfs_emit(buf, "0x%llx\n", dport->rcrb.base);
   954	}
   955	DEVICE_ATTR_RO(cxl_rcrb_addr);
   956	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
