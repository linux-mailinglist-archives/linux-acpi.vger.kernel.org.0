Return-Path: <linux-acpi+bounces-1776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFEF7F5A0F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 09:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F9228109E
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA48BE3
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8dtWN9v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7711C90
	for <linux-acpi@vger.kernel.org>; Thu, 23 Nov 2023 07:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F59C433C8;
	Thu, 23 Nov 2023 07:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700722816;
	bh=gtU+Ip4vBdqkXNcVYMAHTdA7Yf0OaFIdHF1c43xiML0=;
	h=From:To:Cc:Subject:Date:From;
	b=O8dtWN9vYKsRY/QVCQnJOZQMygs9qZR3wKEwAqgHsbtp3o9Uz8TuFWQhWw85jtvUI
	 XXAGrFMsnzJ2LKoaVjLqUGMYPMMJ/jNPe5VrslWFx9QWIUoKSVlyURITZdFufAyv45
	 mGY/lb0py1rl6lxM52ZFUn46m6W3AbHjnrhG0Dr84YSj8Prx+c4z9zbTgAIkwFYR9U
	 O69VHy8DBgf6FPoL4o40OT8DuBtUFqJ+4m2zBa4n9ZhEW1h9ZBb5xDmCVqh/KINU9J
	 HWsGLxOsUuBs6vCzxdLvGl8YkcF4RY4l9GkjVpBZktIRdFMDhvxH348Fxs5uPFQPiU
	 IIShg0B1Izf6A==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: thermal_lib: include "internal.h" for function prototypes
Date: Thu, 23 Nov 2023 07:59:57 +0100
Message-Id: <20231123070010.4013969-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added functions are declared in a header that is not included
before the definition:

drivers/acpi/thermal_lib.c:46:5: error: no previous prototype for 'acpi_active_trip_temp' [-Werror=missing-prototypes]
   46 | int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
      |     ^~~~~~~~~~~~~~~~~~~~~
drivers/acpi/thermal_lib.c:57:5: error: no previous prototype for 'acpi_passive_trip_temp' [-Werror=missing-prototypes]
   57 | int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
      |     ^~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/thermal_lib.c:63:5: error: no previous prototype for 'acpi_hot_trip_temp' [-Werror=missing-prototypes]
   63 | int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
      |     ^~~~~~~~~~~~~~~~~~
drivers/acpi/thermal_lib.c:69:5: error: no previous prototype for 'acpi_critical_trip_temp' [-Werror=missing-prototypes]
   69 | int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
      |     ^~~~~~~~~~~~~~~~~~~~~~~

Fixes: 6908097aa5a7 ("ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/thermal_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/thermal_lib.c b/drivers/acpi/thermal_lib.c
index 646ff6bda6dd..4e0519ca9739 100644
--- a/drivers/acpi/thermal_lib.c
+++ b/drivers/acpi/thermal_lib.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/units.h>
 #include <linux/thermal.h>
+#include "internal.h"
 
 /*
  * Minimum temperature for full military grade is 218°K (-55°C) and
-- 
2.39.2


