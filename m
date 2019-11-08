Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2825F4F7E
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 16:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKHP0w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Nov 2019 10:26:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54858 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKHP0w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Nov 2019 10:26:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id z26so6579161wmi.4
        for <linux-acpi@vger.kernel.org>; Fri, 08 Nov 2019 07:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+aAa3kHo6X36UARQ/hBD+CYIStSC9Mwak+bAj3lpxxM=;
        b=rk9za0j+DjrBF+nEQLw0UeApqKkWBCvgDbUXpotyR3WcOdSZUdqJemsRAUO0+HTGL1
         GUNs7bt4UgSxiL6f3ok4bdNmEamSc9EHDrNjbCyOo0oxmj2VNzcujqfH6kFCFjfZ1jQt
         hks2xi69COXdeSg2aAH4ow5jW7bVQgVZrQTOC+OPqBNFj6FssCrQTeUkL6YYO5NilsTS
         /qQBGPNk10VAvkFNz87SS5aKQnT2uWXfhGs90RxNw+Ls/MQBN9vtyfWpRtTWyVnn4706
         4oAPI5kC4UaL+xz9ryj+/AzkP48rL4NOmp9fynAASOANWZvjDBAghHTT1yBZyxAtJnha
         iLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+aAa3kHo6X36UARQ/hBD+CYIStSC9Mwak+bAj3lpxxM=;
        b=Amj0z7VB7+/Kp7AP1LsdLkprkqV5yrcbg0rSA9DoteS1Bw9erjeLJcOxCthsXemuVV
         Jy04Qk0bSEbE2q9Ii2DDYdNfXfEs4h781nVDHrNrXgHxafhfgq8Mw1AFgDc8Z5YVmMMF
         McVi7vFK8K06DHrkjRooxPouNC8+okFg83PIh6ZOWAXdZTZdfylxAD15tdWTqrIfFlbq
         Ixx6j3jWY6aShGfZwmw9o0lceyXPpMPzv3jivIX0H8i/tZkVXgo5xiF95R0umSG/ukQc
         G7Adz4o5d2M0FqlfvyNID3JlE7uxmRn1Me4y2Vy42o8OeOWbpIB0zoDrWY+0T6xQjlBM
         qqJg==
X-Gm-Message-State: APjAAAWb+0G30IPaVicFILxFlb9/uDeVlaj4uyrBVoYalC/mWWFpIZF6
        wzHLVR/KHPmKlgyvdYVtiLA7uw==
X-Google-Smtp-Source: APXvYqyP1ODYLZACcAlafYthBHeI8vIQSuj7rdAG2X/KmYtzbQ1YGd6y/fT9+gj0hKuehN6KSufekQ==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr8658213wmc.157.1573226810884;
        Fri, 08 Nov 2019 07:26:50 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id w18sm6579232wrp.31.2019.11.08.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:26:50 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com, jonathan.cameron@huawei.com
Subject: [PATCH v2 3/8] ACPI/IORT: Support PASID for platform devices
Date:   Fri,  8 Nov 2019 16:25:03 +0100
Message-Id: <20191108152508.4039168-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Named component nodes in the IORT tables describe the number of
Substream ID bits (aka. PASID) supported by the device. Propagate this
value to the fwspec structure in order to enable PASID for platform
devices.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 5a7551d060f2..9aebb180744f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt)	"ACPI: IORT: " fmt
 
 #include <linux/acpi_iort.h>
+#include <linux/bitfield.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -924,6 +925,20 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return iort_iommu_xlate(info->dev, parent, streamid);
 }
 
+static void iort_named_component_init(struct device *dev,
+				      struct acpi_iort_node *node)
+{
+	struct acpi_iort_named_component *nc;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec)
+		return;
+
+	nc = (struct acpi_iort_named_component *)node->node_data;
+	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+					   nc->node_flags);
+}
+
 /**
  * iort_iommu_configure - Set-up IOMMU configuration for a device.
  *
@@ -978,6 +993,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 			if (parent)
 				err = iort_iommu_xlate(dev, parent, streamid);
 		} while (parent && !err);
+
+		if (!err)
+			iort_named_component_init(dev, node);
 	}
 
 	/*
-- 
2.23.0

