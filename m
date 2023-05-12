Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA347009E4
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbjELOEP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241459AbjELODj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC4513C16
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900218; x=1715436218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J0PI22rnw+GYC5C6NqjiXOlKuANTYa1On/ROwJ+FKUU=;
  b=NXNo/nsQzO/vLe8af4pmzodylzgeRWI8ciZ64c6NVrGRYn3io8NjeZMK
   aIkEPGPqaXwcBjCYNnSRKvHFtVbgRWA84ayJzi0OwuGY/gePeG3M70jJY
   qqUQgJhE5LYNibb/NjTHXFHo404dY25FlqvLBqT6NddhULV0JgWl24Xmq
   Q/zn379WYdCOraZtMXl5tu7P6HqbTDME5wBdHvXL9+WgD+TPUEFLcGkOh
   xq8tP+VAJnICAoFNFFjHvMbtkQODC5hkJkt1wB++ayoRCgKljk6eDQs5/
   xOl8vasbq6NUN0/uzjoC3hEzp4mcLnYztuvkhTzs1+pkA2f3gpmlX50rw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931232"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931232"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650649028"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650649028"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:37 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 34/34] acpi/bus: Remove notify callback and flags
Date:   Fri, 12 May 2023 16:02:22 +0200
Message-Id: <20230512140222.124868-35-michal.wilczynski@intel.com>
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

As callback has been replaced by drivers installing their handlers in
.add it's presence is not useful anymore.

Remove notify callback from struct acpi_driver, and flags as it's not
needed anymore.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 include/acpi/acpi_bus.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7fb411438b6f..3326794d5b70 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -151,12 +151,10 @@ struct acpi_hotplug_context {
 
 typedef int (*acpi_op_add) (struct acpi_device * device);
 typedef void (*acpi_op_remove) (struct acpi_device *device);
-typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
 
 struct acpi_device_ops {
 	acpi_op_add add;
 	acpi_op_remove remove;
-	acpi_op_notify notify;
 };
 
 #define ACPI_DRIVER_ALL_NOTIFY_EVENTS	0x1	/* system AND device events */
@@ -165,7 +163,6 @@ struct acpi_driver {
 	char name[80];
 	char class[80];
 	const struct acpi_device_id *ids; /* Supported Hardware IDs */
-	unsigned int flags;
 	struct acpi_device_ops ops;
 	struct device_driver drv;
 	struct module *owner;
-- 
2.38.1

