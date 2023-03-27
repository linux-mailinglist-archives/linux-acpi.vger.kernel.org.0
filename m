Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78A6CB0F3
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjC0Vqe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjC0VqS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:46:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131AA2D51;
        Mon, 27 Mar 2023 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953578; x=1711489578;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qMzu4nCtJ++Zi0nLNXxEMdOYChBih0KqyaTouorlZiU=;
  b=WSdtDeuF/f6eXksYRMQJTDHfr7KdS6077czsaJqcCy2pNLRiwn8rQpM8
   KtWPTcOABmWGeQplqchM/DMs1Fpr41JSlkaoQDY/TLF1kOUSDSo6llRAu
   RgfABcqZiMUILtbWuxWRPlhpeLHLVhwfea0Ur2PWZhBBEd9U9f7aL3xcz
   IjzhdDaiRvbXsTuLmBZ0nnb8buRHw12TBxxW0NMqJUnG/1GrbfFso1OXF
   sBCq3VzUKYTc1aaSTNPakkEk88HfRG0vLD6jn3Y82St+hCSM1LQHF74EW
   ANoeRurcp8Zjd38qHFYIn51Hr82kzdCBno8kcq+KygkHV95BXz2u1w9dc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337900415"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="337900415"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:46:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686114814"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686114814"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:46:12 -0700
Subject: [PATCH v2 21/21] cxl/mem: Add debugfs output for QTG related data
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:46:11 -0700
Message-ID: <167995357195.2857312.5279274659737251140.stgit@djiang5-mobl3>
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

Add debugfs output to /sys/kernel/debug/cxl/memX/qtgmap
The debugfs attribute will dump out all the DSMAS ranges and the associated
QTG ID exported by the CXL device CDAT.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/mem.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

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


