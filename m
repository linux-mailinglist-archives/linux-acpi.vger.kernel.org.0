Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED76CB0F1
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjC0Vqd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjC0VqQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:46:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1303590;
        Mon, 27 Mar 2023 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953576; x=1711489576;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VNlMZOdJht7Zy6pmLtxW1M0jPur17UAJ1WBP+aKH9eE=;
  b=G3BjD5syB3n3eCtAZ++BUPW82/tWKq5mOAb0l9Do3uBH/YOIVWRkzLa/
   BbjdqW+HvNpEIc7TF7FEE2+8K1gv9hO4nvs3Uxp58845eQG9eRxZnzh9H
   Fdfplag/kUReSoXdLLXXjy6XawN7RaJSoHI7w6/48aDR15xEAuQ6UjZp3
   YOiOyadb/CHrqd9A5YH7/5nK+tFTa5lfJf9XPN0A+7lBLJLhKZ4/ZVIUm
   HYuKmMG7Yz5OYd5xuPEorn6/Hyl/j3aVPnDhvBzJXBBE07/joZU1/R12q
   k18js7V1NkxwT2YKaECIbRcucxix1Dgh5Yif1gjnwtznelSJz6PaCbLgn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337900377"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="337900377"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686114802"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686114802"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:46:00 -0700
Subject: [PATCH v2 19/21] cxl: Store QTG IDs and related info to the CXL
 memory device context
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:46:00 -0700
Message-ID: <167995356029.2857312.4374564094571467987.stgit@djiang5-mobl3>
In-Reply-To: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
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
 drivers/cxl/core/memdev.c |    1 +
 drivers/cxl/cxlmem.h      |   14 ++++++++++++++
 drivers/cxl/port.c        |   19 +++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 28a05f2fe32d..d2605fc39240 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -346,6 +346,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	 */
 	cxlmd->cxlds = cxlds;
 	cxlds->cxlmd = cxlmd;
+	INIT_LIST_HEAD(&cxlmd->qos_list);
 
 	cdev = &cxlmd->cdev;
 	rc = cdev_device_add(cdev, dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 001dabf0231b..c8b8d4865e49 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -40,6 +40,7 @@
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
+ * @qos_list: QTG ID related list of entries
  */
 struct cxl_memdev {
 	struct device dev;
@@ -50,6 +51,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm *cxl_nvd;
 	int id;
 	int depth;
+	struct list_head qos_list;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
@@ -215,6 +217,18 @@ struct cxl_event_state {
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
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index f6646d91ae26..4e7e22c13790 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -124,6 +124,22 @@ static int cxl_port_qos_calculate(struct cxl_port *port,
 	return 0;
 }
 
+static void cxl_memdev_set_qtg(struct cxl_memdev *cxlmd, struct list_head *dsmas_list)
+{
+	struct dsmas_entry *dent;
+	struct qos_prop_entry *qos;
+
+	list_for_each_entry(dent, dsmas_list, list) {
+		qos = devm_kzalloc(&cxlmd->dev, sizeof(*qos), GFP_KERNEL);
+		if (!qos)
+			return;
+
+		qos->dpa_range = dent->dpa_range;
+		qos->qtg_id = dent->qtg_id;
+		list_add_tail(&qos->list, &cxlmd->qos_list);
+	}
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -212,6 +228,7 @@ static int cxl_port_probe(struct device *dev)
 	read_cdat_data(port);
 	if (port->cdat.table) {
 		if (is_cxl_endpoint(port)) {
+			struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
 			LIST_HEAD(dsmas_list);
 
 			rc = cdat_table_parse_dsmas(port->cdat.table,
@@ -230,6 +247,8 @@ static int cxl_port_probe(struct device *dev)
 			rc = cxl_port_qos_calculate(port, &dsmas_list);
 			if (rc)
 				dev_dbg(dev, "Failed to do QoS calculations\n");
+
+			cxl_memdev_set_qtg(cxlmd, &dsmas_list);
 			dsmas_list_destroy(&dsmas_list);
 		} else {
 			rc = cdat_table_parse_sslbis(port->cdat.table,


