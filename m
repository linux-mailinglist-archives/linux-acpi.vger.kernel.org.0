Return-Path: <linux-acpi+bounces-1721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E30A7F393D
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 23:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6EEB21051
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 22:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73001584F0
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDvSRCoC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC7ACB;
	Tue, 21 Nov 2023 13:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700602072; x=1732138072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uEBVNeqKwVe2rty8DYNq8xTPRTe1IjjFFyd71FrkqFs=;
  b=WDvSRCoCdDUmFa5DczjfJchQv20VV1gPyvO8WfZSVhgyUazk/gabLJFo
   qDJD/wjfsoT+63S1+2857UlN3QXtYNJuo4zssCX6olgU70G3Tm2LlE8ca
   5YMGSY+l9bQ2joIfxJbU+Tj6hMfTrLJss4+TE08pBXL/0gybNgQWJPp14
   ykdeP0KhYF1m5G7QqT5k46EdUZqZZfHjohqj9FH6y9sKzXPTk6hBQTgvg
   EJ/W0BcU6sOg+JJyFexl8YwszQAHTT+mb0K4Np+a2oYxLg+UEO3O27ouE
   f8wrzBW1NUX9C1quQI1czsniQjbA561uYiOxIrf6et5k9jwroqO2HHHnV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="389080903"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="389080903"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:27:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="15029831"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 13:27:44 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5YHW-0008HO-14;
	Tue, 21 Nov 2023 21:27:42 +0000
Date: Wed, 22 Nov 2023 05:27:15 +0800
From: kernel test robot <lkp@intel.com>
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org,
	lenb@kernel.org, naoya.horiguchi@nec.com, james.morse@arm.com,
	jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	mike.malvestuto@intel.com
Subject: Re: [PATCH v2 01/10] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Message-ID: <202311220525.o2AUzf97-lkp@intel.com>
References: <20231121101844.1161-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121101844.1161-2-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231121-182247
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121101844.1161-2-shiju.jose%40huawei.com
patch subject: [PATCH v2 01/10] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
config: arc-randconfig-r113-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220525.o2AUzf97-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220525.o2AUzf97-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220525.o2AUzf97-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cxl/core/mbox.c:1318:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] size_out @@     got restricted __le32 [usertype] count @@
   drivers/cxl/core/mbox.c:1318:31: sparse:     expected unsigned int [usertype] size_out
   drivers/cxl/core/mbox.c:1318:31: sparse:     got restricted __le32 [usertype] count

vim +1318 drivers/cxl/core/mbox.c

  1306	
  1307	int cxl_get_supported_features(struct cxl_memdev_state *mds,
  1308							struct cxl_mbox_get_supp_feats_in *pi,
  1309							void *feats_out)
  1310	{
  1311		struct cxl_mbox_cmd mbox_cmd;
  1312		int rc;
  1313	
  1314		mbox_cmd = (struct cxl_mbox_cmd) {
  1315			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
  1316			.size_in = sizeof(*pi),
  1317			.payload_in = pi,
> 1318			.size_out = pi->count,
  1319			.payload_out = feats_out,
  1320			.min_out = sizeof(struct cxl_mbox_get_supp_feats_out),
  1321		};
  1322		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
  1323		if (rc < 0)
  1324			return rc;
  1325	
  1326		return 0;
  1327	}
  1328	EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
  1329	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

