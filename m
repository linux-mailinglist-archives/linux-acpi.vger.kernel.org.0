Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 275168DFF4
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfHNVbi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 17:31:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39222 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbfHNVbi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 17:31:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so452426wra.6
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 14:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TzjYpMy9+0zUnyIhGVp0XLreAg3cbu7k5uuH85z42Y=;
        b=lqJcwGi/iKX6Lah1UkksoLcsXgLD/uhUBwIw8Uss8JrvxiFWoYJPAkZb1fobTj9XYb
         y+vU89DnGMwXNo++hidRXgwU0K1hqwUku4HLYBeF4mCjzw2JjU41fR/uAvlOHAW2BtdI
         4GcqlRnwQlQtCLMfEAKjMFECsFOOK3um0ePjeVp83fpYsJZ8KyCns/iNYxb+XsNwuxAp
         JxxEpCqvNdYXAgMPE9hNQbYDMMvfNB18uyKmmMf5eIyVtbbF24veKGbOYVmDKR/y3hld
         QoaQjizehq5V4UwC751G5DTq2engF2RFFSZns2nT0/dssaSEjviVPJgqASDVf2R5i1jC
         BA2w==
X-Gm-Message-State: APjAAAW5IXN1bp1W1PhUJxd0jX3TqGwc+HWjBnkZDnC7MU6L1Q34nfyT
        fVGznSZZ5615k4fvCkoi7VvwWkRcV4s=
X-Google-Smtp-Source: APXvYqzZayfXMMmK+XvZtOaSr4FuQVJXXrQ0d8j9SpvLi3XGme93Isve666keCnmVjrWEvMt/EDx6g==
X-Received: by 2002:a5d:4284:: with SMTP id k4mr1733516wrq.6.1565818296138;
        Wed, 14 Aug 2019 14:31:36 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:26 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4/7] drm/nouveau/pci: enable pcie link changes for pascal
Date:   Wed, 14 Aug 2019 23:31:15 +0200
Message-Id: <20190814213118.28473-5-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814213118.28473-1-kherbst@redhat.com>
References: <20190814213118.28473-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c |  8 ++++----
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c | 10 ++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h  |  5 +++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
index e68030507d88..664890185e15 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
@@ -23,7 +23,7 @@
  */
 #include "priv.h"
 
-static int
+int
 gk104_pcie_version_supported(struct nvkm_pci *pci)
 {
 	return (nvkm_rd32(pci->subdev.device, 0x8c1c0) & 0x4) == 0x4 ? 2 : 1;
@@ -108,7 +108,7 @@ gk104_pcie_lnkctl_speed(struct nvkm_pci *pci)
 	return -1;
 }
 
-static enum nvkm_pcie_speed
+enum nvkm_pcie_speed
 gk104_pcie_max_speed(struct nvkm_pci *pci)
 {
 	u32 max_speed = nvkm_rd32(pci->subdev.device, 0x8c1c0) & 0x300000;
@@ -146,7 +146,7 @@ gk104_pcie_set_link_speed(struct nvkm_pci *pci, enum nvkm_pcie_speed speed)
 	nvkm_mask(device, 0x8c040, 0x1, 0x1);
 }
 
-static int
+int
 gk104_pcie_init(struct nvkm_pci * pci)
 {
 	enum nvkm_pcie_speed lnkctl_speed, max_speed, cap_speed;
@@ -178,7 +178,7 @@ gk104_pcie_init(struct nvkm_pci * pci)
 	return 0;
 }
 
-static int
+int
 gk104_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
 {
 	struct nvkm_subdev *subdev = &pci->subdev;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c
index 82c5234a06ff..eb19c7a44561 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c
@@ -35,6 +35,16 @@ gp100_pci_func = {
 	.wr08 = nv40_pci_wr08,
 	.wr32 = nv40_pci_wr32,
 	.msi_rearm = gp100_pci_msi_rearm,
+
+	.pcie.init = gk104_pcie_init,
+	.pcie.set_link = gk104_pcie_set_link,
+
+	.pcie.max_speed = gk104_pcie_max_speed,
+	.pcie.cur_speed = g84_pcie_cur_speed,
+
+	.pcie.set_version = gf100_pcie_set_version,
+	.pcie.version = gf100_pcie_version,
+	.pcie.version_supported = gk104_pcie_version_supported,
 };
 
 int
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h
index 7009aad86b6e..162ed5dc6fc3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h
@@ -54,6 +54,11 @@ int gf100_pcie_cap_speed(struct nvkm_pci *);
 int gf100_pcie_init(struct nvkm_pci *);
 int gf100_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8);
 
+int gk104_pcie_init(struct nvkm_pci *);
+int gk104_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8 width);
+enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
+int gk104_pcie_version_supported(struct nvkm_pci *);
+
 int nvkm_pcie_oneinit(struct nvkm_pci *);
 int nvkm_pcie_init(struct nvkm_pci *);
 #endif
-- 
2.21.0

