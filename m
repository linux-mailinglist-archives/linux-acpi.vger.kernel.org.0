Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26C67309FE
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jun 2023 23:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjFNVsZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jun 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjFNVsZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jun 2023 17:48:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B28268F;
        Wed, 14 Jun 2023 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686779304; x=1718315304;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BlBJs6J2Ig0B77uN9ly6Nsq9/OB13grYX/N1Pr3I6jg=;
  b=Wdd+DZbG9qrIu51VICWKRvd+/5OpXX3FZ/KrFACVOobUMyVahs2DcmFo
   0ZuRnDImVOxUi6LYXFWQ+d40vT6R/aN67VEbG/xf/qK6298pTIh8oJn2V
   iX8DUj0b7aZE/+/2pF2Egs+FSg0swolLqiY9rqekQIH/4saqzRmscrprT
   Yf6Q9yBp8uCklYoS+LQFOQxdVIxZrVPPFLggk2Ig5s/cfdWcSJVsqxIU4
   KBC052Bi8N/fYO58JHDV7/f5zymvBKiN2va71xHa73Zw7Tqv9ohi/3TCt
   tfx4ZulJ8lpZCCQfi14IM0PJlpvDFzF3qcFctthQk/0S+0rMHCaFzcM3t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="357624264"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="357624264"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 14:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715366017"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="715366017"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.110.39])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 14:48:23 -0700
Subject: [PATCH v4 4/4] acpi: Add defines for CDAT SSLBIS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com, guohanjun@huawei.com
Date:   Wed, 14 Jun 2023 14:48:23 -0700
Message-ID: <168677930330.2787985.15866363373310739456.stgit@djiang5-mobl3>
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

Add upstream port and any port definition for SSLBIS.

Links: https://github.com/acpica/acpica/pull/874
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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


