Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05B8375414
	for <lists+linux-acpi@lfdr.de>; Thu,  6 May 2021 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhEFMuV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 May 2021 08:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhEFMuU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2021 08:50:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED8CC061574;
        Thu,  6 May 2021 05:49:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 10so5189720pfl.1;
        Thu, 06 May 2021 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15GKIU/VxVFZXf36o9Yrp20X9pUI530VMRJk1YXWiwQ=;
        b=WaPLP2+sW2dXb3g0PkjwtlmmNygtk1fmVSauKRC6BdLAn9Xh2YifmDoyXppx0ENOBU
         FCUUHd5cZOpnVGFtG7oCtF5y1UVMaCoD8AlZ1DZgdXbpW5NIvyBgjHOxZ/oGQOc0OgZY
         78bFr6UfsJjYuY/E2oGbc89HD36tBIPzQECtcGnhFVjXXlTRVWkSUY63sgj7xDYDAS7T
         vWgmLUUva2oFYNJJl74E1NdF1Flyjww4udb31qO3nDM4+vZPIWhWWebg1YCLUNFpZ67z
         C5ZK1s4P6bHYis1UgBJcuIjI027b7jLo5YayW+1fQ/SfWf05Z79FWfSsrobOSRDyJy0L
         qt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15GKIU/VxVFZXf36o9Yrp20X9pUI530VMRJk1YXWiwQ=;
        b=f0CMWUAoIgMLuPB3L8FXGYminxXCBAyAi9VdoDIsTy+RfnPjPNWaNf95OfaiI3JqLL
         ZbXNX0MW8TBCf7apVaSEEEEudLrD70zDs/aiugMBb6qHMEU47fIIu8prkKKMJpL1shFk
         ScAH2KidUXEUQYgbCHDq1o3YBQQ4+BC25SQQugCAcKZ4QHduRtAlIb5uF8ZVsugqlOZA
         X/Pix/xPz0AkbIfdKuGaf5Xs8/zcPBZPRFhQBcz8xytCprt0034TA+tYQJeBVkhQPjAx
         VQ/m1A4jokzPdKqh8y5LIc18d/rdJ6eOHMF5TLIC1UFhOjVW4gdJy7YEip5DRELRw0C3
         /yVg==
X-Gm-Message-State: AOAM533/gOIz8ntHptdxipElZOpRBCabr1Tibj39BjxlfkAH1UI5bIN4
        3aysJ2SqDclvSrH/AMKxD6fAKBdRpnWu+kPjcr0=
X-Google-Smtp-Source: ABdhPJxIZt9y1cqlh0eCQWAF6Siwalsz3UBUCaUrJylH/fSA2f8rMHcHPF/3bZbYrx4yCnXKaDPlfQ==
X-Received: by 2002:a63:7e13:: with SMTP id z19mr4114613pgc.184.1620305361551;
        Thu, 06 May 2021 05:49:21 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id t12sm1991313pjw.51.2021.05.06.05.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 05:49:21 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] ACPICA: Use fallthrough pseudo-keyword
Date:   Thu,  6 May 2021 20:49:12 +0800
Message-Id: <20210506124912.7725-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replace /* FALLTHROUGH */ comment with pseudo-keyword macro fallthrough[1]

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/acpi/acpica/utprint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index e37d612e8db5..0b511434b80b 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 		case 'X':
 
 			type |= ACPI_FORMAT_UPPER;
-			/* FALLTHROUGH */
+			fallthrough;
 
 		case 'x':
 
-- 
2.25.1

