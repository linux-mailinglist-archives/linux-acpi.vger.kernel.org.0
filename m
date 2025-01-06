Return-Path: <linux-acpi+bounces-10359-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67FA01EA0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 05:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3357A12F0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 04:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F354C1AB6CB;
	Mon,  6 Jan 2025 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThRBAJzh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96714B94B;
	Mon,  6 Jan 2025 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736138799; cv=none; b=RfNtTeJ5q9nmRnjObuHe4fa3wcMp5YVKEfVTunF0GpSTxGk4vBK6uBTZ40KeXApqXGvJJ5RwbAIAoTuxRozHk8kp+uZtYMFmRLlopaQvezwkh5gorWMICM34+Ysi62Vd0gXLoNi8L83RoA6Ov7zjudhd5ZFl+fAoahL279FjQFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736138799; c=relaxed/simple;
	bh=0UK9rbMYelMqeMWeC95Stip6XcGeeNC73TeXPHxGM2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b54Hsx6LNfC37VfgSsDFkCMRkuxYaZZsUms6JGr8cGXN0Yd0OBHeHpznkrYfdj5aX1x+VWzspv26I6n1v4U7z6d0jd7gCrn7BFKZ9X+4Lg14Csg/vPUpA9MIQAioNnhdSr0Vstu0oxP9QOLGiKC6J5kZ/naFEnDvN8jStxGVl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThRBAJzh; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4b2c0a7ef74so7897998137.2;
        Sun, 05 Jan 2025 20:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736138796; x=1736743596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMfjSTD/Y23SgFVdemlIyRQvnFthuXsFFp+nN/PUiP0=;
        b=ThRBAJzhZaEtFjGmMJIAqAnperpdRzlfwkgQ1jykY3lgRgfoIwJaxnAe8sS8U9djou
         8OHpETt2aSZkVHp9hGALbWVTZDVEh+Z/Qv8qt9JEQM90gYRrigllgauudpFlLS/TzV9d
         RzZVagnQB85orpP13v3+jN2a+ILkgkUvWtkvgGHfaS0OBBXktYeNBwiLSM/7LJXdEl6m
         +0vecCYcmkOlCfItjAk4m9mrN9CLb8wtw4BLRND4rWTyaLDdKXJQJhabskiWo3oETPxu
         llVaDoTaLodC0IjtYzJnlTwvT6r8FzEPEM09t9CrAbDCXoqAwCnuBlwcd0z5q9K0Y+2p
         WHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736138796; x=1736743596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMfjSTD/Y23SgFVdemlIyRQvnFthuXsFFp+nN/PUiP0=;
        b=bks9SRTPJdVU5OVy7XrV5omlb07+yfF4qyk0ZXkORpMMEn3aqGbrJRt0Ip27IJaOQD
         EolR9mri80vpiODPUgao07/0wZ7Kcz27YBC323LGXG8fr8hdbmODs1TEV5V3ydjv9m7G
         AvVRgjDKNdoQb6MHwTHEF/rieywd636ifEEUqjfcn6HHbxYmT4nMniyiblkrz5UqW0Xn
         BGKkeTeoQRpz7KQmWaO2BIzzAxPavDY5ieS8jtaoZ7u6UAejxJsfPvZkHcPt5nWOehrb
         AXQcc+xya0s5MdR391i9d06/BYdX2tJ62G8U5P6jjLLz3piRr4KrkVsKElWuLCoDOJWq
         3iPw==
X-Forwarded-Encrypted: i=1; AJvYcCUEQw4oNHRD9fQH5LLIVty4EYut40D6eo9k1V/qNlg+vlRa5IW87LRSPrDylpr5Q+6sWTWmy5WO4P4RGwjv@vger.kernel.org, AJvYcCXQ6WbT8N/9EDRv6Z6LfeybAu7vF0R1YZedqRMuEB19wAkOZqdiF98Z/dlmiHq0uY/OawcpJbJYASX5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GWeAruEKIR3kss9VXaP5vm9B33YtRu+AjblOP4tGTctmcLWr
	orZmDrkL5dxqb8iPd7WthKFPt5n2wB80mT8bsK7Odz3LLjJb16cm88E+4oUi
