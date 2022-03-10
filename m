Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C94D3FDD
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 04:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbiCJDus (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 22:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbiCJDun (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 22:50:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355EB6D946
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 19:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646884183; x=1678420183;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dTP1du+sA+bvpHlJgQDh7Lo7PieRTlOTT8kjcjeO5VE=;
  b=UmrxClUrauAUF/VJ5vzJzNFPw2jPjBbASSjUHvzku+bnbK27hbpL3/EF
   Fe9tGVq+xlRCqK5At8Rj9+GlMJWTcdWukwkTjbhghUQFNYftZ/5sJLkTb
   Yw0PTBjXu+poVPutx+2lIVzZjSEC+/gsTeTb/uqkH5sB2KGSehzZRhZun
   iLzAUdsxc7xCIalTNNlQIGdl9/XTbjdUymr+EOv/UdCJsDM8cOzLvuEGU
   XAE3hv3tSw71o8DMmcv8Q6TBm1kTgvooAdScfkRW84/KXrWXqipgesuHC
   cX3b9qIGEfKQLYtH6LiIDmy2V3MjdvECqC5Ywizoohfgz9Ge67ejxGFHF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="341581653"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="341581653"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="815427681"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:42 -0800
Subject: [PATCH 5/6] ACPI: NFIT: Remove block aperture support
From:   Dan Williams <dan.j.williams@intel.com>
To:     nvdimm@lists.linux.dev
Cc:     robert.hu@linux.intel.com, vishal.l.verma@intel.com, hch@lst.de,
        linux-acpi@vger.kernel.org
Date:   Wed, 09 Mar 2022 19:49:42 -0800
Message-ID: <164688418240.2879318.400185926874596938.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164688415599.2879318.17035042246954533659.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164688415599.2879318.17035042246954533659.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Delete the code to parse interleave-descriptor-tables and coordinate I/O
through a BLK aperture.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c         |  376 --------------------------------------
 drivers/acpi/nfit/nfit.h         |    6 -
 tools/testing/nvdimm/test/nfit.c |   23 --
 3 files changed, 405 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e5d7f2bda13f..bea6a219fddd 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -999,80 +999,6 @@ static void *add_table(struct acpi_nfit_desc *acpi_desc,
 	return table + hdr->length;
 }
 
-static void nfit_mem_find_spa_bdw(struct acpi_nfit_desc *acpi_desc,
-		struct nfit_mem *nfit_mem)
-{
-	u32 device_handle = __to_nfit_memdev(nfit_mem)->device_handle;
-	u16 dcr = nfit_mem->dcr->region_index;
-	struct nfit_spa *nfit_spa;
-
-	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
-		u16 range_index = nfit_spa->spa->range_index;
-		int type = nfit_spa_type(nfit_spa->spa);
-		struct nfit_memdev *nfit_memdev;
-
-		if (type != NFIT_SPA_BDW)
-			continue;
-
-		list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list) {
-			if (nfit_memdev->memdev->range_index != range_index)
-				continue;
-			if (nfit_memdev->memdev->device_handle != device_handle)
-				continue;
-			if (nfit_memdev->memdev->region_index != dcr)
-				continue;
-
-			nfit_mem->spa_bdw = nfit_spa->spa;
-			return;
-		}
-	}
-
-	dev_dbg(acpi_desc->dev, "SPA-BDW not found for SPA-DCR %d\n",
-			nfit_mem->spa_dcr->range_index);
-	nfit_mem->bdw = NULL;
-}
-
-static void nfit_mem_init_bdw(struct acpi_nfit_desc *acpi_desc,
-		struct nfit_mem *nfit_mem, struct acpi_nfit_system_address *spa)
-{
-	u16 dcr = __to_nfit_memdev(nfit_mem)->region_index;
-	struct nfit_memdev *nfit_memdev;
-	struct nfit_bdw *nfit_bdw;
-	struct nfit_idt *nfit_idt;
-	u16 idt_idx, range_index;
-
-	list_for_each_entry(nfit_bdw, &acpi_desc->bdws, list) {
-		if (nfit_bdw->bdw->region_index != dcr)
-			continue;
-		nfit_mem->bdw = nfit_bdw->bdw;
-		break;
-	}
-
-	if (!nfit_mem->bdw)
-		return;
-
-	nfit_mem_find_spa_bdw(acpi_desc, nfit_mem);
-
-	if (!nfit_mem->spa_bdw)
-		return;
-
-	range_index = nfit_mem->spa_bdw->range_index;
-	list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list) {
-		if (nfit_memdev->memdev->range_index != range_index ||
-				nfit_memdev->memdev->region_index != dcr)
-			continue;
-		nfit_mem->memdev_bdw = nfit_memdev->memdev;
-		idt_idx = nfit_memdev->memdev->interleave_index;
-		list_for_each_entry(nfit_idt, &acpi_desc->idts, list) {
-			if (nfit_idt->idt->interleave_index != idt_idx)
-				continue;
-			nfit_mem->idt_bdw = nfit_idt->idt;
-			break;
-		}
-		break;
-	}
-}
-
 static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 		struct acpi_nfit_system_address *spa)
 {
@@ -1189,7 +1115,6 @@ static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 				nfit_mem->idt_dcr = nfit_idt->idt;
 				break;
 			}
