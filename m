Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E07815C8AC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 17:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgBMQwL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 11:52:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36299 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgBMQwL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Feb 2020 11:52:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so7551938wma.1
        for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2020 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQbvHTAFoAU5RHLdLgupX/fENQ0mj2n5jeDSVw5UmQU=;
        b=vb+Tx4YPjuXKC+c6jky2UOwKA2GKWNy9qTjZE2ccpnmXF3+xctohVChy1RbIW9obB9
         T5Dve49ZEZiff4UfFfbZ1i2aUZzg4V2o2NTC/rqi2aeTWg6t7vgUSnfI6pPcZ63ljaYq
         1jksjGTZuLzEXRfpEum+ObMhOmrPcw67ATU4rmbyzt5qncORgsTJtboZDSrixLiU39r6
         d4FHVn+XQpd4hHLF6Mvwomwy2xBIomvAvWxjfaz/xaLo4n269iAJR7AQZt6hs6TqCjTJ
         7XxeEJhZ/HsAQQ6e2wKmcrt0h5oWxjRhU48DgNeKFQNSppeWzcoCSrf/Y/j58wqyrVxo
         Cviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQbvHTAFoAU5RHLdLgupX/fENQ0mj2n5jeDSVw5UmQU=;
        b=hV0OGq2GLb4NmO6+GMTPXvO7AwSiHl5oTsEgrtEkTt/IoDumKplMdSTLlhNe1s7r4d
         nqQefuG9FruQ8RJ12EtSlTRMSLHzgq9iIM5RQJAB08gn75waMf3H5t4BVDXRZlb7Dz3Q
         z2C9IedVOpHwUjkcyYPJ5vJPxYCxTzzKEzyq6Lu99tf0W53dNTQ+evKfTJjFkypq2dx1
         F8f+QNwO7Wz5hGStTXr4aoukviirFQ7IRiNzRPzLk3UvXtVrD+Zcm9XBRmN4KfxlLVjH
         QQfzk43px4xZY90L2k8R4zVzYPbZlWVcC2ypkzhVmDEHFmyoNnxXguz7kBNgu3/oCB76
         Jq5g==
X-Gm-Message-State: APjAAAURGU/t5BSC5m61GV7C22+FWtp6TWz8VOHmsVAgl9pPg6IvYZOD
        XrxhmLyI0NqAxih26u9fJPF2Pg==
X-Google-Smtp-Source: APXvYqw/HW+Dcw12NoCQYY4ILhwP9Zxgh/zKxvP8cCtRxWLv/EO4gTZlVf5WfvykVkAwV5DQqK1Qkw==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr6747949wmg.103.1581612729610;
        Thu, 13 Feb 2020 08:52:09 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:52:09 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: [PATCH 05/11] PCI/ATS: Gather checks into pci_ats_supported()
Date:   Thu, 13 Feb 2020 17:50:43 +0100
Message-Id: <20200213165049.508908-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

IOMMU drivers need to perform several tests when checking if a device
supports ATS.  Move them all into a new function that returns true when
a device and its host bridge support ATS.

Since pci_enable_ats() now calls pci_ats_supported(), the following
new checks are now common:
* whether a device is trusted.  Devices plugged into external-facing
  ports such as thunderbolt are untrusted.
* whether the host bridge supports ATS, which defaults to true unless
  the firmware description states that ATS isn't supported by the host
  bridge.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c       | 30 +++++++++++++++++++++++++++++-
 include/linux/pci-ats.h |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 390e92f2d8d1..bbfd0d42b8b9 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -30,6 +30,34 @@ void pci_ats_init(struct pci_dev *dev)
 	dev->ats_cap = pos;
 }
 
+/**
+ * pci_ats_supported - check if the device can use ATS
+ * @dev: the PCI device
+ *
+ * Returns true if the device supports ATS and is allowed to use it, false
+ * otherwise.
+ */
+bool pci_ats_supported(struct pci_dev *dev)
+{
+	struct pci_host_bridge *bridge;
+
+	if (!dev->ats_cap)
+		return false;
+
+	if (dev->untrusted)
+		return false;
+
+	bridge = pci_find_host_bridge(dev->bus);
+	if (!bridge)
+		return false;
+
+	if (!bridge->ats_supported)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_ats_supported);
+
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device
@@ -42,7 +70,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	u16 ctrl;
 	struct pci_dev *pdev;
 
-	if (!dev->ats_cap)
+	if (!pci_ats_supported(dev))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index d08f0869f121..f75c307f346d 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -6,11 +6,14 @@
 
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
+bool pci_ats_supported(struct pci_dev *dev);
 int pci_enable_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
 #else /* CONFIG_PCI_ATS */
+static inline bool pci_ats_supported(struct pci_dev *d)
+{ return false; }
 static inline int pci_enable_ats(struct pci_dev *d, int ps)
 { return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
-- 
2.25.0

