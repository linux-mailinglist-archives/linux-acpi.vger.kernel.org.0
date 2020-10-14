Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8528D7C3
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 03:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgJNBDu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 21:03:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42189 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNBDu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Oct 2020 21:03:50 -0400
Received: from 2.general.alexhung.us.vpn ([10.172.65.255] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1kSVCl-0005XB-Gz; Wed, 14 Oct 2020 01:03:48 +0000
From:   Alex Hung <alex.hung@canonical.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        alex.hung@canonical.com
Subject: [PATCH] ACPI: processor: remove unnecessary string  _UID comments
Date:   Tue, 13 Oct 2020 19:03:40 -0600
Message-Id: <20201014010340.433398-1-alex.hung@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.3 Errata A no longer allows _UID to be string except Itanium
for historical reasons as stated in section 5.2.12. Therefore, it is
redundant to comment "we don't handle string _UIDs yet" which implies a
feature is missing.

"From ACPI Specification 6.3 onward, all processor objects for all
architectures except Itanium must now use Device() objects with an _HID
of ACPI0007, and use only integer _UID values."

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/acpi_processor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index b51ddf3..710605f 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -264,7 +264,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	} else {
 		/*
 		 * Declared with "Device" statement; match _UID.
-		 * Note that we don't handle string _UIDs yet.
 		 */
 		status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
 						NULL, &value);
-- 
2.7.4

