Return-Path: <linux-acpi+bounces-18731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA59BC478DE
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 819304F1DF4
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAE524677A;
	Mon, 10 Nov 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El4VTfY9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEE23EA8B
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788351; cv=none; b=HwBuemloqy4lJZwxAH5RS7VhhxXQy9K8TH5n2W61qA4daDUXRP5//ZrG35UUzbHrkdtsOJRieIKeniGB9Kl8BhqUC9Lo2RqbRe2IygbYmdhBnidJUDcXzWQeYlY8FCYpjipcfuJouk7FY/ruBn1Mfxk+KOS3lJaIr7cI5txMI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788351; c=relaxed/simple;
	bh=55cmDK/DB9d7aWyV3KRW+2aWkZsi317dmr5DmE6lvzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKDnYJsZhgfFmzbj6AgOHqoMG30SpA9GyZWWkBUbUxsd7Ee97h5E3EA0HnU9qqb7WFLkWo6pwsJCNJyl1mN9K/mA9PwnH5O6r+VBEgfgUNr+pgCMY/ssJehenfuq+bvNc4m34c1aspwKsTej1HbDvdE209otxf+IHg5d7Y1H8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El4VTfY9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37a3340391cso30532321fa.3
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762788348; x=1763393148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y7AbbQjoW2c7ZR6ncveQ52gAnz6KIPcgn2CEQordzs=;
        b=El4VTfY9jnI4I4m+jLt5IZRt5W0PMDjX2ohDPFhbjpYofJyXeKhlEWguQ5T2/hXwzH
         u5kXnqRZKBdVFZdit62N4SHK2LqX/jpFL0gHaJ9qoC8zaszh2FTp8AgDujO/H2gg5wgt
         esk+mnuNSI6P8OjvTgzwcOuJrtSWneZoQWWNl9WIqj0Er8ciRmCxdNFwC8DR7YtPJWu5
         1U4+Ybh9tUKakkdIULGZKUqxxs5dv4NASkzGsC5qYeysE1g/+wsYis90zREsG8dLb6s7
         UTtDumqbJxSmEHqou+A6idHLOftjhcReZ3HlcY7OPWGyb5UMuKjMnqKwe/mlsKmReuxi
         JmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788348; x=1763393148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y7AbbQjoW2c7ZR6ncveQ52gAnz6KIPcgn2CEQordzs=;
        b=stmxFgcKvZyGXKxTtqF9sla6DLLCV9C2XyWlwGztk7sHcV7MW7UsX2/RGm94vHGjL2
         JGmZsxCapB5bCXfPXTES2qGeH2joWWIgrWqPd6FlTb+/PIJ9lnBGmtEjwALLh++8DadL
         MRa1twIT3ii9h3aitzX5CU/73BgH9OnVCnhVfb7OWwibLLHMdkVJmQCZ0ZPuFsgiPh18
         4UHor4kjvPJNQHGXc5Ugm9XEySp6U0Zo/guVy1U/1bRIaKu7bbKm+WC1JuQeQ3CxZDRc
         J8LXvdFnNQ22iF9sYDLttgMxQgmRKZ0cZJrdYJU7r6bsZF0UE6nl4y4vaGJVQ7hAycjp
         Z0mw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Xj3Nu4coZEeIJhtmwXa9BzMZrTo3SxNlVkE5dleNjL9nQDYTtPSybleU5uGpDexNazap+MZW0xsF@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHnAzUWef0+2JNDB6hfPRl9ATCWXM3rTTOre8gI8PsHB/Y+a3
	m1FKOLiRxR3fU3j9TwhSczPU7eCbTnAaSunVJeoZQX1loPpeBPcPeUVv
X-Gm-Gg: ASbGncv3IdCSyN0xtH8LHwPnttcDzGiZoFVtDwpgb+X8xCL3fyJXp+o434PiWf1I0Ra
	WFzkXlw8nHqQr9uQmz1nAZ9WxTPAe7wlIDn3Tp324vz6egej2rBaKRk50kApNOoQtqj/mX1HDt0
	bqV+Aohgr6NNfhkkySolmWImk5ANh5UsIbVhKCxtuG7WPsV7GN/4pqQa8bRqBQEbqLCGFk+3csU
	YThkftzDYtPvSaKOvPQ8qPYQSspcB7XZs8Ds+EbbC83v/LnkIuPxAoFtpJo1D2mhZmtzO7rJ9VI
	e6e1u4r53ToiLsoDChRfeJotxQgA5S6x19WzKsdd/qDT9B+z9GZ3Pz+68qbRYr+LhvrTi9n7BDi
	aBPX+uSBqjWIcXpA5AbBC0gSb7LTvpdesO1OizJ6NBxRfIpp7sKryzOQEUmQgE3Bbx0CC1H3e8Y
	8fyfI0DXky75mNrWY2+9XW1MscN+rsMXezy+qadwD7DjmXy1UouRZyBtBsfvfED4K86Y6LJA==
X-Google-Smtp-Source: AGHT+IFZ8Hdn9bIBL2aLClDGCYweA+vbXjTWrk0GlGrm/tskYdFblhNV3v9npKdqEcfWPsY9ou6LMg==
X-Received: by 2002:a05:6512:3d04:b0:594:27fb:e80f with SMTP id 2adb3069b0e04-5945f1c258fmr2134855e87.37.1762788347931;
        Mon, 10 Nov 2025 07:25:47 -0800 (PST)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013a36sm4059381e87.14.2025.11.10.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:25:47 -0800 (PST)
From: Alexandr Sapozhnikov <alsp705@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10] gpiolib: acpi: handle overflow check in acpi_gpio_adr_space_handler()
Date: Mon, 10 Nov 2025 18:25:44 +0300
Message-ID: <20251110152545.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added an overflow check when setting a bit, since the function will not work 
correctly if there is an overflow.

Found by Linux Verification Center (linuxtesting.org) with svace.

Fixes: dc62b56a68d3 ("gpio / ACPI: use *_cansleep version of gpiod_get/set APIs")
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 834a12f3219e..dfb421bff979 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1069,6 +1069,11 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 
 		mutex_unlock(&achip->conn_lock);
 
+		if (i < 0 || i > 64) {
+			status=-EINVAL;
+			goto out;
+		}
+
 		if (function == ACPI_WRITE)
 			gpiod_set_raw_value_cansleep(desc,
 						     !!((1 << i) & *value));
-- 
2.51.0


