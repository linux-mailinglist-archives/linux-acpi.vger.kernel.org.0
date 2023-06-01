Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93B471F4BF
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 23:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjFAVcP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjFAVcO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 17:32:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9770196;
        Thu,  1 Jun 2023 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685655132; x=1717191132;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BEEjOAqfF2uEYyYA/Yp2b7+pHYEv7kWDqY/xkDccu8A=;
  b=bb0gEIhtX+MjP74ch+zcLxAbCUTEA5g4gKa49DIzj6Vc/01Va1XW0c2K
   QSGnXXbOB45VXaVWKTjO1ueliZnGzPM89f1DYNvUgcoQ7KkowmV8w1JQX
   kX1E6CBoNqoI6iKQHywdgqZlrCFEQPu15l/i7gZfe5Ej7DPKRIabaLU1b
   b7gFL/ZSJUtZYhjYiZdNO79UOmq9KCJGdNjDH7HiOYBi+aGGyOHPza0Qh
   w59j+5Z0Onj1lMfInNIzkesLwMs1Qa/fN+qNBgJ7PPrEtuBQ9gnsZiSnx
   rU1kymGf5CdO7i0GdxVfpntRZrfWx5sKZJex/aggd1XybzvOkKlf4ZEbO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421507510"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421507510"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:32:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777376614"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="777376614"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.26.132])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:32:11 -0700
Subject: [PATCH v3 4/4] acpi: Add defines for CDAT SSLBIS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Thu, 01 Jun 2023 14:32:11 -0700
Message-ID: <168565513141.1098279.7310204214131055216.stgit@djiang5-mobl3>
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

Add upstream port and any port definition for SSLBIS.

Links: https://github.com/acpica/acpica/pull/874
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
---
 include/acpi/actbl1.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8d5572ad48cb..a33375e055ad 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -465,6 +465,9 @@ struct acpi_cdat_sslbe {
 	u16 reserved;
 };
 
+#define ACPI_CDAT_SSLBIS_US_PORT	0x0100
+#define ACPI_CDAT_SSLBIS_ANY_PORT	0xffff
+
 /*******************************************************************************
  *
  * CEDT - CXL Early Discovery Table


