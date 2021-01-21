Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5EE2FF467
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbhAUTTc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 14:19:32 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:54055 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbhAUTQ5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 14:16:57 -0500
Received: by mail-pj1-f49.google.com with SMTP id p15so2259948pjv.3;
        Thu, 21 Jan 2021 11:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=woffDF3uhRUDrdb3LU2Pk/FCA9mpI3Ytb8KoYeIYJeA=;
        b=IIU02koRSEoT4q8Q9ehofpACmz28KHNp5Hoo0ciG0PZFexGoI6CrB1+Xk8QwfjWevd
         9aPp+easnrBYUHsSJIoIo5AZOwH4mPI85IjM6Ovh61PWTrjXE44HqZs+mr6em35jqaGa
         EeVgBUpgL7u15YnhNnXXicdzfmcBNZVH/5hhEM6nJH9R/8cjNC82E6c1SJ8m8Hb7dzhj
         kW7zpezLwdNWgixcStg0onr3zTfVOjazOP4jvjxtUhUy8p1UkfN8poImx0/JPZeNNM7F
         CGpMvXkKLf2j/lGXklS4Pm7FZva+fP1Pv0UbuLcOFEZMPdqgj79+Ud8h2x7I8r05/afi
         hWWg==
X-Gm-Message-State: AOAM532jzK13OBfeXyDxm8FOvUju0u68R+8+TuzkaEgVQ8MogjADldH+
        SIlsGdWLRU0Jex1oyeVCbaY=
X-Google-Smtp-Source: ABdhPJzI8AJqE+iWCmW+gyRA1cuwSUSwg+34G/hZ8dWOKvbeMCOrdJpb6lBYekcwpzJj0GgfI7rBMw==
X-Received: by 2002:a17:902:6b0a:b029:dc:31af:8dc3 with SMTP id o10-20020a1709026b0ab02900dc31af8dc3mr1144525plk.41.1611256576405;
        Thu, 21 Jan 2021 11:16:16 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id w7sm6270590pfb.62.2021.01.21.11.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:16:15 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     lorenzo.pieralisi@arm.com
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, moritzf@google.com, will@kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] ACPI/IORT: Do not blindly trust DMA masks from firmware
Date:   Thu, 21 Jan 2021 11:16:12 -0800
Message-Id: <20210121191612.90387-1-mdf@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Address issue observed on real world system with suboptimal IORT table
where DMA masks of PCI devices would get set to 0 as result.

iort_dma_setup() would query the root complex' IORT entry for a DMA
mask, and use that over the one the device has been configured with
earlier.

Ideally we want to use the minimum mask of what the IORT contains for
the root complex and what the device was configured with, but never 0.

Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
Hi all,

not sure I'm doing this right, but I think the current behavior (while a
corner case) seems to also fail for 32 bit devices if the IORT specifies
64 bit. It works on my test system now with a 32 bit device.

Open to suggestions for better solutions (and maybe the
nc_dma_get_range() should have the same sanity check?)

Thanks,
Moritz

---
 drivers/acpi/arm64/iort.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index d4eac6d7e9fb..c48eabf8c121 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1126,6 +1126,11 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
 
 	rc = (struct acpi_iort_root_complex *)node->node_data;
 
+	if (!rc->memory_address_limit) {
+		dev_warn(dev, "Root complex has broken memory_address_limit\n");
+		return -EINVAL;
+	}
+
 	*size = rc->memory_address_limit >= 64 ? U64_MAX :
 			1ULL<<rc->memory_address_limit;
 
@@ -1172,9 +1177,9 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 		 */
 		end = dmaaddr + size - 1;
 		mask = DMA_BIT_MASK(ilog2(end) + 1);
-		dev->bus_dma_limit = end;
-		dev->coherent_dma_mask = mask;
-		*dev->dma_mask = mask;
+		dev->bus_dma_limit = min_not_zero(dev->bus_dma_limit, end);
+		dev->coherent_dma_mask = min_not_zero(dev->coherent_dma_mask, mask);
+		*dev->dma_mask = min_not_zero(*dev->dma_mask, mask);
 	}
 
 	*dma_addr = dmaaddr;
-- 
2.30.0

