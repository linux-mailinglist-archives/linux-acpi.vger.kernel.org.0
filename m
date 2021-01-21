Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9783D2FEA63
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 13:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbhAUMml (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 07:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731437AbhAUMlR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 07:41:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A8C06179F
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:42 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e15so1400762wme.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iza7ai+1pJVkOiREPpK3tUFt/+4KEOcT4kmdIoRu1W4=;
        b=ncM2Etu85nnnt1D5R9wUQk3EdfSF9pw+1ijx4nvgrK8oJD23eDuaDfijqTYecFMFyX
         wDn3pvejZJ45AWRW6k6uYvZj0k+50DwmufnS5BpjT5RFasOCp1okzSAfVbHxJTAkpOjR
         bFiaj49TLoUmXz50hHl/5dwzxButCVFM8yeIw6pGwP/VnDadugin6h75nubMSCJcAFqO
         jY17KorelU5Yco4R8uyif+WIeJveoSTMmVpvqNg2IGuEPh6AEA1HXRbFShVjnA2Ncrhu
         uH+qklVmhowQvcKcP5AUrwxWYPH+BSK1kwjb0JAjJKGJmLV9xrQZONTw0SAGUCP+iOuo
         n96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iza7ai+1pJVkOiREPpK3tUFt/+4KEOcT4kmdIoRu1W4=;
        b=TwN/OCM9G3/aUsninRqdm/VQBTQ9stQa8+Gy5yj5dZahAQKjQEjKM+yMV7hfzKWMsx
         Vpa7tH0h6hcXgh/ziuqQdMHKkpmMkTBzHaRkA35Nua9qLLtsBDAEAYHbRTPJQAkel3fW
         bjXXYYGs0GhYoxd9b+ZxKv0tuUAeDhmYW8NrdT2gp4RNr8Cwn9G/u3bnYTKxdjySm36p
         wmmlnqITQMYPiYoNePaFJCz34S0hBelHmdK1XmkqEnuiDlD6t8gSerZlP9osGjuBpVV+
         nY58YrQdcasQ/ualDCd/X3yz6/QXdIgg/y1B44CyQBw2jMVFzKLuRZUVPlfIHa/hUSX0
         qwxg==
X-Gm-Message-State: AOAM533IR2K1Bp3UwCEtuWQJWLwz1eVtgTlpKx8eb38wjH2oCJN5UV3W
        VC3sSI5gQdzaU+03YF6YO3eh3g==
X-Google-Smtp-Source: ABdhPJyyu67AxXul4I8BEhqNEVWy7+2JiEYaRD6cGbSWv/kOI2QhFIZt2cXoy+7w3p9jk6gaghyMpw==
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr8923805wmg.154.1611232781283;
        Thu, 21 Jan 2021 04:39:41 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 04:39:40 -0800 (PST)
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 08/10] dt-bindings: document stall property for IOMMU masters
Date:   Thu, 21 Jan 2021 13:36:22 +0100
Message-Id: <20210121123623.2060416-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On ARM systems, some platform devices behind an IOMMU may support stall,
which is the ability to recover from page faults. Let the firmware tell us
when a device supports stall.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../devicetree/bindings/iommu/iommu.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 3c36334e4f94..26ba9e530f13 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -92,6 +92,24 @@ Optional properties:
   tagging DMA transactions with an address space identifier. By default,
   this is 0, which means that the device only has one address space.
 
+- dma-can-stall: When present, the master can wait for a transaction to
+  complete for an indefinite amount of time. Upon translation fault some
+  IOMMUs, instead of aborting the translation immediately, may first
+  notify the driver and keep the transaction in flight. This allows the OS
+  to inspect the fault and, for example, make physical pages resident
+  before updating the mappings and completing the transaction. Such IOMMU
+  accepts a limited number of simultaneous stalled transactions before
+  having to either put back-pressure on the master, or abort new faulting
+  transactions.
+
+  Firmware has to opt-in stalling, because most buses and masters don't
+  support it. In particular it isn't compatible with PCI, where
+  transactions have to complete before a time limit. More generally it
+  won't work in systems and masters that haven't been designed for
+  stalling. For example the OS, in order to handle a stalled transaction,
+  may attempt to retrieve pages from secondary storage in a stalled
+  domain, leading to a deadlock.
+
 
 Notes:
 ======
-- 
2.30.0

