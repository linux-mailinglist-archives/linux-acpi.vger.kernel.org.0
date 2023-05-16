Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09888704CFE
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjEPLuk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjEPLuB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:50:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433126E86
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237788; x=1715773788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nHJDSBb//sGSaCA3AwWCNyG65ipnPcU8elWQY3C1O5o=;
  b=RzU/wUk425hGwgEV9LSeF+44V7HHZPCleB4WIri1/AGJkTH4QokDrXya
   PXLjNBBKAdpiV1z/PDiPZzvkn2VKaNJKEXrutGII/2sU4TF9onBGrsKqM
   azY2oJTPA0nXKgmsIOx3cribTjMgDyEUfrz9EXmDpI1pUA9F7h61U9y9t
   r6ZzKd16xRUDAu3M9fAF4eBs1zxgy2+La7Q9mzcSPy+hfItC8T9Vh6+KB
   oW1LGLylxYlRt+pRQY3ZV14eoKn7oPn18oBBR8J3AN893P60MH0nbScdX
   cmweUK3sOJsxMjzxm1YjlTz/X4wwzHGkTBVUOZVETn/QXc01wUs7aQVzP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111752"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731962009"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731962009"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:15 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 32/34] acpi/bus: Remove installing/removing notify handlers from probe/remove
Date:   Tue, 16 May 2023 13:46:15 +0200
Message-Id: <20230516114617.148963-33-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230516114617.148963-1-michal.wilczynski@intel.com>
References: <20230516114617.148963-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove installing/removing .notify callback handlers, to prepare for
notify callback removal.

Remove logic calling .remove callback, as .add should be expected to
clean after itself in case of the failure, and event handler
installation was moved to .add in all drivers already.

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
2.40.1

