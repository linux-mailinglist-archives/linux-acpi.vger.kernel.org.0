Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6961126708
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfLSQbh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 11:31:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLSQbg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2019 11:31:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so6084225wmj.5
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2019 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=en1Diu3sI6Wm13W9qcASbGXcjcSPf5WXodRzGlHYYvg=;
        b=dgEdguI1vFCV7YNVUg0oEi5hoedAB5SCo0EHqrgrYN2fDZQP1jM0e2gVFmXjAsarm9
         sE3jEiVBfo9bIxoraETghmWio/hExZaK0G2MlaAUWWPlH/s/lgj8y2aPluLIJwIiWDO5
         nPCsL9EFTnWUXXPdeHMf2mqD8ncvbLtOVcjLDDmK20sqR/zY19gWGF0iPqJMOqrpBHzU
         P5l5nDoT+24rRDoL/bDgoMasOpqDS3TpLXI4nHsZ6shxvb0a59G2E8TD5mPZoPT7AZm0
         TE/nR/n+4AfO7nup111L94qgV7A8exhXah9vnGXYO9tpJuoHYa73upM3pfuz8aU4XUjD
         EyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=en1Diu3sI6Wm13W9qcASbGXcjcSPf5WXodRzGlHYYvg=;
        b=UDNHGS9vvPHVsTC7fNX7dOLJ/eM0R3LTm1bRBiXLefibm00IKcSdQZZ4RM8IlaTrKx
         Zx3Ykl1n6hmJJ9kw9VrU6hJ+2AWjJ0QIuG/XS9O/phdhIDOon5KKWLCZ9bE403ZKnMP5
         /dhMaSvX1vR5zoZQEd/QQ88ZCTMa06DqGgN35b3pXRf+fE+UAHpCZbMWYJfewdNe9L55
         frx/kc+P7pXPHKu+Yyi9QjcGM/+J+KPVNorvSBvjylZ5VpWjEI3i9vGxLAhQGK9xc1Sg
         MHnpG6rFilhrX9DkxryoQXbMtsuHSuARrj3U1BO5JLi496Wm4aDST2FG3leC1QjZsqEi
         OGHQ==
X-Gm-Message-State: APjAAAVpkbM7NzpDb6rB48KyPFixxzrw+StzvecqCiPJRUkzsWOK6DeF
        QWRvVDEYYey3ttWhWCf1dmaXRA==
X-Google-Smtp-Source: APXvYqz7aYfTKLRMIc9dIpZKfGpZT6KS6fOh8tdIld2RBmduglCWax9u24T9mQN4/gn+82GrDikg0g==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr11448751wmc.111.1576773093503;
        Thu, 19 Dec 2019 08:31:33 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:31:33 -0800 (PST)
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
Subject: [PATCH v4 11/13] iommu/arm-smmu-v3: Improve add_device() error handling
Date:   Thu, 19 Dec 2019 17:30:31 +0100
Message-Id: <20191219163033.2608177-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
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
index bf106a7b53eb..e62ca80f2f76 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2837,14 +2837,16 @@ static int arm_smmu_add_device(struct device *dev)
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
 
@@ -2854,13 +2856,25 @@ static int arm_smmu_add_device(struct device *dev)
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
2.24.1

