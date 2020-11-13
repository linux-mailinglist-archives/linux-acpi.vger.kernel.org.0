Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3A2B22DF
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgKMRqk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 12:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgKMRqj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2020 12:46:39 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D50C0617A6
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2020 09:46:39 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id k1so9206431ilc.10
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2020 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pld0tyi+mzGsNQuwI7CQnf9lmVsFN1oZVTP/doygylM=;
        b=BOStf3do2hC0pTZF89IfWM4+AY2BNC3HErF8ATi7v6CpjAMVOVr3tKjoOxWsuIO62s
         nTGiNtyW8Ymt9ehaaeAMuID2+9iSJAMTqruwn4nTFhy42vn2QozL1TqYUbkKBwaMLjOu
         51z0I86aNb1gZc7AeZ0qnpRbLb9Y2o6pPDI08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pld0tyi+mzGsNQuwI7CQnf9lmVsFN1oZVTP/doygylM=;
        b=NJll/dheQqHLgKFV+udnBORmuj3wGpb0rffVWg8QrtupInvRaTnrs3Z0wFXo2Urkna
         YI8h70jdBBYzzHZeJGT07h7UxwRDJv0HAJUIiVcSnEq/ZWf7czLSbwQmPqCmD8xbUdd8
         IoVMVFPEfvcLJmNVrS1snvBOrvHvqhebj9UG1mVpIG4UYBFbLuPwF09a9NAL/L+9iddB
         eXTg0siSUGXqOOeT3xOcO9E10S5XuGmUAJN+GWHZO7dVeCVnV+I0p0SJXhayQBinuaR+
         eDmiGx+Sx4e1Jzzz4jtVuY0GLW9lM9auVcAphCKRluRr9ntqZmRNS8yURKvm1wTdbp//
         YR3w==
X-Gm-Message-State: AOAM531nmjCYakm78tBgj6XILZTxCYjgnWW2p46Cq3Atu3qaIFjbfJ64
        I1NpJGe6QV8ZV0UBOOleEQmMLw==
X-Google-Smtp-Source: ABdhPJy5c18i6GgD/ONeS4809cT7BgmT+JSdsCG0K4KSxEyiL2s1EQsTIKyDyscYGTcUmeDh5bSJvA==
X-Received: by 2002:a92:4993:: with SMTP id k19mr705357ilg.237.1605289596639;
        Fri, 13 Nov 2020 09:46:36 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:36 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, gregkh@linuxfoundation.org, keescook@chromium.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] drivers/acpi/apei: convert seqno to seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:06 -0700
Message-Id: <7e329c82fb30e9ccb9bcc2d5c56c24efcd924d0c.1605287778.git.skhan@linuxfoundation.org>
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
 drivers/acpi/apei/ghes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade2aba9..36ebecf36dfb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -41,6 +41,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/seqnum_ops.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -625,8 +626,7 @@ static void __ghes_print_estatus(const char *pfx,
 				 const struct acpi_hest_generic *generic,
 				 const struct acpi_hest_generic_status *estatus)
 {
-	static atomic_t seqno;
-	unsigned int curr_seqno;
+	static struct seqnum32 seqno = SEQNUM_INIT(0);
 	char pfx_seq[64];
 
 	if (pfx == NULL) {
@@ -636,8 +636,8 @@ static void __ghes_print_estatus(const char *pfx,
 		else
 			pfx = KERN_ERR;
 	}
-	curr_seqno = atomic_inc_return(&seqno);
-	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx,
+		 seqnum32_inc_return(&seqno));
 	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
 	       pfx_seq, generic->header.source_id);
 	cper_estatus_print(pfx_seq, estatus);
-- 
2.27.0

