Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89778126703
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 17:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLSQbd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 11:31:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36224 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfLSQbc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2019 11:31:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so6637962wru.3
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2019 08:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nQT4ayYi2icUCghAPJFv/Sszvlp8khOsvgAay7NA80=;
        b=npHKtHQyMJP1HB7cti1f6qmoeI+DJKFn7XvDJJvdFOvDZnGuyq626gmPPg1VW/g+vf
         NqHOB4YW3LtpAFxkZLtWK59MIggQeBHMnf2FU4aoFn2biHVyVWj0iduHkMNtN+Cw2QKl
         3GzgzVR/AU8hNb4bXoVdj3ptMWKCW30ACKJ3zUu58boNWddLRmDvOzJlIlY5xbZoskN5
         NreU0QK4KXWGIqcGeZD3D1pGnvnWQRzTZfOi+0GHu41hGDI1yGc6L4u2Cpc68atX6ZYW
         BASd0KfcX6CjN1z5HsyiO9BpOuElbJpjkF8aVQmcH6L1OGUKS7nE3VlxwSQerqKeYRZZ
         jh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nQT4ayYi2icUCghAPJFv/Sszvlp8khOsvgAay7NA80=;
        b=DlYO18Tv9auGcxE6y+O7hbdTR9ycy56i2orfDfhF4AvmVg2mieFofwz4aP9S/tTLAC
         rhIso5EvcU1p5pECGB7yM9E8VP+KUXBZVmB6GygOV4IOrUA8/Sc+r27ZGLitEoId7aVQ
         xlF8CAOK7fVQ8VEoOPFHGjIIiPonAhc0Rp+y9imwCN0GXoWpdGGeiM5dIPWcOOmlD3Pw
         xA/Y1BZPJNkUQPyDb//n7XwQ1DyxIavQCLqiLkqsBN7zoScLBzkDESJi2pQwsmeofuUu
         fE055LVBLip32tw1mFebLZGDrExwUDHuMrnTjJOGW9XL4CUimbECaRkC+oRfe6LNa2GH
         tW4w==
X-Gm-Message-State: APjAAAXi3Q9ryH6MFYx5NXqNPk7q9s2J219RDuZwOdRMqf8gH7ZH9POK
        xlNyyjs9OtHldD4R31D2eMhN4Q==
X-Google-Smtp-Source: APXvYqySYIruAf+8UBV8yIOQEKLEyMW/IQr33V3GJnSu1IpDHvzkWr5tRTKgSPhwJDgoXMZbxqfv3Q==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr10010531wrw.327.1576773090913;
        Thu, 19 Dec 2019 08:31:30 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:31:30 -0800 (PST)
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
Subject: [PATCH v4 09/13] iommu/arm-smmu-v3: Prepare for handling arm_smmu_write_ctx_desc() failure
Date:   Thu, 19 Dec 2019 17:30:29 +0100
Message-Id: <20191219163033.2608177-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Second-level context descriptor tables will be allocated lazily in
arm_smmu_write_ctx_desc(). Help with handling allocation failure by
moving the CD write into arm_smmu_domain_finalise_s1().

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e147087198ef..b825a5639afc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2301,8 +2301,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
+
+	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	if (ret)
+		goto out_free_tables;
+
 	return 0;
 
+out_free_tables:
+	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
 	arm_smmu_bitmap_free(smmu->asid_map, asid);
 	return ret;
@@ -2569,10 +2576,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
-		arm_smmu_write_ctx_desc(smmu_domain, 0,
-					&smmu_domain->s1_cfg.cd);
-
 	arm_smmu_install_ste_for_dev(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-- 
2.24.1

