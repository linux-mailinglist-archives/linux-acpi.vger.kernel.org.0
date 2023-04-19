Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF76E8298
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjDSUZK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjDSUY4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:24:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6065BA;
        Wed, 19 Apr 2023 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935800; x=1713471800;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EfovW0VkDvDsILDAe9TRZnntRoF2epX3VCK/uqVPCM=;
  b=gJcB4N55PHkKayhVX1XOb86kl2kGHvqYrzN3WvZkMQ3zx0SP8udSbMyc
   Fa421q9gJOIs85FxR2ya1lji2vhOysgl/CvNHCNr87cwvZ7dbVLs/ZfdK
   iNdIX3rz0inpAo/9nJiks0b/suQCtlkJmLCzmoB3IRS1uhLlN07VFORxi
   YgkkRJT60aVvARYJXzBBxble0lbjJiAsZbpVwVKZPNzFwqCnqd+u8u2EL
   C2UV0+uysVRH0bMV16WNy6t+D0sHi4xDkRi8xRvBryacvyCfo0TnCxWPF
   EBvcpBwpfYiBxpNd2yTCPW8GegrWUrn8ytfxGWyc3tQBcYui6j4q6vF9e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345555252"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="345555252"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="760877028"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="760877028"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:23:19 -0700
Subject: [PATCH v4 23/23] cxl/mem: Add debugfs output for QTG related data
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:23:19 -0700
Message-ID: <168193579968.1178687.4591837657491020641.stgit@djiang5-mobl3>
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

Add debugfs output to /sys/kernel/debug/cxl/memX/qtgmap
The debugfs attribute will dump out all the DSMAS ranges and the associated
QTG ID exported by the CXL device CDAT.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Use cxlds->qos_list instead of the stray cxlmd->qos_list
---
 Documentation/ABI/testing/debugfs-cxl |   11 +++++++++++
 drivers/cxl/mem.c                     |   17 +++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
new file mode 100644
index 000000000000..0f36eeb7e59b
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -0,0 +1,11 @@
+What:		/sys/kernel/debug/cxl/memX/qtg_map
+Date:		Mar, 2023
+KernelVersion:	v6.4
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Entries of all Device Physical Address (DPA) ranges
+		provided by the device Coherent Device Attributes Table (CDAT)
+		Device Scoped Memory Affinity Structure (DSMAS) entries with
+		the matching QoS Throttling Group (QTG) id calculated from the
+		latency and bandwidth of the CXL path from the memory device
+		to the CPU.
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 39c4b54f0715..9a23875975eb 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,22 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static int cxl_mem_qtg_show(struct seq_file *file, void *data)
+{
+	struct device *dev = file->private;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct qos_prop_entry *qos;
+
+	list_for_each_entry(qos, &cxlds->qos_list, list) {
+		seq_printf(file, "%08llx-%08llx : QTG ID %u\n",
+			   qos->dpa_range.start, qos->dpa_range.end,
+			   qos->qtg_id);
+	}
+
+	return 0;
+}
+
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
@@ -117,6 +133,7 @@ static int cxl_mem_probe(struct device *dev)
 
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
+	debugfs_create_devm_seqfile(dev, "qtgmap", dentry, cxl_mem_qtg_show);
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
 		return rc;


