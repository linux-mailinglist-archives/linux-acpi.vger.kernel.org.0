Return-Path: <linux-acpi+bounces-1475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51D7EB289
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7461F25123
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9E41745
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF363FB34;
	Tue, 14 Nov 2023 12:57:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B819B;
	Tue, 14 Nov 2023 04:57:08 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SV5rV0dvgz6K9Ky;
	Tue, 14 Nov 2023 20:55:54 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 12:57:05 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>,
	<"pgonda@pgonda"@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 4/6] memory: scrub: Add scrub control attributes for the DDR5 ECS
Date: Tue, 14 Nov 2023 20:56:45 +0800
Message-ID: <20231114125648.1146-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231114125648.1146-1-shiju.jose@huawei.com>
References: <20231114125648.1146-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected

From: Shiju Jose <shiju.jose@huawei.com>

Add scrub control attributes for the DDR5 ECS feature.

The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts. The ECS control feature
allows the request to configure ECS input configurations during system
boot or at run-time.

The ECS control allows the requester to change the ECS threshold count
provided that the request is within the definition specified in DDR5 mode
registers, change mode between codeword mode and row count mode, and reset
the ECS counter.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/memory/scrub/memory-scrub.c | 14 +++++++++++++-
 include/memory/memory-scrub.h       | 11 +++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/scrub/memory-scrub.c b/drivers/memory/scrub/memory-scrub.c
index ff5b4a52d2da..5f7b1fd73fb1 100755
--- a/drivers/memory/scrub/memory-scrub.c
+++ b/drivers/memory/scrub/memory-scrub.c
@@ -211,7 +211,8 @@ static bool is_hex_attr(u32 attr)
 
 static bool is_string_attr(u32 attr)
 {
-	return	attr == scrub_speed_available;
+	return	attr == scrub_speed_available ||
+		attr == scrub_threshold_available;
 }
 
 static struct attribute *scrub_genattr(const void *drvdata,
@@ -266,11 +267,22 @@ static struct attribute *scrub_genattr(const void *drvdata,
 }
 
 static const char * const scrub_common_attrs[] = {
+	/* scrub attributes - common */
 	[scrub_addr_base] = "addr_base",
 	[scrub_addr_size] = "addr_size",
 	[scrub_enable] = "enable",
 	[scrub_speed] = "speed",
 	[scrub_speed_available] = "speed_available",
+	/* scrub attributes - DDR5 ECS/common */
+	[scrub_ecs_log_entry_type] = "ecs_log_entry_type",
+	[scrub_ecs_log_entry_type_per_dram] = "ecs_log_entry_type_per_dram",
+	[scrub_ecs_log_entry_type_per_memory_media] = "ecs_log_entry_type_per_memory_media",
+	[scrub_mode] = "mode",
+	[scrub_mode_counts_rows] = "mode_counts_rows",
+	[scrub_mode_counts_codewords] = "mode_counts_codewords",
+	[scrub_reset_counter] = "reset_counter",
+	[scrub_threshold] = "threshold",
+	[scrub_threshold_available] = "threshold_available",
 };
 
 static struct attribute **
diff --git a/include/memory/memory-scrub.h b/include/memory/memory-scrub.h
index 8e999c9daaed..2e223e29a5bc 100755
--- a/include/memory/memory-scrub.h
+++ b/include/memory/memory-scrub.h
@@ -17,11 +17,22 @@ enum scrub_types {
 };
 
 enum scrub_attributes {
+	/* scrub attributes - common */
 	scrub_addr_base,
 	scrub_addr_size,
 	scrub_enable,
 	scrub_speed,
 	scrub_speed_available,
+	/* scrub attributes - DDR5 ECS/common */
+	scrub_ecs_log_entry_type,
+	scrub_ecs_log_entry_type_per_dram,
+	scrub_ecs_log_entry_type_per_memory_media,
+	scrub_mode,
+	scrub_mode_counts_rows,
+	scrub_mode_counts_codewords,
+	scrub_reset_counter,
+	scrub_threshold,
+	scrub_threshold_available,
 	max_attrs,
 };
 
-- 
2.34.1


