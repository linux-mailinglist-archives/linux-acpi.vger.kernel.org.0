Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2CB2EF471
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbhAHPDx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbhAHPDv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 10:03:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E7C0612A7
        for <linux-acpi@vger.kernel.org>; Fri,  8 Jan 2021 07:02:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v14so8060585wml.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jan 2021 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glgQFW7kM8hmWXtoybiQQhFk+nRduu62qvfDCI4eUuo=;
        b=MG97V7CT/lZ/B9evctCewK363gKZ+3KiM85e7mwnaEFFhfvdmANNctUZMCkWea6m2c
         y9JbDyd83+QZWNebbFl1XohTEAfiymYtPnr8I5QXFNso7vxshtjN+2Kr9XX7XfxRGoVF
         kdqbMiLyEnhELcyFWL33dIF+Z2j3VGFTU9ZwXiiuOzGxVt+wKTfopNOQMbOXSrcuq4G7
         +6zWzaEl3bBn0BXKGW/dKkLgc/pnTUQcYL7XdWY4dOlRa7cMWQLTLb/aivovSNEunw9Y
         iaVGDOQ9FEpEiOktUQU70rzBN9DAl+JxI8MySkT7XOjWQz3KypPDtDfUJFGenPxpQMV9
         XOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=glgQFW7kM8hmWXtoybiQQhFk+nRduu62qvfDCI4eUuo=;
        b=PjvSCWdIMhi5oQHV3lcqDtO5zrMecg9yO5o8CXSL/jdp2nlb/HBB/NCUynfGbE1WCt
         ZCcaIn/I1ACGCVDlpAF+ZhZ1JnPESAY+37nq5P3uBmuKyF7Ool4ymDuJaLfRnwiXDIaf
         BIG/2Vynl5aiYh4d2dyvCEnSJs3kYTmBcUJ66ctsBRBqCkVnZ4jogdmWWdKJBn+DlItq
         H9+ssawm45T272rqhRxLgV8/m8UxLYDvQcpqHOKW7VedhJUo1tec0bXgzcPJbWymC7zv
         bT8GYy6CVLvp67rCL85juQlCnSUb5BUYrwTVp6v252p8kfzx1ehq4sYZKN27GPXba9Jb
         bdAA==
X-Gm-Message-State: AOAM530huudkIa+6443h1sTz0w+K2XjARxb3dIOiRAKDeNerZJgXaqqc
        ApNFED6wYksYKmBbBfQNFUcycw==
X-Google-Smtp-Source: ABdhPJzqMQ5/Vme0bjJMr2Logxq8jK6Q7oFlWy2kXgzfP9ZlVTQt7eKTUQpSXxby55CCipER5aZqrw==
X-Received: by 2002:a1c:2d6:: with SMTP id 205mr3469208wmc.60.1610118159297;
        Fri, 08 Jan 2021 07:02:39 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:02:38 -0800 (PST)
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 08/10] dt-bindings: document stall property for IOMMU masters
Date:   Fri,  8 Jan 2021 15:52:16 +0100
Message-Id: <20210108145217.2254447-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
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
2.29.2

