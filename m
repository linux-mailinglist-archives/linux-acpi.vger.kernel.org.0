Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10376767EE0
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jul 2023 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjG2Lxd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Jul 2023 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjG2Lx3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Jul 2023 07:53:29 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5F3A99;
        Sat, 29 Jul 2023 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690631608; x=1722167608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2dClKk9mbxGL+oyokT6h+JrcG9FfvfifzgcmH4N+eW0=;
  b=iD7KS6nopoPiLm6H2ZXnOo1Se1ezxIatsaUJlbBW6bIR3cWvQN8VrOPs
   XIsegMVoC5xV72azINOnDY446dyFMYOHZwbaIBzZ9cZVSgStEjr74ZusW
   YBJ7tXxGowXPfpd/D2PJ9XvuIc/VQKHezAJ/7h7Jq2B1WkqBY38u0XsJg
   xH8HN9I1DSAsgQ93UOQCjLNzaa/Z8ZU3NozfmwPddCjWhlqEg6ARhH2qn
   Lptg6IYwrzJt9qzuv1kUaiHKybi6WGHMayfSjOciRhQo0IYR1LymIr6QB
   cUptX198/syaleg/MGfwe/UXJBlX6yFgKdDHN3fnRhAbmpxMM6BjIr67/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="455116357"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="455116357"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 04:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="762848881"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="762848881"
Received: from shsensorbuild2.sh.intel.com ([10.239.134.197])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2023 04:53:25 -0700
From:   Wentong Wu <wentong.wu@intel.com>
To:     sakari.ailus@linux.intel.com, hdegoede@redhat.com,
        djrscally@gmail.com, laurent.pinchart@ideasonboard.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     bingbu.cao@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com,
        Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH v10 3/3] ACPI: delay enumeration of devices with a _DEP pointing to IVSC device
Date:   Sat, 29 Jul 2023 19:52:55 +0800
Message-Id: <1690631575-15124-4-git-send-email-wentong.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690631575-15124-1-git-send-email-wentong.wu@intel.com>
References: <1690631575-15124-1-git-send-email-wentong.wu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Inside IVSC, switching ownership requires an interface with two
different hardware modules, ACE and CSI. The software interface
to these modules is based on Intel MEI framework. Usually mei
client devices are dynamically created, so the info of consumers
depending on mei client devices is not present in the firmware
tables.

This causes problems with the probe ordering with respect to
drivers for consumers of these mei client devices. But on these
camera sensor devices, the ACPI nodes describing the sensors all
have a _DEP dependency on the matching mei bus ACPI device, so
adding IVSC mei bus ACPI device to acpi_honor_dep_ids allows
solving the probe-ordering problem by delaying the enumeration of
ACPI-devices which have a _DEP dependency on an IVSC mei bus ACPI
device.

On TGL platform, the HID of IVSC mei bus ACPI device is INTC1059,
and on ADL platform, the HID is INTC1095. So add both of them to
acpi_honor_dep_ids.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 drivers/acpi/scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2743444..59c92a9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -796,6 +796,9 @@ static const char * const acpi_ignore_dep_ids[] = {
 /* List of HIDs for which we honor deps of matching ACPI devs, when checking _DEP lists. */
 static const char * const acpi_honor_dep_ids[] = {
 	"INT3472", /* Camera sensor PMIC / clk and regulator info */
+	"INTC1059", /* IVSC (TGL) driver must be loaded to allow i2c access to camera sensors */
+	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
+	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	NULL
 };
 
-- 
2.7.4

