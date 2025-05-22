Return-Path: <linux-acpi+bounces-13849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307CBAC0DD1
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892861886A56
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA0B28C029;
	Thu, 22 May 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VBbe1Rxu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE21F09B3
	for <linux-acpi@vger.kernel.org>; Thu, 22 May 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923259; cv=none; b=UAAgAJLNuOZNv5AZmrvaovI15WzF7miZpcmEBXxEJ1IzG7AS/rQjT3rLfYzvABS0eTck0emq75/+9dcXeVMx2LyZ/LVCEFhBuxckEuorhdgJ6NOpmUAe4Qzhs+fuxF9G/tb58I2nzlOyHzRrjnMHVurrzIepByMfJ1GK4BgDN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923259; c=relaxed/simple;
	bh=NjkTfzFMyAGXuhOgKQ109s7ClQHXKV1V0DZBGG1rmro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qdxRmxOcyQLeRJc+Xu0StLMiYM86DuQjbQh/U7D1EgNqqX8U1dOBniZfyso78lnJpoVq0RrDHz8RvjvXfdf3pjPknjtlzICjLoGVXwu5QrIX+M+AYuhZWzUFWjVIfkExZ+N/TLIa4JnoeGum6JVfHhjSD+TCwtOAO88AC8bgmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VBbe1Rxu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a367ec7840so3722441f8f.2
        for <linux-acpi@vger.kernel.org>; Thu, 22 May 2025 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747923256; x=1748528056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/uSymK2KQolRGNG/Zro5bwOoIkGZ6ivjeaFlFxOB+M=;
        b=VBbe1RxuogT4M7dGw5g/JO+q6uFqQQjq45rIOCEPBobNpjeSt/zkOF6wleASLMktpR
         bIJczm+Helt1zdrU08kASnyelExoeJGAt+gO6rIM4fMie0Lkhn8ngEYFpGfECyICgFW7
         HEdts/JRwNQGKuGw8DN7nfukmbGJp577TdJOeeotVP2MTERpCGRmL/B0GSWBoNk5ZdSV
         EhyKpdn7jehwwwyM9LXl1ZHaRk5d08GIDcbjOmUL33nYFVy2Q+9mQ7Q9iMmQsnKln2jk
         NJ3/nPXT+8B9lzMrVLpxK/o61rX2/0Fk5hGEppxESLhzBwp+zrY/LLQoDp1X1z6NQvjC
         pzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747923256; x=1748528056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/uSymK2KQolRGNG/Zro5bwOoIkGZ6ivjeaFlFxOB+M=;
        b=PF6FusI10AvV8zvWgsZceNMd0sRgw7l+MQTJiCteA8JQEecNATHUvE2q0oh3UlE8Dt
         9YfPyzv/zk7Ez+V6NFilQMQF4O3pyXglvJ2ySdVie4XIrOmjv1hYxxiaqkNSVSwJb+ax
         YQ79UhC9P0oGQ/Pl/Xgy1dDfXEz27iHddfZONFlRxQLt46JfTqE2m0CewUIdxQY54xW0
         jH88vIOrPAQSJxXJQBcSu8v5drAiPCKPQp5bG66+6owVEn711fKySQjIkYfV7kqG4NiV
         t1XLkiFQwBJ9F04WNVZhVkYjTtCCivqoohGd0SrLBBp/BkwjGcDSLXIEkRyl2cTgfRxX
         xbqA==
X-Forwarded-Encrypted: i=1; AJvYcCWH/r9MptpJsBuES+I+jF2Jgiy3bzTmnVamDSMXpzgKwFkCBqOmTtUpbMom3rh3AjX9AELmPkKSlkXI@vger.kernel.org
X-Gm-Message-State: AOJu0YyMK8kblHGRLmbHQQKBayO03SxPiFyTP2xAGlAFy0DjomT49l7o
	n+Ho7xrv75pfmeGy/XWRqqvht5KlqE3+9FW1t+j2KEI30vYiNusPgqqt+0J9dqQcm54=
X-Gm-Gg: ASbGncuDjI17thlP2D3/skW7QKtDeRi5D4VbEiDavBtk1sI1tUQKBU2GDCaTH7gZ+mH
	oU5MBUTcMXIDu9IShkI1udlKkhCcHPMxKevU5V7uTPxrqm6Z3ao4JngLRmoDgQFmlc1INxlqI1P
	mRYYRhuWwNCuMQ2rHxFZtgfH8cE557tvZ+uTOYBSzgyssSTTNl/oKiCVZEZGUIliVvcWmjQcCCs
	kM4F/dVmne3RY9K3vvHARUcOQz1vYROX7qrBWcQel0W00epcfz651t2jyJqO34/bxCUd6yCapVz
	0tlZjlOyJDQKyVFgE43toP/eKf5jriKi6Dm0FiB0GclyOX7yh0bN4hJRQmV/UzKBtgZjeZuxN/I
	64nHvqQ==
X-Google-Smtp-Source: AGHT+IG0f08eYuSPxr3k77OUaqNYl8jJN0PAzE7LLLCfL4pu+eoqr3PWdm1MbbqN3+STTYtiLTQqeQ==
X-Received: by 2002:a05:6000:26d3:b0:3a4:7373:7147 with SMTP id ffacd0b85a97d-3a473737314mr6667933f8f.25.1747923255863;
        Thu, 22 May 2025 07:14:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3382:ef90:a754:c956:d8da:801c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8caaasm22910191f8f.83.2025.05.22.07.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:14:15 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] drivers: acpi: Fix platform profile driver on !acpi platforms
Date: Thu, 22 May 2025 16:13:56 +0200
Message-ID: <20250522141410.31315-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform profile driver is loaded even on platforms that do not have
acpi enabled. The initialization of the sysfs entries was recently moved
from platform_profile_register() to the module init call, and those
entries need acpi_kobj to be initialized which is not the case when acpi
is disabled.

This results in the following warning:

 WARNING: CPU: 5 PID: 1 at fs/sysfs/group.c:131 internal_create_group+0xa22/0xdd8
 Modules linked in:
 CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.15.0-rc7-dirty #6 PREEMPT
 Tainted: [W]=WARN
 Hardware name: riscv-virtio,qemu (DT)
 epc : internal_create_group+0xa22/0xdd8
  ra : internal_create_group+0xa22/0xdd8

 Call Trace:

 internal_create_group+0xa22/0xdd8
 sysfs_create_group+0x22/0x2e
 platform_profile_init+0x74/0xb2
 do_one_initcall+0x198/0xa9e
 kernel_init_freeable+0x6d8/0x780
 kernel_init+0x28/0x24c
 ret_from_fork+0xe/0x18

Fix this by checking if acpi is enabled before trying to create sysfs
entries.

Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI platform profile")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/acpi/platform_profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index ffbfd32f4cf1..b43f4459a4f6 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -688,6 +688,9 @@ static int __init platform_profile_init(void)
 {
 	int err;
 
+	if (acpi_disabled)
+		return -EOPNOTSUPP;
+
 	err = class_register(&platform_profile_class);
 	if (err)
 		return err;
-- 
2.43.0


