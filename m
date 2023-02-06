Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033E468B38E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBFBDt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBFBDs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:03:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298208A53;
        Sun,  5 Feb 2023 17:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645428; x=1707181428;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ME8XRCvN/v2Itlb7KzpHyRZDGDqzMok/X5JUlaNFKjM=;
  b=gx6W2Yk7XxUKIxbtRO/Apx7OhpEQTJ0eQl6sXp0DGths2dlKfgaZ1P4r
   0D2q2vibkUfC6QgEdK5GRqChWGVIMrOzisFzB9Zf8wxbjcID73o89BksI
   Ksz0ca6bY8e7LUixQLwHvXt0ggbUdx4c6OqVRG4RVs6ovr/1XSy3wYUfN
   zx16ZDXa1ABvplS9N76bKv7VbSQbAKOrQZSc32Wa7acroDOhOcnZufNsC
   g6zjwEf6PxeGynkPREXyfhGKqfVWEANJrNgCyulAPx4UavrwVeADpR1QV
   hVYJbz6AaJgT9rIXsUO9vIc9NrjnWKLc55Z0SlV8z72qCoOZkBmi2iMQ3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="309442676"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309442676"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="775006679"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775006679"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:47 -0800
Subject: [PATCH 14/18] dax/hmem: Drop unnecessary dax_hmem_remove()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:03:46 -0800
Message-ID: <167564542679.847146.17174404738816053065.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
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

Empty driver remove callbacks can just be elided.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/hmem.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 1bf040dbc834..c7351e0dc8ff 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -44,15 +44,8 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int dax_hmem_remove(struct platform_device *pdev)
-{
-	/* devm handles teardown */
-	return 0;
-}
-
 static struct platform_driver dax_hmem_driver = {
 	.probe = dax_hmem_probe,
-	.remove = dax_hmem_remove,
 	.driver = {
 		.name = "hmem",
 	},

