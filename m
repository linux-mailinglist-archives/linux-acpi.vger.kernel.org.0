Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AD02AE053
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 20:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgKJTz1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 14:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgKJTyj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 14:54:39 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20851C0617A6
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2020 11:54:38 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id t8so11075808iov.8
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2020 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJU5BF5XUBg+xDNSMiAC8MnJi+PijhO7PLpt5hzre/4=;
        b=hWBEx6QME80sNP6u2IId4qFwe/A0iEcMW1hZC+POySD/V3cvoUOaZYvmHrKB0jNVWY
         IQTbrE+m8h45Pq4a7q068aD8d7YTati8uMJ8yS3sQ3lvHMlB7hQjf7DbXdnpxfJqV5yG
         eGvkPB5rvJmRABPLqNQkNHU6iiCQasGEIl+DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJU5BF5XUBg+xDNSMiAC8MnJi+PijhO7PLpt5hzre/4=;
        b=tUicI0FGB7ST83ThapvF9zkvJiGTAp6NfcK9OchkRM+Mw9cNeJfWqQeQohNBfVs7bS
         Z37OZWNaa1GPAPZl0+emhoXEH0DDV4JjK753Y1+dXESUsG5QdV8iMzNht36pjJ7rAhzd
         tOMn/t9vdT+ZZlkLjKOGto65C6x0gh+Lzzm5VLDSXWjoWQguVOgwLaqHvbmsjPw2Fhm4
         Ev4XQcK/oYi0zGdLwOQfOc5HiwcG5TR0smxnfoK5jnJDx6jZUEpQJrFKSbgoZKTNCLtS
         n1lUTiWi7aTbZ5jP2Xtz9wMW3zXiv6bvc/pgRlYHjPz+b7geJCt0COFFbKlCQ0AAKRtk
         L/Sw==
X-Gm-Message-State: AOAM533xmVBjrLUCR2C8JcRmN0QTDkLHz7aTeTMF/HNYPj3H3ShLKNRF
        nJ78pusk5GqIP23usHhClSg83w==
X-Google-Smtp-Source: ABdhPJxZq4Mqy2gKrCi1yrxiEmOjXBXpfjvBZnB9eJy+Qq21MyWJG4bCHboxEnZ4sQP9xK2EedVD5Q==
X-Received: by 2002:a02:c884:: with SMTP id m4mr7112536jao.43.1605038077545;
        Tue, 10 Nov 2020 11:54:37 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:37 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, gregkh@linuxfoundation.org, keescook@chromium.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] drivers/acpi/apei: convert seqno to seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:30 -0700
Message-Id: <59277751de83120741466b56beaefd75652c4de0.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

seqnum_ops api is introduced to be used when a variable is used as
a sequence/stat counter and doesn't guard object lifetimes. This
clearly differentiates atomic_t usages that guard object lifetimes.

seqnum32 variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

seqno is a sequence number counter for logging. This counter gets
incremented. Unsure if there is a chance of this overflowing. It
doesn't look like overflowing causes any problems since it is used
to tag the log messages and nothing more. This conversion doesn't
change the overflow wrap around behavior.

Convert it to use seqnum_ops. This conversion replaces inc_return()
with _inc() followed by _read().

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/apei/ghes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade2aba9..aa91998ce6f4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -41,6 +41,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/seqnum_ops.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -625,7 +626,7 @@ static void __ghes_print_estatus(const char *pfx,
 				 const struct acpi_hest_generic *generic,
 				 const struct acpi_hest_generic_status *estatus)
 {
-	static atomic_t seqno;
+	static struct seqnum32 seqno = SEQNUM_INIT(0);
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
@@ -636,7 +637,8 @@ static void __ghes_print_estatus(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
+	seqnum32_inc(&seqno);
+	curr_seqno = seqnum32_read(&seqno);
 	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
 	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
 	       pfx_seq, generic->header.source_id);
-- 
2.27.0

