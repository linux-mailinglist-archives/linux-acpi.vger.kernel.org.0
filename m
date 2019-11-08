Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F47F4F85
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 16:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKHP05 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Nov 2019 10:26:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37728 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKHP05 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Nov 2019 10:26:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id q130so6641378wme.2
        for <linux-acpi@vger.kernel.org>; Fri, 08 Nov 2019 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcF4FI/xEJT2ddBZxLwsH4kwVBtXhLcA/n4y2uy3gfU=;
        b=BDQ7ZeC9LB/2Lh6DQj16J8t0f6umU/jbny0nZwuikklVbgDi7dCWTbWMm0aRjLi005
         V9skokHIp4EKef66gOqo4I/nTxWGvc+9S6EKjBlJxyLdKbQSqZqWvqeY+Z77HTqkfX16
         4JkmEuH7gjM/RdLJO9BN/Vyp34vnY9Hjxh0xTuSOc2pbbXcqJvbeKLT8KPs3B6zuGeSk
         oQeEJyv8qFljGOOQ55RrjTk0fCjjESA+CfjKaY7SQ8SZ3HRmaDrfbgz8Gb5nIqgT00q+
         AA1hFm+CnyswDokicO8N1z95D2kGm5pzZtaKebbBgrFl7rKhfqfepJE34J7LhtfZSbFY
         G1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcF4FI/xEJT2ddBZxLwsH4kwVBtXhLcA/n4y2uy3gfU=;
        b=DUvGcVhRbM508nKdqzBAy/1aDTFInhNiwrrNQNi0c4bCBwRz3WQSttJlxoz7TR7yOr
         YA1Hbizv1NIQ5Iyg9KE2BE+Wk4TcOGv/yo6iYrnGErd9P3zDq0QR7/MwbeoRXDVykU47
         d2iT2q5HmXbCU1wO4nphNs8JzkvU/efyt04CtDZgsWU4Xukd6P/1NnOWDfmRW0tkk0Cz
         ZnzkE2w7a1QrE0xWvZnfDYy4xJlxX5I6bXOygYXNW6AewhHAiR+3BTeJkvx3ISTDPtOH
         YZRQ8kkLCrjCFsIk61RAsKTEPYPEEAE72Fhcwjb+C9++jAjbudodGl171mZWeyqN0Alg
         Xvgw==
X-Gm-Message-State: APjAAAV1Ot7Wi42uiUpu1MB32prOfhBUQ25iBo0PIRHwpP6+OjX8ExvI
        q4/2jtJiWXeODWmhgX+eS9FYNQ==
X-Google-Smtp-Source: APXvYqzgCicwCZbEjPp1W/xKMCJmORJ4A/9v+uL6ZQTDFPmzJrCekPgMET2BLRpL/BAud9T+NepWPQ==
X-Received: by 2002:a1c:9917:: with SMTP id b23mr8603435wme.42.1573226815904;
        Fri, 08 Nov 2019 07:26:55 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id w18sm6579232wrp.31.2019.11.08.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:26:55 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com, jonathan.cameron@huawei.com
Subject: [PATCH v2 7/8] iommu/arm-smmu-v3: Improve add_device() error handling
Date:   Fri,  8 Nov 2019 16:25:07 +0100
Message-Id: <20191108152508.4039168-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
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
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82eac89ee187..88ec0bf33492 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2826,14 +2826,16 @@ static int arm_smmu_add_device(struct device *dev)
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
 
@@ -2843,13 +2845,25 @@ static int arm_smmu_add_device(struct device *dev)
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
2.23.0

