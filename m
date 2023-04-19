Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9956E8282
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDSUVb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjDSUVU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:21:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A2B61AB;
        Wed, 19 Apr 2023 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935675; x=1713471675;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8MxlJ1+PFYsT4zJD2rLD6eOXsfO1SJ5tDzA0hk12vHw=;
  b=KzFJRzzSsF08A2w+dCHRhrrIzaStD+aSIi47OhFyq0pi6tYfmW/1xM5Q
   ALfCv12b/xOAPQIkvLqcIK0l3IxNy05B49AUXNrp0wfxC99+OI2Jy8EIm
   NROIQlhbg6DPzBgS6qB+JTFXhamTxIlQKtEY8EUHUylrVdVr4+EyC3Ufm
   mH5mTve8TVow1Fc29dZrpghE3yRfEx7lvPHSuS8AQ4HW0UeGDzaph6+p5
   Aj7WOcso0+vDGxDLIbfrN4V8EvcGhuD3YDXrIJObURXH+NisP2OB4rn7r
   SKIr+eKZBSMV2DGTmtWXxQxiQ3IVq/VZfMJNBS4hFyTaUBMds6f0Bw8k6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334369558"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="334369558"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="937798495"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="937798495"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:14 -0700
Subject: [PATCH v4 02/23] cxl: Add checksum verification to CDAT from CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:21:13 -0700
Message-ID: <168193567363.1178687.9185773070266307121.stgit@djiang5-mobl3>
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

A CDAT table is available from a CXL device. The table is read by the
driver and cached in software. With the CXL subsystem needing to parse the
CDAT table, the checksum should be verified. Add checksum verification
after the CDAT table is read from device.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Just return the final sum. (Alison)
v2:
- Drop ACPI checksum export and just use local verification. (Dan)
---
 drivers/cxl/core/pci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 25b7e8125d5d..9c7e2f69d9ca 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -528,6 +528,16 @@ static int cxl_cdat_read_table(struct device *dev,
 	return 0;
 }
 
+static unsigned char cdat_checksum(void *buf, size_t size)
+{
+	unsigned char sum, *data = buf;
+	size_t i;
+
+	for (sum = 0, i = 0; i < size; i++)
+		sum += data[i];
+	return sum;
+}
+
 /**
  * read_cdat_data - Read the CDAT data on this port
  * @port: Port to read data from
@@ -573,6 +583,12 @@ void read_cdat_data(struct cxl_port *port)
 	}
 
 	port->cdat.table = cdat_table + sizeof(__le32);
+	if (cdat_checksum(port->cdat.table, cdat_length)) {
+		/* Don't leave table data allocated on error */
+		devm_kfree(dev, cdat_table);
+		dev_err(dev, "CDAT data checksum error\n");
+	}
+
 	port->cdat.length = cdat_length;
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);


