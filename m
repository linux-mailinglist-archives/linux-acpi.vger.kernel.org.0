Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430EA3D3AA1
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jul 2021 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhGWMNK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Jul 2021 08:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235127AbhGWMNJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Jul 2021 08:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627044823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyJyx55HAmoGVAJ3/fwHgQgmTxMahZRdR8vu+clKwGM=;
        b=gjc+ekUe44cinQYzvuv6abGd225c4brtO13Ai/Oa9XauyAsVEus52/f6EZYBA6H62DLFz4
        uwgMdmqjVR5pRGKmIhGtQpnJmq47stOls7O4njGli4KG29byzdPHAcQNf5nxCKp1oEWZ8o
        ZqzKnhVEUuLy+oZqrjLUx6DG2bVuoGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-2kvrrxK9Pty_ACU86rb3_w-1; Fri, 23 Jul 2021 08:53:42 -0400
X-MC-Unique: 2kvrrxK9Pty_ACU86rb3_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA25B801AE3;
        Fri, 23 Jul 2021 12:53:39 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-253.ams2.redhat.com [10.36.112.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9ED051C63;
        Fri, 23 Jul 2021 12:53:29 +0000 (UTC)
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
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 7/9] virtio-mem: use a single dynamic memory group for a single virtio-mem device
Date:   Fri, 23 Jul 2021 14:52:08 +0200
Message-Id: <20210723125210.29987-8-david@redhat.com>
In-Reply-To: <20210723125210.29987-1-david@redhat.com>
References: <20210723125210.29987-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let's use a single dynamic memory group.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 774986695dc4..19036922f7ef 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -143,6 +143,8 @@ struct virtio_mem {
 	 * add_memory_driver_managed().
 	 */
 	const char *resource_name;
+	/* Memory group identification. */
+	int mgid;
 
 	/*
 	 * We don't want to add too much memory if it's not getting onlined,
@@ -626,8 +628,8 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
 		addr + size - 1);
 	/* Memory might get onlined immediately. */
 	atomic64_add(size, &vm->offline_size);
-	rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
-				       MHP_MERGE_RESOURCE);
+	rc = add_memory_driver_managed(vm->mgid, addr, size, vm->resource_name,
+				       MHP_MERGE_RESOURCE | MHP_NID_IS_MGID);
 	if (rc) {
 		atomic64_sub(size, &vm->offline_size);
 		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
@@ -2562,6 +2564,7 @@ static bool virtio_mem_has_memory_added(struct virtio_mem *vm)
 static int virtio_mem_probe(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm;
+	uint64_t unit_pages;
 	int rc;
 
 	BUILD_BUG_ON(sizeof(struct virtio_mem_req) != 24);
@@ -2596,6 +2599,16 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	if (rc)
 		goto out_del_vq;
 
+	/* use a single dynamic memory group to cover the whole memory device */
+	if (vm->in_sbm)
+		unit_pages = PHYS_PFN(memory_block_size_bytes());
+	else
+		unit_pages = PHYS_PFN(vm->bbm.bb_size);
+	rc = register_dynamic_memory_group(vm->nid, unit_pages);
+	if (rc < 0)
+		goto out_del_resource;
+	vm->mgid = rc;
+
 	/*
 	 * If we still have memory plugged, we have to unplug all memory first.
 	 * Registering our parent resource makes sure that this memory isn't
@@ -2610,7 +2623,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	vm->memory_notifier.notifier_call = virtio_mem_memory_notifier_cb;
 	rc = register_memory_notifier(&vm->memory_notifier);
 	if (rc)
-		goto out_del_resource;
+		goto out_unreg_group;
 	rc = register_virtio_mem_device(vm);
 	if (rc)
 		goto out_unreg_mem;
@@ -2624,6 +2637,8 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	return 0;
 out_unreg_mem:
 	unregister_memory_notifier(&vm->memory_notifier);
+out_unreg_group:
+	unregister_memory_group(vm->mgid);
 out_del_resource:
 	virtio_mem_delete_resource(vm);
 out_del_vq:
@@ -2688,6 +2703,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	} else {
 		virtio_mem_delete_resource(vm);
 		kfree_const(vm->resource_name);
+		unregister_memory_group(vm->mgid);
 	}
 
 	/* remove all tracking data - no locking needed */
-- 
2.31.1

