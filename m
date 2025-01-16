Return-Path: <linux-acpi+bounces-10697-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94B1A12FB5
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD343A5AA0
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096AFA94A;
	Thu, 16 Jan 2025 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4zQPTO5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57092BA34;
	Thu, 16 Jan 2025 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987263; cv=none; b=o9rfPWUkWt5Fd7eYUd7dMxWgiEZpDqwHgaROkDm1dPa+p7aUyumWf5lQcZFrKxIAV1FuvjYPtyzm1uHwH7rStuy0ErOzYRrmWAzAm2sLAd9wEDHAHxm3p632o+Xn91yqPVMCxBPADspG+rkQV44LMxa5Y3Ni38QcOoXNewvrtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987263; c=relaxed/simple;
	bh=wsLq6qeiuTFQaaOi2TO6CTEMs4n7yGnX2RsVSSMFkis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ap2jvmfBV6obsAYfeJU+vdqca6920D9qBd/2C12o5DCwbtG/UCffp0HjlwhktjE5Thkqxglf+gAv20x2BphKKFJB3cqe/KYMB4fqcALTCw5hFYZwViUiGhvN5vUXUcEmarhhCkDRkRFNyWM0U5y4uzPg6Z3Y0AntDBEtriMT3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4zQPTO5; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e573136107bso663475276.3;
        Wed, 15 Jan 2025 16:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987261; x=1737592061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6ItIuPUER6hoSMg/joSU8e/Itcbzuq4aGsbnewvB1U=;
        b=A4zQPTO5Yb5Ct4a5QaevNk7QOysVriBp+9k1riq9W4mP2fjvMY3gm8860P/YffjHdd
         dyfORL6x9f6PaBAaFV5iRCyxAj8PbEMLs9z9nZRy+Lt3cMnR6zwg+nVtIyofasrCzzlV
         o1skwMOnzgHJRm61KW2YboT3g+qISgIvMA4IMhGk7RFCbS9DVKI4ESWQcSQIFWcCCE5j
         /UzlhRaysj3FnGHEM9GBSxBjiY7LiOMbMZnUrWb0dq0lwk6YUnea7n6SUI5+wwbMDwbI
         zzz0IiX4cF4YzjzZkmDouHQP95t01UQVcoeCm1Gqntyu+mQze4jxXBnleZrY8qqm223t
         pUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987261; x=1737592061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6ItIuPUER6hoSMg/joSU8e/Itcbzuq4aGsbnewvB1U=;
        b=nIwrjPnC8E1J4qITbT8Q5xuHuhIlRizO7nXFTzamjTyDFBMsQPYJ6dujb41MtPr3VT
         yYdLyAxdAmxGPSk2iRfgW8m4qAydFJx7CaeVbzi9WwzFRdxZ+s22LdwLTs2xIZdiX21w
         HTqoBemnkeef8WGWRWmIaTfxooKtXH/lxvH2lJGgqGx+v4p/ID4TfIGtf4zltPiMqTG9
         c521j2Tj+zLP76Q+S22S5wpVpwtOH65nsIIPTHRMTVrQwixyU2m3UIjafA/JkAWH4+c+
         kh+LE4kmtEFJmyCygoUxY0Ted4uIK0ICpAsN/HI2lxnZ761tth4qJD1NXcO1SUdXqLVj
         ypUg==
X-Forwarded-Encrypted: i=1; AJvYcCW/ExoTYjljb0faAJEw/c5mRXXC+wZG64+5hHv7Dn38woHm5waMhyqS7s7rICgi3Ev3X61wEgTCOj+pI1zH@vger.kernel.org, AJvYcCX7wvAv3COLdOWDpeZ2Mt3KqmzOfEosVNLPf5giFR7JBwNT1UxnX8rGvWkxgeTO6r96ZHDFj/kjtO1s@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHDo5Sq0bqAY2E20sFkky8P6BB5trguWx+/VM8Ry25QiaFybM
	MPDPD4TbB5laVLPL386WIgmByiLjg03ZhrwNTKCqEdjY9wZg+aKKOJzo7g==
X-Gm-Gg: ASbGnctWA8sNft15jjMq+oI3ro9VMCcFybYvSV5Uu1BUA1DPt2m1xBHXnslKq5Lgahb
	5OHAMeRw2Mavmyqv8BsQ7nr8iEKSsQ+MLiUupB8CTW39WiQra9PFIQslT52tQcHZxfpvh9RHlqb
	D/YBzlNuyTJFBsRAvf0GcuQIl9a+ON5tTZP+aNxXlpcrM13Q6mzAa83HGB50CaR+I/aJWdaypw5
	LpskEmLO8dMSiNZX5PuW8TX5dK6tXe4HZqNWfvxm9+EjrNKmWArvCqJDjw1jE1E
X-Google-Smtp-Source: AGHT+IH2F2+6cCAJawNCqoQuFN3KdhLz4mQ44By4V+g88yGjUF9vfQODjLvaYrxwA16VECXKunieZg==
X-Received: by 2002:a05:690c:f12:b0:6ef:698a:1f02 with SMTP id 00721157ae682-6f5312afc4dmr148550347b3.32.1736987260741;
        Wed, 15 Jan 2025 16:27:40 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:27:40 -0800 (PST)
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
Subject: [PATCH v4 00/19] Hide platform_profile_handler from consumers
Date: Wed, 15 Jan 2025 19:27:02 -0500
Message-ID: <20250116002721.75592-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi :)

The merge window is about to open, so I rebased this patchset on top of
pdx86/review-ilpo-next to pick up acer-wmi latest commits, in case we
manage to squeeze this into v6.14.

~ Kurt
---
v3 -> v4:

[09/19]
  - Replace error message with a user-friendly one

v3: https://lore.kernel.org/platform-driver-x86/20250115071022.4815-1-kuurtb@gmail.com/

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
 drivers/platform/x86/acer-wmi.c               | 114 ++++++------
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
 15 files changed, 495 insertions(+), 337 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile


base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
-- 
2.48.1


