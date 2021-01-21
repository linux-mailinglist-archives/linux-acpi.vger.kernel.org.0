Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8677D2FEA6C
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 13:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbhAUMmw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 07:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbhAUMlD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 07:41:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1483C061798
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c128so1395436wme.2
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2eRhKsVau0r7rYJc5kg9wODttGekaxkRDREYSkG2V3g=;
        b=QuUMjiy5ho1cz1ta5kVsxHS6pccVZgC9l6zL1qsFa7+VqjNpuf/uQnkpICVteQGTmp
         5LfYliJDrpBW/gPgpB7ezB5xGV1T8K0b2SaRShfvi4yMh0bYjCt/utdFGEstkQVoNjiA
         eFM8A9hStx44vAI2iPyPAZRme9cDQULk4hw1TIurC9IApmOLPwdVgoG+9t85+7OtvPu/
         k//FGUbAqr9XsDSOm8HxrfdVW2FadDrap3RhH4vIsdF4h1+6UmL/+ThjrnrGApVO3mss
         VFwc3rD61MYEuRJPv+T1m/isVhd6pid/9m4XbVK/WijzMQ62V4m7JSmViDa9OzIQA9hl
         UX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2eRhKsVau0r7rYJc5kg9wODttGekaxkRDREYSkG2V3g=;
        b=pTGQUrVUNp4xhm4RwafEAb6CIfIsSpsE8JtzMl82kD74zr3fkqcitu1u5RL2qz2JnS
         Pd8EF3DUgeIKXKJp8ta6cCScSfczUodiiG2KgBE2FbHyaeZ4LfksEk2uMpKZNWpigeod
         7V8Lkmagi/HEK3DD+XenuXC5aZFjYFEKKgyqMyAJokUmtCxofQ/9NfRinccsGZPpzGma
         rkSALeN8/R/bPvzpTteXPOuf60/AaRvswAviaMrfZ2zBbge3eklmlju/3cZnDIwiFAq8
         /t+jLpVbSHg/RS5F4zZqXJ7DRogYQCkuTg58+bhKwXYlNkLaFcuIMfFjwZMKPEmL177d
         38ig==
X-Gm-Message-State: AOAM532mYVk62Z2QkO30OWOEWG/7rGSc/Ew3TOExITN5i+TUliXz7388
        GFcxotqCZDhcO8972Z4jAEEHdw==
X-Google-Smtp-Source: ABdhPJzCnYjI4iIxIrFa+qg5mD+IvE1eNZJ/zCswHjZr0Pa6EmPz7F9ZjjKy3/Xym3kXCMfttFAK5g==
X-Received: by 2002:a05:600c:1986:: with SMTP id t6mr8703507wmq.93.1611232777425;
        Thu, 21 Jan 2021 04:39:37 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 04:39:36 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v10 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
Date:   Thu, 21 Jan 2021 13:36:19 +0100
Message-Id: <20210121123623.2060416-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The IOPF (I/O Page Fault) feature is now enabled independently from the
SVA feature, because some IOPF implementations are device-specific and
do not require IOMMU support for PCIe PRI or Arm SMMU stall.

Enable IOPF unconditionally when enabling SVA for now. In the future, if
a device driver implementing a uacce interface doesn't need IOPF
support, it will need to tell the uacce module, for example with a new
flag.

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/misc/uacce/uacce.c | 39 +++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d07af4edfcac..6db7a98486ec 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -385,6 +385,33 @@ static void uacce_release(struct device *dev)
 	kfree(uacce);
 }
 
+static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
+{
+	if (!(flags & UACCE_DEV_SVA))
+		return flags;
+
+	flags &= ~UACCE_DEV_SVA;
+
+	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
+		return flags;
+
+	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
+		iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
+		return flags;
+	}
+
+	return flags | UACCE_DEV_SVA;
+}
+
+static void uacce_disable_sva(struct uacce_device *uacce)
+{
+	if (!(uacce->flags & UACCE_DEV_SVA))
+		return;
+
+	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
+}
+
 /**
  * uacce_alloc() - alloc an accelerator
  * @parent: pointer of uacce parent device
@@ -404,11 +431,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	if (!uacce)
 		return ERR_PTR(-ENOMEM);
 
-	if (flags & UACCE_DEV_SVA) {
-		ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
-		if (ret)
-			flags &= ~UACCE_DEV_SVA;
-	}
+	flags = uacce_enable_sva(parent, flags);
 
 	uacce->parent = parent;
 	uacce->flags = flags;
@@ -432,8 +455,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	return uacce;
 
 err_with_uacce:
-	if (flags & UACCE_DEV_SVA)
-		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	uacce_disable_sva(uacce);
 	kfree(uacce);
 	return ERR_PTR(ret);
 }
@@ -487,8 +509,7 @@ void uacce_remove(struct uacce_device *uacce)
 	mutex_unlock(&uacce->queues_lock);
 
 	/* disable sva now since no opened queues */
-	if (uacce->flags & UACCE_DEV_SVA)
-		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	uacce_disable_sva(uacce);
 
 	if (uacce->cdev)
 		cdev_device_del(uacce->cdev, &uacce->dev);
-- 
2.30.0

