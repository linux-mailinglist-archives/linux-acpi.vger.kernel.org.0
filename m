Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687CF279511
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Sep 2020 01:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgIYXrq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbgIYXrj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 19:47:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1491CC0613D4
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 16:47:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 60so3952240otw.3
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfv5DwnuqxUK2/JI31FCljoAr6aY+o7ASwHVzd1SBv8=;
        b=PJwBEwXoDlmaOihq4USR91LUuIlycye+cnBxlxnV1BLnSK3jVHTq1ObnjeK00HjbYj
         fmQ2zYF0nxqhpSD4c7K2zriVY2/thFbvtpJATf9R80neccigNL8uIfa2XWuqWN102MO/
         K9jTVJ9Hnm5kfYfWddAdxkp5M+bwFLUTSt/a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfv5DwnuqxUK2/JI31FCljoAr6aY+o7ASwHVzd1SBv8=;
        b=eBOp0/8chUsZJxqr1DPE0n4KjT4o6AV4rnfJfCnTeLeJzaZFbD3J8No2RP/zyKotNt
         de5mo1QI8Vo+oplX2pEd6N3dg7m22WJfbRhvAw4cqdfRI7Lz7cBfdPzYaEdYPYUP4SZm
         CMN89Ly46YCts+qnJCuqaZmqCt/wEDwK+SIR64PPVPNse07z2NxwVGPIoEg3grpPvBEM
         b3H5KUvpx3BUR4bq6jh9Jt7H8B0p1LRxiO2CgOjmBZFFqWlYjeHgjx+G3tF0ouOKQb3/
         A8lDH26l+ZbuYKvLboPyi74oTlFhOaTTKf2LEJUjmp20RMkEYOXNp6obSU3LOIbltwuv
         s6Aw==
X-Gm-Message-State: AOAM532rxqgPgVRN99TQdOEBeTWVzmg3DuYlQEnmQR07oMYiRJjXGS9v
        r4Y1DBT7p2wt1/1k6ye9lqgceQ==
X-Google-Smtp-Source: ABdhPJx6aGdjiInXsFRrlUQ2fnBxI8gTzveq1ANiRP2KZz1+XLj0ZD4Upsgn70drDJZRXMvfhXeOWw==
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr1975643otp.129.1601077658485;
        Fri, 25 Sep 2020 16:47:38 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:37 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] drivers/acpi: convert seqno counter_atomic32
Date:   Fri, 25 Sep 2020 17:47:19 -0600
Message-Id: <c70c2be728d8b8552ef4de6f0536c3e8395ec456.1601073127.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
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

