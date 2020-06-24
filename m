Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7D207BC4
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jun 2020 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406000AbgFXSvo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Jun 2020 14:51:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:49963 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405808AbgFXSvo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Jun 2020 14:51:44 -0400
IronPort-SDR: pKPA21B+uMgIqqoduevgqPeaIgsnL75fe9BWJ2pCj69tqyfwMP2VK6vml5Wl4rt1oS5Shvsb7b
 I0e9ipNPK2FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="206123699"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="206123699"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 11:51:43 -0700
IronPort-SDR: T7beGo5cOt3/eJwZcWA5xpuDJnvUoEKe2u+XvSCa4OhUK096WiTcri2hs5uo4kj/xn98EzPIF2
 spHepU84gf1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="385253982"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2020 11:51:43 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI: DPTF: Add battery participant for TigerLake
Date:   Wed, 24 Jun 2020 11:51:40 -0700
Message-Id: <20200624185140.3842391-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Added ACPI ID for battery participant for TigerLake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/dptf/dptf_power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 5fab7e350db8..92b996a564d0 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -228,6 +228,7 @@ static const struct acpi_device_id int3407_device_ids[] = {
 	{"INT3407", 0},
 	{"INT3532", 0},
 	{"INTC1047", 0},
+	{"INTC1050", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
-- 
2.25.4

