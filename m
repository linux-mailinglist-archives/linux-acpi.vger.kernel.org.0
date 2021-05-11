Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F66437AE19
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEKSMC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 14:12:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:59479 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbhEKSMC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 14:12:02 -0400
IronPort-SDR: yFppTRn87+PcyhgJNVRQXXPhKN4uWKkD3ip4I/3KFpjSPoz3apVs4orynJ1MGx1nk7QwKTkD+1
 zaJRHbjp5v6A==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179105361"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="179105361"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:10:55 -0700
IronPort-SDR: GHHpRvwMWpa5pxG9CRcbylH+5b9jQk5TXWNmaeLq8w6Me5hjhH4PZEgiHHE+FmgTVu6TwmAYXU
 rK0h3TFXWGCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="434712503"
Received: from srpawnik-nuc8i7beh.iind.intel.com ([10.223.107.144])
  by fmsmga008.fm.intel.com with ESMTP; 11 May 2021 11:10:53 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        sumeet.r.pawnikar@intel.com
Subject: [PATCH v2] ACPI: PM: Add ACPI ID of Alder Lake Fan
Date:   Tue, 11 May 2021 23:31:42 +0530
Message-Id: <20210511180142.28472-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a new unique fan ACPI device ID for Alder Lake to
support it in acpi_dev_pm_attach() function.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
v1-->v2 : Fixed commit header typo APCI with ACPI.

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

