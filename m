Return-Path: <linux-acpi+bounces-2035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370717FFCC4
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 21:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5E8B2089B
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 20:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29306482CA
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC6510E4;
	Thu, 30 Nov 2023 11:23:35 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh5fX6BRjz6DB9n;
	Fri,  1 Dec 2023 03:21:56 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id A59C01402CD;
	Fri,  1 Dec 2023 03:23:33 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 19:23:32 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 08/11] memory: scrub: Add scrub control attributes for the DDR5 ECS
Date: Fri, 1 Dec 2023 03:23:10 +0800
Message-ID: <20231130192314.1220-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231130192314.1220-1-shiju.jose@huawei.com>
References: <20231130192314.1220-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

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
 drivers/memory/scrub/memory-scrub.c | 13 ++++++++++++-
 include/memory/memory-scrub.h       | 10 ++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/scrub/memory-scrub.c b/drivers/memory/scrub/memory-scrub.c
index c2d794b2624b..43b7da43114f 100755
--- a/drivers/memory/scrub/memory-scrub.c
+++ b/drivers/memory/scrub/memory-scrub.c
@@ -208,7 +208,8 @@ static bool is_hex_attr(u32 attr)
 
 static bool is_string_attr(u32 attr)
 {
-	return	attr == scrub_speed_available;
+	return	attr == scrub_speed_available ||
+		attr == scrub_threshold_available;
 }
 
 static struct attribute *scrub_genattr(const void *drvdata,
@@ -269,6 +270,16 @@ static const char * const scrub_common_attrs[] = {
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
index d7cbde4718d0..74ad5addd5b3 100755
--- a/include/memory/memory-scrub.h
+++ b/include/memory/memory-scrub.h
@@ -23,6 +23,16 @@ enum scrub_attributes {
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


