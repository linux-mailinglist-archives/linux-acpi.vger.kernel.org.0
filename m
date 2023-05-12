Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC77009E1
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbjELOD7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbjELODj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62201385F
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900214; x=1715436214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2g43mjaPSJayDX4co/+nvjJtHmwHMaNW0cV9F4N1udc=;
  b=PRVNmQAzEPNWaeSDpEI7MmJjNnGMKYgkX1aAlmsxHEggA4lYtAYhJAq0
   wedDNcyksrgoBO6wRZ3IUSDA9fC8w9bWeTCeVDQGNim+h2aBiafre4+97
   Omm4/lkO+2D2DA900Gk/ziaDDj+azpmNhYaFt1Sc+ZAEs3Wsxn6x9A/aQ
   00RPvSqRgoFfR20z9SZn4k1zoZZLz2CcMkMTLOJt4/n0pz95667X1UH+K
   gdGd3W2yizfIi/SmChWxsx/4SldJc6FVVqlOVY8NiI1lP8wrfCNqozV0P
   sTCYW7Ax5ncBZJSAGI9PHsIzCxthTG4bZBZbZSqTpoz0n6citdcKd+ZR6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931211"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931211"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650649019"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650649019"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:33 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 31/34] virt/vmgenid: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:19 +0200
Message-Id: <20230512140222.124868-32-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512140222.124868-1-michal.wilczynski@intel.com>
References: <20230512140222.124868-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently logic for installing notifications from ACPI devices is
implemented using notify callback in struct acpi_driver. Preparations
are being made to replace acpi_driver with more generic struct
platform_driver, which doesn't contain notify callback. Furthermore
as of now handlers are being called indirectly through
acpi_notify_device(), which decreases performance.

Call acpi_device_install_event_handler() at the end of .add() callback.
Call acpi_device_remove_event_handler() at the beginning of .remove()
callback. Change arguments passed to the notify callback to match with
what's required by acpi_device_install_event_handler().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/virt/vmgenid.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index a1c467a0e9f7..b5532215e476 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -60,16 +60,26 @@ static int vmgenid_add(struct acpi_device *device)
 
 	device->driver_data = state;
 
+	ret = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, vmgenid_notify);
+
 out:
 	ACPI_FREE(parsed.pointer);
 	return ret;
 }
 
-static void vmgenid_notify(struct acpi_device *device, u32 event)
+static void vmgenid_remove(struct acpi_device *device)
+{
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, vmgenid_notify);
+}
+
+static void vmgenid_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct vmgenid_state *state = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct vmgenid_state *state;
 	u8 old_id[VMGENID_SIZE];
 
+	state = acpi_driver_data(device);
+
 	memcpy(old_id, state->this_id, sizeof(old_id));
 	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
 	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
@@ -89,7 +99,7 @@ static struct acpi_driver vmgenid_driver = {
 	.owner = THIS_MODULE,
 	.ops = {
 		.add = vmgenid_add,
-		.notify = vmgenid_notify
+		.remove = vmgenid_remove,
 	}
 };
 
-- 
2.38.1

