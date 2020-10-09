Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7A288D75
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Oct 2020 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbgJIP4V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389510AbgJIP4V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2020 11:56:21 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AADC0613DE
        for <linux-acpi@vger.kernel.org>; Fri,  9 Oct 2020 08:56:18 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o8so9435822otl.4
        for <linux-acpi@vger.kernel.org>; Fri, 09 Oct 2020 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxGBD0NCi/MzhF6RzJGO1Op3qiNabAYCN4C/VOLMVMg=;
        b=Pv8X98rQrxmQmC3AYgeqGl/3Wk9jEr2z3r1AsjjBWItQarSnLt+hACI/K+54PmcGqB
         a6eccMthV+9Z0NohOHwemKNP3iAKtcfB871irTEsCjdu6VJjkKtzuC0TCZ+38LgwYXqy
         22DWwqfvNOxEp+4/pcAGi+dbraAvqO0gRaIDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxGBD0NCi/MzhF6RzJGO1Op3qiNabAYCN4C/VOLMVMg=;
        b=sbPdzKM598WVTFf/3JUJBjq6GKgTLStlM+kJOxRVZmezSIqKqgUyLd5yQRXzEcWzMa
         KJcDWEZ5xL0STIt8fPs3vbt7vODap4xFlNW9Bx2P7507X4uuPC0R2v0CWwuDfjNjVYss
         PQPgsf+ceMnIjiqTBq/xrX0lNjFNaLpean+NjBl0ogSwMYekIP4V6jtfrg6jxLsYrNc7
         R9qYGW1t9dyOy26HU6YoPHLdjiGPNmzCojd8RM7d5AF+KDmtEJ1ipBqcGSXGtNqv1Vq6
         9Pg0zB7Cy4poaASkW+RB62bqEsFFvQXcSQZ806Fhym81znQdHgUHistMmmItjxS2miMp
         eK8A==
X-Gm-Message-State: AOAM533/d55u2RuvI4BKykPCfX5Z0STW/x3oWz6vCrHvrULTbUI0Vn4V
        7bwQZTxDI1GH3XCw3fyA89C9mA==
X-Google-Smtp-Source: ABdhPJwbBZCHnPwAt1monb6rS8Y1Exeh2/LVfsjInRAkUPpEXOu1zrSNDvtpFRcJNjRoSW4w4ceTAQ==
X-Received: by 2002:a9d:224b:: with SMTP id o69mr8748064ota.358.1602258977631;
        Fri, 09 Oct 2020 08:56:17 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e7sm7347246oia.9.2020.10.09.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:56:17 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, gregkh@linuxfoundation.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v3 06/11] drivers/acpi/apei: convert seqno counter_atomic32
Date:   Fri,  9 Oct 2020 09:56:01 -0600
Message-Id: <2f39e13e92b587ac48b7c11a17854b6426cfb745.1602209970.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602209970.git.skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

counter_atomic* is introduced to be used when a variable is used as
a simple counter and doesn't guard object lifetimes. This clearly
differentiates atomic_t usages that guard object lifetimes.

counter_atomic* variables wrap around to INT_MIN when it overflows
and should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

seqno is a sequence number counter for logging. This counter gets
incremented. Unsure if there is a chance of this overflowing. It
doesn't look like overflowing causes any problems since it is used
to tag the log messages and nothing more.

Convert it to use counter_atomic32.

This conversion doesn't change the overflow wrap around behavior.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
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

