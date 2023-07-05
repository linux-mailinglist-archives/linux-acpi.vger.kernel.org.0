Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC019748FC9
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjGEVcD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGEVcC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F190619BB
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOI7cpcNK8zoC+qtqEt3rkkD5JPdd/L+4TbpPOVkBAI=;
        b=GPFZ9hLYSJxztmAaDqYbVpfiYmRIj7zhPHluRaumWyH9hkfNRH2djA7Fqjf9VNSx13nRpe
        oUe4t3dTGxR3pj8aTrMMGz1jAc++ByqyDTUE3DRfusot2jbIJW4QJ3CsKB47+FXt1K7QVQ
        GKlyjC/z8ZGxiGJpthHfeSMAEkNqAj4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-AfJZGqF5NLOg9kkw0P-cnA-1; Wed, 05 Jul 2023 17:30:29 -0400
X-MC-Unique: AfJZGqF5NLOg9kkw0P-cnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71F823C100AC;
        Wed,  5 Jul 2023 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E331A40C2063;
        Wed,  5 Jul 2023 21:30:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Hao Yao <hao.yao@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 04/18] media: ipu-bridge: Allow building as module
Date:   Wed,  5 Jul 2023 23:29:56 +0200
Message-ID: <20230705213010.390849-5-hdegoede@redhat.com>
In-Reply-To: <20230705213010.390849-1-hdegoede@redhat.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After commit f54eb0ac7c1a ("media: ipu3-cio2: rename cio2 bridge to ipu
bridge and move out of ipu3") the ipu-bridge code is always built in
even if all consumers are build as module.

Fix this by turning "config IPU_BRIDGE" into a pure library Kconfig
option (not user selectable, must be selected by consumers) and
re-introducing the CIO2_BRIDGE Kconfig bits in .../pci/intel/ipu3/Kconfig
which were dropped to still allow building ipu3-cio2 without ipu-bridge
support.

Fixes: f54eb0ac7c1a ("media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ipu3")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/pci/intel/Kconfig      | 18 ++----------------
 drivers/media/pci/intel/ipu-bridge.c |  4 ++++
 drivers/media/pci/intel/ipu3/Kconfig | 20 ++++++++++++++++++++
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/media/pci/intel/Kconfig b/drivers/media/pci/intel/Kconfig
index 64a29b0b7033..3179184d7616 100644
--- a/drivers/media/pci/intel/Kconfig
+++ b/drivers/media/pci/intel/Kconfig
@@ -1,21 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IPU_BRIDGE
-	bool "Intel IPU Sensors Bridge"
-	depends on VIDEO_IPU3_CIO2 && ACPI
+	tristate
+	depends on ACPI
 	depends on I2C
-	help
-	  This extension provides an API for the Intel IPU driver to create
-	  connections to cameras that are hidden in the SSDB buffer in ACPI.
-	  It can be used to enable support for cameras in detachable / hybrid
-	  devices that ship with Windows.
-
-	  Say Y here if your device is a detachable / hybrid laptop that comes
-	  with Windows installed by the OEM, for example:
-
-		- Microsoft Surface models (except Surface Pro 3)
-		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
-		- Dell 7285
-
-	  If in doubt, say N here.
 
 source "drivers/media/pci/intel/ipu3/Kconfig"
diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 1c88fd925a8b..97b544736af2 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -497,3 +497,7 @@ int ipu_bridge_init(struct pci_dev *ipu)
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(ipu_bridge_init, INTEL_IPU_BRIDGE);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dan Scally <djrscally@gmail.com>");
+MODULE_DESCRIPTION("Intel IPU ACPI Sensors Bridge");
diff --git a/drivers/media/pci/intel/ipu3/Kconfig b/drivers/media/pci/intel/ipu3/Kconfig
index 9be06ee81ff0..0951545eab21 100644
--- a/drivers/media/pci/intel/ipu3/Kconfig
+++ b/drivers/media/pci/intel/ipu3/Kconfig
@@ -8,6 +8,7 @@ config VIDEO_IPU3_CIO2
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
 	select VIDEOBUF2_DMA_SG
+	select IPU_BRIDGE if CIO2_BRIDGE
 
 	help
 	  This is the Intel IPU3 CIO2 CSI-2 receiver unit, found in Intel
@@ -17,3 +18,22 @@ config VIDEO_IPU3_CIO2
 	  Say Y or M here if you have a Skylake/Kaby Lake SoC with MIPI CSI-2
 	  connected camera.
 	  The module will be called ipu3-cio2.
+
+config CIO2_BRIDGE
+	bool "IPU3 CIO2 Sensors Bridge"
+	depends on VIDEO_IPU3_CIO2 && ACPI
+	depends on I2C
+	help
+	  This extension provides an API for the ipu3-cio2 driver to create
+	  connections to cameras that are hidden in the SSDB buffer in ACPI.
+	  It can be used to enable support for cameras in detachable / hybrid
+	  devices that ship with Windows.
+
+	  Say Y here if your device is a detachable / hybrid laptop that comes
+	  with Windows installed by the OEM, for example:
+
+		- Microsoft Surface models (except Surface Pro 3)
+		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
+		- Dell 7285
+
+	  If in doubt, say N here.
-- 
2.41.0

