Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4579E6F87AA
	for <lists+linux-acpi@lfdr.de>; Fri,  5 May 2023 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjEERdb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 May 2023 13:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjEERdK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2023 13:33:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A513C34;
        Fri,  5 May 2023 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683307989; x=1714843989;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YN+oJapGmyCTPCfCe0BSQmXfdb6zKqYD+fIXjEyZ1y0=;
  b=bmSs6SbnCZQb2YmQ3Sb/XjiU2Zii23v3oVPstEgr4iWtLpLN0FYlJCS7
   7yzvCNd5G6AroBmXoUgy8BscZjz01J1f7+qEImckEuViAkXYa1ObMCRKJ
   Wyv9Hs2MgWgJhRzyoCuJcoUO2/AgGyVG2Ua4gTMAC5bw55tmvgUM1o6E2
   mwogh+iX41YVabyQqpfclY2FYVNBIl64gg1VuSkDYul/oJhnsdShbuwpS
   NxE1xNrIJm65VNe84vtvuAeag6KvSjM3J8qw5Kr91ZGopCfBGVaUq2nVf
   mMfdCQoJaMWAYk/6HHFCarYTB9h76FJ5siZP3tPKcq8s+je6lMWYpTg0O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349301234"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="349301234"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="700531264"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="700531264"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:33:09 -0700
Subject: [PATCH 3/4] acpi: fix misnamed define for CDAT DSMAS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 05 May 2023 10:33:08 -0700
Message-ID: <168330798865.2042604.4255466100952700191.stgit@djiang5-mobl3>
In-Reply-To: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
References: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI_CEDT_DSMAS_NON_VOLATILE should be defined as
ACPI_CDAT_DSMAS_NON_VOLATILE. Fix misspelled define.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/acpi/actbl1.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 166337b04306..8ea7e5d64bc1 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -360,7 +360,7 @@ struct acpi_cdat_dsmas {
 
 /* Flags for subtable above */
 
-#define ACPI_CEDT_DSMAS_NON_VOLATILE        (1 << 2)
+#define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
 
 /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
 


