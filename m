Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692C273219C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jun 2023 23:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjFOVYY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jun 2023 17:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjFOVYX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jun 2023 17:24:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E232C2962;
        Thu, 15 Jun 2023 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864262; x=1718400262;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7VI07YLzpsiRkIdy/gzB7FtvLUo5Hg7wbg+UN74IyAg=;
  b=eBBMInjmMvkMcUjJu8DGjJk8QetpgG5oS6uQzdFfDg6gwz/iALiRNBJv
   FvcRF/axibdBgbu90qh3b4ZId3ebE48oGCxhcxlRLwN4VAv1PQmsqE4gm
   iPT5sTamx7QE7HYJyTTyd5YIpxZuJkFWfl/Yxg7EaPmA90VR6CsvF6EZh
   JE4rPRcIT8YQ44ipezDjqL+g6AW308IIRG0tNl+VqFVo2iW7umuHwPlJo
   sXt5I0NAVZp5HN47iZ0tY89vwTIqfcWDzXxN0vH7rzymEB98dn3X/hGRx
   fK23cqhk83qErIkp9FRcnYPkcP2kwJjpCbvxg5+ggPtlW0jeMwR1m9mqj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339385856"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="339385856"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689962187"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689962187"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.110.129])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:24:21 -0700
Subject: [PATCH v3 6/6] acpi: numa: Add helper function to retrieve the
 performance attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 15 Jun 2023 14:24:20 -0700
Message-ID: <168686426062.2950427.16463024982887754959.stgit@djiang5-mobl3>
In-Reply-To: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
References: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v2:
- Change strncmp to memcmp. (Jonathan)
---
 drivers/acpi/numa/hmat.c |   35 +++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |   12 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 32b951cd5ee4..b356c149ddb1 100644
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
+		if (!memcmp(target->device_handle, device_handle,
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


