Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB395106F86
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 12:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfKVKvI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 05:51:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44406 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfKVKvH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2019 05:51:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so7991587wrn.11
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2019 02:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDs5y1/lUK+eWeeJx//ERXKdVvxWdj4EMLwCwstQME4=;
        b=tZrmxDqsZ1RxyI07RNeundpwyg3krx2pcdHCNpZvL3eVD3KsQ239cK0WPxnijQt1Sx
         Fs/hoURodhjYShc3UsRO8wvWP3TJghstOvwU0hqvTLFGlHfjPbK+N8DC9RWKjJr0OSfG
         U8/SeO0cY0wZsBiqU23iCYDvR8R/mftguKFjWVo1gq4EDGNowS6VNXbBbPpDaZ6ANKju
         QvHqIx0HkGQc9XfDWtkRsWeWzQvhDGRGubK/9H01T5zo/uIfdNyzFvyaivP26qcnRGV1
         2W+UM6kD51rYLCCVA698kX5jZc+fgUZ9zv8aIXlsnfVKBPQMWGC6BGoWZw80BqSyjx13
         75PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDs5y1/lUK+eWeeJx//ERXKdVvxWdj4EMLwCwstQME4=;
        b=mhQ4X9SERdSTyd/zhWX2q2QCkiS53r/m7oXKUTX4mKuTCofCy+8vMHglsQj/3vDZyc
         3djiJ2Fz09W3PfNdxvCtrTEvGxkzubjUR36gJ7qNe5oAg+CNKjuvdbbzvWbuK82Jc82A
         1UuZlibTskT2VSrAoGzFecZk+dV8yKmWgsvMN+A7pEe4Tt+gqckgfctEV8LF+R2K4S3l
         lfKHHxyQiprVEy9QXIopjtGAXhG5KL2BtL8AeGAfBLM4oBRBjUvR9NuAdj3KvqbvN2EP
         bCbvW95bCXeI1cPm3eZ0woToTsr6QpbB6VmEyUvVuziMKMUo8WJWvaywrZlertgtt9Vu
         x3+A==
X-Gm-Message-State: APjAAAW4xJGTis55ro/TsHQpVKVQLdAdv/uSxa+ksH1ZFxOPU6T+8Y+u
        mVQ2BFHr/KpXe7sZUAxm6pQU6OICOes=
X-Google-Smtp-Source: APXvYqz63MumbBUd6GIRd7d2nXdQzJtqYQvwS0Q1xjmH0yv+JY/99rcdr1f7XN3ibul7iFA5Jzo61w==
X-Received: by 2002:adf:9f43:: with SMTP id f3mr17102828wrg.76.1574419864067;
        Fri, 22 Nov 2019 02:51:04 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:51:03 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: [RFC 10/13] iommu/virtio: Update IORT fwnode
Date:   Fri, 22 Nov 2019 11:49:57 +0100
Message-Id: <20191122105000.800410-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When the virtio-iommu uses the PCI transport and the topology is
described with IORT, register the PCI fwnode with IORT.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 8efa368134c0..9847552faecc 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi_iort.h>
 #include <linux/amba/bus.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
@@ -989,6 +990,8 @@ static int viommu_set_fwnode(struct viommu_dev *viommu)
 		set_primary_fwnode(dev, fwnode);
 	}
 
+	/* Tell IORT about a PCI device's fwnode */
+	iort_iommu_update_fwnode(dev, dev->fwnode);
 	iommu_device_set_fwnode(&viommu->iommu, dev->fwnode);
 	return 0;
 }
@@ -1000,6 +1003,8 @@ static void viommu_clear_fwnode(struct viommu_dev *viommu)
 	if (!dev->fwnode)
 		return;
 
+	iort_iommu_update_fwnode(dev, NULL);
+
 	if (is_software_node(dev->fwnode)) {
 		struct fwnode_handle *fwnode = dev->fwnode;
 
-- 
2.24.0

