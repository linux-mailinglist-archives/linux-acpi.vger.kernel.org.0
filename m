Return-Path: <linux-acpi+bounces-10449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E80A07B27
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011C8169188
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155321C19A;
	Thu,  9 Jan 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZElWALz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CF215162;
	Thu,  9 Jan 2025 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435271; cv=none; b=rZzEdycxwVAvkbW/DCPSEH4+sy1VuS9gUPoO+vTkvt40rOOxCvi7WAGzkIsH4sKNGSfVSl0BfQlvApYR4uWNd07+Xi7iCTlykLEsSz4rDzbbOnGZU0djEoQZlz89+hoGGsrA9YiljkmUMlO/vAP40D4VfpFHJbS7cvek7leu0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435271; c=relaxed/simple;
	bh=+moCUpL6u4XxrsURb1bfyf5rekPbmy7akn2O6PEWcCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cusn2X1WkS9So+y/3br6BMeHYVwT5ld6ymjx5H2ZIfvYeZ5v0R3NqOl94eoynYLQbhb6M6h/l5XUSh+8QHdHcxQd2rE9v1/qPplm2UErNPJDzAZ4FqO+H5ZgQFSNp8kN42kprieu4e02AblO8FrhuUrC+jXp1eO83VjZnfa1zmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZElWALz; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4aff620b232so402290137.0;
        Thu, 09 Jan 2025 07:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435269; x=1737040069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoE7go3RrYEFTYajkK0L5YTSqdtFu88WCWiNyjfJPnc=;
        b=lZElWALzwFIZY2lDYKEmBiQfu8Dwrdv08bqJYiUL2O/aDvm5Tu6MnVusmSyaa8M8nf
         /aKKuPCwtIQDRHotBfYV0r4XCEYg8HsUIa+NN5XZ1ACmZqz0QrRedhjpZWlDirBoPlan
         97XQoShwskNilh6Pb+VlagZjpKbs1MuypmmsIZjDGlxCrD1BDPpvOouDB79gV9ZNazP+
         PDq902Zk0PsvXykFQjAh3KiGiWA/UMYJawIayvLxCiROKwJt7BMyK0/WEkbF3L5kcaIv
         NzUutJyAVuHW3j2FiVh0f/uTXQkD6AiwRo7dWurQmF/mkUK5LVNWXblRESLZFUmRs/5R
         Sumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435269; x=1737040069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoE7go3RrYEFTYajkK0L5YTSqdtFu88WCWiNyjfJPnc=;
        b=wsWTCwC+VYwEO6R9zf0Cl6jM+Xflo8ZAAUpo8ffh/UyCxtwvJfFtLfJ0RrPBWXif4u
         TyqNIC84BRjI4GPV+VROky1J3Hh3q0ItqtTHvW5MTyyJp/UX9YkbUyuenR7b120I3uxD
         CV7vtV9fRB6do0D0PrzfWu0Db0LwZ5VcSHCEPGMGe+CFyZSySVIVE5jkJqYa3qvZFpCL
         stSMFlS3sbSIwiOyAjAEzsvUDyWaiF7RCpavZjDqPNtF50a8WXboevM3bGDY8CH2hv7X
         ZozOA6c977uZfnGA6vS3Sq1pPNXGnecVf84z/7Ciyi0I+WgWrog+4ppfiJz09pFIUOD5
         S4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUHExFZZ85VxdEUOQIA6vn+PttHXeKo9QlX4TNJ3UZgERIHeSeb/4lCE+B7+SVe1Jvgn41Jl+shBiS0@vger.kernel.org, AJvYcCWYWuVBFbdP19/StS2lOxWQUptihYs4OIOTV9J4DoiVBFLYAmmppW5ASfB4Uzbaa+vcfHGZEuDBHkiwSzv8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7/jawe2WtEg9Zo6Z4M1MaV5BT5awawAIBPaYwdfN76H3GJDL
	uN1IqDZa6Za/TiSjECJZ6+Ws4vWUzpAlxtQw/4kfvrBN/D8QmIipOrNRZqbj
