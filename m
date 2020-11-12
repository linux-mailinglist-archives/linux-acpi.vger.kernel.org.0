Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552992B05DB
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 14:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgKLNDd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 08:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgKLND0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 08:03:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7FC061A49
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 05:03:25 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so5457383wme.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 05:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YNIotbOC7bka5Z9BLnFVmsCtOLB6kJ/rhFA9CsCNoBU=;
        b=QZfgK97B8RvBj1vgMXgdtAlJTXGErNY2MHWaYeZJYcihAKpzxznX+f3QupErxyW+y7
         vl5dFcj/SwiTM7AoiBl8Ekh/VI2I+MV6RRDXOcrbDCGTkeMw66SFzS1DgJvxjcaDuKjk
         2bmfttuRd5KL3r+eSvLlVqZxie8jGCaK6VIEInNDm+bzEK1xUWxTL3t2xMOYv4Bass5p
         gBiBnUXUjVBFvCB1BrWOR56d6TtjFa2TYTFOwxI7fDliFlDQVEIWqgTYl5sIlbDUR1ej
         iCxbPa+0gIBZXHXjDH2ssbGlbO7TSEgUjnx9UYgYtW9ALf/I+qK3xCqik9HnPlfBcF/J
         Vzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YNIotbOC7bka5Z9BLnFVmsCtOLB6kJ/rhFA9CsCNoBU=;
        b=LCWt2+wIzmTizZbMKjPeYDx7TZ5/GYKPgJCuRlIO1r+2S+5zsA22dH66sl1a253hY2
         CaLGWl3/y8jbQXx6Gol7TGKdwIMfAOyixWARWWPhkr7/eaKKb/ldovnTHyLD2LJADFyu
         CteKoY4P3oLXip+jVx+SE7qSHefSMtjYvTXRQePAo02IUymHTNJ1kyaMTRN7pzouowPk
         OH7tTLvMspl3dz4HiBdsPUrlyPChaReVi6Iekt3Cjhw8VmYDv8qI4SJEDt1c1qaMsylG
         xUJWmOjJz9yXTa41exEdMy9NReiPb/gKrVeBoiNWPygA2W0FQG16rBfipAEOMZLosrZ1
         pPLA==
X-Gm-Message-State: AOAM531ezwZjl1guBmqKeDvIjKIo5dJWR8tij0okZACMtMpc4qA6gPmp
        E0M0UBf/0RxWmdLlUMfe86SPby+zRHsCnA==
X-Google-Smtp-Source: ABdhPJwEuQSW7wZd81DIymTmLqqJtRteXgrSKTo8T+v6vTfsJF7cOILOIkbIrFkOfcCnh2vnSQXfbA==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr9104219wml.149.1605186204490;
        Thu, 12 Nov 2020 05:03:24 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:23 -0800 (PST)
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
Subject: [PATCH v8 7/9] PCI/ATS: Add PRI stubs
Date:   Thu, 12 Nov 2020 13:55:19 +0100
Message-Id: <20201112125519.3987595-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
support for PRI.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
adding more #ifdefs to the SMMU driver.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index df54cd5b15db..ccfca09fd232 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -30,6 +30,13 @@ int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 bool pci_pri_supported(struct pci_dev *pdev);
 #else
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{ return 0; }
 static inline bool pci_pri_supported(struct pci_dev *pdev)
 { return false; }
 #endif /* CONFIG_PCI_PRI */
-- 
2.29.1

