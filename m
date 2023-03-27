Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0272E6CB0F2
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjC0Vqd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjC0VqP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:46:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B323A82;
        Mon, 27 Mar 2023 14:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953572; x=1711489572;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2JHEP2NGtTg4XZMCESgs9TXf6rrTFuo735DGLV/EUQ=;
  b=P+1DaS07glEVvnWmLHpapXtIm9yX50t657m1GLy8NsyvDgRbFQLDwo8w
   S7mKQOjQrA3NKXUDO7fZtTIb3B0biWLNaOTe9snmarOM7CwNo77kz3UEr
   h2NaCdsM+Mxxx0299dxXVoapf5kiHV7O8Rhu2wZG+7A0gdn/zxAqjlHnE
   nMeiQ8px0u4NRSpfDqhS052tfHnprIrS6map9uFTDceioPoVIOBdPcwPL
   3SGrEva/aoeUaau4YG8/T0K453B4vg7cw9VNvabQlmuQyGHw2NlELgHtu
   wOmk0A4k+Y9QEd3KMEqElC+3VJ16AmT2YLKbdLndZtbWb6iMuvVscBRvw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337900352"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="337900352"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686114796"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686114796"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:54 -0700
Subject: [PATCH v2 18/21] cxl: Move identify and partition query from pci
 probe to port probe
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:45:54 -0700
Message-ID: <167995355442.2857312.7640440102093572590.stgit@djiang5-mobl3>
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
index 55517f6f5b84..f6646d91ae26 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -175,6 +175,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
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


