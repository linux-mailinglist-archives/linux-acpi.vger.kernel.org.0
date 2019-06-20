Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553554D943
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 20:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfFTScO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 14:32:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfFTScO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jun 2019 14:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1785475726;
        Thu, 20 Jun 2019 18:32:14 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-71.ams2.redhat.com [10.36.116.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E49CA19C5B;
        Thu, 20 Jun 2019 18:32:11 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 3/6] mm: Make register_mem_sect_under_node() static
Date:   Thu, 20 Jun 2019 20:31:36 +0200
Message-Id: <20190620183139.4352-4-david@redhat.com>
In-Reply-To: <20190620183139.4352-1-david@redhat.com>
References: <20190620183139.4352-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 18:32:14 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It is only used internally.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/node.c  | 3 ++-
 include/linux/node.h | 7 -------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 9be88fd05147..e6364e3e3e31 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -752,7 +752,8 @@ static int __ref get_nid_for_pfn(unsigned long pfn)
 }
 
 /* register memory section under specified node if it spans that node */
-int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
+static int register_mem_sect_under_node(struct memory_block *mem_blk,
+					 void *arg)
 {
 	int ret, nid = *(int *)arg;
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
diff --git a/include/linux/node.h b/include/linux/node.h
index 548c226966a2..4866f32a02d8 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -137,8 +137,6 @@ static inline int register_one_node(int nid)
 extern void unregister_one_node(int nid);
 extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
-extern int register_mem_sect_under_node(struct memory_block *mem_blk,
-						void *arg);
 extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
 
 extern int register_memory_node_under_compute_node(unsigned int mem_nid,
@@ -170,11 +168,6 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 {
 	return 0;
 }
-static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
-							void *arg)
-{
-	return 0;
-}
 static inline void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
 {
 }
-- 
2.21.0

