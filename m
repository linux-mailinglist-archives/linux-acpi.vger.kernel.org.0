Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6032A4C4
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442187AbhCBLRM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379044AbhCBJiz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 04:38:55 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C1C0617A9
        for <linux-acpi@vger.kernel.org>; Tue,  2 Mar 2021 01:35:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u187so1620309wmg.4
        for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2021 01:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UwcG/UbYxOwu/Rok4cktInfyw7lfwNLJYyuoJI7sKTg=;
        b=vGsFqDqP3CHWV+Yt1menOPl3yoMGtirJWj2Zr9+MyVkCV7uKFvnywi7OQlvSvGy3RW
         rUqU7p3fe+muXm5qv95Ab6t47/zFtZqZQIrBhkgmESkzZ7VmtiyQgtLPd6ipfJkcWGiR
         6MkIb1JCZWTNjtNCGUd1S45kmqCIKsbwDrmq0ZvtyLP3ED42TK1HYt1RRpJRZF68XtQm
         RqMax/jWgba5YRRKgtrUhISzlUhHNjRfbKMPZFVUUDgfT/5A9X7VLoYv3mF5t2phBix6
         tE6f3/KB8GbwdBSzsU3+lmF0HXaqA9X/RzkPFERfSO8BJtcypuVS0MR0MOQfhVhr+Irt
         DjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwcG/UbYxOwu/Rok4cktInfyw7lfwNLJYyuoJI7sKTg=;
        b=r11A3Er/7x/YcP2NQ9UQ7X4IgrGDmY4SHaJfdZez8+BFEXm7KuClgSv4PDWqUppBi1
         VG3orP8JrzlYs3+lOrENCyeHGO9RRd8mPw0XBdxCAFH4OQ7L1Ji5epFhZ/2+OaTAs7QE
         1DXPrrcdDrO6rL+j+XILcln/3AbqkJALz72PL1hGs+jQgxhxqr3X/ROq4s6xCr3S/Sc5
         MhlBUmUlDBMDZ5AVCF8dU+CNRTGBaUBRHQDaOU0BkbKBjn9h5ccQ5Rz8dhoj0Zc4iyAm
         /cszn8vGgi435h6zMkvjdtGQupKbTZEpv7SHizvjZjGtfqOoFA/87wsk6nb05HfXoYdt
         Fbhg==
X-Gm-Message-State: AOAM53185SGhbno7Y5gWZp9I6Sa+G5Ltau8t4G8FJEMCCIGak5DIX/9e
        T9GHyCF9BZctvetfLKrvINXisg==
X-Google-Smtp-Source: ABdhPJx3IarwrxvGVNUDDDTxKQdBz1ESv5vuEdngsYCCDXK+5PM6f0H2Y/ifeQTqAjmXHfnwbdzQBQ==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr2993828wme.175.1614677733641;
        Tue, 02 Mar 2021 01:35:33 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:35:33 -0800 (PST)
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
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v13 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
Date:   Tue,  2 Mar 2021 10:26:39 +0100
Message-Id: <20210302092644.2553014-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some devices manage I/O Page Faults (IOPF) themselves instead of relying
on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
mandating IOMMU-managed IOPF. The other device drivers now need to first
enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA. Enabling
IOMMU_DEV_FEAT_IOPF on its own doesn't have any effect visible to the
device driver, it is used in combination with other features.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 include/linux/iommu.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 16ce75693d83..45c4eb372f56 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -156,10 +156,24 @@ struct iommu_resv_region {
 	enum iommu_resv_type	type;
 };
 
-/* Per device IOMMU features */
+/**
+ * enum iommu_dev_features - Per device IOMMU features
+ * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
+ * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
+ * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
+ *			 enabling %IOMMU_DEV_FEAT_SVA requires
+ *			 %IOMMU_DEV_FEAT_IOPF, but some devices manage I/O Page
+ *			 Faults themselves instead of relying on the IOMMU. When
+ *			 supported, this feature must be enabled before and
+ *			 disabled after %IOMMU_DEV_FEAT_SVA.
+ *
+ * Device drivers query whether a feature is supported using
+ * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
+ */
 enum iommu_dev_features {
-	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
-	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
+	IOMMU_DEV_FEAT_AUX,
+	IOMMU_DEV_FEAT_SVA,
+	IOMMU_DEV_FEAT_IOPF,
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
-- 
2.30.1

