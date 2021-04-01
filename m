Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A993518A2
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhDARqp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbhDARmW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 13:42:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1308C02D55A
        for <linux-acpi@vger.kernel.org>; Thu,  1 Apr 2021 08:48:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c8so2279368wrq.11
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BquDzldAEj2EH23ygss3SlxMQB0eJjr5DrCfd4H/f6A=;
        b=BY1P730D3224hWTgv8L+qHOrdvpJ1eFdWnZzEjuJ8pzTTK5vPuk7rUBvJOrV7koxpw
         prbNI6DAhcnlJjXE2vOMjNZR4Z8QIidATQEEo/kJbgrDEpYXDycRs1/YSlZHA5xloE5a
         udnV1CQcHzf3y9U3foiWJ8Os3CNye79HUcsL27t5dhaGROvyFIkORAgdgg/d0vozPqtf
         +oE3I7nDP6s56qlzG0kge3kfa+CQYkBeAHJ7qTa3jHM8apl/pj4eTHZa6elBoHe1C2X0
         v/P5h1n2g72ckiGIgulfUJhbL+7Hgwiq72Qpp4GYtL3zqCcRMVZM/WwnV5LyVANnxPoP
         gbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BquDzldAEj2EH23ygss3SlxMQB0eJjr5DrCfd4H/f6A=;
        b=tQQHn4CdAEZaTKHQJ9JOTTJwU3EvuxUFV3JZ77Lgskz9MfGHwC7zjE2qasDCEoPZza
         NsTL7UgBdsX/WC26d9yb3ZygpPVOe27arbZHqlzw1nR70itp/4IdG/8GFSFaO+c2K3TZ
         ogC6+9F8rWDpeTnttkMNU0WyEFd8/xQ+eHa0SQ6O+W5fAhp0pkQRM+K6wBuCLbn7jYU+
         nQvofiMvteh+X07hGoO3C8IQaJjtY/5jnea+MshKqvlC3Csb0xNmr+VWg4NLQQX8VwvC
         m1w/Jfb00cWbuHgyBMiuS/l2SXUI9YASYGY6FXqiT0s4zAhEL3sQ33u2QjW2BR5HFU4B
         nnHg==
X-Gm-Message-State: AOAM5303KoJB+eXlOPkWmcBWKzgEVfb6rED01BjNcVHwbuCEG6hqyCAw
        peq3LJWFvWlhM4IHjDAb6VJ/WA==
X-Google-Smtp-Source: ABdhPJyKKBv2LoaNLDGxO1hDnhB/xoVY7kpAPpy2Z4WbHxQ5K5/AvH0yQdAKDNlsPeatC8vioANMnw==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr10401493wrq.201.1617292098573;
        Thu, 01 Apr 2021 08:48:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:48:18 -0700 (PDT)
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
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v14 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
Date:   Thu,  1 Apr 2021 17:47:14 +0200
Message-Id: <20210401154718.307519-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
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
2.31.1

