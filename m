Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17929303607
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 06:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbhAZF6K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 00:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbhAYMuX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 07:50:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DACC061354
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 03:08:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a1so11880514wrq.6
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 03:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iza7ai+1pJVkOiREPpK3tUFt/+4KEOcT4kmdIoRu1W4=;
        b=fzAYzsIviLsnsdHkwnDD4zLK+G98O29ATNRd/oDswbowaY7Zr+nLaOcFcmXmf/bj2w
         sN5e/n3UT20Fr7KGxcyNYL303yAvJlogHiVtLgMj77MlPdSuYi0HnX/67z3hcp3eSnvq
         6kNOn44rjrxRPk6uUBmXRSa0IA+4zGDWl9YWMyRArq4MyJGnCsb8/+uHR9Idp9Kiu6Lg
         66pDSi3HhXCfpnVf2sDoKPzg4CMYQh1IAjWuFBrDf/8dfeBlJOKz1mZAKZXCVMehWrzE
         W2wpnBuYldvz0puu5+hXREtPgOQTBgA611k1XcR4jfdmMFLTxChzyjB04qECL/Q97yvB
         9gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iza7ai+1pJVkOiREPpK3tUFt/+4KEOcT4kmdIoRu1W4=;
        b=jZM5XoiSqSJ+yoQTCYY9whst7ULxiUbumbCql9kuRVv/YdJ+Fz8j2oVymWGtMN9EGB
         uxKa7DM5DU4j91EQYJA7sNh4BnifeDQNwFrCSQeRTn0WpEihpEs9+Maeuct2RTnoNEST
         Zu2TCZzIQk9zD5zbXlbtBtP5fAFJjI1aB0B7RlgUeXKWZgXP46bs21Sk+IZkj0uMpQsQ
         eFGGrugxoPvhm+PREOxLwE77P6fGfYGiGfgh0Wk4zTxZ7lYZuLPm7eTSDBBi5pvR9NyN
         K8yEu/cQhyPyie8ZPwNoIPKgy2+JTeypdBVMOK6YpnU0wrxjKDNP3ehTGydM9htkk2uI
         xAMw==
X-Gm-Message-State: AOAM530FWaiq1MwLOUe80eEMXKkbuAfEXlsdLuyOaq3E7pe0C8f5VTYy
        q12xmPPcX0iD6Vd6nOxRYdEYSE25jNEbqQ==
X-Google-Smtp-Source: ABdhPJy5f//eiJub6eaRvFPmpLLEWtAjFwGFdZCIc36qdqavYTJmd6vDKljNYCIOSv4uyC5e0tiFcQ==
X-Received: by 2002:adf:b1da:: with SMTP id r26mr348225wra.198.1611572931725;
        Mon, 25 Jan 2021 03:08:51 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u6sm16636014wro.75.2021.01.25.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 03:08:51 -0800 (PST)
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
Subject: [PATCH v11 08/10] dt-bindings: document stall property for IOMMU masters
Date:   Mon, 25 Jan 2021 12:06:49 +0100
Message-Id: <20210125110650.3232195-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125110650.3232195-1-jean-philippe@linaro.org>
References: <20210125110650.3232195-1-jean-philippe@linaro.org>
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