-			nfit_mem_init_bdw(acpi_desc, nfit_mem, spa);
 		} else if (type == NFIT_SPA_PM) {
 			/*
 			 * A single dimm may belong to multiple SPA-PM
@@ -1532,8 +1457,6 @@ static int num_nvdimm_formats(struct nvdimm *nvdimm)
 
 	if (nfit_mem->memdev_pmem)
 		formats++;
-	if (nfit_mem->memdev_bdw)
-		formats++;
 	return formats;
 }
 
@@ -2079,11 +2002,6 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 			continue;
 		}
 
-		if (nfit_mem->bdw && nfit_mem->memdev_pmem) {
-			set_bit(NDD_ALIASING, &flags);
-			set_bit(NDD_LABELING, &flags);
-		}
-
 		/* collate flags across all memdevs for this dimm */
 		list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list) {
 			struct acpi_nfit_memory_map *dimm_memdev;
@@ -2429,272 +2347,6 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 	return 0;
 }
 
-static u64 to_interleave_offset(u64 offset, struct nfit_blk_mmio *mmio)
-{
-	struct acpi_nfit_interleave *idt = mmio->idt;
-	u32 sub_line_offset, line_index, line_offset;
-	u64 line_no, table_skip_count, table_offset;
-
-	line_no = div_u64_rem(offset, mmio->line_size, &sub_line_offset);
-	table_skip_count = div_u64_rem(line_no, mmio->num_lines, &line_index);
-	line_offset = idt->line_offset[line_index]
-		* mmio->line_size;
-	table_offset = table_skip_count * mmio->table_size;
-
-	return mmio->base_offset + line_offset + table_offset + sub_line_offset;
-}
-
-static u32 read_blk_stat(struct nfit_blk *nfit_blk, unsigned int bw)
-{
-	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[DCR];
-	u64 offset = nfit_blk->stat_offset + mmio->size * bw;
-	const u32 STATUS_MASK = 0x80000037;
-
-	if (mmio->num_lines)
-		offset = to_interleave_offset(offset, mmio);
-
-	return readl(mmio->addr.base + offset) & STATUS_MASK;
-}
-
-static void write_blk_ctl(struct nfit_blk *nfit_blk, unsigned int bw,
-		resource_size_t dpa, unsigned int len, unsigned int write)
-{
-	u64 cmd, offset;
-	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[DCR];
-
-	enum {
-		BCW_OFFSET_MASK = (1ULL << 48)-1,
-		BCW_LEN_SHIFT = 48,
-		BCW_LEN_MASK = (1ULL << 8) - 1,
-		BCW_CMD_SHIFT = 56,
-	};
-
-	cmd = (dpa >> L1_CACHE_SHIFT) & BCW_OFFSET_MASK;
-	len = len >> L1_CACHE_SHIFT;
-	cmd |= ((u64) len & BCW_LEN_MASK) << BCW_LEN_SHIFT;
-	cmd |= ((u64) write) << BCW_CMD_SHIFT;
-
-	offset = nfit_blk->cmd_offset + mmio->size * bw;
-	if (mmio->num_lines)
-		offset = to_interleave_offset(offset, mmio);
-
-	writeq(cmd, mmio->addr.base + offset);
-	nvdimm_flush(nfit_blk->nd_region, NULL);
-
-	if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
-		readq(mmio->addr.base + offset);
-}
-
-static int acpi_nfit_blk_single_io(struct nfit_blk *nfit_blk,
-		resource_size_t dpa, void *iobuf, size_t len, int rw,
-		unsigned int lane)
-{
-	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[BDW];
-	unsigned int copied = 0;
-	u64 base_offset;
-	int rc;
-
-	base_offset = nfit_blk->bdw_offset + dpa % L1_CACHE_BYTES
-		+ lane * mmio->size;
-	write_blk_ctl(nfit_blk, lane, dpa, len, rw);
-	while (len) {
-		unsigned int c;
-		u64 offset;
-
-		if (mmio->num_lines) {
-			u32 line_offset;
-
-			offset = to_interleave_offset(base_offset + copied,
-					mmio);
-			div_u64_rem(offset, mmio->line_size, &line_offset);
-			c = min_t(size_t, len, mmio->line_size - line_offset);
-		} else {
-			offset = base_offset + nfit_blk->bdw_offset;
-			c = len;
-		}
-
-		if (rw)
-			memcpy_flushcache(mmio->addr.aperture + offset, iobuf + copied, c);
-		else {
-			if (nfit_blk->dimm_flags & NFIT_BLK_READ_FLUSH)
-				arch_invalidate_pmem((void __force *)
-					mmio->addr.aperture + offset, c);
-
-			memcpy(iobuf + copied, mmio->addr.aperture + offset, c);
-		}
-
-		copied += c;
-		len -= c;
-	}
-
-	if (rw)
-		nvdimm_flush(nfit_blk->nd_region, NULL);
-
-	rc = read_blk_stat(nfit_blk, lane) ? -EIO : 0;
-	return rc;
-}
-
-static int acpi_nfit_blk_region_do_io(struct nd_blk_region *ndbr,
-		resource_size_t dpa, void *iobuf, u64 len, int rw)
-{
-	struct nfit_blk *nfit_blk = nd_blk_region_provider_data(ndbr);
-	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[BDW];
-	struct nd_region *nd_region = nfit_blk->nd_region;
-	unsigned int lane, copied = 0;
-	int rc = 0;
-
-	lane = nd_region_acquire_lane(nd_region);
-	while (len) {
-		u64 c = min(len, mmio->size);
-
-		rc = acpi_nfit_blk_single_io(nfit_blk, dpa + copied,
-				iobuf + copied, c, rw, lane);
-		if (rc)
-			break;
-
-		copied += c;
-		len -= c;
-	}
-	nd_region_release_lane(nd_region, lane);
-
-	return rc;
-}
-
-static int nfit_blk_init_interleave(struct nfit_blk_mmio *mmio,
-		struct acpi_nfit_interleave *idt, u16 interleave_ways)
-{
-	if (idt) {
-		mmio->num_lines = idt->line_count;
-		mmio->line_size = idt->line_size;
-		if (interleave_ways == 0)
-			return -ENXIO;
-		mmio->table_size = mmio->num_lines * interleave_ways
-			* mmio->line_size;
-	}
-
-	return 0;
-}
-
-static int acpi_nfit_blk_get_flags(struct nvdimm_bus_descriptor *nd_desc,
-		struct nvdimm *nvdimm, struct nfit_blk *nfit_blk)
-{
-	struct nd_cmd_dimm_flags flags;
-	int rc;
-
-	memset(&flags, 0, sizeof(flags));
-	rc = nd_desc->ndctl(nd_desc, nvdimm, ND_CMD_DIMM_FLAGS, &flags,
-			sizeof(flags), NULL);
-
-	if (rc >= 0 && flags.status == 0)
-		nfit_blk->dimm_flags = flags.flags;
-	else if (rc == -ENOTTY) {
-		/* fall back to a conservative default */
-		nfit_blk->dimm_flags = NFIT_BLK_DCR_LATCH | NFIT_BLK_READ_FLUSH;
-		rc = 0;
-	} else
-		rc = -ENXIO;
-
-	return rc;
-}
-
-static int acpi_nfit_blk_region_enable(struct nvdimm_bus *nvdimm_bus,
-		struct device *dev)
-{
-	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
-	struct nd_blk_region *ndbr = to_nd_blk_region(dev);
-	struct nfit_blk_mmio *mmio;
-	struct nfit_blk *nfit_blk;
-	struct nfit_mem *nfit_mem;
-	struct nvdimm *nvdimm;
-	int rc;
-
-	nvdimm = nd_blk_region_to_dimm(ndbr);
-	nfit_mem = nvdimm_provider_data(nvdimm);
-	if (!nfit_mem || !nfit_mem->dcr || !nfit_mem->bdw) {
-		dev_dbg(dev, "missing%s%s%s\n",
-				nfit_mem ? "" : " nfit_mem",
-				(nfit_mem && nfit_mem->dcr) ? "" : " dcr",
-				(nfit_mem && nfit_mem->bdw) ? "" : " bdw");
-		return -ENXIO;
-	}
-
-	nfit_blk = devm_kzalloc(dev, sizeof(*nfit_blk), GFP_KERNEL);
-	if (!nfit_blk)
-		return -ENOMEM;
-	nd_blk_region_set_provider_data(ndbr, nfit_blk);
-	nfit_blk->nd_region = to_nd_region(dev);
-
-	/* map block aperture memory */
-	nfit_blk->bdw_offset = nfit_mem->bdw->offset;
-	mmio = &nfit_blk->mmio[BDW];
-	mmio->addr.base = devm_nvdimm_memremap(dev, nfit_mem->spa_bdw->address,
-			nfit_mem->spa_bdw->length, nd_blk_memremap_flags(ndbr));
-	if (!mmio->addr.base) {
-		dev_dbg(dev, "%s failed to map bdw\n",
-				nvdimm_name(nvdimm));
-		return -ENOMEM;
-	}
-	mmio->size = nfit_mem->bdw->size;
-	mmio->base_offset = nfit_mem->memdev_bdw->region_offset;
-	mmio->idt = nfit_mem->idt_bdw;
-	mmio->spa = nfit_mem->spa_bdw;
-	rc = nfit_blk_init_interleave(mmio, nfit_mem->idt_bdw,
-			nfit_mem->memdev_bdw->interleave_ways);
-	if (rc) {
-		dev_dbg(dev, "%s failed to init bdw interleave\n",
-				nvdimm_name(nvdimm));
-		return rc;
-	}
-
-	/* map block control memory */
-	nfit_blk->cmd_offset = nfit_mem->dcr->command_offset;
-	nfit_blk->stat_offset = nfit_mem->dcr->status_offset;
-	mmio = &nfit_blk->mmio[DCR];
-	mmio->addr.base = devm_nvdimm_ioremap(dev, nfit_mem->spa_dcr->address,
-			nfit_mem->spa_dcr->length);
-	if (!mmio->addr.base) {
-		dev_dbg(dev, "%s failed to map dcr\n",
-				nvdimm_name(nvdimm));
-		return -ENOMEM;
-	}
-	mmio->size = nfit_mem->dcr->window_size;
-	mmio->base_offset = nfit_mem->memdev_dcr->region_offset;
-	mmio->idt = nfit_mem->idt_dcr;
-	mmio->spa = nfit_mem->spa_dcr;
-	rc = nfit_blk_init_interleave(mmio, nfit_mem->idt_dcr,
-			nfit_mem->memdev_dcr->interleave_ways);
-	if (rc) {
-		dev_dbg(dev, "%s failed to init dcr interleave\n",
-				nvdimm_name(nvdimm));
-		return rc;
-	}
-
-	rc = acpi_nfit_blk_get_flags(nd_desc, nvdimm, nfit_blk);
-	if (rc < 0) {
-		dev_dbg(dev, "%s failed get DIMM flags\n",
-				nvdimm_name(nvdimm));
-		return rc;
-	}
-
-	if (nvdimm_has_flush(nfit_blk->nd_region) < 0)
-		dev_warn(dev, "unable to guarantee persistence of writes\n");
-
-	if (mmio->line_size == 0)
-		return 0;
-
-	if ((u32) nfit_blk->cmd_offset % mmio->line_size
-			+ 8 > mmio->line_size) {
-		dev_dbg(dev, "cmd_offset crosses interleave boundary\n");
-		return -ENXIO;
-	} else if ((u32) nfit_blk->stat_offset % mmio->line_size
-			+ 8 > mmio->line_size) {
-		dev_dbg(dev, "stat_offset crosses interleave boundary\n");
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int ars_get_cap(struct acpi_nfit_desc *acpi_desc,
 		struct nd_cmd_ars_cap *cmd, struct nfit_spa *nfit_spa)
 {
@@ -2911,9 +2563,6 @@ static int acpi_nfit_init_mapping(struct acpi_nfit_desc *acpi_desc,
 	struct nvdimm *nvdimm = acpi_nfit_dimm_by_handle(acpi_desc,
 			memdev->device_handle);
 	struct acpi_nfit_system_address *spa = nfit_spa->spa;
-	struct nd_blk_region_desc *ndbr_desc;
-	struct nfit_mem *nfit_mem;
-	int rc;
 
 	if (!nvdimm) {
 		dev_err(acpi_desc->dev, "spa%d dimm: %#x not found\n",
@@ -2928,30 +2577,6 @@ static int acpi_nfit_init_mapping(struct acpi_nfit_desc *acpi_desc,
 		mapping->start = memdev->address;
 		mapping->size = memdev->region_size;
 		break;
-	case NFIT_SPA_DCR:
-		nfit_mem = nvdimm_provider_data(nvdimm);
-		if (!nfit_mem || !nfit_mem->bdw) {
-			dev_dbg(acpi_desc->dev, "spa%d %s missing bdw\n",
-					spa->range_index, nvdimm_name(nvdimm));
-			break;
-		}
-
-		mapping->size = nfit_mem->bdw->capacity;
-		mapping->start = nfit_mem->bdw->start_address;
-		ndr_desc->num_lanes = nfit_mem->bdw->windows;
-		ndr_desc->mapping = mapping;
-		ndr_desc->num_mappings = 1;
-		ndbr_desc = to_blk_region_desc(ndr_desc);
-		ndbr_desc->enable = acpi_nfit_blk_region_enable;
-		ndbr_desc->do_io = acpi_desc->blk_do_io;
-		rc = acpi_nfit_init_interleave_set(acpi_desc, ndr_desc, spa);
-		if (rc)
-			return rc;
-		nfit_spa->nd_region = nvdimm_blk_region_create(acpi_desc->nvdimm_bus,
-				ndr_desc);
-		if (!nfit_spa->nd_region)
-			return -ENOMEM;
-		break;
 	}
 
 	return 0;
@@ -3635,7 +3260,6 @@ void acpi_nfit_desc_init(struct acpi_nfit_desc *acpi_desc, struct device *dev)
 
 	dev_set_drvdata(dev, acpi_desc);
 	acpi_desc->dev = dev;
-	acpi_desc->blk_do_io = acpi_nfit_blk_region_do_io;
 	nd_desc = &acpi_desc->nd_desc;
 	nd_desc->provider_name = "ACPI.NFIT";
 	nd_desc->module = THIS_MODULE;
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index c674f3df9be7..50882bdbeb96 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -208,13 +208,9 @@ struct nfit_mem {
 	struct nvdimm *nvdimm;
 	struct acpi_nfit_memory_map *memdev_dcr;
 	struct acpi_nfit_memory_map *memdev_pmem;
-	struct acpi_nfit_memory_map *memdev_bdw;
 	struct acpi_nfit_control_region *dcr;
-	struct acpi_nfit_data_region *bdw;
 	struct acpi_nfit_system_address *spa_dcr;
-	struct acpi_nfit_system_address *spa_bdw;
 	struct acpi_nfit_interleave *idt_dcr;
-	struct acpi_nfit_interleave *idt_bdw;
 	struct kernfs_node *flags_attr;
 	struct nfit_flush *nfit_flush;
 	struct list_head list;
@@ -266,8 +262,6 @@ struct acpi_nfit_desc {
 	unsigned long family_dsm_mask[NVDIMM_BUS_FAMILY_MAX + 1];
 	unsigned int platform_cap;
 	unsigned int scrub_tmo;
-	int (*blk_do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,
-			void *iobuf, u64 len, int rw);
 	enum nvdimm_fwa_state fwa_state;
 	enum nvdimm_fwa_capability fwa_cap;
 	int fwa_count;
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 0bc91ffee257..65dbdda3a054 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -2842,28 +2842,6 @@ static void nfit_test1_setup(struct nfit_test *t)
 	set_bit(ND_CMD_SET_CONFIG_DATA, &acpi_desc->dimm_cmd_force_en);
 }
 
-static int nfit_test_blk_do_io(struct nd_blk_region *ndbr, resource_size_t dpa,
-		void *iobuf, u64 len, int rw)
-{
-	struct nfit_blk *nfit_blk = ndbr->blk_provider_data;
-	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[BDW];
-	struct nd_region *nd_region = &ndbr->nd_region;
-	unsigned int lane;
-
-	lane = nd_region_acquire_lane(nd_region);
-	if (rw)
-		memcpy(mmio->addr.base + dpa, iobuf, len);
-	else {
-		memcpy(iobuf, mmio->addr.base + dpa, len);
-
-		/* give us some some coverage of the arch_invalidate_pmem() API */
-		arch_invalidate_pmem(mmio->addr.base + dpa, len);
-	}
-	nd_region_release_lane(nd_region, lane);
-
-	return 0;
-}
-
 static unsigned long nfit_ctl_handle;
 
 union acpi_object *result;
@@ -3219,7 +3197,6 @@ static int nfit_test_probe(struct platform_device *pdev)
 	nfit_test->setup(nfit_test);
 	acpi_desc = &nfit_test->acpi_desc;
 	acpi_nfit_desc_init(acpi_desc, &pdev->dev);
-	acpi_desc->blk_do_io = nfit_test_blk_do_io;
 	nd_desc = &acpi_desc->nd_desc;
 	nd_desc->provider_name = NULL;
 	nd_desc->module = THIS_MODULE;

