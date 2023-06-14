Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140C77309FC
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jun 2023 23:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFNVsW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jun 2023 17:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjFNVsT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jun 2023 17:48:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAB6268C;
        Wed, 14 Jun 2023 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686779298; x=1718315298;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBNArsLwwppyPXWARVS5buh24Hqnq9o+Jj2eaRkIogk=;
  b=F474lobyTiNGSQ4hKpMf4nw/Bphlsv9sz60kI1V4mDJI5TQ7jewg0Bb2
   iFYf8LD4AICYCfXsN9Wjyl2ITzUtpY8yAHD5ikyQLOxoHVPmEAosHKZLC
   8wE85WRY1sYAqTAlwcQBVj12euYKT4LBB0TiVM4CVqvGUOrFAobjItOXw
   5Ne9ypGd9pIOL8iYmnKDbiz8L0K3RwO7JbSk1nn12G5S/8Wu6102fMtbO
   1t5xuZTnQbw8K/Muq8YzCG2yd4snhWVhNwy8j+6U55MJNeN1WDIJocixJ
   5kgH+z1uQQnt642VnPJ9ItfrnZL+Dsp0NNAqcRwwT6egxgjW4jsLZmrht
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="357624249"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="357624249"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 14:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715366012"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="715366012"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.110.39])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 14:48:17 -0700
Subject: [PATCH v4 3/4] acpi: fix misnamed define for CDAT DSMAS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com, guohanjun@huawei.com
Date:   Wed, 14 Jun 2023 14:48:17 -0700
Message-ID: <168677929734.2787985.10830491440007394080.stgit@djiang5-mobl3>
In-Reply-To: <168677921156.2787985.6927511816148622557.stgit@djiang5-mobl3>
References: <168677921156.2787985.6927511816148622557.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI_CEDT_DSMAS_NON_VOLATILE should be defined as
ACPI_CDAT_DSMAS_NON_VOLATILE. Fix misspelled define.

Links: https://github.com/acpica/acpica/pull/874
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
---
 include/acpi/actbl1.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 58b0490a2ad1..8d5572ad48cb 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -402,7 +402,7 @@ struct acpi_cdat_dsmas {
 
 /* Flags for subtable above */
 
-#define ACPI_CEDT_DSMAS_NON_VOLATILE        (1 << 2)
+#define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
 
 /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
 


