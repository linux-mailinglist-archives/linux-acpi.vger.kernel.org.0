Return-Path: <linux-acpi+bounces-6782-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF56C9291C0
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 10:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B9B1F23285
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1163E42AB9;
	Sat,  6 Jul 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1Ej/un2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71F482D3;
	Sat,  6 Jul 2024 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253487; cv=none; b=GsIn1FO+KyJco2YfWaawFxqZji9VaFF7NVlZEeKhuvmfpJPQJi5wzapnTq4VFQxEFDHn1wwVXriBYwHl/xhib5yA0xQwWI0n2GZ3/hL0s91zwxbE8YLTYXUJYUuDhyZQI8z2oozsUU1gCZMs2pi82+emT8B7dgLqr3F+AKfy5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253487; c=relaxed/simple;
	bh=FX1I3X73MwNh0D/6lAVpYMWgdP5ZgymmF8SGh4iQnuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=feP3hlWrLYCdI74mOvCRBkRA1f/MmQ05vg1Ql+9iCHJeV49Z4XPKJ9zeDqxkt1a5zCI19GmZDyy5pWfkVD10YeU6EA9/21xcXIaCPWd74IvdMCGUb3GB/nk3e0pohvuJ1vMCBT7w5lwXpO+4kqM52h8rs+D/OPLFQGFD1Pz7k60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1Ej/un2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3679df4cb4cso1427247f8f.0;
        Sat, 06 Jul 2024 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720253483; x=1720858283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtqQxTg/RL66mUa+pBjnTwVV1hlAlFA3VQSPpIWWypE=;
        b=W1Ej/un2KLIASS0qekNkqXo9DQKlnf9m+Uu7udii4nFFMmM/vhCj8wYkrD7Dwl9x7Z
         AYYetjVVQV4VE86rgPvOSW4zyg7Iktluqy6bye7rm4tF6GrIIjdii2rKZq+dGGJcTSC9
         p6q8S9k3aCsDGZQflEXmwmzbwQgLtWHOiBqp36youmb6he9tQwSncyCQRk5SQ8454ErF
         V9nKUpmvzHlCY8RBnHj5g3m1zrJrZXDBU6DVNBZEPRXv6bN7jaWNwEB3aIiAKrjaQydm
         bmA4017qaEK60X2TixeVYB+CAGUYlm553/ZZyOcpEaU+fjiPI1JQrYaCJFTShgGHh/WX
         epeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720253483; x=1720858283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtqQxTg/RL66mUa+pBjnTwVV1hlAlFA3VQSPpIWWypE=;
        b=Hay09EqQ+oo8+PHXLLdBGC1oAgcOHhb93+gLjZFYhYzW/91w0kdEBCZatHFTeZXMxE
         1Tki3byzDsLC2G9OuHTVBBz5CJuG+GMkPIF8y3jnnWDmYfS8mXezimnO79s7SWjW+gx3
         nmT6jdkNSuDk3N0qq5hRNcPlefY/ntNNKkp4NpeVYkSHSTss+VSM/jaBSzrpn8x+V01h
         JZ9JMnxp62O8hViNjDNi4szYDJdSIf1ykda95idcUY9WyAcJREjyuO5O2pWAlD+3dIim
         lCetalYhF8/4mpUI3rr70IwBj+OGpyZXA9CwTasIWkdK7+Dh2eMYOGADTrQEVJRM4bLb
         dOgw==
X-Forwarded-Encrypted: i=1; AJvYcCVB0BgYtxUDLIuaHV2P693ooSfNmOuFP1K6vcxZAV5DTNtWSXdQXGRqxp1HCSS5FlauqP2nAkKg6XIkjJck8Bh98DYoO2qhAOjk/RcKS7T2Z9eSd8/iLDQOOFxYqwRNqKir1g9S0WDKng==
X-Gm-Message-State: AOJu0YzbOYU/02C2ZbS3kv3H5XulqdUoiyjTG88s9llzaCVgQUGD6JHA
	PgK8TEG1BmnPdSEg7/zt73nKk1mSw7hh6fl7vHrr7f9FhU1YV2f2
X-Google-Smtp-Source: AGHT+IGtqL6OAbpkpWpg+wiXGtlXVHNZcZUGopU+eOAEqYkdVg9KXdSXtqxewHWSKbiSyyrmyNqzIQ==
X-Received: by 2002:a5d:6a4c:0:b0:366:df3f:6f9c with SMTP id ffacd0b85a97d-3679f6d866emr6273240f8f.3.1720253482626;
        Sat, 06 Jul 2024 01:11:22 -0700 (PDT)
Received: from qamajeed.Home ([39.45.163.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678e5c2b08sm10235931f8f.71.2024.07.06.01.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:11:22 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 2/4] Updating a deprecated use of strcpy in acpi_processor.c file.
Date: Sat,  6 Jul 2024 13:11:02 +0500
Message-Id: <20240706081104.14493-2-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240706081104.14493-1-qasim.majeed20@gmail.com>
References: <20240706081104.14493-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing strcpy with strscpy.
strcpy is a deprecated function.
It should be removed from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/acpi_processor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7a0dd35d62c9..8a8826a2242d 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -394,8 +394,8 @@ static int acpi_processor_add(struct acpi_device *device,
 	}
 
 	pr->handle = device->handle;
-	strcpy(acpi_device_name(device), ACPI_PROCESSOR_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
+	strscpy(acpi_device_name(device), ACPI_PROCESSOR_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
 	device->driver_data = pr;
 
 	result = acpi_processor_get_info(device);
-- 
2.34.1


