Return-Path: <linux-acpi+bounces-4478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468588D790
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 08:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50DD2967ED
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384B2D604;
	Wed, 27 Mar 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXsZrCFI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CC2D04F
	for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525490; cv=none; b=oFlvPnNPYnXkTfP1wLG77glLrb/uWNmBDrlGmafaq/UUJI9ph1WRwgn1ow12Ws91cQ4ERGppNUubLYSDrv4bqQdHjbACi9d1qTh9LNc2MsGYuWYd1L2Try1bTrM0dfcGnqL5ckDfVI5fFWbe+ycgM6mabOY7XwZw3zlZIMdgjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525490; c=relaxed/simple;
	bh=AfH7TD93nFAaXOkK7vrlKu3Cot997gVLIL4pGflb6fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OH+M8vKfSPmDjuLBrR313b1Odn+cnqKxoQjS6QLiFY0Z16ar4qSGb+vB2mmu77ugHOJZMfK2lVUkVCcH58YblvqOT1dxBZYBaHGGd5rsnOTNN21YhRAUi1i126tJ95YAS4Yl25AIco3egDqZXNh7V3igAwrhJk5qJSN3DN3aYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sXsZrCFI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4702457ccbso812178966b.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525487; x=1712130287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0h8HJEMkZo/orl3TA6XTaCo4nQqMYHN9Ch6FJtW6jM=;
        b=sXsZrCFIkt8HWpOTUNNsgYGboWq1Vc6ChyUCpfpLBs2JxguKDV2juPX4/wBgSo15bB
         MI4ED2WKBwelYMoyQY2DA0TLb4htxvRdADiNbnVJr3107kcl7JxcBscP4776eGJyUpx9
         vUOMfOOe40tNeEgskd6bLCIghrEh+w3HCw4bKlGgFFSuWVyhWXdRrNeDPOgaR8voIHOu
         e94ijwv7Ts/evhy7d5KBQ/IwYVd2orP4xZWbmMZiRt7nTskiYlnluP8QjmcrqFpDlXWG
         CO4GVg35LSKW5da7ymfhqUvttI78t3TZzVS+w/WsaYpkKANsQPjuKa+s2et4XaEj6s2h
         1fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525487; x=1712130287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0h8HJEMkZo/orl3TA6XTaCo4nQqMYHN9Ch6FJtW6jM=;
        b=bbxqusFEckUdQ2D/tLRQ3TnYTLzvwDAh5GjnC68WyGrMlfVclWnfZVIkPwrmwIHT88
         fs5K4/GKbK2glZNtGwyWbBWqk0UEumcNL6nEJOjgxvSLj0GR6YFGlNX2uwXQigSoA3so
         lthS10v8caEINYXetOOVjRM9u3q4m/ilAOmrB3DmRAM5r+rH9MLYKg+aqDR3lBHAVhtO
         NYJRdB+8zocUWS/kC4LJn5I19hfxoEW2pQWGQlA7QSq2VBPIEv+EUT3RLxHhhOaK7Ixr
         VZEuuRAv8pgjzwHUin/Uf3DY6jNqoKklgCaeN0usSdZILOUsCZoBCwFXkcsNb0l+QuVs
         HfyQ==
X-Gm-Message-State: AOJu0Yx+y/yCEflqhgztSNRGE317mIj1uEE6irrKdTlXbnK4is2LkhJ1
	67E2xX07Xa3akBfBhpI5kxptfPHRjBFLt4R80bdI1jmvDJCvWxyx/gVP5Fjbh8I=
X-Google-Smtp-Source: AGHT+IHRUaSEY2LgvM/wYcxNN2lH5xfqXQT6S4v31IsDX3dv8eFJ37Z52TqYNLsh6Z2pW/xKFizTdg==
X-Received: by 2002:a17:906:8417:b0:a46:f869:3216 with SMTP id n23-20020a170906841700b00a46f8693216mr242827ejx.64.1711525486845;
        Wed, 27 Mar 2024 00:44:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:44:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:48 +0100
Subject: [PATCH 01/19] ACPI: store owner from modules with
 acpi_bus_register_driver()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-1-725241a2d224@linaro.org>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
