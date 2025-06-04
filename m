Return-Path: <linux-acpi+bounces-14121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448DAACD5B7
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 04:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E0A189A012
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E416F8E9;
	Wed,  4 Jun 2025 02:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+c83KrZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBF1519B4;
	Wed,  4 Jun 2025 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749004588; cv=none; b=DH5A01mv2hx/lKb/MW7DjXy0Kp5javHkzBbEq2cPAVZ0yzWgoPzw52Wg5tm+jgJw8f4HC17z/Nm0pctwtyP3jd05j7wr0VRvPCZqxNh+OIk8GLNvYBp03QIc3r56BkZt4Yx18P7DisZRZLQv81eKa88aLf/x4iv9GrxNMHJe1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749004588; c=relaxed/simple;
	bh=XnkF8GMiqVFFAPNc03BSO7NNXF7cVBexlzuZhiEyuv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jrfYymppwgp0WmpKAc9IFWhcDeI54IYfoyS8yGM4UVNTkyR/emjETPHFpNPZFlx/2mfJwSpD94volUhU6ILElKSBZoWCSolwhjB+SbXAXqIoRoKrTY4lOeMU3+0Y/RTYSXLlArJdlCWYkXsm6UsTXUd5njAAxGO2Qv/ajdMeGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+c83KrZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749004587; x=1780540587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XnkF8GMiqVFFAPNc03BSO7NNXF7cVBexlzuZhiEyuv8=;
  b=i+c83KrZSb2HAraRI+K+eXbZiBwLCb752AVqiPFP+SOP97VBK6AG7qqQ
   4IQ3yS+AJ1DtKb4tRTmkSGs5u9LSY5s4njcRw9CZyanBBXDgFhpLNwI5w
   yRimSyp1bECPGqH9kE8rUQQS5AsmTQG3uapLBwRM2zMcmGZRCKNNtZwyy
   6qXBaw6iKVzT7Cnx09wucIoIErzvLqFPkRr4NsppYQIJKWIqXxFSSWU7R
   4dZ58kgq7KK63yeKEyCgMm78QWuHrWruAew3mHc8NINO9GDhohwuuxjzL
   bUrkOpzZy39rJZUcZaLtXY0SH8hQajTUBImvnFxSyYjz+rXpC2RLrdCtn
   Q==;
X-CSE-ConnectionGUID: cjirubLJSPuizUe27kzn9A==
X-CSE-MsgGUID: bWwVp18/RASkR3wTRL3I1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68618882"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="68618882"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 19:36:26 -0700
X-CSE-ConnectionGUID: IBUDyrAvRcuAZq9wvKDiPQ==
X-CSE-MsgGUID: hAo/CRgXQMurIhoaR4lmiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="150088179"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa004.jf.intel.com with ESMTP; 03 Jun 2025 19:36:24 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	"Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.com>
Subject: [PATCH] ACPI: pfr_update: Add more debug information when firmware update failed
Date: Wed,  4 Jun 2025 10:29:56 +0800
Message-Id: <20250604022956.3723438-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users reported insufficient error information for debugging during
firmware update failures on certain platforms. Add verbose error logs
in the error code path to enhance debuggability.

Reported-by: "Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/pfr_update.c | 63 +++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 031d1ba81b86..318683744ed1 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -127,8 +127,11 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr,
 					  pfru_dev->rev_id,
 					  PFRU_FUNC_QUERY_UPDATE_CAP,
 					  NULL, ACPI_TYPE_PACKAGE);
-	if (!out_obj)
+	if (!out_obj) {
+		dev_dbg(pfru_dev->parent_dev,
+			"Query cap failed with no object\n");
 		return ret;
+	}
 
 	if (out_obj->package.count < CAP_NR_IDX ||
 	    out_obj->package.elements[CAP_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
@@ -141,13 +144,17 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr,
 	    out_obj->package.elements[CAP_DRV_SVN_IDX].type != ACPI_TYPE_INTEGER ||
 	    out_obj->package.elements[CAP_PLAT_ID_IDX].type != ACPI_TYPE_BUFFER ||
 	    out_obj->package.elements[CAP_OEM_ID_IDX].type != ACPI_TYPE_BUFFER ||
-	    out_obj->package.elements[CAP_OEM_INFO_IDX].type != ACPI_TYPE_BUFFER)
+	    out_obj->package.elements[CAP_OEM_INFO_IDX].type != ACPI_TYPE_BUFFER) {
+		dev_dbg(pfru_dev->parent_dev,
+			"Query cap failed with invalid package count/type\n");
 		goto free_acpi_buffer;
+	}
 
 	cap_hdr->status = out_obj->package.elements[CAP_STATUS_IDX].integer.value;
 	if (cap_hdr->status != DSM_SUCCEED) {
 		ret = -EBUSY;
-		dev_dbg(pfru_dev->parent_dev, "Error Status:%d\n", cap_hdr->status);
+		dev_dbg(pfru_dev->parent_dev, "Query cap Error Status:%d\n",
+			cap_hdr->status);
 		goto free_acpi_buffer;
 	}
 
@@ -193,24 +200,32 @@ static int query_buffer(struct pfru_com_buf_info *info,
 	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
 					  pfru_dev->rev_id, PFRU_FUNC_QUERY_BUF,
 					  NULL, ACPI_TYPE_PACKAGE);
