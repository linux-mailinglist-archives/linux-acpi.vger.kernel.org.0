Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1411467AFD4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 11:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjAYKkI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 05:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjAYKkH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 05:40:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E91042A
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 02:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674643163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vmfRH30ciZxy2uxjKYT/zXoIw0CUhTXt10e0YrMu5k=;
        b=PQzEAxxbOC8L5sSwgJEZyFIRztqnJVF3F4kmytVNIm9kIN6oo0idLGjqcuucyw28lKQnR4
        ZAo6mYb9TQ7Nil1fUSvy97SMqJPf7mAkLSQTsmop3UVuYwccO/YoCqbkD8t7fyrIfYbV9L
        8vTteNFKkDtEdMUnwk4aIHdTPK8ujIY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-sAc5AI51OvW6cI-ceAK00w-1; Wed, 25 Jan 2023 05:39:20 -0500
X-MC-Unique: sAc5AI51OvW6cI-ceAK00w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B44280482A;
        Wed, 25 Jan 2023 10:39:19 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7DBE492C18;
        Wed, 25 Jan 2023 10:39:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mario Limonciello <Mario.Limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [RFC 1/1] pinctrl: amd: Fix handling of PIN_CONFIG_BIAS_PULL_UP/_DOWN settings
Date:   Wed, 25 Jan 2023 11:39:16 +0100
Message-Id: <20230125103916.16772-2-hdegoede@redhat.com>
In-Reply-To: <20230125103916.16772-1-hdegoede@redhat.com>
References: <20230125103916.16772-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PIN_CONFIG_BIAS_PULL_UP is documented as follows:

@PIN_CONFIG_BIAS_PULL_UP: the pin will be pulled up (usually with high
impedance to VDD). If the argument is != 0 pull-up is enabled,
if it is 0, pull-up is total, i.e. the pin is connected to VDD.

This patch fixes 2 issues with how the AMD pinctrl code was handling this:

1. amd_pinconf_set() was setting the PULL_UP_ENABLE bit as follows:
    pin_reg &= ~BIT(PULL_UP_ENABLE_OFF);
    pin_reg |= ((arg>>1) & BIT(0)) << PULL_UP_ENABLE_OFF;
   When called from gpio_set_bias() for ACPI enumerated GPIOs arg == 1,
   so the pull-up enable bit would be cleared instead of being set.
   It seems unnecessary to say that this is BAD.

   There is no real convention for the meaning of arg other then that
   a value != 0 means the pull-up should be enabled (which was being
   violated here). Looking at other drivers the Intel pinctrl drivers
   all treat 1 (as used by gpio_set_bias()) as indictating that the
   driver should pick the pull-up strength; and all other values are
   interpreted as the amount of ohm with which to pull-up, with non
   supported values being rejected with -EINVAL.

   This patch changes the AMD pinctrl code to match this behavior so
   that the behavior of all x86 pinctrl drivers is consistent.

2. arg == 0 does not mean that the pull-up/-down is disabled as the
   old code was assuming. Rather it means that the "pull-up is total,
   i.e. the pin is connected to VDD". The correct way for
   amd_pinconf_get() to indicate that the pull-up/-down is not enabled
   is to return -EINVAL. I've checked a whole bunch of pinctrl drivers
   and they all behave this way. This patch brings the AMD pinctrl driver
   in line with this.

Fixes: dbad75dd1f25 ("pinctrl: add AMD GPIO driver support.")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=212379
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/pinctrl-amd.c | 37 +++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9bc6e3922e78..88174195b5c8 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -744,11 +744,19 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		arg = (pin_reg >> PULL_DOWN_ENABLE_OFF) & BIT(0);
+		if (!(pin_reg & BIT(PULL_DOWN_ENABLE_OFF)))
+			return -EINVAL;
+		arg = 1;
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg = (pin_reg >> PULL_UP_SEL_OFF) & (BIT(0) | BIT(1));
+		if (!(pin_reg & BIT(PULL_UP_ENABLE_OFF)))
+			return -EINVAL;
+
+		if (pin_reg & BIT(PULL_UP_SEL_OFF))
+			arg = 8000;
+		else
+			arg = 4000;
 		break;
 
 	case PIN_CONFIG_DRIVE_STRENGTH:
@@ -790,15 +798,28 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			pin_reg &= ~BIT(PULL_DOWN_ENABLE_OFF);
-			pin_reg |= (arg & BIT(0)) << PULL_DOWN_ENABLE_OFF;
+			pin_reg |= BIT(PULL_DOWN_ENABLE_OFF);
 			break;
 
 		case PIN_CONFIG_BIAS_PULL_UP:
-			pin_reg &= ~BIT(PULL_UP_SEL_OFF);
-			pin_reg |= (arg & BIT(0)) << PULL_UP_SEL_OFF;
-			pin_reg &= ~BIT(PULL_UP_ENABLE_OFF);
-			pin_reg |= ((arg>>1) & BIT(0)) << PULL_UP_ENABLE_OFF;
+			/* Set default ohm value in case none is given */
+			if (arg == 1)
+				arg = 4000;
+
+			switch (arg) {
+			case 4000:
+				pin_reg &= ~BIT(PULL_UP_SEL_OFF);
+				pin_reg |= BIT(PULL_UP_ENABLE_OFF);
+				break;
+			case 8000:
+				pin_reg |= BIT(PULL_UP_SEL_OFF);
+				pin_reg |= BIT(PULL_UP_ENABLE_OFF);
+				break;
+			default:
+				dev_err(&gpio_dev->pdev->dev,
+					"Invalid pull-up arg %u\n", arg);
+				ret = -EINVAL;
+			}
 			break;
 
 		case PIN_CONFIG_DRIVE_STRENGTH:
-- 
2.39.0

