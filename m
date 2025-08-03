Return-Path: <linux-acpi+bounces-15477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528DBB19466
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 17:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23297A23CE
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1897C19E81F;
	Sun,  3 Aug 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7A4rNXB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4019C569;
	Sun,  3 Aug 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754235553; cv=none; b=fnzaMuMlrwUNFf/9DBy756vU6gHaxz6ssTLmeYKx2aVvCY1xeHOxpgkohF4fcp1BfVbDioJiTJZdN+t64VZ156bZ83cTnrWEyIEHVurqdTomKVe2D9VdyvcfPnDLMopkbruGdncCz5pFWXZA79DGDMP8lsr/9+1TUOjLKSCC7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754235553; c=relaxed/simple;
	bh=QnhcH6EmOVfVct7pYcTO7Tgv9reBGW+qWGGn3slLxgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cd7rdeSeLanD2BodJMDIxFlj8dW94PiANhTBk64izAq2h5VVzfQZJXHjXjZCTocDlLdQo8t/WJTG9K/Q6ZlokKniPZlPhIRWsfkeSF3n30vqtzuHlEkhSIE9dMvNhDy1LCy2vBbFehlBKuNpAZx0tW//+qksVCwNcZleHSj1cwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7A4rNXB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bd7676e60so1718425b3a.0;
        Sun, 03 Aug 2025 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754235550; x=1754840350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ij3lZbSxaO2czp7QJ8u/Z0Siwp4mTMeKHEVXbv9xEV8=;
        b=B7A4rNXBKLk+I7z9RGz8EClEPURyD4YNj+aD75141JR5n0oVYmaeyfaJ7WoDmQAvjK
         ThCXV6fLr++JhyY61IVIYMDqyuBB8LATN0HoINbYNdC17fumGwPovEUDqfJ4WyDAIACs
         F8L2aFjwtoxSiqC3rppNw3bY4XAKWgXUt3tiol8zMPA+Tg+GmA8E/l+lW8WtYWKIoDw2
         /P8RqNBao55i96SZP25eOmsbXkbx1hAP8ecgtBS9MGlVgpNPRq7yCFSqn+tmc/85M3w/
         +BbTk1emoZZ/x/QF5QhN081a7oo5SaID0/w3AcR86YWGmKsOM7Wm+uURnjOjcoAAuwlN
         /yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754235550; x=1754840350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ij3lZbSxaO2czp7QJ8u/Z0Siwp4mTMeKHEVXbv9xEV8=;
        b=pZKfyulEAZ6+k3IdK483/bOpn9FBMQJ28aV+ufHOvZJXTgp8yKsVNP+nvV4fHLea5S
         wqrKNNYDs+WpS5Pc2PzNaYhSM7lRhoshY4EtvFXjmma/Ydt+cQHvcpFA0Tok1HqltD4Y
         OtNkSJVdm7deW+E6jAcHbWz1kxpjx0oUQSu5jJ+vwce6HtRGf+oK0XxcRxtHFQqyxlwy
         NL+8qTUhPice9AlwM4OubYWtupspuBJ/y3ZUMgGYXxH1wODtJP93kr57a8h5nyKCS3bu
         XH0GUmufgGGWMA/Z/WRbyr0+3BXeVvnvQwCswOuGYmj5I2+DSmI8BZgWN61J/mAF2R9i
         MZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCUbMelez7si8zxvJSvge7tRln9BbOhkYn3m8hC8RuddRl85j0ZFTsT14QAT8E0yRy1l4Rmykj/66Km/@vger.kernel.org, AJvYcCW9bU5qlSOG2qN5H0BTcymFojHrHLuknmLTQ+HHfsciiWdMCsegbZwcKJI3TO0QbMucNm+aIsMpFMGHWM6n@vger.kernel.org
X-Gm-Message-State: AOJu0YzWP9dR7d03yH222dvbKXYjh0xrr0ao0Y7Wv19TzdTXEmYzogcx
	6YiI/rd9dSBv7B5KheEFuKdL1MfuRyO9ZGFtM4MpY/62/VgSm7Jqlu3C
X-Gm-Gg: ASbGnctVlH2zyJHHlaTILOkse8aj6tW/vCfC2tqL8Z6K+PSyvS3LDq1Sv4LEgbp5PfM
	1omFKCmXFUQCk15im6Kfx8fjSLo+vBYOsuWxFIOndhgY7BmYefn2FonJDnbesGnJ+kHt+lMldKK
	g/37wtS6Rwo9WbsjhXL3nl3c80v873fzOg4VtD3lwiJhjz3xAn6gEs3sAowsCAG7lxkNxnEZPIP
	npyVOug7s73SaIjiz0AVWsOvze68zrymNxKyhbbHUz7P4ELDRBkkwzvzisx4KMHe8TUF6BKcTY+
	XmXGMmFbvEwyiSJdkGFvWD4O3NrWKCqhK0emYlYoOkbyBf2BHCs7c91ajwa2v1UETI4F59RJq7O
	GoqSfp+vE9Q==