In-Reply-To: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 Daniel Oliveira Nascimento <don@syst.com.br>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>, 
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2780;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=AfH7TD93nFAaXOkK7vrlKu3Cot997gVLIL4pGflb6fs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85Ln15mHy/+MFVp10AE619hdOQmn023kKU+n
 VJlMoJVEYGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOSwAKCRDBN2bmhouD
 1+/rD/99BcfHmnHUga4+/O9mIaAJmXx7ZQ2COoQmAL9yQSJWbDdvffVupiZB9Kb9+hnXrSQ5xIY
 ggKqajxoO7hSls5UHkq+Y+lgewh/kJV8eq99aqzFOt1phiBqqIunhaWz+2hs1XPyCcqiMjnXWMW
 y8iCNTvsKsUNKylCbYP15D4lsLnZ31rX2yZsksWvyKsA5s7+a1leMBLEjwoItHxvgsNxE0MyODU
 ntSK/7yEz7rQdmr+yCrSRFXrKjBpoQYAAdUFvtzZADe+rFviymGQ6hCdZ7lZZ9rezsGeWe97IX+
 Hz5s7T/345dgLpgx5QYu8F1uI3Nx5/NBnejp3xgBx3mVnj3qhAgD8jsPlY1nBBR79ZBHqsISBHb
 figg/7S3tvP6YCCvmC9y4JcEUbZiG9pGkjovCVwC2wCwk5hVOGGQ9iMDCLQp39FzqZTtdQiV732
 0LE4/tZflMwZQ2dyTy8jbQeRg2J2Y44Blbx7qo0FAu7Jjz0Vual+lFq4YugV0Lw/QOLauWZALyK
 trUaRiFr6/Xqia9GutyvSvwSkDyiL9h/tho2vebH9YGd8PFaFgA9O6oGIhblIFI6k5Sic47Uq1G
 2WYq7iVEG1TKRyccLgjMqJ0Koilm+tamc/I/DYIRQaxA7mpvOoe7WPVQOSiO7CN+llioF+uhjif
 Sep+NfVSaThEJHw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Modules registering driver with acpi_bus_register_driver() often forget to
set .owner field.  The field is used by some of other kernel parts for
reference counting (try_module_get()), so it is expected that drivers
will set it.

Solve the problem by moving this task away from the drivers to the core
ACPI bus code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/acpi/bus.c      | 9 +++++----
 include/acpi/acpi_bus.h | 7 ++++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d9fa730416f1..eda951032f3c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -990,25 +990,26 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_device);
    -------------------------------------------------------------------------- */
 
 /**
- * acpi_bus_register_driver - register a driver with the ACPI bus
+ * __acpi_bus_register_driver - register a driver with the ACPI bus
  * @driver: driver being registered
+ * @owner: owning module/driver
  *
  * Registers a driver with the ACPI bus.  Searches the namespace for all
  * devices that match the driver's criteria and binds.  Returns zero for
  * success or a negative error status for failure.
  */
-int acpi_bus_register_driver(struct acpi_driver *driver)
+int __acpi_bus_register_driver(struct acpi_driver *driver, struct module *owner)
 {
 	if (acpi_disabled)
 		return -ENODEV;
 	driver->drv.name = driver->name;
 	driver->drv.bus = &acpi_bus_type;
-	driver->drv.owner = driver->owner;
+	driver->drv.owner = owner;
 
 	return driver_register(&driver->drv);
 }
 
-EXPORT_SYMBOL(acpi_bus_register_driver);
+EXPORT_SYMBOL(__acpi_bus_register_driver);
 
 /**
  * acpi_bus_unregister_driver - unregisters a driver with the ACPI bus
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5de954e2b18a..7453be56f855 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -656,7 +656,12 @@ void acpi_scan_lock_release(void);
 void acpi_lock_hp_context(void);
 void acpi_unlock_hp_context(void);
 int acpi_scan_add_handler(struct acpi_scan_handler *handler);
-int acpi_bus_register_driver(struct acpi_driver *driver);
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define acpi_bus_register_driver(drv) \
+	__acpi_bus_register_driver(drv, THIS_MODULE)
+int __acpi_bus_register_driver(struct acpi_driver *driver, struct module *owner);
 void acpi_bus_unregister_driver(struct acpi_driver *driver);
 int acpi_bus_scan(acpi_handle handle);
 void acpi_bus_trim(struct acpi_device *start);

-- 
2.34.1


