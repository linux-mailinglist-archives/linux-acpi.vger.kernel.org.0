Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B151719EB9
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjFANqq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjFANqo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:46:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD16918C;
        Thu,  1 Jun 2023 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627203; x=1717163203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ts6C5JUZkQiwH7gJ6stxKKdR9KfqEVngICJLmKLlXY=;
  b=VTuEQ3yoH2vlz3KFgNYvrlpcm43lOqqFXUp4spn+BMcZPfw6bSKHF/T+
   ZxcYZaQ70I9aoiznkBUIuxGWmEGwDxil4vh2dQ+F3Pj8SMm4VNG1mOSSG
   ocoqn8HCKUdpmVLAZB68hGf24Nvl/2Exnyt2vWKQ585maUOAUrIuGMgvh
   /vcV6M3cNXOOGg54noHoRKaDjAQ8/QscXKUDPeuaWj/4HiJZygtAAtbci
   R+FccF0uPWdHW/iRpP5g95aan7MwJ0FamK1ti9v2qe2aAUu1gpwMClDJA
   IriAwS/dwPUa3x36tFi/hCv+uUygj/a4HHv/fyWa7ZwX6rzI4WVZfte70
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068988"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068988"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881602201"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881602201"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:20 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 32/35] virt/vmgenid: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:35 +0200
Message-Id: <20230601131739.300760-33-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230601131739.300760-3-michal.wilczynski@intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/virt/vmgenid.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index a1c467a0e9f7..50e7f4a82f99 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -21,6 +21,21 @@ struct vmgenid_state {
 	u8 this_id[VMGENID_SIZE];
 };
 
+static void vmgenid_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *device = data;
+	struct vmgenid_state *state;
+	u8 old_id[VMGENID_SIZE];
+
+	state = acpi_driver_data(device);
+
+	memcpy(old_id, state->this_id, sizeof(old_id));
+	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
+	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
+		return;
+	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
+}
+
 static int vmgenid_add(struct acpi_device *device)
 {
 	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
@@ -60,21 +75,16 @@ static int vmgenid_add(struct acpi_device *device)
 
 	device->driver_data = state;
 
+	ret = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, vmgenid_notify);
+
 out:
 	ACPI_FREE(parsed.pointer);
 	return ret;
 }
 
-static void vmgenid_notify(struct acpi_device *device, u32 event)
+static void vmgenid_remove(struct acpi_device *device)
 {
-	struct vmgenid_state *state = acpi_driver_data(device);
-	u8 old_id[VMGENID_SIZE];
-
-	memcpy(old_id, state->this_id, sizeof(old_id));
-	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
-	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
-		return;
-	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, vmgenid_notify);
 }
 
 static const struct acpi_device_id vmgenid_ids[] = {
@@ -89,7 +99,7 @@ static struct acpi_driver vmgenid_driver = {
 	.owner = THIS_MODULE,
 	.ops = {
 		.add = vmgenid_add,
-		.notify = vmgenid_notify
+		.remove = vmgenid_remove,
 	}
 };
 
-- 
2.40.1

