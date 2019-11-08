Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A06F4F79
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfKHP0u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Nov 2019 10:26:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37713 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfKHP0u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Nov 2019 10:26:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id q130so6641026wme.2
        for <linux-acpi@vger.kernel.org>; Fri, 08 Nov 2019 07:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkWcxJ6Iuy+TFzutOZwKsDdjGV2W0A5RS2sI5DD8vzM=;
        b=rr+E9RT1m3Uo7HDUww3oQBuqgMwd4smQJlm1F51cGsAn5yxcXpfWYxrw5HNGAbAN0T
         vCuV/pFnYtG6J/pA8tYatmkzzIt46o+Dibijb10+j8gXZtsXmaPI2hVExy0xaTPM1pUw
         jWyJ4iAp0CaA+2OriDDPyVEAYwIpVTS1sbFx5qbFpaZE0rXPjKfyiWXPnoRAZqG++wEI
         quuvaGA4UYD7FneNYZe2huxUVlofu3I9+CDwSJXYrb2yPBxitzAAjDVaYj/cfBnZTpZK
         Q/VnQBsoVhbXhLUrHkrWvVm1kgTuEYPkBFnVWoN8dc8lROj6lv/76Wr+Dt4SpoqAyU3N
         Cv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkWcxJ6Iuy+TFzutOZwKsDdjGV2W0A5RS2sI5DD8vzM=;
        b=HzMdravIx/gsJy1//xeSK2jPZAxnPAuJMuvxRYLftwk+Q2ZsehS2Y0/bzzzyWeny96
         Tff32uRyQB/LXCpBSuK/Byb8K8/sH0k3GMDaF+tZxRmhcRV7X5oNfSBGWJxXLAXCGTzX
         4mtBJ2S9bfxAjP1eFTLSIq8t96zQMFISLAnm++3zSPCQ2bF5RUNu+FHgKwJ8vo+jx25m
         nxMfqYaCJmF0TC+2LEsAfBzbuPoJQah9byUTq0KYDtVh5OD8RlCQRwCOOGP49+80/SOg
         kJpiPBtHf13vS1gxgisaTZ5QvhEK6dVsLYZzDyZnGTHtF3Fx1SBBcyVq17G/m+L5AWMH
         ixjw==
X-Gm-Message-State: APjAAAURecL0lR5n9ffOm2ObWL1SqZcmfxUh8nd+ZEErr2lASSBi8OuA
        6DD/MeFnvEKYlQcFPQKfJCS8+Q==
X-Google-Smtp-Source: APXvYqx/xuA1TPNnHqIK0UYk9J6qHcyjmZQq/kaCmKhNSU7fNuxym1Kdo6WOQxPLxhdoo0A3JfJ3WA==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr9006014wml.170.1573226808499;
        Fri, 08 Nov 2019 07:26:48 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id w18sm6579232wrp.31.2019.11.08.07.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:26:47 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com, jonathan.cameron@huawei.com
Subject: [PATCH v2 1/8] dt-bindings: document PASID property for IOMMU masters
Date:   Fri,  8 Nov 2019 16:25:01 +0100
Message-Id: <20191108152508.4039168-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
2.23.0

