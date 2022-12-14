Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A5A64D1C3
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Dec 2022 22:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiLNV0q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Dec 2022 16:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiLNVZq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Dec 2022 16:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C7936C7A
        for <linux-acpi@vger.kernel.org>; Wed, 14 Dec 2022 13:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671053100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=es5pjxDHLwLyb87qSja+0ZN7d8ZGmpWxkLo2O4sK3ME=;
        b=Zm0L7/qa5sABXUATV0Mt7VezlVyoDvzKDtsrAEWwD/hmr0GwRh34kjMn7ZtDYuGyqCLryl
        fyv5iWw+bFBny1Ph/qlXNaDCzLEV4myZWibr7kVuW7sovfsn4QYYrw/aLAha5+m+fTFtIi
        9vRM4Dp2kD7EZQTbW+AwAgt/pMEyeME=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-D2nlkwB8M_aF0AVnypRf9Q-1; Wed, 14 Dec 2022 16:24:55 -0500
X-MC-Unique: D2nlkwB8M_aF0AVnypRf9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9731929ABA1B;
        Wed, 14 Dec 2022 21:24:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 150742026D68;
        Wed, 14 Dec 2022 21:24:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] x86/rtc: Simplify PNP ids check
Date:   Wed, 14 Dec 2022 22:24:47 +0100
Message-Id: <20221214212447.4058-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

compare_pnp_id() already iterates over the single linked pnp_ids list
starting with the id past to it.

So there is no need for add_rtc_cmos() to call compare_pnp_id()
for each id on the list.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/kernel/rtc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 349046434513..1309b9b05338 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -138,15 +138,12 @@ static __init int add_rtc_cmos(void)
 	static const char * const ids[] __initconst =
 	    { "PNP0b00", "PNP0b01", "PNP0b02", };
 	struct pnp_dev *dev;
-	struct pnp_id *id;
 	int i;
 
 	pnp_for_each_dev(dev) {
-		for (id = dev->id; id; id = id->next) {
-			for (i = 0; i < ARRAY_SIZE(ids); i++) {
-				if (compare_pnp_id(id, ids[i]) != 0)
-					return 0;
-			}
+		for (i = 0; i < ARRAY_SIZE(ids); i++) {
+			if (compare_pnp_id(dev->id, ids[i]) != 0)
+				return 0;
 		}
 	}
 #endif
-- 
2.38.1

