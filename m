Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0956CB0D7
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjC0VoR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjC0VoQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:44:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D281FF2;
        Mon, 27 Mar 2023 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953455; x=1711489455;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pFqON91iYbteazF95zQ7LMgoJ45bF8CJY0dtaCEPOTc=;
  b=TAP0RRP/5E4i4SYqfbYkACMF13GBuuxNeFllc4OlEqcu4Z4Ugsbz73Er
   2hVQ1gvS3NvhBKA+Ced2GhiAswp0G4tbtkN/OgxL51Xqvs7tyNZsp3p4D
   ePTKmAzMg4xZdCRBAStzzXP/QYjVm5V3V1HRwxGhjY16KQfnlsPqQrsfJ
   dZeywbRfcSIynxNLFKk+QkjfPpsyurDHrHFUOw099KcBHTEz9App/pU7h
   kaBazK0wHKr4fdZ0NUGeyoDex63JBbdYDh2EGPUv1kNZraYQQKGSFSw4S
   cIWxDUE7aNH0NCizuoZb97GcHDtJ80BmeQQPW9m43Mf0jLIvgciR39E2X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320798895"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320798895"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="857803675"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="857803675"
Received: from spal2-desk3.gar.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:44:14 -0700
Subject: [PATCH v2 02/21] cxl: Add checksum verification to CDAT from CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:44:13 -0700
Message-ID: <167995345388.2857312.2421270054519644444.stgit@djiang5-mobl3>
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

A CDAT table is available from a CXL device. The table is read by the
driver and cached in software. With the CXL subsystem needing to parse the
CDAT table, the checksum should be verified. Add checksum verification
after the CDAT table is read from device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Drop ACPI checksum export and just use local verification. (Dan)
---
 drivers/cxl/core/pci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 25b7e8125d5d..e0d5e6525c0d 100644
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
+	return 0 - sum;
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


