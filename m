Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634A12EF46C
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAHPDu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbhAHPDu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 10:03:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48607C0612A3
        for <linux-acpi@vger.kernel.org>; Fri,  8 Jan 2021 07:02:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v14so8060390wml.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jan 2021 07:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eMatyaU8zFd8Q8TvQc5SNMWc7sFi+EMVDUCvYNO8HI=;
        b=PF+LtOue9z0k3+oGC/sV5vRzeVgpjnE66dv2lS1/0KAh6PdcDcb/eiy37cF0YSw7tR
         XamqKOvs/tvWlbeQMist5W2NOqYEP+DQrOLDcyMMWBGWnTGIbB7jRFkZYp2PJUmaAk5X
         9ZNyT4OrLBxIV8rTB1uhyk4ubLRlzCNYE9TGknq19Iu/r98UGfCTUWQU4RhOiQFvYsuC
         UHhAmgUFXWWV8nlVOLzJNpjmHVmovdXXeY6I5cASBrJxD+S17acG+4oscZrctbysrux5
         GJV8LXQdfWgJTatHEY+Q3AgLBuECirtQlEnsNdWT5PSeyPBtzBgy79fPiBriSzLmRaf0
         wh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eMatyaU8zFd8Q8TvQc5SNMWc7sFi+EMVDUCvYNO8HI=;
        b=TdO7r5JBPI88fIWJAlzkpJGlxU+sVmwkz8g82xsTsgEImihuFykXP++1VHjPnLdIYQ
         QvJiyadNuHYzXKYezmhVdRq8b5pNtu6kGxSqGJ62VuY+3oR54V3Kdbiq+f3CZn6n94Co
         gFd7u8li38bI686p1PkOpaUhJgyH5rq8URNCMuHdSmRI2QON9cxNhht8zCYXInOxUTEs
         U+MVPD0r0FyNa2lxhdDQiSwXd8OxuOjlVxCjVG9sI/bWbQb0fiiPt35EouSfa53ZEHdV
         VeiRfZTOxRm0p/mwyhykZNfAB9ySdamQXJo37P0KQPPgQKYKsi1fVrA/EIkxYF12rCzr
         nvXQ==
X-Gm-Message-State: AOAM531blqaRN6PEMA+kR9qiF2mBXyAP1qNZBRrUF4dQSfqqfRKsmIKa
        A3Bowc0MQ00+XHNAOs/fVzu0nA==
X-Google-Smtp-Source: ABdhPJyHiNU1Qbdu42iiC2mX+tJD+USpt5tm+a/xmIdCmwoy1ECY/HXmB0eN9hveoKs5yMklN1nRqw==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr3294358wml.56.1610118154929;
        Fri, 08 Jan 2021 07:02:34 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:02:34 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
Date:   Fri,  8 Jan 2021 15:52:13 +0100
Message-Id: <20210108145217.2254447-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
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

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/misc/uacce/uacce.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d07af4edfcac..41ef1eb62a14 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -385,6 +385,24 @@ static void uacce_release(struct device *dev)
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
 /**
  * uacce_alloc() - alloc an accelerator
  * @parent: pointer of uacce parent device
@@ -404,11 +422,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
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
@@ -432,8 +446,10 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	return uacce;
 
 err_with_uacce:
-	if (flags & UACCE_DEV_SVA)
+	if (flags & UACCE_DEV_SVA) {
 		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
+	}
 	kfree(uacce);
 	return ERR_PTR(ret);
 }
@@ -487,8 +503,10 @@ void uacce_remove(struct uacce_device *uacce)
 	mutex_unlock(&uacce->queues_lock);
 
 	/* disable sva now since no opened queues */
-	if (uacce->flags & UACCE_DEV_SVA)
+	if (uacce->flags & UACCE_DEV_SVA) {
 		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
+	}
 
 	if (uacce->cdev)
 		cdev_device_del(uacce->cdev, &uacce->dev);
-- 
2.29.2

