Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091AC7456C8
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jul 2023 10:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGCIDl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jul 2023 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjGCIDa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2023 04:03:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226310D1;
        Mon,  3 Jul 2023 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688371398; x=1719907398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lc4+OfSbvvX57NjX05OtAekCe3S3QQ2eQi+GYzBA354=;
  b=SOgw3j+JCTy1KkHYHcJD0NRdaHrmf7mf8Q1lE3eRlJestsUBHczpFQRA
   /2102VbmwmvoLaDJ0aiEkJnAkGlwOQ6PtOZQh4hwDSl1aa2p234NrUhSF
   +IsjfOMK0z8B5TlH+qmf7hd/PBNLfkpp+njyVTWz0SsUus8GHlCce1EJm
   6PHjng7iwCsCaI8Nv3Xc/WyJn7oeJEKEqRpN9xSCFu44IIFaCm43JpUZj
   Q7KteGF/nAe6+t4T/sktnb4wZ/Z8iUa+LCPmfmp2NAkywNhTGfUQW+EQV
   ZEAj4dkZFshSrE56I9pQXCzGV49nM3VteoM0lkaPzdoPVZQBaihfU+uN6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366304007"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="366304007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="862994510"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="862994510"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:14 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 1/9] acpi/bus: Introduce wrappers for ACPICA event handler install/remove
Date:   Mon,  3 Jul 2023 11:02:44 +0300
Message-ID: <20230703080252.2899090-2-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703080252.2899090-1-michal.wilczynski@intel.com>
References: <20230703080252.2899090-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Introduce new acpi_dev_install_notify_handler() and
acpi_dev_remove_notify_handler(). Those functions are replacing old
installers, and after all drivers switch to the new model, old installers
will be removed.

Make acpi_dev_install_notify_handler() and acpi_dev_remove_notify_handler()
non-static, and export symbols. This will allow the drivers to call them
directly, instead of relying on .notify callback.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c      | 26 ++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 20cdfb37da79..2d6f1f45d44e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -554,6 +554,32 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
 	acpi_os_wait_events_complete();
 }
 
+int acpi_dev_install_notify_handler(struct acpi_device *adev,
+				    u32 handler_type,
+				    acpi_notify_handler handler)
+{
+	acpi_status status;
+
+	status = acpi_install_notify_handler(adev->handle,
+					     handler_type,
+					     handler,
+					     adev);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_dev_install_notify_handler);
+
+void acpi_dev_remove_notify_handler(struct acpi_device *adev,
+				    u32 handler_type,
+				    acpi_notify_handler handler)
+{
+	acpi_remove_notify_handler(adev->handle, handler_type, handler);
+	acpi_os_wait_events_complete();
+}
+EXPORT_SYMBOL(acpi_dev_remove_notify_handler);
+
 /* Handle events targeting \_SB device (at present only graceful shutdown) */
 
 #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c941d99162c0..23fbe4a16972 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -515,6 +515,12 @@ void acpi_bus_private_data_handler(acpi_handle, void *);
 int acpi_bus_get_private_data(acpi_handle, void **);
 int acpi_bus_attach_private_data(acpi_handle, void *);
 void acpi_bus_detach_private_data(acpi_handle);
+int acpi_dev_install_notify_handler(struct acpi_device *adev,
+				    u32 handler_type,
+				    acpi_notify_handler handler);
+void acpi_dev_remove_notify_handler(struct acpi_device *adev,
+				    u32 handler_type,
+				    acpi_notify_handler handler);
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
-- 
2.41.0

