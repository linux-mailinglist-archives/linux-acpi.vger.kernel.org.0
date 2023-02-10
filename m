Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84196691AC8
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjBJJGx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjBJJGN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A937713;
        Fri, 10 Feb 2023 01:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019953; x=1707555953;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOZoUMpBUKRLc8QIK289XEjoJsII4YkEt62Y5Arb8us=;
  b=ayHpBr5/S6SDefaGkDCl7ygH5IL2FZiTFvGE10pqlIFkSkwkhO1yTxIT
   Djues1HUKDGuS4yUcY2a/c2YKKMQo9FAdgqODujZkzm9Jkrx1UOzYsdsK
   Aw8yygItcbcW4rQx9Iv1ZfejyYcZTjmh3u3SIS2IbM3lhUsHtNW+2ZArA
   mXwT4qGfqiyFDBi75NgPWBSZ7FiP9f+tGw+/9/eNghQeKeyVlrHjJn5e3
   ZBvJwTfA6fwGiN7nNmdVmHfjFno7GaIc6vbhBbhdX9R6qvfGLbifUh99Y
   96veemMbkvk66OfAN+62RsVVUClh9JynZG4dj2WJ79kVG5SygvNvQV1Rs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416600012"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="416600012"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="669930208"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="669930208"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:51 -0800
Subject: [PATCH v2 05/20] cxl/region: Validate region mode vs decoder mode
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:05:51 -0800
Message-ID: <167601995111.1924368.7459128614177994602.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for a new region mode, do not, for example, allow
'ram' decoders to be assigned to 'pmem' regions and vice versa.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0fc80478ff6b..285835145e9b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1221,6 +1221,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int i, rc = -ENXIO;
 
+	if (cxled->mode != cxlr->mode) {
+		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
+			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
+		return -EINVAL;
+	}
+
 	if (cxled->mode == CXL_DECODER_DEAD) {
 		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
 		return -ENODEV;

