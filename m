Return-Path: <linux-acpi+bounces-17506-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D4FBB3C70
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 13:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7094D3A3B46
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E86311599;
	Thu,  2 Oct 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yl9o4QIS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856403081D0
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404857; cv=none; b=s8YanCqOzK+prazui5rVqO3++EulnpcpeYoO/7x9ramikCHsp8NoaG3P5aMmaNXG7qMIvwaShOVEcBJnKBuvauoSFrWM43OsA6xkFD+QSlkpjH8kM2badmczVkZu/pDyQR42OpvBzm6xagP1guPj67NI42xBeXvqKt/gJQSXQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404857; c=relaxed/simple;
	bh=4OP6QBdFKr1574GZhyc2cb1Lv+GX8ez8QVbJWQWOSGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d7J5T1RlVt2NY+6Gk517IoOlZfaNArdPCzM5lwZk+AZWzCcUzPQxAhF7OHxK3XOzo3wGrxdx0nLClxS/LJFe0oPyQpaE/Xd5OQLcml3RVAseHiecxOW7/D/JhgNRtNvDUHUwJWbxz21Wi4uh/xeJNLvu/yCwae1ceha1xG5BCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yl9o4QIS; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-634c01ca90fso1160140a12.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404854; x=1760009654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kgpUJcZIT53UUziBi2oBrvyEh4rGfYabLqvWzsqp90A=;
        b=yl9o4QISp/HuDiOBl78uizac9ONNsWBTwjSk7NgXErl4BxfQtpffv2wI5ED6LimNq3
         z0X0q86LNIKfevGBCGt7SFDuC16e3cZLAtE+5GaMd/v3zNMsyCW8u6NKaf+LdCbu5L+b
         4b44NeULuk2NrIXQ91iltZaVY6OOu43wvq2h51yFjetvU02ScTDEGf2e8etZFoXj3r6T
         Xolj7ywxVMmJ7wOS8lB5uXuZTGhSQr8OcXG2i8jz9niRHHC42ygPfBW51IAObukXKfRe
         Hnc/rPpjaGrwWNQlCnlgGSfq+wly/kJMmJgen3FPvQ6bzO9y0dl1AoQd+ZY3cSCKZfwm
         mfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404854; x=1760009654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgpUJcZIT53UUziBi2oBrvyEh4rGfYabLqvWzsqp90A=;
        b=hGiMFHfqAM/svFSNeNcwk4UYw5nFxhPIJ2LxDu/pbV6rzI2iwthe1VEbEwN06tXYyB
         vQY6gy0S4lF2UZCuHDmJ9wVW5Ouvrb34cLVXQpAlEvjRKn+sW5eLeAzuubhj3h8Nzv3g
         6+DUqQSGPRbVkQs7idbpWzylIVoJ8Xp6Smdclcsjk+4jNdctIaOMcb2OL4haqIIqjxcu
         b1AouaG1NR6tU/E2ciWfGPrVZbd1+IHhe9a2Uy0plakrZ6X4cjcmCF9lnBu1LaAPdfsY
         5AsT+21JKqYfu2QVrzeXMGaQ2Fzq3A6RiFVP8suaukWMQ7AjB+FHDG0Bi+JPe4IoNmRU
         d4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb+N4yRk3pSA9d72qHfamtrfWq/06JSGa3Vy8GgFg090o717/Hd7Pn92F7Jl/vz1TVdb8oQ2edglBa@vger.kernel.org
X-Gm-Message-State: AOJu0YywaGmjWD5G6XxeflrR5OGqRv1bzUWuncKDkoXTfFK/Wnwa8fjr
	dMQO/X3HOL/9EN+MS3npDu63gUSymNJ1VnsIXRtPv2KJVHqB2QATxX9CSAVQ1019iC58fqkiz+e
	fb5HxWA==
