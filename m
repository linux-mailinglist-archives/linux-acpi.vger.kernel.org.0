Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4813A55FD
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Jun 2021 03:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFMB5R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Jun 2021 21:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhFMB5R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jun 2021 21:57:17 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8B5C061574
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jun 2021 18:55:03 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso7200236otm.11
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jun 2021 18:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8WPlYtrSCysijOVz9j8fCoDQgLKwSFYG2ZEyr+9cJM=;
        b=m8ukk6Y6RBms+3bjhQt1pExXJbAQRuZireLiOqDEJivewDanbhH2RtBH77QCHEgeju
         ZzNSbUPj+VE4WunGEUyb8Wg/ayvT1YhtzLeF/Afl5oa6akJNZEIx/WERNRagOcnXVja7
         PZpAyh7cFpWpOobikmbQCmzmV5U49apCKRcrsb6CPnCdwbDjA5rZbfY7pLl0sWIrjpKb
         +7NMaHjZ55ohFtDzDyCsAMuLyl0w3TFswKwh3X+K6ciAyZ/R3nujNSYKny2JgnQdmKxI
         yKwDF9xKAXw307vgPoEBVwJWS0pE6k0UcQq3LtJu/P90BmAav2SlQXqC28jMnF9WoBMZ
         2QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8WPlYtrSCysijOVz9j8fCoDQgLKwSFYG2ZEyr+9cJM=;
        b=p5y++v5BvDoYz9f5bMkUO3xeYqgqcTXWZJq+vwwjwI+WLNhWeWgO2bL3D7Xn5q4gXC
         mVBdOZRCJWF3iv2FLkKOXZbEozbtK7lUM4QcVgkdne87NEkIzBx1/cXDe8LBqdY/l007
         sHrgt5DULkmKmTFi/DcuvBPQid8EOqV2uEIuRs+POAG7ie7L1t2hheSyzZ4eRRJAPTey
         nuLPfCr7IiE9h7AZewsm1qBoL65hKIxaFifIxx4iHkdTleyQRGg6sB7UORMMxdJ6+pCm
         IQ7saG5wwcui7Q1nQuHZJWq2NOoWcTe+uPnB+1INoleFz/9j2FjMejW847w08FFgiHqQ
         aQWA==
X-Gm-Message-State: AOAM531jLmyfqbOii8jqoZf3aAKxrCEOfviePfR7qZQ2hBp1ntjDmLJ4
        nvZEDAzxybcETpIf8SxpSU4jS13uBtKiDg==
X-Google-Smtp-Source: ABdhPJwWqYfEG7D6ZJSmKDqFpnEppHpuOcLs+Dv2sLs+GX4mheRO3L7hnmWNWMxadn87HlDT9C2HuA==
X-Received: by 2002:a9d:6f93:: with SMTP id h19mr8611540otq.292.1623549299693;
        Sat, 12 Jun 2021 18:54:59 -0700 (PDT)
Received: from fedora.. ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id 3sm2171735oob.1.2021.06.12.18.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 18:54:59 -0700 (PDT)
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH] acpi: processor_throttling: Fixed coding style issues
Date:   Sat, 12 Jun 2021 19:53:53 -0600
Message-Id: <20210613015352.13072-1-majortomtosourcecontrol@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 drivers/acpi/processor_throttling.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index e61b8f038364..45f5f7d68b1e 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -6,7 +6,7 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2004       Dominik Brodowski <linux@brodo.de>
  *  Copyright (C) 2004  Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
- *  			- Added processor hotplug support
+ *                      - Added processor hotplug support
  */
 
 #include <linux/kernel.h>
@@ -195,15 +195,13 @@ void acpi_processor_throttling_init(void)
 {
 	if (acpi_processor_update_tsd_coord())
 		pr_debug("Assume no T-state coordination\n");
-
-	return;
 }
 
 static int acpi_processor_throttling_notifier(unsigned long event, void *data)
 {
 	struct throttling_tstate *p_tstate = data;
 	struct acpi_processor *pr;
-	unsigned int cpu ;
+	unsigned int cpu;
 	int target_state;
 	struct acpi_processor_limit *p_limit;
 	struct acpi_processor_throttling *p_throttling;
@@ -477,7 +475,7 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 		goto end;
 	}
 
-      end:
+end:
 	kfree(buffer.pointer);
 
 	return result;
@@ -554,7 +552,7 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 		}
 	}
 
-      end:
+end:
 	kfree(buffer.pointer);
 
 	return result;
@@ -639,7 +637,7 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 		pthrottling->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
 	}
 
-      end:
+end:
 	kfree(buffer.pointer);
 	return result;
 }
@@ -717,7 +715,7 @@ static int acpi_throttling_rdmsr(u64 *value)
 		msr_low = 0;
 		msr_high = 0;
 		rdmsr_safe(MSR_IA32_THERM_CONTROL,
-			(u32 *)&msr_low , (u32 *) &msr_high);
+			(u32 *)&msr_low, (u32 *) &msr_high);
 		msr = (msr_high << 32) | msr_low;
 		*value = (u64) msr;
 		ret = 0;
@@ -1185,8 +1183,7 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 	 */
 	if (acpi_processor_get_throttling_control(pr) ||
 		acpi_processor_get_throttling_states(pr) ||
-		acpi_processor_get_platform_limit(pr))
-	{
+		acpi_processor_get_platform_limit(pr)) {
 		pr->throttling.acpi_processor_get_throttling =
 		    &acpi_processor_get_throttling_fadt;
 		pr->throttling.acpi_processor_set_throttling =
@@ -1246,7 +1243,7 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 			goto end;
 	}
 
-      end:
+end:
 	if (result)
 		pr->flags.throttling = 0;
 
-- 
2.31.1

