Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1EA12CFD9
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2019 13:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfL3MBP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Dec 2019 07:01:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbfL3MBP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Dec 2019 07:01:15 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 851AD5C8891C7BB89C4D;
        Mon, 30 Dec 2019 20:01:12 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Dec 2019 20:01:05 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tiantao6@huawei.com>, <jonathan.cameron@huawei.com>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] ACPI/PPTT: fixed some parameter type is not right
Date:   Mon, 30 Dec 2019 19:56:28 +0800
Message-ID: <1577706988-56848-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tian Tao <tiantao6@huawei.com>

The fourth parameter 'level' of function 'acpi_find_cache_level()' is a
signed interger, but its caller 'acpi_find_cache_node()' passes that
parameter an unsigned interger. This patch fixes the paramter type
inconsistency.

Signed-off-by: Tian Tao <tiantao6@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

---
v2:	fix the conflicts in the third hunk.
	Modify the commit information a little bit.
---
 drivers/acpi/pptt.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index f31544d..4ae9335 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -98,11 +98,11 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
  *
  * Return: The cache structure and the level we terminated with.
  */
-static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
-				int local_level,
-				struct acpi_subtable_header *res,
-				struct acpi_pptt_cache **found,
-				int level, int type)
+static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
+					 unsigned int local_level,
+					 struct acpi_subtable_header *res,
+					 struct acpi_pptt_cache **found,
+					 unsigned int level, int type)
 {
 	struct acpi_pptt_cache *cache;
 
@@ -119,7 +119,7 @@ static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 			if (*found != NULL && cache != *found)
 				pr_warn("Found duplicate cache level/type unable to determine uniqueness\n");
 
-			pr_debug("Found cache @ level %d\n", level);
+			pr_debug("Found cache @ level %u\n", level);
 			*found = cache;
 			/*
 			 * continue looking at this node's resource list
@@ -132,16 +132,17 @@ static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 	return local_level;
 }
 
-static struct acpi_pptt_cache *acpi_find_cache_level(struct acpi_table_header *table_hdr,
-						     struct acpi_pptt_processor *cpu_node,
-						     int *starting_level, int level,
-						     int type)
+static struct acpi_pptt_cache *
+acpi_find_cache_level(struct acpi_table_header *table_hdr,
+		      struct acpi_pptt_processor *cpu_node,
+		      unsigned int *starting_level, unsigned int level,
+		      int type)
 {
 	struct acpi_subtable_header *res;
-	int number_of_levels = *starting_level;
+	unsigned int number_of_levels = *starting_level;
 	int resource = 0;
 	struct acpi_pptt_cache *ret = NULL;
-	int local_level;
+	unsigned int local_level;
 
 	/* walk down from processor node */
 	while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
@@ -321,12 +322,12 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
 						    unsigned int level,
 						    struct acpi_pptt_processor **node)
 {
-	int total_levels = 0;
+	unsigned int total_levels = 0;
 	struct acpi_pptt_cache *found = NULL;
 	struct acpi_pptt_processor *cpu_node;
 	u8 acpi_type = acpi_cache_type(type);
 
-	pr_debug("Looking for CPU %d's level %d cache type %d\n",
+	pr_debug("Looking for CPU %d's level %u cache type %d\n",
 		 acpi_cpu_id, level, acpi_type);
 
 	cpu_node = acpi_find_processor_node(table_hdr, acpi_cpu_id);
-- 
1.7.12.4

