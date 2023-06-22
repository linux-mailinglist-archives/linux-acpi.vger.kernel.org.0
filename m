Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1E73ABB4
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 23:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFVVjm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFVVjl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 17:39:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE5B1FED;
        Thu, 22 Jun 2023 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687469980; x=1719005980;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KkhMEzxXU8CC/Aa+3udHBagC72rArqsW6CT+7tfGKec=;
  b=WOTludKkcaW2XGRuALxpnher/mdoNF2O9WuaUXj1T63eKr/bTuvkrP7x
   IAjrvX5k6DNa3W+/vJfBunul9+4/+5Hb3j1AekXSXzr+XwXXg3bQ2gD7X
   gAE5ni58BwqWsj4SsovE7gxNGBO3R4x1K4yiLqTiOQEi/rF2rE5n/adJq
   +KADuqmlSop6ZOg2qOZSpirV3/kZLex06+5ji3sxWBMtLItglj4x/C/Zd
   gpuBSTrNSrs0oSS5yLOumBAUbBOnAqBkJx6E3zA9Fbmk4z23uNkBw9tV5
   9jBn0qhWnv6jUyz68Vok8OAPjAvwIzAQsNz4T/nXGXUguMvE1wNh7wbrf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="345381272"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="345381272"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715088897"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715088897"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.53.238])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:39 -0700
Subject: [PATCH v4 2/6] ACPICA: Add a define for size of
 acpi_srat_generic_affinity DeviceHandle
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Thu, 22 Jun 2023 14:39:39 -0700
Message-ID: <168746997931.4115467.47140094903948157.stgit@djiang5-mobl3>
In-Reply-To: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
References: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit be56820b03d8aeabfa6709c4d99bf1711afe7ef1

Replace magic number with a define. Linux kernel code will utilize this
define.

Link: https://github.com/acpica/acpica/commit/be56820b
Link: https://github.com/acpica/acpica/pull/876
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/acpi/actbl3.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index f51c46f4e3e4..1838e5cb313a 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -279,12 +279,14 @@ struct acpi_srat_gic_its_affinity {
  * 6: ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY
  */
 
+#define ACPI_SRAT_DEVICE_HANDLE_SIZE	16
+
 struct acpi_srat_generic_affinity {
 	struct acpi_subtable_header header;
 	u8 reserved;
 	u8 device_handle_type;
 	u32 proximity_domain;
-	u8 device_handle[16];
+	u8 device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
 	u32 flags;
 	u32 reserved1;
 };


