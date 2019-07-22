Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967A86F733
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 04:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfGVCgG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 Jul 2019 22:36:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38597 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfGVCgG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Jul 2019 22:36:06 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so38333870ioa.5;
        Sun, 21 Jul 2019 19:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MI5pP/95cljpGBtp/V+zUfk7+WS9iXpcoTov/fza3VQ=;
        b=WqsZZUdgKSWyoWKGonBa2yNXkffaLLoPf8vielAdO/brV5Dxzos32yFbS22tNXe3EQ
         o4qZLTLhYVkI/P/um8VToODECzHjfCQvVy63E/mlYqhXgLsO3AQw+NIP5xBETlFEsAE7
         eskK4ne3pyMZdKCk3sEw2XRCi04JprsbCeNbaG8REVCqzfmpX4DuY5TjDkocVGX+QWZl
         BqbSABPJ12QsZteMch3GW1XctVWANQwUqEsG+ZWoH+0IhGFgOfBcpqv0CbPDYuWxWchw
         gtrxeVHE5WSc9aoZ/wZZrvNT3SIVaqSpOiGHw+ZlafdsFSA+Yhu9fuwvYArRvCKCa1WH
         zgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MI5pP/95cljpGBtp/V+zUfk7+WS9iXpcoTov/fza3VQ=;
        b=cb3FE2GApnlK1h5t8Bq+wEsUmrkeDVfuVU7GS6WXEjqZnXMPZNd02J+RgGM6IFiKcB
         9q6ec1VLU0Ljh02gP2UqQQMMK/cf0AGM9LvPiSEinNdkMA/RAhA/QW0PRFeiAnomzCEP
         MgGvSAqMK0I+5/qA/JsseYL8GiRk9LGDn9lWC10HKx1DgoydBA/+aBH7KYKTy/kHH0KI
         RUNU7QFVh6N6iyryxV7637vUVD83b2cvc5ofAKyTITXUJPwoCvSUPOAmfpkJ1mY6eu6G
         AqThFT+ybVnhj9CaYIXd+9R5K8Vive9py+q9hjIJl5CZtiAmW2CowXABd2Qr2edjOFw9
         ew8g==
X-Gm-Message-State: APjAAAUV23p8FrPPH3ynsMQwhjfdyHRGqIJ8jA8c+Rk7HbOTKhdpxpEr
        SfonKw/Nr/45TU4UfczkkpQ=
X-Google-Smtp-Source: APXvYqyTOouutc91U2WNFG9MMczhWty7SVKMwuK87LZPlNkjDtGbeieUTQjIitnhIdCehXWun/S6rg==
X-Received: by 2002:a6b:7401:: with SMTP id s1mr59037561iog.67.1563762965239;
        Sun, 21 Jul 2019 19:36:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id e188sm32816577ioa.3.2019.07.21.19.36.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 19:36:04 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com,
        skunberg.kelsey@gmail.com
Subject: [PATCH 3/3] ACPI: Remove acpi_has_method() calls from thermal.c
Date:   Sun, 21 Jul 2019 20:35:30 -0600
Message-Id: <20190722023530.67676-4-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
References: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The following acpi_has_method() calls are unnecessary since
acpi_execute_simple_method() and acpi_evaluate_reference() will return an
error if the given method does not exist. Remove acpi_has_method() calls
to avoid additional work.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/acpi/thermal.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 00f12a86ecbd..d831a61e0010 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -225,13 +225,9 @@ static int acpi_thermal_set_cooling_mode(struct acpi_thermal *tz, int mode)
 	if (!tz)
 		return -EINVAL;
 
-	if (!acpi_has_method(tz->device->handle, "_SCP")) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_SCP not present\n"));
+	if (ACPI_FAILURE(acpi_execute_simple_method(tz->device->handle,
+						    "_SCP", mode)))
 		return -ENODEV;
-	} else if (ACPI_FAILURE(acpi_execute_simple_method(tz->device->handle,
-							   "_SCP", mode))) {
-		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -463,8 +459,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			break;
 	}
 
-	if ((flag & ACPI_TRIPS_DEVICES)
-	    && acpi_has_method(tz->device->handle, "_TZD")) {
+	if (flag & ACPI_TRIPS_DEVICES) {
 		memset(&devices, 0, sizeof(devices));
 		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
 						NULL, &devices);
-- 
2.20.1

