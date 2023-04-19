Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927B56E8295
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjDSUZF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjDSUYx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:24:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4044ECD;
        Wed, 19 Apr 2023 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935783; x=1713471783;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bAmffv/C09ABIT2wveWXOvzc/uYEdULYACajMLcopuo=;
  b=jDxVXoA4NWQ0CqnVP7BZzEP05oUYmYkLftbaO+6bAUCiurAxg65I0zRO
   xh+aVR8FVIh65Z2DPJGao0aXxvNfT07vCHt71DCUEVHLPidu8cSXiMoFl
   5kmFk4IUWJe63/TYRSS+cpa838tE7YBlS9K9IHBaCKTvURVpjimduxOp+
   UcMGKXjTqIAw3vlLEE792VKYw3Ej+fzzdy0U5IfZvl10CV4QjjeI+90lg
   Gz0p5l2R6CUKBlzgdkeqb4lA3/gsqu3oxrOB2xnEZipxYRIpW2+KvTmLd
   fP4fk3gyUyxDct9OINhABTfsAF9NYrnGnIbWG1VDcTKOoi9sEuJHvpiiw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347408473"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="347408473"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="669112678"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="669112678"
Received: from jdgarvey-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:23:02 -0700
Subject: [PATCH v4 20/23] cxl: Move identify and partition query from pci
 probe to port probe
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:23:01 -0700
Message-ID: <168193578153.1178687.15034252316341065408.stgit@djiang5-mobl3>
In-Reply-To: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Move the enumeration of device capacity to cxl_port_probe() from
cxl_pci_probe(). The size and capacity information should be read
after cxl_await_media_ready() so the data is valid.

Fixes: 5e2411ae8071 ("cxl/memdev: Change cxl_mem to a more descriptive name")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c  |    8 --------
 drivers/cxl/port.c |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ed39d133b70d..06324266eae8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -707,14 +707,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_dev_state_identify(cxlds);
-	if (rc)
-		return rc;
-
-	rc = cxl_mem_create_range_info(cxlds);
-	if (rc)
-		return rc;
-
 	rc = cxl_alloc_irq_vectors(pdev);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 8e6e49ca8c7d..82c24a4c85a2 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -187,6 +187,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		return rc;
 	}
 
+	rc = cxl_dev_state_identify(cxlds);
+	if (rc)
+		return rc;
+
+	rc = cxl_mem_create_range_info(cxlds);
+	if (rc)
+		return rc;
+
 	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
 	if (rc)
 		return rc;


