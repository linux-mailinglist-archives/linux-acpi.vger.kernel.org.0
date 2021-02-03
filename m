Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A856230E234
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 19:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhBCSOh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 13:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhBCSNd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 13:13:33 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C73C0617AB
        for <linux-acpi@vger.kernel.org>; Wed,  3 Feb 2021 10:12:18 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id g9so133760ilc.3
        for <linux-acpi@vger.kernel.org>; Wed, 03 Feb 2021 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjC27Eb9w9mM2SAEoXcwuyGIikNJU3zdPVeVR9rKt0c=;
        b=KqWrrH2txCq4lO2ex6WKtRqHlkaLYMNP/cM5ExESO2VMWv16ydv9eW4RUqwDSNgULE
         cV9HAU5u2bk8h6Bdl11d/CiQYi/VeWsJsIfOQozly7zbb8GrHUOoPQ1x+sx+Tu2iCRKE
         N+71OcIyUcMeVWPZhq9WGSvc962kn3oWzcHPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjC27Eb9w9mM2SAEoXcwuyGIikNJU3zdPVeVR9rKt0c=;
        b=aoV9LEHm7bFoBqs5Y1vr+VPdo6gO4WbtL4x5GiQdJAPCpJpcswJovokXzTtNkMrZy/
         nySI0Qj8IIqUKsTQM8MF8wFOtJziTggv5WYX5DIa14lT4YuGQ88rvdf5s2dDWgCyjPm4
         YidUChLUBeXEDp43N4GIi6l6augsIW7BOBgpm1zXJ9hBjp5IYFYG6duHWOEuG9JWzIkX
         ZuafKBcQxfpc7OAWvNfGx0Q/lSbu/qWvdB9WsMMxX4KdyT0YMy6cb4ZeXUk9nEILX3v5
         +KMFEKal8v1kf2yjY9HnG6xAvWZ7NXcMf7kEiVKLr6uYXk6uZ0fF+dfT1dBWYnqba50Z
         JKew==
X-Gm-Message-State: AOAM5321V8VGZBXJViR7FqIMIModXn2L/BIsBSFLiAasUWIBDNEIkPAV
        d6zPU3E6SDIQv36HzIXrKHJemA==
X-Google-Smtp-Source: ABdhPJx8Qrp2K4WoCsSpLgc8CZBOB6oPCmpJqO+WHXB9WoPN+cz8O0USgJa4+n4x2TYfDLXOVcxczA==
X-Received: by 2002:a92:d845:: with SMTP id h5mr3474042ilq.34.1612375937986;
        Wed, 03 Feb 2021 10:12:17 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h21sm399684iob.30.2021.02.03.10.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 10:12:17 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, peterz@infradead.org,
        keescook@chromium.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 3/7] drivers/acpi: convert seqno to use seqnum_ops
Date:   Wed,  3 Feb 2021 11:11:59 -0700
Message-Id: <8d11eec80d6668065fb35a0b025c3614b67bf798.1612314468.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1612314468.git.skhan@linuxfoundation.org>
References: <cover.1612314468.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

Convert seqno atomic counter to use seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/acpi_extlog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 72f1fb77abcd..16a4928645a1 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
 #include <linux/ras.h>
+#include <linux/seqnum_ops.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 
@@ -93,8 +94,7 @@ static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int ban
 static void __print_extlog_rcd(const char *pfx,
 			       struct acpi_hest_generic_status *estatus, int cpu)
 {
-	static atomic_t seqno;
-	unsigned int curr_seqno;
+	static struct seqnum32 seqno;
 	char pfx_seq[64];
 
 	if (!pfx) {
@@ -103,8 +103,8 @@ static void __print_extlog_rcd(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
-	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx,
+		 seqnum32_inc(&seqno));
 	printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
 	cper_estatus_print(pfx_seq, estatus);
 }
-- 
2.27.0

