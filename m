Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5176215C8CA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 17:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBMQwS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 11:52:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34133 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBMQwR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Feb 2020 11:52:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so148596wme.1
        for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2020 08:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WDMFZWW+h59RhGdVycD2Uyjz5YXns4ww4oPwlirB1xs=;
        b=RU6hP0YaDVyg76DpwMt8+kokjDNdYK4t+fP1NMy86wohTGSpgKGZzXz22INLcb/uTG
         SulDKPmxKjSDX9mM1ObcytxPc9qSyfmoSueNx1WrVr+i2pcQ0/1MH6MfZipjLCRNhZ4R
         QAAwV9AK52wzbuAFhJ4wwljXxMGU1D8fjkRr3xz5yGktVvdi91XDhvfsXom1xAiav9Ca
         9EsxU47a4H/ESMgWlgX459A9KaDdxI8GrFEiHciqdGPUqbJk6r0x0gm/NOt1/yOdfV8m
         TYI4DrH7cKX39puiAtvbmBg0t24nmt6J4GV1r4c9AeQkOhtGKMzU9MsecC3L+ojmCMyI
         c2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDMFZWW+h59RhGdVycD2Uyjz5YXns4ww4oPwlirB1xs=;
        b=hVyqADZ2PHsCefkc68tqTcDkElgREcKfQ625l7YgiS/k/yu36xUyXckPHmdrR+d7X0
         /ehaYvBlxtsFNKBII9FEiesFfhjmWgHd+XYFGhj/SICILF/N3J1r9ptPjwsZ4gpRjvEM
         jXsbNbshtUCAgUqccRcB5DDnVjRWS8AGp1F2SLMQNmhGcYl8VMvNIHGsgNk2xjB+ESPQ
         sVFU/nWIyeasZ54DwXJYCdTuvSeiyIQ5Ax/on4xDgSmIoS+CmbLVS97wOFbxqQDARyI7
         RW0Yyqj+SxE+zQIpD/FIOtaCjLzPQyWJ9R7OCKrgDIPeaYjAHHvugbAFCGxYt8W2OE/S
         Swug==
X-Gm-Message-State: APjAAAXqHX2EBevBuKqQab7oKkbOB7Nm9z03M+AI8juJ+rj9OTAWNt1M
        zrb3xjMpNYP8TJsduRy+hc0yQQ==
X-Google-Smtp-Source: APXvYqyTnYcfWPm44mmD/6D5Wm+c5cA7JDMBagRyfl9k+jEqNIeMmPTzO2182wwz9XUN7ktGp7/pbQ==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr6917432wmc.165.1581612735514;
        Thu, 13 Feb 2020 08:52:15 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:52:15 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: [PATCH 10/11] arm64: dts: fast models: Enable PCIe ATS for Base RevC FVP
Date:   Thu, 13 Feb 2020 17:50:48 +0100
Message-Id: <20200213165049.508908-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Declare that the host controller supports ATS, so the OS can enable it
for ATS-capable PCIe endpoints.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
All endpoints support ATS provided they have the ats_supported=1 model
parameter. "lspci -vv" shows whether ATS is supported and enabled.
---
 arch/arm64/boot/dts/arm/fvp-base-revc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 62ab0d54ff71..6e5bb7bcb4b3 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -170,6 +170,7 @@ pci: pci@40000000 {
 		iommu-map = <0x0 &smmu 0x0 0x10000>;
 
 		dma-coherent;
+		ats-supported;
 	};
 
 	smmu: smmu@2b400000 {
-- 
2.25.0

