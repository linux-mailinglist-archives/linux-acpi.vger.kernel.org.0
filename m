Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4794B4CC0E
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 12:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfFTKfs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 06:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731388AbfFTKfr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jun 2019 06:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 074DF2E97C7;
        Thu, 20 Jun 2019 10:35:47 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-88.ams2.redhat.com [10.36.117.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D445160600;
        Thu, 20 Jun 2019 10:35:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 2/6] drivers/base/memory: Use "unsigned long" for block ids
Date:   Thu, 20 Jun 2019 12:35:16 +0200
Message-Id: <20190620103520.23481-3-david@redhat.com>
In-Reply-To: <20190620103520.23481-1-david@redhat.com>
References: <20190620103520.23481-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 20 Jun 2019 10:35:47 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Block ids are just shifted section numbers, so let's also use
"unsigned long" for them, too.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 5947b5a5686d..c54e80fd25a8 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -34,12 +34,12 @@ static DEFINE_MUTEX(mem_sysfs_mutex);
 
 static int sections_per_block;
 
-static inline int base_memory_block_id(unsigned long section_nr)
+static inline unsigned long base_memory_block_id(unsigned long section_nr)
 {
 	return section_nr / sections_per_block;
 }
 
-static inline int pfn_to_block_id(unsigned long pfn)
+static inline unsigned long pfn_to_block_id(unsigned long pfn)
 {
 	return base_memory_block_id(pfn_to_section_nr(pfn));
 }
@@ -587,7 +587,7 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
  * A reference for the returned object is held and the reference for the
  * hinted object is released.
  */
-static struct memory_block *find_memory_block_by_id(int block_id,
+static struct memory_block *find_memory_block_by_id(unsigned long block_id,
 						    struct memory_block *hint)
 {
 	struct device *hintdev = hint ? &hint->dev : NULL;
@@ -604,7 +604,7 @@ static struct memory_block *find_memory_block_by_id(int block_id,
 struct memory_block *find_memory_block_hinted(struct mem_section *section,
 					      struct memory_block *hint)
 {
-	int block_id = base_memory_block_id(__section_nr(section));
+	unsigned long block_id = base_memory_block_id(__section_nr(section));
 
 	return find_memory_block_by_id(block_id, hint);
 }
@@ -663,8 +663,8 @@ int register_memory(struct memory_block *memory)
 	return ret;
 }
 
-static int init_memory_block(struct memory_block **memory, int block_id,
-			     unsigned long state)
+static int init_memory_block(struct memory_block **memory,
+			     unsigned long block_id, unsigned long state)
 {
 	struct memory_block *mem;
 	unsigned long start_pfn;
@@ -729,8 +729,8 @@ static void unregister_memory(struct memory_block *memory)
  */
 int create_memory_block_devices(unsigned long start, unsigned long size)
 {
-	const int start_block_id = pfn_to_block_id(PFN_DOWN(start));
-	int end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
+	const unsigned long start_block_id = pfn_to_block_id(PFN_DOWN(start));
+	unsigned long end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
 	struct memory_block *mem;
 	unsigned long block_id;
 	int ret = 0;
@@ -766,10 +766,10 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
  */
 void remove_memory_block_devices(unsigned long start, unsigned long size)
 {
-	const int start_block_id = pfn_to_block_id(PFN_DOWN(start));
-	const int end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
+	const unsigned long start_block_id = pfn_to_block_id(PFN_DOWN(start));
+	const unsigned long end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
 	struct memory_block *mem;
-	int block_id;
+	unsigned long block_id;
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
 			 !IS_ALIGNED(size, memory_block_size_bytes())))
-- 
2.21.0

