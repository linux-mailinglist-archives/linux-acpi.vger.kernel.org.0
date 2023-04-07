Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30686DB140
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDGRMK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjDGRMJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:12:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60789ED1;
        Fri,  7 Apr 2023 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887528; x=1712423528;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8MxlJ1+PFYsT4zJD2rLD6eOXsfO1SJ5tDzA0hk12vHw=;
  b=Z/cJA3R29yUCWMlsIGEnv43NJealSX1eAwdNvdQpVGaPN72nZaKeox5Z
   efDcZr8+4wUzgYT/ssthxKRAz7rNE3etdBzGWYb4L6H3dhil03JOY4Nd/
   HcswJL0q0QpHcw4mFdb9eEYRs8aR80pOWXhn4c6+RfQEFM9ElsFadW6Qp
   wBOEoD3cElmSRN5KbuLgOvpixVpfW+T5PfhNmeFn0EkX5bVgsxbBWtF0m
   22QRo7kfIjf1ZlvLsHMiJ10XJxDKGilAf3E0/B+0/tQJf8k0OOi+cHCr4
   KFnm2yxwE2ClVpkRNSELkL4cnjL0tzxGp/YSF/d5VWPrvRkfMkEwZVceL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="323402089"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="323402089"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="717902620"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="717902620"
Received: from rramanna-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:07 -0700
Subject: [PATCH 3 02/23] cxl: Add checksum verification to CDAT from CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:12:06 -0700
Message-ID: <168088752692.1441063.12748870422089681966.stgit@djiang5-mobl3>
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


