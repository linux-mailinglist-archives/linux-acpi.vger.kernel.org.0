Return-Path: <linux-acpi+bounces-16130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554DFB3931A
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 07:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F79462731
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 05:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6D27144E;
	Thu, 28 Aug 2025 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWzjOi8p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F00264619;
	Thu, 28 Aug 2025 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756359499; cv=none; b=RjHOSqV+OPojRUl+YBN2xLGW6YlHXztQTNLCGKMalyx/8kwzbG6b0MaAl44Z60QZaDvy3cDFPdZUU97yR3lLZvJ/wvUQFk/fCUHpnZ9Qf2N8vdyPzpTNAbaGV7LRmkkLFXcsFhQPw/Vg3d/zM+7wFoCpvBjoH/F202Aht45SKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756359499; c=relaxed/simple;
	bh=o0j2Q5OnFRDkN6o3mzrj81Sev8VvY/usqBdzqqqUpO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7neGCy2brKAaZ3chVB27UG4WmpDuNC2E/d+lNXU5Vq+NyKiCwUttwTYwCwBMIsD+fF+awCfB6PiTUh0yywq7ptjibpyF9OjEsiu1eb8ZBt7aizEysSTk9jiisJLFmvs21RDEHTwponwNxEJ0zlkFtWU8v/bODzyfrdqsy8z67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWzjOi8p; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e872c3a0d5so68834285a.2;
        Wed, 27 Aug 2025 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756359497; x=1756964297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeZgFAplHYCPO1eIcGIJKgjyuG6YfkVFCqbE6NCwBao=;
        b=nWzjOi8p9S0jgbhl4VzdFVsxEI3iqSn7AwciMOgba0hTZR/Tv3bemA07wd9o2n8h5Y
         /sKnwpPqrxgC8y+cb6vXsHivkr+RPFlUADd4P31Z7SwFxRRUDeoBi04laBHhfN7oWpGC
         kHt/e24S+WX6g4I2x4eLrhYeX6xeqnczheQ0xjmpEWCk8Gr3RwgLn4aomheCYkq9Jrzv
         h43lcTvq0z1ka7Tr1VJpB0rIDFkcXo+hZifd5nFc4bntpqPv30Vu8wJUsxX6+gIELbNr
         YwgI1+gAH+yxhmBJNvTsBdlcwsNH9i8E9eQfi+KBzmck/d4W6KId4ShGlTHot12477U/
         i6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756359497; x=1756964297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeZgFAplHYCPO1eIcGIJKgjyuG6YfkVFCqbE6NCwBao=;
        b=lBGqV7nrw+zh3QjXBHsNU/1q1HsoIwLYIBn2VPuJmCazb+SVkOSXNKJ32s/ft8Tuhp
         2/VhlixwInxZBpsIXjeGJqYQQHuWbnNazKSJe9DVvOdBpIBm8fgmuvTGran9xQZgk8a8
         RDhlsF0nu8FxMujZfU21LzuZcRNZsxk6w2STeNxV/23HYyVsCfrJ2jzBNnNTIZ13W6bA
         b/mQt0mv1EnIYg129429oZNB2UsJWQdOWMkJIphTqrIM5hVTbt4pBbksMDIRJ4Mli1pI
         j7qPepgVtvcCmnaTdGE/g6aBAj1Y11I4aCK1EzzbAa5bdtaEUb8ya+b2Hd+l972cI1xb
         WZjw==
X-Forwarded-Encrypted: i=1; AJvYcCXMWO+7PqE024sui7AzsRz2DiPpNZrc2mNm+TpcngZc7xhRKmyuoG4zRVcXlZ61H7DR0/2yI+6CVxS6sAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRptQ+3yUqmNlej4RWdXXtvkBd+tuuRXwWPM936fbftWgu6Agb
	HTl7kvnlDnTWjgwWDwwHg5qrhmyymAJlEICplF4/Z0xl4EWcHEU1gnDm
X-Gm-Gg: ASbGncvfaRlnMfoIaU6xf/u9V1w1U9TZ57Yy1NfLExGWbB3LYJhLdFLHJ5a3Ae31msb
	PTreSdFRofUORXNoMLcshsuN88ggkH1g+/a2DgisV3yjYRIR4UhfOLvlxY8+2lDEtHmbkGA9YVe
	u1dnF+xuXBOMRIocIY5Hxh2lnxbKPT/6okcvQCvbFRJqcHF38/lFpyi8KrM8PSnqZDDXkdHP9C2
	w8ECGMqtH2pOg5+UABrmqAuTe7bLaEMBp/+skXF4SKUh09Ac0+K5TB/QBjVyTOT1M6Fq8/wzWLz
	6tlT70GYVZmFljKwfVAXnmd5g3RLuaNYxeVDa7zKCdpmsJxCgGJAxClOENVgvUULl1eTB8o3ux1
	ucvZ8cHILlvf1X1siMRcLEC4bjKqpdzIc1orNI3IqQmJId4Nu/wjSxYoSpDBIvsH0zEVM6A==
X-Google-Smtp-Source: AGHT+IFg4F1UAA3wCHuhTMCYZKaMV9OhYqevQ8NlMIdCfe+j4F5HZapDikDWp6iVvIKhPJgNhj4DCA==
X-Received: by 2002:a05:620a:469e:b0:7e1:4bec:9769 with SMTP id af79cd13be357-7ea10ffd167mr2310006385a.29.1756359497396;
        Wed, 27 Aug 2025 22:38:17 -0700 (PDT)
Received: from daniel-desktop3.localnet ([204.48.94.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed79ac9csm1037328385a.21.2025.08.27.22.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:38:16 -0700 (PDT)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] acpi: TAD: Add missing sysfs_remove_group for ACPI_TAD_RT
Date: Thu, 28 Aug 2025 01:38:14 -0400
Message-ID: <2881298.hMirdbgypa@daniel-desktop3>
In-Reply-To: <20250828051203.GU476609@black.igk.intel.com>
References:
 <7674021.TlGXAFRqVo@daniel-desktop3>
 <20250828051203.GU476609@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Previously, after `rmmod acpi_tad`, `modprobe acpi_tad` would fail
with this dmesg:

sysfs: cannot create duplicate filename '/devices/platform/ACPI000E:00/time'
Call Trace:
 <TASK>
 dump_stack_lvl+0x6c/0x90
 dump_stack+0x10/0x20
 sysfs_warn_dup+0x8b/0xa0
 sysfs_add_file_mode_ns+0x122/0x130
 internal_create_group+0x1dd/0x4c0
 sysfs_create_group+0x13/0x20
 acpi_tad_probe+0x147/0x1f0 [acpi_tad]
 platform_probe+0x42/0xb0
 </TASK>
acpi-tad ACPI000E:00: probe with driver acpi-tad failed with error -17

Fixes: 3230b2b3c1ab ("ACPI: TAD: Add low-level support for real time capability")
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 drivers/acpi/acpi_tad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 91d7d90c47da..33418dd6768a 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -565,6 +565,9 @@ static void acpi_tad_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
+	if (dd->capabilities & ACPI_TAD_RT)
+		sysfs_remove_group(&dev->kobj, &acpi_tad_time_attr_group);
+
 	if (dd->capabilities & ACPI_TAD_DC_WAKE)
 		sysfs_remove_group(&dev->kobj, &acpi_tad_dc_attr_group);
 
-- 
2.48.1



