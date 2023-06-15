Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323A2732198
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jun 2023 23:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjFOVYA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jun 2023 17:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjFOVX7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jun 2023 17:23:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FC02962;
        Thu, 15 Jun 2023 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864237; x=1718400237;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KkhMEzxXU8CC/Aa+3udHBagC72rArqsW6CT+7tfGKec=;
  b=LUhh3AI7lkskLXx7j4pVoGTQpcAj9rn+U2LTy/f2oyTVoABdiq7UzU/F
   gJ6PuvAHWpc3UMx9BsMBlkBodtEOWbs/MBVykO2hYrwklIx4zxNDH/wZl
   o4ls5gszJFrrW5cycCICvg0GVn9mhPiqL0briI6LJ97I5htuBc6E3cE1Y
   TqQmdxlBZMp6209ZGSHTrGsHaW3rV29in1F/FIVyir0w4v+ompiBnDu5g
   WWD8ODHMBKECJw+vaovOxuIoDURAmvCv2iMxmzWHtmOu9pKU3d2+UPU8v
   i+GWlS0LceTyL/pA1YOLqSA41rxuS4o0fn17gjUpf4t5e7m3kL3WFmimq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424975422"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424975422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825457897"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825457897"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.110.129])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:23:56 -0700
Subject: [PATCH v3 2/6] ACPICA: Add a define for size of
 acpi_srat_generic_affinity DeviceHandle
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Thu, 15 Jun 2023 14:23:55 -0700
Message-ID: <168686423583.2950427.5409194525724370539.stgit@djiang5-mobl3>
In-Reply-To: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
References: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
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


