Return-Path: <linux-acpi+bounces-12406-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B013A6CC92
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Mar 2025 22:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4A87AA4C1
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Mar 2025 21:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983CC204F66;
	Sat, 22 Mar 2025 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwCUXh6B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2D6AAD;
	Sat, 22 Mar 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742677457; cv=none; b=Dm0UtgOlNderzbAd4iTZ5DJ/EJh7wlRiZcHHsaFI2HuNY1mZuwO/XLW5UgwOk/QitoW2h6j848ixEA304rsNR30ny3GmmPrc1VewbszQot4RfRrcAi7cM+jwn1fmiwhQE2EyK2CcxhlrHvMo7FU3HW7SFaYNjqSrDLeHOS5CDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742677457; c=relaxed/simple;
	bh=UoblSZhYFn43TYAhpP/6qsDP/KTK9Kg/4h20SGoQtn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UkUN2Eq6GPHLNMdfSLqjb8IE8uZeH6ikzH+Gxzum4M1kCPFn/2uU0Oych9ZZq/kK1XdCyQnRZNIhJEo0vDqhKAS3Kr90ZNGvSPFX7zE+O92R2eiPA76v7CmdKjX/wSI50M9gsJ2TtAnj4kJ7mQuMEx9EKvuIPyXhFeZ9JVgs8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwCUXh6B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225fbdfc17dso48908215ad.3;
        Sat, 22 Mar 2025 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742677455; x=1743282255; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAtAdykgv5G1Y8t2VeTj6XiiQ2E2aeRKOIebizLrXZI=;
        b=WwCUXh6BpnXiJXisoONgcVwelqapVo4mo6byBFx82JmpM1lBq1IhW9krL80MaA+bE5
         aCq5PsCPdrHj/tLD3ARtRcIvgLcMopBRQLzkvs0Zi+97s+0k0Xc7IhBOuhhvaDAMQJT4
         peyp3Yugf0hrKNWpCIdjVeIy662XsKEbcHnHAdXVzI8f6d9WnfW9tmbd0LcuxYpYrcPK
         48a0Czk3VCpe68pFQ0kqCmZqDKrJgAXYpd/fRDvF+znXDlHUVWwwKxe9vvvUob3wIjGo
         hMSv1b8qV7qOxb9J4ke0+NYB0uptQEtUUlfbmmPfy1xI/h5gWYDGSmErenRUtVvkwuxf
         xltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742677455; x=1743282255;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAtAdykgv5G1Y8t2VeTj6XiiQ2E2aeRKOIebizLrXZI=;
        b=OULYMnclY+WcM+l1sbgsz+b5Karg22lCNJ1CV6gN9KhX86qypoNVHmdWCNUpmgZSLm
         5PppgWt9nAtx/7x8oMO8v1b+dxnfx4v8ISamhpik4e2RBOnILreC//TKm1RVeTCjl1Tq
         X7BrJ742hhkhjY+hDTKchXZvqVH58hMEmdT41KXC6OKzeQjHlvGbHiK6gdr7UEAXvH8q
         lScE1JPQqdFHq7cr+JzBPzo1Iyocb0hvlW7RWtUt+FAvQkBAIzWUIRo893u4bGrxzw9s
         mbzHv+f27+dqUpBGKdzTtDQZAfSxjTZ4cTwqh9iCkASnO54DAfCdVPHxEdTgxvJ3Bpsy
         tVFw==
X-Forwarded-Encrypted: i=1; AJvYcCVZp+20rX7f1b4DJO9cjvBQsECmUqtL+wrUZcvgOYx8S9kE+4utR07YG0CLWtEBN5B5tRxmmIl3WHj/@vger.kernel.org, AJvYcCXNdENA6dw5BmUjOaHBIxblN4MjjSDLxTcEwhM6OTlgbgZaR84vmDTRuUZePNFUGTbjnZKlYjPQP57MJubS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx558uO+UpltwPZ4uTL1qFbUQrX50xfiRZQBBof7VSXcyqHZPHI
	IEQYMJtkcXPSwTYSEVP0LhRPBAJIn7wckj3Mo21wUUYGHhPdPwpBlQRtMg==
