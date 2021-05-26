Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A89391CE9
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhEZQXI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 12:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhEZQXI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 12:23:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7CC061574
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 09:21:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w12so2274838edx.1
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpxpWMnrPJKc07Z7A57L4cT+PGNv1GXXzLI4P6Yd1EE=;
        b=igtqyM//LYjdds1ytHCniCgg8zwXeW+EZ8GUvM0m2FRDNDeVRq9vskLXhwydDfk8I1
         Py+Iv1uCGEMhmYD2qpm+O2OSqMgjpeMutUiLdEcnWGKoeriIt/AE8DKSXYiTUxiyznbe
         FVzBP6qI4Px6bkTjqE0BruPZj/fjxlr0WhZ7KV8kWd9BbRvRG47PkuIFm0nrg1TTkArn
         T6b0IDjr4ltS+qRRAtM2FeMsHX0vCGj0W+xGELgKG65hDbF2uQlsZbnB1i5SVT38WK3o
         72JWxaT5VTxUZBWIrmWxI2hh1HFSn5kD6YQkLSO9vewdxJhgHUS2S/wf0yd5pzk65gzR
         1qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpxpWMnrPJKc07Z7A57L4cT+PGNv1GXXzLI4P6Yd1EE=;
        b=KwMbD1a2fmZCpmOTcx0Ti+OoiKCNn5TlhGNd82DfdLNI10gUk6AVmAHknobNO0X7rQ
         5j/sUIkqqP+p7hYFDyq0LcpqEefZhinoP9/m3K0B8qRBt5dZgpqyUdeYt7TP6lm8/A7h
         hbMzQoCJufSUJ1yCIAYlV3YeuLKloy+cUuWFPjfA7yEI/13dtToBeikjETp3vdy59ew9
         YhBveAbLvXVSXLynrRb5Q58GWcE1gEHMwZJ1Tqmt0RRGtSK7PXRwVOmvO7Ou3aM+IBvn
         AqBCwqEZ8JHtgQ7Z/ruuojJ/E5NJZouoih5GyRrEBsPurV9QlNV9zFt47rEpX6jGkD24
         lc1w==
X-Gm-Message-State: AOAM53257xidpNPfXmbnIMT0AADKYAXepkzjVsw7i8tDTsLn70mqaJhg
        2LXUswNjbEnaV8fGnabmqryUdA==
X-Google-Smtp-Source: ABdhPJzV0Ekj4Q8KGq3C6oAPDF07bqX/LfHaYKNeHot9cZ4TZoZePl+V6GNvhy0kwuByEYqcvxu6qg==
X-Received: by 2002:aa7:c152:: with SMTP id r18mr38149878edp.266.1622046094940;
        Wed, 26 May 2021 09:21:34 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
        by smtp.gmail.com with ESMTPSA id e6sm10497145ejd.31.2021.05.26.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:21:34 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v15 1/3] dt-bindings: document stall property for IOMMU masters
Date:   Wed, 26 May 2021 18:19:26 +0200
Message-Id: <20210526161927.24268-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526161927.24268-1-jean-philippe@linaro.org>
References: <20210526161927.24268-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On ARM systems, some platform devices behind an IOMMU may support stall,
which is the ability to recover from page faults. Let the firmware tell us
when a device supports stall.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
2.31.1