-	if (!out_obj)
+	if (!out_obj) {
+		dev_dbg(pfru_dev->parent_dev,
+			"Query buf failed with no object\n");
 		return ret;
+	}
 
 	if (out_obj->package.count < BUF_NR_IDX ||
 	    out_obj->package.elements[BUF_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
 	    out_obj->package.elements[BUF_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
 	    out_obj->package.elements[BUF_ADDR_LOW_IDX].type != ACPI_TYPE_INTEGER ||
 	    out_obj->package.elements[BUF_ADDR_HI_IDX].type != ACPI_TYPE_INTEGER ||
-	    out_obj->package.elements[BUF_SIZE_IDX].type != ACPI_TYPE_INTEGER)
+	    out_obj->package.elements[BUF_SIZE_IDX].type != ACPI_TYPE_INTEGER) {
+		dev_dbg(pfru_dev->parent_dev,
+			"Query buf failed with invalid package count/type\n");
 		goto free_acpi_buffer;
+	}
 
 	info->status = out_obj->package.elements[BUF_STATUS_IDX].integer.value;
 	info->ext_status =
 		out_obj->package.elements[BUF_EXT_STATUS_IDX].integer.value;
 	if (info->status != DSM_SUCCEED) {
 		ret = -EBUSY;
-		dev_dbg(pfru_dev->parent_dev, "Error Status:%d\n", info->status);
-		dev_dbg(pfru_dev->parent_dev, "Error Extended Status:%d\n", info->ext_status);
+		dev_dbg(pfru_dev->parent_dev,
+			"Query buf failed with Error Status:%d\n", info->status);
+		dev_dbg(pfru_dev->parent_dev,
+			"Query buf failed with Error Extended Status:%d\n", info->ext_status);
 
 		goto free_acpi_buffer;
 	}
@@ -295,12 +310,16 @@ static bool applicable_image(const void *data, struct pfru_update_cap_info *cap,
 	m_img_hdr = data + size;
 
 	type = get_image_type(m_img_hdr, pfru_dev);
-	if (type < 0)
+	if (type < 0) {
+		dev_dbg(pfru_dev->parent_dev, "Invalid image type\n");
 		return false;
+	}
 
 	size = adjust_efi_size(m_img_hdr, size);
-	if (size < 0)
+	if (size < 0) {
+		dev_dbg(pfru_dev->parent_dev, "Invalid image size\n");
 		return false;
+	}
 
 	auth = data + size;
 	size += sizeof(u64) + auth->auth_info.hdr.len;
@@ -346,8 +365,11 @@ static int start_update(int action, struct pfru_device *pfru_dev)
 	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
 					  pfru_dev->rev_id, PFRU_FUNC_START,
 					  &in_obj, ACPI_TYPE_PACKAGE);
-	if (!out_obj)
+	if (!out_obj) {
+		dev_dbg(pfru_dev->parent_dev,
+			"Update failed to start with no object\n");
 		return ret;
+	}
 
 	if (out_obj->package.count < UPDATE_NR_IDX ||
 	    out_obj->package.elements[UPDATE_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
@@ -355,8 +377,11 @@ static int start_update(int action, struct pfru_device *pfru_dev)
 	    out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER ||
 	    out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].type != ACPI_TYPE_INTEGER ||
 	    out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER ||
-	    out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].type != ACPI_TYPE_INTEGER)
+	    out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].type != ACPI_TYPE_INTEGER) {
+		dev_dbg(pfru_dev->parent_dev,
+			"Update failed with invalid package count/type\n");
 		goto free_acpi_buffer;
+	}
 
 	update_result.status =
 		out_obj->package.elements[UPDATE_STATUS_IDX].integer.value;
@@ -365,8 +390,10 @@ static int start_update(int action, struct pfru_device *pfru_dev)
 
 	if (update_result.status != DSM_SUCCEED) {
 		ret = -EBUSY;
-		dev_dbg(pfru_dev->parent_dev, "Error Status:%d\n", update_result.status);
-		dev_dbg(pfru_dev->parent_dev, "Error Extended Status:%d\n",
+		dev_dbg(pfru_dev->parent_dev,
+			"Update failed with Error Status:%d\n", update_result.status);
+		dev_dbg(pfru_dev->parent_dev,
+			"Update failed with Error Extended Status:%d\n",
 			update_result.ext_status);
 
 		goto free_acpi_buffer;
@@ -450,8 +477,10 @@ static ssize_t pfru_write(struct file *file, const char __user *buf,
 	if (ret)
 		return ret;
 
-	if (len > buf_info.buf_size)
+	if (len > buf_info.buf_size) {
+		dev_dbg(pfru_dev->parent_dev, "Capsule image size too large\n");
 		return -EINVAL;
+	}
 
 	iov.iov_base = (void __user *)buf;
 	iov.iov_len = len;
@@ -460,10 +489,14 @@ static ssize_t pfru_write(struct file *file, const char __user *buf,
 	/* map the communication buffer */
 	phy_addr = (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.addr_lo);
 	buf_ptr = memremap(phy_addr, buf_info.buf_size, MEMREMAP_WB);
-	if (!buf_ptr)
+	if (!buf_ptr) {
+		dev_dbg(pfru_dev->parent_dev, "Failed to remap the buffer\n");
 		return -ENOMEM;
+	}
 
 	if (!copy_from_iter_full(buf_ptr, len, &iter)) {
+		dev_dbg(pfru_dev->parent_dev,
+			"Failed to copy the data from the user space buffer\n");
 		ret = -EINVAL;
 		goto unmap;
 	}
-- 
2.25.1


