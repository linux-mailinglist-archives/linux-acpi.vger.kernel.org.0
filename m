Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125688DFF3
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfHNVb6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 17:31:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39227 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbfHNVbl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 17:31:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so452537wra.6
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 14:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4cBPfAkm3JGwK6tgjgZG/bf6hqDAaKM4pHE2P3hoSk=;
        b=IzB0n5cxejX7FsmAgsYL/PI3Ag86wOlNembVe5Oz+REyMC+yL8ILlHxRxsyOIGPqaZ
         bB5kuA9siSa7VxMnUM8Z6oSQObFxQr+es5v/rKo6PuHY1zoeiEomnUtqS6XU4NYnF5vw
         AWwNpxMbimtq2ZDFEaiNmBAawIDazEt0/FcJw2hik4GrSinotuwaI5AakPHTWODgW/En
         uWIA0hs+lQNj1fUPJgkmhTEHYsEmQTILAAxcflz2avsWSITh8M3EoPW21lCl9LknQH9x
         g+crMzLk3gsFoUXKqQYagfPEz/W6gTUpUdQJuhWnc7fuxXQNOKlmmk9k7xLXIDtDXSC1
         BHLQ==
X-Gm-Message-State: APjAAAU2CjMQ9BuP3SJFV3bRMlpaERTj49O71d9pYjKo8e7sRUdrBR/u
        a7sSEb5ljBF6Dq4qXBBdDce1aQ==
X-Google-Smtp-Source: APXvYqymBPN2fOiVKvJ95+sArRHW7L8w/SOhnKONfuNY4jEYxmOQid0DtmsLelmU+LjZAjug4enZtg==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr1774830wrs.88.1565818298960;
        Wed, 14 Aug 2019 14:31:38 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:38 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 6/7] drm/nouveau/pci: save the boot pcie link speed and restore it on fini
Date:   Wed, 14 Aug 2019 23:31:17 +0200
Message-Id: <20190814213118.28473-7-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814213118.28473-1-kherbst@redhat.com>
References: <20190814213118.28473-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Apperantly things go south if we suspend the device with a different PCIE
link speed set than it got booted with. Fixes runtime suspend on my gp107.

This all looks like some bug inside the pci subsystem and I would prefer a
fix there instead of nouveau, but maybe there is no real nice way of doing
that outside of drivers?

v2: squashed together patch 4 and 5
v3: only restore pcie speed on machines with runpm
    add NvRunpmWorkaround config option to disable the workaround

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com> (v2)
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 .../drm/nouveau/include/nvkm/core/device.h    |  2 +
 .../gpu/drm/nouveau/include/nvkm/subdev/pci.h |  8 ++--
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/clk/base.c    |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/base.c    |  9 ++++-
 .../gpu/drm/nouveau/nvkm/subdev/pci/pcie.c    | 38 ++++++++++++++++---
 .../gpu/drm/nouveau/nvkm/subdev/pci/priv.h    |  2 +
 7 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/device.h b/drivers/gpu/drm/nouveau/include/nvkm/core/device.h
index 6d55cd0476aa..4fb3f972ff97 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/device.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/device.h
@@ -125,6 +125,8 @@ struct nvkm_device {
 	u8  chiprev;
 	u32 crystal;
 
+	bool has_runpm;
+
 	struct {
 		struct notifier_block nb;
 	} acpi;
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
index b29101e485f9..56e73412fe4a 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
@@ -26,8 +26,9 @@ struct nvkm_pci {
 	} agp;
 
 	struct {
-		enum nvkm_pcie_speed speed;
-		u8 width;
+		enum nvkm_pcie_speed cur_speed;
+		enum nvkm_pcie_speed def_speed;
+		u8 cur_width;
 	} pcie;
 
 	bool msi;
@@ -52,6 +53,7 @@ int gk104_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 int gp100_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 
 /* pcie functions */
-int nvkm_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8 width);
+int nvkm_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8 width,
+		       bool save);
 enum nvkm_pcie_speed nvkm_pcie_get_speed(struct nvkm_pci *);
 #endif
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 7c2fcaba42d6..16441c5bf29c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -675,6 +675,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 
 	if (nouveau_atomic)
 		driver_pci.driver_features |= DRIVER_ATOMIC;
+	device->has_runpm = nouveau_pmops_runtime();
 
 	drm_dev = drm_dev_alloc(&driver_pci, &pdev->dev);
 	if (IS_ERR(drm_dev)) {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 40e564524b7a..1a524ffa77a3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -278,7 +278,7 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int pstatei)
 	nvkm_debug(subdev, "setting performance state %d\n", pstatei);
 	clk->pstate = pstatei;
 
