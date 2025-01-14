Return-Path: <linux-acpi+bounces-10601-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0142FA10AFC
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D61F168087
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6FE156885;
	Tue, 14 Jan 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ7b/jtf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A1232422;
	Tue, 14 Jan 2025 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869089; cv=none; b=Q9TBMsUu0h/H/dVfrJQETD1UlvBMmEaLiBbV0+p/AX2xnEQD44wC+l3EcuBtO1YpdMzFOssrXcE1OzQ3l0fkPa2ugin8gwcm0v12wyHds3qCzIonToulcgv64WZ2E/pxE5eEeOANIT/VKmbhhDOY8xy2JuVo9rj58raJWeHYfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869089; c=relaxed/simple;
	bh=FKT7LpmC/KgLbkhhg563slhkYuuo+25wRKhGL6TGztM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxhDiqOVBEc5GbtpZPPNNibxexjdBzgMvKJk3K4hJqmCaseILRootNgJ9GsMEyWTShWtwDiUfMoN3rTcECCBjnGvD7tEhBlScqo9Eccm4NE2OnTBE5QT9+JWEs4P3OqqfdFB/yeLpIhwF2dTX2mjxd4K0sPcZtlOVW4QhEFCDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ7b/jtf; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51cd05384aaso216439e0c.0;
        Tue, 14 Jan 2025 07:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869086; x=1737473886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6OcBLSiXj43UWw6kP+ylSaU+o5she7C6HdRdC/cjns=;
        b=ZQ7b/jtf0W/9dZ6/bHjdRVfFwz2EQkZX9vFHxw4gvaEt/1krABJ9YZAbPiR1E7NfLa
         WneB2f4uzlccloDuILjRAFjbsXObRFiizrUig1wZSpSoRqBncGC17AY8/YheiuyUlGUx
         D+kJNPj+eqP1g6q3+KUSEGQh+/eiPnFc8VQnILu6hOvZWWPq9Lvt3XmgG1iVRBeWlE2j
         DjOIRUXmYsHW6ZBPz9+8gPAcq4VBUmVFacW1W2CV4/HGigTiUMH/zv9sW6q4Bsv/O4uP
         Qej+WQeK53GBZfAo7RVvX5KntyD3TY/f1vYwK2QKsXcWIvn09uvX9tzavaMBEIy4AvIS
         ju8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869086; x=1737473886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6OcBLSiXj43UWw6kP+ylSaU+o5she7C6HdRdC/cjns=;
        b=tEzcFshGW3xxlu0lroGlIBNZGTtZBYeYo2Zo1QqQzx6de2o076b7ldEJFXLVvWQHb0
         qbIqWnbkE/OrnW3pMMSntrP0bZ5sXjbpSBWScyBn3/a3/IPymJMmaKcEG/Pz0lX69wwy
         boga5q0rfCyBrCb8hK6ZoUqM+wyIh9yo72QLWWQ6CrA4Y/NXgl3V4k/2MUPfWZjdIbLf
         K+NIUjuON9HsDLvSJCaH5Upkni+1LPca2rXCL/UWgoqC4GYHLpyxjRJBGtyy0P3e/bSa
         Nt9efsIWUoxMsaIVgxkJ2NhjTDJlZ/YxxSJEqWhqF722s7pi7asmOJpxefsyhsm29E9u
         KlGg==
X-Forwarded-Encrypted: i=1; AJvYcCVa4y+LOAsdw4srt/bs8FkJSbYuQB6ZLieioHF2KuTi+UxgylKHnG2TcL1Q7mcFZgIZvvL53K1Mwz2WgcdL@vger.kernel.org, AJvYcCXyHNR/y2UgFCHKo2hRFNCjpizciEZezHfzgapq2eVwqIwMusjNA/rnxjGZSgV6EGf4CmDKPThwsvQg@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+Y72ffRY6EI+yLnB8vlDZ91D4PrfUl7cL7xZdv0lnKRP5lUb
	oftvzSm2Tp2dFUcrNLXRabxSe6fnKK9uttIXXuTxCP4FiwA182QfKIg6Ow==
X-Gm-Gg: ASbGncvXcVZ2uqfcdCTxzPEmT6B5POxnHZiemN3JqbXT1Ni95FgEs7q90XSxQh0f+cq
	op4EBbXPTNykqOKBObPXtdlVc6COyEMkfHoxAo3J2/ooXpMPd7q7OlcbUiSMnYZtiADltBJpaaI
	nLgv31vlMEkZDB4tFkvoksdRtXzxjxjW+MHwYhSIggfwmEiq0+GuTRMQYwTm9ZnqyFwl3Feb40A
	Ost2sO4f34rlRrwZDuFnZ7YScxcONApQZwtaTllXRIL6AmgURgjeb9c4UAf5waq
X-Google-Smtp-Source: AGHT+IE8jHUpgvWGxondQBd2bR/hLYSS9v4Lm2B1k8zYGh7DUVExCKbtlPX9v9yTDrq0bu/Cbe1SZg==
X-Received: by 2002:a05:6122:c94:b0:514:eeba:517 with SMTP id 71dfb90a1353d-51c6c532293mr19159278e0c.10.1736869085689;
        Tue, 14 Jan 2025 07:38:05 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:04 -0800 (PST)
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
Subject: [PATCH v2 00/18] Hide platform_profile_handler from consumers
Date: Tue, 14 Jan 2025 10:37:08 -0500
Message-ID: <20250114153726.11802-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

As suggested by Mario, I moved patch 15/18 to position 3/18. This indeed
simplified all diffs. Full reordering bellow.

Series based on top of pdx86/for-next branch.

~ Kurt
---
v1 -> v2:

01 -> 04
02 -> 05
03 -> 01
04 -> 02
05 -> 06
06 -> 07
07 -> 08
08 -> 09
09 -> 10
10 -> 11
11 -> 12
12 -> 13
13 -> 14
14 -> 15
15 -> 03

[1/18]
  - Call put_device() if device_register() fails

[2/18]
  - Set and use drvdata for every driver in these series, instead of
    patches 6-14

[4/18]
  - Renamed the `choices` callback to `probe`

[15/18]
  - Improve error handling in amd/pmf
  - Improve error handling in asus-wmi

[18/18]
  - Fix typo
  - Added documentation to platform_profile_ops

v1: https://lore.kernel.org/platform-driver-x86/20250109150731.110799-1-kuurtb@gmail.com/

Kurt Borja (18):
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

 .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
 drivers/acpi/platform_profile.c               | 164 +++++++++++++-----
 .../surface/surface_platform_profile.c        |  48 ++---
 drivers/platform/x86/acer-wmi.c               |  58 +++----
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
 drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
 drivers/platform/x86/asus-wmi.c               |  55 +++---
 drivers/platform/x86/dell/alienware-wmi.c     |  33 ++--
 drivers/platform/x86/dell/dell-pc.c           |  60 ++++---
 drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
 drivers/platform/x86/ideapad-laptop.c         |  44 +++--
 .../platform/x86/inspur_platform_profile.c    |  48 +++--
 drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
 include/linux/platform_profile.h              |  51 ++++--
 15 files changed, 474 insertions(+), 306 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile


base-commit: 58126788aa7726c0e91de6b25e6e332fa06089ab
-- 
2.47.1


