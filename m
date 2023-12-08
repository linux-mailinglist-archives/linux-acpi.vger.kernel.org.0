Return-Path: <linux-acpi+bounces-2229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC8580A128
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 11:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F6DB2047F
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5B19459
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHnmlIRj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C562D4A
	for <linux-acpi@vger.kernel.org>; Fri,  8 Dec 2023 02:33:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bce78f145so2209997e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 08 Dec 2023 02:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702031618; x=1702636418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4cT1vPyF4MV6Slk3a0U6oOkB8CmE1BrFIZp/eFFbf4=;
        b=QHnmlIRjhtK+UkcUFdtli+wgOIrK27ehHSn9m2hldHYTEjb4JHzhILK7mkhHv5OT9+
         ueQXwKLwr1YOC8q9UBS3LImd91u+xlbfyBsuXANw76fv+hemMxly3zilqAYZvxpZlyXf
         7KPplqR+pMmTUFj8XQM7eTNcQRuKDEcTXC58TMw+ahvk3vGi13aWW41KmfrNj+yszxL1
         gy5TMGKRIq7tV6QpJHqLaRYlcEB5xhK5QRQ7q/rNNZm1k3YX69k1SYgrfKWQPhMHS9Wq
         MWnNufZAsrX5YkR2JWHXCq1oZxmjlDa1VbLtvx4Iq9Yd25vSTzPQuNVj6xEZ0IIWkQrU
         WNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031618; x=1702636418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4cT1vPyF4MV6Slk3a0U6oOkB8CmE1BrFIZp/eFFbf4=;
        b=E752L8kDHkbIkOTTjaMxyBYZuERUiTklgd9ceP5eRN4ClkUyxzgBTDI0NMTydCSu1P
         aKtiRqXVxlo1Rcl9ZkVaLJsk3GKL5BiknrywFMdaOQWLZKT+jt1t6jZAaJondNx8Ijv1
         qg6vI922Xxq41kn1Ae6FD4RO6zHFWIJSSsNvDY/c0e+Z4+/3VjAmQzyubAlFe/8sYEOt
         XYJZc2TSr8SRWThJkYsrmFOZ8CcEK+exiKaN+Cr4YLb8dtXSbd2s15Z2yOaYjcMkjQb0
         J+vgxxEW00Sq1HM+5t/Sz4WWhwI1euI09HOmzZ2ZAjuPZ3YO5GdPWfXy+rTjWUfYB6Tj
         FNTw==
X-Gm-Message-State: AOJu0YyDbkmB2PuyoneAQwUS6j9T5sbiHYTQqXUTCvjhrAMpQQuUnsMV
	ITzV7WsEdkwjd8Fwqp5ZGTMzYw2A+FwCxNPhZ/o=
X-Google-Smtp-Source: AGHT+IE1x+vEB0enFOFbtTJdwklZj+bcAzaYQcqHhZJJEoKhfkAXGO7EL1aO6WM7utpSS1pYmNwbYA==
X-Received: by 2002:ac2:4a84:0:b0:50b:f51a:299d with SMTP id l4-20020ac24a84000000b0050bf51a299dmr1077926lfp.18.1702031617898;
        Fri, 08 Dec 2023 02:33:37 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id y1-20020ac24e61000000b0050bff86c497sm176842lfs.23.2023.12.08.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:33:37 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	james.morse@arm.com,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drivers: acpi: arm64: thermal_cpufreq: export module
Date: Fri,  8 Dec 2023 11:33:32 +0100
Message-ID: <20231208103332.2829631-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following build error shows up when building an allmodconfig kernel
on arch=arm64:

ERROR: modpost: "acpi_arch_thermal_cpufreq_pctg" [drivers/acpi/processor.ko] undefined!
make[3]: *** [/next/scripts/Makefile.modpost:145: Module.symvers] Error 1
make[3]: Target '__modpost' not remade because of errors.
make[2]: *** [/tmp/next/Makefile:1876: modpost] Error 2
make[2]: Target '__all' not remade because of errors.
make[1]: *** [/tmp/next/Makefile:243: __sub-make] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:243: __sub-make] Error 2
make: Target '__all' not remade because of errors.

Solve the issue by export acpi_arch_thermal_cpufreq_pctg() since the
function are used in function 'acpi_thermal_cpufreq_config()'.

Fixes: a02f66bb3cf4 ("ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64 and riscv")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/acpi/arm64/thermal_cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
index d524f2cd6044..582854914c5c 100644
--- a/drivers/acpi/arm64/thermal_cpufreq.c
+++ b/drivers/acpi/arm64/thermal_cpufreq.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/acpi.h>
+#include <linux/export.h>
 
 #include "../internal.h"
 
@@ -18,3 +19,4 @@ int acpi_arch_thermal_cpufreq_pctg(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(acpi_arch_thermal_cpufreq_pctg);
-- 
2.42.0


