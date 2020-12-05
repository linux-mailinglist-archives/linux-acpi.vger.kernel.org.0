Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290522CFDA7
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Dec 2020 19:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgLESmZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Dec 2020 13:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgLERic (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2020 12:38:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F6C061A56;
        Sat,  5 Dec 2020 09:04:17 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so9758957wmb.5;
        Sat, 05 Dec 2020 09:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23C9Ul2ghjmtO1BTicHAi1FqcvDYRumYWusDkhObZqk=;
        b=SofYyZM3PDDtGsOSdR8ACZOXWr+yHRxLaOrG0tQ9V2HpWRJFMmvBlLRSGrNU+5A8dz
         GABdA9y1HX+Hb194BMIjVHTMcWOEufVzEjHhcI0VcPYgRCAGg58zo5Pa0ncTn6cLAgQ2
         Ri6SGX+xXlp0kWxTJEI01L8HOiijbbgD+WjG7hYgYM5MisedAFF6yICCrJtu0mrtTc/4
         ajtahggj4oL6hyifC0JdGfS2feFpf9SIRTXcAS7mMzdJwh8h2wE/CF380byb1YEr1fVg
         mEZ07LGxBnV+mGYzUCHsqXJCymAaRa/Q91mKFP54NAxQFdmS2fjkIFfocMNOeyT7HB7K
         rdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23C9Ul2ghjmtO1BTicHAi1FqcvDYRumYWusDkhObZqk=;
        b=TABepvFXEZgHKyCwY0QeuT/YOLZAGVKD2q6pys08n8fDGZiea37Cv+rf82G7WJA9/P
         5i6xLeoPPBd+Gu9wKbmlFX0Kk8FLZ7jmYWe4VMvuUWR6jO1ElV4PhYrQZ6CmTs0+8Knd
         GAXh6YnoI2TEeT8bOAPaAHy8xwhWNDVDWTj50HF9edV7ZPBjTqhE57Afzh01pfTRQS0g
         OdOZV6PwRtol/R1AgT2aR7+oisPEqljugKhKj8i8P+BROfT7k/xrpeb2GeJA4HOUesbd
         Lb74z2Y81TsSJk82gJWR1okMrERVEDMFdT4A0wy2tgbEO878yUlMJMjliF1vzkkZrjXu
         QZLA==
X-Gm-Message-State: AOAM5334A3/YvwZokxJFdJKu1ILDW0T2g9HB12TCnrX0mNoMGrhyya5q
        7+frnRhf2OsbJZYN4YIothrnCHq4l4osHg==
X-Google-Smtp-Source: ABdhPJxqoL1yFp51O/IXBl4y5UnOXWEgoz0DunuhfeLFFKImjTbYa/SeENlRXpP0Hi3xHLpOCBqjSg==
X-Received: by 2002:a1c:3902:: with SMTP id g2mr9901700wma.117.1607187855750;
        Sat, 05 Dec 2020 09:04:15 -0800 (PST)
Received: from valhalla.home ([2.31.225.57])
        by smtp.gmail.com with ESMTPSA id w17sm8265984wru.82.2020.12.05.09.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 09:04:15 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lenb@kernel.org, mika.westerberg@linux.intel.com, rjw@rjwysocki.net
Subject: [PATCH v2] Revert "ACPI / resources: Use AE_CTRL_TERMINATE to terminate resources walks"
Date:   Sat,  5 Dec 2020 17:04:03 +0000
Message-Id: <20201205170403.31827-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit 8a66790b7850a6669129af078768a1d42076a0ef.

Switching this function to AE_CTRL_TERMINATE broke the documented
behaviour of acpi_dev_get_resources() - AE_CTRL_TERMINATE does not, in
fact, terminate the resource walk because acpi_walk_resource_buffer()
ignores it (specifically converting it to AE_OK), referring to that
value as "an OK termination by the user function". This means that
acpi_dev_get_resources() does not abort processing when the preproc
function returns a negative value.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/acpi/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ad04824ca3ba..f2f5f1dc7c61 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -541,7 +541,7 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
 		ret = c->preproc(ares, c->preproc_data);
 		if (ret < 0) {
 			c->error = ret;
-			return AE_CTRL_TERMINATE;
+			return AE_ABORT_METHOD;
 		} else if (ret > 0) {
 			return AE_OK;
 		}
-- 
2.25.1

