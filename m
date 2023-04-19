Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C036E8294
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDSUZI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjDSUYz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:24:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288016593;
        Wed, 19 Apr 2023 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935789; x=1713471789;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ptUqUY/bpaS35M1SUxWIhyOtSa14gymR/+yoiNOcOv0=;
  b=VMMBP1AT2c5uQKQ1ROMiUQCPce84KtuBUFS2ijJV342YfgtfPQCsBrdU
   /nYlmlq64m/tLT3b1KqYqCEyah9L/q6MJheh5SZjb/d+DVpiNsK5A6Emi
   vxNaUDJxwWwKAtPokB9eQJRbPrq3cI0bsM6wW7KmyVvEQrX8l31rhrraq
   W7t2o4HTM+EZbNTrRu1E/+Ik0hEB05QZQsTBrvy6z54NMysj+u1/es2Ow
   sH4Je4pbPIlvGmkfQLunxIWQJrQxU53TzeVF21bSbpywEs8wIabKfE2FZ
   2IJGTXB6F7bvCYV3WFaDY/HYGc0j5DXu0uODp5tdBbefGSuIz/h/QhRYt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345555192"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="345555192"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:23:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="760876985"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="760876985"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:23:08 -0700
Subject: [PATCH v4 21/23] cxl: Store QTG IDs and related info to the CXL
 memory device context
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:23:07 -0700
Message-ID: <168193578787.1178687.7864040343041326972.stgit@djiang5-mobl3>
In-Reply-To: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
v4:
- Remove unused qos_list from cxl_md
v3:
- Move back to QTG ID per partition
---
 drivers/cxl/core/mbox.c |    3 +++
 drivers/cxl/cxlmem.h    |   21 +++++++++++++++++++++
 drivers/cxl/port.c      |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..0352bd36d47e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1120,6 +1120,9 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	mutex_init(&cxlds->mbox_mutex);
 	mutex_init(&cxlds->event.log_lock);
 	cxlds->dev = dev;
+	INIT_LIST_HEAD(&cxlds->qos_list);
+	cxlds->ram_qtg_id = CXL_QTG_ID_INVALID;
+	cxlds->pmem_qtg_id = CXL_QTG_ID_INVALID;
 
 	return cxlds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 001dabf0231b..9a23e13ce796 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/node.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -215,6 +216,19 @@ struct cxl_event_state {
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
@@ -251,6 +265,9 @@ struct cxl_event_state {
  * @serial: PCIe Device Serial Number
  * @event: event log driver state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @ram_qtg_id: QTG ID for volatile region
+ * @pmem_qtg_id: QTG ID for persistent region
+ * @qos_list: QTG ID related list of entries
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -283,6 +300,10 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
+	int ram_qtg_id;
+	int pmem_qtg_id;
+	struct list_head qos_list;
+
 	resource_size_t component_reg_phys;
 	u64 serial;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 82c24a4c85a2..0bf6ed7a05a8 100644
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
 


