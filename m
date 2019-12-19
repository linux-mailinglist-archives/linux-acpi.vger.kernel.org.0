Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F9512670E
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 17:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLSQbj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 11:31:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38536 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfLSQbh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2019 11:31:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so6640327wrh.5
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2019 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0PTgEa8Z2EtxKNp+bXlU3gMIeIQMMd4dvAJJmx7ucE=;
        b=W+Iytwj4wvUZ2mbwDVM7FzjhurcQ7XEm74cJFZdKNOpWZtf7wK2eBP0X8FsMZeSJ6x
         iR0hoMFIuiITseQd974oYuP4t6sCXPRf3CBmd6yCV89pn+xP+xk+w7DoS2RBpcJj2xkt
         9hAy9ONlO9aTHj8k3D5PUqhPlRW8+9sBhjji/UXYjHTc2kU0B/rcTeoqySC1prww1Kh5
         lDK2rbNnj95q+9W/YHUT8aL/yY4xujuGQ3Gqt7+IIi+uCEaUwCmo0aNTuAmGuF4PphBE
         eH7TqxdLwqXapRzKuHr8uFQZKVtKa1+hpBYpYNgTi8ckKxL0EE66EGNi9XNuHJ5DvbFx
         fRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0PTgEa8Z2EtxKNp+bXlU3gMIeIQMMd4dvAJJmx7ucE=;
        b=tk4pL7G1w+TW0Phj+UcLT9bP66AnjrN4w3Gg3N7c+rWnPAlJKfbDFW+ku30nas3Jnv
         lEvWFbl2VzQ/HGHdXYPeq5V4l3g77Ko6IcjbnvOde/dGuThk3u7o9VK0pbEOkDjSm03q
         R1VPBTj9gZObdMBWCVnQzy9U2XUUn1K6ifnXdXGM3/4CUEEwA/6g/xefZgL2iKnC5eHW
         Oz/YkGUjtb7G4aPeXBEtabxDMkezj4zDkfeIGpiAejhR2Hp361xQrFjNrHYi2651RgcG
         AMcTDPQu2HDdNxKnXE+lvmNEkL7fFsQ4pmrq3hGrpaIj9ALg7RggQZL0tri99AAlWSe/
         SiOQ==
X-Gm-Message-State: APjAAAUrcQWARlOf3LvVxZl96ysW65vYRv2OUkOTHlAPsdAjuTv9wSeE
        z3X/fEWi+kRJKgAsJHY/3+GLXQ==
X-Google-Smtp-Source: APXvYqydpFFmYvpMjkEfbCXJIymkJAymWbp5K7XBwcoeSyvYywcmv2pSNLmPre/mfuyPhSrLgbG6Lw==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr10390218wrs.247.1576773095285;
        Thu, 19 Dec 2019 08:31:35 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:31:34 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v4 12/13] PCI/ATS: Add PASID stubs
Date:   Thu, 19 Dec 2019 17:30:32 +0100
Message-Id: <20191219163033.2608177-13-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The SMMUv3 driver, which may be built without CONFIG_PCI, will soon gain
PASID support.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PASID stubs, and avoid
adding more #ifdefs to the SMMU driver.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 5d62e78946a3..d08f0869f121 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -33,6 +33,9 @@ void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
+static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
+{ return -EINVAL; }
+static inline void pci_disable_pasid(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
 { return -EINVAL; }
 static inline int pci_max_pasids(struct pci_dev *pdev)
-- 
2.24.1

