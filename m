Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8543452CE
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 00:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCVXKL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 19:10:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:20269 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhCVXJk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Mar 2021 19:09:40 -0400
IronPort-SDR: lsvopVouV+Mi/NPi0e64EXy6g3IHUDBwhoIU//aienKUclCDmLK13XtWFSSKyrnB6CvCvh4o6s
 vg2vGsYHafTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251718885"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="251718885"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:09:38 -0700
IronPort-SDR: GAIBKWqCD1B6lS0K3aBb4t8iJHQruKq4aUHwxf7pBfBGh2LjQmZAtBKhCK0/gFZmu2ajdzHEWQ
 +U69ZfzY7pYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="607510508"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2021 16:09:38 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v3 4/4] ACPI: Add \_SB._OSC bit for PRM
Date:   Mon, 22 Mar 2021 15:37:07 -0700
Message-Id: <20210322223707.1838823-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322223707.1838823-1-erik.kaneda@intel.com>
References: <20210322223707.1838823-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/bus.c   | 1 +
 include/linux/acpi.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3484497923d5..e8119a9eca28 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -305,6 +305,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
 
 #ifdef CONFIG_ARM64
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6868b342cdc3..fc50d2202446 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -547,6 +547,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
+#define OSC_SB_PRM_SUPPORT			0x00020000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 
 extern bool osc_sb_apei_support_acked;
-- 
2.29.2

