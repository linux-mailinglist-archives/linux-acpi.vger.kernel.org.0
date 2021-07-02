Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDAD3B9CB6
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhGBHGI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 03:06:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:46298 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhGBHGC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jul 2021 03:06:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="230353255"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="230353255"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 00:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="482194015"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.122])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2021 00:03:28 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH 2/2] ACPI: let BIOS fall back to legacy handling if PRM disabled
Date:   Fri,  2 Jul 2021 15:03:50 +0800
Message-Id: <1625209430-19934-2-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625209430-19934-1-git-send-email-aubrey.li@intel.com>
References: <1625209430-19934-1-git-send-email-aubrey.li@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Based on _OSC PRM bit, BIOS can choose switch from legacy handling
to using PRM. So if CONFIG_ACPI_PRMT is disabled, this bit should
not be set to let BIOS fall back to the legacy handling (such as SMI).

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 drivers/acpi/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 60fb6a84..30a3d4a 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -303,7 +303,9 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
+#ifdef CONFIG_ACPI_PRMT
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
+#endif
 
 #ifdef CONFIG_ARM64
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
-- 
2.7.4

