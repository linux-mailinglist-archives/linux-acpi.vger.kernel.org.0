Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328A118189B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Mar 2020 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgCKMrI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Mar 2020 08:47:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52628 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbgCKMrI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2020 08:47:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id 11so1941313wmo.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2020 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyt9EDLxonGbKc5hM6CKEH9sOA1tej8/GhDoeiFUKak=;
        b=ncgLdDhr1gsVmIKw0dva+fqrHBQurcK9VYJtWgeUva4PerBGhsr2pO3ugJ/2qoFzaL
         hJ4cpZqdwse98rHFRyhh1g1lpITEsUbmEXhQo14D6537GZNYohNkAXM780pcNZSb6KAY
         6YqQE0NBgJonQ1nQlVKvn8bzE+AGBtBekekgeJreU6AC+TPDfd2fFmNjvuSWoHZX43Ry
         ycWRsDcIClqWML7JkEMoUZWYnKJQj1wPDd/+M0iMm5rk9co3czS3fC1sA0RLqEeZboYU
         T6doJ9QG51osk860+l0/4JjAXGMjw8oJNmZwtUNWzuT4CqYVbatdc707pG60eCDpap2S
         DLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyt9EDLxonGbKc5hM6CKEH9sOA1tej8/GhDoeiFUKak=;
        b=KBjUmxot7oeSpavfRCJA+fMqM57VdLOltYfI3DywIPD7WKT4iTrVhbZpIs24ds6KbH
         vNsUbgK7m2MYSmDXB/4dl8zCbNQ+xTc7jgzRus4hjIYeZNt7XSoQZNbsKGvP4RTQCM3z
         diXMYIzQU+8MqhAQnk+g44mRBFM3SzwpEnR5QFFQhEOS5fhzk68CTcxO8vxglbafrqae
         XfmHMfw2Vj9BKN/H76QDw2CKnVAKmK0Q/VKGwdd6vB9DtBbrMdjt5skje4g7yIMQskrV
         6LSYfNlja2nunEe99D2UX3xXpzH8NMYfEgX2ZqBXQctK3aclo7E5vMwbuGv5+0obgaPX
         djeA==
X-Gm-Message-State: ANhLgQ34oR97i0WIwQ9IHJi8BVvugaULUZCF63qyvDnz9FoNXS+qUWwi
        wrGOl0K4WV7hrCd/uA7l1M0OqA==
X-Google-Smtp-Source: ADFU+vuoGCMDLfkq5/GJN/4qTM7pYDQ3Wyic8sIgmIFqGMqHRI8BaekbHLoblPdIpK3Uqq6CChtTAg==
X-Received: by 2002:a1c:a908:: with SMTP id s8mr3841957wme.133.1583930825087;
        Wed, 11 Mar 2020 05:47:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:47:04 -0700 (PDT)
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
Subject: [PATCH v2 08/11] iommu/vt-d: Use pci_ats_supported()
Date:   Wed, 11 Mar 2020 13:45:03 +0100
Message-Id: <20200311124506.208376-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pci_ats_supported() function checks if a device supports ATS and is
allowed to use it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/intel-iommu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6fa6de2b6ad5..17208280ef5c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1454,8 +1454,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
 		info->pri_enabled = 1;
 #endif
-	if (!pdev->untrusted && info->ats_supported &&
-	    pci_ats_page_aligned(pdev) &&
+	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
@@ -2611,10 +2610,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
 
-		if (!pdev->untrusted &&
-		    !pci_ats_disabled() &&
-		    ecap_dev_iotlb_support(iommu->ecap) &&
-		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
+		if (ecap_dev_iotlb_support(iommu->ecap) &&
+		    pci_ats_supported(pdev) &&
 		    dmar_find_matched_atsr_unit(pdev))
 			info->ats_supported = 1;
 
-- 
2.25.1

