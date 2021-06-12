Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B23A507D
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Jun 2021 22:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFLUMU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Jun 2021 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFLUMT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jun 2021 16:12:19 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB24C061574
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jun 2021 13:10:05 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso6714373otl.13
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jun 2021 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKEX8cTD1kN5NoYJkf/ZAwwWslWM8AUiiSWPZSLHlP4=;
        b=RPQgP3NP4LieAvfw4Juod0Q5BlgZ4N7Cz8cyKM0NobB7em9Ud86p9+C3FkTsWD/4g5
         eg/dYuud3SOah5f027K3pUV6LjcvNSzhX/mZB3jbKSsUDfhA5McV9115rgHfrjbnCpjg
         wD6sYJ4po5u9iQ4jByWhPyJ8ID5Z4hqCZux7F1iR/wkDUBAzI0a1VLWeGsrYy/rgBzx7
         ag2BrpBfJY9ojrhX+yjwU2mDP1mU1+/RASF/80ANE3Oismd7eyCZqRPsOjosXGKjPYyM
         MOoCl1dxbazwHcXQb1WeHU+J1gLKYa0JyZ8p8RHdlY5Rj3NmcjiOK221I6GSTqPsLZsl
         lQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKEX8cTD1kN5NoYJkf/ZAwwWslWM8AUiiSWPZSLHlP4=;
        b=b/GFFgAOVDlvDE6eY0pxMUulcN4NiwY+dhBbDbelfJ1dq9oS8nn4h0rPqvFrIrknsb
         /KuMzQIXYOlsWP7qOLZ4jkgwT9hdcyer8CgKfaVcdRx+zbHSu0BeDQD0I90bKXAnjkQN
         0fmiVl3JeTuYJBuKnvzeHCzoAH1q9VyfjFZjPDYoRMyaROj9j8PigO5p93r4ObsS8qUh
         sLif4Ui+x5P/tz8Rar5A+fTa9dZb7SIlXJHVe2Pk9eZYDwkcZ+p0i2p8K3FjysvsvK0P
         nT2XV44BBEOxPHf61PenzVBt6Z6+sC0ztP+d8D5Fx4M+rBkdGB/M6qAO12IMbXs6pwi9
         NWkg==
X-Gm-Message-State: AOAM531wRVoVruY+sfmQ8zlvLZL2g+D5pv7rg1B/6WQpHHqww3janfut
        h43zsLzmRiG9nP4lhc81Xxw=
X-Google-Smtp-Source: ABdhPJzEvrd/auD1iu2HxghK7xZqtACz4R5BLd3IQZFb8LRDC+wl8lhaqop6DunE8qwrTXjOCTi+7g==
X-Received: by 2002:a9d:730a:: with SMTP id e10mr5931830otk.97.1623528603793;
        Sat, 12 Jun 2021 13:10:03 -0700 (PDT)
Received: from fedora.. ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id t39sm2011086ooi.42.2021.06.12.13.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 13:10:03 -0700 (PDT)
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH] apci: sysfs: Fixed void function style code issues
Date:   Sat, 12 Jun 2021 14:09:11 -0600
Message-Id: <20210612200910.1094351-1-majortomtosourcecontrol@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixed coding style issues.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 drivers/acpi/sysfs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index d25927195d6d..d6626aba4a6a 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -582,8 +582,6 @@ static void delete_gpe_attr_array(void)
 		kfree(counter_attrs);
 	}
 	kfree(all_attrs);
-
-	return;
 }
 
 static void gpe_count(u32 gpe_number)
@@ -598,8 +596,6 @@ static void gpe_count(u32 gpe_number)
 	else
 		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
 			     COUNT_ERROR].count++;
-
-	return;
 }
 
 static void fixed_event_count(u32 event_number)
@@ -612,8 +608,6 @@ static void fixed_event_count(u32 event_number)
 	else
 		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
 			     COUNT_ERROR].count++;
-
-	return;
 }
 
 static void acpi_global_event_handler(u32 event_type, acpi_handle device,
@@ -914,8 +908,6 @@ static void __exit interrupt_stats_exit(void)
 	sysfs_remove_group(acpi_kobj, &interrupt_stats_attr_group);
 
 	delete_gpe_attr_array();
-
-	return;
 }
 
 static ssize_t
-- 
2.31.1

