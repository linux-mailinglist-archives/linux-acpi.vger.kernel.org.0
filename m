Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32541818AC
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Mar 2020 13:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgCKMrN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Mar 2020 08:47:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37609 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbgCKMrJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2020 08:47:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so1973645wme.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2020 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zesK78yJZWicqhUwQPL3V6IqJnaQGS4nHnDD923Fhg=;
        b=qpU0Jj2JGN061vUq5cRmJ2MXokC1AW2fzaoV1IqvSV4EPD/dGYLmROiwAk6c96x6vW
         3c/QS7+d0Xs5Hg4r7OeK7NtbyPvNPP+RLWm3RAqJWlVgADXkRpSmM4wionq4sZjhwfZ6
         QnTdAlc42Rps5J6oHni3fFRJiGfPdNWPPBRs7orE3Sad+mMLGwaOhdJfGJcCqrGm0Pka
         snPcqW+J2mj9avU/qFATUqel4P0ix1B8p1qv6emtgkrGOO7Rgx7QYRY1KdpBr/OIuiDx
         vjQs8+BI98JR4mQqH2dqqlxDjanzHaFD/KL4Szy9PMzsMwMolUfmEEz9VwmReUMISzJz
         hL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zesK78yJZWicqhUwQPL3V6IqJnaQGS4nHnDD923Fhg=;
        b=p1Vicx1AlhAI+J0LOKhIEDEAnOEiKdhJDhoU0UPbErwDbqZwM/e7SasKyJD/8wlGvW
         U1FpaF3p3+kQ4fpywDMOHDc/8Rzl4I8A2K+mj4w6AYBFQ5o+9llpuSZL5JUDQxo91NhF
         YWbBIjBBewpZWSyVsNzs4YBRih03A5LSVFZVwIuZExe6mtlf+CgDPyGkpNYNZKUe5B1j
         zdp96dl9RpyoX25k/lQcAm8rbGw/EUAvEAfdeB7skDWYR52SacQmwQqC5OPOJTmLMfeg
         8pRQ7HLgavMNOhC08xO5bk4eD2Z3ptZIsCaYa9BItEsCUSwfpI+XYTr0maMm9CbIemBD
         gjTQ==
X-Gm-Message-State: ANhLgQ1bw7XY7TQGQX3lmHPXAMLSoX8TUutLrgjySOdSdZUbD0Prkzyk
        zB0CBZqArwN1Op6hFeJ2I9AATg==
X-Google-Smtp-Source: ADFU+vvKRqzKojPsnzu47XlfEmFywvbZvI7bIuc0VHfmPVsSrBbWdmKhaDCO0TaazIr2/co3EoA9sw==
X-Received: by 2002:a1c:5fc5:: with SMTP id t188mr1007720wmb.110.1583930828211;
        Wed, 11 Mar 2020 05:47:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:47:07 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        joro@8bytes.org, baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 10/11] arm64: dts: fast models: Enable PCIe ATS for Base RevC FVP
Date:   Wed, 11 Mar 2020 13:45:05 +0100
Message-Id: <20200311124506.208376-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
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
 arch/arm64/boot/dts/arm/fvp-base-revc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 335fff762451..9171bf0254bf 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -170,6 +170,7 @@ pci: pci@40000000 {
 		iommu-map = <0x0 &smmu 0x0 0x10000>;
 
 		dma-coherent;
+		ats-supported;
 	};
 
 	smmu: smmu@2b400000 {
-- 
2.25.1

