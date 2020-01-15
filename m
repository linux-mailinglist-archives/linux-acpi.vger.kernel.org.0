Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8691213C1E6
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 13:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAOMxm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 07:53:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38515 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAOMxl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 07:53:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so15644020wrh.5
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jan 2020 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3g2nYTO2xQzb0GJuxY8N32scuZW4mZloVEmHa7VH1s=;
        b=GizgJV+NAlkwmPStOaKeLJGVjuw+mNcVnRBGC3KOsPI8Ckz3NtzP81ZW0FXqyGTgmo
         CQSBQ1i/367JhF2Hr9aOyBH7HhwOtRQxxhF1ER/yFhgBYGARKyuYZwnyUOM16f9ZkoHz
         932OC6jTw3G1Yo73aVV7ol9jYuBydFvGU5nbMGRb8wnB/wZMPE3SbC9TXmYjWfC0Hj8w
         toP68qIugnKqfeVmyqApFpJyXHnxypMTrAs0iJBxdz+LQ8B8jT0dBRDD7X39lECHCK9Y
         lz9qLSHufNXYhKd+fOGRYzHa41Bh2IjLy2+y4DlRmvQ2I5XcgoOrSTzHbGvUrovuTt/X
         3gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3g2nYTO2xQzb0GJuxY8N32scuZW4mZloVEmHa7VH1s=;
        b=kuzPEaFkUKBINusUmG3gHamZjUOcVcoZaEPmLUz55Hlyu6kjDueJe36MWjPwjLBuVe
         EstS6wEl2FNWH/XO/uSe6gLEZiNGk5whQkcJjhBOrb3EdG936VAxRTkgIFazuDFIDNbH
         HV16CKuSBkxV7cfbfZn85kqt/ZmMb9/9BnnmW/NQ2DEDrUlGx3BC/2UeYIcFhABdlFgZ
         RxtA/MXyLS09OlKp9chLBoASwok0gR0vE+JSWHhtxbD8XjKW0t1nOP1Ss9tPfDg0/pwD
         BiSDHPikiZpHOlzZ2CgWX/xTrVDuGrs6kCwT/xAMEqU+tcXLAssX4qZXgyar4WgDv6G2
         Flfg==
X-Gm-Message-State: APjAAAXGo3juPJ24KcVOFdFPXjtFSllqrOgW/s3hFMIAKOZchirKq//8
        tarf+js+Hi/xZ6KT4I84R7Q1hA==
X-Google-Smtp-Source: APXvYqwSGcbdAtd5+ica/pXHhp8VLPeN94EbbtkoRsRsPY47afNQboGMHUBtV30+2XDoEbdnJ8V8Ug==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr11624781wrn.140.1579092820130;
        Wed, 15 Jan 2020 04:53:40 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:39 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 11/13] iommu/arm-smmu-v3: Improve add_device() error handling
Date:   Wed, 15 Jan 2020 13:52:37 +0100
Message-Id: <20200115125239.136759-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
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
index 04144b39c4ce..b2b7ba9c4e32 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2827,14 +2827,16 @@ static int arm_smmu_add_device(struct device *dev)
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
 
@@ -2844,13 +2846,25 @@ static int arm_smmu_add_device(struct device *dev)
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

