Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D376DB156
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDGROZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjDGROU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:14:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BFAB752;
        Fri,  7 Apr 2023 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887658; x=1712423658;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+EXZVJ1JkQIsvOgC4hoYVQTXB71iThB2DX8P+RuUtI=;
  b=VpgOWcKKEtXIOMCRMAyijZEpOWJHgbGCwG6brKz1z8KikGvEBSjfdFCF
   WGE0SkX8vzprryHlxcPHIma8hFm5r9x+URCvkAk4lyS5J/BI3Aw16JDzJ
   VMK5SAOOh8QBd4XX2QqTKLQPFOr7UhG79RAQ/PLB92+r/rrNHGlnXIEKs
   ReZ5fDx3OQiTzfNa3D928SbEynYj0IVO078xus7t2Zn+C0eVs8xM9kbxv
   /VDaT/kuEnWg1WwSyo4Jl96fgb7EBdnq4o83f5AeZI3R6UOGV92oowYZL
   ALkiJAwoFHmnwgVkj2w/mKDdtOHYuhB6Wdgm4Y++bHXzndMnOO6zBoq/C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="343037457"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="343037457"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="933648814"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="933648814"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:14:17 -0700
Subject: [PATCH 3 23/23] cxl/mem: Add debugfs output for QTG related data
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:14:17 -0700
Message-ID: <168088765758.1441063.3077950661602680130.stgit@djiang5-mobl3>
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

Add debugfs output to /sys/kernel/debug/cxl/memX/qtgmap
The debugfs attribute will dump out all the DSMAS ranges and the associated
QTG ID exported by the CXL device CDAT.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/debugfs-cxl |   11 +++++++++++
 drivers/cxl/mem.c                     |   16 ++++++++++++++++
 2 files changed, 27 insertions(+)
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
index 39c4b54f0715..bf2cb5a54a7f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,21 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static int cxl_mem_qtg_show(struct seq_file *file, void *data)
+{
+	struct device *dev = file->private;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct qos_prop_entry *qos;
+
+	list_for_each_entry(qos, &cxlmd->qos_list, list) {
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
@@ -117,6 +132,7 @@ static int cxl_mem_probe(struct device *dev)
 
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
+	debugfs_create_devm_seqfile(dev, "qtgmap", dentry, cxl_mem_qtg_show);
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
 		return rc;


