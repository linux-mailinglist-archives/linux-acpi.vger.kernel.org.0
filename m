Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C8E37BED4
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 15:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhELNvm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNvl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 09:51:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F3C061574;
        Wed, 12 May 2021 06:50:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090ae502b029015b0fbfbc50so382293pjy.3;
        Wed, 12 May 2021 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lF3zIWRBmjQNGRhL7RSn8ALvgjyrCfxTezULAdSmxXA=;
        b=VM4Lt6abnC4MQiMVD49r0HxiqlgvfS3NdUFSx8ATNqHMJ7LZwQJZoKCAM0LqNH4I1b
         EzpK7QXvy4AuscqqkTEPErsbY87SmP+/aFCLCrSmvUSpjq524CZlRubHyFYiHbZHPOio
         10/4DcN/GaqYYiwPuB0taeIO4a4wMMDU/zcWO2UJL9M+s+3tnHkPCgse8DMsk/0d47zf
         E7mV/5GZSKd01uBC4/bapFUUa9Bpbo1XkXfQPXh9YellYqIy3mOujmecPzH3altXQUmm
         /6jVGWDFIA3mGuylGIRiewy4nO3uwIOQYv+0xiNWPp+X2cNB+j+7EuT/VfSTHmbCLKcg
         DzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lF3zIWRBmjQNGRhL7RSn8ALvgjyrCfxTezULAdSmxXA=;
        b=T19chHAwouv1tH+eDg983bN/g5dOtnzDORMk+riQMVfYrzaQY4gVggdoVYpmn5ecGp
         yDsGf9jqNju20prqhZ8dHitCORVuk7zOFGXZOV4NjoSecYxqj3N36vexE6Drvc/1hKOi
         CrFAvW8TbiWZBNKgNRlf+HFFNPdq3bkq3ECTqa6XWrKEu/yHT2ZhEK20gl/pqFmFoPvP
         7OQjn7GBQjnuKLT+IT/W9i39VUOzIlNzKmq2+2xhs6ME/KJM19TgkYgKFFYwmOHKBxS1
         frP+1PFeGF69OSo1UUsi2/7YUFFBdYKY0fh9pIPMaOcwnWejuQ/2w/UhbcoaESoSdkG/
         hEdA==
X-Gm-Message-State: AOAM533YeYei0xE0HaRRbPozSB6Zv6fCrzcfhXIzSAGKp8nIbMFV/faw
        4cJ5PWV/tHzAMrxlfhdplXfARXIg4Xu42RwqQGQ=
X-Google-Smtp-Source: ABdhPJxsPSgaMd34YrOESOQScMfQotIEL41AfWxpO8ogdH0kXPgV+lePDwvcRaNclKZ8znuHFCxXYg==
X-Received: by 2002:a17:902:ecce:b029:ee:cf77:3b22 with SMTP id a14-20020a170902ecceb02900eecf773b22mr35109167plh.46.1620827432817;
        Wed, 12 May 2021 06:50:32 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id v15sm57750pgc.57.2021.05.12.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:50:32 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     erik.kaneda@intel.com, devel@acpica.org,
        linux-acpi@vger.kernel.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] ACPICA: Use ACPI_FALLTHROUGH
Date:   Wed, 12 May 2021 21:50:18 +0800
Message-Id: <20210512135018.20253-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replace /* FALLTHROUGH */ comment with ACPI_FALLTHROUGH

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/acpi/acpica/utprint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index e37d612e8db5..05426596d1f4 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 		case 'X':
 
 			type |= ACPI_FORMAT_UPPER;
-			/* FALLTHROUGH */
+			ACPI_FALLTHROUGH;
 
 		case 'x':
 
-- 
2.25.1

