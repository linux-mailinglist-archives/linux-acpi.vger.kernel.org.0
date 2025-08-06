Return-Path: <linux-acpi+bounces-15553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65DB1CC77
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 21:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735ED56474A
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67429E0F2;
	Wed,  6 Aug 2025 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm0PPXII"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2985215F6C;
	Wed,  6 Aug 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508170; cv=none; b=RCJZq/gSTr754Eur4wuSXTPa2K+JRL94cF8BKZV7UUkOtLC2nY41zffotSM1rnu/L55CFesdBf0ce5BgJfD41srcwBVf15/2ZFwpmJqv5igic/Om3bu7sJ0Zp6L3WqnyYI0ZA8IEone6/bj9AM7Sqfrhe9Xl8f4vZwRQ0nW9kME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508170; c=relaxed/simple;
	bh=0Smmvk7/7PBIfJOmFbelMA4iOxCor7rfdYx7f5lWz+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f2KIzGMgd0qqhCLAGsOswD4sjGCgBieS7o0nifOr/X4P7/OR1y4qWt7zNpo0iiM+m8pYQCb1GIKDB50UbUmFGcNLLSzC4fxDX7362IScC+yQ9sBhEiiLxwevFVIfF9ybwUobGF5OH6ITXde8i+ZC2J4E7LSD4EaEwAaLF3CLe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gm0PPXII; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bfabdbef5so310635b3a.1;
        Wed, 06 Aug 2025 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754508168; x=1755112968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4AyOWdEDqjQgldlgukYNr30YcKFtHC6pdaPLRv6HM7w=;
        b=Gm0PPXIIASrJtii5dDIUrU4sXz9qVjI+zj8HKS03FlGvHRX9CtUWoYYqtjZliwYsET
         6qU1pvUc9VjEo2R6hsVHHpmnYxTeG1qDetDnUQYpvJIFw2axbl7kvkCxqBrcdwGmbmai
         lwi51HV4RZaabKM4IeadyCFIu/+lyPMlX+uJCiW25SLVNHoOSYs4dE8PquL1eWqyAam1
         eBIeASoPUfPahBnOXiN43DnR7oEih107VZwW/yce683kkjnxgNfNL8daZYIK3VG3LcaS
         L22MU9ggV3izjrAV3x+jpgoLwxY4PTRzctq4gXE4deSpJt1LJ121faOqDEMk3oTer0tI
         909g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754508168; x=1755112968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AyOWdEDqjQgldlgukYNr30YcKFtHC6pdaPLRv6HM7w=;
        b=f49WJzf7TqPHxbaDlVYAodWH0ZX4vVAJZHabfjE7ap4tW8D/mAQ6TXdJi0ZYeACwT3
         eb6kwIKgma88BCXRJY88ggztsdPGRzL4ZiUJOymFu1DZqQpZmWrrl80fEcriY09Lm3O+
         Bsffvr8O/r1UcXmaZmFfiRmh9xpP12owvYw4JVpCqT02yaCBVEFWOyyAmcI954TMHwoo
         kP1lro3+rFAZdgeORypVIEV4Q/lcS9tgKDz78O7j1GCxe4XMoArnPYtjZJpZJ6nDwjQj
         BC7ALrXtopqWbfVpqOJkSOrLxncnfzOuI5zNKOOg1kmWFns5LqD4a9GfSlOnFR2bnAI6
         Aq8A==
X-Forwarded-Encrypted: i=1; AJvYcCU0xThyLKeHyFEfYaxZSMpVvEMDF0g281/Jw5lZPpvjff7ziyrbUdFLW7LgG8lnz00/c5sB9ejqxRIKR0QQ@vger.kernel.org, AJvYcCUT+/hC0Zum3o8XvkgcTpug+qiP8r7+gY9NZZdsU+VYXHvQuqErjxmam0vJZJ1/4ITxcsTtSo22mKii@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0/jZ8rpSyA7F9FMB8bLQm/xI9l33QTFGDy+BaxBIQOEZj/gl
	zugvElZ1CA1hAclO3WCUlWopOK5JVMS182QdS4t38BEqonk0xwQ4jhHK
X-Gm-Gg: ASbGncskcjkuUVGxWXEUxgDQPEFoAPnBCHGnsAjhpbfao/n3Eb/HP+gMmvLMjf8LgpZ
	nligCAWLb4t5fAUjX1JgJfmytgVbsgQLQUJxYbflToed15oDA+HrL/WIsAnxIKwtCoamQje6Ff9
	e5SnBrjAdSPp0Y+rN5E2MXduZ0u0LeGIHjtqmOLF/mUcfjF9fNB8acZhNWrk8H9L/vpXKwUx3s2
	MPGy3tS6OA2x0UaMKeh08lAsZDi423XQhq89JaCO380/Y25ZeshBS1xk1+q8RoOLZqQGtKPZhje
	2PqQndCL4319P1RKUmvfOVBkqOLCia0ciAvPGCTpsB7J/AiyG0JNpBmTc/iRgFQmJC6e2Vmxqxw
	1XbDxDYkCxUFXca3nMqt0OLoc+jVQLcfyg5RrMw2o
X-Google-Smtp-Source: AGHT+IF6JEuKE3Jn3aX/UVQAo0grixOintA1fW1G8ukMtbQ142BQH0FQqo5RG9vdd72dWReaWCJnvQ==
X-Received: by 2002:a05:6a21:6d85:b0:240:21e1:cbbd with SMTP id adf61e73a8af0-24031455135mr6502150637.26.1754508167931;
        Wed, 06 Aug 2025 12:22:47 -0700 (PDT)
Received: from diksha-pc.. ([2401:4900:1f27:8350:374b:b9dd:a07b:cf15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd1d4e312sm15528619b3a.17.2025.08.06.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 12:22:47 -0700 (PDT)
From: Diksha Kumari <dikshakdevgan@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de
Cc: Diksha Kumari <dikshakdevgan@gmail.com>
Subject: [PATCH v4] acpi: remove unnecessary return parentheses and conditional braces
Date: Thu,  7 Aug 2025 00:52:40 +0530
Message-Id: <20250806192240.31849-1-dikshakdevgan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove unnecessary parentheses around return values and curly braces from
single-statement conditionals. Curly braces are removed only from
conditionals that are directly related to the return statements being
cleaned up. Other instances of one-line conditionals remain unchanged to
limit the scope of this patch. These changes address checkpatch.pl
warnings and improve code readability.

Signed-off-by: Diksha Kumari <dikshakdevgan@gmail.com>
---
V3 -> V4: Corrected commit message and patch format
V2 -> V3: Updated commit message and added changelogs
V1 -> V2: Addressed review comments and updated commit message

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


