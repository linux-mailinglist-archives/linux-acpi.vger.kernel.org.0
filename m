Return-Path: <linux-acpi+bounces-17130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EFFB8812D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 09:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EA43A4397
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 07:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C02BE7B5;
	Fri, 19 Sep 2025 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqI6tNjO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C02BEC3A
	for <linux-acpi@vger.kernel.org>; Fri, 19 Sep 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265209; cv=none; b=mUXA5nhs8ve1Gy44MQ409omI2LdHmq4fkZno+dewubTwoaMmfolc/1TZA0jqjsJ6POtcyeSa198EBP/IcmlyLMehBIesKjNkg5Jg9wMDVLOq5usfm11rtbbGwPYGbHixOgvNEpjCkhCy1Tv3hxLkRdbhlAskPEU47wUVhm0FN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265209; c=relaxed/simple;
	bh=uAk+KA/2arGgRYi6RKljz+pNp4Iu/ABT1xGE3Hki/kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiGhHum/3TtzmTmb6tF1rkmtcJLPpwQcfieQQSMJ9eEWDRB8lR4nOXGsDVXs4mxVTmptOGsdinjSW4M7x/BgxliIyhWVAXBgy7vz+2r7r0fzzNlGxbyoy5xLeoBDPENWBm9HqpqJdZ+3vGYb+VLc0GS/+k7ed3Kj/WZjsapk1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqI6tNjO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77615d6af4fso2589843b3a.3
        for <linux-acpi@vger.kernel.org>; Fri, 19 Sep 2025 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758265201; x=1758870001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqB+YMZcuLYAs8+OHarhQxNJf94rd8pAU5DBCBmw7lU=;
        b=PqI6tNjOWce3MJsbjzGtyDHkksJ0/LkABbBStkw/InSXyyhJo64aF3FiZjAZmBv2Av
         j2j9ThiMZg/HmpDZJiHqJURSblgvgaAonZz8uUWGjRP0r99XCLY6y/gQfHGsIXuER3WU
         9w+CSbJ5bYB48lHdQ3VlmSIUsKZs609zeQuDvDQHk3fCcHwhSte5cXtFg+U1d1/p/wGm
         77qxX4jMZVAmplZA7EDdQBo+f4cDpgNfc+MvRquUl1dvbHa5VkArHg6h8yHg7XUOxUP6
         +aWqH4VjoDyUSqqqjB0iiGukmm9+ie8I9+uOu1EH5MTAVdij5EMe8ki3GzJQO8SBk30e
         DWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265201; x=1758870001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqB+YMZcuLYAs8+OHarhQxNJf94rd8pAU5DBCBmw7lU=;
        b=K7iMLyEtIakQalAtC7q6VINyAPx75qO/FTHvYLtNXjqGlEOuMxkoTa5v1/QKf6XR9K
         MvzHgtIJmd62JpdhRnSkiha3IKRay+NVlTwyUrNhvu1baUDxFuI3Ljnp828ranm35RQe
         wsC76oYlpFcAPYeWccTavR78GiDY5zxqqHNbNJHQ0/NTkWi5g8PWnTM4eP8y2M21M8eQ
         duiMQF+8DoXnbSg21qCaXFA0MJ5ze1brmu+QBRSmHuywYo6s4jKebgzzlewEmBRK1Gri
         U/P4SAOxEJM6imiCLZgZa+laW9vbOZCGwYP5rBZewxIIe3P72d4U8Ulc01Xyyd8LSO4I
         J1VA==
X-Forwarded-Encrypted: i=1; AJvYcCVGWuERGL0/lThESZ4M2S0QK1TnCKK5VXqS0ZZH4f25U7Rim9MURpttcoMmnyXOhbtzLPJxSQ1dsznG@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQ7FugD/ly2UWL+FgiFYbOHMs4+mQGhtOORxavOuA0FIz7H1+
	CNomHvdVJhl7auZkRPyijBXfNYIGAJvrrnPFThA4nuOXGzk1xn6IAo7v
X-Gm-Gg: ASbGncsB6V16GlKRw3152rxSyHyf3+wpFUln5pCnazHEUz3iZOAmrfi+t0cMMKVC/XH
	0NCnLHAy0nYe55UEW5rnRwZBJuUI+KZ8p682vzWVLKL9qg/BhrdWRylFFZeFOOcjUA8woWEAimg
	Dz/2EWa+afdm+/n7q8Zjq3EGozXEQLtsmYzNm6L49VwaRlI3lwz5sJEIP09VPJKO2SBIVdeq64u
	GBNp1w4/Z0Z/ZuPtURPXPpPCEhfo0/ef8bOPsM+W2P6qEj1yxNCvlsByeLQfzBp01is4ndYwg/N
	dIf8z5pskDwGjnjs8m44g0JxMMSdfVlQs7eVGmK9bFnF6kp+b1IVovBONirRRMKJF6U68/ouU97
	NVznv3Wl2A3qMuX++I6dGC/euUQ==
X-Google-Smtp-Source: AGHT+IGRyWOudoRi9Tem9txO7j0k6xxGJSz/N2dM0RUuqwAkPE1QePAX965M+SCjwpij//u2J7rKzg==
X-Received: by 2002:a05:6a00:4b55:b0:776:1a2a:6baf with SMTP id d2e1a72fcca58-77e4f19fe23mr2906611b3a.32.1758265200897;
        Fri, 19 Sep 2025 00:00:00 -0700 (PDT)
Received: from archlinux ([103.105.227.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e87fb4698sm782455b3a.96.2025.09.18.23.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 23:59:59 -0700 (PDT)
From: Harishankar <harishankarpp7@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	harishankarpp7@gmail.com
Subject: [PATCH] ACPI: property: fix spacing around colon in pointer macros
Date: Fri, 19 Sep 2025 12:29:51 +0530
Message-ID: <20250919065951.156362-1-harishankarpp7@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix coding style issues reported by checkpatch.pl in
drivers/acpi/property.c. The colons following pointer
types in macros were missing the required surrounding
spaces.

This change makes the code consistent with the Linux
kernel coding style guidelines.

Signed-off-by: Harishankar <harishankarpp7@gmail.com>
---
 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 436019d96..8905a8b34 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1108,10 +1108,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 				break;					\
 			}						\
 			if (__items[i].integer.value > _Generic(__val,	\
-								u8 *: U8_MAX, \
-								u16 *: U16_MAX, \
-								u32 *: U32_MAX, \
-								u64 *: U64_MAX)) { \
+								u8  * : U8_MAX, \
+								u16 * : U16_MAX, \
+								u32 * : U32_MAX, \
+								u64 * : U64_MAX)) { \
 				ret = -EOVERFLOW;			\
 				break;					\
 			}						\
-- 
2.51.0


