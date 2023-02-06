Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4168B388
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBFBDZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFBDY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:03:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB28A144B8;
        Sun,  5 Feb 2023 17:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645403; x=1707181403;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1wW75nbCrf3Mo9olc/rXs6RitxwA0HhPGRVwUk3MkpQ=;
  b=cdOXogEpJQ4b9DkUVRe1uYinj//tFtgvOE5QcSTD1vu/IVKOXL+gzj9/
   CvyzAiFU73EqSyw8XwG33BVTDiNtb4QUJ5HPSIVnmRrOPFp+6kLOJ4pAj
   y1acNyf7qWYTzzURDoI6Fjia0qRMZUUSSZ0Xad01zkUj6Z8/if/nmhSW9
   J3XOQQCv92VXD0RPjsx4fPGu6dpXeERvKZI3Gl/GHlDKnRqsNO/FUKxJ5
   t0O9lJJw8/4s9g7UeIBRX+MAf7ixNUukW6HP72hjH35VKGJP76zJxRfjj
   Y1GcvQXGi43QvKVevNqGadQ7XJWW14tfgYfToFLCq8sw5K8mBJYMJudVj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="312763209"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312763209"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="616291323"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616291323"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:19 -0800
Subject: [PATCH 09/18] cxl/region: Enable CONFIG_CXL_REGION to be toggled
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:03:18 -0800
Message-ID: <167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add help text and a label so the CXL_REGION config option can be
toggled. This is mainly to enable compile testing without region
support.

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

