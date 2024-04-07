Return-Path: <linux-acpi+bounces-4702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32CD89B0D5
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Apr 2024 14:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AB51C20E52
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Apr 2024 12:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BBA24B33;
	Sun,  7 Apr 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h+Q+gPp2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22F2375F
	for <linux-acpi@vger.kernel.org>; Sun,  7 Apr 2024 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493583; cv=none; b=CkP1S/OaIL5BN6JZNWDNIJnZrtbk/eLQIxT030tLx3StAZKQ9neFKa7OJXa5oUHCQ3+KoBMgiY1hX40fGJRTwx4T7r6K8LRbpJboOQPCrwCCJHCfDoTnE3C8BHvPjeWt31IYAFet4ywKTUqk1re9Qu07Y8daRBC/2/Ux/sATTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493583; c=relaxed/simple;
	bh=eGrvIfqPXS6QwpY+mYvAwWgafwQOupoa5XqTr6tLbqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mIfIWNCDkm2U6juOhUjO/jeSY/rtH/bEXwyT1Tddnsw5UrjeNcBrZoXj5vg62IP2kBDKU6/6mPtED2icdxpFygM/Gaeygs6xzq/WBl94+XiMeO/Xhan48CkXgkAiJ2RIhPFKcN54Q8u8F/ncG19i4zjTfEIvJ4gHbR3LBeXc/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h+Q+gPp2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso2622626b3a.2
        for <linux-acpi@vger.kernel.org>; Sun, 07 Apr 2024 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712493581; x=1713098381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vPBHKQJQEE6Ldq8xPlUpXcKmkLxliyIjm+yGQB4JHjw=;
        b=h+Q+gPp2ivuQolq+66H1ppC8K9oqxnjok0MsTGQfwSxxtQSD/iNTg7UKqQtaTtVFTs
         3QPKzIEbv2uJFlEBU5txhIKgi8fhZ6UCjh5bPJkgNKvxr4cifahutZySVfE8lhHZTqbb
         mp8K19ghMZwWBxlhetFyfVVFEzPwYPlfqa0+GfKPdCfQ/eLI9LQehZp76jBsDPUmsrDy
         Sg3/l7LR+8Nlsjh5kiU3O8SIO9s+Q0MyzTeoJcj24LnzEhVSK39k+UnikjWIC/F1vPcA
         QTO1vxoTRxP+/roKyyhO2EDxaIm/SnnLOupeQCt1gfu7i4P2TrMuHem1NUFZZ8JjvgKy
         /Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712493581; x=1713098381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPBHKQJQEE6Ldq8xPlUpXcKmkLxliyIjm+yGQB4JHjw=;
        b=YNbJ9sWSHD6JogYOo/f4ncEuHMLLzq/7G0VEzc0Gi5Ka457xQCdgD1FaqDwycIGEbG
         CMAwFb6aitnfTUwOVkzJ97tcE/jEZq9OR7Ge1makaD0wYmhYsjtO7nkFLfIg3ElFxbwy
         wtO2k+73oYEVKv8yXIu5dlvp+DIVsQpxA3MhAbdESS7yBEkhpGNgUuZKdiIZcYL/GujY
         oE6K6itQIHqmVlHqUaZ/lMyTRszVjV8Piq33F4eKEwCODBC7/G22JIRYk6hGpkX5M1AA
         CrNqTXE8idJw2Bdqy7m3I+6BiydpMqU7aCN9GKpeUAywCl8WhbPbdLY5kPXbRW9rL8gO
         SszQ==
X-Forwarded-Encrypted: i=1; AJvYcCXySxf27FBX2QpZaG5TQorNRIbhRZZrJ2sJqnQysGY1lndJQexqBtUEJbGe1qpzzZVVrO/vu6awbyXesBEwhwhXPH3UXSvaBJcAMQ==
X-Gm-Message-State: AOJu0YxrFsGSA0FagzjsxVb37rRu8BN4EjswqfqHt16PhZ7sui1UX8AX
	Hssre8EGUAu3zqICqi/Ky5qbZV/OLEh5a0ieIDIQ4izP15G//Yqk6BkhGFlDDwY=
