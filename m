Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86459285369
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Oct 2020 22:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgJFUqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Oct 2020 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgJFUpz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Oct 2020 16:45:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F22AC0613D4
        for <linux-acpi@vger.kernel.org>; Tue,  6 Oct 2020 13:45:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so14563908ioo.1
        for <linux-acpi@vger.kernel.org>; Tue, 06 Oct 2020 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=At1aUnvT5eDxsJMP8JOTpBJfmvn8QU5R9du5xc+rYaw=;
        b=JruCQKsGQT8ZZXdkjACFodnnBoHtjwpX/ZY1bcTfL/nXebJXQblLPL2FeC4SYA72ur
         yVUP2jK7XNv5iIFTwk6Q2wx8b82cqNvdaKl+WvVOL1KxKA6PeGvFS7HD6Rq9MQbKlfDl
         0Ro5RBhD1B54be0A45bfA7mccWklThWcR+5lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=At1aUnvT5eDxsJMP8JOTpBJfmvn8QU5R9du5xc+rYaw=;
        b=JOuEV3Dn33MIk0/2EYYW/BaiVvB0j28+69+1keT5BqasG/Xva+jG2mvepuWM9vMrSO
         6aDasGHsdtItav0iPCj4eF4eez58ma8yLRsPzOvtryZj/mNTjPfWNdNKhqYUegigrlAP
         AgoTed0SQV2pTFKrk98DtgxSvyw8/Zixv5UaHOKI1ewDZASGCb1qIt+eciBlBnxzeoHP
         zYP7SICQZ65ttbhcZjNptauSGw08jKKLsthZzXumGHB8dRJpTVDPFOdAZWMzlRJQVHTD
         GR76ZVPZE7IXAHY8zAh4Ckz0K4sY3YVqYnwm3mXM5lp9f3yDWoFYx3953Cu4XozFuEwQ
         ZN0A==
X-Gm-Message-State: AOAM533fHJzVsLP/3Vikcf9jlMv1VZXx4H+6hmQw4vAuofQOQZoUev/K
        6KgbG55DmtaMevEi1Xunti39tQ==
X-Google-Smtp-Source: ABdhPJyyEGOvuXYYSNNHz4knD3nyyXJAgpQncSYUo7CUJKF6PmQDEFLpUTIWTQNd3U9X9JnJZ2wCGA==
X-Received: by 2002:a5e:c917:: with SMTP id z23mr2736650iol.38.1602017153697;
        Tue, 06 Oct 2020 13:45:53 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm1665627ili.54.2020.10.06.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:45:53 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, gregkh@linuxfoundation.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 06/11] drivers/acpi/apei: convert seqno counter_atomic32
Date:   Tue,  6 Oct 2020 14:44:37 -0600
Message-Id: <884f1fddfbc1a991f5f5bbada3ea63c1e3afab20.1602011710.git.skhan@linuxfoundation.org>
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
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/acpi/apei/ghes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b10d44..92169436be18 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -41,6 +41,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/counters.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -562,7 +563,7 @@ static void __ghes_print_estatus(const char *pfx,
 				 const struct acpi_hest_generic *generic,
 				 const struct acpi_hest_generic_status *estatus)
 {
-	static atomic_t seqno;
+	static struct counter_atomic32 seqno = COUNTER_ATOMIC_INIT(0);
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
@@ -573,7 +574,7 @@ static void __ghes_print_estatus(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
+	curr_seqno = counter_atomic32_inc_return(&seqno);
 	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
 	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
 	       pfx_seq, generic->header.source_id);
-- 
2.25.1

