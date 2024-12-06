Return-Path: <linux-acpi+bounces-9987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9629E64C4
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664A8168279
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16A18E373;
	Fri,  6 Dec 2024 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuHv+89v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575617C224;
	Fri,  6 Dec 2024 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455365; cv=none; b=Q0GLoO46Hop/gxlyXm4h51ZczfiWVHdh8bo/1BYsdRKg4gbztg8TrYjwAIsDZgSDZPClFcoca1rALqFwqY/ruDz1DGb5K6+B/YD8MzcgTk+mYP8UmtgYJvLjEyrLUxKBdKhlH/tMl0AhIopjiC8MWWIHqpYKYpsarTM8C7iKz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455365; c=relaxed/simple;
	bh=5yfacooh1q8ddkvqfVkRI63lg/jowgqtpCOcaQCWDoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH1pGEqgl/WvYIrV9kfK1yP1Dv7a7r3ScGT9qE71kLZksQVvIN8QVpIky+GdejbZmYLGlqcA1XVetnRAWu/JpuYg4TMhu78ECcrVGna/hhBAvgh+CHmmmWZyWMnsOHPaaaLXQiSx3cK5FjpzxQCpvwGkUMsIUEjMI49k243CG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuHv+89v; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733455363; x=1764991363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5yfacooh1q8ddkvqfVkRI63lg/jowgqtpCOcaQCWDoU=;
  b=FuHv+89vbj5noqfWZVINtuGgamqfhd6og0Z4traa1ztgZH2fsW1hn4o3
   ltw4VQpOQXFcyfW8+vzg8SqEAGseNJRlEUpKSxpn4lbysVO31eTleqMt4
   hcwvv6ow5mgYFtF4/m+h/qSu3dVmz5pSTr+RykwWKsk3a4gPW8ksZK8QT
   USFgrOS5ZvPF3hCa4gW7tg3lLEOoxV0fT5EtLwyYT+1/0C8QDjC8cEBoG
   nyB+UbdozVO3tmLv23fZmkdsPyMG8hTtJgro8UtJuf2mC6lehOszXgALM
   CZb0KkR0MQex9r2hsWe8E2cgMHk3cY/d/ChCnh2SwzNbT2jEofhT/LUMM
   A==;
X-CSE-ConnectionGUID: kzalme3zTG6AAfi/UbZCLw==
X-CSE-MsgGUID: VjQuQg1XSt+q77wHLMy3uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33680608"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33680608"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 19:22:42 -0800
X-CSE-ConnectionGUID: FuKTYfqxQA2rmsNE8xvOtQ==
X-CSE-MsgGUID: BHRpg1JRTZqQnLRl1XS4LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="131700249"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Dec 2024 19:22:37 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJOvK-0000et-0k;
	Fri, 06 Dec 2024 03:22:34 +0000
Date: Fri, 6 Dec 2024 11:21:47 +0800
From: kernel test robot <lkp@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
	bp@alien8.de, robert.moore@intel.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse
 warning
Message-ID: <202412061152.Zar8cGxV-lkp@intel.com>
References: <20241205211854.43215-4-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205211854.43215-4-zaidal@os.amperecomputing.com>