X-Google-Smtp-Source: AGHT+IFJUJpcaALlEKLwsTMy4Msxncvd4YWls0qgllSZsfvWQuz8O0EgJe+rILAvbChBvgUXtRbMgg==
X-Received: by 2002:a05:6a20:8423:b0:1a3:64e8:eb8f with SMTP id c35-20020a056a20842300b001a364e8eb8fmr6675079pzd.11.1712493581235;
        Sun, 07 Apr 2024 05:39:41 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b001dd578121d4sm4933210pln.204.2024.04.07.05.39.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Apr 2024 05:39:40 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo entirely with PPTT
Date: Sun,  7 Apr 2024 20:38:28 +0800
Message-Id: <20240407123829.36474-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the type and level information of this_leaf cannot be obtained
from arch, cacheinfo is completely filled in with the content of PPTT.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/acpi/pptt.c | 135 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 124 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index a35dd0e41c27..6c54fc8e3039 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -21,6 +21,9 @@
 #include <linux/cacheinfo.h>
 #include <acpi/processor.h>
 
+void acpi_fill_cacheinfo(struct acpi_pptt_cache *cache, struct acpi_table_header *table,
+			 int cpu, int level, int *index);
+
 static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
 							u32 pptt_ref)
 {
@@ -77,6 +80,18 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
 		table_type & ACPI_PPTT_CACHE_TYPE_UNIFIED & type);
 }
 
+static inline u32 get_cache_id(struct acpi_pptt_cache *cache)
+{
+	struct acpi_pptt_cache_v1 *cache_v1;
+
+	if (cache->flags & ACPI_PPTT_CACHE_ID_VALID) {
+		cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
+					cache, sizeof(struct acpi_pptt_cache));
+		return cache_v1->cache_id;
+	}
+	return 0;
+}
+
 /**
  * acpi_pptt_walk_cache() - Attempt to find the requested acpi_pptt_cache
  * @table_hdr: Pointer to the head of the PPTT table
@@ -104,7 +119,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 					 unsigned int *split_levels,
 					 struct acpi_subtable_header *res,
 					 struct acpi_pptt_cache **found,
-					 unsigned int level, int type)
+					 unsigned int level, int type, int cpu, int *index)
 {
 	struct acpi_pptt_cache *cache;
 
@@ -125,7 +140,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 		     acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CACHE_TYPE_INSTR)))
 			*split_levels = local_level;
 
-		if (local_level == level &&
+		if (level && local_level == level &&
 		    acpi_pptt_match_type(cache->attributes, type)) {
 			if (*found != NULL && cache != *found)
 				pr_warn("Found duplicate cache level/type unable to determine uniqueness\n");
@@ -137,7 +152,9 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 			 * to verify that we don't find a duplicate
 			 * cache node.
 			 */
-		}
+		} else
+			acpi_fill_cacheinfo(cache, table_hdr, cpu, local_level, index);
+
 		cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
 	}
 	return local_level;
@@ -147,7 +164,7 @@ static struct acpi_pptt_cache *
 acpi_find_cache_level(struct acpi_table_header *table_hdr,
 		      struct acpi_pptt_processor *cpu_node,
 		      unsigned int *starting_level, unsigned int *split_levels,
-		      unsigned int level, int type)
+		      unsigned int level, int type, int cpu, int *index)
 {
 	struct acpi_subtable_header *res;
 	unsigned int number_of_levels = *starting_level;
@@ -161,7 +178,8 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
 
 		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
 						   split_levels, res, &ret,
-						   level, type);
+						   level, type, cpu, index);
+
 		/*
 		 * we are looking for the max depth. Since its potentially
 		 * possible for a given node to have resources with differing
@@ -197,7 +215,7 @@ static void acpi_count_levels(struct acpi_table_header *table_hdr,
 			      unsigned int *levels, unsigned int *split_levels)
 {
 	do {
-		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
+		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0, 0, NULL);
 		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
 	} while (cpu_node);
 }
@@ -316,6 +334,7 @@ static u8 acpi_cache_type(enum cache_type type)
 }
 
 static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *table_hdr,
+						    int cpu,
 						    u32 acpi_cpu_id,
 						    enum cache_type type,
 						    unsigned int level,
@@ -325,6 +344,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
 	struct acpi_pptt_cache *found = NULL;
 	struct acpi_pptt_processor *cpu_node;
 	u8 acpi_type = acpi_cache_type(type);
+	int index = 0;
 
 	pr_debug("Looking for CPU %d's level %u cache type %d\n",
 		 acpi_cpu_id, level, acpi_type);
@@ -333,7 +353,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
 
 	while (cpu_node && !found) {
 		found = acpi_find_cache_level(table_hdr, cpu_node,
-					      &total_levels, NULL, level, acpi_type);
+					      &total_levels, NULL, level, acpi_type, cpu, &index);
 		*node = cpu_node;
 		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
 	}
@@ -406,8 +426,14 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 	 * specified in PPTT.
 	 */
 	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
