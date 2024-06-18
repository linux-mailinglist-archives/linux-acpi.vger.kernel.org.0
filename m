Return-Path: <linux-acpi+bounces-6497-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EFB90DB95
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 20:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161531C2251A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA1E1581E9;
	Tue, 18 Jun 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVnWenwl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A962139C6;
	Tue, 18 Jun 2024 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735541; cv=none; b=pGty+yx+qjKrMVx1zXBkO9wzQLThwwV55lbi9AJPsMmgoulXtlmBigu/10dYomB9FSqDD/9C1MRtwQaxROM6l3PVZZpDHDMBm9larh2I3oRTn/HMwqZmC1spLpDpDMdnCxWqfnbcYtHS4sZpTmcBTOFdnDxufn39h4L350S2wwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735541; c=relaxed/simple;
	bh=SrnPl07BTfc9+u75OWMWEt5md6swr5rr4F+oLflqxhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHF2VcWOAM20HzuikmbJrL/yEjeZD+Tx2syEJ0j0ETXWPIRZxWeMjoec/vXI6j4TipdOi3fGj58F8zqaOm3cWNcywwN33BC96eUWm8K7hK83DDh5KpEwCtW71RdxV/rezhMqd5OGy3YTlBiULAEIEo1zEJEisbNu11PU2ng2qFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVnWenwl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718735539; x=1750271539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SrnPl07BTfc9+u75OWMWEt5md6swr5rr4F+oLflqxhk=;
  b=IVnWenwl66xUrIsa8jqpbPJQ4Rcqx3h0VVLyn1L0pBLT/KJnqckmMM00
   F8X+uD+ySskDs9CGsVy2Rc83prAYxmVYxEGT7oS+GInrCieTxle972P9s
   SyCFBqf1R94xMXpn8kVcgFGMnaH2C7p4QcbYWO+lc6kd6Ro6R5AgP5SU+
   9LuLsBkzMlvuRAfgx9lP2lmQ/Uutw9XN8r2RJl1oX4nxRLE7IS1UHXKSA
   vTf++6lmMFF9GxsZDLyiFhsjjloMimkmQgwpb4MQTKkGCdqWlW3ZhRlIz
   Fo3BLEj8C+ynxVO81EYWEcM+8PM8PoM1DEzSJnCyEzNYTaoxVNSKT3WfH
   Q==;
X-CSE-ConnectionGUID: YwprC9RKSM+SUOzFra6mVQ==
X-CSE-MsgGUID: nUQ3JLQdR3a70aMUFX/wCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15781613"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15781613"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 11:32:18 -0700
X-CSE-ConnectionGUID: 925BNXD6T5u4irsJbYCTXw==
X-CSE-MsgGUID: LkApo/3yTOCZ+96MX8jlcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41741312"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2024 11:32:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJdcq-0005p4-1G;
	Tue, 18 Jun 2024 18:32:12 +0000
Date: Wed, 19 Jun 2024 02:31:56 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>, linux-acpi@vger.kernel.org,
	rafael@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mario.limonciello@amd.com,
	lenb@kernel.org, linux-kernel@vger.kernel.org, mmikowski@kfocus.org
Subject: Re: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <202406190206.Z56zEzTy-lkp@intel.com>
References: <ZnD22b3Br1ng7alf@kf-XE>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnD22b3Br1ng7alf@kf-XE>

Hi Aaron,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.10-rc4 next-20240618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Rainbolt/acpi-Allow-ignoring-_OSC-CPPC-v2-bit-via-kernel-parameter/20240618-105454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/ZnD22b3Br1ng7alf%40kf-XE
patch subject: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240619/202406190206.Z56zEzTy-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406190206.Z56zEzTy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406190206.Z56zEzTy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/cppc_acpi.c:677: warning: Function parameter or struct member 'ignore_osc_cppc_bit' not described in 'acpi_cppc_processor_probe'


vim +677 drivers/acpi/cppc_acpi.c

