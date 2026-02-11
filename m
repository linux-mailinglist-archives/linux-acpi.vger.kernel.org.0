Return-Path: <linux-acpi+bounces-20945-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM0yHz0BjWnAwwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20945-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 23:22:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03040128177
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 23:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C57653019C98
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 22:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0B334F47E;
	Wed, 11 Feb 2026 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqmQA6vT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458AB326D55
	for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2026 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848570; cv=none; b=vEpo8a77JoQKIJpZeG3tgMMx/GgV7BmvrhzajUuDZZn9m/Be8krPuOxrn9sxn1AMJ6wA0fDiwmw9IIGa3c47Kr2dNoJV5AgForwL77UcVyMmdIZJMys7fRR4kCkpxz8M8g/uSXQVoKKrNxY4ge8R8X6QcyjaQhBRp+hCTJVQwDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848570; c=relaxed/simple;
	bh=kSRQ1t2rTIhxrR2NpzeHuU4Dkb/YzC8EVGJFlY2YwXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=io+wtncupuwihMQ5+WmGrZUB6YCsEPcbV+z6k0j7nv4b+0I9OIoDga3sVAQSkXQGGBQ61VG4gkfQSMF0GfeRTQpntiBfGPnNQExZbzfMyctB/KkXVODVAWtXNtFI1IUOeOTHuGeNDDipuCZSOTTpSRvcNPUTjRXW+oHy6lBDsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqmQA6vT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b885e8c6700so1174336666b.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2026 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770848567; x=1771453367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGpB4qIcfn0G9JgYHap+RlcYDjLTRdjD7UOeytDXSa8=;
        b=nqmQA6vTTTvsKL+4qN5f7xFgPvmpSVoY/CI2BoSaqtz7vC1FdLuoNT44EbxDxPPJAq
         7ZUfCIN7FgpbP7cbXoRx/dwnJexN049Eqa6frbwQyAF1RWrx/+TifJMsLHGgGJ1XyhJq
         Z3lwaUb5JlKAsuCuaWFCjyb1E8ZdeW8OqwuJyowAbVkbNfPp5YgmWjC9PGbG16C+HbeU
         fvt8eiSpWcVCw2RPOT+GUfz+A2Ldn5+ZZF4cmf94/wY6iXCVWWBi5MU4+JrBHa3RIT9h
         H19QUjJ0RvP6GP3KDPACLSvENczRshWS/89+Loafz2Dy9D0uwuOYOT5OzC621abl/wAx
         k69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770848567; x=1771453367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGpB4qIcfn0G9JgYHap+RlcYDjLTRdjD7UOeytDXSa8=;
        b=ly/ZNhSdfebdfGd6omKJOKBVDC77M5xfQ3/CPeTch8SlacLM2gnW06DTDJbGx6GyEQ
         FIImbO+51/B14Nx9N/84pkXYgrCsH0BQJOvnLlPocUKrENcYCKzYV2JEvf7KcMI7gTlD
         ojXHDKncuwXtbidqifjelYPz6H2m5vfpZJq36C4p6kmo+N7Motq2mhA2I3d6bFbQvp0S
         qskvl69Nhpzh13SDWLiVfdtjxa8E8A7lBHY3NQfvEr4hleio08w8Imo7CCLcF6rTaayr
         piUqXYaZJnPbfMPd9BEqwpuGkmQPqq0wH21MNx/ovnbXGejqNOk4mZLaCfGaMpJ6Bd0a
         tvBQ==
X-Gm-Message-State: AOJu0YwfAxeBeRm+f2g49T5iq7+z7+GcBEKmIem/vQkHv0CKtgPM+Yfs
	szZF64sMoermPgB/kTUOGrdMAuIyA7+8N/c67ROFRzmHENCF/2WWDWSPn6XjWQ==
X-Gm-Gg: AZuq6aJbSG0gWlUL/zM5M8exBK3AE0wx9V+Ge50azF2MVPXTdLSs4GQoq8ieZjE8aKm
	Rl3T5uUQ7yqS+WUJ9KkNTbE+zz/zxUP+8mU2yrETa+U7q6a9e/lHX/bRdvNTwMoUuzd0B2BdWiv
	QVZoj0KlAt+YEMxggGImk9SsvYD62BAz2U8dqTEIr7VilWtYBlgfhWXCucsVaOsGHadVL1Vd9Ho
	vEZijGLXGNVNFN4UY9xpQ9kt+WRMdxgc036irM0caVKIvv0iwYCRruLtbYaahsMl1PCBKDKjcvQ
	EQN4FISlmozlinPgMH5YLEzawPQYUMJwGHrLahcbybRVAmN9tX/da25Sao1B1QKhJs6aAWL1acD
	o5hkcfEOI+btX30J0ybNqzIMoX66ZxAgdPb5kWQE9KmJPvIi32lU2Nmtia2oq21luRWV0Yxj7M9
	8aK6XRCDJXFyy7DA==
X-Received: by 2002:a17:907:9455:b0:b87:3174:9bbe with SMTP id a640c23a62f3a-b8f8f6c918cmr34185866b.61.1770848567182;
        Wed, 11 Feb 2026 14:22:47 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6e9b3e67sm106522866b.21.2026.02.11.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 14:22:46 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH] ACPI: x86: Force enabling of PWM2 on the Yogabook YB1-X90
Date: Thu, 12 Feb 2026 00:22:42 +0200
Message-ID: <20260211222242.4101162-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20945-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jekhor@gmail.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03040128177
X-Rspamd-Action: no action

The PWM2 on YB1-X90 tablets is used for keyboard backlight control but
it is disabled in the ACPI DSDT table. Add it to the override_status_ids
list to allow keyboard function control driver
(drivers/platform/x86/lenovo/yogabook.c) to use it.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/acpi/x86/utils.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4ee30c2897a2..418951639f51 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -81,6 +81,18 @@ static const struct override_status_id override_status_ids[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 	      }),
 
+	/*
+	 * Lenovo Yoga Book uses PWM2 for touch keyboard backlight control.
+	 * It needs to be enabled only for the Android device version (YB1-X90*
+	 * aka YETI-11); the Windows version (YB1-X91*) uses ACPI control
+	 * methods.
+	 */
+	PRESENT_ENTRY_HID("80862289", "2", INTEL_ATOM_AIRMONT, {
+		DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+		DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+		DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+	      }),
+
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
-- 
2.51.0