X-Gm-Gg: ASbGncvsGMYohgF/GwxgVnxuGzBuyIRr3vZcY+73Z9bmHC5p0RasexlYO0xWz1cW/tj
	81eBfRM2NkRnVk+zc0kxmaDQ1koAkDnScgDG6IEqdZF1zPffQnKE6V1V9RUrdAZOvQmuB8qwjjM
	KmZeD5vABSraPNuZEYGgtBExpLvXgI7rBUPZ/2IWAiTL00S0lvM7uC4C82lqv5vRCONOjsa9DtP
	tL7VVRTZ2tjnVx7DxYDRvEKbyJ/Ck7sGvJvIlOFLXnTy2VToZ3ylkeWJX6KEFv7cUhfi00EMEOV
	wos4m9OxJs2qdRePVA+u4cLZVL8FSJAZ9yOsQq66V+EP
X-Google-Smtp-Source: AGHT+IFh8nERex3K939/qb++TUQrdcSu6jo0dDWgImyOLhFeT1WIyyapBk095HoYhekkvbJ9vlep9Q==
X-Received: by 2002:a17:902:c942:b0:220:ca39:d453 with SMTP id d9443c01a7336-22780d8004emr116438955ad.17.1742677454640;
        Sat, 22 Mar 2025 14:04:14 -0700 (PDT)
Received: from [192.168.1.26] ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2bd8sm39993635ad.112.2025.03.22.14.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 14:04:14 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 22 Mar 2025 18:03:37 -0300
Subject: [PATCH] ACPI: platform_profile: Optimize _aggregate_choices()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-pprof-opt-v1-1-105455879a82@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKgl32cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMj3YKCovw03fyCEt3kxETzNPM0YxPLJAsloPqCotS0zAqwWdGxtbU
 Am5L6zFsAAAA=
X-Change-ID: 20250322-pprof-opt-caa7f7f349b8
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

Choices aggregates passed to _aggregate_choices() are already filled
with ones, therefore we can avoid copying a new bitmap on the first
iteration.

This makes setting the PLATFORM_PROFILE_LAST bit on aggregates
unnecessary, so drop it as well.

While at it, add a couple empty lines to improve style.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index ef9444482db1982b19d2a17884e1c3ab0e5cb55c..b5b24b075af6dfa612d56eb95342c6af87a60d3e 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -256,12 +256,10 @@ static int _aggregate_choices(struct device *dev, void *arg)
 	struct platform_profile_handler *handler;
 
 	lockdep_assert_held(&profile_lock);
+
 	handler = to_pprof_handler(dev);
 	bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFORM_PROFILE_LAST);
-	if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
-		bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
-	else
-		bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
+	bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
 	data->count++;
 
 	return 0;
@@ -305,7 +303,6 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	};
 	int err;
 
-	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		err = class_for_each_device(&platform_profile_class, NULL,
 					    &data, _aggregate_choices);
@@ -422,7 +419,7 @@ static ssize_t platform_profile_store(struct device *dev,
 	i = sysfs_match_string(profile_names, buf);
 	if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
 		return -EINVAL;
-	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
+
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		ret = class_for_each_device(&platform_profile_class, NULL,
 					    &data, _aggregate_choices);
@@ -502,7 +499,6 @@ int platform_profile_cycle(void)
 	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
 	int err;
 
-	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		err = class_for_each_device(&platform_profile_class, NULL,
 					    &profile, _aggregate_profiles);

---
base-commit: 9a43102daf64dd0d172d8b39836dbc1dba4da1ea
change-id: 20250322-pprof-opt-caa7f7f349b8

Best regards,
-- 
Kurt Borja <kuurtb@gmail.com>


