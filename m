Return-Path: <linux-acpi+bounces-10293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD439FBEED
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 15:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418DC165FB6
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075271AF0C8;
	Tue, 24 Dec 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZI28l6W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13419DF98;
	Tue, 24 Dec 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735048940; cv=none; b=Yqzdbo9FTLHY7swZKUfuPrnU90N5b0lTxKVU4PGEhTMzBO8t2C5D4P33BoYmnbOxJi1XlQ6GFGo6VzwCoVCqIV2wnFtpXwqtKT7nvjgMfuegpxewJUf8vVhS3HKx0aCp8RI8LK8JmmuUn1vk6gLuwhY+03Difqv7HwtNe4kMY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735048940; c=relaxed/simple;
	bh=2x/32LBBMrY9B9huAiVqNewYZMucStDSJdnGanOm4Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6NyNbmOkYXOm2U1FRB3ZuhDlbKzxPwb67LgwPxj3n8DKhRIL+0LDm7KBH/ffCSu2qNsjRmUZNF9fAjNCMlqU+jumOjsMQUXAuXsPTFRfInP0NobAgfTO2ATgKpD0MEaJwXZtWWAZFCc5yBQR4/rCi4YyYjjVnD54v+mQYkUNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZI28l6W; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e39779a268bso4494565276.1;
        Tue, 24 Dec 2024 06:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735048938; x=1735653738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTCSxNnvOAOyuHwrOZSUGtLRMMKrDqsd1nj8fO8Yy3s=;
        b=DZI28l6WdI10rTw2fzckH02RGMXk/u8OJN4YsGSZJtP6qutQf3rCskuii8ys0p26pF
         jZqNuQwNWFT7MifvpUeYO+3nME3aTuAQqun5bIdS4I8q9H+RdiZLPuA2cy8TFfZ8c/1m
         J2Inxj9IZVSkIlh+YrF6AcnOdlthvkaKqnPMglcBeC4MBG1J/Olp+Ku+HSBtaTuXdoSI
         tk1MHXKW0c01MhudB/R9txcCaYNVNH7ReinwpN/SGIEzhmIE3bbYmLrkjFyuww2m5P06
         L0UuGJHAtRezg966MsuJfMXpLB1ywVlCAIPI6EhafUVbXG+sbUd9KRB6nwS4XGgNB0Q/
         2evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735048938; x=1735653738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTCSxNnvOAOyuHwrOZSUGtLRMMKrDqsd1nj8fO8Yy3s=;
        b=YhnlFvCjsiBjVcA4ZyEz0Oiop1vdI+PjU/ZF1BlCCh1NbPeyG54X22FlS4EBw+QH1l
         7YAsktNOVOhIMq4302mRsckHv7bYTcBhvIhRC/srOnwBu1VL6v15od991TtL5kXNY+Yt
         zFZWO7Via74a3xux3cWiiBm5CToDBYX1hU8zlZCQFBWVoH7tnd/jCYfZhox3l/4ANJyT
         YGRIIZRF5mUd7MVMcWtE/Hv4g/v82d4EkxEkGTd7U+vJHiKLBeUssS3e+14/lekX6ml5
         6mBtuCTsqBiqN3pTytC10j2xrIva9Mug9qB/jy62hRG5Dfnzyuj9EoZPG/G6VzJBW4mi
         gYAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5spQBSb9gHMVMaUW76WFNHAAEwIjFcz4bAlXSff6KOJNelCla5YTGoUGsccDlctr/Ryr7hpeMdxlu+NVD@vger.kernel.org, AJvYcCXDX5oAseOXw+cEHu2WzRXrhkDaY8nqYQbsp3IAn43DhdGZa7vpJk4ztnj5w+wbcKEpnNHk82OuDZ66@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7s2UGhv03KQKNUwVTGnwrIc5Pmf7JxCnf5G8XU4bCmGQKmgvw
	RlI2hLBsJlYFZ0IPvczXRH4PNTV/wUziB+t7fJ94tOc7xYM9583pUZfykg==
X-Gm-Gg: ASbGnct0IHWw6x9vJAKgTQ10SbSnbHaYtzy+WTqhXo6ZHIaGgYJfZsVUP+wAPbuDC6h
	KZiuDHeHcFbR40HNo8cto5lM3g9tguSpBbFH7SVDZ+9a2ME7i/JYWAKP+arHJC0U6+mGqXUV/8Q
	9nwyamlvWYq0D4i7UwvAwQTDhtQgSMDDcv8nMvBX6WqUNTIAuzDOi+SHpGWc9J4zlL5fWyX7HwO
	/58ztSoGZkzeFoOM2IJRILnJE7l/IqRuvuUVzibLlX4g+IXA5dA0diIGSuAFo9T
X-Google-Smtp-Source: AGHT+IERUOn1WNhz9vE1Vyu9bC/Px6coDKYTxdnvCHSlpDlRsL0+C1j2pbj8SW/TFe02w2Qs3pkV8w==
X-Received: by 2002:a05:6902:2602:b0:e38:230d:aee0 with SMTP id 3f1490d57ef6-e538d0b3662mr14613257276.23.1735048937903;
        Tue, 24 Dec 2024 06:02:17 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cc79049sm2976051276.33.2024.12.24.06.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 06:02:16 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	mpearson-lenovo@squebb.ca,
	rafael@kernel.org,
	soyer@irl.hu,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 0/2] Device managed platform_profile_register()
Date: Tue, 24 Dec 2024 09:01:30 -0500
Message-ID: <20241224140131.30362-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi :)

This is meant to be merged on the pdx86 tree.

~ Kurt

v2:
 - Replaced convoluted cast with intermediate variable (1/2)
 - Restored dropped empty line (1/2)
 - Couldn't incorporate Armin's second comment. I probably didn't
   understand it (1/2)
v1: 
 - https://lore.kernel.org/platform-driver-x86/20241221070817.3764-2-kuurtb@gmail.com

Kurt Borja (2):
  ACPI: platform_profile: Add devm_platform_profile_register()
  alienware-wmi: Use devm_platform_profile_register()

 drivers/acpi/platform_profile.c           | 29 +++++++++++++++++++++++
 drivers/platform/x86/dell/alienware-wmi.c | 10 +-------
 include/linux/platform_profile.h          |  1 +
 3 files changed, 31 insertions(+), 9 deletions(-)


base-commit: 03f8e0e05510dad6377cd5ef029594d30e6c096d
-- 
2.47.1


