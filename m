Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E150D8DFEF
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 23:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfHNVbm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 17:31:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34514 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfHNVbl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 17:31:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so4173751wme.1
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 14:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JS9FDqsk2E6RQCD4HkMjbuys2g4pNRCG7WFODU185bI=;
        b=WP7qTGhc5r5DTZn4z5uIV/vYPFO5L67bxY3M2zZ3jFENipGJh1FZENkRWpg5xhNBgx
         irRPbcwcgu6Syn0Vu1nEPdq5rHRnzcrMOwrKXaqUXOvCfylgvCwECkEy0NWnRECyYkq3
         nCGR+Qb2D2xqeb5sHtISAObCIn7BuBunVqTEj2G2/IWsJMA4NPQtEwgT3TmBbUemwvV4
         XO62F54u48i74TmSScJg5KlbZ86qy/rCSwe2bFn0omqHDDQLTilyZ0Pz6ZsAo+JsDy8g
         UBXaqvsMPefpIftL9fL+X9PbBVPR7c8ApKcIdZwtpvTzV5uKSrsth2PPrrg1tOmaT6eh
         64Ww==
X-Gm-Message-State: APjAAAWfNURpoPI1k1CIIwqIfXo8NH50qsIq5oY2C4a2dNreItEoq/te
        VSdyzcfcsGx2fXKSJz1rL2wn2Q==
X-Google-Smtp-Source: APXvYqzHDWQhfPJ6We27I1c01VEHmcH6AedqLJLeDfuYhTAnIpxtfMqyBLvyHd9LxsMu3eLuFy5VVA==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr949715wmg.150.1565818300170;
        Wed, 14 Aug 2019 14:31:40 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:39 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 7/7] drm/nouveau: abort runtime suspend if we hit an error
Date:   Wed, 14 Aug 2019 23:31:18 +0200
Message-Id: <20190814213118.28473-8-kherbst@redhat.com>
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
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 16441c5bf29c..b16157a9c736 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -910,6 +910,7 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct nouveau_drm *drm = nouveau_drm(drm_dev);
 	int ret;
 
 	if (!nouveau_pmops_runtime()) {
@@ -919,6 +920,10 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 
 	nouveau_switcheroo_optimus_dsm();
 	ret = nouveau_do_suspend(drm_dev, true);
+	if (ret) {
+		NV_ERROR(drm, "suspend failed with: %d\n", ret);
+		return ret;
+	}
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
 	pci_ignore_hotplug(pdev);
-- 
2.21.0

