Return-Path: <linux-acpi+bounces-11986-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E64A58FDF
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 10:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385DB188E870
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2943F2253F9;
	Mon, 10 Mar 2025 09:39:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514E02253EC;
	Mon, 10 Mar 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599592; cv=none; b=KwyUDV90Ux82lgQXOeuRxDa0wkj+obQlXSaHoD09nYfUfbqtIoO9lRwUv/L0NPexQV7ktci1KUgK+z7yGplRphLBYebkm2iezyiq9RxNyzBPaMN4sLR3r1TrIpns+tNj4pitK077WDlFEAjmuPeciK4Ga/7ZGvrjlZ6nOu321No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599592; c=relaxed/simple;
	bh=mXEXXWZhTAy6Xgv9fTXo+ptxJ2X1MjYFV3t3jQa9mjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O8i8gqbxoKxi8/BIg+czaB3FtIJJCOHZ472Y5jBpd0M1j6a38XVXyeSQEyqTPcNi5hxuroSsXfgXvMxpLg8sZnBCXQy353x+IJFzEkyzPTL7MPH1ocIQ+vXhVhPgr4X06bzcNRtTVKA88FihtAfEE7o8pnMzCXFWxrtk+1sKLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX3k5Us85n9g9PCA--.19023S2;
	Mon, 10 Mar 2025 17:39:32 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBnZ4NRs85nV6ZBAA--.19172S3;
	Mon, 10 Mar 2025 17:39:31 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	alison.schofield@intel.com,
	rrichter@amd.com,
	bfaccini@nvidia.com,
	haibo1.xu@intel.com,
	dave.jiang@intel.com,
	rppt@kernel.org,
	gourry@gourry.net
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Date: Mon, 10 Mar 2025 17:39:10 +0800
Message-Id: <20250310093910.1752126-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBnZ4NRs85nV6ZBAA--.19172S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQACAWfJ-yEJJwBCse
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZrW3Ww45JryDKr45XryUGFg_yoWDJrb_uF
	Z7ur4xJa12gF4I9wnrtr15ZrWvyrs7uFykZ3WSqa4Fka4kX3W3Ca1Yv3sxZr15KF1fGFs8
	Ca98AryFyr4fZjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

The absence of SRAT would cause the fake_pxm to be -1 and increment
to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
ranges that are defined in the CFMWS and not already defined in the
SRAT, the new node (node0) for the CXL memory would be invalid, as
node0 is already in "used".

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 drivers/acpi/numa/srat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 00ac0d7bb8c9..eb8628e217fa 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -646,6 +646,9 @@ int __init acpi_numa_init(void)
 		if (node_to_pxm_map[i] > fake_pxm)
 			fake_pxm = node_to_pxm_map[i];
 	}
+	if (fake_pxm == PXM_INVAL)
+		pr_warn("Failed to find the next unused PXM value for CFMWs\n");
+
 	last_real_pxm = fake_pxm;
 	fake_pxm++;
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
-- 
2.34.1


