Return-Path: <linux-acpi+bounces-19731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 850C3CD2120
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 23:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2872304B20D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028842E06D2;
	Fri, 19 Dec 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSV1GRxN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484A02BE7AB
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766181602; cv=none; b=K7sgavWwAgn4E19RiM+53PEgCIQwxneR6eRUoiyx9tDidbD3dSbVVjLJkPKcVfqz+zmVp49Fol27SSi1aTMvEO1geZ2heRKQikAxvgOQ8S7r1kFwqLRTw8lYm75C2d3LQaAedc+lpGLGai8wKVuq21tQGWbVxXpZ4LKDAtQraSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766181602; c=relaxed/simple;
	bh=p5ZBx2fO8dMf8JhJxD/15gLwQL2iG+/xA9SMwVPva7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vDUT+UWom5/FcPtrYjeWcqRc9VNwGY4N8Ca0ARetQPx24PKc2aRyz7lDu4std/rPTJtBNqajtQXBlVVOSd+zxkuRZmfzWLQpu23qVVBB+q76OxaJMQx18ajv4+7cMi+eHRvac8V+hv9ZFcPHtw/jx3dSmv+CamBEc80p4xdlDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSV1GRxN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so1105016f8f.3
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 14:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766181600; x=1766786400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz/5KtDyRfV7d2ZpZVgNC/lWm9kf2lu1z7gPSFjPPXQ=;
        b=LSV1GRxNdXYYzhgcVUJ8xdY/gZSC1wgszBeyrBz6TDvJ3D9edX8S6DrczgLmK6LdSX
         7RvDwSC4IcFKzDER/N7P6MLG/KI/K5fVMEQ2/nQRwmAn1XlBZW8ZRGK5rWPiM5QqTPig
         5HvVEWd13hDdWb8cQfSUPccXAji6FioQe4xePSZARTcvss5vTmHFth3YJMj0nrTuGwLy
         N6MqoK/K9mPwrbRYCmN70xf2dLD1CCr6D0zgemFL+GPEAg4o61mJfKMeHZb+QnvpkafT
         3RfrWTj+KUmF0Gu36d0liQArJhcztxg1YhmF7WnyJI56rXfJvqwoVdjGL1tB0uOBxExh
         c3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766181600; x=1766786400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz/5KtDyRfV7d2ZpZVgNC/lWm9kf2lu1z7gPSFjPPXQ=;
        b=VH7Ge8Kr8uTJv1/kDeGpxtdKqzOIsytIGezAw2iqkOLfB1Aboy4rStOOj2cXAUOBxh
         /gkNcNEh85VQiR0w8o1g39CRbpnJw0vAbSByVlg+Fujr0iGDXNi1131f4IDGw617PceQ
         hzlGVPE7/qh0F/ZfBfWjE8wM8p6CwnxvZd7l87o3I2padCQjLtC017uHQvxM/9caF1Ow
         vRYT/zbpvA7CFrWnn0oF4upp6Z0DhxQXSyHYdh5f/64fs4+LQM0lvHvYRd+ft9M+8DhV
         1Fe6iwhgziqGuyP/93nGWp5b7W9y415NKC76nSp61TL1fobE7vI5jj1oLaBnhEsLgEFg
         5f4w==
X-Forwarded-Encrypted: i=1; AJvYcCWyaZwcX8eq3zrAwQAs85ODjUewSIsf3IKkXb2XD0rdL9qy+c3mbQo0qsRwUPBMrseOyoftW9vOmF5U@vger.kernel.org
X-Gm-Message-State: AOJu0Yywo+Vu81pShA+d9RJgPOZhp2EkRgAop4uoWXuRblrjzj4lKwqV
	cukOipgv5CFXT0E5zI9yynC+GXRtG3oi3mNevOZqScXYVpp+yajoh39Y
X-Gm-Gg: AY/fxX6JdAq8pd0NTTLHH4zxPuIFyXWeqjWgdFH2hOWQKBFXq13+z/wRyO205E+YNII
	9vYdxp/Chvs3GR0yJz8H8YOVngKMzp+FQ7+qKjS0oo14rRs9ViL9AfE/vrcUXKJMgMy4VSeZSMF
	PZQON8ptcPUrDAJUC7eaiT6L985FPjbM4KLO2Q7P9GalxbyYWlyNHoP5OvFgH6QDMG47cSMcCRa
	6cxyEDQtcMWhf32r7qlYEWcURsxVvrBwKqusbs8dBGFWB2wi144hqCC5uierRtm7bQk0Xssva/2
	BmVbvRycQ6AaUhWb9i8nN9S5fTJBTpkdOLiwXu2eVuG9jX74zp+DmvMYbjAY37uVrkkjwk9objd
	By+TzyIqOzR5i/8Vm17Sh7pkHTZTxYGHhQ7CONVaufIfnNFqaivL4Izb9reqow0qCrdne643m4F
	8FoRiOxC+6QKdJGGYjKCiN
X-Google-Smtp-Source: AGHT+IHa4QBBFGtyb79vsIJvGHrCndRLRO0iu/waUiiuJ/ecEaNRWqeL9eRxWmgxsvmevKs3pD56mw==
X-Received: by 2002:a05:6000:1ca:b0:431:7a0:dbc2 with SMTP id ffacd0b85a97d-4324e5035dcmr3998214f8f.31.1766181599315;
        Fri, 19 Dec 2025 13:59:59 -0800 (PST)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82fddsm7154835f8f.25.2025.12.19.13.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:59:59 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: APEI: EINJ: make read-only array non_mmio_desc static const
Date: Fri, 19 Dec 2025 21:59:00 +0000
Message-ID: <20251219215900.494211-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array non_mmio_desc on the stack at run
time, instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/acpi/apei/einj-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 305c240a303f..f5bfdffe1e43 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -679,7 +679,7 @@ static bool is_allowed_range(u64 base_addr, u64 size)
 	 * region intersects with known resource. So do an allow list check for
 	 * IORES_DESCs that definitely or most likely not MMIO.
 	 */
-	int non_mmio_desc[] = {
+	static const int non_mmio_desc[] = {
 		IORES_DESC_CRASH_KERNEL,
 		IORES_DESC_ACPI_TABLES,
 		IORES_DESC_ACPI_NV_STORAGE,
-- 
2.51.0


