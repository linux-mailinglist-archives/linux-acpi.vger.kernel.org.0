Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3771F4BD
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 23:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjFAVcL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFAVcI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 17:32:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB6C195;
        Thu,  1 Jun 2023 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685655127; x=1717191127;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DXQR/Lpo+Y73F2vX/Z1uBGRi7w60gV47PBhBhCqh8lI=;
  b=iMdszhwYo1TezYpm/uYaIGL9zkM2pUHM//W8mpXoYuzR9VQznRjL5eJO
   xFi9ElGTfGGwJ2SDiif58+oIT3QVrCBy72fIoT7umkWTIx1hA2tBVXsEo
   Cks7hJpowhvt+Kt15GsjdBkBhZcgClGleJ5XMGKj9ZFLmz39eP/LA7PHw
   Dg/wGl9hoJgs2J8huyNRmIdEzevfU9IKhkg5KJ4y+8ZePXXSEcQy8AUqd
   dnvMMwGBZ/7tPuvnsTbm8CEaXcalKmcJ9c3Y0aQ/Lopb7Tk4CHr3lKtbk
   mVsfdfDuNt/Q1oc8ttaZiUnr4UQvzEFYOt5TFzJdcBIEbpRd72Le7D9+8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421507472"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421507472"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:32:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777376583"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="777376583"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.26.132])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:32:05 -0700
Subject: [PATCH v3 3/4] acpi: fix misnamed define for CDAT DSMAS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 01 Jun 2023 14:32:05 -0700
Message-ID: <168565512544.1098279.10448422511551990530.stgit@djiang5-mobl3>
In-Reply-To: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
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

Links: https://github.com/acpica/acpica/pull/874
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

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
 


