Return-Path: <linux-acpi+bounces-10648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E41A11A7E
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA47A18892B4
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F09522FDEA;
	Wed, 15 Jan 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEBWjOxT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22021BEF9E;
	Wed, 15 Jan 2025 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925076; cv=none; b=D2SNLpu3708PQo9/HkGn5xkoTIZZ3OKxo/TN/ChNu0fg/2cFxRkuGV9MWI+2rfivTLncULg/O8iByqswUwFemERbvjUsU+EC9VZ55jBRCKWHa+wcmL+g+DXi/LloCHsCsTmT8GZhkOKKZ5tjPQdjcR93W+9a0NkRvV2JjSagEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925076; c=relaxed/simple;
	bh=4fxqI9phMz83ho7mlRkcoDfukZks609Ewy0/2yKeJyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFe9sY3fnNFTkoqA7QWm+pjf8gGba0kSekYor8nRoJ+PdnxTvy2nsOcXha9QFPsZ/+kjx7aqV9zBIZovXruQw1ezMuIJM6JXiU0JmLIDCZ+HMai1PcMV1o44qYxzfAZM3J+Ie9XQjKhF875KpYXYSb0YM3cYLLvFXeRAuCkUTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEBWjOxT; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85bb13573fbso1814713241.1;
        Tue, 14 Jan 2025 23:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925073; x=1737529873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlsStkftLAH2Ux8McUIhsA8XnUFbwhAZcRGBt8ITERQ=;
        b=ZEBWjOxT+55P/5Xpg88IsXNJ5ms/eqNhQQZ8xiGXneEX9EsHKSASvEIiSJhLHaCkH/
         2A6QxMRsLh6l3R23or1rmUvFPEonAworCYr/B1HVZxaOcauTrqUZf/vZM0TPO5bC9gO+
         y4nJExvbGF6OJ2i3gZZUNq5lCNIYVhvcgc2xmbTjw8f231USJtmNQvZSAOOH/ykUHOhq
         SkeIHOz1nys23znz1rYkAxTSc/djYdqSVG79yYldsYkVUS6UY1osxHRbnDib/whN1CWS
         B31DPV+WpVNgxcPPPFfDeMwAAvAv6MNLo0j4uY5bR79DnqpDuRZ3gCuUpH+zQMkEJPwg
         hXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925073; x=1737529873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlsStkftLAH2Ux8McUIhsA8XnUFbwhAZcRGBt8ITERQ=;
        b=fDIGyYYyqoe6yF2S97D0OySqCLPc0c6pzFmM6z37+V25PiReKR4n0Ne168AFoe/uL4
         BiopkpKejKV/xqYjWVDnmY2K7FBO1K5VwdqA5zWQsieFEPk81Jx2i76Uvx+zjzws2gxP
         RYcLirMyvlSJ7RhV0+ukXjLoO1dLmU9a6T89fZTclAQHVpaGoHWZH0PeWHypvT81lt+L
         ep/xvKSoNopArR8qA9i6BSvHsa3EGsN9r+Vu/IO5IKj9ZMRiqaHnjfFux/sHkbYwpbxP
         DSrQQovyI9SpqCqoNADTYuHi84j9FJATkS7+pElrMwsUnG4qvu3mFUXi9+QO1rLbvEGV
         0Rng==
X-Forwarded-Encrypted: i=1; AJvYcCUjdg4LZmfeMQnYTM0GcbTCpApf0zVZ0819IbNju1wOO8XntoVQNfMNbYXkpeIukYFQWQE9MjH/6B8t@vger.kernel.org, AJvYcCUl8U21K1onm+4rkUhR6zV52MyirTOp1iWvnl7GRmo3A43EPhbDol4HQesItSOt/PgiOu/s1SMN+l1xZabG@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzOS0Pk2VytdIIpJk4flFGhc4/8bBLjykLvq18pbBsAgJ3KUl
	aG9XMWe0qjdIL9khqpFU+Xqe5ed8h5Iq6d3y84ruA8x90tXuxAzYK4Vz0g==
X-Gm-Gg: ASbGncuJty3N+/pMIjP9q9DYKBfl6L3JI8abcjBpazjDguQdUslck7okJeQBpWoKKCV
	5L6KcHkVgUR8fcigZQp5z7YerAP2d3MBrq55CpXIFPX0IE7lOdyCpxC1XO7Z8NCxxyMLu0JlFcL
	ilxZeOOqZRrnOvdCuWaw2gXymc2BIc1u4jp8ETr1hH4ofMc/DqC2zyLUg8hQR3tlWiIBf4/jORo
	6LUBuVBva83rX2idFwAPdSGLegpNX4wGdgSBd5/BdkNRc3v5rr9TDugz057gWFv