-	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
-		this_leaf->type = CACHE_TYPE_UNIFIED;
+	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) {
+		if (acpi_pptt_match_type(found_cache->attributes, ACPI_PPTT_CACHE_TYPE_DATA))
+			this_leaf->type = CACHE_TYPE_DATA;
+		if (acpi_pptt_match_type(found_cache->attributes, ACPI_PPTT_CACHE_TYPE_INSTR))
+			this_leaf->type = CACHE_TYPE_INST;
+		if (acpi_pptt_match_type(found_cache->attributes, ACPI_PPTT_CACHE_TYPE_UNIFIED))
+			this_leaf->type = CACHE_TYPE_UNIFIED;
+	}
 
 	if (revision >= 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
 		found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
@@ -417,19 +443,106 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 	}
 }
 
+static bool cache_is_filled_id(struct acpi_pptt_cache *cache, int cpu)
+{
+	u32 id = get_cache_id(cache);
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf;
+	int index = 0;
+
+	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
+		this_leaf = this_cpu_ci->info_list + index;
+		if (this_leaf->id == id)
+			return true;
+		index++;
+	}
+	return false;
+}
+
+static bool cache_is_filled_content(struct acpi_pptt_cache *cache,
+				    struct acpi_table_header *table,
+				    int cpu, int level, u8 revision)
+{
+	struct acpi_pptt_processor *cpu_node;
+	struct cacheinfo *this_leaf, *tleaf;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo tmp_leaf = {0};
+	int index = 0;
+
+	cpu_node = acpi_find_processor_node(table, get_acpi_id_for_cpu(cpu));
+	tleaf = &tmp_leaf;
+	tleaf->level = level;
+
+	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
+		this_leaf = this_cpu_ci->info_list + index;
+		update_cache_properties(tleaf, cache,
+					ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
+					revision);
+		if (!memcmp(this_leaf, tleaf, sizeof(struct cacheinfo)))
+			return true;
+		index++;
+	}
+	return false;
+}
+
+static bool cache_is_filled(struct acpi_pptt_cache *cache, struct acpi_table_header *table,
+				   int cpu, int level)
+{
+	u8 revision = table->revision;
+
+	/*
+	 * If revision >= 3, compare the cacheid directly,
+	 * otherwise compare the entire contents of the cache.
+	 */
+	if (revision >= 3)
+		return cache_is_filled_id(cache, cpu);
+	else
+		return cache_is_filled_content(cache, table, cpu, level, revision);
+}
+
+void acpi_fill_cacheinfo(struct acpi_pptt_cache *cache,
+				struct acpi_table_header *table,
+				int cpu, int level, int *index)
+{
+	struct cacheinfo *this_leaf;
+	struct acpi_pptt_processor *cpu_node;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+
+	if (!index)
+		return;
+
+	cpu_node = acpi_find_processor_node(table, get_acpi_id_for_cpu(cpu));
+	this_leaf = this_cpu_ci->info_list + *index;
+	if (this_leaf) {
+		this_leaf->level = level;
+		if (cache_is_filled(cache, table, cpu, level))
+			return;
+		update_cache_properties(this_leaf, cache,
+					ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node,
+							table)),
+					table->revision);
+		*index += 1;
+	}
+}
+
 static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 				 unsigned int cpu)
 {
 	struct acpi_pptt_cache *found_cache;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
-	struct cacheinfo *this_leaf;
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
 	unsigned int index = 0;
 	struct acpi_pptt_processor *cpu_node = NULL;
 
+	if (!this_leaf->type && !this_leaf->level) {
+		acpi_find_cache_node(table, acpi_cpu_id, cpu, 0, 0, &cpu_node);
+		return;
+	}
+
 	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
 		this_leaf = this_cpu_ci->info_list + index;
-		found_cache = acpi_find_cache_node(table, acpi_cpu_id,
+		found_cache = acpi_find_cache_node(table, acpi_cpu_id, cpu,
 						   this_leaf->type,
 						   this_leaf->level,
 						   &cpu_node);
-- 
2.20.1


