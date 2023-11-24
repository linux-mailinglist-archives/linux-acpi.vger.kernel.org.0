Return-Path: <linux-acpi+bounces-1813-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229007F7660
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 15:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0202809FE
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E9C9444
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N83SE/du"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5278A8;
	Fri, 24 Nov 2023 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700832131; x=1732368131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zLBpZsi4EvW4qAY9AV/g6RcsAWxtHMXbFPgMBS5FyFo=;
  b=N83SE/duaDqv0CGmASO7QdP2tnQvN9/hpWaTU1pSFAYg5U8f01qtLvs1
   r5f9gu9tnGSBWS+oOm9vuOcSEi4KldFl/+9IsbsDfW032xepLJnFfm528
   5YlN4VrwrpEA/7aPkcw06X0T9hWYW0MiI7rW/QWsH35RVolnnMGP92Cuu
   mIvuHiNPcYW2h78GFmugkkN1WRZIW0J3U9wUD/mtQsGpLzyMu9Bp4eFWk
   isG4tZiWCotmCriwCrFDxJgSwT0Jq7409uwLW48sGfGkj/8gUvwVw0NSl
   OaAKqrsQjDRvKXQNma6zZeqYWjuVx43SGTCJ1/3TP7uDIHmY1pykfD5dY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389575407"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389575407"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15632202"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2023 05:21:33 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6W7e-0002oF-28;
	Fri, 24 Nov 2023 13:21:30 +0000
Date: Fri, 24 Nov 2023 21:20:15 +0800
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
Subject: Re: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Message-ID: <202311241526.R8n6AibH-lkp@intel.com>
References: <20231123174355.1176-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123174355.1176-2-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on krzk-mem-ctrl/for-next]
[also build test WARNING on linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231124-014622
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-next
patch link:    https://lore.kernel.org/r/20231123174355.1176-2-shiju.jose%40huawei.com
patch subject: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
config: i386-randconfig-061-20231124 (https://download.01.org/0day-ci/archive/20231124/202311241526.R8n6AibH-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241526.R8n6AibH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241526.R8n6AibH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cxl/core/mbox.c:1317:30: sparse: sparse: cast from restricted __le32

vim +1317 drivers/cxl/core/mbox.c

  1305	
  1306	int cxl_get_supported_features(struct cxl_memdev_state *mds,
  1307							struct cxl_mbox_get_supp_feats_in *pi,
  1308							void *feats_out)
  1309	{
  1310		struct cxl_mbox_cmd mbox_cmd;
  1311		int rc;
  1312	
  1313		mbox_cmd = (struct cxl_mbox_cmd) {
  1314			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
  1315			.size_in = sizeof(*pi),
  1316			.payload_in = pi,
> 1317			.size_out = (size_t)pi->count,
  1318			.payload_out = feats_out,
  1319			.min_out = sizeof(struct cxl_mbox_get_supp_feats_out),
  1320		};
  1321		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
  1322		if (rc < 0)
  1323			return rc;
  1324	
  1325		return 0;
  1326	}
  1327	EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
  1328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

