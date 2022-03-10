Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27264D3FDB
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 04:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiCJDum (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 22:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239314AbiCJDuj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 22:50:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D16D946
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 19:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646884178; x=1678420178;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZ9lzUpSH27ZVhCVy0PyyU7vHjtstmYXSpeiy1bu42s=;
  b=U5v/U3aQhiu54pCz2j2ebYHM+BhgTE6bbZ5gLc4m+0NLHJA8nnTqeqj4
   Si6UgboosBVSDd+hbzVejbNon3TfRBZCGBBnlA4eDsh6BI8Lnv3Vb0DFO
   Bggn2kLM1jcjIlnS040tbIxS5ha6tyZ+385MW6g2dROfMU5W39QkwD0qQ
   l0h5OkOzkpG+euN0Flw1Tyod2eUoXOCmp7ziIoFnGvh06HBZInfwv0AL9
   hQqKCMvKfjIVazAk5iIGSEGWtFBYm8aZ3sbl4YA9qOYliBMZUccW+NgAR
   8ANLscbFDPzt1JNFmLvxVrxsAo/PFoCzFkisAYgOyumih5t/bYnnT+4DC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255096946"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="255096946"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="712208698"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:37 -0800
Subject: [PATCH 4/6] nvdimm/namespace: Delete nd_namespace_blk
From:   Dan Williams <dan.j.williams@intel.com>
To:     nvdimm@lists.linux.dev
Cc:     robert.hu@linux.intel.com, vishal.l.verma@intel.com, hch@lst.de,
        linux-acpi@vger.kernel.org
Date:   Wed, 09 Mar 2022 19:49:37 -0800
Message-ID: <164688417727.2879318.11691110761800109662.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Now that none of the configuration paths consider BLK namespaces, delete
the BLK namespace data and supporting code.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.c          |  340 ---------------------------------------
 drivers/nvdimm/label.h          |    3 
 drivers/nvdimm/namespace_devs.c |  227 +-------------------------
 drivers/nvdimm/nd-core.h        |    3 
 drivers/nvdimm/nd.h             |    1 
 include/linux/nd.h              |   26 ---
 6 files changed, 13 insertions(+), 587 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 5ec9a4023df9..8c972bcb2ac3 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -968,326 +968,6 @@ static int __pmem_label_update(struct nd_region *nd_region,
 	return rc;
 }
 
-static bool is_old_resource(struct resource *res, struct resource **list, int n)
-{
-	int i;
-
-	if (res->flags & DPA_RESOURCE_ADJUSTED)
-		return false;
-	for (i = 0; i < n; i++)
-		if (res == list[i])
-			return true;
-	return false;
-}
-
-static struct resource *to_resource(struct nvdimm_drvdata *ndd,
-		struct nd_namespace_label *nd_label)
-{
-	struct resource *res;
-
-	for_each_dpa_resource(ndd, res) {
-		if (res->start != nsl_get_dpa(ndd, nd_label))
-			continue;
-		if (resource_size(res) != nsl_get_rawsize(ndd, nd_label))
-			continue;
-		return res;
-	}
-
-	return NULL;
-}
-
-/*
- * Use the presence of the type_guid as a flag to determine isetcookie
- * usage and nlabel + position policy for blk-aperture namespaces.
- */
-static void nsl_set_blk_isetcookie(struct nvdimm_drvdata *ndd,
-				   struct nd_namespace_label *nd_label,
-				   u64 isetcookie)
-{
-	if (efi_namespace_label_has(ndd, type_guid)) {
-		nsl_set_isetcookie(ndd, nd_label, isetcookie);
-		return;
-	}
-	nsl_set_isetcookie(ndd, nd_label, 0); /* N/A */
-}
-
-bool nsl_validate_blk_isetcookie(struct nvdimm_drvdata *ndd,
-				 struct nd_namespace_label *nd_label,
-				 u64 isetcookie)
-{
-	if (!efi_namespace_label_has(ndd, type_guid))
-		return true;
-
-	if (nsl_get_isetcookie(ndd, nd_label) != isetcookie) {
-		dev_dbg(ndd->dev, "expect cookie %#llx got %#llx\n", isetcookie,
-			nsl_get_isetcookie(ndd, nd_label));
-		return false;
-	}
-
-	return true;
-}
-
-static void nsl_set_blk_nlabel(struct nvdimm_drvdata *ndd,
-			       struct nd_namespace_label *nd_label, int nlabel,
-			       bool first)
-{
-	if (!efi_namespace_label_has(ndd, type_guid)) {
-		nsl_set_nlabel(ndd, nd_label, 0); /* N/A */
-		return;
-	}
-	nsl_set_nlabel(ndd, nd_label, first ? nlabel : 0xffff);
-}
-
-static void nsl_set_blk_position(struct nvdimm_drvdata *ndd,
-				 struct nd_namespace_label *nd_label,
-				 bool first)
-{
-	if (!efi_namespace_label_has(ndd, type_guid)) {
-		nsl_set_position(ndd, nd_label, 0);
-		return;
-	}
-	nsl_set_position(ndd, nd_label, first ? 0 : 0xffff);
-}
-
-/*
- * 1/ Account all the labels that can be freed after this update
- * 2/ Allocate and write the label to the staging (next) index
- * 3/ Record the resources in the namespace device
- */
-static int __blk_label_update(struct nd_region *nd_region,
-		struct nd_mapping *nd_mapping, struct nd_namespace_blk *nsblk,
-		int num_labels)
-{
-	int i, alloc, victims, nfree, old_num_resources, nlabel, rc = -ENXIO;
-	struct nd_interleave_set *nd_set = nd_region->nd_set;
-	struct nd_namespace_common *ndns = &nsblk->common;
-	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
-	struct nd_namespace_label *nd_label;
-	struct nd_label_ent *label_ent, *e;
-	struct nd_namespace_index *nsindex;
-	unsigned long *free, *victim_map = NULL;
-	struct resource *res, **old_res_list;
-	struct nd_label_id label_id;
-	int min_dpa_idx = 0;
-	LIST_HEAD(list);
-	u32 nslot, slot;
-
-	if (!preamble_next(ndd, &nsindex, &free, &nslot))
-		return -ENXIO;
-
-	old_res_list = nsblk->res;
-	nfree = nd_label_nfree(ndd);
-	old_num_resources = nsblk->num_resources;
-	nd_label_gen_id(&label_id, nsblk->uuid, NSLABEL_FLAG_LOCAL);
-
-	/*
-	 * We need to loop over the old resources a few times, which seems a
-	 * bit inefficient, but we need to know that we have the label
-	 * space before we start mutating the tracking structures.
-	 * Otherwise the recovery method of last resort for userspace is
-	 * disable and re-enable the parent region.
-	 */
-	alloc = 0;
-	for_each_dpa_resource(ndd, res) {
-		if (strcmp(res->name, label_id.id) != 0)
-			continue;
-		if (!is_old_resource(res, old_res_list, old_num_resources))
-			alloc++;
-	}
-
-	victims = 0;
-	if (old_num_resources) {
-		/* convert old local-label-map to dimm-slot victim-map */
-		victim_map = bitmap_zalloc(nslot, GFP_KERNEL);
-		if (!victim_map)
-			return -ENOMEM;
-
-		/* mark unused labels for garbage collection */
-		for_each_clear_bit_le(slot, free, nslot) {
-			nd_label = to_label(ndd, slot);
-			if (!nsl_uuid_equal(ndd, nd_label, nsblk->uuid))
-				continue;
-			res = to_resource(ndd, nd_label);
-			if (res && is_old_resource(res, old_res_list,
-						old_num_resources))
-				continue;
-			slot = to_slot(ndd, nd_label);
-			set_bit(slot, victim_map);
-			victims++;
-		}
-	}
-
-	/* don't allow updates that consume the last label */
-	if (nfree - alloc < 0 || nfree - alloc + victims < 1) {
-		dev_info(&nsblk->common.dev, "insufficient label space\n");
-		bitmap_free(victim_map);
-		return -ENOSPC;
-	}
-	/* from here on we need to abort on error */
-
-
-	/* assign all resources to the namespace before writing the labels */
-	nsblk->res = NULL;
-	nsblk->num_resources = 0;
-	for_each_dpa_resource(ndd, res) {
-		if (strcmp(res->name, label_id.id) != 0)
-			continue;
-		if (!nsblk_add_resource(nd_region, ndd, nsblk, res->start)) {
-			rc = -ENOMEM;
-			goto abort;
-		}
-	}
-
-	/* release slots associated with any invalidated UUIDs */
-	mutex_lock(&nd_mapping->lock);
-	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list)
-		if (test_and_clear_bit(ND_LABEL_REAP, &label_ent->flags)) {
-			reap_victim(nd_mapping, label_ent);
-			list_move(&label_ent->list, &list);
-		}
-	mutex_unlock(&nd_mapping->lock);
-
-	/*
-	 * Find the resource associated with the first label in the set
-	 * per the v1.2 namespace specification.
-	 */
-	for (i = 0; i < nsblk->num_resources; i++) {
-		struct resource *min = nsblk->res[min_dpa_idx];
-
-		res = nsblk->res[i];
-		if (res->start < min->start)
-			min_dpa_idx = i;
-	}
-
-	for (i = 0; i < nsblk->num_resources; i++) {
-		size_t offset;
-
-		res = nsblk->res[i];
-		if (is_old_resource(res, old_res_list, old_num_resources))
-			continue; /* carry-over */
-		slot = nd_label_alloc_slot(ndd);
-		if (slot == UINT_MAX) {
-			rc = -ENXIO;
-			goto abort;
-		}
-		dev_dbg(ndd->dev, "allocated: %d\n", slot);
-
-		nd_label = to_label(ndd, slot);
-		memset(nd_label, 0, sizeof_namespace_label(ndd));
-		nsl_set_uuid(ndd, nd_label, nsblk->uuid);
-		nsl_set_name(ndd, nd_label, nsblk->alt_name);
-		nsl_set_flags(ndd, nd_label, NSLABEL_FLAG_LOCAL);
-
-		nsl_set_blk_nlabel(ndd, nd_label, nsblk->num_resources,
-				   i == min_dpa_idx);
-		nsl_set_blk_position(ndd, nd_label, i == min_dpa_idx);
-		nsl_set_blk_isetcookie(ndd, nd_label, nd_set->cookie2);
-
-		nsl_set_dpa(ndd, nd_label, res->start);
-		nsl_set_rawsize(ndd, nd_label, resource_size(res));
-		nsl_set_lbasize(ndd, nd_label, nsblk->lbasize);
-		nsl_set_slot(ndd, nd_label, slot);
-		nsl_set_type_guid(ndd, nd_label, &nd_set->type_guid);
-		nsl_set_claim_class(ndd, nd_label, ndns->claim_class);
-		nsl_calculate_checksum(ndd, nd_label);
-
-		/* update label */
-		offset = nd_label_offset(ndd, nd_label);
-		rc = nvdimm_set_config_data(ndd, offset, nd_label,
-				sizeof_namespace_label(ndd));
-		if (rc < 0)
-			goto abort;
-	}
-
-	/* free up now unused slots in the new index */
-	for_each_set_bit(slot, victim_map, victim_map ? nslot : 0) {
-		dev_dbg(ndd->dev, "free: %d\n", slot);
-		nd_label_free_slot(ndd, slot);
-	}
-
-	/* update index */
-	rc = nd_label_write_index(ndd, ndd->ns_next,
-			nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
-	if (rc)
-		goto abort;
-
-	/*
-	 * Now that the on-dimm labels are up to date, fix up the tracking
-	 * entries in nd_mapping->labels
-	 */
-	nlabel = 0;
-	mutex_lock(&nd_mapping->lock);
-	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
-		nd_label = label_ent->label;
-		if (!nd_label)
-			continue;
-		nlabel++;
-		if (!nsl_uuid_equal(ndd, nd_label, nsblk->uuid))
-			continue;
-		nlabel--;
-		list_move(&label_ent->list, &list);
-		label_ent->label = NULL;
-	}
-	list_splice_tail_init(&list, &nd_mapping->labels);
-	mutex_unlock(&nd_mapping->lock);
-
-	if (nlabel + nsblk->num_resources > num_labels) {
-		/*
-		 * Bug, we can't end up with more resources than
-		 * available labels
-		 */
-		WARN_ON_ONCE(1);
-		rc = -ENXIO;
-		goto out;
-	}
-
-	mutex_lock(&nd_mapping->lock);
-	label_ent = list_first_entry_or_null(&nd_mapping->labels,
-			typeof(*label_ent), list);
-	if (!label_ent) {
-		WARN_ON(1);
-		mutex_unlock(&nd_mapping->lock);
-		rc = -ENXIO;
-		goto out;
-	}
-	for_each_clear_bit_le(slot, free, nslot) {
-		nd_label = to_label(ndd, slot);
-		if (!nsl_uuid_equal(ndd, nd_label, nsblk->uuid))
-			continue;
-		res = to_resource(ndd, nd_label);
-		res->flags &= ~DPA_RESOURCE_ADJUSTED;
-		dev_vdbg(&nsblk->common.dev, "assign label slot: %d\n", slot);
-		list_for_each_entry_from(label_ent, &nd_mapping->labels, list) {
-			if (label_ent->label)
-				continue;
-			label_ent->label = nd_label;
-			nd_label = NULL;
-			break;
-		}
-		if (nd_label)
-			dev_WARN(&nsblk->common.dev,
-					"failed to track label slot%d\n", slot);
-	}
-	mutex_unlock(&nd_mapping->lock);
-
- out:
-	kfree(old_res_list);
-	bitmap_free(victim_map);
-	return rc;
-
- abort:
-	/*
-	 * 1/ repair the allocated label bitmap in the index
-	 * 2/ restore the resource list
-	 */
-	nd_label_copy(ndd, nsindex, to_current_namespace_index(ndd));
-	kfree(nsblk->res);
-	nsblk->res = old_res_list;
-	nsblk->num_resources = old_num_resources;
-	old_res_list = NULL;
-	goto out;
-}
-
 static int init_labels(struct nd_mapping *nd_mapping, int num_labels)
 {
 	int i, old_num_labels = 0;
@@ -1425,26 +1105,6 @@ int nd_pmem_namespace_label_update(struct nd_region *nd_region,
 	return 0;
 }
 
-int nd_blk_namespace_label_update(struct nd_region *nd_region,
-		struct nd_namespace_blk *nsblk, resource_size_t size)
-{
-	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
-	struct resource *res;
-	int count = 0;
-
-	if (size == 0)
-		return del_labels(nd_mapping, nsblk->uuid);
-
-	for_each_dpa_resource(to_ndd(nd_mapping), res)
-		count++;
-
-	count = init_labels(nd_mapping, count);
-	if (count < 0)
-		return count;
-
-	return __blk_label_update(nd_region, nd_mapping, nsblk, count);
-}
-
 int __init nd_label_init(void)
 {
 	WARN_ON(guid_parse(NVDIMM_BTT_GUID, &nvdimm_btt_guid));
diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index 8ee248fc214f..198ef1df298b 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -221,9 +221,6 @@ bool nd_label_free_slot(struct nvdimm_drvdata *ndd, u32 slot);
 u32 nd_label_nfree(struct nvdimm_drvdata *ndd);
 struct nd_region;
 struct nd_namespace_pmem;
-struct nd_namespace_blk;
 int nd_pmem_namespace_label_update(struct nd_region *nd_region,
 		struct nd_namespace_pmem *nspm, resource_size_t size);
-int nd_blk_namespace_label_update(struct nd_region *nd_region,
-		struct nd_namespace_blk *nsblk, resource_size_t size);
 #endif /* __LABEL_H__ */
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 5c76547c9b84..d1c190b02657 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -32,19 +32,6 @@ static void namespace_pmem_release(struct device *dev)
 	kfree(nspm);
 }
 
-static void namespace_blk_release(struct device *dev)
-{
-	struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
-	struct nd_region *nd_region = to_nd_region(dev->parent);
-
-	if (nsblk->id >= 0)
-		ida_simple_remove(&nd_region->ns_ida, nsblk->id);
-	kfree(nsblk->alt_name);
-	kfree(nsblk->uuid);
-	kfree(nsblk->res);
-	kfree(nsblk);
-}
-
 static bool is_namespace_pmem(const struct device *dev);
 static bool is_namespace_io(const struct device *dev);
 
@@ -245,65 +232,6 @@ static ssize_t __alt_name_store(struct device *dev, const char *buf,
 	return rc;
 }
 
-static bool __nd_namespace_blk_validate(struct nd_namespace_blk *nsblk)
-{
-	struct nd_region *nd_region = to_nd_region(nsblk->common.dev.parent);
-	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
-	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
-	struct nd_label_id label_id;
-	struct resource *res;
-	int count, i;
-
-	if (!nsblk->uuid || !nsblk->lbasize || !ndd)
-		return false;
-
-	count = 0;
-	nd_label_gen_id(&label_id, nsblk->uuid, NSLABEL_FLAG_LOCAL);
-	for_each_dpa_resource(ndd, res) {
-		if (strcmp(res->name, label_id.id) != 0)
-			continue;
-		/*
-		 * Resources with unacknowledged adjustments indicate a
-		 * failure to update labels
-		 */
-		if (res->flags & DPA_RESOURCE_ADJUSTED)
-			return false;
-		count++;
-	}
-
-	/* These values match after a successful label update */
-	if (count != nsblk->num_resources)
-		return false;
-
-	for (i = 0; i < nsblk->num_resources; i++) {
-		struct resource *found = NULL;
-
-		for_each_dpa_resource(ndd, res)
-			if (res == nsblk->res[i]) {
-				found = res;
-				break;
-			}
-		/* stale resource */
-		if (!found)
-			return false;
-	}
-
-	return true;
-}
-
-resource_size_t nd_namespace_blk_validate(struct nd_namespace_blk *nsblk)
-{
-	resource_size_t size;
-
-	nvdimm_bus_lock(&nsblk->common.dev);
-	size = __nd_namespace_blk_validate(nsblk);
-	nvdimm_bus_unlock(&nsblk->common.dev);
-
-	return size;
-}
-EXPORT_SYMBOL(nd_namespace_blk_validate);
-
-
 static int nd_namespace_label_update(struct nd_region *nd_region,
 		struct device *dev)
 {
@@ -1579,12 +1507,6 @@ static const struct device_type namespace_pmem_device_type = {
 	.groups = nd_namespace_attribute_groups,
 };
 
-static const struct device_type namespace_blk_device_type = {
-	.name = "nd_namespace_blk",
-	.release = namespace_blk_release,
-	.groups = nd_namespace_attribute_groups,
-};
-
 static bool is_namespace_pmem(const struct device *dev)
 {
 	return dev ? dev->type == &namespace_pmem_device_type : false;
@@ -1964,54 +1886,6 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 	return ERR_PTR(rc);
 }
 
-struct resource *nsblk_add_resource(struct nd_region *nd_region,
-		struct nvdimm_drvdata *ndd, struct nd_namespace_blk *nsblk,
-		resource_size_t start)
-{
-	struct nd_label_id label_id;
-	struct resource *res;
-
-	nd_label_gen_id(&label_id, nsblk->uuid, NSLABEL_FLAG_LOCAL);
-	res = krealloc(nsblk->res,
-			sizeof(void *) * (nsblk->num_resources + 1),
-			GFP_KERNEL);
-	if (!res)
-		return NULL;
-	nsblk->res = (struct resource **) res;
-	for_each_dpa_resource(ndd, res)
-		if (strcmp(res->name, label_id.id) == 0
-				&& res->start == start) {
-			nsblk->res[nsblk->num_resources++] = res;
-			return res;
-		}
-	return NULL;
-}
-
-static struct device *nd_namespace_blk_create(struct nd_region *nd_region)
-{
-	struct nd_namespace_blk *nsblk;
-	struct device *dev;
-
-	if (!is_nd_blk(&nd_region->dev))
-		return NULL;
-
-	nsblk = kzalloc(sizeof(*nsblk), GFP_KERNEL);
-	if (!nsblk)
-		return NULL;
-
-	dev = &nsblk->common.dev;
-	dev->type = &namespace_blk_device_type;
-	nsblk->id = ida_simple_get(&nd_region->ns_ida, 0, 0, GFP_KERNEL);
-	if (nsblk->id < 0) {
-		kfree(nsblk);
-		return NULL;
-	}
-	dev_set_name(dev, "namespace%d.%d", nd_region->id, nsblk->id);
-	dev->parent = &nd_region->dev;
-
-	return &nsblk->common.dev;
-}
-
 static struct device *nd_namespace_pmem_create(struct nd_region *nd_region)
 {
 	struct nd_namespace_pmem *nspm;
@@ -2050,10 +1924,7 @@ void nd_region_create_ns_seed(struct nd_region *nd_region)
 	if (nd_region_to_nstype(nd_region) == ND_DEVICE_NAMESPACE_IO)
 		return;
 
-	if (is_nd_blk(&nd_region->dev))
-		nd_region->ns_seed = nd_namespace_blk_create(nd_region);
-	else
-		nd_region->ns_seed = nd_namespace_pmem_create(nd_region);
+	nd_region->ns_seed = nd_namespace_pmem_create(nd_region);
 
 	/*
 	 * Seed creation failures are not fatal, provisioning is simply
@@ -2128,54 +1999,6 @@ static int add_namespace_resource(struct nd_region *nd_region,
 	return i;
 }
 
-static struct device *create_namespace_blk(struct nd_region *nd_region,
-		struct nd_namespace_label *nd_label, int count)
-{
-
-	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
-	struct nd_interleave_set *nd_set = nd_region->nd_set;
-	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
-	struct nd_namespace_blk *nsblk;
-	char name[NSLABEL_NAME_LEN];
-	struct device *dev = NULL;
-	struct resource *res;
-	uuid_t uuid;
-
-	if (!nsl_validate_type_guid(ndd, nd_label, &nd_set->type_guid))
-		return ERR_PTR(-EAGAIN);
-	if (!nsl_validate_blk_isetcookie(ndd, nd_label, nd_set->cookie2))
-		return ERR_PTR(-EAGAIN);
-
-	nsblk = kzalloc(sizeof(*nsblk), GFP_KERNEL);
-	if (!nsblk)
-		return ERR_PTR(-ENOMEM);
-	dev = &nsblk->common.dev;
-	dev->type = &namespace_blk_device_type;
-	dev->parent = &nd_region->dev;
-	nsblk->id = -1;
-	nsblk->lbasize = nsl_get_lbasize(ndd, nd_label);
-	nsl_get_uuid(ndd, nd_label, &uuid);
-	nsblk->uuid = kmemdup(&uuid, sizeof(uuid_t), GFP_KERNEL);
-	nsblk->common.claim_class = nsl_get_claim_class(ndd, nd_label);
-	if (!nsblk->uuid)
-		goto blk_err;
-	nsl_get_name(ndd, nd_label, name);
-	if (name[0]) {
-		nsblk->alt_name = kmemdup(name, NSLABEL_NAME_LEN, GFP_KERNEL);
-		if (!nsblk->alt_name)
-			goto blk_err;
-	}
-	res = nsblk_add_resource(nd_region, ndd, nsblk,
-			nsl_get_dpa(ndd, nd_label));
-	if (!res)
-		goto blk_err;
-	nd_dbg_dpa(nd_region, ndd, res, "%d: assign\n", count);
-	return dev;
- blk_err:
-	namespace_blk_release(dev);
-	return ERR_PTR(-ENXIO);
-}
-
 static int cmp_dpa(const void *a, const void *b)
 {
 	const struct device *dev_a = *(const struct device **) a;
@@ -2233,12 +2056,7 @@ static struct device **scan_labels(struct nd_region *nd_region)
 		kfree(devs);
 		devs = __devs;
 
-		if (is_nd_blk(&nd_region->dev))
-			dev = create_namespace_blk(nd_region, nd_label, count);
-		else
-			dev = create_namespace_pmem(nd_region, nd_mapping,
-						    nd_label);
-
+		dev = create_namespace_pmem(nd_region, nd_mapping, nd_label);
 		if (IS_ERR(dev)) {
 			switch (PTR_ERR(dev)) {
 			case -EAGAIN:
@@ -2260,30 +2078,21 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			? "blk" : "pmem", count == 1 ? "" : "s");
 
 	if (count == 0) {
+		struct nd_namespace_pmem *nspm;
+
 		/* Publish a zero-sized namespace for userspace to configure. */
 		nd_mapping_free_labels(nd_mapping);
 
 		devs = kcalloc(2, sizeof(dev), GFP_KERNEL);
 		if (!devs)
 			goto err;
-		if (is_nd_blk(&nd_region->dev)) {
-			struct nd_namespace_blk *nsblk;
-
-			nsblk = kzalloc(sizeof(*nsblk), GFP_KERNEL);
-			if (!nsblk)
-				goto err;
-			dev = &nsblk->common.dev;
-			dev->type = &namespace_blk_device_type;
-		} else {
-			struct nd_namespace_pmem *nspm;
 
-			nspm = kzalloc(sizeof(*nspm), GFP_KERNEL);
-			if (!nspm)
-				goto err;
-			dev = &nspm->nsio.common.dev;
-			dev->type = &namespace_pmem_device_type;
-			nd_namespace_pmem_set_resource(nd_region, nspm, 0);
-		}
+		nspm = kzalloc(sizeof(*nspm), GFP_KERNEL);
+		if (!nspm)
+			goto err;
+		dev = &nspm->nsio.common.dev;
+		dev->type = &namespace_pmem_device_type;
+		nd_namespace_pmem_set_resource(nd_region, nspm, 0);
 		dev->parent = &nd_region->dev;
 		devs[count++] = dev;
 	} else if (is_memory(&nd_region->dev)) {
@@ -2318,10 +2127,7 @@ static struct device **scan_labels(struct nd_region *nd_region)
  err:
 	if (devs) {
 		for (i = 0; devs[i]; i++)
-			if (is_nd_blk(&nd_region->dev))
-				namespace_blk_release(devs[i]);
-			else
-				namespace_pmem_release(devs[i]);
+			namespace_pmem_release(devs[i]);
 		kfree(devs);
 	}
 	return NULL;
@@ -2484,19 +2290,12 @@ int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
 		struct device *dev = devs[i];
 		int id;
 
-		if (type == ND_DEVICE_NAMESPACE_BLK) {
-			struct nd_namespace_blk *nsblk;
-
-			nsblk = to_nd_namespace_blk(dev);
-			id = ida_simple_get(&nd_region->ns_ida, 0, 0,
-					GFP_KERNEL);
-			nsblk->id = id;
-		} else if (type == ND_DEVICE_NAMESPACE_PMEM) {
+		if (type == ND_DEVICE_NAMESPACE_PMEM) {
 			struct nd_namespace_pmem *nspm;
 
 			nspm = to_nd_namespace_pmem(dev);
 			id = ida_simple_get(&nd_region->ns_ida, 0, 0,
-					GFP_KERNEL);
+					    GFP_KERNEL);
 			nspm->id = id;
 		} else
 			id = i;
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index a11850dd475d..e4af0719cf33 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -150,9 +150,6 @@ int nd_region_conflict(struct nd_region *nd_region, resource_size_t start,
 resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
 		struct nd_label_id *label_id);
 int alias_dpa_busy(struct device *dev, void *data);
-struct resource *nsblk_add_resource(struct nd_region *nd_region,
-		struct nvdimm_drvdata *ndd, struct nd_namespace_blk *nsblk,
-		resource_size_t start);
 int nvdimm_num_label_slots(struct nvdimm_drvdata *ndd);
 void get_ndd(struct nvdimm_drvdata *ndd);
 resource_size_t __nvdimm_namespace_capacity(struct nd_namespace_common *ndns);
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 6f8ce114032d..8391bf2729bc 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -687,7 +687,6 @@ static inline bool is_bad_pmem(struct badblocks *bb, sector_t sector,
 
 	return false;
 }
-resource_size_t nd_namespace_blk_validate(struct nd_namespace_blk *nsblk);
 const uuid_t *nd_dev_to_uuid(struct device *dev);
 bool pmem_should_map_pages(struct device *dev);
 #endif /* __ND_H__ */
diff --git a/include/linux/nd.h b/include/linux/nd.h
index 4813c7089e5c..7b2ccbdc1cbc 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -136,27 +136,6 @@ struct nd_namespace_pmem {
 	int id;
 };
 
-/**
- * struct nd_namespace_blk - namespace for dimm-bounded persistent memory
- * @alt_name: namespace name supplied in the dimm label
- * @uuid: namespace name supplied in the dimm label
- * @id: ida allocated id
- * @lbasize: blk namespaces have a native sector size when btt not present
- * @size: sum of all the resource ranges allocated to this namespace
- * @num_resources: number of dpa extents to claim
- * @res: discontiguous dpa extents for given dimm
- */
-struct nd_namespace_blk {
-	struct nd_namespace_common common;
-	char *alt_name;
-	uuid_t *uuid;
-	int id;
-	unsigned long lbasize;
-	resource_size_t size;
-	int num_resources;
-	struct resource **res;
-};
-
 static inline struct nd_namespace_io *to_nd_namespace_io(const struct device *dev)
 {
 	return container_of(dev, struct nd_namespace_io, common.dev);
@@ -169,11 +148,6 @@ static inline struct nd_namespace_pmem *to_nd_namespace_pmem(const struct device
 	return container_of(nsio, struct nd_namespace_pmem, nsio);
 }
 
-static inline struct nd_namespace_blk *to_nd_namespace_blk(const struct device *dev)
-{
-	return container_of(dev, struct nd_namespace_blk, common.dev);
-}
-
 /**
  * nvdimm_read_bytes() - synchronously read bytes from an nvdimm namespace
  * @ndns: device to read

