Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04C2379362
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 18:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhEJQKY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 12:10:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:32425 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhEJQKO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 12:10:14 -0400
IronPort-SDR: 8KTw4ojtUbfHysmRd6tXmp32aB4ZotoXvlMNqymdq6yfk58XX5Sl3WjW19hWDdhorsFQGInljv
 1Gwl9SP5PK+Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="220176279"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="220176279"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 09:07:29 -0700
IronPort-SDR: 9/fyJTdb9+2VzB4z/Xe3vw+P+iVr/wA24JC3NDEyD1W4CBT9rNjYd26f9NyCfCfSklu1d2B8XU
 ppAmSt2rftgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="433873530"
Received: from srpawnik-nuc8i7beh.iind.intel.com ([10.223.107.144])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2021 09:07:27 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        sumeet.r.pawnikar@intel.com
Subject: [PATCH] ACPI: DPTF: Add battery participant for Intel SoCs
Date:   Mon, 10 May 2021 21:28:19 +0530
Message-Id: <20210510155819.29595-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add ACPI Device ID for DPTF battery participant for the Intel
Jasper Lake (INT3532) and Tiger Lake (INTC1050) SoC based platforms.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/dptf/int340x_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index d14025a85ce8..da5d5f0be2f2 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -24,6 +24,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT3409"},
 	{"INT340A"},
 	{"INT340B"},
+	{"INT3532"},
 	{"INTC1040"},
 	{"INTC1041"},
 	{"INTC1043"},
@@ -33,6 +34,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INTC1047"},
 	{"INTC1048"},
 	{"INTC1049"},
+	{"INTC1050"},
 	{"INTC1060"},
 	{"INTC1061"},
 	{""},
-- 
2.17.1

