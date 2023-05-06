Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D966F8D00
	for <lists+linux-acpi@lfdr.de>; Sat,  6 May 2023 02:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjEFAFi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 May 2023 20:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEFAFh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2023 20:05:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2555FD1;
        Fri,  5 May 2023 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683331536; x=1714867536;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=315FCC00DECdTFs1kEI640oh+jZ3R4IIaEwTILAjmnQ=;
  b=gys5kX9r1Q96Bt7ax0n9o+xhk//HzQsc4R8ffP+4ysK7xgZwqt+fh1mU
   t8ekkN1QSYY7UDpF7/pWDLYsJEXy8X61yDWVoPtMdTi3XpeW+HMj46ywx
   4gP3QKFQRRIwAZLyBzZRplaFp00uui5yB4uV+bAKVoiEiK24a1bLz/Bq4
   UVzozINkyK+s4eBKgbrtashEM2q1tyCYklVjJbSw1mCVjJD41l9CiuaHv
   4p2jzbcUCVk/xEONt14D9TNmmU6US31912pvgHrDgfNRQHx8b3fYTytyE
   wR0pFcNVcTysIL8ZZbbBgF8LX8/xNlL9iSsVH7NdgjVWhL/V5WoufAMqE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="435643326"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="435643326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 17:05:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="675304562"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="675304562"
Received: from nkonan-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 17:05:34 -0700
Subject: [PATCH 4/4] acpi: numa: Add helper function to retrieve the
 performance attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 05 May 2023 17:05:34 -0700
Message-ID: <168333153420.2290593.8903766148018143689.stgit@djiang5-mobl3>
In-Reply-To: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
References: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add helper to retrieve the performance attributes based on the device
handle.  The helper function is exported so the CXL driver can use that
to acquire the performance data between the CPU and the CXL host bridge.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |   35 +++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |    9 +++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 951579e903cf..73d716e6096e 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -107,6 +107,41 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
 	return NULL;
 }
 
+static struct memory_target *acpi_find_genport_target(u8 *device_handle)
+{
+	struct memory_target *target;
+
+	list_for_each_entry(target, &targets, node) {
+		if (!strncmp(target->device_handle, device_handle,
+			     ACPI_SRAT_DEVICE_HANDLE_SIZE))
+			return target;
+	}
+
+	return NULL;
+}
+
+/**
+ * acpi_get_genport_coordinates - Retrieve the access coordinates for a generic port
+ * @device_handle: Device handle string (ACPI or PCI) to match up to the gen port
+ * @coord: The access coordinates written back out for the generic port
+ *
+ * Return: 0 on success. Errno on failure.
+ */
+int acpi_get_genport_coordinates(u8 *device_handle,
+				 struct access_coordinate *coord)
+{
+	struct memory_target *target;
+
+	target = acpi_find_genport_target(device_handle);
+	if (!target)
+		return -ENOENT;
+
+	*coord = target->coord[NODE_ACCESS_CLASS_GENPORT];
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, CXL);
+
 static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4c3dfe7587e9..d6a99fa430dd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/property.h>
 #include <linux/uuid.h>
+#include <linux/node.h>
 
 #ifndef _LINUX
 #define _LINUX
@@ -455,6 +456,8 @@ extern bool acpi_osi_is_win8(void);
 #ifdef CONFIG_ACPI_NUMA
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);
+int acpi_get_genport_coordinates(u8 *device_handle,
+				 struct access_coordinate *coord);
 
 /**
  * pxm_to_online_node - Map proximity ID to online node
@@ -489,6 +492,12 @@ static inline int acpi_get_node(acpi_handle handle)
 {
 	return 0;
 }
+
+static inline int acpi_get_genport_coordinates(u8 *device_handle,
+					       struct access_coordinate *coord)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 extern int acpi_paddr_to_node(u64 start_addr, u64 size);
 


