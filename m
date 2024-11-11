Return-Path: <linux-acpi+bounces-9490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94DC9C3E08
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Nov 2024 13:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392041F21124
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Nov 2024 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17819B3EE;
	Mon, 11 Nov 2024 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kvljj/vJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23419153820;
	Mon, 11 Nov 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327085; cv=none; b=mPtU3+Fm8uP1aCjaZsLkixTdCRg5A+OVrIrCRXjg9bdQ8c4XQMx0oLtFfTuwZvoakO5w8a5SpUakD97Jk/Z7EnKRUFAr2qqkRFYBhStX4CGXTGTawl8I9RzmKKbSvp2AksXNnYGC3chN5dJRAgLd651oHx6ruP7vD0Y0Cy9gSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327085; c=relaxed/simple;
	bh=mokoN7i4MtyCTJ1ZSeqy7ot3zOS2I0QWGTKkUaKf2e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF+kW+BD9ni0KnTRe8vX0qSHOWdu32SQuEPPAG58/tCZb5rE96eXr5/4pX6VHWTBSabnUY6qDdLD3K43F8j4bcDEXlq8AllX66LBGlw60pDnLRdgIW7UErutD982xHFl2VkITZosHtZ4bAvMDcT8ry9nfarloDqqQXBSu3pT8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kvljj/vJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731327084; x=1762863084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mokoN7i4MtyCTJ1ZSeqy7ot3zOS2I0QWGTKkUaKf2e4=;
  b=Kvljj/vJxVgtNBY3EtJZsSY9zLrKxcGvs0aN5wc2IL90wRKjwZeTzIgn
   WI90hPtvaIdGXMT4uQ1Gy9dYhtIZQOlKGP8m0AynUh/5VfySt1CRonOdg
   AJSgDiylvZPCrqw8nKcYYMGBEQRRpeJN/5B7x7IXk6GI4mW3M+KlQjqY7
   3CrSpqxv6BK23tn2mSv0mKZnldy3iNrv3YrCTwDG04LlM8ZNrubLKAF/J
   XyRaE4S19On3WazXZ1Dn82MqHLobSsJONgK1PPRqClCoE1CbtaGe633zP
   65KfN3zH7e2Le3QulUuY9MhBB+FMyIeyIQ/zA+zsI1lbfI94fsU7wWUpx
   g==;
X-CSE-ConnectionGUID: P8hj5Vj8Q465ZgXyCJNh0A==
X-CSE-MsgGUID: dREWD2obSgW3XwnZcyXghg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53691631"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53691631"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 04:11:23 -0800
X-CSE-ConnectionGUID: sDMJPiQhTkSZFiSw+QlW8g==
X-CSE-MsgGUID: NDGM1jyrTfCtQajaaVBARw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="110166510"
Received: from lkp-server01.sh.intel.com (HELO dc8184e5aea1) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2024 04:11:19 -0800
Received: from kbuild by dc8184e5aea1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tATGH-0000GP-0A;
	Mon, 11 Nov 2024 12:11:17 +0000
Date: Mon, 11 Nov 2024 20:11:16 +0800
From: kernel test robot <lkp@intel.com>
To: Suraj Sonawane <surajsonawane0215@gmail.com>, dan.j.williams@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
	rafael@kernel.org, lenb@kernel.org, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Subject: Re: [PATCH] acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl
Message-ID: <202411112001.OeKx45GR-lkp@intel.com>
References: <20241111080429.9861-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111080429.9861-1-surajsonawane0215@gmail.com>

