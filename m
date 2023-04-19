Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491A06E8284
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjDSUVf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjDSUVX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:21:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0025591;
        Wed, 19 Apr 2023 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935680; x=1713471680;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PGRLksT1aBLB2MmCn8K4Y3dNAaQSpPJtVNygEGOZ2Pc=;
  b=Ed1xL8u+wu01aVKorBb02CRwrpJROHTSTrOhrMiEe+hQCeHfckVqJkFb
   fbDmEhGqIMKI5K+/15O33PLEMwd8rGdbn5aesSfpQr78IHuC7o88cgg0C
   wjMwePEDUpgNFW+4Ao2iGDM8KpoRgemDx5qIombippmj/0AXbFnjlkOEL
   IIhI0Bb0/DDlF87nAshYVj/6U0OunEiXYsk4+ZOpHz7OgS0OSLuo/FOr0
   ntoEWbx6zpoGSnK0KdGTY8FCo1BaKz660oCptkBHS5ZReq/Vtil29Onnm
   0iM6Wpli3tipYjKW1hp60ge7bumtyiJXbBjaEvQzUdcG7eyxxdB6fL/RP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334369577"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="334369577"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="937798513"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="937798513"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:19 -0700
Subject: [PATCH v4 03/23] cxl: Add support for reading CXL switch CDAT table
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:21:19 -0700
Message-ID: <168193567959.1178687.13133878561024203176.stgit@djiang5-mobl3>
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

Move read_cdat_data() from endpoint probe to general port probe to
allow reading of CDAT data for CXL switches as well as CXL device.
Add wrapper support for cxl_test to bypass the cdat reading.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Remove cxl_test wrapper. (Ira)
---
 drivers/cxl/core/pci.c |   20 +++++++++++++++-----
 drivers/cxl/port.c     |    6 +++---
 2 files changed, 18 insertions(+), 8 deletions(-)

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
index 22a7ab2bae7c..615e0ef6b440 100644
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


