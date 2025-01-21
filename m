Return-Path: <linux-acpi+bounces-10781-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD7EA1876C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 22:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D8C3A7ED0
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762B1F868C;
	Tue, 21 Jan 2025 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGR8SPuh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395741F8663;
	Tue, 21 Jan 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495758; cv=none; b=BG3BfQ5kwYl4GS7ynUoJ1at2yIak0Xi1v4KSOI5EkNkPduuT+4sB6aF+EOmY6ElJoN7g1pZoWUuJxIy5zqu7vJjCcqMbpkJcW9gmqW3oOQpggt+mRcQjfNx77wm+T4jgN3I+Dm+S/dD5kgtZ+ZzQVUAdmbZZVGEunYr+y4v0Oo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495758; c=relaxed/simple;
	bh=Nsh6i8wGo75jSznNs+eUKo+N8R7rr+zJF6bdIaqq5Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FazLD4bCeESWkO/vQaE52Xfi546npY0KtdW5zlWITO3vOkiiquxbt1E8q9YQH7CZxTctl6R7Z5F+b2ifa/GCoE5Ky7uVi/a1BOceIQ2Xkw1Y9Voi7FVXrxBkDkpJQlqgRZLpDoYJR2neJXQjC+ePIdTJ6utdPic4A/g4UsacKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGR8SPuh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so43208355e9.1;
        Tue, 21 Jan 2025 13:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737495754; x=1738100554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfWpIO6NyTS+eatKsrL3Z/jOCTpeKZJxG0BULy6Dl7g=;
        b=bGR8SPuhOXS3U9uJzi+RO0L2URYx5Pobw20mdjW+b8EcKx7oqWcU/DcpmhFAbFGqMp
         TRL2z7wIzX/QsQzhznR0ukzLpqWxaWGkU22UXLALnvaxS2OynosYSJFqV06xS0A8GQBP
         2e51qLHb4IeIuh33Z/Hk5vHHpFC+//bBwuRwPUtgJzMf9xf8fuvUpPl1hZzfBfnD5A2F
         UHc1dhW60ej05KCiW43HAG+dkYf+dsfrCdpfGKVaAB6tAYQovzYvVE/OkbJan9lPCUNJ
         13wbJpEVq54rgEr7scm2Mw/JjeWz4mDmotfKEjhzMBPEfwTsdVMBrEU120M8ZBvxvsVB
         b8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495754; x=1738100554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfWpIO6NyTS+eatKsrL3Z/jOCTpeKZJxG0BULy6Dl7g=;
        b=S2QfFwAXlqDpAhuVCnQPcOJsX7IFV8pwVVT1vkcOU5V6DNyrTNDFnmJ1juUF9y0Suv
         gRMtbyAxeI77ZOvYOj5nimAoqh9sgCXjAFCMzqZ0weIV3DKkMQAPKHKXBGHk4UvWGZIX
         +9NfzoM+hqLlaKGMa1uiJ5HN6x4gXQQkpUfEijlEgw02jnM1c9a5uqIgFl1R7dha6pck
         ZhjVBMn8jgvZXYkz4YFN3UPB7e8jX+id/r9T3T+lwNvx9iL8dMS3H51RivMd/cJmkI2n
         pyYwvTW+xt5zBlUpjy/5ErQ0ISb6/dADWnTFvU6QpyAQ9+4Jk9rUzUIK1wCLKQWVr1hj
         atCw==
X-Forwarded-Encrypted: i=1; AJvYcCWcVSufpQjec/22wYzW5qAaWUEF1ABEPZMkU9XWQBxIuDmTEfa2JCZr6rCVVreR4QswrLuPlIBXZJ8WTB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xDrgWu+qOoDINBDVSnWLQ4D3wV9PxHujIkry93RrYBMwsVTj
	5I37GlGC0bEi52xs29M0eb0aCECoUk3XhDwD9CoLobtpKVvgLZolaoNS5A9Y
X-Gm-Gg: ASbGncs74CZEXV+Gq3xdotxCrtMpBeMUyyQuQY+DHJrESnWp9eNIOPDQ2VXf8OKq8eU
	OPo+mMigpScRpIo8BT7ZOx1PcJ1lW0xlz1QUrPl+VhYnj/FZjogOcaJc/q0XduE2aQB3Nd3fIe8
	5zlI6gbG7ai8SYXaQQbB1HuBuopfAuQ2CeWoJbjimySnDgkP196dZiNwl3AioU77YB22SAz63Wf
	xsoNyPqNTGmBuZlc4dMFMIXVlonm9oDY3gEUAR9O8U2WSg7cdGzsYWGburPj+JHDJEr/sWBRq4l
	FJTGmg==
X-Google-Smtp-Source: AGHT+IGsoKIxtfWaKZzRFwaLbVURNNmNg4OSmjLFjOXCelq3CFd77mN4PnKPfUdQia87Fd6q6E7yQQ==
X-Received: by 2002:a05:600c:138f:b0:436:ed50:4f8a with SMTP id 5b1f17b1804b1-438913caeb9mr200933955e9.10.1737495754229;
        Tue, 21 Jan 2025 13:42:34 -0800 (PST)
Received: from azathoth.suse.cz ([45.250.247.107])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43890408a66sm196898465e9.5.2025.01.21.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:42:34 -0800 (PST)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: ardb@kernel.org,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ACPI: Fix building with GCC 15
Date: Wed, 22 Jan 2025 03:12:19 +0530
Message-ID: <20250121214219.1455896-1-brahmajit.xyz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building with GCC 15 results in the following build error:

...
  CC      drivers/acpi/tables.o
In file included from ./include/acpi/actbl.h:371,
                 from ./include/acpi/acpi.h:26,
                 from ./include/linux/acpi.h:26,
                 from drivers/acpi/tables.c:19:
./include/acpi/actbl1.h:30:33: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   30 | #define ACPI_SIG_BERT           "BERT"  /* Boot Error Record Table */
      |                                 ^~~~~~
drivers/acpi/tables.c:400:9: note: in expansion of macro ‘ACPI_SIG_BERT’
  400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
      |         ^~~~~~~~~~~~~
./include/acpi/actbl1.h:31:33: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   31 | #define ACPI_SIG_BGRT           "BGRT"  /* Boot Graphics Resource Table */
      |                                 ^~~~~~
drivers/acpi/tables.c:400:24: note: in expansion of macro ‘ACPI_SIG_BGRT’
  400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
      |                        ^~~~~~~~~~~~~
./include/acpi/actbl1.h:34:33: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   34 | #define ACPI_SIG_CPEP           "CPEP"  /* Corrected Platform Error Polling table */
...

This is due to GCC having enabled
-Werror=unterminated-string-initialization[0] by default. To work around
this build time error we're modifying the size of table_sigs from
table_sigs[][ACPI_NAMESEG_SIZE] to table_sigs[][ACPI_NAMESEG_SIZE + 1].
This ensures space for NUL, thus satisfying GCC.

[0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 9e1b01c35070..5a6524eb79d8 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -396,7 +396,7 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
 }
 
 /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
-static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
+static const char table_sigs[][ACPI_NAMESEG_SIZE + 1] __initconst = {
 	ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
 	ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
 	ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
-- 
2.48.1


