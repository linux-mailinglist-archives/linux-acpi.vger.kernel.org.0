Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE26DB154
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDGROQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDGROP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:14:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9BCAD25;
        Fri,  7 Apr 2023 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887654; x=1712423654;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+mZI/k+IwVP7frgAtKYxsQS4FuBNwyZvfyDnmIgFQC8=;
  b=gtMD3YurP8YZ5eM3UReaPyabC1gaDqZJxbVWGy8rAzY7mEbjaq0IbJN1
   VYgjLV2iv028axZxPPSLZRo9ns0Vhcq/TOy2mjznIQPHHlp0+lilFtEXg
   btPMg230UxB4d7W08WkD+oF2Ym9akNMii+wo5GY/QxhB5cSwowfFc+Vf6
   k5O5Y9ii2bmmtlWBgAdrIbDddgcLiNDr37OrcEnKSmYZ9+J+oXjPUaTfJ
   14dTc5OYaQy3r98xxrCfflpieLRLBrAGqBZBzAV7royv68q5xS1Lcxuia
   YjzO1DnuHI6Yc4n4eIFwX6q3FoSa1HjZRHrqhHtooJA1kbYULi/Ywchk8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="345682112"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="345682112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="831251806"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="831251806"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:14:00 -0700
Subject: [PATCH 3 20/23] cxl: Move identify and partition query from pci probe
 to port probe
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:14:00 -0700
Message-ID: <168088764000.1441063.12595330462471499795.stgit@djiang5-mobl3>
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
index dad5258b4604..70189309c1c0 100644
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