X-Google-Smtp-Source: AGHT+IHlv4LdOei1NQjX17HaQo40l3r02Z+8Vmhd8q3LeHn7bo5+nyuKOLMqzXI5mVFrLexVqTtDng==
X-Received: by 2002:a05:6a20:244b:b0:23d:7c59:c7c1 with SMTP id adf61e73a8af0-23df91a0467mr9896065637.44.1754235549756;
        Sun, 03 Aug 2025 08:39:09 -0700 (PDT)
Received: from diksha-pc.. ([49.207.53.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f483sm8382190b3a.31.2025.08.03.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 08:39:09 -0700 (PDT)
From: Diksha Kumari <dikshakdevgan@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de
Cc: Diksha Kumari <dikshakdevgan@gmail.com>
Subject: [PATCH V2] acpi: remove unnecessary parenthesis from return statement
Date: Sun,  3 Aug 2025 21:08:30 +0530
Message-Id: <20250803153829.6545-1-dikshakdevgan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl is generating a warning when return value is enclosed
in parenthesis. Remove the parenthesis to improve code readability.

Signed-off-by: Diksha Kumari <dikshakdevgan@gmail.com>
---
 drivers/acpi/acpica/dbconvert.c | 43 +++++++++++++++------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 8dbab6932049..5f53388b6f1e 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -31,9 +31,8 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
 
 	/* Digit must be ascii [0-9a-fA-F] */
 
-	if (!isxdigit(hex_char)) {
-		return (AE_BAD_HEX_CONSTANT);
-	}
+	if (!isxdigit(hex_char))
+		return AE_BAD_HEX_CONSTANT;
 
 	if (hex_char <= 0x39) {
 		value = (u8)(hex_char - 0x30);
@@ -42,7 +41,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
 	}
 
 	*return_value = value;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -68,19 +67,17 @@ static acpi_status acpi_db_hex_byte_to_binary(char *hex_byte, u8 *return_value)
 	/* High byte */
 
 	status = acpi_db_hex_char_to_value(hex_byte[0], &local0);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
+	if (ACPI_FAILURE(status))
+		return status;
 
 	/* Low byte */
 
 	status = acpi_db_hex_char_to_value(hex_byte[1], &local1);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
+	if (ACPI_FAILURE(status))
+		return status;
 
 	*return_value = (u8)((local0 << 4) | local1);
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -122,9 +119,8 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 	}
 
 	buffer = ACPI_ALLOCATE(length);
-	if (!buffer) {
-		return (AE_NO_MEMORY);
-	}
+	if (!buffer)
+		return AE_NO_MEMORY;
 
 	/* Convert the command line bytes to the buffer */
 
@@ -132,7 +128,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 		status = acpi_db_hex_byte_to_binary(&string[i], &buffer[j]);
 		if (ACPI_FAILURE(status)) {
 			ACPI_FREE(buffer);
-			return (status);
+			return status;
 		}
 
 		j++;
@@ -145,7 +141,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 	object->type = ACPI_TYPE_BUFFER;
 	object->buffer.pointer = buffer;
 	object->buffer.length = length;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -175,7 +171,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
 	if (!elements)
-		return (AE_NO_MEMORY);
+		return AE_NO_MEMORY;
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
@@ -190,7 +186,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 		if (ACPI_FAILURE(status)) {
 			acpi_db_delete_objects(i + 1, elements);
 			ACPI_FREE(elements);
-			return (status);
+			return status;
 		}
 
 		this = next;
@@ -199,7 +195,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	object->type = ACPI_TYPE_PACKAGE;
 	object->package.count = i;
 	object->package.elements = elements;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -251,7 +247,7 @@ acpi_db_convert_to_object(acpi_object_type type,
 		break;
 	}
 
-	return (status);
+	return status;
 }
 
 /*******************************************************************************
@@ -272,9 +268,8 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *pld_info)
 	u32 dword;
 
 	buffer = ACPI_ALLOCATE_ZEROED(ACPI_PLD_BUFFER_SIZE);
-	if (!buffer) {
-		return (NULL);
-	}
+	if (!buffer)
+		return NULL;
 
 	/* First 32 bits */
 
@@ -331,7 +326,7 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *pld_info)
 		ACPI_MOVE_32_TO_32(&buffer[4], &dword);
 	}
 
-	return (ACPI_CAST_PTR(u8, buffer));
+	return ACPI_CAST_PTR(u8, buffer);
 }
 
 /*******************************************************************************
-- 
2.34.1


