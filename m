Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E2F4F8B
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfKHP07 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Nov 2019 10:26:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42675 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKHP07 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Nov 2019 10:26:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so7470391wrf.9
        for <linux-acpi@vger.kernel.org>; Fri, 08 Nov 2019 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjGV9dHEsXE/CXRMwyPeo6zW+qyz6ot3r0JcxY8EA5E=;
        b=Stc/zRTgvuJV42ldqRHlqe8DkziQ/xZI3K/M//32mxdJaRU1jz2L5/fMxZ1QFhpcGb
         EvSLry3iFu8329VB2GuTsvuMtRKQtUr6NhZe+OfFoUtq8NdYCPynlIwHbw/GjFUbmRC+
         H6gal8DBpakRVo3SnhTJfseRLFp1XqfFkb3D3NUiwdPCcqFJAIgPj+gGr6Z9Up4EP+4P
         8+Ut1quAnJxAurGbZKQH/VrQGWCWm7la8zmxc89J8tDCxR4MRqdAj9qnVky2l9P/QGSc
         7hQrDyjXx2qQgCLFiaNFaKInDn2CY6ehhHcEYqTjArSQZFKJgu0xbSGyle/kTSvYSm0a
         jagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjGV9dHEsXE/CXRMwyPeo6zW+qyz6ot3r0JcxY8EA5E=;
        b=BHi2CJQNI7rAMZkNys27BykMQGTIKaWaUEVx3YCRWT37+cMN5taLbb2I7oSnTyxwhf
         MCIDQ4m3XN402uVz0Rk9/1+R1KGVQ2k3ZpBsrxpAQD+xSYXqaq2PWr7jsw42qnET0kba
         +flyZhu+gnah8ehZ8etBNazI4MzorG6GRbWB4KSGy3kLh5dUYt3cb+MtWFbhD+7IVfsZ
         CD8i3O8I86C2BzsAmVkA12Vgq7uWggtFjSMHauZbsTgfghAkLCVSzW8zxZnHWMp7Mp3+
         0qlinvX5QA0fAYSG0uHkIEO0TXwP6CgqK1WW0jpoMV8browSmXiW8KzQRUfWNmiZb3KI
         mnJw==
X-Gm-Message-State: APjAAAVa8KI4dxcG9o3gfSRfXvYYj/ymlt5SeWx0g8q3GH8cGnubPFn0
        6mTB/nWpxqwzcB6Pbn3F3fnB8g==
X-Google-Smtp-Source: APXvYqyYxAoUhXJzLGprymri1AM4kybRhlq/Xshi8NVcy8x0x8VatgjfP55PcG/0utxa9PrTdLVdag==
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr9845340wrt.260.1573226817077;
        Fri, 08 Nov 2019 07:26:57 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id w18sm6579232wrp.31.2019.11.08.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:26:56 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com, jonathan.cameron@huawei.com
Subject: [PATCH v2 8/8] iommu/arm-smmu-v3: Add support for PCI PASID
Date:   Fri,  8 Nov 2019 16:25:08 +0100
Message-Id: <20191108152508.4039168-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Enable PASID for PCI devices that support it. Since the SSID tables are
allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
arm_smmu_dev_feature_enable() would be too late, since by that time the
main DMA domain has already been attached. Do it in add_device() instead.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 51 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 88ec0bf33492..3ee313c08325 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2633,6 +2633,49 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
+static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
+{
+	int ret;
+	int features;
+	int num_pasids;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+
+	features = pci_pasid_features(pdev);
+	if (features < 0)
+		return -ENOSYS;
+
+	num_pasids = pci_max_pasids(pdev);
+	if (num_pasids <= 0)
+		return -ENOSYS;
+
+	ret = pci_enable_pasid(pdev, features);
+	if (!ret)
+		master->ssid_bits = min_t(u8, ilog2(num_pasids),
+					  master->smmu->ssid_bits);
+	return ret;
+}
+
+static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->pasid_enabled)
+		return;
+
+	master->ssid_bits = 0;
+	pci_disable_pasid(pdev);
+}
+
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
@@ -2841,13 +2884,16 @@ static int arm_smmu_add_device(struct device *dev)
 
 	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
 
+	/* Note that PASID must be enabled before, and disabled after ATS */
+	arm_smmu_enable_pasid(master);
+
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
 	ret = iommu_device_link(&smmu->iommu, dev);
 	if (ret)
-		goto err_free_master;
+		goto err_disable_pasid;
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
@@ -2860,6 +2906,8 @@ static int arm_smmu_add_device(struct device *dev)
 
 err_unlink:
 	iommu_device_unlink(&smmu->iommu, dev);
+err_disable_pasid:
+	arm_smmu_disable_pasid(master);
 err_free_master:
 	kfree(master);
 	fwspec->iommu_priv = NULL;
@@ -2880,6 +2928,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_disable_pasid(master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
-- 
2.23.0

