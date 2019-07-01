Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EEE5BD33
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2019 15:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfGANnO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jul 2019 09:43:14 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:53010 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfGANnN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2019 09:43:13 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 48E854D130;
        Mon,  1 Jul 2019 15:43:09 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, nv@vosn.de
Subject: [PATCH v2 2/2] ASoC: tas5720.c: add ACPI enumeration support
Date:   Mon,  1 Jul 2019 15:42:52 +0200
Message-Id: <24afd89b00bfba84d31083e6455baf1f3ad3f362.1561988282.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1561988282.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1561988282.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1561988282.git.nikolaus.voss@loewensteinmedical.de>
References: <20190628143037.GH5379@sirena.org.uk> <cover.1561988282.git.nikolaus.voss@loewensteinmedical.de>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add ACPI IDs for tas5720 and tas5722 and use device match API
to determine the variant.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 sound/soc/codecs/tas5720.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index b2e897f094b4..e3f85926cac4 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -7,6 +7,7 @@
  * Author: Andreas Dannenberg <dannenberg@ti.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/device.h>
@@ -631,7 +632,9 @@ static int tas5720_probe(struct i2c_client *client,
 
 	data->tas5720_client = client;
 
-	data->variant = (const struct tas5720_variant *)id->driver_data;
+	data->variant = device_get_match_data(&client->dev);
+	if (!data->variant)
+		data->variant = (const struct tas5720_variant *)id->driver_data;
 
 	data->regmap = devm_regmap_init_i2c(client, data->variant->reg_config);
 	if (IS_ERR(data->regmap)) {
@@ -687,10 +690,20 @@ static const struct of_device_id tas5720_of_match[] = {
 MODULE_DEVICE_TABLE(of, tas5720_of_match);
 #endif
 
+#if IS_ENABLED(CONFIG_ACPI)
+static const struct acpi_device_id tas5720_acpi_match[] = {
+	{ "10TI5720", (kernel_ulong_t)&tas5720 },
+	{ "10TI5722", (kernel_ulong_t)&tas5722 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, tas5720_acpi_match);
+#endif
+
 static struct i2c_driver tas5720_i2c_driver = {
 	.driver = {
 		.name = "tas5720",
 		.of_match_table = of_match_ptr(tas5720_of_match),
+		.acpi_match_table = ACPI_PTR(tas5720_acpi_match),
 	},
 	.probe = tas5720_probe,
 	.id_table = tas5720_id,
-- 
2.17.1

