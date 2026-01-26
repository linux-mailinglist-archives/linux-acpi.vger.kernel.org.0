Return-Path: <linux-acpi+bounces-20607-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMVqO8zmdmlxYgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20607-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 05:00:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEEE83CBE
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 05:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32D553001595
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 04:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B43043B5;
	Mon, 26 Jan 2026 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXkrTi5C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75B2F39C1
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769400006; cv=none; b=rnLfKM6eKH/Ib20VrN+Alev/XH743s59FaC7mryySjOQvB9csvlqNsoXRfyVHIdZZVnVmEMS81CRMnQ7CSuKGtqpw5FAwaKkUz3+aQVszy5gZYbVF+Rpn4teJaMus2qy2KiSJ95aRUozgBh1+iMm3J3LA9aI92VWa/bP4Y8AI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769400006; c=relaxed/simple;
	bh=dWe/Ofg1Ju70PTF+2ND9l7SJJ9rV2eyZ7T92BJiX644=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CyC1a9AoFZ/vjmrlQsyJejTYT+MQ5InsoHGvsRNM/lRjUE7Uvfbq4lFDMaj6PfMdA46K9qDkn9EQ8yXggzZhseMKVGVtfijBIN81p6JcUIL2sLe0Wf8owCETqeIvv1LiRygznn+n8LiIn8rSIEFDV+lJt1piXoGxkyt2yjEAujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXkrTi5C; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b6f267721so3764292e87.2
        for <linux-acpi@vger.kernel.org>; Sun, 25 Jan 2026 20:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769400002; x=1770004802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOBDD584N2G3qYvT8oMwoUGO5hkpiwx3PvZwbmC4EP0=;
        b=JXkrTi5CdI2s0Toa/N3GkeOYN0uErSAPQP0IANj5jcMOdEmUx7ppOq5yaDKn7NScMO
         MHsJDiW4H277NroVipvdzaup0J77u5n0MlPEGu0zJ6mPP3avuONaucfvjLPNrmLCbqby
         T6J+U9/nqCsr/iztMmKcYNFxUNWgeMxlbLDr9caqVDlUGCNjAAMRR/R1y7XRsn8ssiwY
         gBIhLwm6yGURaqzUerYmXVVzx56l4gUGAnf8CqI9/8xHntReCiRaosZ8U8xPATzsG+VP
         BNzQh3cDj21mnHzBw9ng0qRxSy0aKtZ0YnrUTajSn0kg/EOr4LG/fs7M70ELj6HK/AEO
         j1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769400002; x=1770004802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOBDD584N2G3qYvT8oMwoUGO5hkpiwx3PvZwbmC4EP0=;
        b=RpG0J74tuWOQe5+hxkyomOowgvGLbyUjHssDlf+HFecdC9D/kD3bBVnIBPvrsdxiVr
         wvI+4H1U0x0aQpZKfYckD4WWwQG5KbOsvMDe2UtSes221ZMBm61YG2Dt/NGCHOnxS0FG
         sJaSIkKUsPs7lT4H/koDmvQXd97jezW57KohQ0aM3LtsvIINCfbDqh+k2kbZAhWTUwH6
         Y7vdaNVhiIeXXei4tOvA3QKmYFXz6rUY4vB0xwU/C+aIhGrWMAMRF5NEbDaWMAdbCkZg
         ZTRP8hDADCsRCvKzJFqBMEiCFu5Uw8kvo3+R+8WoI6TX+q/vFr1fZnlHzFjfbphlyHad
         T/qA==
X-Forwarded-Encrypted: i=1; AJvYcCXoF1ii/UjPMUFsF6fmMxTbk1tfnHtjkjDMxh2+r9F0G2GH6DJooyDwH+RJjoMmikSlCbDZusWnAnxd@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYEHTsv45mRXXdG+F44tzMx/Z5iWLDo/w0sv2jARHB8GLsBRJ
	fdwwclVA2idRb9HnUwdzXhXlCIs+6SXcuYmT0Pi4G044XU8+7UWX0Ea5
X-Gm-Gg: AZuq6aJgg5eYYF9MFnqexN1YoljHBRGgzFwCeVMmiqql+6ilfPXM4z3Obk4kPA9AbaR
	rLP9vUfgAP7aahSmFHVEwKaM40eBMXLUhjYg73m/g0Pj7uQ8XVcG5+Y3CEOj9Vnqrmjkqsw9nq2
	E+OOzJRA7RLWbbgEkUgagxqPudHyL+zZ9QlFa0eGIQxw+pzIk/Lkv819d9/LlQBZr8n27gqPFLT
	hgfBBWF5LYyGxnFBdqGIAXEFhXzond+AagOEd8xg1ZGKukWKrSqKJmVCtQPmfRIlwt21SbgFYeq
	zWgGy2IejsXWlcCaX/db7i7+rwBaKDlYG2bgXCjqgxkbsGPShr7Y8nYXeIgrRUD2/lNIONfYrOq
	lGiJTe+iup0TYW9TA6grP+oiEyS/112XTirIEZSD3KqdV/B75D6I1gBkJJH6ucC/X6+LUjoTK0l
	4X1Czju2p2gGAO/UDZnUFzZfJ5+KbMDNeF
X-Received: by 2002:a05:6512:304e:b0:59d:f669:c924 with SMTP id 2adb3069b0e04-59df669c967mr685191e87.27.1769400001890;
        Sun, 25 Jan 2026 20:00:01 -0800 (PST)
Received: from happy ([217.15.199.233])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48e5fc6sm2434040e87.34.2026.01.25.19.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 20:00:00 -0800 (PST)
From: Denis Sergeev <denserg.edu@gmail.com>
To: westeri@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linusw@kernel.org,
	brgl@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH] gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler
Date: Mon, 26 Jan 2026 06:59:14 +0300
Message-ID: <20260126035914.16586-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20607-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxtesting.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[densergedu@gmail.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url]
X-Rspamd-Queue-Id: CDEEE83CBE
X-Rspamd-Action: no action

The BIT() macro uses unsigned long, which is 32 bits on 32-bit
architectures. When iterating over GPIO pins with index >= 32,
the expression (*value & BIT(i)) causes undefined behavior due
to shifting by a value >= type width.

Since 'value' is a pointer to u64, use BIT_ULL() to ensure correct
64-bit mask on all architectures.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 2c4d00cb8fc5 ("gpiolib: acpi: Use BIT() macro to increase readability")
Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>

---
The ACPI specification does not define a strict upper bound for the
number of GPIO pins in the Pin Table. The value is derived from
16-bit offsets inside the resource descriptor, which theoretically
allows far more than 64 pins.

However, the current Linux GPIO ACPI OpRegion handler represents the
pin state as a single u64 value, which inherently limits the number of
addressable pins to 64. Thus, even though the specification permits
larger tables, the existing implementation already assumes a <= 64 pin
mask.

This patch fixes undefined behavior in the valid range [32, 63] on
32-bit architectures. Extending support beyond 64 pins would require
a different representation (e.g. bitmap) and is outside the scope of
this fix.

 drivers/gpio/gpiolib-acpi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 83dd227dbbec..d42f769eeb11 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1159,7 +1159,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		mutex_unlock(&achip->conn_lock);
 
 		if (function == ACPI_WRITE)
-			gpiod_set_raw_value_cansleep(desc, !!(*value & BIT(i)));
+			gpiod_set_raw_value_cansleep(desc, !!(*value & BIT_ULL(i)));
 		else
 			*value |= (u64)gpiod_get_raw_value_cansleep(desc) << i;
 	}
-- 
2.50.1


