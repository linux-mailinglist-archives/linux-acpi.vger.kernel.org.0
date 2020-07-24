Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C722CAD6
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 18:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGXQVX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXQVX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2020 12:21:23 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A54AC0619D3;
        Fri, 24 Jul 2020 09:21:23 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id by13so7403384edb.11;
        Fri, 24 Jul 2020 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnLeEgl0OdbAaR19fupjakxQIYn8oNSSFUXoArUSDD4=;
        b=riM6pJY00CChmUUWclO6o4dA0hIz8JHEYu/bXyGnhI3YvRYfOZE4HpeeZEVwzpYL0P
         +BRPu5Xbeh/jqKjZtJytBVadwHwMQab4Hsd9MR5V1PBIgR0yFdwphZWPB2UldwNHyH+4
         a2GzMzhg4AqkjTwTzEF5Pda2m9HSmO0T6utJ5QnXMPmUAqtcu46CMS/+ZiwXP2TMC8Dq
         L6TGtFnbp/WE0qV+K8oG7cXHBKsMS2b7gJsdldLEdlpkGaZib9GUocqEOqJg8Z50oDZJ
         UWvDeChf/aCJNLKjDA6tdULxFHJ5OrLONxainfK6r1vCRJ3tAQYtRF59sKV0llQQ6JCI
         tUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnLeEgl0OdbAaR19fupjakxQIYn8oNSSFUXoArUSDD4=;
        b=DYNUYWurD51GjPNuSs6j7tOofaB9WVYG9v6a1WDiKdsLtjZiHkE6t+KKElwYCInd/I
         SZ4J/kC9x8RYeuXvN1Y/L6Ys7Zl26qiMc6TvJLPF83s4W3WEijufqebglMf0MyUnv579
         xsgyiCloS6A1Gaaexw5PbjpR5rA3hg2qU4uW+k72yhfadu7vvTNCWfuWU8vIPEMojkSz
         3udf7a3BTnrNKFVTqjW1wx6crFDy/rUm0ps5haSr4BFz6AfhGSnOmVfOtCg9kudIkn+6
         SFnoKn7dtkf1u0jIltuu7HndXarv7jtD1nIy7ibu36Aml7ZSsIEEILNIHYVrc2xiJTk/
         gWwQ==
X-Gm-Message-State: AOAM5339c2kREvd6+zbzlKze5sZ8xiGVYaGnPfu1Gp7TkK9I+xtVSYWf
        nTNKA0igM19gFCvPPu/OF/M=
X-Google-Smtp-Source: ABdhPJz0aRYFiwE7s+lJSzQ8OxbkpX38V8gtjz1U8eFteEkd327Q/20KGY+yhKDzSzMDed3LKpLr2g==
X-Received: by 2002:aa7:d7cf:: with SMTP id e15mr9834501eds.236.1595607681680;
        Fri, 24 Jul 2020 09:21:21 -0700 (PDT)
Received: from garrit-VirtualBox.fritz.box ([94.31.102.44])
        by smtp.gmail.com with ESMTPSA id o20sm937069ejr.64.2020.07.24.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:21:21 -0700 (PDT)
From:   Garrit Franke <garritfranke@gmail.com>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, trivial@kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, kernel-janitors@vger.kernel.org
Cc:     Garrit Franke <garritfranke@gmail.com>
Subject: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Date:   Fri, 24 Jul 2020 18:20:52 +0200
Message-Id: <20200724162050.18077-2-garritfranke@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.21.2007241814450.2834@hadrien>
References: <alpine.DEB.2.21.2007241814450.2834@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Garrit Franke <garritfranke@gmail.com>
---
 drivers/acpi/acpica/exfldio.c   | 2 +-
 drivers/acpi/acpica/utownerid.c | 6 +++---
 drivers/acpi/bus.c              | 2 +-
 drivers/acpi/sleep.c            | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index ade35ff1c7..92fc702456 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -298,7 +298,7 @@ acpi_ex_register_overflow(union acpi_operand_object *obj_desc, u64 value)
 		return (FALSE);
 	}
 
-	if (value >= ((u64) 1 << obj_desc->common_field.bit_length)) {
+	if (value >= ((u64) BIT(obj_desc->common_field.bit_length))) {
 		/*
 		 * The Value is larger than the maximum value that can fit into
 		 * the register.
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index d3525ef8ed..c4e2db2f54 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -74,13 +74,13 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
 			 * int. Some compilers or runtime error detection may flag this as
 			 * an error.
 			 */
-			if (!(acpi_gbl_owner_id_mask[j] & ((u32)1 << k))) {
+			if (!(acpi_gbl_owner_id_mask[j] & (u32)BIT(k))) {
 				/*
 				 * Found a free ID. The actual ID is the bit index plus one,
 				 * making zero an invalid Owner ID. Save this as the last ID
 				 * allocated and update the global ID mask.
 				 */
-				acpi_gbl_owner_id_mask[j] |= ((u32)1 << k);
+				acpi_gbl_owner_id_mask[j] |= (u32)BIT(k);
 
 				acpi_gbl_last_owner_id_index = (u8)j;
 				acpi_gbl_next_owner_id_offset = (u8)(k + 1);
@@ -171,7 +171,7 @@ void acpi_ut_release_owner_id(acpi_owner_id *owner_id_ptr)
 	/* Decode ID to index/offset pair */
 
 	index = ACPI_DIV_32(owner_id);
-	bit = (u32)1 << ACPI_MOD_32(owner_id);
+	bit = (u32)BIT(ACPI_MOD_32(owner_id));
 
 	/* Free the owner ID only if it is valid */
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 54002670cb..39ead80c45 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -233,7 +233,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 		goto out_kfree;
 	}
 	/* Need to ignore the bit0 in result code */
-	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
+	errors = *((u32 *)out_obj->buffer.pointer) & BIT(0);
 	if (errors) {
 		if (errors & OSC_REQUEST_ERROR)
 			acpi_print_osc_error(handle, context,
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index aff13bf4d9..38f5210313 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -880,7 +880,7 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
 {
 	union acpi_object *out_obj;
 
-	if (!(lps0_dsm_func_mask & (1 << func)))
+	if (!(lps0_dsm_func_mask & BIT(func)))
 		return;
 
 	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, func, NULL);
-- 
2.25.1

