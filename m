Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6855B3D3A9B
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jul 2021 14:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhGWMMx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Jul 2021 08:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235126AbhGWMMx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Jul 2021 08:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627044806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BNdBLLGlA2PZ1Ey+ERvbMpf7L4Iuikq21FXsWIbZe4=;
        b=ZQVpXs9BqJ7tOzMGCgu1bgSQ9pXGldOjNTufABQUhmnTMoQKsVa0giiPdxY9Yxo0GMFbdP
        6fXRiWOIHJ/0XUIrz0ngWbcM3lpk16uFCvyxg1dF/cTjuqcL1Lyb+Tq31uFrcpzEQney+0
        0+sLdqvK/OTW4BgtpUcwXqlBsms5AJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-1jvXxHdAOqmTb9x-yvVd_g-1; Fri, 23 Jul 2021 08:53:24 -0400
X-MC-Unique: 1jvXxHdAOqmTb9x-yvVd_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 269611B18BC3;
        Fri, 23 Jul 2021 12:53:22 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-253.ams2.redhat.com [10.36.112.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CCB83AC1;
        Fri, 23 Jul 2021 12:53:06 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
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
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 5/9] ACPI: memhotplug: use a single static memory group for a single memory device
Date:   Fri, 23 Jul 2021 14:52:06 +0200
Message-Id: <20210723125210.29987-6-david@redhat.com>
In-Reply-To: <20210723125210.29987-1-david@redhat.com>
References: <20210723125210.29987-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let's group all memory we add for a single memory device - we want a
single node for that (which also seems to be the sane thing to do).

We won't care for now about memory that was already added to the system
(e.g., via e820) -- usually *all* memory of a memory device was already
added and we'll fail acpi_memory_enable_device().

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/acpi_memhotplug.c | 35 +++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index eb4faf7c5cad..0ffa3db142a1 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -54,6 +54,7 @@ struct acpi_memory_info {
 struct acpi_memory_device {
 	struct acpi_device *device;
 	struct list_head res_list;
+	int mgid;
 };
 
 static acpi_status
@@ -169,12 +170,33 @@ static void acpi_unbind_memory_blocks(struct acpi_memory_info *info)
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
 	acpi_handle handle = mem_device->device->handle;
+	mhp_t mhp_flags = MHP_NID_IS_MGID;
 	int result, num_enabled = 0;
 	struct acpi_memory_info *info;
-	mhp_t mhp_flags = MHP_NONE;
-	int node;
+	u64 total_length = 0;
+	int node, mgid;
 
 	node = acpi_get_node(handle);
+
+	list_for_each_entry(info, &mem_device->res_list, list) {
+		if (!info->length)
+			continue;
+		/* We want a single node for the whole memory group */
+		if (node < 0)
+			node = memory_add_physaddr_to_nid(info->start_addr);
+		total_length += info->length;
+	}
+
+	if (!total_length) {
+		dev_err(&mem_device->device->dev, "device is empty\n");
+		return -EINVAL;
+	}
+
+	mgid = register_static_memory_group(node, PFN_UP(total_length));
+	if (mgid < 0)
+		return mgid;
+	mem_device->mgid = mgid;
+
 	/*
 	 * Tell the VM there is more memory here...
 	 * Note: Assume that this function returns zero on success
@@ -188,12 +210,10 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		 */
 		if (!info->length)
 			continue;
-		if (node < 0)
-			node = memory_add_physaddr_to_nid(info->start_addr);
 
 		if (mhp_supports_memmap_on_memory(info->length))
 			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
-		result = __add_memory(node, info->start_addr, info->length,
+		result = __add_memory(mgid, info->start_addr, info->length,
 				      mhp_flags);
 
 		/*
@@ -253,6 +273,10 @@ static void acpi_memory_device_free(struct acpi_memory_device *mem_device)
 	if (!mem_device)
 		return;
 
+	/* In case we succeeded adding *some* memory, unregistering fails. */
+	if (mem_device->mgid >= 0)
+		unregister_memory_group(mem_device->mgid);
+
 	acpi_memory_free_device_resources(mem_device);
 	mem_device->device->driver_data = NULL;
 	kfree(mem_device);
@@ -273,6 +297,7 @@ static int acpi_memory_device_add(struct acpi_device *device,
 
 	INIT_LIST_HEAD(&mem_device->res_list);
 	mem_device->device = device;
+	mem_device->mgid = -1;
 	sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
 	sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
 	device->driver_data = mem_device;
-- 
2.31.1

