Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106AD18187F
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Mar 2020 13:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgCKMrA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Mar 2020 08:47:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41915 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbgCKMq7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2020 08:46:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14so2425474wrt.8
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2020 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4gyYG6pd1qHC2GjZUAc/a5emn2edBGVA7chcRhvAO8=;
        b=R8RuT72WL1I4haJ6qD2A19NADfHGGL4h8E65a5bB32JeKEnVO9JbfE6y04C41FHnLL
         AiH3yxrWmV4b4ouGsgZnYDvH6JyHDntuFb3/9DvYzPs3xRWl9CkmzwGARwuOAyD3ENG8
         ExLs4O2EfRkqOxjujXUUTbIjhiAylBxQ8ybvym8Qyo1jwtRGcka/n1mIYt++nCi7pTJf
         r7VZnDbXLgsvy6IWe8+Hwi6VVKzu0VjNNczUmct/KxpEmMqWQtjtAeb2DhsSv3KYbkPr
         VSYMt4h9O6gpK0lYTWS8aMFDJFwbWDK7v4kkJazCh6yUcurLTvS7ONepD43137VO3oBz
         gmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4gyYG6pd1qHC2GjZUAc/a5emn2edBGVA7chcRhvAO8=;
        b=KZPI7Fl6YyM0iTiq6LmA4VIVi5jm6xnw6ItCpJtCt2fgToLra0X9vTeu1hCqmEoSmG
         3FoBF1V8zZkrRgVUYQ2aoLvpZUPUJm6q231+kAE4MYOYvl/26A6GKQYmryNjC8i++FwI
         jwHG/s/a9N0t6iFahIJJERW/SWv+jP3Psx3V7vvIogMjG5Rj/MHce0DWVMY4q40r03AP
         ZqXVA0AbCqLQ/oXFtAx5KfekyqJnB0O4c92Q7ViUUttxt2cdXOyfqGDz+gnhlXYT1roS
         Kh6AuQLWTDmUThSGKofhUcScbOqLJsw9ostSXRonkHfFPEBtT7vrl4IMdwCFbHOb0cQH
         QjtA==
X-Gm-Message-State: ANhLgQ0oMpFlHQjXwOuvKaYUXLSUlx3dDDJkqFvC8WtX7GCQxM1R3QMz
        uaK4+ZzQI3PQhQZiKuyuDQG2iQ==
X-Google-Smtp-Source: ADFU+vtVplsLJKhJ5k96cjG7bQIJiqMwH6aOvBxLDVX3vK8y4Ou+veGu1hCYgxMQXp8PN1ugVbeDHg==
X-Received: by 2002:adf:a555:: with SMTP id j21mr4427467wrb.409.1583930817062;
        Wed, 11 Mar 2020 05:46:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:46:56 -0700 (PDT)
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
Subject: [PATCH v2 02/11] PCI: Add ats_supported host bridge flag
Date:   Wed, 11 Mar 2020 13:44:57 +0100
Message-Id: <20200311124506.208376-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Each vendor has their own way of describing whether a host bridge
supports ATS.  The Intel and AMD ACPI tables selectively enable or
disable ATS per device or sub-tree, while Arm has a single bit for each
host bridge.  For those that need it, add an ats_supported bit to the
host bridge structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: try to improve the comment
---
 drivers/pci/probe.c | 8 ++++++++
 include/linux/pci.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..b5e36f06b40a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -598,6 +598,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+
+	/*
+	 * Some systems (ACPI IORT, device-tree) declare ATS support at the host
+	 * bridge, and clear this bit when ATS isn't supported. Others (ACPI
+	 * DMAR and IVRS) declare ATS support with a smaller granularity, and
+	 * need this bit set.
+	 */
+	bridge->ats_supported = 1;
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..9fe2e84d74d7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -511,6 +511,7 @@ struct pci_host_bridge {
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
+	unsigned int	ats_supported:1;
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.25.1

