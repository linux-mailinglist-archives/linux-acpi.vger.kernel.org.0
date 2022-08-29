Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED695A51EC
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiH2QgF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Aug 2022 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH2QgD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 12:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA62C12A
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661790960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=633hcKwB65o3TRyR8CoUo0+iIVy6Wow8+41OLG/NlBo=;
        b=VPetW3luEcBYRcEPApHiExuAlZTsz/qHeXA48LvsdvWf9iHtmmAK2oBo7eaEf5dAA/YmHP
        MeUj0Fsqe8oYcAijGcANnLwaUTLhxm54BSIzGT+eLRWMj6rNTNipYUV12ntqIOPex1Mzmp
        KyKrUY/q/glj+XNcDCREl8Y4CoOZ1qw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-94c9aUbdOrOBl0Qg9x890A-1; Mon, 29 Aug 2022 12:35:54 -0400
X-MC-Unique: 94c9aUbdOrOBl0Qg9x890A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 591C2803520;
        Mon, 29 Aug 2022 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 879EE1410F36;
        Mon, 29 Aug 2022 16:35:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Lee Chun-Yi <jlee@suse.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] platform/x86: acer-wmi: Acer Aspire One AOD270/Packard Bell Dot keymap fixes
Date:   Mon, 29 Aug 2022 18:35:44 +0200
Message-Id: <20220829163544.5288-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

2 keymap fixes for the Acer Aspire One AOD270 and the same hardware
rebranded as Packard Bell Dot SC:

1. The F2 key is marked with a big '?' symbol on the Packard Bell Dot SC,
this sends WMID_HOTKEY_EVENTs with a scancode of 0x27 add a mapping
for this.

2. Scancode 0x61 is KEY_SWITCHVIDEOMODE. Usually this is a duplicate
input event with the "Video Bus" input device events. But on these devices
the "Video Bus" does not send events for this key. Map 0x61 to KEY_UNKNOWN
instead of using KE_IGNORE so that udev/hwdb can override it on these devs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/acer-wmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index b933a5165edb..9610742fe6aa 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -99,6 +99,7 @@ static const struct key_entry acer_wmi_keymap[] __initconst = {
 	{KE_KEY, 0x22, {KEY_PROG2} },    /* Arcade */
 	{KE_KEY, 0x23, {KEY_PROG3} },    /* P_Key */
 	{KE_KEY, 0x24, {KEY_PROG4} },    /* Social networking_Key */
+	{KE_KEY, 0x27, {KEY_HELP} },
 	{KE_KEY, 0x29, {KEY_PROG3} },    /* P_Key for TM8372 */
 	{KE_IGNORE, 0x41, {KEY_MUTE} },
 	{KE_IGNORE, 0x42, {KEY_PREVIOUSSONG} },
@@ -112,7 +113,13 @@ static const struct key_entry acer_wmi_keymap[] __initconst = {
 	{KE_IGNORE, 0x48, {KEY_VOLUMEUP} },
 	{KE_IGNORE, 0x49, {KEY_VOLUMEDOWN} },
 	{KE_IGNORE, 0x4a, {KEY_VOLUMEDOWN} },
-	{KE_IGNORE, 0x61, {KEY_SWITCHVIDEOMODE} },
+	/*
+	 * 0x61 is KEY_SWITCHVIDEOMODE. Usually this is a duplicate input event
+	 * with the "Video Bus" input device events. But sometimes it is not
+	 * a dup. Map it to KEY_UNKNOWN instead of using KE_IGNORE so that
+	 * udev/hwdb can override it on systems where it is not a dup.
+	 */
+	{KE_KEY, 0x61, {KEY_UNKNOWN} },
 	{KE_IGNORE, 0x62, {KEY_BRIGHTNESSUP} },
 	{KE_IGNORE, 0x63, {KEY_BRIGHTNESSDOWN} },
 	{KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} },	/* Display Switch */
-- 
2.37.2

