Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB726C341
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIPN13 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 09:27:29 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55198 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgIPNYy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Sep 2020 09:24:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U97x1KA_1600260734;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U97x1KA_1600260734)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Sep 2020 20:52:14 +0800
Date:   Wed, 16 Sep 2020 20:52:14 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v4 6/8] virtio-mem: try to merge system ram resources
Message-ID: <20200916125214.GB48039@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200911103459.10306-1-david@redhat.com>
 <20200911103459.10306-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911103459.10306-7-david@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 11, 2020 at 12:34:57PM +0200, David Hildenbrand wrote:
>virtio-mem adds memory in memory block granularity, to be able to
>remove it in the same granularity again later, and to grow slowly on
>demand. This, however, results in quite a lot of resources when
>adding a lot of memory. Resources are effectively stored in a list-based
>tree. Having a lot of resources not only wastes memory, it also makes
>traversing that tree more expensive, and makes /proc/iomem explode in
>size (e.g., requiring kexec-tools to manually merge resources later
>when e.g., trying to create a kdump header).
>
>Before this patch, we get (/proc/iomem) when hotplugging 2G via virtio-mem
>on x86-64:
>        [...]
>        100000000-13fffffff : System RAM
>        140000000-33fffffff : virtio0
>          140000000-147ffffff : System RAM (virtio_mem)
>          148000000-14fffffff : System RAM (virtio_mem)
>          150000000-157ffffff : System RAM (virtio_mem)
>          158000000-15fffffff : System RAM (virtio_mem)
>          160000000-167ffffff : System RAM (virtio_mem)
>          168000000-16fffffff : System RAM (virtio_mem)
>          170000000-177ffffff : System RAM (virtio_mem)
>          178000000-17fffffff : System RAM (virtio_mem)
>          180000000-187ffffff : System RAM (virtio_mem)
>          188000000-18fffffff : System RAM (virtio_mem)
>          190000000-197ffffff : System RAM (virtio_mem)
>          198000000-19fffffff : System RAM (virtio_mem)
>          1a0000000-1a7ffffff : System RAM (virtio_mem)
>          1a8000000-1afffffff : System RAM (virtio_mem)
>          1b0000000-1b7ffffff : System RAM (virtio_mem)
>          1b8000000-1bfffffff : System RAM (virtio_mem)
>        3280000000-32ffffffff : PCI Bus 0000:00
>
>With this patch, we get (/proc/iomem):
>        [...]
>        fffc0000-ffffffff : Reserved
>        100000000-13fffffff : System RAM
>        140000000-33fffffff : virtio0
>          140000000-1bfffffff : System RAM (virtio_mem)
>        3280000000-32ffffffff : PCI Bus 0000:00
>
>Of course, with more hotplugged memory, it gets worse. When unplugging
>memory blocks again, try_remove_memory() (via
>offline_and_remove_memory()) will properly split the resource up again.
>
>Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Baoquan He <bhe@redhat.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index ed99e43354010..ba4de598f6636 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -424,7 +424,8 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
> 
> 	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
> 	return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
>-					 vm->resource_name, MHP_NONE);
>+					 vm->resource_name,
>+					 MEMHP_MERGE_RESOURCE);
> }
> 
> /*
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
