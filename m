Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDDC37AD5E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 19:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhEKRwr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 13:52:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:39236 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhEKRwr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 13:52:47 -0400
IronPort-SDR: PxktPzZjqriqbrVgftT7fPmmBJXC15MgGt9CT6dzgWT+lKa/P2BrCv3MMoqDOYyqD0gY55ZcO2
 HhzTiDtNbqiw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="260769166"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="260769166"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 10:51:40 -0700
IronPort-SDR: EUHjuP8Qoeb8DrTp7qivB2I8eD2xmTSNjOtq/k2GKDxLK+FJ+fpLGtJYDgGvTtW4P7o1loXg7e
 KPSASuQeZjog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="436775556"
Received: from srpawnik-nuc8i7beh.iind.intel.com ([10.223.107.144])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2021 10:51:38 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        sumeet.r.pawnikar@intel.com
Subject: [PATCH] ACPI: PM: Add APCI ID of Alder Lake Fan
Date:   Tue, 11 May 2021 23:12:26 +0530
Message-Id: <20210511174226.28185-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a new unique fan ACPI device ID for Alder Lake to
support it in acpi_dev_pm_attach() function.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/device_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 16c0fe8a72a7..d260bc1f3e6e 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1313,6 +1313,7 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 		{"PNP0C0B", }, /* Generic ACPI fan */
 		{"INT3404", }, /* Fan */
 		{"INTC1044", }, /* Fan for Tiger Lake generation */
+		{"INTC1048", }, /* Fan for Alder Lake generation */
 		{}
 	};
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-- 
2.17.1

