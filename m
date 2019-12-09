Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF8D1173AB
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 19:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLISMM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 13:12:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46492 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLISMK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2019 13:12:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so17177897wrl.13
        for <linux-acpi@vger.kernel.org>; Mon, 09 Dec 2019 10:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bUNvcbVur0Ef2VA51V4gsgr3fHJGR70sEezlRR2RXc=;
        b=QWVvbh0Jpp5+Hw8827sqJaAjar+vbOSxAvAj30oTykn3fZunkMM+V0TpMe8znZSIwt
         kVb7o3GmlRpgmGRwqFd9IL7O0Rr/xOSf3Ou712l2rKwvJ+ientMioZnVc1lDF91iu51I
         UHJUu2zRarBoJs8L2yoNmEOFKcoFuBaNk3ypQxZ80un+15jE6DMxi+ZjCVVZZ43p9sG2
         IBBhzFgwwrNysh5v+q2LdP7dwwQvTzT0h9awcGtfIkraKUYda6YASGA0COj5K+NLIQlU
         vc+Klj7osrnuHxQ7nzumbvGR2a/QpWUNgVCUK01W87GXIit9vGNapGS5T4f3bqCJiksT
         E9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bUNvcbVur0Ef2VA51V4gsgr3fHJGR70sEezlRR2RXc=;
        b=nJidNII0eDGIDHhLH5MHqaUgN1FOrQngIqDKwqiGXCvZCBdiSA0iWXUPRGghYGV55c
         6SEJly4hZ/GX9TJaaSqk/rIqE3ISL2IHz6OjGgyqWYmhAlkTq6gAKHExCTtocZc3XaCG
         rGv8/XsEVDN99c5Qx3PPcHIGLMiOxVUD8jR3YUv3xKMwMUdaMQrCqPyoA4LE7AgKcSfa
         A/f6HvZLpvD+CThC9a3UwqLdgkp/NtpQtIHx3ead5+tLrl0A1Wh21ySswduMOd9M/AIk
         3A+yOYfa8bCNj8hjhMmuGUW33d2K7dXdvu6xEeERhW3n6VglQxb8n3Pk83TXNj7jUGuS
         fukA==
X-Gm-Message-State: APjAAAVu/rSpVsjOITV75eOcbeVIQkJnJ/71nJAZpufVKGvRz6jsxllI
        FSsyxB0oylI0oCd/X+4BsyK7iw==
X-Google-Smtp-Source: APXvYqxZH+0s1tJzoncKkc0MLrscBtmGhCCKfuSL1rRjTgo9fxA1fKZvT0gterjHLEAe0aJZPngGUg==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr3528279wrq.37.1575915129138;
        Mon, 09 Dec 2019 10:12:09 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:12:08 -0800 (PST)
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
Subject: [PATCH v3 12/13] PCI/ATS: Add PASID stubs
Date:   Mon,  9 Dec 2019 19:05:13 +0100
Message-Id: <20191209180514.272727-13-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
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
2.24.0

