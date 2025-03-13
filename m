Return-Path: <linux-acpi+bounces-12163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DFCA5EB88
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 07:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F6C170B87
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 06:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F21F9F72;
	Thu, 13 Mar 2025 06:10:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081BA1FAC5A;
	Thu, 13 Mar 2025 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846213; cv=none; b=VygJYVyUofo1x/XcgAdBFLO9tlssUPA9PCk7k0ZZ62niTPuDii5YRZxJSco1K4/a/xgZHQeIoacg0A6pxH3ibTkoVhsYi8oefAlIFNVz9ELUEmuadOdL4D1+4US78lKvpMz2GnbIBzm8BRdA9W9xRrlp7+Srmw/SSbvMKOC9JJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846213; c=relaxed/simple;
	bh=haDKOhb9ripu8pCRPsDyANNnE4vbQebVtFppu+s+GgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PWreuOWsJbN7R9BDgp28jkWDsnPuOHeq/3ZhC+Ridavy5b+PHwrEK7v9sOtaizRBQegPRsAC6xJXlzJOxhOf/xKYZm7WASWddd9VzhB0fWtQ4TP+3XWE+Vio5ZkOcDMKN8kDKanyLw2oQ33O2FceX73MpZukTR/3P1b4z5WOMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAXHw+zdtJn3HhxCQ--.12654S2;
	Thu, 13 Mar 2025 14:09:55 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBHSYWxdtJnHJFGAA--.19030S3;
	Thu, 13 Mar 2025 14:09:54 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	bfaccini@nvidia.com,
	rppt@kernel.org,
	haibo1.xu@intel.com
Cc: chenbaozi@phytium.com.cn,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Date: Thu, 13 Mar 2025 14:09:07 +0800
Message-Id: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBHSYWxdtJnHJFGAA--.19030S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWfR6CADUgAAsn
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kry7JrWxWr18Kw1xuw13twb_yoW8Zw45pF
	Z7AFyFyry7XFWI9F4Dtw17WFyrC3WjkFWxKF9ru3sxZanxGryDArs3KFyjvFyDJry8Cw4f
	tFs5t3W5WFy8uF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

The absence of SRAT would cause the fake_pxm to be -1 and increment
to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
ranges that are defined in the CFMWS and not already defined in the
SRAT, the new node (node0) for the CXL memory would be invalid, as
node0 is already in "used".

This utilizes disable_srat() & srat_disabled() to fail CXL init.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---

Changes in v2:
- Add disable_srat() when fake_pxm is invalid
- Add srat_disabled() check in cxl_acpi_probe() and acpi_parse_cfmws()


 drivers/acpi/numa/srat.c | 10 ++++++++++
 drivers/cxl/acpi.c       |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 00ac0d7bb8c9..2dac25c9258a 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
+	if (srat_disabled()) {
+		pr_err("SRAT is missing or bad while processing CFMWS.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * The SRAT may have already described NUMA details for all,
 	 * or a portion of, this CFMWS HPA range. Extend the memblks
@@ -646,6 +651,11 @@ int __init acpi_numa_init(void)
 		if (node_to_pxm_map[i] > fake_pxm)
 			fake_pxm = node_to_pxm_map[i];
 	}
+
+	/* Make sure CFMWs fake nodes start at node[1] */
+	if (fake_pxm < 0)
+		disable_srat();
+
 	last_real_pxm = fake_pxm;
 	fake_pxm++;
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..e75a8ead99f6 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -829,6 +829,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	/* CXL must be in a NUMA system */
+	if (srat_disabled())
+		return -EINVAL;
+
 	cxl_res = devm_kzalloc(host, sizeof(*cxl_res), GFP_KERNEL);
 	if (!cxl_res)
 		return -ENOMEM;
-- 
2.34.1


