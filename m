Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E1673ABB8
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 23:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjFVVkH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 17:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjFVVkG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 17:40:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE21FF1;
        Thu, 22 Jun 2023 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687470005; x=1719006005;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VReebXOV4skZQO6tXnZMZWd0m1aKAuLopzyT9MLDleI=;
  b=S6Et/bucu8RAYdDRjc0nOuSj7DU5pAmv2QfIwQ0p1cjUH6jNqpOo1ler
   NXnXoeB0/mVP6JlU1ViL0wJWuaglxKSquOyrFXiI4Jhp27czgWfgr4pC5
   /VsBAK8weMEbLDqRRoabKGRdQjOvwy8rFXc7DmRS6UoMj5M55xezn7unJ
   m85nQ4+KgNeXLVrTppTLC67Kniwt2lmhu4/30RLAy48Va0Y2NvVo7lk8p
   5vRMTsn60mnz3eEEY0suntysVSNvb5FFsu9++2vFx8MK6/GpvApVwrFyl
   uM4XlFhmxOGp0q5KfhtzsLP9NR0/S0tZ8Gcx5fl3XMaFwGS/AjjLBjsHf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350383091"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350383091"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="785080721"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="785080721"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.53.238])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:40:04 -0700
Subject: [PATCH v4 6/6] acpi: numa: Add helper function to retrieve the
 performance attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 22 Jun 2023 14:40:04 -0700
Message-ID: <168747000399.4115467.8583559086999809735.stgit@djiang5-mobl3>
In-Reply-To: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
References: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add helper to retrieve the performance attributes based on the device
handle.  The helper function is exported so the CXL driver can use that
to acquire the performance data between the CPU and the CXL host bridge.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Update device_handle to gen_port_device_handle. (Jonathan)
v2:
- Change strncmp to memcmp. (Jonathan)
---
 drivers/acpi/numa/hmat.c |   35 +++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |   12 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index aabd89c79e26..e3a29ddacbca 100644
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
+		if (!memcmp(target->gen_port_device_handle, device_handle,
+			    ACPI_SRAT_DEVICE_HANDLE_SIZE))
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
+	*coord = target->coord[NODE_ACCESS_CLASS_GENPORT_SINK];
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, CXL);
+
 static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index bf3433747495..9f4ac0a39ab6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -16,6 +16,7 @@
 #include <linux/property.h>
 #include <linux/uuid.h>
 #include <linux/fw_table.h>
+#include <linux/node.h>
 
 struct irq_domain;
 struct irq_domain_ops;
@@ -430,6 +431,17 @@ extern int acpi_blacklisted(void);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
+#ifdef CONFIG_ACPI_HMAT
+int acpi_get_genport_coordinates(u8 *device_handle,
+				 struct access_coordinate *coord);
+#else
+static inline int acpi_get_genport_coordinates(u8 *device_handle,
+					       struct access_coordinate *coord)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #ifdef CONFIG_ACPI_NUMA
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);