-	nvkm_pcie_set_link(pci, pstate->pcie_speed, pstate->pcie_width);
+	nvkm_pcie_set_link(pci, pstate->pcie_speed, pstate->pcie_width, true);
 
 	if (fb && fb->ram && fb->ram->func->calc) {
 		struct nvkm_ram *ram = fb->ram;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
index ee2431a7804e..d9fb5a83f7d2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
@@ -90,6 +90,8 @@ nvkm_pci_fini(struct nvkm_subdev *subdev, bool suspend)
 
 	if (pci->agp.bridge)
 		nvkm_agp_fini(pci);
+	else if (pci_is_pcie(pci->pdev))
+		nvkm_pcie_fini(pci);
 
 	return 0;
 }
@@ -100,6 +102,8 @@ nvkm_pci_preinit(struct nvkm_subdev *subdev)
 	struct nvkm_pci *pci = nvkm_pci(subdev);
 	if (pci->agp.bridge)
 		nvkm_agp_preinit(pci);
+	else if (pci_is_pcie(pci->pdev))
+		nvkm_pcie_preinit(pci);
 	return 0;
 }
 
@@ -193,8 +197,9 @@ nvkm_pci_new_(const struct nvkm_pci_func *func, struct nvkm_device *device,
 	pci->func = func;
 	pci->pdev = device->func->pci(device)->pdev;
 	pci->irq = -1;
-	pci->pcie.speed = -1;
-	pci->pcie.width = -1;
+	pci->pcie.cur_speed = -1;
+	pci->pcie.def_speed = -1;
+	pci->pcie.cur_width = -1;
 
 	if (device->type == NVKM_DEVICE_AGP)
 		nvkm_agp_ctor(pci);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
index 03be24930c0e..d6b7ad6a8d0d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
@@ -23,6 +23,8 @@
  */
 #include "priv.h"
 
+#include <core/option.h>
+
 static char *nvkm_pcie_speeds[] = {
 	"2.5GT/s",
 	"5.0GT/s",
@@ -85,6 +87,13 @@ nvkm_pcie_oneinit(struct nvkm_pci *pci)
 	return 0;
 }
 
+int
+nvkm_pcie_preinit(struct nvkm_pci *pci)
+{
+	pci->pcie.def_speed = nvkm_pcie_get_speed(pci);
+	return 0;
+}
+
 int
 nvkm_pcie_init(struct nvkm_pci *pci)
 {
@@ -105,14 +114,31 @@ nvkm_pcie_init(struct nvkm_pci *pci)
 	if (pci->func->pcie.init)
 		pci->func->pcie.init(pci);
 
-	if (pci->pcie.speed != -1)
-		nvkm_pcie_set_link(pci, pci->pcie.speed, pci->pcie.width);
+	if (pci->pcie.cur_speed != -1)
+		nvkm_pcie_set_link(pci, pci->pcie.cur_speed,
+				   pci->pcie.cur_width, false);
+
+	return 0;
+}
+
+int
+nvkm_pcie_fini(struct nvkm_pci *pci)
+{
+	struct nvkm_device *device = pci->subdev.device;
+	if (!device->has_runpm)
+		return 0;
+
+	if (!nvkm_boolopt(device->cfgopt, "NvRunpmWorkaround", true))
+		return 0;
 
+	if (!IS_ERR_VALUE(pci->pcie.def_speed))
+		return nvkm_pcie_set_link(pci, pci->pcie.def_speed, 16, false);
 	return 0;
 }
 
 int
-nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
+nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width,
+                   bool save)
 {
 	struct nvkm_subdev *subdev = &pci->subdev;
 	enum nvkm_pcie_speed cur_speed, max_speed;
@@ -146,8 +172,10 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
 		speed = max_speed;
 	}
 
-	pci->pcie.speed = speed;
-	pci->pcie.width = width;
+	if (save) {
+		pci->pcie.cur_speed = speed;
+		pci->pcie.cur_width = width;
+	}
 
 	if (speed == cur_speed) {
 		nvkm_debug(subdev, "requested matches current speed\n");
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h
index 162ed5dc6fc3..85be0594f11b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h
@@ -60,5 +60,7 @@ enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
 int gk104_pcie_version_supported(struct nvkm_pci *);
 
 int nvkm_pcie_oneinit(struct nvkm_pci *);
+int nvkm_pcie_preinit(struct nvkm_pci *);
 int nvkm_pcie_init(struct nvkm_pci *);
+int nvkm_pcie_fini(struct nvkm_pci *);
 #endif
-- 
2.21.0

