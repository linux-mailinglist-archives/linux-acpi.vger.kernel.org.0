Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576986DB141
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDGRMQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjDGRMP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:12:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB70A5CB;
        Fri,  7 Apr 2023 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887535; x=1712423535;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KkQPMKg/m4KPZlcMeM+2KUn0G82HH+sivmcx9DEURSw=;
  b=HVp8W2XOzODUVqQVCCI2jn9VCoEHgz02Yvv+SCuRvPlSvtViDnvGQgzv
   fbiRVbNAeWZ4M41eknw74Bh/yyJ8ovXzB2gYxTU+Jro5aD+rkG719B5uG
   aQhYTMYtUuoDOK4heF8yx5beywGWzCLTZI89AnMRM32XooI0eI61AHhaA
   KXCxIVa4GfKVVum2WD8dGRxItd8hOh5hnG3P/TYzhPcjXAEgJo4XqrvS7
   v+SBRZJrAtGkeIKcICAnb3m2F/nKLUum14QVpAahiORsimB/mo7B7ea9a
   iEJxF6PwcEpZBrUbRQJ16DnX1q2ncW0ws1bBAU1pkIDbvMrInY0/pzBVB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="323402110"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="323402110"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="717902647"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="717902647"
Received: from rramanna-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:13 -0700
Subject: [PATCH 3 03/23] cxl: Add support for reading CXL switch CDAT table
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:12:13 -0700
Message-ID: <168088753327.1441063.12840367865204790886.stgit@djiang5-mobl3>
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

Move read_cdat_data() from endpoint probe to general port probe to
allow reading of CDAT data for CXL switches as well as CXL device.
Add wrapper support for cxl_test to bypass the cdat reading.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c        |   20 +++++++++++++++-----
 drivers/cxl/port.c            |    6 +++---
 tools/testing/cxl/Kbuild      |    1 +
 tools/testing/cxl/test/mock.c |    5 +++++
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9c7e2f69d9ca..1c415b26e866 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -546,16 +546,26 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct pci_doe_mb *cdat_doe;
-	struct device *dev = &port->dev;
 	struct device *uport = port->uport;
-	struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct device *dev = &port->dev;
+	struct cxl_dev_state *cxlds;
+	struct pci_doe_mb *cdat_doe;
+	struct cxl_memdev *cxlmd;
+	struct pci_dev *pdev;
 	size_t cdat_length;
 	void *cdat_table;
 	int rc;
 
+	if (is_cxl_memdev(uport)) {
+		cxlmd = to_cxl_memdev(uport);
+		cxlds = cxlmd->cxlds;
+		pdev = to_pci_dev(cxlds->dev);
+	} else if (dev_is_pci(uport)) {
+		pdev = to_pci_dev(uport);
+	} else {
+		return;
+	}
+
 	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
 					CXL_DOE_PROTOCOL_TABLE_ACCESS);
 	if (!cdat_doe) {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 1049bb5ea496..60a865680e22 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -93,9 +93,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
-	/* Cache the data early to ensure is_visible() works */
-	read_cdat_data(port);
-
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
@@ -135,6 +132,9 @@ static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
 
+	/* Cache the data early to ensure is_visible() works */
+	read_cdat_data(port);
+
 	if (is_cxl_endpoint(port))
 		return cxl_endpoint_port_probe(port);
 	return cxl_switch_port_probe(port);
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index fba7bec96acd..2637c71f3378 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -12,6 +12,7 @@ ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=cxl_rcrb_to_component
+ldflags-y += --wrap=read_cdat_data
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index c4e53f22e421..3a75909b2aae 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -263,6 +263,11 @@ resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcrb_to_component, CXL);
 
+void __wrap_read_cdat_data(struct cxl_port *port)
+{
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_read_cdat_data, CXL);
+
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
 MODULE_IMPORT_NS(CXL);


