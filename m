Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278D718189E
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Mar 2020 13:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgCKMrI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Mar 2020 08:47:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37601 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgCKMrF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2020 08:47:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id a141so1973356wme.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2020 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfMBk8SLNbiqvSQTKNw5nVOwT2ukh4ZsyZ4CcWYi0pU=;
        b=kGuexoqbuQJZfLJ6IRVhdgqXT2Li0ISoLXz0HBfWDMtpencXONYJHfL5BMvcPqfGns
         KTLe7/XryQ8otcvTvvBmXsfwat0eWTcx2+S3AY+1GUovN8spX6q7o2ijMrTUu5CI7XZi
         sXSmXpsBNPqNuYtOOjN0yT9WFBfYw8z72+I3JHP780/sn1m+qnJhj57OTTCF5Rl7VNbI
         I7+Cx38sOpBfHpJyAtHR0EJE+EL+xYVzqLpK9UKTABDAepAg9uvq1mm+y1d2lHqjsV/o
         5qIAXn96SgCfw69yQzALEut3rCN9yVu46I16Uc8TUdhIIoc5YfzmjtVW8PyrVvwzibNe
         fBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfMBk8SLNbiqvSQTKNw5nVOwT2ukh4ZsyZ4CcWYi0pU=;
        b=a64E3E74H2ab+HeGc+lXTq7pzjmhlrZuDgDN7PG/xNICs04aRsV/avVMCxkwMxKwcY
         wXjyOrzownj741q9dIMU46jy1K8Xpo3SNL8xJzIdkJEonJps3wO/l3YOJN1F/joInlwY
         Ua+nLLisBTsM2fvX3aibVYH+Rn85sGLJCDpehCKsb/W28HvDDyPjHQCgwp+qIgmU6LwO
         Inl/1DgIfQj6yPbeNldNm+vHYxPS2N5iYgFa+nV/L0sUY6M0O+l6L62mvM9MyVCAswUJ
         /l958BBZ/Uc0/Vtvvaf4C8RKg868U4DZkyIDAxM9eKJeH2dT+gDODEDXnCIoifIOWKuJ
         p/ug==
X-Gm-Message-State: ANhLgQ3rlfSAdXBhSd3bQgEw4CaFEt1gQtF+F4Q8KOCSvMKrmVO9DlOR
        I0H9X9wBXonInzHgnlG8EmovSA==
X-Google-Smtp-Source: ADFU+vtntOL4brDxmDQGG6xeJrIuadRvitxT9k9QnLoTDiM4xzqU981cVjB7SKKNNlkYOG+EtlWXJA==
X-Received: by 2002:a1c:5443:: with SMTP id p3mr3479986wmi.149.1583930823712;
        Wed, 11 Mar 2020 05:47:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:47:03 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        joro@8bytes.org, baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 07/11] iommu/arm-smmu-v3: Use pci_ats_supported()
Date:   Wed, 11 Mar 2020 13:45:02 +0100
Message-Id: <20200311124506.208376-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The new pci_ats_supported() function checks if a device supports ATS and
is allowed to use it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4f0a38dae6db..87ae31ef35a1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2592,26 +2592,14 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	}
 }
 
-#ifdef CONFIG_PCI_ATS
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
-	struct pci_dev *pdev;
+	struct device *dev = master->dev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
-
-	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
-	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
-		return false;
 
-	pdev = to_pci_dev(master->dev);
-	return !pdev->untrusted && pdev->ats_cap;
+	return (smmu->features & ARM_SMMU_FEAT_ATS) && dev_is_pci(dev) &&
+		pci_ats_supported(to_pci_dev(dev));
 }
-#else
-static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
-{
-	return false;
-}
-#endif
 
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
-- 
2.25.1

