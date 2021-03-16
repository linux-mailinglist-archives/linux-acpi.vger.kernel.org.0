Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5DB33DD43
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Mar 2021 20:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhCPTTH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Mar 2021 15:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbhCPTS5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Mar 2021 15:18:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195AC061756
        for <linux-acpi@vger.kernel.org>; Tue, 16 Mar 2021 12:18:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d191so158722wmd.2
        for <linux-acpi@vger.kernel.org>; Tue, 16 Mar 2021 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5nF/sXmMcwkw/ixJn1wgxDWeReE+TQab+n6/wXS1U0=;
        b=oaMK9nYnTAZy6ym3HYBmsqWuTVnMYutZ/U+My/vKZTXWBNQa3kUp/CciNiv42oBJY0
         sz/3nwTqT77ad0BK6/aNftjxGpd+x5BnQ08enNqXaOj6sYNydPxIwAdUYSmBMMdHknaJ
         3lTnRODxiPkto6n3IX3caXRjSWSazO2ZyYuFTmm2Z8jGfNqMpX2X4pzRd4+2GzuiV3at
         le5h53LvdTcx4ZjtnQNcJlulO36rZ/2LAjIsCcNWdtBEiPFwHj30zOJ9APBb0G7Xy2g9
         V3t8uyrFrYicbRxD3jwfVfuIs4jbNaFzW7lHPH02gBcOy9b2DQZMVtEbZKfz0FBvkYvI
         3hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5nF/sXmMcwkw/ixJn1wgxDWeReE+TQab+n6/wXS1U0=;
        b=rjKC1oqr8H+q5KOC7aV0TTYTUETGmAV9pekMZU6T/LrLTIzJfUhsj/BeabYqiDIPNw
         ltufcFZSbjw5BBtiPuVv30eYeAKteffDSwBor+YDtoV5y+Vv+x10uel9da9OhqaBq3O0
         0Yo5jAwXCBPUTrC6/d9Bi9zVY9GmLZf3fYhl/urYnpYjKpb1oNMgO2gAJYsDUWq5GDxC
         edb465Bx/RWSFnSapiKzZK11n3Fb+xsUw4Pxkbm3l6niZSN2ee3V2ar268XDDbJQBsR/
         fl/xelnrAblMbhDEkIsVfI9dPebXxo0HolYW+eWGXLsaw6QWdp3a6KBDoGdOBRzE2qSk
         DYaA==
X-Gm-Message-State: AOAM530ndk6p5pMsW/UnKrByBjsqlFC8bgXPClmNx/K2IGJ96/VN0H/b
        9i6JzFoZONrpj0TQz8r5dl6m8Q==
X-Google-Smtp-Source: ABdhPJwrnc/yoYhLqyVbf/ctwV9VfvVZmgZLZUJT5ACgoolGvh6o3uWH6IcGtVOst4Ix4VaYd5EPVQ==
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr308127wmq.183.1615922335734;
        Tue, 16 Mar 2021 12:18:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p12sm22690438wrx.28.2021.03.16.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:18:55 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        jean-philippe@linaro.org
Subject: [PATCH 3/3] iommu/virtio: Enable x86 support
Date:   Tue, 16 Mar 2021 20:16:54 +0100
Message-Id: <20210316191652.3401335-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316191652.3401335-1-jean-philippe@linaro.org>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

With the VIOT support in place, x86 platforms can now use the
virtio-iommu.

The arm64 Kconfig selects IOMMU_DMA, while x86 IOMMU drivers select it
themselves.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 2819b5c8ec30..ccca83ef2f06 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -400,8 +400,9 @@ config HYPERV_IOMMU
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
-	depends on ARM64
+	depends on (ARM64 || X86)
 	select IOMMU_API
+	select IOMMU_DMA if X86
 	select INTERVAL_TREE
 	select ACPI_VIOT if ACPI
 	help
-- 
2.30.2

