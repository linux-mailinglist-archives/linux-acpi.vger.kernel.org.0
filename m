Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9707087DE
	for <lists+linux-acpi@lfdr.de>; Thu, 18 May 2023 20:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjERSdw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 May 2023 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjERSdv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 14:33:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02D6127;
        Thu, 18 May 2023 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684434830; x=1715970830;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQ00hd0YR4BGL/6CcDpbb4RmtqcJv+sUZVhHtSVJapg=;
  b=IwISkHbgjgSQUB2cPUsKmyNfhScZYh+THAtTTRgks/ARacmj/YHz76sM
   PHSljW5bFsNNEoC0lh6A8C6QbZE22he8PbX37auPxCBcP74xZ+/vPoslp
   DSlja4484rgfJO2Hu+CxxoMd+Fs7MMpsX5iVJ1ytIy6mAG49xeTfMdzEB
   3gRg7uN1tCgViyqDS3aPSisK88HyD8qM7y8PONcBvfVflaLvsaq7RPHqN
   bBvswSyxSeQLheP0DguEvLISfpw/ceoQc3cKTQOsXCAb21Pzw0usLeQES
   DthEgvHpjuaTliyEPPLVKQu5ZyDqO5wEDWJqIYuvkduVx/lh78t4D8XrQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="349669910"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="349669910"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:33:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="767330276"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="767330276"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:33:20 -0700
Subject: [PATCH v2 4/4] acpi: Add defines for CDAT SSLBIS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Thu, 18 May 2023 11:33:20 -0700
Message-ID: <168443480048.2966470.1931302851443645778.stgit@djiang5-mobl3>
In-Reply-To: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add upstream port and any port definition for SSLBIS.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
See https://github.com/acpica/acpica/pull/874
Merged
---
 include/acpi/actbl1.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 15df363b9144..c6189fafe87f 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -419,6 +419,9 @@ struct acpi_cdat_sslbe {
 	u16 reserved;
 };
 
+#define ACPI_CDAT_SSLBIS_US_PORT	0x0100
+#define ACPI_CDAT_SSLBIS_ANY_PORT	0xffff
+
 /*******************************************************************************
  *
  * CEDT - CXL Early Discovery Table


