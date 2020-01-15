Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7275813C1DC
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 13:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgAOMxk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 07:53:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34059 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgAOMxj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 07:53:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id w5so4684892wmi.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jan 2020 04:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkGjwbrGa1wrMcO/KHo5uF2vFnVmce44IDO/Kf1WvcM=;
        b=pq6uZQpsX3gU3Tcd0g31MBx+lVvCLRX8nZbjge2zbaX0o40wceneHPuMBzBFtJbnQL
         rUphD/LvuXhsWoPi1Og8NoDIG7QjYbtE3v8hHk2uxTgndgP2lfnwgtXQ+UZsMAzgPKNE
         6wxRLnJXPFcRyy2v8Krf7yS5doZHoY6lsNnNvZDBYlAoiS23SYnwL89liofvY0J2F/AX
         ZYOl+WxomfHZtKAsdCpkAaCuyZSIRGodHQmCd7TdNUhI+LGOanQE085hqGg/w3JJ2o0b
         I1QBD0/XrJyW23s8DR7txRnM8g1bWYQkQEz7aKlLGCKfhG3uLoGTHeVG9WQmgfSvDZbH
         jWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkGjwbrGa1wrMcO/KHo5uF2vFnVmce44IDO/Kf1WvcM=;
        b=WS3B/XZBdK5ucO2GDC+aKLOMZ54JH9dr+ppgbOrKBxXSrcCJEzp923I58gqY+yBkLd
         YhgG81D/MG+Gj4izQLAzb2IVuRiZZL0D6QqEL32r+C+rIjqSt+1Kny3p8Xb7hTcG+qd2
         xbxeIHe7MpukvuOjMYqVogJU/MbyR88qHpn25C3b5/fRtXASHg3KgyrwYMJueX1a1NQZ
         68EgOb/Ks5ohfz5YD9mOHUJleLWT3JaBDqXpmcHT0daGudWWGScm3ZoXCdAcmNJpCvGW
         EzmvsqNErZB1pIt4wFBofk+lJENFSQLxs073+2SXivVoBf/CNfONBPzel81TC67S/Oih
         r1vw==
X-Gm-Message-State: APjAAAWH9/MQDwGgSLnReQ7UYcsMzVAIJjxeRv7KpEiQz5LxUesIg0b8
        C+LgQZ+Lies9GgbBrllh9Yz90Q==
X-Google-Smtp-Source: APXvYqxppRXM7W0rog1akfsKD1HDFU2AmK5typwsSWE2NQJlIYz8KU9v6BH6h5H2FeKoNTAxdXO+4Q==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr32316515wmc.165.1579092816792;
        Wed, 15 Jan 2020 04:53:36 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:36 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 08/13] iommu/arm-smmu-v3: Propagate ssid_bits
Date:   Wed, 15 Jan 2020 13:52:34 +0100
Message-Id: <20200115125239.136759-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
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
index 6ab0e93518f6..7b7dea596f60 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2277,6 +2277,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -2288,6 +2289,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
+	cfg->s1cdmax = master->ssid_bits;
+
 	ret = arm_smmu_alloc_cd_tables(smmu_domain);
 	if (ret)
 		goto out_free_asid;
@@ -2304,6 +2307,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2320,7 +2324,8 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_master *master)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2328,6 +2333,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
+				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2382,7 +2388,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2535,7 +2541,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, master);
 		if (ret) {
 			smmu_domain->smmu = NULL;
 			goto out_unlock;
@@ -2547,6 +2553,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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