X-Gm-Gg: ASbGnct/OGFrL57oRSjrKet4KGilaHbzBJw0EFsGDkRb2Yja8oPaPR2fB6eCOM1ghKS
	HmH2OIBKEiLR2+0eK6pa8oKDg6g0caEeDPflmLDp7LaF3wZXHcI5lGVKzty/BudaCdqnBd6he/v
	E36tMTXVuOQmiev9bp5dvMy1VCqmU2r5SCDveuRNaPAAW/pOr9P1vJoy7fFyipCaIf1gtWxRdXv
	pzw3BO9OBXcdxmz/aHEQibNU47JmueEUO1UbMhxHK/LrWXkHBvCopyP9u+k/1fW
X-Google-Smtp-Source: AGHT+IHAz58NwnGlKi8SyoMcgpW+cwu7YkwN6dC5ukWfnVdSdbxXzdJSnELWSOKyQgDq4dYG9qzPZw==
X-Received: by 2002:a05:6102:6e88:b0:4af:e61d:e22f with SMTP id ada2fe7eead31-4b363593900mr10310184137.24.1736138796431;
        Sun, 05 Jan 2025 20:46:36 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf98d1c9sm7083507137.4.2025.01.05.20.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 20:46:35 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: josh@joshuagrisham.com,
	hridesh699@gmail.com,
	derekjohn.clark@gmail.com,
	Kurt Borja <kuurtb@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Lyndon Sanche <lsanche@lyndeno.ca>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Armin Wolf <W_Armin@gmx.de>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ai Chao <aichao@kylinos.cn>,
	Gergo Koteles <soyer@irl.hu>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [RFC PATCH 0/3] ACPI: platform_profile: Let drivers dynamically refresh choices
Date: Sun,  5 Jan 2025 23:45:48 -0500
Message-ID: <20250106044605.12494-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Some drivers may need to dynamically modify their selected `choices`.
Such is the case of the acer-wmi driver, which implemented their own
profile cycling method, because users expect different profiles to be
available whether the laptop is on AC or not [1].

These series would allow acer-wmi to simplify this custom cycling method
to use platform_profile_cycle(), as it's already being proposed in these
series [2]; without changing expected behaviors, by refreshing their
selected choices on AC connect/disconnect events, which would also solve
this discussion [3].

Additionally, I think the platform_profile_ops approach would enable us
to hide the platform_profile_handler in the future, and instead just pass
the class device to get/set methods like the HWMON subsystem does.

I think having this kind of flexibility is valuable. Let me know what you
think!

These series are based on top of pdx86/for-next branch.

~ Kurt

[1] https://lore.kernel.org/platform-driver-x86/6a9385e6-8c5a-4d08-8ff9-728ac40792d2@gmail.com/
[2] https://lore.kernel.org/platform-driver-x86/20250104-platform_profile-v2-0-b58164718903@gmail.com/
[3] https://lore.kernel.org/platform-driver-x86/20241210001657.3362-6-W_Armin@gmx.de/

Kurt Borja (3):
  ACPI: platform_profile: Add ops member to handlers
  ACPI: platform_profile: Add `choices` to platform_profile_ops
  ACPI: platform_profile: Add platform_profile_refresh_choices()

 drivers/acpi/platform_profile.c               | 39 ++++++++++++--
 .../surface/surface_platform_profile.c        | 24 ++++++---
 drivers/platform/x86/acer-wmi.c               | 35 ++++++------
 drivers/platform/x86/amd/pmf/sps.c            | 23 +++++---
 drivers/platform/x86/asus-wmi.c               | 24 ++++++---
 drivers/platform/x86/dell/alienware-wmi.c     | 19 ++++---
 drivers/platform/x86/dell/dell-pc.c           | 34 +++++++-----
 drivers/platform/x86/hp/hp-wmi.c              | 53 +++++++++++++------
 drivers/platform/x86/ideapad-laptop.c         | 23 +++++---
 .../platform/x86/inspur_platform_profile.c    | 22 +++++---
 drivers/platform/x86/thinkpad_acpi.c          | 23 +++++---
 include/linux/platform_profile.h              | 16 ++++--
 12 files changed, 237 insertions(+), 98 deletions(-)


base-commit: 6b228cfc52a6e9b7149cf51e247076963d6561cd
-- 
2.47.1


