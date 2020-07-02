Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E2E21230D
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jul 2020 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgGBMRr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Jul 2020 08:17:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44656 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgGBMRm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2020 08:17:42 -0400
Received: from 89-64-84-242.dynamic.chello.pl (89.64.84.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id c59e2b59b8593f71; Thu, 2 Jul 2020 14:17:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams.korg@gmail.com>
Subject: [PATCH 1/3] ACPI: OSL: Use deferred unmapping in acpi_os_unmap_generic_address()
Date:   Thu, 02 Jul 2020 14:11:12 +0200
Message-ID: <2627540.Zly3GVl0Zp@kreacher>
In-Reply-To: <22474080.3crLlKV2y5@kreacher>
References: <22474080.3crLlKV2y5@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

There is no reason (knwon to me) why any of the existing users of
acpi_os_unmap_generic_address() would need to wait for the unused
memory mappings left by it to actually go away, so use the deferred
unmapping of ACPI memory introduced previously in that function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index abbf8630f774..5c56f084e8b0 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -518,12 +518,9 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 		mutex_unlock(&acpi_ioremap_lock);
 		return;
 	}
-	if (acpi_os_drop_map_ref(map, false))
-		map = NULL;
+	acpi_os_drop_map_ref(map, true);
 
 	mutex_unlock(&acpi_ioremap_lock);
-
-	acpi_os_map_cleanup(map);
 }
 EXPORT_SYMBOL(acpi_os_unmap_generic_address);
 
-- 
2.26.2