X-Gm-Gg: ASbGncuRFeC7K2kEHt97vnt05+9zPKKa/mIYLkjKFnXIK28GsW1H/1h2DTFfD1x2aaR
	Fvfsi1YJkEeQgoI1pc3hfq5x0Gona8AE4QLB58C0L9AwAiGZpGoCLORga5p11b1N73MgvTuurrv
	37UaFq7WbV2wPu6xEcjc2lGfvkwebU3NMJ7kVORrHGR/RgOAtGfSwad9AJNvGcU3pAerq4JR+lE
	Ls/Yc3vJIPY/3laNL1ybfu7YyMvYi4MZxtfCke4OUkcQXK/1RsoMBEz+jhsrCtu
X-Google-Smtp-Source: AGHT+IEwxvowKGZ8QIQOsUElQtm5MIUIo4vYsM4VuCZBWZOrM4bMMNQD3ZTA6ZeBJWBs8dq+bdq2fg==
X-Received: by 2002:a05:6102:d86:b0:4b1:16f8:efc4 with SMTP id ada2fe7eead31-4b3d0f9fa0bmr6112503137.12.1736435268573;
        Thu, 09 Jan 2025 07:07:48 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:07:47 -0800 (PST)
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
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 00/18] Hide platform_profile_handler from consumers
Date: Thu,  9 Jan 2025 10:06:13 -0500
Message-ID: <20250109150731.110799-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello :)

These series removes every use of platform_profile_handler outside
platform_profile.c and fundamentally modifies the platform profile API.

Currently, drivers have to allocate a platform_profile_handler and then
manually setup undocumented (as far as I know) members, before
registering the class device. This approach leaves exposed internal
members that should be managed *only* by the platform_profile module.
This has not been a problem yet because the interface is very simple,
but that could change in the future.

These series tackles this problem by presenting a new interface which
works around the following method:

struct *platform_profile_register(struct device *dev, const char *name,
				  void *drvdata,
				  const struct platform_profile_ops *ops)

Which now returns a pointer to the new allocated class device assigned
with *drvdata. I think this both is easier to use for future developers
and safer, because it protects internal structures that shouldn't be
meddled with.

If you want more details about this interface you can read patch [18/18]
which adds kerneldoc to exported methods.

These series would also make it trivial to implement a method that
"updates" selected choices, in a similar fashion to how
sysfs_update_group() updates attribute visibility. I proposed this a
couple days ago [1], but no drivers currently need this, so I dropped
the idea for the time being.

Your feedback is much appreciated!

Tested for the alienware-wmi driver on an Alienware x15 R1.

~ Kurt

[1] https://lore.kernel.org/platform-driver-x86/20250106044605.12494-1-kuurtb@gmail.com/

Kurt Borja (18):
  ACPI: platform_profile: Add `ops` member to handlers
  ACPI: platform_profile: Add `choices` to platform_profile_ops
  ACPI: platform_profile: Replace *class_dev member with class_dev
  ACPI: platform_profile: Let drivers set drvdata to the class device
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
  ACPI: platform_profile: Remove platform_profile_handler from callbacks
  ACPI: platform_profile: Move platform_profile_handler
  ACPI: platform_profile: Clean platform_profile_handler
  ACPI: platform_profile: Add documentation

 .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
 drivers/acpi/platform_profile.c               | 168 +++++++++++++-----
 .../surface/surface_platform_profile.c        |  48 ++---
 drivers/platform/x86/acer-wmi.c               |  58 +++---
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
 drivers/platform/x86/amd/pmf/sps.c            |  47 ++---
 drivers/platform/x86/asus-wmi.c               |  54 +++---
 drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
 drivers/platform/x86/dell/dell-pc.c           |  60 +++----
 drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
 drivers/platform/x86/ideapad-laptop.c         |  44 +++--
 .../platform/x86/inspur_platform_profile.c    |  48 +++--
 drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
 include/linux/platform_profile.h              |  27 ++-
 15 files changed, 454 insertions(+), 302 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile


base-commit: 6b228cfc52a6e9b7149cf51e247076963d6561cd
-- 
2.47.1


