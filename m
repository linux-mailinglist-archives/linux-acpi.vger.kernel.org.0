Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9AA4A3929
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jan 2022 21:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356228AbiA3Uq4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 30 Jan 2022 15:46:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356223AbiA3Uqz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 30 Jan 2022 15:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643575614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0KY+INVdVwsnOFWOvZroFlL4EVFzOquUSMZhHLXyX0=;
        b=MyqFKR5hwPosUUgDutnVA2bqRSTh22gEpKpmU40YwWvNkC5z6qk2tKzkZW0xf+Tr+3mIeu
        o7awvmerWbfyutMcRa/RjXsKc9LTZheKArdD4UM7qeSKFb37xwTY2/rng5TsQqx/+rcPjr
        Etwu1tf25DcU/zcU5BvTpX+83NOJwIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-uf3WxaqpPxy4gmpGqrO2VQ-1; Sun, 30 Jan 2022 15:46:51 -0500
X-MC-Unique: uf3WxaqpPxy4gmpGqrO2VQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C21A1083F62;
        Sun, 30 Jan 2022 20:46:49 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5F2D61093;
        Sun, 30 Jan 2022 20:46:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v4 06/20] power: supply: bq25890: Add support to read back the settings from the chip
Date:   Sun, 30 Jan 2022 21:45:43 +0100
Message-Id: <20220130204557.15662-7-hdegoede@redhat.com>
In-Reply-To: <20220130204557.15662-1-hdegoede@redhat.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On most x86/ACPI devices there is no devicetree to supply the necessary
init-data. Instead the firmware already fully initializes the bq25890
charger at boot. To support this, add support for reading back the
settings from the chip through a new "linux,read-back-settings" boolean.

So far this new property is only used on x86/ACPI (non devicetree) devs,
IOW it is not used in actual devicetree files. The devicetree-bindings
maintainers have requested properties like these to not be added to the
devicetree-bindings, so the new property is deliberately not added
to the existing devicetree-bindings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- New patch in v2 of this series, together with the "linux,skip-reset" patch
  this patch replaces the "ti,skip-init" patch from v1
---
 drivers/power/supply/bq25890_charger.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index cd80d748df92..f758e28046e5 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -111,6 +111,7 @@ struct bq25890_device {
 	struct regmap_field *rmap_fields[F_MAX_FIELDS];
 
 	bool skip_reset;
+	bool read_back_init_data;
 	enum bq25890_chip_version chip_version;
 	struct bq25890_init_data init_data;
 	struct bq25890_state state;
@@ -696,7 +697,7 @@ static int bq25890_chip_reset(struct bq25890_device *bq)
 
 static int bq25890_rw_init_data(struct bq25890_device *bq)
 {
-	bool write = true;
+	bool write = !bq->read_back_init_data;
 	int ret;
 	int i;
 
@@ -981,6 +982,10 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 	struct bq25890_init_data *init = &bq->init_data;
 
 	bq->skip_reset = device_property_read_bool(bq->dev, "linux,skip-reset");
+	bq->read_back_init_data = device_property_read_bool(bq->dev,
+						"linux,read-back-settings");
+	if (bq->read_back_init_data)
+		return 0;
 
 	ret = bq25890_fw_read_u32_props(bq);
 	if (ret < 0)
-- 
2.33.1