X-Google-Smtp-Source: AGHT+IEdiSeZMxfLDyKqQLr4bWZpo5QW8wx72sbtY6EKlVZhyotYQYnRfIde70Qirn/XF+rTPt++LA==
X-Received: by 2002:a05:6102:d86:b0:4b2:af6e:5fef with SMTP id ada2fe7eead31-4b3d0f8f84cmr24403867137.9.1736925073256;
        Tue, 14 Jan 2025 23:11:13 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:11:12 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	"Joshua Grisham" <josh@joshuagrisham.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	"Kurt Borja" <kuurtb@gmail.com>,
	"Maximilian Luz" <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	"Lyndon Sanche" <lsanche@lyndeno.ca>,
	"Ike Panhc" <ike.pan@canonical.com>,
	"Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
	"Mark Pearson" <mpearson-lenovo@squebb.ca>,
	"Alexis Belmonte" <alexbelm48@gmail.com>,
	"Ai Chao" <aichao@kylinos.cn>,
	"Gergo Koteles" <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH v3 00/19] Hide platform_profile_handler from consumers
Date: Wed, 15 Jan 2025 02:10:03 -0500
Message-ID: <20250115071022.4815-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ilpo,

I left acer-wmi and hp-wmi class device variable names as is, on patch
15/19, because they are global variables and I believe `ppdev` is too
short for globals.

~ Kurt
---
v2 -> v3:

[01/19]
  - Dropped #include <linux/kdev_t.h>

[05/19]
  - Add dev_err log if probe fails
  - Log empty `choices` with dev_err
  - if (err < 0) -> if (err) when handling probe errors

[15/19]
  - Check if ppdev IS_ERR instead of dev in
    devm_platform_profile_register()
  - Drop pp_handler from alienware-wmi
  - Replace sanity check error log with WARN_ON_ONCE()
  - Add an intermediate variable `ppdev` to store
    &no_free_ptr(pprof)->class_dev right before we pass ownership to
    device_register()
  - Break lines better in all uses of devm_platform_profile_register()

[18/19]
  - Fixed kerneldoc for platform_profile_ops

[19/19]
  - Added

v2: https://lore.kernel.org/platform-driver-x86/20250114153726.11802-1-kuurtb@gmail.com/

Kurt Borja (19):
  ACPI: platform_profile: Replace *class_dev member with class_dev
  ACPI: platform_profile: Let drivers set drvdata to the class device
  ACPI: platform_profile: Remove platform_profile_handler from callbacks
  ACPI: platform_profile: Add `ops` member to handlers
  ACPI: platform_profile: Add `probe` to platform_profile_ops
  platform/surface: surface_platform_profile: Use
    devm_platform_profile_register()
  platform/x86: acer-wmi: Use devm_platform_profile_register()
  platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
  platform/x86: asus-wmi: Use devm_platform_profile_register()
  platform/x86: dell-pc: Use devm_platform_profile_register()
  platform/x86: ideapad-laptop: Use devm_platform_profile_register()
  platform/x86: hp-wmi: Use devm_platform_profile_register()
  platform/x86: inspur_platform_profile: Use
    devm_platform_profile_register()
  platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
  ACPI: platform_profile: Remove platform_profile_handler from exported
    symbols
  ACPI: platform_profile: Move platform_profile_handler
  ACPI: platform_profile: Clean platform_profile_handler
  ACPI: platform_profile: Add documentation
  ACPI: platform_profile: Add a prefix to log messages

 .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
 drivers/acpi/platform_profile.c               | 172 +++++++++++++-----
 .../surface/surface_platform_profile.c        |  48 ++---
 drivers/platform/x86/acer-wmi.c               |  58 +++---
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
 drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
 drivers/platform/x86/asus-wmi.c               |  55 +++---
 drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
 drivers/platform/x86/dell/dell-pc.c           |  60 +++---
 drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
 drivers/platform/x86/ideapad-laptop.c         |  45 +++--
 .../platform/x86/inspur_platform_profile.c    |  48 +++--
 drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
 include/linux/platform_profile.h              |  37 ++--
 15 files changed, 467 insertions(+), 309 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile


base-commit: 58126788aa7726c0e91de6b25e6e332fa06089ab
-- 
2.48.0


