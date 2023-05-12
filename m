Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C827009E3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbjELOEP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241405AbjELODj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3813C02
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900216; x=1715436216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZIELIisXLuT7XWw63Y22+2MpV7DcrBhlODB+fjpGyhE=;
  b=AGBcUj4VMghzFDguzXfXkAzS59qPAlZp8BVDeDAcT1iiiHLXxwD/ZrmC
   SBgKVMRN5c2qGN5ACbthYdW4PDbmCp03c5FaUlvuEav63DQGcd278lLNs
   uQeNjvbZLN51CLe3jLpPmKJl3dQ557CGL9vt6judhI89Zow9H7H7vBaCa
   ZNZf+Ia7O1tEJGwdsZJWt6EAOxAdFNElZKDIVJ1LsWczz9o/IuF6LSFv6
   6/Ps6Z/KpM034D6JUNQxKCD9OR0nNR4XGRdONFVgt/SM1Omc2pUXxa3tC
   e93d5ThVPdLnWT1PzaXYuc0FRcPSuI4hSW05ZgwzXscLTESX+rv31KMjS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931219"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931219"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650649022"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650649022"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:34 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 32/34] acpi/bus: Remove installing/removing notify handlers from probe/remove
Date:   Fri, 12 May 2023 16:02:20 +0200
Message-Id: <20230512140222.124868-33-michal.wilczynski@intel.com>
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

Remove installing/removing .notify callback handlers, to prepare for
notify callback removal.

Remove logic calling .remove callback, as .add should be expected to
clean after itself in case of the failure, and event handler
installation will be moved to .add in following commits.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 00309df56c24..3eeeec70e70b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1086,20 +1086,6 @@ static int acpi_device_probe(struct device *dev)
 	pr_debug("Driver [%s] successfully bound to device [%s]\n",
 		 acpi_drv->name, acpi_dev->pnp.bus_id);
 
-	if (acpi_drv->ops.notify) {
-		ret = acpi_device_install_notify_handler(acpi_dev, acpi_drv);
-		if (ret) {
-			if (acpi_drv->ops.remove)
-				acpi_drv->ops.remove(acpi_dev);
-
-			acpi_dev->driver_data = NULL;
-			return ret;
-		}
-	}
-
-	pr_debug("Found driver [%s] for device [%s]\n", acpi_drv->name,
-		 acpi_dev->pnp.bus_id);
-
 	get_device(dev);
 	return 0;
 }
@@ -1109,9 +1095,6 @@ static void acpi_device_remove(struct device *dev)
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
 
-	if (acpi_drv->ops.notify)
-		acpi_device_remove_notify_handler(acpi_dev, acpi_drv);
-
 	if (acpi_drv->ops.remove)
 		acpi_drv->ops.remove(acpi_dev);
 
-- 
2.38.1

