Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8027691ACD
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjBJJHc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjBJJGf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAD611EB9;
        Fri, 10 Feb 2023 01:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019975; x=1707555975;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fhaP5oPHi1onz90GhrHdXiTbxa3g3s/6YpVTWY4pO0U=;
  b=JSHxYX701Clq6zXbr/KYF3yvV9vve2AyF2a6BgVEk7+OkN08K/bRgRhW
   XBfbQNhg/zp37M6Tn409rIWiPwpoI9dlVkIht5iTBbws5MdL5HZBDBrtX
   d+he9BFR+5kMxxFKVD1chUYv5VNESK+WN1ybfTm1p1sKZlBV4g8CXlyWg
   lmbhnIrVIR3cgGcM6597h9CDlpP2rhWoxgRoipt7Cs/29HPc+tmb/mo42
   QAVQswxM2bkVgYK9zvSOocOt39wCtZlHZYHMKZGMxUZ7LLxi0H4R0WS9O
   2z5GIKpR+rl1gYlpFyhB4w9eQDmPuU7iZ1yVvZmyihQhdFt5db66f+tcs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416600064"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="416600064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="669930260"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="669930260"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:10 -0800
Subject: [PATCH v2 08/20] cxl/region: Cleanup target list on attach error
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:09 -0800
Message-ID: <167601996980.1924368.390423634911157277.stgit@dwillia2-xfh.jf.intel.com>
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

Jonathan noticed that the target list setup is not unwound completely
upon error. Undo all the setup in the 'err_decrement:' exit path.

Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Link: http://lore.kernel.org/r/20230208123031.00006990@Huawei.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 040bbd39c81d..ae7d3adcd41a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1347,6 +1347,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 
 err_decrement:
 	p->nr_targets--;
+	cxled->pos = -1;
+	p->targets[pos] = NULL;
 err:
 	for (iter = ep_port; !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))

