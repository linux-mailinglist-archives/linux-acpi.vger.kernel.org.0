Return-Path: <linux-acpi+bounces-15521-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B5B1A951
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 20:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6050462154D
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9528507D;
	Mon,  4 Aug 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1bcNxz0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF302253EE;
	Mon,  4 Aug 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333948; cv=none; b=NzrU043UsezqGixFPGt3UZYAjSKrQDYn9g25mtb1TOPZYV2jllYYSfRx5gbrJxHHYgiKddnxCFG9yS/UnOReaZNqi+C/ze5DTr9HrEiUo12fVevsI3N5HX5KK/2PgjMbFOJ82xd80IANAQp7EHMrOBS9GEPSjVWDePgBX1/U7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333948; c=relaxed/simple;
	bh=cEmRum5XYAzlQ9YsYVZG/YOXocwoC+rRSdZyIJuBJ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BLa/Mmw/28dnKsepG7BMGhZLcNIq2xxkCgqBeedyL7k1fxHkO6a1oZHzI5Z1Cb7GD6sxkQg2tiT28dk99f5TJ+442R4wxHa4X6Q1RutHP6zkP9W+g4BWg5Z/F3WzN/noR2X9pa/nthwY0zg/5KuWl2PfmjreMqMSii3IJKnAyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1bcNxz0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23fc5aedaf0so33158545ad.2;
        Mon, 04 Aug 2025 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754333946; x=1754938746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMHrDBTVCapZN4Ij1l4T90M7GkuqWi+q6Y/GUZJOE5A=;
        b=P1bcNxz0lMSA1cAPw2zWL97OhShj/6Qwzypski3ehoQZ+gIsI6UVST0FMjuu4P7oQ7
         Py5KjdR80MUIHjWQlcI8RXyGfGtst537IjWZuNeCC5n6JHoJO/y1dmWf/An4H4+Oc1T7
         ev0JB+B4ua26HJHeXS3xu9bkYxc7gV2wJgOCSPALTBwB2FLqiHUllIJJL3Pq3D3X3hkj
         3L62D0Oyw2+Zd4ku5iTOsupa1Zj2M9mwHgunpLxth673wbWJogi/QJjweeDEVq2bmkTZ
         XY2Yj4lsXPEcJt4cBbVPkYgNDGCxmrJfNVCAo2jVAWqc7sNARtHDn0sPJJ4zvYwe/3gy
         carA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754333946; x=1754938746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMHrDBTVCapZN4Ij1l4T90M7GkuqWi+q6Y/GUZJOE5A=;
        b=N/w5Vi7Bf6gyQw2QGEiusjTivw3Ur+OeVk5zkNgXg6bYTaICQntjS9rF7FkHyTh8fu
         1stZkzjTHXTbxxWqOIEwlZCoJTKVNAQKbe6aIRlS1ZEzvg1KI51qKW0uqa3sL2PEDaVT
         XV6gH6cyzQP/d2vNeeNMJxeonc0e3gUArp7cbaS5fpUEf75AXRC9yvsvm8DWbvRE+loz
         B3UTqQZFpKU4C5b87EIEpfxbRQKdjphG+GwWURNctVP+4lDLc+msra9JPPBSgw4Q5a5R
         3QGGE3Cw23JVDMKh2cG5MHOwkTE7iWCgsY7wkPLBliAJwynsmpTt1o3v3kf+8K9/iIms
         Y77g==
X-Forwarded-Encrypted: i=1; AJvYcCV+QnWwp3sQgCGRmLrqRPslcQu3Y9REzp+YKbwnRJylXS8VORS5ArTC+1khJAVtvEBcQ2ApbL9Hp+Cr@vger.kernel.org, AJvYcCXngoW6oIWad/OkNN1E7GmM54es5kx61PQT0Y3jR9tf/FbPJGz+vbhAlk47d7PS1icxDUZg6U6im9zRIlb2@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKQEEF9vQ7vmQmbLBIofSJvjB5wUoaV058HJWntLieIiZFQN3
	ZssJmIStKG7gcdrRgsvHpUTGF5GZIjLy6D2d05cW6Y+usEpWniyJuPOb
X-Gm-Gg: ASbGncsUSWng/SBTlyppjZ3Edp4Z0JezjQIQ9afbEIzg0QrBcSHR9Ri70Mx2SWuhpa7
	HYrJ+JxRFw+oed2vTNOV1jZL6LiMsyUTKSTHJJtJe5BMYnx3R77pNFmJ6U0BIbkVl5TO+BoUjjF
	7pSYzX2NMaLL9KHNVOx+UGbs+gt3/RwP+wVhm+ejqTn7d0/QtJEZktYpze4Tf111OvCHBunXiMj
	Uc41rgqUtIYCRFY2I0YNOzKSk3w2FPdDj7c9BvPCIEpQzcqcwy2sDnblXAEYFuZ2rzsepJb0Vc+
	Qsfu5CQ0NXpWGwdrmfinxggxUoRPYFpEdQHU+U8bWa31XOwL3aCnQbIWHDKKN22eESTfL7it8m1
	/jPTvZmuv5+fTSCE=
X-Google-Smtp-Source: AGHT+IEOnucQk03b0U4cuDeXdIZDNb3Av5jSWL1ukaJL0ECYCD8PzJA4YIhmCdjbvBLf0PScyJPtrQ==
X-Received: by 2002:a17:903:2d1:b0:23f:d8e4:ded2 with SMTP id d9443c01a7336-24247066a0fmr142738105ad.53.1754333946401;
        Mon, 04 Aug 2025 11:59:06 -0700 (PDT)
Received: from diksha-pc.. ([2401:4900:1f27:8800:4f4d:8f79:7e46:47aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976d13sm115046835ad.109.2025.08.04.11.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:59:06 -0700 (PDT)
From: Diksha Kumari <dikshakdevgan@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de
Cc: Diksha Kumari <dikshakdevgan@gmail.com>
Subject: [PATCH V3] acpi: remove unnecessary return parentheses and conditional braces
Date: Tue,  5 Aug 2025 00:28:26 +0530
Message-Id: <20250804185826.29723-1-dikshakdevgan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes unnecessary parentheses around return values and curly braces from single-statement conditionals.
Curly braces are removed only from conditionals that are directly related to the return statements being cleaned up.
Other instances of one-line conditionals remain unchanged to limit the scope of this patch.

These changes address checkpatch.pl warnings and improve code readability.

v3:
- Updated commit message

v2:
- Addressed review comments
- Updated commit message

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


