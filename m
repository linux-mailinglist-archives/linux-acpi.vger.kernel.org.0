Return-Path: <linux-acpi+bounces-6738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC727923E43
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 15:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7212823F9
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EC516EB6A;
	Tue,  2 Jul 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fusetak.com header.i=@fusetak.com header.b="Of8YU+EF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D916D316
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jul 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925211; cv=none; b=sFdx8O9Lqm6iTs7qzMDYiAoLe70tnaNJkIFP3YIqKJLmZcl0ME6+ZWD6F7ZBP1v1gZROICb/8D3VgSajvML3pcREogkeICft/GzxynXkFD/b3qe2dLZbyRztntBqoIUyO4Pdb/NLidWhW7GYN8lUfYk6CJFhHra8i7OJHGrIqTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925211; c=relaxed/simple;
	bh=6cW1OOupuN0t4GT+kU86RYQiWiaMVegwZV8ABdLxQTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbzX8LUjzvDMMoUIT1HmLHzVjDEZ/o1F/EN20zE3FrSXKO4Cinq7SSpweXv++gsPyhe8/UFcJ3oHAOF932swkaoTtAsSAdcpHhQUoJLMh66dxAjvApwo7R4LDlVTwM8Ht9gHDNMXvtjsKfhlr+0z0YBNsvew58FgYcvfSaaorHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fusetak.com; spf=pass smtp.mailfrom=fusetak.com; dkim=pass (2048-bit key) header.d=fusetak.com header.i=@fusetak.com header.b=Of8YU+EF; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fusetak.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fusetak.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79c03dbddb8so392715285a.1
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jul 2024 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fusetak.com; s=google; t=1719925208; x=1720530008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kb47TtTb9W9xZLtu/KLNSD3b7BbY25Ysou+rBKGBTNc=;
        b=Of8YU+EF7SKawwTmqmiSvzCpcCqhzsDaOsMyHMpof7bgrBEUblUAisOoQoBWnv9tKT
         r9g21ExemsU+EHLkZDQo47uCCaNQVj6UcsjQLY11MBNJ/JlPPw/zccC1LUKFU4FcZ4i0
         iLtt1+Qom3G23x8mB2ShSakH5k23EYRnVVoGAwq2fmi/uFlCqoO8cm5eoc7T73uLJf2f
         FFuT8WJj7PMDGLmeXkzyb4gXHBZTMigLTmOuy9TyP0odkrOTtF9Afs7jA3fc5XEX4dIA
         rI/MIRewK9/nhdPMRuJ9Yrz2VkzH0L6bMcS/xZmZcURGCFBKYs1/jmG7umq65JVvv3rR
         SDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719925208; x=1720530008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb47TtTb9W9xZLtu/KLNSD3b7BbY25Ysou+rBKGBTNc=;
        b=ettmPIuGkTLlh32fs4ghoSZ3nC/ta7LaZIzoMtM5MRF90RMKl02EUtLfRE5gWvJe7e
         nvRljFjd5JsYXvEJj30Q1j0JupvmKy6z1p9PPwSf7XvqSaOi0SWTOHAPR0ALe1Ahmlk7
         lC3hdSh8L4dVgDEL2I3ny3NbLaCSRwKA702KAxA2gxMzl1y6HiAiwXXJn6NC7XzZJhqa
         8wQRS8QV4ij36HqTgVEnA5InzgGujSgRBn+lfP69yjzcBUaNc8nX3Y/+cleEyb8KbBUV
         cFXlJaP0CJFUC11VlXQ1/VKVdSyWlzIoBawElbOVJX9akeqfXfwQ70bShn5BdJn/qkS6
         iWHA==
X-Gm-Message-State: AOJu0YyP/S8zwqCB/JNZSk8XURPy5ybNZHoirAXytjW5hVjgFcb7TlSF
	AXbXSzCRNwWqbQT92nVQPW0gd3D74Jvy7v/63s5eCkFZ6DSX32WSTaTNJRYNQinxMAWynwPJYj0
	iP1k=
X-Google-Smtp-Source: AGHT+IGndDHoxuxivK30khxxlY9Ols6DM6ZXNPhZXatEMEKm+OixAXFdAVbQkiIzLqaCtlYBtwXc0A==
X-Received: by 2002:ad4:5aec:0:b0:6b5:9146:6251 with SMTP id 6a1803df08f44-6b5b7059d58mr81660626d6.12.1719925208459;
        Tue, 02 Jul 2024 06:00:08 -0700 (PDT)
Received: from fusetakDesktop.internal.fusetak.net ([2607:fea8:4d9f:ec87::103b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5d8fa573fsm4535156d6.37.2024.07.02.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:00:08 -0700 (PDT)
From: Tamim Khan <tamim@fusetak.com>
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	Tamim Khan <tamim@fusetak.com>,
	Lefteris <eleftherios.giapitzakis@gmail.com>
Subject: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MU
Date: Tue,  2 Jul 2024 08:58:06 -0400
Message-ID: <20240702125918.34683-1-tamim@fusetak.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like various other Asus laptops, the Asus Vivobook Pro N6506MV has a
DSDT table that describes IRQ 1 as ActiveLow while the kernel is overriding
it to Edge_High. This prevents the internal keyboard from working. This patch
prevents this issue by adding this laptop to the override table that prevents
the kernel from overriding this IRQ

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218954
Tested-by: Lefteris <eleftherios.giapitzakis@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b5bf8b81a050..b3ae5f9ac551 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -524,6 +524,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
 		},
 	},
+	{
+		/* Asus Vivobook Pro N6506MU */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506MU"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.45.2


