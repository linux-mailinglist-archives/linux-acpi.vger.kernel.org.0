Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1467B1B206B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Apr 2020 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgDUHz3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Apr 2020 03:55:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45300 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUHz3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2020 03:55:29 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jQnkc-0002yx-1p; Tue, 21 Apr 2020 07:55:26 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rjw@rjwysocki.net
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI: PM: Output correct message on target power state
Date:   Tue, 21 Apr 2020 15:55:16 +0800
Message-Id: <20200421075516.23019-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Transitioned power state logged at the end of setting ACPI power.

However, D3cold won't be in the message because state can only be D3hot
at most.

Use target_state to corretly report when power state is D3cold.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/device_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index b2263ec67b43..5832bc10aca8 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -273,13 +273,13 @@ int acpi_device_set_power(struct acpi_device *device, int state)
  end:
 	if (result) {
 		dev_warn(&device->dev, "Failed to change power state to %s\n",
-			 acpi_power_state_string(state));
+			 acpi_power_state_string(target_state));
 	} else {
 		device->power.state = target_state;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Device [%s] transitioned to %s\n",
 				  device->pnp.bus_id,
-				  acpi_power_state_string(state)));
+				  acpi_power_state_string(target_state)));
 	}
 
 	return result;
-- 
2.17.1

