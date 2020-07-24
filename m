Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9244B22C9AE
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXQDC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXQDC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2020 12:03:02 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA5DC0619D3;
        Fri, 24 Jul 2020 09:03:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i26so4080977edv.4;
        Fri, 24 Jul 2020 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQTpifOXkPGGfRuYd1/rjbKFU+Iii6xOzk9bp8GtLa4=;
        b=T5sCHRjiyU0tXMKbXmkzw0PdZ2FZXHO6zcqMu7MHZjCvpOlr9sPjpGT1rQl3qzP4GV
         QlUn4J+yk+w/wCuQ4dijHzJlSEQl0mCY9+YXGWWIjvr4cJxPPyo3PVGCna07jjULq9ro
         lPMFRoj6hyBEG0Y4ZVhOIAPnsXnxGNDXcdwMxj6/BlmDmc+/GxRIlJlwZ0m1GXlzCtob
         63RW6DbUXqDWJoAk9giTOlyTEx8O5qoYCjcYwbE0TQ4flpJm0kj/6hvP8dlrjYAcI4wL
         EMJ9JfCQO2x4RULPl7ZhHkvegVFAyMQwYw0QmSS3D71aL7xNQnh5v5p7XwX2aME0d2KF
         /ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQTpifOXkPGGfRuYd1/rjbKFU+Iii6xOzk9bp8GtLa4=;
        b=S1E8xZ32XpHNYI2/kjH2xNz/4oIUCbpMAgMWrmJmhXGoDITqodA/iR7CdRNKLGuHJU
         n99IU/zzwyPJr4aitMy7gi5+ofDJmuO/UsJribSyITmAOlEffHtJVerjjlwqutMYCfl2
         wD2bAiwpiYm6twXl6e4dvpav5XTGApXzpE+5+HyOEpGRfpKEnSCHdfZarAEGH3tf6tAL
         tAMwAv5C/NL2sx/T/g9bM3B9/QTbMT9Sig6MOYLABV8w9zViTXM4y//brKLINAnisJjG
         ewtIHLWAweIVRqnFwIblZa4j+oTAG1c3HISGz3w4TwD0Hc5ay8xA1TWb0jvdSdORfejO
         ex2w==
X-Gm-Message-State: AOAM531JfZyrT/rzsHvfKXkIqkpw4xD42ib++OeWgFnvSzP8sWp+4QWV
        713MU1guNB9BjJDCdpVxTCs=
X-Google-Smtp-Source: ABdhPJzQTXO3LcAy5BHvoc0MGt7LyyOeYJtSgKI3JTXJ63hb/M7vVBL1YDo7FUsLGqZPoHrtdaN9sg==
X-Received: by 2002:aa7:da06:: with SMTP id r6mr9622991eds.189.1595606580463;
        Fri, 24 Jul 2020 09:03:00 -0700 (PDT)
Received: from garrit-VirtualBox.fritz.box ([94.31.102.44])
        by smtp.gmail.com with ESMTPSA id w19sm908625ejv.92.2020.07.24.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:02:59 -0700 (PDT)
From:   garritfra <garritfranke@gmail.com>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, trivial@kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, kernel-janitors@vger.kernel.org
Cc:     garritfra <garritfranke@gmail.com>
Subject: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Date:   Fri, 24 Jul 2020 18:02:39 +0200
Message-Id: <20200724160239.16284-1-garritfranke@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: garritfra <garritfranke@gmail.com>
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

