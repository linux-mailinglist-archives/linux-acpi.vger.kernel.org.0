Return-Path: <linux-acpi+bounces-1726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC07F3ABC
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 01:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E6AB203A0
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9F629
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2/sX2SY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B63A1BC;
	Tue, 21 Nov 2023 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700607148; x=1732143148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LskDiBuvjSasPHzI3RZx0ZGahLutMUfdBedZf+vO8Fk=;
  b=a2/sX2SYK6V+hOh0Tp/DHdnACIkgdfp+0/PhhYVoYunFhTjYAP+R+G4Z
   DluBJThXiW8HqqGvitEqY87OMpwFPulVMmIBPusTZ/6cV5ESiuJSsiEZY
   IWGHDhIcU2NYymmfXD0s2VA5pIhXBVx2LUx2QJDywVrIW0C6ZinCG0WQI
   s9i2pWq+SLWr/ppRrXK+gPRvY1EMyRcyUvZqTrN5kUPfD30ZvN39YhMIR
   FfZFgHGdXOozI5lP+Z4b5xCBOmhgxTqfKrojaUgEzr9hw5S7uTSrwB9Fj
   yzBHQUyYTscsH/qyxKIX/GMCOinjtiLGr31ly5Db9rhpqXAlIZek/cVaS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="371290762"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="371290762"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 14:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="837191870"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="837191870"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2023 14:52:20 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5ZbO-0008Mm-0k;
	Tue, 21 Nov 2023 22:52:18 +0000
Date: Wed, 22 Nov 2023 06:52:17 +0800
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
Subject: Re: [PATCH v2 02/10] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <202311220635.mch7Y8LH-lkp@intel.com>
References: <20231121101844.1161-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121101844.1161-3-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231121-182247
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121101844.1161-3-shiju.jose%40huawei.com
patch subject: [PATCH v2 02/10] cxl/mbox: Add GET_FEATURE mailbox command
config: arc-randconfig-r113-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220635.mch7Y8LH-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220635.mch7Y8LH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220635.mch7Y8LH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/cxl/core/mbox.c:1319:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] size_out @@     got restricted __le32 [usertype] count @@
   drivers/cxl/core/mbox.c:1319:31: sparse:     expected unsigned int [usertype] size_out
   drivers/cxl/core/mbox.c:1319:31: sparse:     got restricted __le32 [usertype] count
>> drivers/cxl/core/mbox.c:1341:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] size_out @@     got restricted __le16 [usertype] count @@
   drivers/cxl/core/mbox.c:1341:31: sparse:     expected unsigned int [usertype] size_out
   drivers/cxl/core/mbox.c:1341:31: sparse:     got restricted __le16 [usertype] count
>> drivers/cxl/core/mbox.c:1343:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] min_out @@     got restricted __le16 [usertype] count @@
   drivers/cxl/core/mbox.c:1343:30: sparse:     expected unsigned int [usertype] min_out
   drivers/cxl/core/mbox.c:1343:30: sparse:     got restricted __le16 [usertype] count

vim +1341 drivers/cxl/core/mbox.c

  1330	
  1331	int cxl_get_feature(struct cxl_memdev_state *mds,
  1332			    struct cxl_mbox_get_feat_in *pi, void *feat_out)
  1333	{
  1334		struct cxl_mbox_cmd mbox_cmd;
  1335		int rc;
  1336	
  1337		mbox_cmd = (struct cxl_mbox_cmd) {
  1338			.opcode = CXL_MBOX_OP_GET_FEATURE,
  1339			.size_in = sizeof(*pi),
  1340			.payload_in = pi,
> 1341			.size_out = pi->count,
  1342			.payload_out = feat_out,
> 1343			.min_out = pi->count,
  1344		};
  1345		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
  1346		if (rc < 0)
  1347			return rc;
  1348	
  1349		return 0;
  1350	}
  1351	EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
  1352	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

