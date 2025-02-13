Return-Path: <linux-acpi+bounces-11154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A5A34D5A
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 19:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715353ABA61
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660AB241690;
	Thu, 13 Feb 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYufC8Wn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003F24167D;
	Thu, 13 Feb 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470602; cv=none; b=grOYOKo7PJcW9EGs0hPD3qMCajqyfudRv4PaK+aRjZ4lAOSy7LBPyobpyerHNz0t5ANB5C8dXK3w9y9oLxCMdeiD6PfxMNJHoUWyc5qeETFObOArE/vO6EFy1riUYOoUnrtZdsXJITqEz5cnqXzXuQU0CgkT2giNxwp1PQke9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470602; c=relaxed/simple;
	bh=L0OREqdY+y/o1a+FBGpKuy/3qSthMcAa/bxvgooC9bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8b8lAu5AnQzlW3Q7qcju3laytBfuilR33yEZl7rI6A0qWTdxZYpOIXHVpOXWA89ToFdwDtLKl5c7dY5i4d8fb2Bniw8aB1jYWCYJ+ziD+CILFT4HSkiblspVX0ly59aaMg5AtQ2BL8HmbRT10RoxPBfalILUp1iRfE5JL5K3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYufC8Wn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43963935585so9185345e9.0;
        Thu, 13 Feb 2025 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739470599; x=1740075399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1cwn72nFWVMoRcX7Ta6FaedrWfQ45c684gfv/c7Ix0=;
        b=GYufC8WnuVXnLuHMu3vslzfUJ+Jkag7INHWcK99AlGV7Ge+/39eUJtpJhGt3Yk2+gO
         GSnA5eoAHGrIpVX+wgtCJqAP4k6JaaR7bLomAgT2b69HxyFy5OYAfOs0u4Vjxa/AA57Z
         /SnxceRCMNk/RLhYImIBRPp9iPWmKe5DIYnnbSnqgf7q2u73Y8G51HOS7oyVhfAZeAVm
         Px1bmIr0yyXoaa04of9Xtbgy0rpCY6G9iWL6IrnAiRAFWwcsZsadYE6iVZb6uUvOOn+D
         50dPxq2tK7UMIUTNXFADljxC/ksC4wAzrr3OmBcOEg/0j8JJFN/zI6+/TxTuY9noi/uJ
         A2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470599; x=1740075399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1cwn72nFWVMoRcX7Ta6FaedrWfQ45c684gfv/c7Ix0=;
        b=wE8D9OoG72AU6/vVZEgygkdHh3xOIdu4rhIGnCMrdggmTK/spq/Fi5fNBJD3+hUbb7
         S7ENzHa/MELjt1wJ9Kk64C9+bIQq45KA+5JYaQLVqr7oV6H1wvnZn5dzJ2klUd7wCoc3
         VLn4RqAiokP3KOUYEqvckAVwLBeq8fZPcIVJsap7VOx2ieonNq3ObW45T6f9kARFEaVa
         a3LRRslReYy3BtycxqKDP5uW5BnLwdMwI1ck79FhuY8MMW1cPpbsjOTRmB30tBoNjTKi
         l5Jw7KgcwDCLGDorYX570MOecMmZsF8ukVS/vBzmeaWHtYwE2bzQJbs5ZeJkY30tR233
         HeSw==
X-Forwarded-Encrypted: i=1; AJvYcCVUUiFDNTtNOt3RfJDASTAwHBp/XWugFByoYRf4JLXeQttg1Ah6wkKXfz4WorXoWILg3A09wkKJwdts@vger.kernel.org
X-Gm-Message-State: AOJu0Yy969Y3Fm2zIrwdeciIutopYH2l/90/UoFiyOfOdSEAr3fJemaQ
	UuND/WxD2C6ve6BTKvrusb3dJPvR/vJZgJTVxHVr4rQ81vgx0/86
X-Gm-Gg: ASbGncvLsV+rRP/DEazgg4Q+Y+m/mSLk9AENsLWgRJ92fS56wR/voMj2Klfg9fAUhws
	rsayUxO69qD+D4XEsyuymj5j5QHeZMlea2lMOSYBgr4jFNlMauj0hN7rO+3UyhLMCGDt0V6IGXC
	R/VRx19RDUCR6PQWNKhlqOhELyE/RnP6uz4vBwBbTcCXWz8pptH1VWHor39u3kUFb5ikmO1cNcC
	gdcZAbav3AU6RnrnxIx0ishe+Z4+B1H5Z4g52bUHRkIxWBPry6garLFrLO8lbYQC5BZFi4ju2Wq
	Wc/Fui8Lfn7FT7Gd
X-Google-Smtp-Source: AGHT+IEs+27ELYHrFDfK8te2RTx1vST5AAiOB5rfr5KnwDnwxj6fjZdgNLHnRRECdTI/Pr+TlHj/Aw==
X-Received: by 2002:a05:600c:4509:b0:439:5590:6d2f with SMTP id 5b1f17b1804b1-4395817aa0cmr107359355e9.12.1739470598462;
        Thu, 13 Feb 2025 10:16:38 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439618264a3sm24065575e9.23.2025.02.13.10.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:16:38 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: OSL: ratelimit ACPICA kernel messages
Date: Thu, 13 Feb 2025 18:16:10 +0000
Message-ID: <20250213181610.718343-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In cases where the ACPI AML contains errors there can be quite a large
amount of ACPICA kernel log spamming. Reduce this by rate limiting
the messages.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/acpi/osl.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5ff343096ece..d4ece68e0fd6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -159,17 +159,21 @@ void __printf(1, 0) acpi_os_vprintf(const char *fmt, va_list args)
 	if (acpi_in_debugger) {
 		kdb_printf("%s", buffer);
 	} else {
-		if (printk_get_level(buffer))
-			printk("%s", buffer);
-		else
-			printk(KERN_CONT "%s", buffer);
+		if (printk_ratelimit()) {
+			if (printk_get_level(buffer))
+				printk("%s", buffer);
+			else
+				printk(KERN_CONT "%s", buffer);
+		}
 	}
 #else
 	if (acpi_debugger_write_log(buffer) < 0) {
-		if (printk_get_level(buffer))
-			printk("%s", buffer);
-		else
-			printk(KERN_CONT "%s", buffer);
+		if (printk_ratelimit()) {
+			if (printk_get_level(buffer))
+				printk("%s", buffer);
+			else
+				printk(KERN_CONT "%s", buffer);
+		}
 	}
 #endif
 }
-- 
2.47.2


