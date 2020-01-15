Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CA13C1E7
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 13:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAOMxn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 07:53:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33574 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgAOMxm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 07:53:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so4707759wmd.0
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jan 2020 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0PTgEa8Z2EtxKNp+bXlU3gMIeIQMMd4dvAJJmx7ucE=;
        b=dHOXOKHoTxItty8Q5696Mr+qbLuMsFa+MTSqKPLipIvl2oTCGz6ML1mpeZ/hKlDF/w
         0zv4zm331wgT2+KoHIxNr0EbnRGGQsLvPJyytnYPhCnUUDZJbkaemFEkNnu+UetF8/hv
         V63rc3osvZrEsMSG1CYkzOLHHYC2msMAlTjspE9QoVjnwGTB+KftSreLBNSx3XxcNWWz
         7qWRy0hn5i3tRV6yEIj4f9s5mv4xFHEO4sLGFIYhAVyLWiQK84QoCPspbr09hIqHacJb
         keyJbpDsHaUOhTQQceVDxe4Do+EaZFZskEG7KV/7urpQlMM39SamhpMjxm3wKwlF46iZ
         BDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0PTgEa8Z2EtxKNp+bXlU3gMIeIQMMd4dvAJJmx7ucE=;
        b=ITVr3LftjVsvsnOVn6uQr6/vW/KnsudtAKCvfWk8xoPcGDRPW/F+AbUKy5/19atdI6
         geyBtw4Tm5GQp39bO6/AHlXdq4Kg0d5M/4dUlT9if5pLKQbfTQco+IJIpFuXlK8TEYJt
         RuBSpazIhMRuO0XA02XAv8D1Acz1GIgbzqLdf3sDqey3ZVwU6059tYp/6Dtl3TF1ZCR9
         4hi4yiezLeEYpi3VvkQVprWT609l+3AuezMQalyWENlCIUM+NyD5G82Bgx8Kp2z/kevS
         7PkeGqofNk6iBwAS/A4DtMMoo6//c2leMeFFA7IH6jPx2A8PK4uhkp6nY8161hjqDfYN
         m0Hw==
X-Gm-Message-State: APjAAAXVU2w4d8NaRNZXxVytIAmWiTHWIQIm1u749IldgHLNcQNkGUHi
        rcoxHFFaPfzkfjbgervpafKthQ==
X-Google-Smtp-Source: APXvYqw9Mt6OhEbO1QMqXTowh5t7SCfN3PgnBvH6KOJ1spMG2hboA0nCSsAfuEDMtgnKjfCtqj0iOg==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr34564949wmj.33.1579092821258;
        Wed, 15 Jan 2020 04:53:41 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:40 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 12/13] PCI/ATS: Add PASID stubs
Date:   Wed, 15 Jan 2020 13:52:38 +0100
Message-Id: <20200115125239.136759-13-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The SMMUv3 driver, which may be built without CONFIG_PCI, will soon gain
PASID support.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PASID stubs, and avoid
adding more #ifdefs to the SMMU driver.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 5d62e78946a3..d08f0869f121 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -33,6 +33,9 @@ void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
+static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
+{ return -EINVAL; }
+static inline void pci_disable_pasid(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
 { return -EINVAL; }
 static inline int pci_max_pasids(struct pci_dev *pdev)
-- 
2.24.1

