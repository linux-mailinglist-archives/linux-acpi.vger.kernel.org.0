Return-Path: <linux-acpi+bounces-15472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B9B193DF
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 13:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C113B6164
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109B6259C82;
	Sun,  3 Aug 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KocQsPAc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CDDF76;
	Sun,  3 Aug 2025 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754221147; cv=none; b=U3Cv6G0UaF6RIKx+qPKbJlYj6A6fsDtECy8zOmRlgqmactma7yodJIsQBGhA8V/Rs1QidyMMlb2y238F269g3cKc2wvmoqrztWKDmVhnJlgA/RHojWNlokHYlwCX76eTAIQ+Jy0wRRMDYS1d9kGPYUUifHkU3co+12Bix9e+4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754221147; c=relaxed/simple;
	bh=s1FR7zxDZSSXuXE1d969kx1AYfH0bBKhLwrR+UZ+uDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nynto8Pd+Q+wuoGwxRbi4W9CTbLKGMt6sKx0Wo+3R0/qwx//2jF0dDQSJ2gdNwK3EuUjSmKTftjoTHXEYJTdr7wEOLUrMNGztdE/jmzQElEFYEbUGbIPzM+Bw2WuuiZe+4jKtMMaqf3EtJT9R+lZvvnHETrNTqhHtuuNFHzgS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KocQsPAc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23aeac7d77aso30391805ad.3;
        Sun, 03 Aug 2025 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754221145; x=1754825945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5aQYQG7h1SH5iX9vRpAQpmq1mqK08hgnvrQbM2elCA=;
        b=KocQsPAc4n7M0bLGh2HaezEB399vaAIHbp7V5Fl9tkq6q2VraLtvXkY1ZWZ/E1QBKP
         5iVc/7Zu9NHHP1Bfp7EA5vnd7WWT+MzUQzVmWilizmgdu92r1VwmLEfR4HA4VcvCZBSZ
         PqLHKl2/gURFEoiA7WKV4usSqD1+W3almRgID5A1F+onFp7w2MmpwLm7qLLSIk5X0UEO
         SimN96jAqnHIMQRfEjMUK8M/VdGLoR3nAz4TphBgtqkg8rpSyPgnEQ7n9qnOYD2r5bjq
         oserweWUpLI6OIOL1RQQkjYFI2Ku6d1ML9SAB8I6BJN+3gdvs9/MMOXy7ZczfSWMa70j
         VPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754221145; x=1754825945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5aQYQG7h1SH5iX9vRpAQpmq1mqK08hgnvrQbM2elCA=;
        b=mkXwTqfwwiuF1zMLKeWOpbOYcU84fCUct3de5du5WVg6u3fU+JASmEvrTo7H1P3mon
         yOJG/kGS8D/DGqdgNDjOzFU540qXvqAWf+zfUjk5x/qffAxc8MF+CeJBZ29IdzgSPgnX
         0NtyB6vJaxWLx3NLL5erZY9vHcw62OwXpHhEud0CvZJLu/JqUpBuXzTs5OicpWcEQO7v
         IgUHvtM6sIaM2xUYVo52DGcVeiZRaADfQlHIDhabij3MFGlq6ieu1HBHM3uem2e4swjt
         mXNL2035Iq4gWFpqvRiTWb7VOMbijxYkTdcuYNCN+jX8QmmCNSlnfDi3lPISV7y6zYKN
         pNjA==
X-Forwarded-Encrypted: i=1; AJvYcCWJXeIP1vqZXu/Vu69dOB6cbC6rI82r5GZHGolLuAuy0nOiBQd4XTAns7qcA3O8kIvL6FxOFm6EyE2PLzKO@vger.kernel.org, AJvYcCXFIDcyubmFbVSQwyVMCj6SoqQLbSomFL20DF/qX8Jy0NTifAXIc+lO68V7t22O0z+RCy78SXfup6sL@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDawFeVqfXpCF1DpR6AfD5Dt+wCOHOfWIGM8789CQ4s12TjwQ
	1MWVVXAlLFwGyH0vgVp4/kbnOtYNcwsDRPS40Ec9hE2caLIg83GWCkRo
X-Gm-Gg: ASbGncvVfXLmaApshfpfkFMikWRoS8jWdlrzAdMeU17m9Qx/ivdYC/PUECiWJPQ1Rx6
	ScVMYGOqZKRMj2iiyqZeikadrVKjYa1r2riVj347TD7Y8H9ePfnsamw2ULCG2HHV7dB9238wLv/
	gLvyorHnzpC+OA1WZVKdzhswSl90/WQVn++sQ48HW+d5FKvVmVNQ8A1RzeXxjXjGDZb8yhfXHzJ
	0yak9twGBoU14DjIQ2jvUk/tMUfdofcd+kaZ8m53jV3YlTBX4c6KJxoweN0FJYxpqiZESNJgy8D
	JGD19iTLE24m8C8X362u1FTX2rWLsdaOizMcXX2sP7a724DmMNEfaE+24Nyh9CGWJr919EmHpgt
	508T5ZfuBst3mi6ST3aHW