41ea667227bad5 Nathan Fontenot     2020-11-12  669  
337aadff8e4567 Ashwin Chaugule     2015-10-02  670  /**
337aadff8e4567 Ashwin Chaugule     2015-10-02  671   * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
603fadf33604a2 Bjorn Helgaas       2019-03-25  672   * @pr: Ptr to acpi_processor containing this CPU's logical ID.
337aadff8e4567 Ashwin Chaugule     2015-10-02  673   *
337aadff8e4567 Ashwin Chaugule     2015-10-02  674   *	Return: 0 for success or negative value for err.
337aadff8e4567 Ashwin Chaugule     2015-10-02  675   */
e7e2a9d4606e2e Aaron Rainbolt      2024-06-17  676  int acpi_cppc_processor_probe(struct acpi_processor *pr, bool ignore_osc_cppc_bit)
337aadff8e4567 Ashwin Chaugule     2015-10-02 @677  {
337aadff8e4567 Ashwin Chaugule     2015-10-02  678  	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
337aadff8e4567 Ashwin Chaugule     2015-10-02  679  	union acpi_object *out_obj, *cpc_obj;
337aadff8e4567 Ashwin Chaugule     2015-10-02  680  	struct cpc_desc *cpc_ptr;
337aadff8e4567 Ashwin Chaugule     2015-10-02  681  	struct cpc_reg *gas_t;
158c998ea44ba3 Ashwin Chaugule     2016-08-16  682  	struct device *cpu_dev;
337aadff8e4567 Ashwin Chaugule     2015-10-02  683  	acpi_handle handle = pr->handle;
337aadff8e4567 Ashwin Chaugule     2015-10-02  684  	unsigned int num_ent, i, cpc_rev;
85b1407bf6d2f4 George Cherian      2017-10-11  685  	int pcc_subspace_id = -1;
337aadff8e4567 Ashwin Chaugule     2015-10-02  686  	acpi_status status;
f21a3509842294 Rafael J. Wysocki   2022-03-22  687  	int ret = -ENODATA;
337aadff8e4567 Ashwin Chaugule     2015-10-02  688  
7feec7430edddb Mario Limonciello   2022-07-05  689  	if (!osc_sb_cppc2_support_acked) {
7feec7430edddb Mario Limonciello   2022-07-05  690  		pr_debug("CPPC v2 _OSC not acked\n");
e7e2a9d4606e2e Aaron Rainbolt      2024-06-17  691  		if (!ignore_osc_cppc_bit && !cpc_supported_by_cpu()) {
5f8f9bc4d7bc8d Perry Yuan          2024-04-25  692  			pr_debug("CPPC is not supported by the CPU\n");
c42fa24b44751c Rafael J. Wysocki   2022-03-16  693  			return -ENODEV;
7feec7430edddb Mario Limonciello   2022-07-05  694  		}
5f8f9bc4d7bc8d Perry Yuan          2024-04-25  695  	}
c42fa24b44751c Rafael J. Wysocki   2022-03-16  696  
603fadf33604a2 Bjorn Helgaas       2019-03-25  697  	/* Parse the ACPI _CPC table for this CPU. */
337aadff8e4567 Ashwin Chaugule     2015-10-02  698  	status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
337aadff8e4567 Ashwin Chaugule     2015-10-02  699  			ACPI_TYPE_PACKAGE);
337aadff8e4567 Ashwin Chaugule     2015-10-02  700  	if (ACPI_FAILURE(status)) {
337aadff8e4567 Ashwin Chaugule     2015-10-02  701  		ret = -ENODEV;
337aadff8e4567 Ashwin Chaugule     2015-10-02  702  		goto out_buf_free;
337aadff8e4567 Ashwin Chaugule     2015-10-02  703  	}
337aadff8e4567 Ashwin Chaugule     2015-10-02  704  
337aadff8e4567 Ashwin Chaugule     2015-10-02  705  	out_obj = (union acpi_object *) output.pointer;
337aadff8e4567 Ashwin Chaugule     2015-10-02  706  
337aadff8e4567 Ashwin Chaugule     2015-10-02  707  	cpc_ptr = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
337aadff8e4567 Ashwin Chaugule     2015-10-02  708  	if (!cpc_ptr) {
337aadff8e4567 Ashwin Chaugule     2015-10-02  709  		ret = -ENOMEM;
337aadff8e4567 Ashwin Chaugule     2015-10-02  710  		goto out_buf_free;
337aadff8e4567 Ashwin Chaugule     2015-10-02  711  	}
337aadff8e4567 Ashwin Chaugule     2015-10-02  712  
337aadff8e4567 Ashwin Chaugule     2015-10-02  713  	/* First entry is NumEntries. */
337aadff8e4567 Ashwin Chaugule     2015-10-02  714  	cpc_obj = &out_obj->package.elements[0];
337aadff8e4567 Ashwin Chaugule     2015-10-02  715  	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
337aadff8e4567 Ashwin Chaugule     2015-10-02  716  		num_ent = cpc_obj->integer.value;
40d8abf364bcab Rafael J. Wysocki   2022-03-22  717  		if (num_ent <= 1) {
40d8abf364bcab Rafael J. Wysocki   2022-03-22  718  			pr_debug("Unexpected _CPC NumEntries value (%d) for CPU:%d\n",
40d8abf364bcab Rafael J. Wysocki   2022-03-22  719  				 num_ent, pr->id);
40d8abf364bcab Rafael J. Wysocki   2022-03-22  720  			goto out_free;
40d8abf364bcab Rafael J. Wysocki   2022-03-22  721  		}
337aadff8e4567 Ashwin Chaugule     2015-10-02  722  	} else {
f21a3509842294 Rafael J. Wysocki   2022-03-22  723  		pr_debug("Unexpected _CPC NumEntries entry type (%d) for CPU:%d\n",
f21a3509842294 Rafael J. Wysocki   2022-03-22  724  			 cpc_obj->type, pr->id);
337aadff8e4567 Ashwin Chaugule     2015-10-02  725  		goto out_free;
337aadff8e4567 Ashwin Chaugule     2015-10-02  726  	}
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  727  
337aadff8e4567 Ashwin Chaugule     2015-10-02  728  	/* Second entry should be revision. */
337aadff8e4567 Ashwin Chaugule     2015-10-02  729  	cpc_obj = &out_obj->package.elements[1];
337aadff8e4567 Ashwin Chaugule     2015-10-02  730  	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
337aadff8e4567 Ashwin Chaugule     2015-10-02  731  		cpc_rev = cpc_obj->integer.value;
337aadff8e4567 Ashwin Chaugule     2015-10-02  732  	} else {
f21a3509842294 Rafael J. Wysocki   2022-03-22  733  		pr_debug("Unexpected _CPC Revision entry type (%d) for CPU:%d\n",
f21a3509842294 Rafael J. Wysocki   2022-03-22  734  			 cpc_obj->type, pr->id);
337aadff8e4567 Ashwin Chaugule     2015-10-02  735  		goto out_free;
337aadff8e4567 Ashwin Chaugule     2015-10-02  736  	}
337aadff8e4567 Ashwin Chaugule     2015-10-02  737  
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  738  	if (cpc_rev < CPPC_V2_REV) {
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  739  		pr_debug("Unsupported _CPC Revision (%d) for CPU:%d\n", cpc_rev,
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  740  			 pr->id);
337aadff8e4567 Ashwin Chaugule     2015-10-02  741  		goto out_free;
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  742  	}
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  743  
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  744  	/*
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  745  	 * Disregard _CPC if the number of entries in the return pachage is not
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  746  	 * as expected, but support future revisions being proper supersets of
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  747  	 * the v3 and only causing more entries to be returned by _CPC.
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  748  	 */
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  749  	if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  750  	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  751  	    (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  752  		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  753  			 num_ent, pr->id);
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  754  		goto out_free;
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  755  	}
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  756  	if (cpc_rev > CPPC_V3_REV) {
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  757  		num_ent = CPPC_V3_NUM_ENT;
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  758  		cpc_rev = CPPC_V3_REV;
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  759  	}
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  760  
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  761  	cpc_ptr->num_entries = num_ent;
4f4179fcf42087 Rafael J. Wysocki   2022-07-21  762  	cpc_ptr->version = cpc_rev;
337aadff8e4567 Ashwin Chaugule     2015-10-02  763  
337aadff8e4567 Ashwin Chaugule     2015-10-02  764  	/* Iterate through remaining entries in _CPC */
337aadff8e4567 Ashwin Chaugule     2015-10-02  765  	for (i = 2; i < num_ent; i++) {
337aadff8e4567 Ashwin Chaugule     2015-10-02  766  		cpc_obj = &out_obj->package.elements[i];
337aadff8e4567 Ashwin Chaugule     2015-10-02  767  
337aadff8e4567 Ashwin Chaugule     2015-10-02  768  		if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
337aadff8e4567 Ashwin Chaugule     2015-10-02  769  			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
337aadff8e4567 Ashwin Chaugule     2015-10-02  770  			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = cpc_obj->integer.value;
337aadff8e4567 Ashwin Chaugule     2015-10-02  771  		} else if (cpc_obj->type == ACPI_TYPE_BUFFER) {
337aadff8e4567 Ashwin Chaugule     2015-10-02  772  			gas_t = (struct cpc_reg *)
337aadff8e4567 Ashwin Chaugule     2015-10-02  773  				cpc_obj->buffer.pointer;
337aadff8e4567 Ashwin Chaugule     2015-10-02  774  
337aadff8e4567 Ashwin Chaugule     2015-10-02  775  			/*
337aadff8e4567 Ashwin Chaugule     2015-10-02  776  			 * The PCC Subspace index is encoded inside
337aadff8e4567 Ashwin Chaugule     2015-10-02  777  			 * the CPC table entries. The same PCC index
337aadff8e4567 Ashwin Chaugule     2015-10-02  778  			 * will be used for all the PCC entries,
337aadff8e4567 Ashwin Chaugule     2015-10-02  779  			 * so extract it only once.
337aadff8e4567 Ashwin Chaugule     2015-10-02  780  			 */
337aadff8e4567 Ashwin Chaugule     2015-10-02  781  			if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
85b1407bf6d2f4 George Cherian      2017-10-11  782  				if (pcc_subspace_id < 0) {
85b1407bf6d2f4 George Cherian      2017-10-11  783  					pcc_subspace_id = gas_t->access_width;
85b1407bf6d2f4 George Cherian      2017-10-11  784  					if (pcc_data_alloc(pcc_subspace_id))
85b1407bf6d2f4 George Cherian      2017-10-11  785  						goto out_free;
85b1407bf6d2f4 George Cherian      2017-10-11  786  				} else if (pcc_subspace_id != gas_t->access_width) {
f21a3509842294 Rafael J. Wysocki   2022-03-22  787  					pr_debug("Mismatched PCC ids in _CPC for CPU:%d\n",
f21a3509842294 Rafael J. Wysocki   2022-03-22  788  						 pr->id);
337aadff8e4567 Ashwin Chaugule     2015-10-02  789  					goto out_free;
337aadff8e4567 Ashwin Chaugule     2015-10-02  790  				}
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  791  			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  792  				if (gas_t->address) {
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  793  					void __iomem *addr;
2f4a4d63a193be Jarred White        2024-03-01  794  					size_t access_width;
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  795  
0651ab90e4ade1 Pierre Gondois      2022-05-18  796  					if (!osc_cpc_flexible_adr_space_confirmed) {
0651ab90e4ade1 Pierre Gondois      2022-05-18  797  						pr_debug("Flexible address space capability not supported\n");
09073396ea62d0 Mario Limonciello   2022-07-15  798  						if (!cpc_supported_by_cpu())
0651ab90e4ade1 Pierre Gondois      2022-05-18  799  							goto out_free;
0651ab90e4ade1 Pierre Gondois      2022-05-18  800  					}
0651ab90e4ade1 Pierre Gondois      2022-05-18  801  
2f4a4d63a193be Jarred White        2024-03-01  802  					access_width = GET_BIT_WIDTH(gas_t) / 8;
2f4a4d63a193be Jarred White        2024-03-01  803  					addr = ioremap(gas_t->address, access_width);
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  804  					if (!addr)
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  805  						goto out_free;
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  806  					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  807  				}
a2c8f92bea5f8f Steven Noonan       2021-12-24  808  			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
a2c8f92bea5f8f Steven Noonan       2021-12-24  809  				if (gas_t->access_width < 1 || gas_t->access_width > 3) {
a2c8f92bea5f8f Steven Noonan       2021-12-24  810  					/*
a2c8f92bea5f8f Steven Noonan       2021-12-24  811  					 * 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit.
a2c8f92bea5f8f Steven Noonan       2021-12-24  812  					 * SystemIO doesn't implement 64-bit
a2c8f92bea5f8f Steven Noonan       2021-12-24  813  					 * registers.
a2c8f92bea5f8f Steven Noonan       2021-12-24  814  					 */
f21a3509842294 Rafael J. Wysocki   2022-03-22  815  					pr_debug("Invalid access width %d for SystemIO register in _CPC\n",
a2c8f92bea5f8f Steven Noonan       2021-12-24  816  						 gas_t->access_width);
a2c8f92bea5f8f Steven Noonan       2021-12-24  817  					goto out_free;
a2c8f92bea5f8f Steven Noonan       2021-12-24  818  				}
a2c8f92bea5f8f Steven Noonan       2021-12-24  819  				if (gas_t->address & OVER_16BTS_MASK) {
a2c8f92bea5f8f Steven Noonan       2021-12-24  820  					/* SystemIO registers use 16-bit integer addresses */
f21a3509842294 Rafael J. Wysocki   2022-03-22  821  					pr_debug("Invalid IO port %llu for SystemIO register in _CPC\n",
a2c8f92bea5f8f Steven Noonan       2021-12-24  822  						 gas_t->address);
a2c8f92bea5f8f Steven Noonan       2021-12-24  823  					goto out_free;
a2c8f92bea5f8f Steven Noonan       2021-12-24  824  				}
0651ab90e4ade1 Pierre Gondois      2022-05-18  825  				if (!osc_cpc_flexible_adr_space_confirmed) {
0651ab90e4ade1 Pierre Gondois      2022-05-18  826  					pr_debug("Flexible address space capability not supported\n");
09073396ea62d0 Mario Limonciello   2022-07-15  827  					if (!cpc_supported_by_cpu())
0651ab90e4ade1 Pierre Gondois      2022-05-18  828  						goto out_free;
0651ab90e4ade1 Pierre Gondois      2022-05-18  829  				}
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  830  			} else {
a6cbcdd5ab5f24 Srinivas Pandruvada 2016-09-01  831  				if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
a2c8f92bea5f8f Steven Noonan       2021-12-24  832  					/* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
f21a3509842294 Rafael J. Wysocki   2022-03-22  833  					pr_debug("Unsupported register type (%d) in _CPC\n",
f21a3509842294 Rafael J. Wysocki   2022-03-22  834  						 gas_t->space_id);
337aadff8e4567 Ashwin Chaugule     2015-10-02  835  					goto out_free;
337aadff8e4567 Ashwin Chaugule     2015-10-02  836  				}
a6cbcdd5ab5f24 Srinivas Pandruvada 2016-09-01  837  			}
337aadff8e4567 Ashwin Chaugule     2015-10-02  838  
337aadff8e4567 Ashwin Chaugule     2015-10-02  839  			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
337aadff8e4567 Ashwin Chaugule     2015-10-02  840  			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
337aadff8e4567 Ashwin Chaugule     2015-10-02  841  		} else {
f21a3509842294 Rafael J. Wysocki   2022-03-22  842  			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
f21a3509842294 Rafael J. Wysocki   2022-03-22  843  				 i, pr->id);
337aadff8e4567 Ashwin Chaugule     2015-10-02  844  			goto out_free;
337aadff8e4567 Ashwin Chaugule     2015-10-02  845  		}
337aadff8e4567 Ashwin Chaugule     2015-10-02  846  	}
85b1407bf6d2f4 George Cherian      2017-10-11  847  	per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
4773e77cdc9b3a Prashanth Prakash   2018-04-04  848  
4773e77cdc9b3a Prashanth Prakash   2018-04-04  849  	/*
4773e77cdc9b3a Prashanth Prakash   2018-04-04  850  	 * Initialize the remaining cpc_regs as unsupported.
4773e77cdc9b3a Prashanth Prakash   2018-04-04  851  	 * Example: In case FW exposes CPPC v2, the below loop will initialize
4773e77cdc9b3a Prashanth Prakash   2018-04-04  852  	 * LOWEST_FREQ and NOMINAL_FREQ regs as unsupported
4773e77cdc9b3a Prashanth Prakash   2018-04-04  853  	 */
4773e77cdc9b3a Prashanth Prakash   2018-04-04  854  	for (i = num_ent - 2; i < MAX_CPC_REG_ENT; i++) {
4773e77cdc9b3a Prashanth Prakash   2018-04-04  855  		cpc_ptr->cpc_regs[i].type = ACPI_TYPE_INTEGER;
4773e77cdc9b3a Prashanth Prakash   2018-04-04  856  		cpc_ptr->cpc_regs[i].cpc_entry.int_value = 0;
4773e77cdc9b3a Prashanth Prakash   2018-04-04  857  	}
4773e77cdc9b3a Prashanth Prakash   2018-04-04  858  
4773e77cdc9b3a Prashanth Prakash   2018-04-04  859  
337aadff8e4567 Ashwin Chaugule     2015-10-02  860  	/* Store CPU Logical ID */
337aadff8e4567 Ashwin Chaugule     2015-10-02  861  	cpc_ptr->cpu_id = pr->id;
337aadff8e4567 Ashwin Chaugule     2015-10-02  862  
337aadff8e4567 Ashwin Chaugule     2015-10-02  863  	/* Parse PSD data for this CPU */
337aadff8e4567 Ashwin Chaugule     2015-10-02  864  	ret = acpi_get_psd(cpc_ptr, handle);
337aadff8e4567 Ashwin Chaugule     2015-10-02  865  	if (ret)
337aadff8e4567 Ashwin Chaugule     2015-10-02  866  		goto out_free;
337aadff8e4567 Ashwin Chaugule     2015-10-02  867  
603fadf33604a2 Bjorn Helgaas       2019-03-25  868  	/* Register PCC channel once for all PCC subspace ID. */
85b1407bf6d2f4 George Cherian      2017-10-11  869  	if (pcc_subspace_id >= 0 && !pcc_data[pcc_subspace_id]->pcc_channel_acquired) {
85b1407bf6d2f4 George Cherian      2017-10-11  870  		ret = register_pcc_channel(pcc_subspace_id);
337aadff8e4567 Ashwin Chaugule     2015-10-02  871  		if (ret)
337aadff8e4567 Ashwin Chaugule     2015-10-02  872  			goto out_free;
8482ef8c6e684a Prakash, Prashanth  2016-08-16  873  
85b1407bf6d2f4 George Cherian      2017-10-11  874  		init_rwsem(&pcc_data[pcc_subspace_id]->pcc_lock);
85b1407bf6d2f4 George Cherian      2017-10-11  875  		init_waitqueue_head(&pcc_data[pcc_subspace_id]->pcc_write_wait_q);
337aadff8e4567 Ashwin Chaugule     2015-10-02  876  	}
337aadff8e4567 Ashwin Chaugule     2015-10-02  877  
337aadff8e4567 Ashwin Chaugule     2015-10-02  878  	/* Everything looks okay */
337aadff8e4567 Ashwin Chaugule     2015-10-02  879  	pr_debug("Parsed CPC struct for CPU: %d\n", pr->id);
337aadff8e4567 Ashwin Chaugule     2015-10-02  880  
158c998ea44ba3 Ashwin Chaugule     2016-08-16  881  	/* Add per logical CPU nodes for reading its feedback counters. */
158c998ea44ba3 Ashwin Chaugule     2016-08-16  882  	cpu_dev = get_cpu_device(pr->id);
501634759d55a5 Dan Carpenter       2016-11-30  883  	if (!cpu_dev) {
501634759d55a5 Dan Carpenter       2016-11-30  884  		ret = -EINVAL;
158c998ea44ba3 Ashwin Chaugule     2016-08-16  885  		goto out_free;
501634759d55a5 Dan Carpenter       2016-11-30  886  	}
158c998ea44ba3 Ashwin Chaugule     2016-08-16  887  
603fadf33604a2 Bjorn Helgaas       2019-03-25  888  	/* Plug PSD data into this CPU's CPC descriptor. */
28076483afac9d Rafael J. Wysocki   2016-12-10  889  	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
28076483afac9d Rafael J. Wysocki   2016-12-10  890  
158c998ea44ba3 Ashwin Chaugule     2016-08-16  891  	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
158c998ea44ba3 Ashwin Chaugule     2016-08-16  892  			"acpi_cppc");
28076483afac9d Rafael J. Wysocki   2016-12-10  893  	if (ret) {
28076483afac9d Rafael J. Wysocki   2016-12-10  894  		per_cpu(cpc_desc_ptr, pr->id) = NULL;
4d8be4bc94f74b Qiushi Wu           2020-05-27  895  		kobject_put(&cpc_ptr->kobj);
158c998ea44ba3 Ashwin Chaugule     2016-08-16  896  		goto out_free;
28076483afac9d Rafael J. Wysocki   2016-12-10  897  	}
158c998ea44ba3 Ashwin Chaugule     2016-08-16  898  
1132e6de11cfc3 Ionela Voinescu     2022-03-10  899  	arch_init_invariance_cppc();
41ea667227bad5 Nathan Fontenot     2020-11-12  900  
337aadff8e4567 Ashwin Chaugule     2015-10-02  901  	kfree(output.pointer);
337aadff8e4567 Ashwin Chaugule     2015-10-02  902  	return 0;
337aadff8e4567 Ashwin Chaugule     2015-10-02  903  
337aadff8e4567 Ashwin Chaugule     2015-10-02  904  out_free:
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  905  	/* Free all the mapped sys mem areas for this CPU */
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  906  	for (i = 2; i < cpc_ptr->num_entries; i++) {
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  907  		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  908  
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  909  		if (addr)
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  910  			iounmap(addr);
5bbb86aa4b8d84 Ashwin Chaugule     2016-08-16  911  	}
337aadff8e4567 Ashwin Chaugule     2015-10-02  912  	kfree(cpc_ptr);
337aadff8e4567 Ashwin Chaugule     2015-10-02  913  
337aadff8e4567 Ashwin Chaugule     2015-10-02  914  out_buf_free:
337aadff8e4567 Ashwin Chaugule     2015-10-02  915  	kfree(output.pointer);
337aadff8e4567 Ashwin Chaugule     2015-10-02  916  	return ret;
337aadff8e4567 Ashwin Chaugule     2015-10-02  917  }
337aadff8e4567 Ashwin Chaugule     2015-10-02  918  EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
337aadff8e4567 Ashwin Chaugule     2015-10-02  919  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

