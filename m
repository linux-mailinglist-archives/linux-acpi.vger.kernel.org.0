Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D2B704D00
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjEPLuq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjEPLuJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:50:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CCD1986
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237796; x=1715773796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LDh3/ulcjpVzc1kWMXWyk72lw2x2F5XCJG1Yb1dhhKw=;
  b=EuWcuCZYT2NLtIS1toSmwofINP77Q3Me/tmGKmtRmjX6Zbny5SwiMnJn
   L4xysjOXsfI6/dSts0efKqTh067M+hteFgwMGXrEfhIrIEpw9yKWDYBB5
   OT6rMujKXgvsc0dmBAo8K9pPbsIK4DxxQja8Zb/YUHbA2hS33gVNLqaIX
   Na5O2kwmxJEGHNdCogwG+jkPWvB+W9XqiFOC5KNjGPGEbxUY/vfekjJn3
   IseZvMnGyi76xzL6AfALtNGv7suBeFMsqcEbssLxGLowMRPtW4RjBS/wn
   b0pmWD/G4xyKPcrvKLxgvU2G3e2BTzi1Jk2rCTzw+VSDqQJYAtt+/HzBE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111763"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111763"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731962020"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731962020"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:17 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 34/34] acpi/bus: Remove notify callback and flags
Date:   Tue, 16 May 2023 13:46:17 +0200
Message-Id: <20230516114617.148963-35-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230516114617.148963-1-michal.wilczynski@intel.com>
References: <20230516114617.148963-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As callback has been replaced by drivers installing their handlers in
.add it's presence is not useful anymore.

Remove .notify callback and flags variable from struct acpi_driver,
as they're not needed anymore.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 include/acpi/acpi_bus.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7fb411438b6f..3326794d5b70 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -151,12 +151,10 @@ struct acpi_hotplug_context {
 
 typedef int (*acpi_op_add) (struct acpi_device * device);
 typedef void (*acpi_op_remove) (struct acpi_device *device);
-typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
 
 struct acpi_device_ops {
 	acpi_op_add add;
 	acpi_op_remove remove;
-	acpi_op_notify notify;
 };
 
 #define ACPI_DRIVER_ALL_NOTIFY_EVENTS	0x1	/* system AND device events */
@@ -165,7 +163,6 @@ struct acpi_driver {
 	char name[80];
 	char class[80];
 	const struct acpi_device_id *ids; /* Supported Hardware IDs */
-	unsigned int flags;
 	struct acpi_device_ops ops;
 	struct device_driver drv;
 	struct module *owner;
-- 
2.40.1

