Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487746DB155
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDGROR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjDGROP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:14:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0A9AF34;
        Fri,  7 Apr 2023 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887654; x=1712423654;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWsYJfw0gbUl/xTVOGIsEJag6zroc9ti2yLD7YmUSuc=;
  b=VqzdoxFCuJQVt2AkvYbXRhMG1+Gh3cEurvjqIVJzbKQ/cBnGWaV39YW6
   AnLy0aTyI6I7S60WrCa7/FSQ49kooAJidcl5a++mH6ebXLPTuxm6P6axG
   BAPW+P9uRq0yX/3ous0luJZKR7hnBRj3rDq2aNwgYcOl+dy4EzWKCxI5U
   wawPj+PeoHrABWWPWalv2R5b2CvwJC4Mlj1/d3jqaqH+1VdFg4P9qJj2f
   mRuaoCmHUpGixHS/zIDdWBcDUFuu55rwarWWfo/iffx7g2Wlmy+PtFMOO
   Vs1TZlLcgBwX3QJpOTMEFzQvideeb1T3f1xg8PeUtwODHyAUCJ4f4E9C1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="345682119"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="345682119"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="831251826"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="831251826"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:14:06 -0700
Subject: [PATCH 3 21/23] cxl: Store QTG IDs and related info to the CXL memory
 device context
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:14:05 -0700
Message-ID: <168088764576.1441063.4073780159473151210.stgit@djiang5-mobl3>
In-Reply-To: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
References: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
the return package. Create a list of entries in the cxl_memdev context and
store the QTG ID and the associated DPA range. This information can be
exposed to user space via sysfs in order to help region setup for
hot-plugged CXL memory devices.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Move back to QTG ID per partition
---
 drivers/cxl/core/mbox.c |    3 +++
 drivers/cxl/cxlmem.h    |   20 ++++++++++++++++++++
 drivers/cxl/port.c      |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..a535a1b78b0e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1120,6 +1120,9 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	mutex_init(&cxlds->mbox_mutex);
 	mutex_init(&cxlds->event.log_lock);
 	cxlds->dev = dev;
+	INIT_LIST_HEAD(&cxlds->qos_list);
+	cxlds->ram_qtg_id = -1;
+	cxlds->pmem_qtg_id = -1;
 
 	return cxlds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 001dabf0231b..7107ef594555 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/node.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -40,6 +41,7 @@
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
+ * @qos_list: QTG ID related list of entries
  */
 struct cxl_memdev {
 	struct device dev;
@@ -50,6 +52,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm *cxl_nvd;
 	int id;
 	int depth;
+	struct list_head qos_list;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
@@ -215,6 +218,19 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/**
+ * struct qos_prop - QoS property entry
+ * @list - list entry
+ * @dpa_range - range for DPA address
+ * @qtg_id - QoS Throttling Group ID
+ */
+struct qos_prop_entry {
+	struct list_head list;
+	struct range dpa_range;
+	u16 qtg_id;
+	struct node_hmem_attrs hmem_attrs;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -283,6 +299,10 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
+	int ram_qtg_id;
+	int pmem_qtg_id;
+	struct list_head qos_list;
+
 	resource_size_t component_reg_phys;
 	u64 serial;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 70189309c1c0..facecb5c8b00 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -124,6 +124,40 @@ static int cxl_port_qos_calculate(struct cxl_port *port,
 	return 0;
 }
 
+static void cxl_memdev_set_qtg(struct cxl_dev_state *cxlds, struct list_head *dsmas_list)
+{
+	struct range pmem_range = {
+		.start = cxlds->pmem_res.start,
+		.end = cxlds->pmem_res.end,
+	};
+	struct range ram_range = {
+		.start = cxlds->ram_res.start,
+		.end = cxlds->ram_res.end,
+	};
+	struct qos_prop_entry *qos;
+	struct dsmas_entry *dent;
+
+	list_for_each_entry(dent, dsmas_list, list) {
+		qos = devm_kzalloc(cxlds->dev, sizeof(*qos), GFP_KERNEL);
+		if (!qos)
+			return;
+
+		qos->dpa_range = dent->dpa_range;
+		qos->qtg_id = dent->qtg_id;
+		qos->hmem_attrs = dent->hmem_attrs;
+		list_add_tail(&qos->list, &cxlds->qos_list);
+
+		if (resource_size(&cxlds->ram_res) &&
+		    range_contains(&ram_range, &dent->dpa_range) &&
+		    cxlds->ram_qtg_id == -1)
+			cxlds->ram_qtg_id = dent->qtg_id;
+		else if (resource_size(&cxlds->pmem_res) &&
+			 range_contains(&pmem_range, &dent->dpa_range) &&
+			 cxlds->pmem_qtg_id == -1)
+			cxlds->pmem_qtg_id = dent->qtg_id;
+	}
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -234,6 +268,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		if (rc)
 			dev_dbg(&port->dev, "Failed to do QoS calculations\n");
 
+		cxl_memdev_set_qtg(cxlds, &dsmas_list);
 		dsmas_list_destroy(&dsmas_list);
 	}
 


