Return-Path: <linux-acpi+bounces-1730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E87F3BD2
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 03:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BAEB216DD
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 02:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222008460
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgPH2iHm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077AA181;
	Tue, 21 Nov 2023 18:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700618603; x=1732154603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KmomHtCj6nESx87+Js1u9Z2YNV0lNh6hqZAaci012Sw=;
  b=hgPH2iHmC+pVtObyZEPpsxJcqLdritY6qmGi58pBpqhNQfaEyc5hcU0W
   E1hdhI/9jIkifl3K3TpxE1XKaEH5HlznuQFl6QsLY5TOhwnhguG3rc1nt
   xi5Xa0hIjW9x/zg8WIIDL/xs2LMvn3xZSybAZuWmFVendtYIuDeiY2zta
   /LmEROeZdSOrbWwMtGTzjQd6ovHB1Nt9liu0I7EZknJqv0zMeZih5zQiB
   M6/hViRgJ2FtlAys1qv0XNjCHmoghrFXx0ItmLjTKFBRiexpCLTXvkcEF
   3kynO6qMuRy72/YZ17uK8IvTnOMahxh7HFisrUeaaeTlQbBC/D26C65ex
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372138332"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="372138332"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="14720458"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 21 Nov 2023 18:03:14 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5ca8-0008WH-1J;
	Wed, 22 Nov 2023 02:03:12 +0000
Date: Wed, 22 Nov 2023 09:59:32 +0800
From: kernel test robot <lkp@intel.com>
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
	Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
	tony.luck@intel.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	rafael@kernel.org, lenb@kernel.org, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	mike.malvestuto@intel.com
Subject: Re: [PATCH v2 06/10] memory: scrub: Add scrub driver supports
 configuring memory scrubbers in the system
Message-ID: <202311220944.tcffRUl0-lkp@intel.com>
References: <20231121101844.1161-7-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121101844.1161-7-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231121-182247
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121101844.1161-7-shiju.jose%40huawei.com
patch subject: [PATCH v2 06/10] memory: scrub: Add scrub driver supports configuring memory scrubbers in the system
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231122/202311220944.tcffRUl0-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220944.tcffRUl0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220944.tcffRUl0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/memory/scrub/memory-scrub.c:71:48: warning: comparison of array 'scrub_dev->name' equal to a null pointer is always false [-Wtautological-pointer-compare]
           if (attr == &dev_attr_name.attr && scrub_dev->name == NULL)
                                              ~~~~~~~~~~~^~~~    ~~~~
   1 warning generated.


vim +71 drivers/memory/scrub/memory-scrub.c

    64	
    65	static umode_t scrub_dev_attr_is_visible(struct kobject *kobj,
    66						    struct attribute *attr, int n)
    67	{
    68		struct device *dev = kobj_to_dev(kobj);
    69		struct scrub_device *scrub_dev = to_scrub_device(dev);
    70	
  > 71		if (attr == &dev_attr_name.attr && scrub_dev->name == NULL)
    72			return 0;
    73	
    74		return attr->mode;
    75	}
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

