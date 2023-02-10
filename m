Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F370B691AD1
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBJJHk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBJJGu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF33EFC5;
        Fri, 10 Feb 2023 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019989; x=1707555989;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QvyAdNBc9ZYsmtnrtNpMiAkkV624GUaybC07KzHXR5s=;
  b=ROTz6GR1lLgZ/UGNGI1F5F3KZIcEtNPAQipPFHlhx+l2ym3IZUOe/rka
   v21sG4kvO5KJ6PDn0qhC+au9KGGeqStppK03cg+DOkqlo7OTzC23Vd/4l
   e/58E5xg52nG0nCAQsivYn7qf4PEvVKpknIvheTQxL+zBJgNxcY4BzCNt
   KcaQLayHLJ2Ae0C6nFsesny21iqnTPUSD6urzLmSNvDFI1EZk72+GXZYC
   HhKB9Osht0Bnt5LepzMoIky4nYHZxlAd2S0LgM/ZQz9FsAhAn+iuPN6wh
   C/fZ+1BzpAFQVsG1ZllOdhtiKb+Vd8fsH4hyC4h7oJI0q85wGy3/BvJ6/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="329003076"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="329003076"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="913463849"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="913463849"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:28 -0800
Subject: [PATCH v2 11/20] cxl/region: Enable CONFIG_CXL_REGION to be toggled
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Fan Ni <fan.ni@samsung.com>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:27 -0800
Message-ID: <167601998765.1924368.258370414771847699.stgit@dwillia2-xfh.jf.intel.com>
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

Add help text and a label so the CXL_REGION config option can be
toggled. This is mainly to enable compile testing without region
support.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 0ac53c422c31..163c094e67ae 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -104,12 +104,22 @@ config CXL_SUSPEND
 	depends on SUSPEND && CXL_MEM
 
 config CXL_REGION
-	bool
+	bool "CXL: Region Support"
 	default CXL_BUS
 	# For MAX_PHYSMEM_BITS
 	depends on SPARSEMEM
 	select MEMREGION
 	select GET_FREE_REGION
+	help
+	  Enable the CXL core to enumerate and provision CXL regions. A CXL
+	  region is defined by one or more CXL expanders that decode a given
+	  system-physical address range. For CXL regions established by
+	  platform-firmware this option enables memory error handling to
+	  identify the devices participating in a given interleaved memory
+	  range. Otherwise, platform-firmware managed CXL is enabled by being
+	  placed in the system address map and does not need a driver.
+
+	  If unsure say 'y'
 
 config CXL_REGION_INVALIDATION_TEST
 	bool "CXL: Region Cache Management Bypass (TEST)"

