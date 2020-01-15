Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7E13C1C4
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 13:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgAOMxb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 07:53:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43936 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgAOMxb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 07:53:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so15623892wre.10
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jan 2020 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Rlh4fuYqJBRp2jOU8B0MlV1M4d0Kd3bn04JlNplJUI=;
        b=RQa6zVa9SRTjAkDpWaeNQ+TzHNaqSmjwUNjLiSStgQQFU8m1OhdHW06usASKfswEOm
         ekBnCK32y0eGel6xTuDdUakkQQN3qPA3G8RZ2bB2/vEsRD4EoWf2rDFY7CHKqlFY4vh0
         QQFCA9QYc73ULV1UlWEobvL9/no+9Vz/XZYY2Tj674ONdjmt9oZZufAB1mBcKnbhBt2q
         4ZyVannnpIUGVhmPOs8HxT18d9vQXPh7dxHC9oOgWg1bO+r8Uh6hZp5mpAIPltKup6q6
         726G40en2MsW4RUUOKkrDY94g3Urf6AAlYT9SgfBjoDblDCkp9GNBhcmObIfka7aytXi
         sROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Rlh4fuYqJBRp2jOU8B0MlV1M4d0Kd3bn04JlNplJUI=;
        b=j0S+RtH5vR6JGOtIOwULOStnSpqVsK8rOY0Bo2YaZ6PLbZNeUm5zqPiYiuXWkdl3Q6
         TFftpf8Tv4Vc1yw6DYz7nvModVUWcp2I8BIuY/RTJXoY7DPUEDIW8FoNd6ST/F7QXEEX
         uoLQ/IaNo8wZRxxA/KB6wXmwR0g+aZPA6FE95K0mUFornBi8w3ksGfgf7c4jad4Xsutc
         yyU9oehvSDMD26qSQi6qmk7KDJnqat7PbDW+Yt0EKn7T6tUk2xYs/cIsjW/fmJfitl0v
         f9gfBMeA1JMyNTUBjj6qDpTFZAb7PNzoHRGLdlk0pURrTZQETrirpWsvvfhRKhwOJx/7
         YCXA==
X-Gm-Message-State: APjAAAWUTLiycSYwFmD6t2gB/uSYENF4p+Tbe/di2gTcUS+QorA/g0s6
        P90CVFx2UP++pHmKtgBhhkmWyQ==
X-Google-Smtp-Source: APXvYqzMgS/+4YiEL+CRzGGcAhTGiJstPbrqmMFBjWd9wKtGLhNavA3EcOaksZRO/N8Ru4NFTMuSgQ==
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr32846130wrx.141.1579092809778;
        Wed, 15 Jan 2020 04:53:29 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:29 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 02/13] dt-bindings: document PASID property for IOMMU masters
Date:   Wed, 15 Jan 2020 13:52:28 +0100
Message-Id: <20200115125239.136759-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..3c36334e4f94 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,12 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- pasid-num-bits: Some masters support multiple address spaces for DMA, by
+  tagging DMA transactions with an address space identifier. By default,
+  this is 0, which means that the device only has one address space.
+
 
 Notes:
 ======
-- 
2.24.1

