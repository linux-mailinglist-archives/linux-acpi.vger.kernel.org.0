Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D696A3A2325
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 06:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhFJESj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 00:18:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:23380 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhFJESi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Jun 2021 00:18:38 -0400
IronPort-SDR: /MleY8rY9KwiySZ57VauzI5cOxaA+M/XLyMt/bLS00dlBcn/obSCGJz0lY2MUEJW81QoyydS/q
 CocHyWZUTDAg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202196871"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="202196871"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 21:16:41 -0700
IronPort-SDR: Hkr68tC3Vet0caVTQqmqD6u48DlON1saug9acLOA+CnkDB+D3gnvzgGcrEkXm06t/xnJQsuuAN
 4Kt8AhVARu7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="441064182"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2021 21:16:41 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 3/3] ACPI: Add \_SB._OSC bit for PRM
Date:   Wed,  9 Jun 2021 20:41:53 -0700
Message-Id: <20210610034153.3882311-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210610034153.3882311-1-erik.kaneda@intel.com>
References: <20210610034153.3882311-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
index 4c07ac22c6ba..a618ba698a5c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -551,6 +551,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
+#define OSC_SB_PRM_SUPPORT			0x00020000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 
 extern bool osc_sb_apei_support_acked;
-- 
2.29.2

