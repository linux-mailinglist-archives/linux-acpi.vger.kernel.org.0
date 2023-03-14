Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D983C6B9BEF
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Mar 2023 17:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCNQoc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Mar 2023 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCNQob (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2023 12:44:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C4CA3F
        for <linux-acpi@vger.kernel.org>; Tue, 14 Mar 2023 09:44:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o12so64550581edb.9
        for <linux-acpi@vger.kernel.org>; Tue, 14 Mar 2023 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678812269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVoWSrSw8iWnvdsUsZm3Xc3V9c32i6G9JTNL1QjtlpM=;
        b=Q6clugfH2wohZW+/jssUotWY9EqeGyTOorxwY/50yJNmRT/yX+yr2l4b9WrkomV9M2
         KA6RYdkb+Z82ezcLYElhpJ9q/kHG8WcSsHjFPIxYg1AF657VKEpQLmQ1vxzciKLLC9aY
         FeDHZ8DC9Hv2G3jsbjPWgaicialWvwk8ZD1B9TQvcWNp7j6/3SSVtOiiugxciAUFRL39
         aHk41xve72YWPyQmkFDWXwXxXVidovtu8+hBDuR35WKuTKXs8zTWYNG+SLAe2060h0K/
         E9WKNP88fYFtJVfh4u3gJSf7uWNKIuPaA1uJvj70gU5vLYS60bdTxx5lnxdFmTbEmFu7
         JPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678812269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVoWSrSw8iWnvdsUsZm3Xc3V9c32i6G9JTNL1QjtlpM=;
        b=husAg+zu5C/Hlwj0QLmlCODp1/zICVYJN31KszcjRxEcvwY9xTSxW/VtRa6G1GvHD1
         sE5xtGdDAfQP+zPJXbwgMrQ7MdrJvAr+EcolnK8SGTRPjN4T2ThYW4PMUWXM3Rp7+Vz4
         AgZ8u5u5q/iGRj4qDAFHfI/RxI8R9KnHfT8AYYEKtMA9ofOtXh25+QAZBfZJ4MoNZj7Y
         8ROJlzBEgEjfDftBVxUnGZXqt1dptXTUxbfYQUlA+yKV1orVQGpaQFpidZuaBUtqjsUO
         gf0RgfLqzpNFQK6MwKDFi4UjUdQpC8p8AHXT/1VlK53wjyvp70PBkvrefQXbg11B0s2a
         d+Xg==
X-Gm-Message-State: AO0yUKUpjglysenlHy7XvbFXdsYkP5aGjpNMEg2edwvTGC3ZR8Z2wxLB
        BXj5kS9ndksSGJDDAi4Al0Gjyg==
X-Google-Smtp-Source: AK7set+yBLjEXWLeeOSy1YCkZG3vvlqho9+FJiah/pJcz/iWU3nnD6rKgcsZCn3D2SKW5QT0yWNd7A==
X-Received: by 2002:a17:906:816:b0:924:d90a:6f97 with SMTP id e22-20020a170906081600b00924d90a6f97mr3276207ejd.13.1678812268851;
        Tue, 14 Mar 2023 09:44:28 -0700 (PDT)
Received: from localhost.localdomain (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id u21-20020a170906409500b00928de86245fsm1351055ejj.135.2023.03.14.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:44:28 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     eric.auger@redhat.com, rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
Date:   Tue, 14 Mar 2023 16:44:16 +0000
Message-Id: <20230314164416.2219829-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When setting up DMA for a PCI device, we need to initialize its
iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
this we use pci_for_each_dma_alias() which calls
viot_pci_dev_iommu_init(). This function incorrectly initializes the
fwspec of the bridge instead of the device being configured. Fix it by
passing the original device as context to pci_for_each_dma_alias().

Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
This fixes issue (1) reported here:
https://lore.kernel.org/all/Y8qzOKm6kvhGWG1T@myrica/
---
 drivers/acpi/viot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index ed752cbbe636..c8025921c129 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -328,6 +328,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 {
 	u32 epid;
 	struct viot_endpoint *ep;
+	struct device *aliased_dev = data;
 	u32 domain_nr = pci_domain_nr(pdev->bus);
 
 	list_for_each_entry(ep, &viot_pci_ranges, list) {
@@ -338,7 +339,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
+			return viot_dev_iommu_init(aliased_dev, ep->viommu,
 						   epid);
 		}
 	}
@@ -372,7 +373,7 @@ int viot_iommu_configure(struct device *dev)
 {
 	if (dev_is_pci(dev))
 		return pci_for_each_dma_alias(to_pci_dev(dev),
-					      viot_pci_dev_iommu_init, NULL);
+					      viot_pci_dev_iommu_init, dev);
 	else if (dev_is_platform(dev))
 		return viot_mmio_dev_iommu_init(to_platform_device(dev));
 	return -ENODEV;
-- 
2.39.2

