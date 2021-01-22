Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F32FF9EA
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 02:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhAVBZ6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 20:25:58 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:53322 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbhAVBZ5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 20:25:57 -0500
Received: by mail-pj1-f51.google.com with SMTP id p15so2777382pjv.3;
        Thu, 21 Jan 2021 17:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5NpNlGa3I0qkHyy2QB3q+Z/xyRt8oG1MuCOXMzxPu8=;
        b=IQxzJ/mRccCSUINGPSbLKi4DnSIFmlsGU8EY8VrfKiDvkgMkJa+KgsPX1HAHt0gUyH
         24lTX0T5Ot0y8c6AVJWiUdcWNXK/waALaMr2GvLpit2lYsesaDlWW5zZRlEWvM5qK48+
         u7DnMeEdHj7GLYvzhg0kNeNizjVYgBygv+SujdwyAvvp7cKJYzbh5dFqOn0ckgLHCSZx
         4+BcW25KX792A8JYmbwZvFrwOXVuDQVTvcQfbhvVKEbSRYD76US99pb2olmde5MzhNDq
         74eQHvfVMHOA55L4VEH21cqZJH2trfpjv78+Yahs24BmkMq512uOaH8Poh7Yf3870QPy
         FEpA==
X-Gm-Message-State: AOAM533tjvw2FgojYZcOirhvD9wOKrW1sI/DZcLxtENUtvBPYlaXBuhA
        tLL4IYqxuGAXWNVu5un5tCk=
X-Google-Smtp-Source: ABdhPJz3UXnYmYKNarrOmQCLINP1h4cQaCgD44wAGsr0k2OSqvTwTnWp/b6YUHRSH27EhFpVzeH5ZQ==
X-Received: by 2002:a17:90b:33c4:: with SMTP id lk4mr2543290pjb.157.1611278716928;
        Thu, 21 Jan 2021 17:25:16 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id y22sm6321738pfb.132.2021.01.21.17.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 17:25:16 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     lorenzo.pieralisi@arm.com
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, moritzf@google.com, will@kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2] ACPI/IORT: Do not blindly trust DMA masks from firmware
Date:   Thu, 21 Jan 2021 17:24:19 -0800
Message-Id: <20210122012419.95010-1-mdf@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Address issue observed on real world system with suboptimal IORT table
where DMA masks of PCI devices would get set to 0 as result.

iort_dma_setup() would query the root complex'/named component IORT
entry for a DMA mask, and use that over the one the device has been
configured with earlier.

Ideally we want to use the minimum mask of what the IORT contains for
the root complex and what the device was configured with.

Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v1:
- Changed warning to FW_BUG
- Warn for both Named Component or Root Complex
- Replaced min_not_zero() with min()

---
 drivers/acpi/arm64/iort.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index d4eac6d7e9fb..2494138a6905 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1107,6 +1107,11 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
 
 	ncomp = (struct acpi_iort_named_component *)node->node_data;
 
+	if (!ncomp->memory_address_limit) {
+		pr_warn(FW_BUG "Named component missing memory address limit\n");
+		return -EINVAL;
+	}
+
 	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
 			1ULL<<ncomp->memory_address_limit;
 
@@ -1126,6 +1131,11 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
 
 	rc = (struct acpi_iort_root_complex *)node->node_data;
 
+	if (!rc->memory_address_limit) {
+		pr_warn(FW_BUG "Root complex missing memory address limit\n");
+		return -EINVAL;
+	}
+
 	*size = rc->memory_address_limit >= 64 ? U64_MAX :
 			1ULL<<rc->memory_address_limit;
 
@@ -1173,8 +1183,8 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 		end = dmaaddr + size - 1;
 		mask = DMA_BIT_MASK(ilog2(end) + 1);
 		dev->bus_dma_limit = end;
-		dev->coherent_dma_mask = mask;
-		*dev->dma_mask = mask;
+		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
+		*dev->dma_mask = min(*dev->dma_mask, mask);
 	}
 
 	*dma_addr = dmaaddr;
-- 
2.30.0

