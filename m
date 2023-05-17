Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22995706207
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjEQH7r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEQH6p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BCE56
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310324; x=1715846324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ts6C5JUZkQiwH7gJ6stxKKdR9KfqEVngICJLmKLlXY=;
  b=NaHrA3eAZzVvt1btTOnYuKkGP8TwKNTkM22UGM0jLapBTwHyI/YyTho9
   gitDrGJsarQkJiZsEbqNH6S7G/RlE0TPb/bJeTdwMyF8Mr8aPnzNVujSD
   UG80tF4lkQRSPdDOkdreEyEr1vHb2Ce5y+W8yIlQrAcphnXQQle9u94Fi
   VAWzKggFfEve6zQu8Pwu5QniuYTfc6ii+wFNVDsP2mgrYuaFpV069gqfM
   Pvm0eRlUvIbjBsNpto3zOeY86m7kcJsQIIUtzxW+GDAffcc8eKoPW4gnS
   2WzblC+R9NUFBDDnvC5Ke6Bx3Hg4iuZ0FKbGXrZrYGAwkhjmEuvC0j5Ps
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105505"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105505"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877538"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877538"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:42 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 31/34] virt/vmgenid: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:21 +0200
Message-Id: <20230517075724.153992-32-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230517075724.153992-1-michal.wilczynski@intel.com>
References: <20230517075724.153992-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

