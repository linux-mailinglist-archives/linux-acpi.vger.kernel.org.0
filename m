Return-Path: <linux-acpi+bounces-10460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7FFA07B4F
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6263A8ED3
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D8F21D00E;
	Thu,  9 Jan 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkO7zKNr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF821CA10;
	Thu,  9 Jan 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435341; cv=none; b=Bhm+MAE3IXJ4t/MezEPTBCzX74xWDPmoqX4sQGoEomqNOH12gYubDvy/wBW60qyPojSK4tR123i5bVBLiS9YQhkUcX91TEWGlb/4UqhorZYXn/D/BpHpu0FWbTrl1I9Y6SJhKQxn62MBbAlmG/B5LoLKLELtECzkxWU7pIzZT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435341; c=relaxed/simple;
	bh=gYW9aV+qhwvXSzR3wKKONocs/wa6M95/gqFjvC7QP68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjqpsosgLRyOKiNsPkvV04PWpNwXioNNbNpJItqT6GH/8TG6C9rvy7DROqkRGSfML4DqAEpi1+BBRuj6CTttfYZxJbRqJZ6U3Yn9W+omfxuXd4QfVdGbXeAqvRKa8Sgs7Ojt/LPZgsP2LnJPxBBN4pMCwX+KmwP30K1z1pnNUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkO7zKNr; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4afdfd3124dso347190137.2;
        Thu, 09 Jan 2025 07:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435338; x=1737040138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Iy/iNzO4iWV7mgCauIwixil2V9UKIGAzdPrdWEMOSA=;
        b=ZkO7zKNr+NMiaUT79dVAOYxINAPeRJ9BZU+bFN4smcSqexkEEtaA0lyE0jeId2hvBW
         b51pucQfZmjSLsZMJg8qA+dmqivBzic7J1aA7gkBCvjbJ8keYcBohdcPXf8/z1Qh/O1v
         0pYQzrDd/k3QcB4TFKJnnkra/bGIBOe/jzbvQPW3Js36i1GZcLKuroas43tUWYMvlocT
         9HuuRY1yWxZZEhpFmOmvzWAnEcwcIoZmqgzcovKSnZTxhniTyPotG6WeEsPNIf2wiazT
         KIxEZNRXidUamX4BI/9BrWjqhlxuLW9ZYDYpx6ZNXmweX/HmC9trfDZrr9rq4qpvQ5rW
         rqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435338; x=1737040138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Iy/iNzO4iWV7mgCauIwixil2V9UKIGAzdPrdWEMOSA=;
        b=U4+ZrkMRfBHCa9dnzxyAf1kI65OU1Nj9IuCkai7L23CB/FZMshBDFG8seHfyzvTAUE
         Xptsx3Uc7sAFlhn4sCKPe6LK5ztynQ5kZzfLfJ4hqUvk97iBL3XcpbfXeTgYOzUf+MdA
         Z/us0Yrlml4k2h+KRw0Cgo/jYWKuNJbW2rbKuCkCFELZmWUjI7csUmbSte5oGrZ9A3XV
         ra7uzcLJQ6MoXcXjKbQBrn8gwAViUQibk+ozSrZ2We9jOZZaBC5obe4hFp1eQOUYJVrS
         icXzRVviYpUrfXWB+Z+ScW648iS8eqmTwjBWuHvRzEbQskxF1V3HJ1tiK3gP+JBmbRVk
         LsJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTuoWMw41C9BYQ1RUAv0oo3B0DWynBeYefV0TCd10HrKXmsFn1LmwWqkteVB7BHqRggYuZJcvtNXbRZBCT@vger.kernel.org, AJvYcCUUX2jWdi0BUyK/YgRnP88SUgWHgceSAlnIL11XnuwqmDKngO0HLc652dZkInlz+XiU0hqMTfVVSRzY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Wm6y8ZWXAR9jnu2+laNi3zqlgiw+v4Xo2plorJ0iRAPbiavB
	kq9d8KLfog09R8HVBAhLHvbtpW1GCo4QVX7MN90wj6yx+h/EQtgP30kTMhCe
X-Gm-Gg: ASbGncukA/bXxwQdqQGtIR6bztJXf4a6AeUTg6sjUCSNuCj2Kep80yTKpcumzAqHuXN
	FPpAfM8lUKZTDnlgymLKHNCKytiMkmK6PB9UsRnYDXdLjqFFmVJqw9kgTiUqgtVO8tiLdea7bpo
	jwXWRtN7ZGp3g1UAtBiSKDW8WsyzmbxYRl1qjEtDF6qlQ8BiR9wEj/kWMfCQuiBVXsS3xnwQ0b6
	Ep1RZJ7fCtyQa/7GNQrGwicwzUUIe8ivr4Jm8P48jHXwmygd5q+uXYmJw03auK9
X-Google-Smtp-Source: AGHT+IHhytoth0TPlZhKT5Po3SIoqiBBAvw/Y0vwolJzl3cFFRKKI5U+Jy7TwEWCy0sYJWmVsB2vLw==
X-Received: by 2002:a05:6102:292b:b0:4b2:7446:fc18 with SMTP id ada2fe7eead31-4b3d0fb67bemr6272819137.17.1736435337763;
        Thu, 09 Jan 2025 07:08:57 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:56 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	Joshua Grisham <josh@joshuagrisham.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Lyndon Sanche <lsanche@lyndeno.ca>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Ai Chao <aichao@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 11/18] platform/x86: hp-wmi: Use devm_platform_profile_register()
Date: Thu,  9 Jan 2025 10:06:24 -0500
Message-ID: <20250109150731.110799-12-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109150731.110799-1-kuurtb@gmail.com>
References: <20250109150731.110799-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 2cf1da00d5f9..8a620d36f926 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1652,7 +1652,7 @@ static int thermal_profile_setup(struct platform_device *device)
 	platform_profile_handler.name = "hp-wmi";
 	platform_profile_handler.dev = &device->dev;
 
-	err = platform_profile_register(&platform_profile_handler, NULL);
+	err = devm_platform_profile_register(&platform_profile_handler, NULL);
 	if (err)
 		return err;
 
@@ -1714,9 +1714,6 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 		rfkill_unregister(wwan_rfkill);
 		rfkill_destroy(wwan_rfkill);
 	}
-
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
-- 
2.47.1


