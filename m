Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3573C4B78DC
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Feb 2022 21:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbiBOSye (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Feb 2022 13:54:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbiBOSye (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Feb 2022 13:54:34 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720718D68C
        for <linux-acpi@vger.kernel.org>; Tue, 15 Feb 2022 10:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644951264; x=1676487264;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iqCUg8R9cf+BoIRItR4uowgVJzhvGlWm51JimYIpIok=;
  b=T8vrYwjcz/GKUXE4DHV/JXv7p/k2XXruKtXwCztUk5JFCm9FLQAqdPC3
   3FJ58Curz7nHlx0hK9ob52WXAuB2OHwlQuANdmUF7BQE91KoDxXqUXrkW
   zbjHgIqJiYBziedfoyIxWS0vaceHbz9gvLj4B/EpI1DGLqWtdDabijlw+
   ZdvrHZ8w4AEkerrT6dVXgG3mJ84fyuDPq+xFUzxLqP8TXR984oGeKDyMR
   +KMJxnkQlN5ocQoqZMoTI8EGfZAOBCeecFF3+TiIQSrwQnBQARExK3SrP
   akLhfNYVzYMS/xPYMEXDsS6R/IY0PT/nsm7zUxHmNukFy4YGrk7+wdKqw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311169537"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="311169537"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 10:54:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="486311791"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 10:54:24 -0800
Subject: [PATCH] ACPI: Quiet ACPI table not found warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-acpi@vger.kernel.org
Date:   Tue, 15 Feb 2022 10:54:23 -0800
Message-ID: <164495126389.3958890.23245745243532605.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de>
References: <55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Paul reports that the ACPI core complains on every boot about a missing
CEDT table. Unlike the standard NUMA tables (SRAT, MADT, and SLIT) that
are critical to NUMA init, CEDT is only expected on CXL platforms. Given
the notice is not actionable lower its severity to debug.

Link: https://lore.kernel.org/r/55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de
Fixes: fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/tables.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0741a4933f62..34600b5b9d8e 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -400,7 +400,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 
 	acpi_get_table(id, instance, &table_header);
 	if (!table_header) {
-		pr_warn("%4.4s not present\n", id);
+		pr_debug("%4.4s not present\n", id);
 		return -ENODEV;
 	}
 

