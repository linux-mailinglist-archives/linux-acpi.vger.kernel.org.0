Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96398126705
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 17:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLSQbf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 11:31:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37308 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfLSQbb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2019 11:31:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so6286139wmf.2
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2019 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYioDhZ/j/78qMyUi+NbeqzegCC3zzPggnOI7+kacPU=;
        b=E5aFBHpxzJkkIdtB9W66GN6ZLoFLgZNBR0wli2z1R1GfTj4GDjCqIV7HMTgweAZs/m
         ERMXbIUqhoOBDH6Y6yVu9fvJUbv1S/8bk4nVNiphi6Bj9Hr+xJPMF+CM0wdD4p/Nxi15
         DDZ2eWHA4Po8SV0rJ2mSAgR36BjhDGY65Cg+Nrvt9skytm0oy8yLdbTRRrrti8PY8sxG
         GqI3y8AJ1hhG5ISFHxJBz9r9FQVWnJK5gOR2aOQHSLuQPhBDyUQ6M6IhwH5s6ciR9Vts
         9/GMh/foacnJ6Etj2gcl6Fz+phGe372ALVmMIdUJmCb95IS4K+ulNixBQU6NY1edO0qz
         7V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYioDhZ/j/78qMyUi+NbeqzegCC3zzPggnOI7+kacPU=;
        b=C2Epgr0tKIwuQ0O0otKSO4OSI2dlGN2/nMXxZKTrej1S0PnaaYKQThek76nKE+B2re
         VWYmJJl0iqz2TTXlIaS26V4ClZ+HUfnotrVJnuAFE40S3U3NVDvrlV2EthSaZE+yq10L
         ZCZfbhFrjIgTO0tZeLf2pOANyncJzw9/1UlHWVQxfS/LrYe0uuzSxXQ9r8dOH3+Q9UvR
         HT+AfCPM9RE8c2GXbjhQ/fsJVIH1RCjl/hvYzI3LwYW+QAVpXiJVDsSLwix4TLD2wqOS
         m5yJlqzM2xH7EvpPDk5XDosaM5/+JIK9Y1PJe7+EmHsrYt0gmYQeko9whWyLBcYzCB9W
         EAgQ==
X-Gm-Message-State: APjAAAXtR+xhALJj88XRHiywbzEzK+LbxWNI3BkDbXtko2a5bXtUk8dG
        Jr5OG97N2OP/4lxSLw48F5aNow==
X-Google-Smtp-Source: APXvYqz3tbndDtmJIFC5nyvsIDtpq2oUpdByujhcgVkyGmtlGJFmTfIjiRRUks4oRR3Fv+Nm/TOV1w==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr10896801wmd.102.1576773089551;
        Thu, 19 Dec 2019 08:31:29 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:31:29 -0800 (PST)
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
Subject: [PATCH v4 08/13] iommu/arm-smmu-v3: Propagate ssid_bits
Date:   Thu, 19 Dec 2019 17:30:28 +0100
Message-Id: <20191219163033.2608177-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now that we support substream IDs, initialize s1cdmax with the number of
SSID bits supported by a master and the SMMU.

Context descriptor tables are allocated once for the first master
attached to a domain. Therefore attaching multiple devices with
different SSID sizes is tricky, and we currently don't support it.

As a future improvement it would be nice to at least support attaching a
SSID-capable device to a domain that isn't using SSID, by reallocating
the SSID table. This would allow supporting a SSID-capable device that
is in the same IOMMU group as a bridge, for example. Varying SSID size
is less of a concern, since the PCIe specification "highly recommends"
that devices supporting PASID implement all 20 bits of it.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e1bec7e552b9..e147087198ef 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2279,6 +2279,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2290,6 +2291,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
+	cfg->s1cdmax = master->ssid_bits;
+
 	ret = arm_smmu_alloc_cd_tables(smmu_domain);
 	if (ret)
 		goto out_free_asid;
@@ -2306,6 +2309,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2322,7 +2326,8 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_master *master)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2330,6 +2335,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
+				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2384,7 +2390,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2537,7 +2543,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, master);
 		if (ret) {
 			smmu_domain->smmu = NULL;
 			goto out_unlock;
@@ -2549,6 +2555,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			dev_name(smmu->dev));
 		ret = -ENXIO;
 		goto out_unlock;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
+		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
+		dev_err(dev,
+			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
+			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	master->domain = smmu_domain;
-- 
2.24.1

