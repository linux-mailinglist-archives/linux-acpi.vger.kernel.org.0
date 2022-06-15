Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2554D227
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347805AbiFOT5A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 15:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352209AbiFOT47 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 15:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8D8431353
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655323017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evqLu0nPxDj0y/d6MJFVRDPNvEdjCenckvtl/TbFspY=;
        b=NBkvGFX8iRHQdEnF9Pw7GcI6mVkQFKw7mAN1nCmiderhsKqFLY5E51lDVyRMzv6jPpjv59
        gJbBBDEESK7MZNROo4Ai2qP5kfFbF/CtaLeGT0K6+84Jxz09/cMxuvr5y8Zw+rO+Q9wRhT
        Zp6/AstXHxDhn641Try12r7qmEKDt+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-mK2tEywCOYO0QOvX8aJNoA-1; Wed, 15 Jun 2022 15:56:54 -0400
X-MC-Unique: mK2tEywCOYO0QOvX8aJNoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30FA7185A7A4;
        Wed, 15 Jun 2022 19:56:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD6092026D07;
        Wed, 15 Jun 2022 19:56:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        =?UTF-8?q?Johannes=20Pen=C3=9Fel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [RFC 2/4] ACPICA: Add \_SB.PC00, \SB.PCI0 to acpi_ns_early_initialize_devices()
Date:   Wed, 15 Jun 2022 21:56:41 +0200
Message-Id: <20220615195643.12608-3-hdegoede@redhat.com>
In-Reply-To: <20220615195643.12608-1-hdegoede@redhat.com>
References: <20220615195643.12608-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since ACPICA commit f005ee6b90d1 / Linux commit 2d3349de8072
("ACPICA: Namespace: Reorder \_SB._INI to make sure it is evaluated
before _REG evaluations") acpi_initialize_objects() calls \_SB._INI
before executing _REG OpRegion methods, because the _REG methods may
rely on initialization done by this _INI method.

In many DSDTs the \_SB.PC00._INI / \_SB.PCI0._INI methods set an OSYS
global variable based on _OSI evaluations.

In some cases there are _REG methods which depend on the OSYS value and
before this change ACPICA would run these _REG methods before running
_SB.PC00._INI / \_SB.PCI0._INI causing issues.

2 examples of problems caused by running _REG methods before these
_INI methods are:

1. on a "Lenovo IdeaPad 5 15ITL05" \_SB.PC00.LPCB.EC0._REG gets
evaluated before \_SB.PC00._INI and that _REG contains:

    If ((OSYS == 0x07DF))
    {
        Local0 = 0x06
    }

    If ((Acquire (LFCM, 0xA000) == Zero))
    {
        OSTY = Local0
        ...

With OSTY being a SystemMemory OpRegion field, due to the _INI running
too late, Local0 stays at 0. Causing OSTY to be set to 0 instead of 6,
which causes the brightness up/down keys to not work:
https://bugzilla.kernel.org/show_bug.cgi?id=214899

2. On a "Lenovo Thinkbook 14-ILL" \\_SB_.PCI0.I2C0._REG gets
evaluated before \_SB.PCI0._INI and that _REG contains:

    If ((OSYS == 0x07DF))
    {
	...
        LNUX = Zero
        TPID = 0x4E
    }
    else
    {
        LNUX = One
        TPID = 0xBB
    }

And then later on the TPID value gets used to decide for which of multiple
devices describing the touchpad _STA should return 0xF and the one which
gets enabled by TPID=0xBB is broken, causing to the touchpad to not work:
https://bugzilla.redhat.com/show_bug.cgi?id=1842039

Fix these issues by adding \_SB.PC00._INI / \_SB.PCI0._INI to the list of
_INI methods to run early (before executing _REG methods).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/nsinit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index f5364d44fdb8..db66df28e4fc 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -105,6 +105,10 @@ static acpi_string const acpi_ns_early_init_paths[] = {
 	/* There appears to be a strict order requirement for \_SB._INI,
 	 * which should be evaluated before any _REG evaluations. */
 	"\\_SB",
+	/* \_SB.PC00._INI or \_SB.PCI0.INI may use \_OSI to set an OSYS global
+	 * variable used in _REG methods. */
+	"\\_SB.PC00",
+	"\\_SB.PCI0",
 };
 
 acpi_status acpi_ns_early_initialize_devices(void)
@@ -519,7 +523,7 @@ acpi_ns_find_ini_methods(acpi_handle obj_handle,
 
 static u8 acpi_ns_is_early_init_device(struct acpi_namespace_node *device_node)
 {
-	char path[ACPI_PATH_SEGMENT_LENGTH + 2];
+	char path[ACPI_PATH_SEGMENT_LENGTH * 2 + 2];
 	int i;
 
 	acpi_ns_build_normalized_path(device_node, path, sizeof(path), TRUE);
-- 
2.36.0

