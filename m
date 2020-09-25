Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D13279502
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Sep 2020 01:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgIYXrq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbgIYXrk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 19:47:40 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE886C0613D6
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 16:47:40 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 95so3887260ota.13
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 16:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TH11kEvm9iFU4edsTXh7gIDGSk88lSWe2otA52wUs9w=;
        b=UNNLjr39gbouxZCpSiFmcY9V1u0ktwIu7LfYV86klf1keKuS9PkQjb6Vl4/wm2tfsB
         G+xB4lPkRm3p+eIzjRXwpJ1X3XOUWMEm6GNbDW+NGx47YtNIeYp0awbq6fwQjMjThrtL
         y9b5rXVmtqJJiyUIpLg6dFL3iNVsbuKheOEPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TH11kEvm9iFU4edsTXh7gIDGSk88lSWe2otA52wUs9w=;
        b=jU/nl/k5a4uB21Fk8Qtw+fCIod4exqoMdzwc+voDvtIp+Tx7IikxQ/Bwvv/kGup+Sz
         BzXnuWuVhB/EDT49kIsI1DamY45tuheGkKz+KoXOyeTOCQB2kGZaVad9h/IODbvgRn7D
         uyhmUAfltPZTtNCT0oX6gqBBLgRz90hjyvJ8pvLBvNNepq1Aklx5z2XuU6KytCvJ5bmB
         nx3sZiU5uE7MFVjMpVJOSVwcNxPZdjFjknXtfXXozriidreagliA07klmNGqH5iplO3B
         TMow3NDLxdFYAnmk+Z8bRuu4rm0NDiL6pQVAwuwi20Ymwf4/Klj/0l39E5BklBpWdKgK
         vwWA==
X-Gm-Message-State: AOAM532GL9h3pg6kq50FVrIQmm6/ffr00wt5wHOot0ciNfqKLfrMNqs+
        DwnGODf8e9dQmDvoGPZUcHi2eg==
X-Google-Smtp-Source: ABdhPJz/N5qHYeVtWPNLZSMPG+q+JbGjAeoRPiaG78bk13SSNfuduPKklEESh2O7y0hCpBwnUyersA==
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr1960036oto.208.1601077660111;
        Fri, 25 Sep 2020 16:47:40 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:39 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, gregkh@linuxfoundation.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] drivers/acpi/apei: convert seqno counter_atomic32
Date:   Fri, 25 Sep 2020 17:47:20 -0600
Message-Id: <c05e3d040fcaa51e275065f6d6f0b0588fdfebcd.1601073127.git.skhan@linuxfoundation.org>
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

