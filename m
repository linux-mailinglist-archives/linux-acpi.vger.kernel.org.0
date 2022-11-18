Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB88F62FC44
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Nov 2022 19:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiKRSP5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Nov 2022 13:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242555AbiKRSPz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Nov 2022 13:15:55 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE55898F4
        for <linux-acpi@vger.kernel.org>; Fri, 18 Nov 2022 10:15:54 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f9so1459577pgf.7
        for <linux-acpi@vger.kernel.org>; Fri, 18 Nov 2022 10:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmg0LliGpsZZHm4HXiakpzT3kGjALzuosA9bdBtcr+Q=;
        b=eiAPF5GM7kr6LedkAaCy65AdbVFDpDohOTBtN5jzYKzNKrFe9SMUfOeHShgkG72ML/
         TsZq+WEQoaSw0hMt+I5CwhPS5//DaY0NCujymzjFkkHz8CoYyrH7MzIACPlboc+3lm38
         RDqL5ZoJZO9q+GU5AddFLfwE9IpWtNpDyk7N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmg0LliGpsZZHm4HXiakpzT3kGjALzuosA9bdBtcr+Q=;
        b=olrHXDgia02jLS8eFfBTStH0BTErzJr7bTKCJCxqnY5YN6PbhGgJGt7Zgnnm+N1PVD
         5vEyLM/KnPFGCyUL4V+USzCwDxXvc+k9Da+BQVfE9xMrFEweEhZaD68HSoF27EWnJz36
         n/t+55FCPqYtcsa9j5bbhPzkvqkk5IPmA/Y/jeBvaPKvCsRDlKscZb3FGAt1eqq9ZTJK
         +3gT1tRDWU4Ai/p8DrVKJSQ89bNEwBllKP1ipincQb9C0HlUAC3DJUWrQhF2PmzsfE3q
         b07bM38b1TZF3+4AGbqglyQoIg7ibchMjBx63cii5tJhv5L7mvfXy5Fo3i5TYLSJkhos
         lwPA==
X-Gm-Message-State: ANoB5pkKZnqTU+7CiN4J4CvUyhRwR+bg4dMuDMt0TduUW7IH7JKwjwrh
        pNdhQYIeuAaHhx6IaNAt6LfLzw==
X-Google-Smtp-Source: AA0mqf5WDnA1r5jesMg2Qg61/95ge1c7MF8CtLnRwIZaYDBuT4OQmMYteUJ6lQc50XLxtxY/qLeJXg==
X-Received: by 2002:a62:ab18:0:b0:56b:9ae8:ca05 with SMTP id p24-20020a62ab18000000b0056b9ae8ca05mr8908089pff.59.1668795354181;
        Fri, 18 Nov 2022 10:15:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a4a0a00b00217090ece49sm3068381pjh.31.2022.11.18.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:15:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] ACPICA: Replace fake flexible arrays with flexible array members
Date:   Fri, 18 Nov 2022 10:15:51 -0800
Message-Id: <20221118181538.never.225-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; h=from:subject:message-id; bh=hNQ8xGwsN5w0u1FbYYQ7J14X7B6YxBpfy2M2HM3+Jjc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjd8vXU+Wg7XOvkEcmLqHTez5MBdtt0fUOreosAnS4 ntlijcaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3fL1wAKCRCJcvTf3G3AJjDkD/ sFy/fgnccpfOxOXUfmtmxp15lFZTGFZrdm9pbQImExpBb+3wb3jtS5vOigfPdnrVbUAgGA4vw2yBmZ QkApv68Dgc5HzHHbjzpWx2Doo6zdD7kuIygYQqG1TRHIQjr4NWA47yR63Aq3AFYKPh2q+xRCpMrMK5 ZEbxM26zdW+0jmw3BtJ1mmi8V4Q2bhU5+8EyqJ7ESMcqxQKPIrdOtdorD+ACi2P/tJv7prDbSVHFuo 04Jm+Io0K50lcfK9MBGuP45auU9z25kCe/rM5fh5QE9TJrXEVb4lJhoyX64FHY7ya1K9uXk7mGpTuq rCZqhfrGcJvSetSG3qWaP14jtazw1pGpyTE1jMvmuCebgEHupzq2DrThTsn8XX9xLKE9pplLP1OziQ 5tgbmRcDMxNFRQxVL/W1XwTl72j1QD9FbaanBJHksNkYuNAlTPJmVWZR5BowGyuSZJKQ2z0M/fTs0O LXegQJRXyN4FjtHyN/1N7XXNMtEiygKrFXA6YCU4RuSM/C25VrCFo5Rfjlvoed3qfBOTejkqRy1MNV nI21vUXGwSzoJAunS1g5tGn007d7H5tGmp9qY2OTJZBQK3tC1QxMy2Hr1/4XeqygKonufrTM05F3wP eI1e7KQ4oKKMbtYa4eQBq4YsSjyId0Th+edmiKiF/uIcwqjKiKtrc6iqflUg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Functionally identical to ACPICA upstream pull request 813:
https://github.com/acpica/acpica/pull/813

One-element arrays (and multi-element arrays being treated as
dynamically sized) are deprecated[1] and are being replaced with
flexible array members in support of the ongoing efforts to tighten the
FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.

Replace one-element array with flexible-array member in struct
acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
padding in a union with a flexible-array member in struct
acpi_pci_routing_table.

This results in no differences in binary output.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: devel@acpica.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/acpi/acrestyp.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index a7fb8ddb3dc6..ee945084d46e 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -332,7 +332,7 @@ struct acpi_resource_extended_irq {
 	u8 wake_capable;
 	u8 interrupt_count;
 	struct acpi_resource_source resource_source;
-	u32 interrupts[1];
+	u32 interrupts[];
 };
 
 struct acpi_resource_generic_register {
@@ -679,7 +679,10 @@ struct acpi_pci_routing_table {
 	u32 pin;
 	u64 address;		/* here for 64-bit alignment */
 	u32 source_index;
-	char source[4];		/* pad to 64 bits so sizeof() works in all cases */
+	union {
+		char pad[4];	/* pad to 64 bits so sizeof() works in all cases */
+		DECLARE_FLEX_ARRAY(char, source);
+	};
 };
 
 #endif				/* __ACRESTYP_H__ */
-- 
2.34.1

