Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803554D93A
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 20:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfFTScd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 14:32:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfFTScd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jun 2019 14:32:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFED74E90E;
        Thu, 20 Jun 2019 18:32:31 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-71.ams2.redhat.com [10.36.116.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFF9419722;
        Thu, 20 Jun 2019 18:32:25 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>
Subject: [PATCH v3 6/6] drivers/base/memory.c: Get rid of find_memory_block_hinted()
Date:   Thu, 20 Jun 2019 20:31:39 +0200
Message-Id: <20190620183139.4352-7-david@redhat.com>
In-Reply-To: <20190620183139.4352-1-david@redhat.com>
References: <20190620183139.4352-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 20 Jun 2019 18:32:32 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

No longer needed, let's remove it. Also, drop the "hint" parameter
completely from "find_memory_block_by_id", as nobody needs it anymore.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 37 +++++++++++--------------------------
 include/linux/memory.h |  2 --
 2 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 0204384b4d1d..195dbcb8e8a8 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -588,30 +588,13 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
 	return 0;
 }
 
-/*
- * A reference for the returned object is held and the reference for the
- * hinted object is released.
- */
-static struct memory_block *find_memory_block_by_id(unsigned long block_id,
-						    struct memory_block *hint)
+/* A reference for the returned memory block device is acquired. */
+static struct memory_block *find_memory_block_by_id(unsigned long block_id)
 {
-	struct device *hintdev = hint ? &hint->dev : NULL;
 	struct device *dev;
 
-	dev = subsys_find_device_by_id(&memory_subsys, block_id, hintdev);
-	if (hint)
-		put_device(&hint->dev);
-	if (!dev)
-		return NULL;
-	return to_memory_block(dev);
-}
-
-struct memory_block *find_memory_block_hinted(struct mem_section *section,
-					      struct memory_block *hint)
-{
-	unsigned long block_id = base_memory_block_id(__section_nr(section));
-
-	return find_memory_block_by_id(block_id, hint);
+	dev = subsys_find_device_by_id(&memory_subsys, block_id, NULL);
+	return dev ? to_memory_block(dev) : NULL;
 }
 
 /*
@@ -624,7 +607,9 @@ struct memory_block *find_memory_block_hinted(struct mem_section *section,
  */
 struct memory_block *find_memory_block(struct mem_section *section)
 {
-	return find_memory_block_hinted(section, NULL);
+	unsigned long block_id = base_memory_block_id(__section_nr(section));
+
+	return find_memory_block_by_id(block_id);
 }
 
 static struct attribute *memory_memblk_attrs[] = {
@@ -675,7 +660,7 @@ static int init_memory_block(struct memory_block **memory,
 	unsigned long start_pfn;
 	int ret = 0;
 
-	mem = find_memory_block_by_id(block_id, NULL);
+	mem = find_memory_block_by_id(block_id);
 	if (mem) {
 		put_device(&mem->dev);
 		return -EEXIST;
@@ -755,7 +740,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
 		end_block_id = block_id;
 		for (block_id = start_block_id; block_id != end_block_id;
 		     block_id++) {
-			mem = find_memory_block_by_id(block_id, NULL);
+			mem = find_memory_block_by_id(block_id);
 			mem->section_count = 0;
 			unregister_memory(mem);
 		}
@@ -782,7 +767,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 
 	mutex_lock(&mem_sysfs_mutex);
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		mem = find_memory_block_by_id(block_id, NULL);
+		mem = find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
 			continue;
 		mem->section_count = 0;
@@ -882,7 +867,7 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
 	int ret = 0;
 
 	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
-		mem = find_memory_block_by_id(block_id, NULL);
+		mem = find_memory_block_by_id(block_id);
 		if (!mem)
 			continue;
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index b3b388775a30..02e633f3ede0 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -116,8 +116,6 @@ void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern int memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
 extern int memory_isolate_notify(unsigned long val, void *v);
-extern struct memory_block *find_memory_block_hinted(struct mem_section *,
-							struct memory_block *);
 extern struct memory_block *find_memory_block(struct mem_section *);
 typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
-- 
2.21.0