Hi Suraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc7 next-20241111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suraj-Sonawane/acpi-nfit-vmalloc-out-of-bounds-Read-in-acpi_nfit_ctl/20241111-160546
base:   linus/master
patch link:    https://lore.kernel.org/r/20241111080429.9861-1-surajsonawane0215%40gmail.com
patch subject: [PATCH] acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241111/202411112001.OeKx45GR-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241111/202411112001.OeKx45GR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411112001.OeKx45GR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/nfit/core.c:6:
   In file included from include/linux/libnvdimm.h:14:
   In file included from include/linux/bio.h:10:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/acpi/nfit/core.c:458:7: warning: variable 'out_obj' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     458 |                 if (buf == NULL || buf_len < sizeof(struct nd_cmd_pkg)) {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/nfit/core.c:658:12: note: uninitialized use occurs here
     658 |         ACPI_FREE(out_obj);
         |                   ^~~~~~~
   include/acpi/actypes.h:350:55: note: expanded from macro 'ACPI_FREE'
     350 | #define ACPI_FREE(a)                    acpi_os_free (a)
         |                                                       ^
   drivers/acpi/nfit/core.c:458:3: note: remove the 'if' if its condition is always false
     458 |                 if (buf == NULL || buf_len < sizeof(struct nd_cmd_pkg)) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     459 |                         rc = -EINVAL;
         |                         ~~~~~~~~~~~~~
     460 |                         goto out;
         |                         ~~~~~~~~~
     461 |                 }
         |                 ~
