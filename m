Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22F42B05EE
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 14:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKLNDl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 08:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgKLNDa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 08:03:30 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8210CC0613D1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 05:03:28 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so5425908wmb.5
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 05:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVbQfn+wW1FJTP9+IaoEjGKkOhoG1CH1YVgrdlNJ6Sw=;
        b=AJNFqP/ZKhk6objxUUtP+6tvikca2WaZ6jTYQcqn0yvFmq93hZ3lVQHYyK7f33pXgE
         LMPNyvQtw49zSsYAQyGirgOmAjeKMdajdiJVAvrB0xvcpLKnNUh1Z8ZszvxyGNv+yFWO
         jRyaMPOhhzNbE3/mz7+lXJ3IhlCs6H3xrg7kN1+ZuHmW+evNoDn1JYTAFeNTCQVfBP6C
         UDXzfEZDz9yBRbmmCKA8RPN03ITbdvYu314gLJxyyi+H6Vek4EQpQ+DnwUjWmEWZQ4P7
         ecl6SKlD8ae4yC6bXIaFUH6JgCSMUZFZyPJSzMPNHa1vLYEGIy0ojNDIzjqoS0ABNNt4
         JmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVbQfn+wW1FJTP9+IaoEjGKkOhoG1CH1YVgrdlNJ6Sw=;
        b=fUNVzhcLLa4kByZg/qmAtHOW81XCgxDHcPemId0puEpv9EL5zTcsG3JJ0rU7Bxru8m
         0w8JHPs0PLmdEeRoHMlVUYzMQ4r9icaVz8W3kK2GQCAOLptDsMo2doY4el8MsEPOZGUu
         01qPh+1XBd+TO/rR3B0NQ2HHJfhkuXmwUeIIs1EbhuXOaAvG5EuVAXLylYm6mjvYQq2w
         qLCtpwffjgWinnaZgXmToUwZmbN/VnbSvYGjukWz6fYNtysdTvwz6L8OMglkumdFTNii
         tRZ5ne/J9ebusPsLi09XjzySQVi/5t26PbGadlxk8Dfck75Lv/tLmceyoqioxakooTKM
         sLSw==
X-Gm-Message-State: AOAM533eBwipoOwus7m9f+XpNCgup0nU3ZcogSQWzqOhGKTQreRyrjet
        YSHwGz4uIHYVCq1ZWkOWiPEZWw==
X-Google-Smtp-Source: ABdhPJxsDYTMbvBnnj6uOORdu3x6BbabxcW+EJNp1tzj8KBQp5jtE8PRmp5+1detfGdDqBG6DaNgNA==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr10063043wmc.159.1605186207268;
        Thu, 12 Nov 2020 05:03:27 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:26 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v8 8/9] PCI/ATS: Export PRI functions
Date:   Thu, 12 Nov 2020 13:55:20 +0100
Message-Id: <20201112125519.3987595-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The SMMUv3 driver uses pci_{enable,disable}_pri() and related
functions. Export those functions to allow the driver to be built as a
module.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 46bc7f31fb4d..e36d601015d9 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -191,6 +191,7 @@ void pci_pri_init(struct pci_dev *pdev)
 	if (status & PCI_PRI_STATUS_PASID)
 		pdev->pasid_required = 1;
 }
+EXPORT_SYMBOL_GPL(pci_pri_init);
 
 /**
  * pci_enable_pri - Enable PRI capability
@@ -238,6 +239,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -317,6 +319,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -332,6 +335,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 
 /**
  * pci_pri_supported - Check if PRI is supported.
-- 
2.29.1

