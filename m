Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A2C2B22FA
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 18:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKMRqg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 12:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKMRqa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2020 12:46:30 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0CCC0617A6
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2020 09:46:29 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q1so9196852ilt.6
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2020 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40/cDlcEfTdEejZ/aCiOotkpvr8vR4pXOw6eVWgRoOQ=;
        b=d0H1yPCGdSvJSDF/9DqeQNJCbuDUdks4ZOROuAD9yuKoXHs+YNvDITq/tDKdvD96fK
         p0mlsS2HsPp+HiTx5SuZ8V1V7/HT4OsA6cB9GIIRxpj43P+Ke+QvhVTGCc1J0lVmnXbO
         /PFrDS6mlY3KITbKNLe797ItK2vdpM9ivE3Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40/cDlcEfTdEejZ/aCiOotkpvr8vR4pXOw6eVWgRoOQ=;
        b=mH4qjI7ZJRrOKBYiHm1FYAdAbHVkGYEJsty3qgaMOK4vPTj6LZ5+gA3bCLsPeQ9l4f
         qBpsbIWEEo87Tg8cAE09cYye+5WFQwmXLiuL3Ys7vheGQ9J7A0qFuheV+64LlN7bTHh1
         2jn3JYFoifO6SEhQxVprrs4Z71AMtz1QxYlTqpiiEfnioEa7BtzHAwWNIQZ8yb2Ym3mH
         T3zfaEMebdyLT+IdjIME4Uj7diNs2ecMHZz5AgIfW+vA/0K5C1bCDsCMvjx5a8UiU09q
         4ZJfq0wOte5yQY3889IbewVtem86uZFKqBNLtydxUL3iPZs3X47Isa4nfhLe4iykA1h8
         94XA==
X-Gm-Message-State: AOAM532yN53hwNG07qmMZGPWuoFtf5ctNUMQsAFoc/X59KcHnBtxB5RV
        rDKc3A6o1nwYTjkG7tbx7/D5bQ==
X-Google-Smtp-Source: ABdhPJztcmfqYzDzMmyF0PYWt0eujkKZtL5AK7mJIw/D96Bi/odpIwaym7pt8HiSN5EI8BU1S/I0vg==
X-Received: by 2002:a92:600e:: with SMTP id u14mr659595ilb.221.1605289586244;
        Fri, 13 Nov 2020 09:46:26 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:25 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] drivers/acpi: convert seqno seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:05 -0700
Message-Id: <b0bed077dd48518f10195844b5bb0ac4374df868.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605287778.git.skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
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
index 72f1fb77abcd..5872ff698644 100644
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
+		 seqnum32_inc_return(&seqno));
 	printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
 	cper_estatus_print(pfx_seq, estatus);
 }
-- 
2.27.0

