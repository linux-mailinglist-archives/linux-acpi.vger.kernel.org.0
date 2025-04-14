Return-Path: <linux-acpi+bounces-13002-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC469A87917
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F42189307D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 07:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C076270ED4;
	Mon, 14 Apr 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH4fpj3G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4E265CBC;
	Mon, 14 Apr 2025 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616140; cv=none; b=Xng5OphEDuX68J3J/6W+zMO3FCAev/KnhY6fhWC6+6uE0tiaa1CxM1fFUISLgUGYRUsazufhHJcsdbGkIK88wqPbg5HmWzLIdX22epBCTrZ62tHY8dHOIzUFvAT5D9leTCJX7E3SP5Uzb+M/iLkfYKGFS6n7Lo9eDiPe3NhoI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616140; c=relaxed/simple;
	bh=KTe3uWaWlgANscop60ILOfJGk6PaXW06xvdFjDJSwTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DDQ3t84/JrkxeR415gNKJgfpd8+SEY07UXFaJs6VwM6nn9heJjCEr7bv/JcoYT3/PWTiGo1h0R9b2+1DBZyuQTpqUx5ulTIIw+9b9x1Ch+eqnn0vy74w5S5hcC2Q9mFMbqtt6TXYhEAWUTuZJa3/CS+qg+tbyNWQ6ic6gIgScPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH4fpj3G; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso3707201b3a.2;
        Mon, 14 Apr 2025 00:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744616138; x=1745220938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWQtHqSbTf9NzEXG3WeHgoYFaTCv1grfOd+Mceut8xA=;
        b=gH4fpj3GJaXEszXKxhKLCVb185enWmE8XDBPp8ClUPxeY1F84Z3puXdwu7GjrqXy0e
         yrNNRLOG5gqr9g/EAdNZ33Ss4m/5eaSkZU4LyQWTNIpPwM02Nqvki36HpmBWFpD+aT7j
         ev/+QFRRmm72hhw5W61zf1fuSNs9JBA3grGBgOdUWzGRrIg4x0SDAzixgOt+JyOZMPS7
         hb98zG1XMVXPlpPuclHxD/GmnioPlMkTi8//S97r3JxV3NfxherFwCHyiXKar/yo2I2x
         wSACgfGoYAcA6CuGIg3Ub+91iIi1HjVjDWTTXrL3O/6RTffSn2EPcuI+Ri5Ic135RjQs
         frQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744616138; x=1745220938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWQtHqSbTf9NzEXG3WeHgoYFaTCv1grfOd+Mceut8xA=;
        b=JSX0NgN3Bq58DxFzZ0MHw2NDljRN0f4ejQiI6/vrZ5LsVKc5xRlFkI8YTlRO1HKSHn
         iYR1fEE8uI5eayacvOg6JzfMyUlvA4HA8gFFtL1uv7JXwuwlGmb4cdhPuFedjNQy3Js/
         aKF++wIeMUKTDc3ktEI+1siMb4R9eVqPAwReddqs4MVzG68ABDyonkXnQ1OUDmi7mfZM
         DOmqYvQEgctrLsmKRfujb1mrjDcTF7Vld8C8GeHmqVhv7onIBAH6QZFOqXXoI3g/Lh88
         5NOzmv1QXH497lrATDjW67SmOKJ1h3H9bsOL/ICT24X5rZrhAJ2nWl+fr+TPaT9/5nzl
         s19g==
X-Forwarded-Encrypted: i=1; AJvYcCUhb9b+0mmPB970wTLOK3DbR3Ms70xFBpBoIOOMALXMLL+s5IHnkFNS+RygXdYTx4dPzl3k3EkKUpgnOH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvwh1QsXlWsNU7VR/Et3rb4w2IGbLBbCz0dLILRfi/91tEGPaD
	5xQo/TibredCDVHFUixP41tkgdjzDGO7ePf9IoC0CPiojDzpj/RSL8jGHNZizwc=
X-Gm-Gg: ASbGncuSZrGS3q7ruVBwxT8lISkeq9DvcDMipMkOD497TxdubFjww575tv89rGv9Sd2
	PxFLx6m73WXZb4BkD29V4+x9G6IYYRrygBezytMaVLHnKGkAFo0g/RccpueSnFtoV/A2Eui3aVM
	AdXe8SaM5nYb7Qoptwvt63Kry7eG7pbIQjkVeONsyiOg2jwo50XuaUR/FQ/oMVLTM2E8gFynEIj
	utI7vVLmP0tmqrSgg5HjwdKamkpoK166ATu5RgMsx4dSiszzPfI39Z8D2PpEcY8XvG9zm7Uxfc6
	5D6GUE1tu6UubdoV4PDM33Sp6sZNMNNmmHtbSjXiW7jQckiI3OwTGLl76new
X-Google-Smtp-Source: AGHT+IE3VhdggcNXYAgq0b6PYooX5zuI2ynpcIPLIPK5E38pSNyG5MDqPQafDO4ubU5wA1GBOa1Txw==
X-Received: by 2002:a05:6a21:9012:b0:1f5:59e5:8ade with SMTP id adf61e73a8af0-2017996f6c8mr17350608637.29.1744616137864;
        Mon, 14 Apr 2025 00:35:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c408:a0b5:82a7:fae4:9cf0:3b75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0830418644sm1615915a12.39.2025.04.14.00.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 00:35:37 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kevinpaul468@gmail.com
Subject: [PATCH] acpica: Removing deprecated strncpy()
Date: Mon, 14 Apr 2025 13:05:17 +0530
Message-Id: <20250414073517.57745-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch suggests the replacement of strncpy with strscpy
as per Documentation/process/deprecated.
The strncpy() fails to guarantee NULL termination,
The function adds zero pads which isn't really convenient for short strings
as it may cause performance issues.

strscpy() is a preferred replacement because
it overcomes the limitations of strncpy mentioned above.

Compile Tested

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 drivers/acpi/acpica/exconvrt.c | 2 +-
 drivers/acpi/acpica/tbfind.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index bb1be42daee1..648e68a31e1f 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -226,7 +226,7 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
 		/* Copy the string to the buffer */
 
 		new_buf = return_desc->buffer.pointer;
-		strncpy((char *)new_buf, (char *)obj_desc->string.pointer,
+		strscpy((char *)new_buf, (char *)obj_desc->string.pointer,
 			obj_desc->string.length);
 		break;
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1c1b2e284bd9..5536d1755188 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	strscpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	strscpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
 	/* Search for the table */
 
-- 
2.39.5