Hi Zaid,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.13-rc1 next-20241205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zaid-Alali/ACPICA-Update-values-to-hex-to-follow-ACPI-specs/20241206-052420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241205211854.43215-4-zaidal%40os.amperecomputing.com
patch subject: [PATCH v2 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse warning
config: i386-buildonly-randconfig-005-20241206 (https://download.01.org/0day-ci/archive/20241206/202412061152.Zar8cGxV-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412061152.Zar8cGxV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412061152.Zar8cGxV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/apei/einj-core.c:23:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/acpi/apei/einj-core.c:338:6: warning: variable 'p' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     338 |         if (!r) {
         |             ^~
   drivers/acpi/apei/einj-core.c:436:6: note: uninitialized use occurs here
     436 |         if (p)
         |             ^
   drivers/acpi/apei/einj-core.c:338:2: note: remove the 'if' if its condition is always false
     338 |         if (!r) {
         |         ^~~~~~~~~
     339 |                 pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     340 |                        (unsigned long long)trigger_paddr,
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     341 |                        (unsigned long long)trigger_paddr +
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     342 |                             sizeof(*trigger_tab) - 1);
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~
     343 |                 goto out;
         |                 ~~~~~~~~~
     344 |         }
         |         ~
   drivers/acpi/apei/einj-core.c:334:17: note: initialize the variable 'p' to silence this warning
     334 |         void __iomem *p;
         |                        ^
         |                         = NULL
   2 warnings generated.


vim +338 drivers/acpi/apei/einj-core.c

e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  301  
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  302  static struct acpi_generic_address *einj_get_trigger_parameter_region(
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  303  	struct acpi_einj_trigger *trigger_tab, u64 param1, u64 param2)
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  304  {
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  305  	int i;
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  306  	struct acpi_whea_header *entry;
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  307  
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  308  	entry = (struct acpi_whea_header *)
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  309  		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  310  	for (i = 0; i < trigger_tab->entry_count; i++) {
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  311  		if (entry->action == ACPI_EINJ_TRIGGER_ERROR &&
1d5d820b8fe83b5 drivers/acpi/apei/einj.c      Yazen Ghannam    2017-08-28  312  		entry->instruction <= ACPI_EINJ_WRITE_REGISTER_VALUE &&
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  313  		entry->register_region.space_id ==
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  314  			ACPI_ADR_SPACE_SYSTEM_MEMORY &&
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  315  		(entry->register_region.address & param2) == (param1 & param2))
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  316  			return &entry->register_region;
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  317  		entry++;
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  318  	}
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  319  
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  320  	return NULL;
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  321  }
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  322  /* Execute instructions in trigger error action table */
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  323  static int __einj_error_trigger(u64 trigger_paddr, u32 type,
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  324  				u64 param1, u64 param2)
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  325  {
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  326  	struct acpi_einj_trigger *trigger_tab = NULL;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  327  	struct apei_exec_context trigger_ctx;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  328  	struct apei_resources trigger_resources;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  329  	struct acpi_whea_header *trigger_entry;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  330  	struct resource *r;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  331  	u32 table_size;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  332  	int rc = -EIO;
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  333  	struct acpi_generic_address *trigger_param_region = NULL;
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  334  	void __iomem *p;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  335  
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  336  	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  337  			       "APEI EINJ Trigger Table");
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18 @338  	if (!r) {
b2f740baa421525 drivers/acpi/apei/einj.c      Borislav Petkov  2016-05-23  339  		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  340  		       (unsigned long long)trigger_paddr,
46b91e379f7180b drivers/acpi/apei/einj.c      Bjorn Helgaas    2011-12-08  341  		       (unsigned long long)trigger_paddr +
46b91e379f7180b drivers/acpi/apei/einj.c      Bjorn Helgaas    2011-12-08  342  			    sizeof(*trigger_tab) - 1);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  343  		goto out;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  344  	}
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  345  	p = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  346  	if (!p) {
b2f740baa421525 drivers/acpi/apei/einj.c      Borislav Petkov  2016-05-23  347  		pr_err("Failed to map trigger table!\n");
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  348  		goto out_rel_header;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  349  	}
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  350  	trigger_tab = __io_virt(p);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  351  	rc = einj_check_trigger_header(trigger_tab);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  352  	if (rc) {
933ca4e323de777 drivers/acpi/apei/einj.c      Kefeng Wang      2019-10-18  353  		pr_warn(FW_BUG "Invalid trigger error action table.\n");
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  354  		goto out_rel_header;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  355  	}
4c40aed869a200a drivers/acpi/apei/einj.c      Niklas Söderlund 2012-01-09  356  
4c40aed869a200a drivers/acpi/apei/einj.c      Niklas Söderlund 2012-01-09  357  	/* No action structures in the TRIGGER_ERROR table, nothing to do */
4c40aed869a200a drivers/acpi/apei/einj.c      Niklas Söderlund 2012-01-09  358  	if (!trigger_tab->entry_count)
4c40aed869a200a drivers/acpi/apei/einj.c      Niklas Söderlund 2012-01-09  359  		goto out_rel_header;
4c40aed869a200a drivers/acpi/apei/einj.c      Niklas Söderlund 2012-01-09  360  
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  361  	rc = -EIO;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  362  	table_size = trigger_tab->table_size;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  363  	r = request_mem_region(trigger_paddr + sizeof(*trigger_tab),
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  364  			       table_size - sizeof(*trigger_tab),
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  365  			       "APEI EINJ Trigger Table");
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  366  	if (!r) {
b2f740baa421525 drivers/acpi/apei/einj.c      Borislav Petkov  2016-05-23  367  		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  368  		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
46b91e379f7180b drivers/acpi/apei/einj.c      Bjorn Helgaas    2011-12-08  369  		       (unsigned long long)trigger_paddr + table_size - 1);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  370  		goto out_rel_header;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  371  	}
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  372  	iounmap(p);
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  373  	p = ioremap_cache(trigger_paddr, table_size);
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  374  	if (!p) {
b2f740baa421525 drivers/acpi/apei/einj.c      Borislav Petkov  2016-05-23  375  		pr_err("Failed to map trigger table!\n");
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  376  		goto out_rel_entry;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  377  	}
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  378  	trigger_tab = __io_virt(p);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  379  	trigger_entry = (struct acpi_whea_header *)
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  380  		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  381  	apei_resources_init(&trigger_resources);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  382  	apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  383  			   ARRAY_SIZE(einj_ins_type),
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  384  			   trigger_entry, trigger_tab->entry_count);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  385  	rc = apei_exec_collect_resources(&trigger_ctx, &trigger_resources);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  386  	if (rc)
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  387  		goto out_fini;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  388  	rc = apei_resources_sub(&trigger_resources, &einj_resources);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  389  	if (rc)
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  390  		goto out_fini;
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  391  	/*
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  392  	 * Some firmware will access target address specified in
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  393  	 * param1 to trigger the error when injecting memory error.
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  394  	 * This will cause resource conflict with regular memory.  So
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  395  	 * remove it from trigger table resources.
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  396  	 */
c5a130325f13b21 drivers/acpi/apei/einj.c      Chen Gong        2013-06-06  397  	if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && param2) {
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  398  		struct apei_resources addr_resources;
37ea9693869627d drivers/acpi/apei/einj.c      Jay Lu           2022-12-06  399  
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  400  		apei_resources_init(&addr_resources);
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  401  		trigger_param_region = einj_get_trigger_parameter_region(
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  402  			trigger_tab, param1, param2);
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  403  		if (trigger_param_region) {
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  404  			rc = apei_resources_add(&addr_resources,
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  405  				trigger_param_region->address,
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  406  				trigger_param_region->bit_width/8, true);
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  407  			if (rc)
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  408  				goto out_fini;
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  409  			rc = apei_resources_sub(&trigger_resources,
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  410  					&addr_resources);
b4e008dc53a31cb drivers/acpi/apei/einj.c      Xiao, Hui        2011-12-08  411  		}
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  412  		apei_resources_fini(&addr_resources);
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  413  		if (rc)
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  414  			goto out_fini;
fdea163d8c17ba0 drivers/acpi/apei/einj.c      Huang Ying       2011-12-08  415  	}
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  416  	rc = apei_resources_request(&trigger_resources, "APEI EINJ Trigger");
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  417  	if (rc)
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  418  		goto out_fini;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  419  	rc = apei_exec_pre_map_gars(&trigger_ctx);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  420  	if (rc)
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  421  		goto out_release;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  422  
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  423  	rc = apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  424  
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  425  	apei_exec_post_unmap_gars(&trigger_ctx);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  426  out_release:
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  427  	apei_resources_release(&trigger_resources);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  428  out_fini:
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  429  	apei_resources_fini(&trigger_resources);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  430  out_rel_entry:
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  431  	release_mem_region(trigger_paddr + sizeof(*trigger_tab),
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  432  			   table_size - sizeof(*trigger_tab));
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  433  out_rel_header:
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  434  	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  435  out:
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  436  	if (p)
37dbc95939d19c3 drivers/acpi/apei/einj-core.c Zaid Alali       2024-12-05  437  		iounmap(p);
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  438  
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  439  	return rc;
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  440  }
e40213450b53157 drivers/acpi/apei/einj.c      Huang Ying       2010-05-18  441  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