X-Google-Smtp-Source: AGHT+IFcjXs40AxnwGTjfvVWOaYc9m2DmTG8evzSHsQvp65r/QMyy8sA4I35X3KKVoTM/Dqbar8UnA==
X-Received: by 2002:a17:902:f252:b0:23f:ed09:f7b with SMTP id d9443c01a7336-24247063df9mr51125695ad.48.1754221144647;
        Sun, 03 Aug 2025 04:39:04 -0700 (PDT)
Received: from diksha-pc.. ([49.207.53.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8ab0c40sm85423775ad.180.2025.08.03.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 04:39:04 -0700 (PDT)
From: dikshakdevgan@gmail.com
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Diksha Kumari <dkdevgan@outlook.com>
Subject: [PATCH] acpi: remove unnecessary paranthesis from return
Date: Sun,  3 Aug 2025 17:08:20 +0530
Message-Id: <20250803113820.16578-1-dikshakdevgan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diksha Kumari <dkdevgan@outlook.com>

checkpatch.pl is generating a warning when return value is
enclosed in paranthesis. Remove the paranthesis to improve
code readability.

Signed-off-by: Diksha Kumari <dkdevgan@outlook.com>
---
 drivers/acpi/acpica/dbconvert.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 8dbab6932049..7995c1578522 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -32,7 +32,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
 	/* Digit must be ascii [0-9a-fA-F] */
 
 	if (!isxdigit(hex_char)) {
-		return (AE_BAD_HEX_CONSTANT);
+		return AE_BAD_HEX_CONSTANT;
 	}
 
 	if (hex_char <= 0x39) {
@@ -42,7 +42,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
 	}
 
 	*return_value = value;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -69,18 +69,18 @@ static acpi_status acpi_db_hex_byte_to_binary(char *hex_byte, u8 *return_value)
 
 	status = acpi_db_hex_char_to_value(hex_byte[0], &local0);
 	if (ACPI_FAILURE(status)) {
-		return (status);
+		return status;
 	}
 
 	/* Low byte */
 
 	status = acpi_db_hex_char_to_value(hex_byte[1], &local1);
 	if (ACPI_FAILURE(status)) {
-		return (status);
+		return status;
 	}
 
 	*return_value = (u8)((local0 << 4) | local1);
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -123,7 +123,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 
 	buffer = ACPI_ALLOCATE(length);
 	if (!buffer) {
-		return (AE_NO_MEMORY);
+		return AE_NO_MEMORY;
 	}
 
 	/* Convert the command line bytes to the buffer */
@@ -132,7 +132,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 		status = acpi_db_hex_byte_to_binary(&string[i], &buffer[j]);
 		if (ACPI_FAILURE(status)) {
 			ACPI_FREE(buffer);
-			return (status);
+			return status;
 		}
 
 		j++;
@@ -145,7 +145,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 	object->type = ACPI_TYPE_BUFFER;
 	object->buffer.pointer = buffer;
 	object->buffer.length = length;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -175,7 +175,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
 	if (!elements)
-		return (AE_NO_MEMORY);
+		return AE_NO_MEMORY;
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
@@ -190,7 +190,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 		if (ACPI_FAILURE(status)) {
 			acpi_db_delete_objects(i + 1, elements);
 			ACPI_FREE(elements);
-			return (status);
+			return status;
 		}
 
 		this = next;
@@ -199,7 +199,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	object->type = ACPI_TYPE_PACKAGE;
 	object->package.count = i;
 	object->package.elements = elements;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -251,7 +251,7 @@ acpi_db_convert_to_object(acpi_object_type type,
 		break;
 	}
 
-	return (status);
+	return status;
 }
 
 /*******************************************************************************
@@ -273,7 +273,7 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *pld_info)
 
 	buffer = ACPI_ALLOCATE_ZEROED(ACPI_PLD_BUFFER_SIZE);
 	if (!buffer) {
-		return (NULL);
+		return NULL;
 	}
 
 	/* First 32 bits */
@@ -331,7 +331,7 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *pld_info)
 		ACPI_MOVE_32_TO_32(&buffer[4], &dword);
 	}
 
-	return (ACPI_CAST_PTR(u8, buffer));
+	return ACPI_CAST_PTR(u8, buffer);
 }
 
 /*******************************************************************************
-- 
2.34.1


