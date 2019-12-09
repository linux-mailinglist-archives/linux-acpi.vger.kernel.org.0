Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87C21173B8
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLISMN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 13:12:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51260 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfLISMK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2019 13:12:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so331590wme.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Dec 2019 10:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dS9JHQoIet3pVv6eJb9kJhT5ftY7Ua+yYZWdXaG4gzo=;
        b=jHfiTmHM4CgLf+XW4XJxxOpTyiR6rKXGw0zHau9qPm2vGLuTDtwrk1iEmqAtUcL0i1
         GsCQCDgc6hgt4m1sndQFIWIIUKcYhL3IICK4Fqklm0GGYn+i8/U2GBdcVIS7kpyJntqK
         FncR+fmMSAF2mS9jczjFGKFdm/z/keSkGM1LzIOx+yDEkmzwl+Dx3hiYEEq7n5Ta8Vlq
         ruclXWt71bhEl2VL8xVlpMVPiSsHqe3n9I6P6HD+ta2oXHF1cST8lor+yZKxe9kLQzqp
         //OPHKtrlucEqJ22vm3L1SlVRIUHcuhtXn61mRWuGRC0y+tJPOx0Fb2FHsmhDZ9xMc1r
         golg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dS9JHQoIet3pVv6eJb9kJhT5ftY7Ua+yYZWdXaG4gzo=;
        b=aWKuE+jfqnl3M1p4uh6jd0YFPT5UJE7W59QsTPJBG6cvc0//8OM49XvmYMZy0Wfphs
         Y4iMRYcpIl19kU+BYkA7KU+1mqtS7m71FhYFWa/swSEGOXm+YKMsyQarlfaCrVkNu1jU
         YG2X0anFS5jLIzadNdNKEBNNaDI+m8Ous7fqhMhzD9j8eoa01OLxIhQ7F+99h0Yb/nUw
         4/KP+UQiU+IxV7w+J+T7pHssrgVsvFZOVfAKJnuSrlzUgFqgi3sWLGSR4pjMkr0LrElO
         /HAThmOnBm1nHG5q0tX4kAcqdg9Df8ugpWVdEnmFGnmR7pVTJ+nefNX869thlmtvj7wy
         LZQA==
X-Gm-Message-State: APjAAAXjhxIpoMOfLFaxj2m6EntJoTXlqZRI94TMZvYqefURAz2VgbPN
        JJ7cBQsVX1xLDJme5lMh4+eQeA==
X-Google-Smtp-Source: APXvYqwLObPVApm61pTMGQoHPnKg/K//kDJoQJn+2j5gLjfljwmJA5TLzDgo+SfmbkrNRrb8uanIWA==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr394499wmg.66.1575915127985;
        Mon, 09 Dec 2019 10:12:07 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:12:07 -0800 (PST)
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
Subject: [PATCH v3 11/13] iommu/arm-smmu-v3: Improve add_device() error handling
Date:   Mon,  9 Dec 2019 19:05:12 +0100
Message-Id: <20191209180514.272727-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let add_device() clean up after itself. The iommu_bus_init() function
does call remove_device() on error, but other sites (e.g. of_iommu) do
not.

Don't free level-2 stream tables because we'd have to track if we
allocated each of them or if they are used by other endpoints. It's not
worth the hassle since they are managed resources.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 52adcdfda58b..d20a79108f8a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2836,14 +2836,16 @@ static int arm_smmu_add_device(struct device *dev)
 	for (i = 0; i < master->num_sids; i++) {
 		u32 sid = master->sids[i];
 
-		if (!arm_smmu_sid_in_range(smmu, sid))
-			return -ERANGE;
+		if (!arm_smmu_sid_in_range(smmu, sid)) {
+			ret = -ERANGE;
+			goto err_free_master;
+		}
 
 		/* Ensure l2 strtab is initialised */
 		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
 			ret = arm_smmu_init_l2_strtab(smmu, sid);
 			if (ret)
-				return ret;
+				goto err_free_master;
 		}
 	}
 
@@ -2853,13 +2855,25 @@ static int arm_smmu_add_device(struct device *dev)
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
+	ret = iommu_device_link(&smmu->iommu, dev);
+	if (ret)
+		goto err_free_master;
+
 	group = iommu_group_get_for_dev(dev);
-	if (!IS_ERR(group)) {
-		iommu_group_put(group);
-		iommu_device_link(&smmu->iommu, dev);
+	if (IS_ERR(group)) {
+		ret = PTR_ERR(group);
+		goto err_unlink;
 	}
 
-	return PTR_ERR_OR_ZERO(group);
+	iommu_group_put(group);
+	return 0;
+
+err_unlink:
+	iommu_device_unlink(&smmu->iommu, dev);
+err_free_master:
+	kfree(master);
+	fwspec->iommu_priv = NULL;
+	return ret;
 }
 
 static void arm_smmu_remove_device(struct device *dev)
-- 
2.24.0

