Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2922AE466
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 00:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgKJXwG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 18:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJXwG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 18:52:06 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21148C0613D1;
        Tue, 10 Nov 2020 15:52:06 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id i13so3804oou.11;
        Tue, 10 Nov 2020 15:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=GB/JzElEejU8yrYZtAAVnaWAqNt9nJf4JjQo87qrctE=;
        b=uRikxKqNmTRirr6DL9KpUztoqyBeILPgqzAGtXOjW+WRCYT9k4FEhTlLx/8gVLhT0M
         eghtZxBbruyN8Hq22tFSbmik93zsXF6O1sAheGsTP7hR9jycRFsuH5a3fvtKIqxofx+q
         wl/LBJK2offvl1xDmkBdNATkA2sXNbrLPF5mHXrPCQqGpW1+eHID62LdvWQKIqV+uRXz
         fa+Cr+wRDRcTS065o0IvX0S5LJojnp9gQOTiihwHDbFxb1MVyG199g/wyeDNtYwhx9qv
         2F3oFXB5tLJM5PtbgrFn8UPhrAxjMah34YB1qjkXcOnuQfj7Qmd6wuqHy8FSmhwH+EZj
         yhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=GB/JzElEejU8yrYZtAAVnaWAqNt9nJf4JjQo87qrctE=;
        b=LcQmV3CJpIyxk+8yJJ1PLhpxam8zkGPlmTEEUNbFmelH9Jvh8N1POxy9LV0WDncMFN
         wu9u9GH1OIyUsgDg0ajWWYx2ABaxJ0fhL83R0+y5AV8w3K2aX8pl8Fo62PC7R2ebZbmD
         f3r4l/ycRN/5c3rP+ZhL4/oYSiQwRHMqiZxOSPhQYzC8xstxRjKz5MotkZ/NuWVq9t9R
         631WxtbY92fgwkBfqL1RMkLQO4i8M6S0mpGPoPDiXqtIVyix51hFJQ9K07DjeVJbx6Mp
         ZMgzOX4c/OF/Gb2n6J+1V6yhn6sNyIZYWopHuT+SjdBqZoScAVf8FeXzADpYwbF0Eanz
         KfbA==
X-Gm-Message-State: AOAM531/lkPCiylrQzegJ1wKQA/QsPZiKE/raGpVCzRPbL7jIDDb3Y4W
        S+nUZpItW5gSKkxqM37koeA=
X-Google-Smtp-Source: ABdhPJwkzZk1/CkbSnMbjvKEfnnmpwOqLrp9jAxN7zRdaAK1669ckwYMaPWzLQ4vwATQGhrqv5JB5w==
X-Received: by 2002:a4a:b188:: with SMTP id c8mr10121238ooo.61.1605052325293;
        Tue, 10 Nov 2020 15:52:05 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11sm110018oti.75.2020.11.10.15.52.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 15:52:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: fan: Initialize performance state sysfs attribute
Date:   Tue, 10 Nov 2020 15:52:01 -0800
Message-Id: <20201110235201.76981-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The following warning is reported if lock debugging is enabled.

DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:4617 lockdep_init_map_waits+0x141/0x222
...
Call Trace:
 __kernfs_create_file+0x7a/0xd8
 sysfs_add_file_mode_ns+0x135/0x189
 sysfs_create_file_ns+0x70/0xa0
 acpi_fan_probe+0x547/0x621
 platform_drv_probe+0x67/0x8b
 ...

Dynamically allocated sysfs attributes need to be initialized to avoid
the warning.

Fixes: d19e470b6605 ("ACPI: fan: Expose fan performance state information")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/acpi/fan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 62873388b24f..9cbe58e394d0 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -351,6 +351,7 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 		struct acpi_fan_fps *fps = &fan->fps[i];
 
 		snprintf(fps->name, ACPI_FPS_NAME_LEN, "state%d", i);
+		sysfs_attr_init(&fps->dev_attr.attr);
 		fps->dev_attr.show = show_state;
 		fps->dev_attr.store = NULL;
 		fps->dev_attr.attr.name = fps->name;
-- 
2.17.1

