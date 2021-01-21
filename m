Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA92FEA4D
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 13:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbhAUMk0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 07:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbhAUMkO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 07:40:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32A2C0613CF
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 7so1605608wrz.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PBUJkI6WkOQ4c7ebH11XhAeKbkF/R51HzjghE20E74=;
        b=S6KAw6BFvy1u9gJvmutqIln16f2tlRmzrrTj88Jt8KD7XWgeUEfM6naKbWUTAAPUwB
         rZS7buyT/hDN9LnURR0KzikousqtLELsRIgdbWXldN/HbgqPED5ggw9DQI5xYMZBl4jO
         qOmCKvazJNe47iOE/IQhrlbYSbOJK6aqGhTDnurw+RTVmKI8OpKIy66mv0OjGTNemNq8
         D6H49liQT+jbQQWyu6qOoYUGwUjydvCbtSND5j/FWlQs4KpluWbrLop3s7y5psHv/qXI
         6JBpXe8GgGkHTb79wjro/Uc6XEb3UDtIFpKB4GgIjVT807gmpNW8hVcqSy/J775Tgktb
         Ek0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PBUJkI6WkOQ4c7ebH11XhAeKbkF/R51HzjghE20E74=;
        b=cKkNVt4ytLYjkNkf2G6JQk2b0wBkixJgX4q5aMyG4cF5FLo+8L4Da/tVXDLLpr0tPR
         r4Lm0B7WpdDXaEqPUFgS0HPZkYgdQ4JEdgO4vHLTEEmMB/g6eSsenAkdift07upY194h
         N0W8NO64SOp1uC7V3uR+1LHypfYAiKaK1BY6kn8mMCcrslBFz0DUEefP6rQ6R7svycAg
         jiE1jZNl6RNqpARpCQ7Rwl+uyjhq/EVsqnCI5/36XDzDpn/r06cjZ5YvMK78jUbB0zqc
         xv12Po88lbfSE5ctmFaTWmDP6bgoFZ8PjrkDBXKocjRGkq5Dp+DUiUOhsGH4lYcw25S6
         WHQQ==
X-Gm-Message-State: AOAM531zOqLPzWlWX72IAdGltw6ORxJBfr2dc/RN0hJ/N7ru1MVfEbUQ
        pGzc4fl9NWnL5Zc8IXvZRwPCyQ==
X-Google-Smtp-Source: ABdhPJyfGOcKra/ylSEchuLporqovRSRrQIgsiDTRwFORMSbkkpu92YM/S/k4DpD7qDCmqHN7DeYZw==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr14080338wro.216.1611232772398;
        Thu, 21 Jan 2021 04:39:32 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 04:39:31 -0800 (PST)
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
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v10 01/10] iommu: Fix comment for struct iommu_fwspec
Date:   Thu, 21 Jan 2021 13:36:15 +0100
Message-Id: <20210121123623.2060416-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 986d5ecc5699 ("iommu: Move fwspec->iommu_priv to struct
dev_iommu") removed iommu_priv from fwspec and commit 5702ee24182f
("ACPI/IORT: Check ATS capability in root complex nodes") added @flags.
Update the struct doc.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3f0e2018c62..bdf3f34a4457 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -570,7 +570,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * struct iommu_fwspec - per-device IOMMU instance data
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
- * @iommu_priv: IOMMU driver private data for this device
+ * @flags: IOMMU_FWSPEC_* flags
  * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
-- 
2.30.0