X-Google-Smtp-Source: AGHT+IEViJurBgSj1HUwewxJ2lufwYxLh7QiIceZMFqK3KJHnZaS1MP+gTNpl0gquADVo4qzM8B94yHCRDA=
X-Received: from edqm3.prod.google.com ([2002:aa7:c483:0:b0:636:4ff7:efe])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:909:b0:637:ec7d:4d6c
 with SMTP id 4fb4d7f45d1cf-637ec7d4f8cmr859439a12.11.1759404853757; Thu, 02
 Oct 2025 04:34:13 -0700 (PDT)
Date: Thu,  2 Oct 2025 11:34:04 +0000
In-Reply-To: <20251002113404.3117429-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002113404.3117429-7-srosek@google.com>
Subject: [PATCH v3 6/6] ACPI: DPTF: Move INT340X enumeration to modules
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

Move enumeration of INT340X ACPI device objects on the platform bus
from DPTF core to thermal drivers using ACPI platform core methods

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c                       | 2 +-
 drivers/acpi/dptf/dptf_power.c                          | 2 +-
 drivers/acpi/dptf/int340x_thermal.c                     | 7 +++++--
 drivers/acpi/fan_core.c                                 | 2 +-
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3401_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 2 +-
 drivers/thermal/intel/int340x_thermal/int3406_thermal.c | 2 +-
 9 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index cb81636a5d63..f3cd52c89e8d 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -162,7 +162,7 @@ static struct platform_driver pch_fivr_driver = {
 	},
 };
 
-module_platform_driver(pch_fivr_driver);
+module_acpi_platform_driver(pch_fivr_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index d7c59f016083..b85e876b2e85 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -239,7 +239,7 @@ static struct platform_driver dptf_power_driver = {
 	},
 };
 
-module_platform_driver(dptf_power_driver);
+module_acpi_platform_driver(dptf_power_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 7d1308b1f513..b2be3a8df9ac 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -27,8 +27,11 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 static int int340x_thermal_handler_attach(struct acpi_device *adev,
 					const struct acpi_device_id *id)
 {
-	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
-		acpi_create_platform_device(adev, NULL);
+	/*
+	 * Do not attach INT340X devices until platform drivers are loaded.
+	 * Enumeration of INT340X ACPI device objects on the platform bus
+	 * should be done by thermal drivers.
+	 */
 	return 1;
 }
 
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 04ff608f2ff0..61681ff24477 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -463,7 +463,7 @@ static struct platform_driver acpi_fan_driver = {
 	},
 };
 
-module_platform_driver(acpi_fan_driver);
+module_acpi_platform_driver(acpi_fan_driver);
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Fan Driver");
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 6311125c3ebd..0005961328fc 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -699,7 +699,7 @@ static struct platform_driver int3400_thermal_driver = {
 		   },
 };
 
-module_platform_driver(int3400_thermal_driver);
+module_acpi_platform_driver(int3400_thermal_driver);
 
 MODULE_DESCRIPTION("INT3400 Thermal driver");
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
index e0603f218d2e..d496f8b171e0 100644
--- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
@@ -69,7 +69,7 @@ static struct platform_driver int3401_driver = {
 	},
 };
 
-module_platform_driver(int3401_driver);
+module_acpi_platform_driver(int3401_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 213d4535f2c1..d06c06fadce5 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -100,7 +100,7 @@ static struct platform_driver int3402_thermal_driver = {
 		   },
 };
 
-module_platform_driver(int3402_thermal_driver);
+module_acpi_platform_driver(int3402_thermal_driver);
 
 MODULE_DESCRIPTION("INT3402 Thermal driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index d246c69d4872..33735515b47d 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -284,7 +284,7 @@ static struct platform_driver int3403_driver = {
 	},
 };
 
-module_platform_driver(int3403_driver);
+module_acpi_platform_driver(int3403_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
index d05ca8bc4061..03cc026cdffb 100644
--- a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
@@ -203,7 +203,7 @@ static struct platform_driver int3406_thermal_driver = {
 		   },
 };
 
-module_platform_driver(int3406_thermal_driver);
+module_acpi_platform_driver(int3406_thermal_driver);
 
 MODULE_DESCRIPTION("INT3406 Thermal driver");
 MODULE_LICENSE("GPL v2");
-- 
2.51.0.618.g983fd99d29-goog


