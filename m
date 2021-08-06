Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FDC3E2ADF
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Aug 2021 14:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbhHFMuR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 08:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343802AbhHFMsp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 08:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628254109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFeBqOXfkyt43N/bfzc7r20R6enM8cPml+FtmtRNnCk=;
        b=LemyeBI/qkzSRZ522F2ds1gkTyFVHpM3kMD7eO5Iy9jd7FXksFP/E+5OadFH6vQpyk2KEC
        eyLhtyQw59sOHEZ7iWOrh4KGK1VcFIp5WUrBASuAOmdpqBx4vU+2UfmGli4hwlYLTJ6QGG
        r9d3oezBy7jXG/Fc1vMOtsuOYAQozyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-4zB_OUpUOfiCyMBukTa9Hg-1; Fri, 06 Aug 2021 08:48:26 -0400
X-MC-Unique: 4zB_OUpUOfiCyMBukTa9Hg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4824D8042EB;
        Fri,  6 Aug 2021 12:48:24 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5B715D6A1;
        Fri,  6 Aug 2021 12:48:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 6/9] dax/kmem: use a single static memory group for a single probed unit
Date:   Fri,  6 Aug 2021 14:47:12 +0200
Message-Id: <20210806124715.17090-7-david@redhat.com>
In-Reply-To: <20210806124715.17090-1-david@redhat.com>
References: <20210806124715.17090-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Although dax/kmem users often disable auto-onlining and instead online
memory manually (usually to ZONE_MOVABLE), there is still value in
having auto-onlining be aware of the relationship of memory blocks.

Let's treat one probed unit as a single static memory device, similar to
a single ACPI memory device.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/dax/kmem.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 99e0f60c4c26..a37622060fff 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -37,15 +37,16 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 
 struct dax_kmem_data {
 	const char *res_name;
+	int mgid;
 	struct resource *res[];
 };
 
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
+	unsigned long total_len = 0;
 	struct dax_kmem_data *data;
-	int rc = -ENOMEM;
-	int i, mapped = 0;
+	int i, rc, mapped = 0;
 	int numa_node;
 
 	/*
@@ -61,24 +62,44 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range range;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc) {
+			dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
+					i, range.start, range.end);
+			continue;
+		}
+		total_len += range_len(&range);
+	}
+
+	if (!total_len) {
+		dev_warn(dev, "rejecting DAX region without any memory after alignment\n");
+		return -EINVAL;
+	}
+
 	data = kzalloc(struct_size(data, res, dev_dax->nr_range), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	rc = -ENOMEM;
 	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
 	if (!data->res_name)
 		goto err_res_name;
 
+	rc = memory_group_register_static(numa_node, total_len);
+	if (rc < 0)
+		goto err_reg_mgid;
+	data->mgid = rc;
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct resource *res;
 		struct range range;
 
 		rc = dax_kmem_range(dev_dax, i, &range);
-		if (rc) {
-			dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
-					i, range.start, range.end);
+		if (rc)
 			continue;
-		}
 
 		/* Region is permanently reserved if hotremove fails. */
 		res = request_mem_region(range.start, range_len(&range), data->res_name);
@@ -108,8 +129,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		 * Ensure that future kexec'd kernels will not treat
 		 * this as RAM automatically.
 		 */
-		rc = add_memory_driver_managed(numa_node, range.start,
-				range_len(&range), kmem_name, MHP_NONE);
+		rc = add_memory_driver_managed(data->mgid, range.start,
+				range_len(&range), kmem_name, MHP_NID_IS_MGID);
 
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
@@ -129,6 +150,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	return 0;
 
 err_request_mem:
+	memory_group_unregister(data->mgid);
+err_reg_mgid:
 	kfree(data->res_name);
 err_res_name:
 	kfree(data);
@@ -171,6 +194,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 	}
 
 	if (success >= dev_dax->nr_range) {
+		memory_group_unregister(data->mgid);
 		kfree(data->res_name);
 		kfree(data);
 		dev_set_drvdata(dev, NULL);
-- 
2.31.1