>> drivers/acpi/nfit/core.c:458:7: warning: variable 'out_obj' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
     458 |                 if (buf == NULL || buf_len < sizeof(struct nd_cmd_pkg)) {
         |                     ^~~~~~~~~~~
   drivers/acpi/nfit/core.c:658:12: note: uninitialized use occurs here
     658 |         ACPI_FREE(out_obj);
         |                   ^~~~~~~
   include/acpi/actypes.h:350:55: note: expanded from macro 'ACPI_FREE'
     350 | #define ACPI_FREE(a)                    acpi_os_free (a)
         |                                                       ^
   drivers/acpi/nfit/core.c:458:7: note: remove the '||' if its condition is always false
     458 |                 if (buf == NULL || buf_len < sizeof(struct nd_cmd_pkg)) {
         |                     ^~~~~~~~~~~~~~
   drivers/acpi/nfit/core.c:442:44: note: initialize the variable 'out_obj' to silence this warning
     442 |         union acpi_object in_obj, in_buf, *out_obj;
         |                                                   ^
         |                                                    = NULL
   6 warnings generated.


vim +458 drivers/acpi/nfit/core.c

   436	
   437	int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
   438			unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
   439	{
   440		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
   441		struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
   442		union acpi_object in_obj, in_buf, *out_obj;
   443		const struct nd_cmd_desc *desc = NULL;
   444		struct device *dev = acpi_desc->dev;
   445		struct nd_cmd_pkg *call_pkg = NULL;
   446		const char *cmd_name, *dimm_name;
   447		unsigned long cmd_mask, dsm_mask;
   448		u32 offset, fw_status = 0;
   449		acpi_handle handle;
   450		const guid_t *guid;
   451		int func, rc, i;
   452		int family = 0;
   453	
   454		if (cmd_rc)
   455			*cmd_rc = -EINVAL;
   456	
   457		if (cmd == ND_CMD_CALL) {
 > 458			if (buf == NULL || buf_len < sizeof(struct nd_cmd_pkg)) {
   459				rc = -EINVAL;
   460				goto out;
   461			}
   462			call_pkg = (struct nd_cmd_pkg *)buf;
   463		}
   464		func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
   465		if (func < 0)
   466			return func;
   467	
   468		if (nvdimm) {
   469			struct acpi_device *adev = nfit_mem->adev;
   470	
   471			if (!adev)
   472				return -ENOTTY;
   473	
   474			dimm_name = nvdimm_name(nvdimm);
   475			cmd_name = nvdimm_cmd_name(cmd);
   476			cmd_mask = nvdimm_cmd_mask(nvdimm);
   477			dsm_mask = nfit_mem->dsm_mask;
   478			desc = nd_cmd_dimm_desc(cmd);
   479			guid = to_nfit_uuid(nfit_mem->family);
   480			handle = adev->handle;
   481		} else {
   482			struct acpi_device *adev = to_acpi_dev(acpi_desc);
   483	
   484			cmd_name = nvdimm_bus_cmd_name(cmd);
   485			cmd_mask = nd_desc->cmd_mask;
   486			if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
   487				family = call_pkg->nd_family;
   488				if (family > NVDIMM_BUS_FAMILY_MAX ||
   489				    !test_bit(family, &nd_desc->bus_family_mask))
   490					return -EINVAL;
   491				family = array_index_nospec(family,
   492							    NVDIMM_BUS_FAMILY_MAX + 1);
   493				dsm_mask = acpi_desc->family_dsm_mask[family];
   494				guid = to_nfit_bus_uuid(family);
   495			} else {
   496				dsm_mask = acpi_desc->bus_dsm_mask;
   497				guid = to_nfit_uuid(NFIT_DEV_BUS);
   498			}
   499			desc = nd_cmd_bus_desc(cmd);
   500			handle = adev->handle;
   501			dimm_name = "bus";
   502		}
   503	
   504		if (!desc || (cmd && (desc->out_num + desc->in_num == 0)))
   505			return -ENOTTY;
   506	
   507		/*
   508		 * Check for a valid command.  For ND_CMD_CALL, we also have to
   509		 * make sure that the DSM function is supported.
   510		 */
   511		if (cmd == ND_CMD_CALL &&
   512		    (func > NVDIMM_CMD_MAX || !test_bit(func, &dsm_mask)))
   513			return -ENOTTY;
   514		else if (!test_bit(cmd, &cmd_mask))
   515			return -ENOTTY;
   516	
   517		in_obj.type = ACPI_TYPE_PACKAGE;
   518		in_obj.package.count = 1;
   519		in_obj.package.elements = &in_buf;
   520		in_buf.type = ACPI_TYPE_BUFFER;
   521		in_buf.buffer.pointer = buf;
   522		in_buf.buffer.length = 0;
   523	
   524		/* libnvdimm has already validated the input envelope */
   525		for (i = 0; i < desc->in_num; i++)
   526			in_buf.buffer.length += nd_cmd_in_size(nvdimm, cmd, desc,
   527					i, buf);
   528	
   529		if (call_pkg) {
   530			/* skip over package wrapper */
   531			in_buf.buffer.pointer = (void *) &call_pkg->nd_payload;
   532			in_buf.buffer.length = call_pkg->nd_size_in;
   533		}
   534	
   535		dev_dbg(dev, "%s cmd: %d: family: %d func: %d input length: %d\n",
   536			dimm_name, cmd, family, func, in_buf.buffer.length);
   537		if (payload_dumpable(nvdimm, func))
   538			print_hex_dump_debug("nvdimm in  ", DUMP_PREFIX_OFFSET, 4, 4,
   539					in_buf.buffer.pointer,
   540					min_t(u32, 256, in_buf.buffer.length), true);
   541	
   542		/* call the BIOS, prefer the named methods over _DSM if available */
   543		if (nvdimm && cmd == ND_CMD_GET_CONFIG_SIZE
   544				&& test_bit(NFIT_MEM_LSR, &nfit_mem->flags))
   545			out_obj = acpi_label_info(handle);
   546		else if (nvdimm && cmd == ND_CMD_GET_CONFIG_DATA
   547				&& test_bit(NFIT_MEM_LSR, &nfit_mem->flags)) {
   548			struct nd_cmd_get_config_data_hdr *p = buf;
   549	
   550			out_obj = acpi_label_read(handle, p->in_offset, p->in_length);
   551		} else if (nvdimm && cmd == ND_CMD_SET_CONFIG_DATA
   552				&& test_bit(NFIT_MEM_LSW, &nfit_mem->flags)) {
   553			struct nd_cmd_set_config_hdr *p = buf;
   554	
   555			out_obj = acpi_label_write(handle, p->in_offset, p->in_length,
   556					p->in_buf);
   557		} else {
   558			u8 revid;
   559	
   560			if (nvdimm)
   561				revid = nfit_dsm_revid(nfit_mem->family, func);
   562			else
   563				revid = 1;
   564			out_obj = acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
   565		}
   566	
   567		if (!out_obj) {
   568			dev_dbg(dev, "%s _DSM failed cmd: %s\n", dimm_name, cmd_name);
   569			return -EINVAL;
   570		}
   571	
   572		if (out_obj->type != ACPI_TYPE_BUFFER) {
   573			dev_dbg(dev, "%s unexpected output object type cmd: %s type: %d\n",
   574					dimm_name, cmd_name, out_obj->type);
   575			rc = -EINVAL;
   576			goto out;
   577		}
   578	
   579		dev_dbg(dev, "%s cmd: %s output length: %d\n", dimm_name,
   580				cmd_name, out_obj->buffer.length);
   581		print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
   582				out_obj->buffer.pointer,
   583				min_t(u32, 128, out_obj->buffer.length), true);
   584	
   585		if (call_pkg) {
   586			call_pkg->nd_fw_size = out_obj->buffer.length;
   587			memcpy(call_pkg->nd_payload + call_pkg->nd_size_in,
   588				out_obj->buffer.pointer,
   589				min(call_pkg->nd_fw_size, call_pkg->nd_size_out));
   590	
   591			ACPI_FREE(out_obj);
   592			/*
   593			 * Need to support FW function w/o known size in advance.
   594			 * Caller can determine required size based upon nd_fw_size.
   595			 * If we return an error (like elsewhere) then caller wouldn't
   596			 * be able to rely upon data returned to make calculation.
   597			 */
   598			if (cmd_rc)
   599				*cmd_rc = 0;
   600			return 0;
   601		}
   602	
   603		for (i = 0, offset = 0; i < desc->out_num; i++) {
   604			u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i, buf,
   605					(u32 *) out_obj->buffer.pointer,
   606					out_obj->buffer.length - offset);
   607	
   608			if (offset + out_size > out_obj->buffer.length) {
   609				dev_dbg(dev, "%s output object underflow cmd: %s field: %d\n",
   610						dimm_name, cmd_name, i);
   611				break;
   612			}
   613	
   614			if (in_buf.buffer.length + offset + out_size > buf_len) {
   615				dev_dbg(dev, "%s output overrun cmd: %s field: %d\n",
   616						dimm_name, cmd_name, i);
   617				rc = -ENXIO;
   618				goto out;
   619			}
   620			memcpy(buf + in_buf.buffer.length + offset,
   621					out_obj->buffer.pointer + offset, out_size);
   622			offset += out_size;
   623		}
   624	
   625		/*
   626		 * Set fw_status for all the commands with a known format to be
   627		 * later interpreted by xlat_status().
   628		 */
   629		if (i >= 1 && ((!nvdimm && cmd >= ND_CMD_ARS_CAP
   630						&& cmd <= ND_CMD_CLEAR_ERROR)
   631					|| (nvdimm && cmd >= ND_CMD_SMART
   632						&& cmd <= ND_CMD_VENDOR)))
   633			fw_status = *(u32 *) out_obj->buffer.pointer;
   634	
   635		if (offset + in_buf.buffer.length < buf_len) {
   636			if (i >= 1) {
   637				/*
   638				 * status valid, return the number of bytes left
   639				 * unfilled in the output buffer
   640				 */
   641				rc = buf_len - offset - in_buf.buffer.length;
   642				if (cmd_rc)
   643					*cmd_rc = xlat_status(nvdimm, buf, cmd,
   644							fw_status);
   645			} else {
   646				dev_err(dev, "%s:%s underrun cmd: %s buf_len: %d out_len: %d\n",
   647						__func__, dimm_name, cmd_name, buf_len,
   648						offset);
   649				rc = -ENXIO;
   650			}
   651		} else {
   652			rc = 0;
   653			if (cmd_rc)
   654				*cmd_rc = xlat_status(nvdimm, buf, cmd, fw_status);
   655		}
   656	
   657	 out:
   658		ACPI_FREE(out_obj);
   659	
   660		return rc;
   661	}
   662	EXPORT_SYMBOL_GPL(acpi_nfit_ctl);
   663	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

