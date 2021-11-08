Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4C44992C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 17:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhKHQOx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 11:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231976AbhKHQOx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Nov 2021 11:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636387928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdztAeC5+Y6+RydYkWsoC/3dnH5yvJgyarTBidkx8ps=;
        b=hQWTpkRkKWm96I/97V/P2yctDrxRGrl7qpVmCxvvokEuiRY2kPJwO1UJ17tsa0qUAeAXZ3
        oC8fvNXeFtwk9rC5OTuhFaDD2wpkgn5eym8QN1xeE/rsLC+2Y8H60LizuhCZqdVAeYvdwR
        IQJcJW+7JCsTY3+3PH6usvuRjzQQOrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-YkCvHW4pOiqXH0akaedPsQ-1; Mon, 08 Nov 2021 11:11:37 -0500
X-MC-Unique: YkCvHW4pOiqXH0akaedPsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 009E2802E73;
        Mon,  8 Nov 2021 16:11:36 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B7F55C3E0;
        Mon,  8 Nov 2021 16:11:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/1] ACPI / x86: Add PWM2 on the Xiaomi Mi Pad 2 to the always_present list
Date:   Mon,  8 Nov 2021 17:11:31 +0100
Message-Id: <20211108161131.896783-2-hdegoede@redhat.com>
In-Reply-To: <20211108161131.896783-1-hdegoede@redhat.com>
References: <20211108161131.896783-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Xiaomi Mi Pad 2 has backlit LEDs behind the capacitive menu, home
and back buttons below the screen which are controlled by the PWM2
controller of the CHT SoC. This PWM2 controller gets hidden by the
firmware, add it to the always_present_ids table so that we can use
the PWM controller to control the backlighting of the buttons.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index f22f23933063..cb988f9b23a1 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -58,6 +58,11 @@ static const struct always_present_id always_present_ids[] = {
 	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
 		}),
+	/* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
+	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
+		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
+	      }),
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
-- 
2.31.1

