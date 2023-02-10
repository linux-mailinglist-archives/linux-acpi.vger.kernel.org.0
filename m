Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4598F691AD8
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjBJJIU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjBJJHj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:07:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A4123C4B;
        Fri, 10 Feb 2023 01:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676020021; x=1707556021;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0vAv81xsakge/rDyjzGZncp54zlO+3hec2ycZsFjWQ=;
  b=n6zGVQFN0jAQQSUJ5RydnkU/ABHiehvVwNv7cT5dsVJJrvmlsgFruxm+
   1GLG6PSRIh/8ufbfm14djICUv/9Gy2DbaQmUIJzWHy/bJXo4KpsmaDpFD
   pvaUm/FhiUqjFjNZC4ztmOLUhBL2exHEeOLmfwYjIVwXPVrupNTPzqqMT
   WU5V3HVEniSIDuAwOFA85So+wPtb8C7Ugg5eFYDG09qUSPWc+CrvtPhzt
   PkGk2Y9voRWQvFU8S57h6rOdtW5G1gAz8Fa9MhqQddElj193iiVYU0DKC
   6QYrjpNLBa9fLNmB2U4DK5xuYDaIFYR5Fozl1fB9HVHxiftZVFZ+grrAi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328062605"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="328062605"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="700392810"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="700392810"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:56 -0800
Subject: [PATCH v2 16/20] dax/hmem: Drop unnecessary dax_hmem_remove()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gregory.price@memverge.com>,
        Fan Ni <fan.ni@samsung.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:56 -0800
Message-ID: <167602001664.1924368.9102029637928071240.stgit@dwillia2-xfh.jf.intel.com>
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

Empty driver remove callbacks can just be elided.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564542679.847146.17174404738816053065.stgit@dwillia2-xfh.jf.intel.com
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

