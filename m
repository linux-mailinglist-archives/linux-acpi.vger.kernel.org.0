Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277F2159D46
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 00:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBKXiA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 18:38:00 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46557 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgBKXiA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Feb 2020 18:38:00 -0500
X-Originating-IP: 172.58.43.13
Received: from localhost (unknown [172.58.43.13])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 993A3240002;
        Tue, 11 Feb 2020 23:37:48 +0000 (UTC)
Date:   Tue, 11 Feb 2020 15:37:22 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ACPI: button: move HIDs to acpi/button.h
Message-ID: <35cb43e08ac1b69d4e2faabf8788083bdd399fd4.1581463668.git.josh@joshtriplett.org>
References: <cover.1581463668.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581463668.git.josh@joshtriplett.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This makes it possible to use ACPI_BUTTON_HID_POWER in another driver.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/button.c | 3 ---
 include/acpi/button.h | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index f6925f16c4a2..00112cf15322 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -30,17 +30,14 @@
 #define ACPI_BUTTON_NOTIFY_STATUS	0x80
 
 #define ACPI_BUTTON_SUBCLASS_POWER	"power"
-#define ACPI_BUTTON_HID_POWER		"PNP0C0C"
 #define ACPI_BUTTON_DEVICE_NAME_POWER	"Power Button"
 #define ACPI_BUTTON_TYPE_POWER		0x01
 
 #define ACPI_BUTTON_SUBCLASS_SLEEP	"sleep"
-#define ACPI_BUTTON_HID_SLEEP		"PNP0C0E"
 #define ACPI_BUTTON_DEVICE_NAME_SLEEP	"Sleep Button"
 #define ACPI_BUTTON_TYPE_SLEEP		0x03
 
 #define ACPI_BUTTON_SUBCLASS_LID	"lid"
-#define ACPI_BUTTON_HID_LID		"PNP0C0D"
 #define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
 #define ACPI_BUTTON_TYPE_LID		0x05
 
diff --git a/include/acpi/button.h b/include/acpi/button.h
index 340da7784cc8..af2fce5d2ee3 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -2,6 +2,10 @@
 #ifndef ACPI_BUTTON_H
 #define ACPI_BUTTON_H
 
+#define ACPI_BUTTON_HID_POWER	"PNP0C0C"
+#define ACPI_BUTTON_HID_LID	"PNP0C0D"
+#define ACPI_BUTTON_HID_SLEEP	"PNP0C0E"
+
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
 extern int acpi_lid_open(void);
 #else
-- 
2.25.0

