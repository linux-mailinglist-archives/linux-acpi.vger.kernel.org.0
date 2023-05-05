Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57EE6F87A7
	for <lists+linux-acpi@lfdr.de>; Fri,  5 May 2023 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjEERda (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 May 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjEERdJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2023 13:33:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6BDAD0A;
        Fri,  5 May 2023 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683307984; x=1714843984;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z/YQtogYQbIISXUUKIz/FcxkfBirKCCFl1KoqVUT/aM=;
  b=GFHVEFb41TUfQIjyoDZlnnDTJe1KKBLNjVX8naAM/Db1I0JKqHyBUjOq
   Kk0Go4ihodkI8sRvvtf+mRn6bU5D9ohtvU6tHFAgWryBf0hx8CEqTN6R+
   LzZLmEq1Xn21XzWMdDASKFp+T0OJvr49bgKffNELjkAfx/X3dkTreObXH
   94pxibssJE74b3bnEFrIpWGMWNR1wGyVtUtqNpQH31fvpYEPEAaio0GsV
   YidqzdqAFEB8ra+7UfjPJW4kzOVyxWh7ty889DlhtgEj7/9Miq2F/tUsh
   H4klcbH4B6tlmQyetyUvTfXM03qOFlPU2yuIHRjEgVC8Rdyj914cumdga
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349301217"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="349301217"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="700531240"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="700531240"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:33:03 -0700
Subject: [PATCH 2/4] acpi: Add header struct in CDAT subtables
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 05 May 2023 10:33:02 -0700
Message-ID: <168330798275.2042604.11217169699695338532.stgit@djiang5-mobl3>
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

Add the common header struct in all CDAT subtables. This change
complies with other ACPI sub-tables in the header file. The change
also eases the usage with the helper functions in tables.c.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/acpi/actbl1.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 3119be093cfe..166337b04306 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -350,6 +350,7 @@ enum acpi_cdat_type {
 /* Subtable 0: Device Scoped Memory Affinity Structure (DSMAS) */
 
 struct acpi_cdat_dsmas {
+	struct acpi_cdat_header header;
 	u8 dsmad_handle;
 	u8 flags;
 	u16 reserved;
@@ -364,6 +365,7 @@ struct acpi_cdat_dsmas {
 /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
 
 struct acpi_cdat_dslbis {
+	struct acpi_cdat_header header;
 	u8 handle;
 	u8 flags;		/* If Handle matches a DSMAS handle, the definition of this field matches
 				 * Flags field in HMAT System Locality Latency */
@@ -377,6 +379,7 @@ struct acpi_cdat_dslbis {
 /* Subtable 2: Device Scoped Memory Side Cache Information Structure (DSMSCIS) */
 
 struct acpi_cdat_dsmscis {
+	struct acpi_cdat_header header;
 	u8 dsmas_handle;
 	u8 reserved[3];
 	u64 side_cache_size;
@@ -386,6 +389,7 @@ struct acpi_cdat_dsmscis {
 /* Subtable 3: Device Scoped Initiator Structure (DSIS) */
 
 struct acpi_cdat_dsis {
+	struct acpi_cdat_header header;
 	u8 flags;
 	u8 handle;
 	u16 reserved;
@@ -398,6 +402,7 @@ struct acpi_cdat_dsis {
 /* Subtable 4: Device Scoped EFI Memory Type Structure (DSEMTS) */
 
 struct acpi_cdat_dsemts {
+	struct acpi_cdat_header header;
 	u8 dsmas_handle;
 	u8 memory_type;
 	u16 reserved;
@@ -408,6 +413,7 @@ struct acpi_cdat_dsemts {
 /* Subtable 5: Switch Scoped Latency and Bandwidth Information Structure (SSLBIS) */
 
 struct acpi_cdat_sslbis {
+	struct acpi_cdat_header header;
 	u8 data_type;
 	u8 reserved[3];
 	u64 entry_base_unit;


