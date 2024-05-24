Return-Path: <linux-acpi+bounces-5975-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CEB8CE3AC
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2024 11:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885031C213E9
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2024 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DAF85283;
	Fri, 24 May 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="j5W9IJfz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7685279
	for <linux-acpi@vger.kernel.org>; Fri, 24 May 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543788; cv=none; b=mMCTIsPS8D5H22zzTLa7wtl1xe8bUfAMeUGqpth2lQWryD7Vaz/rpcYUw/cRAL+/suT4LlF/TbjAnG+Yg7bbqriXyNjk/FLUzmoq2Lb4jQfUbN0wIRCmfRcy/Nmj66Gr4YiKlzwRogSqmztkcRlBDXYengwRpWJ89vdC9qr9waY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543788; c=relaxed/simple;
	bh=GkLKm0oj1HpLHw4ns0Tw1JfVm2d5iaPgURXutHnx9EY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TPEowAengbPusGLVvPLiy77jKndKfITM6pNSjBScKDE+7w2aNixsBHjcDpL1NWBJ3ns7qjbnRIlYV7PGE10Kk7llIU7xqIETX+b63QxNfzSKi9mojVtdudSR0fBskr/pt1HoByhSmX1u7255exfvuZE5inpIxZ33ocVfo78DVkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=j5W9IJfz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f335e8d493so5133995ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 24 May 2024 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1716543786; x=1717148586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvVFUGPKt/a8n9rluYwNaVtttO9sxZ+ITXVXwBC3J7o=;
        b=j5W9IJfziHGBBRAnS6AMfMVvu0v5rNT6fKIdXYIFR9ntxlKDQHJoiFk5J/6n7j0hxg
         XL997UZ1+J5zIE2UCiuXyAkezTJLv2fpPyRpasJaaztvCfsc6mzSmgthMovFpjBbeq3v
         +WGa0GXpAYD3Zaj0+1hiGVZ8z3vd4QLfP3KO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543786; x=1717148586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvVFUGPKt/a8n9rluYwNaVtttO9sxZ+ITXVXwBC3J7o=;
        b=tLHTJc5tuHXlQzeoryuAjLBc8y5M8gGhxBJTrfiSiw47Z7Tf+U9W4rlm7c6ttJ+kYI
         BF3SCKWIRZlPJGC85CKTL4oyQ2/pv0YK5cqq6azjJFJSGnuXlnBRxTlN+BEj/rxZrbiW
         zMMR/30Iixl623CTk1sZlxwcNxyiR+TaftUDHC0AgNO64rvzQwEnEfiYpOcthfWwopew
         81CCQc2/gGRBr/ntbFEJoPXFY7lEEKGm+8vdHltMwSkql//fe3/2ifQLm76M3vz2GXTu
         xYK7+48UlZpL5JvSaUrcW5sN3Ohvf01vIEwSrxx0hOzwZGIXsze7rNJA6HVkbXMILtGg
         8WMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2m4QaaHhZE7nqtQfGvmzCQB3pVNVLZeUKcIeGIhQNA0sZzWD2QwWmNqIEupePoCZnh4BGqLajs626t4JGhTwgj4GtIU19uUgtQ==
X-Gm-Message-State: AOJu0YyzwIKHIO6cyOvIFINN9lac4MtFAbE2o7HVoohejfGtSJSFS57s
	zc4VlfV2iLJDm6jKhc10d0N/lrmk4Bgs+DDov+BqXNMNXoMfMQgYWxfXLYBaswk=
X-Google-Smtp-Source: AGHT+IGXGCqoPutDXzuzz6RKBCtI2gGhcCn9izfE255s9KQUodLb37wS+/DcoGph2y40IgqmV2WjrQ==
X-Received: by 2002:a17:902:d492:b0:1f3:2f88:a158 with SMTP id d9443c01a7336-1f44873db5bmr21658705ad.25.1716543785848;
        Fri, 24 May 2024 02:43:05 -0700 (PDT)
Received: from localhost.localdomain ([103.14.255.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7c402asm9873935ad.101.2024.05.24.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:43:05 -0700 (PDT)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Chunjie Zhu <chunjie.zhu@cloud.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fix kdump kernel cannot find ACPI RSDP
Date: Fri, 24 May 2024 09:41:49 +0000
Message-Id: <20240524094149.189329-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kexec/kdump must pass acpi_rsdp (physical address of ACPI RSDP table) to the
crash kernel, especially in EFI case, otherwise, the crash kernel fails to
locate ACPI RSDP table. Consequently, ACPI init runs into error, and APIC
mmio read page fault happens, finally crash kernel gets stuck.

Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
---
 drivers/acpi/osl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f725813d0cce..39474468dba1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -174,7 +174,7 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 #endif
 }
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 static unsigned long acpi_rsdp;
 static int __init setup_acpi_rsdp(char *arg)
 {
@@ -187,7 +187,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 {
 	acpi_physical_address pa;
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	/*
 	 * We may have been provided with an RSDP on the command line,
 	 * but if a malicious user has done so they may be pointing us
-- 
2.34.1


