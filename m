Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B704285368
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Oct 2020 22:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgJFUqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Oct 2020 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgJFUpx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Oct 2020 16:45:53 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA8C061755
        for <linux-acpi@vger.kernel.org>; Tue,  6 Oct 2020 13:45:52 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d197so14552781iof.0
        for <linux-acpi@vger.kernel.org>; Tue, 06 Oct 2020 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfv5DwnuqxUK2/JI31FCljoAr6aY+o7ASwHVzd1SBv8=;
        b=NZwHIeJQKfVmnelySm/YL7PRFIILPLtLT+vDnRK8rJGGXMMmWvh80Fc9Tc9M3+TMrg
         LeSHcacCU9fDJ+xygh3eg4qKqztRKchsgt9o+Yp8mD5TKzIfsbFXwgGZ+lZ/eL571B6S
         3DYZolRQgSuxfez8xJJnLabbXp8XxOyPQrEDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfv5DwnuqxUK2/JI31FCljoAr6aY+o7ASwHVzd1SBv8=;
        b=TaU6yzbgRWleFmWQQIsR9ExYPVdF++wLGR7owU65kfnUhtTf5wWe5++PnnBycaHHD5
         xCYFLG5TaPEfTN6cekTYCIMSIytLDmgWJapUVS3m2WoNCCmfjKzeIciQBUGuDJljpFHa
         XUPVG+V1w4kYqPUZ1PDUNSgBpfjDo/P/GcyaEnSTUhWobaFnt6A9KDkuVagKlbHHI5hL
         YMt80ODeFjchzgCNi9rspwGuTYA1/WMzmUkFPoEwsKMVjiJOaAxK1yyI7iBzgJNBleKN
         MWj4tvJe2JGvSQ8AMEBLXIrh3QhyoVQkY+DYZDQoZq2S/dkLjjACZGZMnlcjJ7FSuE3H
         4AIQ==
X-Gm-Message-State: AOAM533+Q+kxwT+4QlBtF9jH/we+Srce2Zo40pa3Vu51arFaJhzCP66D
        4t1u+IWcHXSYXji10Ts0HSSujYHh9SSDnw==
X-Google-Smtp-Source: ABdhPJxZxKHD4d/VdWy1NjaKftY1G49pqPPh3cxbBTFf0LjEOwr2nODPZZWGSJ6nzF20dWwuUX9DQA==
X-Received: by 2002:a6b:9041:: with SMTP id s62mr2552346iod.97.1602017151852;
        Tue, 06 Oct 2020 13:45:51 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm1665627ili.54.2020.10.06.13.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:45:51 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] drivers/acpi: convert seqno counter_atomic32
Date:   Tue,  6 Oct 2020 14:44:36 -0600
Message-Id: <c6d405511bef3413156a2b38bad22dff624bff0c.1602011710.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602011710.git.skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables will wrap around to 0 when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

seqno is a sequence number counter for logging. This counter gets
incremented. Unsure if there is a chance of this overflowing. It
doesn't look like overflowing causes any problems since it is used
to tag the log messages and nothing more.

Convert it to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/acpi_extlog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f138e12b7b82..d1e733f15cf5 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
 #include <linux/ras.h>
+#include <linux/counters.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 
@@ -93,7 +94,7 @@ static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int ban
 static void __print_extlog_rcd(const char *pfx,
 			       struct acpi_hest_generic_status *estatus, int cpu)
 {
-	static atomic_t seqno;
+	static struct counter_atomic32 seqno;
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
@@ -103,7 +104,7 @@ static void __print_extlog_rcd(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
+	curr_seqno = counter_atomic32_inc_return(&seqno);
 	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
 	printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
 	cper_estatus_print(pfx_seq, estatus);
-- 
2.25.1

