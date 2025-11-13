Return-Path: <linux-acpi+bounces-18879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68853C5A1FD
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 22:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77CB14E65DA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614E3246E6;
	Thu, 13 Nov 2025 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmkL1HZc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEB322C70
	for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069205; cv=none; b=YuUrBWYOilfnszGN8RJkb5v3XOZwF/IvRqOe11ATzKAWTDY/Pe3HxIQmocqswb+eNVZNw9kEjZaOasTJjT726WTz5jsd6I6jMhR+45qnvqfchRU2p5PnERGNkemEPSMTxq+PuWtjiFaw1KnasWlvEBeCxUoYyLrNtfmTFw50pW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069205; c=relaxed/simple;
	bh=75BuXIjGpZny9CJyYZ3+cDjv4Td/7jryzbg1I2bUBp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRPvypqgcApBeS8ICTL1+EdaJwjP8cqdz/trBOP/A0oNLgDD54ASocyoFPzgn4GLapznKtKv0AkCEFCTb4a4ZqaHld+iLs8d9sQLWkyZnVjOX7DL+P7M4UzsJEur4NoDftDnKDZbZ+R3HbZjJZXLzH5vJFYJZ3YeN7c2BjhBLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmkL1HZc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b556284db11so898363a12.0
        for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 13:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763069203; x=1763674003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm8LcnZyr//0nT7mWq+F1YEGC3NfbcijTCKWk6nFZu0=;
        b=BmkL1HZcTfHeiGfgLY8doTDPzVBx6ymCS/gRBaYt0Nf9adnjVfYTchjtfi0Zhrio2I
         qt7fsxhCNwypHkWT6CdaY78iCSSFVGHzB8cOhyauEWSkAd9UXHYpET6Ms0CVFvUFs2HC
         7e7HFwKSDb9qaTuFczTcvd+tf3bsfP0GWXH5xcmTDF2MXMFmCjB9wrQb4s5qcpQQPbOV
         28HoOeonsmF4m0pPxMV9vMJtOYzlyHgXCTkPHaBuZ91DxXDV73bgFCR2z9e/7S5JtnKS
         edL59PnoWjI7cp30tI/pUIsq4k5y1ADXWQjt2yB7K+6joSSgvBNxm0X5k0njK+CxMyTp
         oD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763069203; x=1763674003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm8LcnZyr//0nT7mWq+F1YEGC3NfbcijTCKWk6nFZu0=;
        b=a6CfryUBWb9T0E8gQYoovGjDFmJ60NlTMIr5daX9F1rTcZFwz7cUe7QRrB8UVitlCJ
         fjnETUpo7ltCJdNvuzHIbnlYodRGekSxndyafTXfNEwPGLdKGAGOL4llk5YKU5/zl0gx
         Q5HMfvVEzbU8JJJht8e/KEeKeIRzJITbE/2pacjLyKQP5+qXHLiNeCyfz2XQWvW57VFO
         q9AQjXIiGQZCOA7OJdZwrhc29QItdZXyNYN3qbBreXl8de+34YDhcIq/gCd4pLGAiUn3
         W4n8JaGvq5XfBABQuILIqCq4HFGpKI+ZrLVO96plq5CqN+S9Adub407z5dJyTLfrsRdW
         ql0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1U6f6Xmg3LhCYphAgSJBci9t5GAJr2rbUNDIWcRAajpN3bEVMvvZ5HBMu8pK3/UWLW0KLYp7TEsVJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGtVt/ieYoMSY8ad0II36xszV8KI6p+Njp5iRWxsJtAVwLnPA
	7zaNN2rLjEgNzLp2h3trTOrQmsmvdyYQyqGCZ+ZYoEHxNXNoTN8XLEQ/
X-Gm-Gg: ASbGncsqdU66rMCbpQjCIveCAYF0aSjgmA8U0IPe5TnihuZFsd8sZc2qWJEL/XyyOSa
	WHfX2G34g2XqBmNw2YoD+S1uRayZEoxlOc9QoYmwVfrIRcl/FhU1ulZxYytTnR0YfCcLeP+ZHLT
	3Yi8LMs55hJYcoxDmfb8H9J/sWX68VkeoziRiCMA1AuvMjfZlKpIroxZSSZt6BODUkbaGaI8ztz
	cxxDm/FkiWBN1E4Tia9vgvEH5dKfyJbjT28KpsqAQNmcCNl4NTWkGemMiwLei6ImqAKr/QP5Z4Z
	y7LObZh4yr4AU9QNDhnixc/ZnlkTnU7LcmQ+SuQ+dBe5t4U7ZITEQEldjl50ol0OZGB5fVYpC9t
	+4aMcrZR5PkMuCct4NLvJhoJCC1tww4dc2zxIK4S09kk8jLLjOTYivtzXAtb28FUbD23jTuHfpX
	NHukEc1qybc4bBJaNyh4tRAHDnuOIAxV3QJaH7dpi2dP3QwMBn9Yq1p4ff
X-Google-Smtp-Source: AGHT+IH2ppKVKaegleIFYp2CPh1L2DqmyfOwakV0r/xJMX47RxpUdSR1jy5Z+Tosq9kSQTZd5Y8Tew==
X-Received: by 2002:a05:7022:69a0:b0:119:e569:f622 with SMTP id a92af1059eb24-11b4150c6aamr292336c88.27.1763069202522;
        Thu, 13 Nov 2025 13:26:42 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885eesm1811414c88.1.2025.11.13.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 13:26:41 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/3] Add max-power platform profile
Date: Thu, 13 Nov 2025 13:26:14 -0800
Message-ID: <20251113212639.459896-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "max-power" platform profile mode and uses it for
the lenovo-wmi-gamezone driver. It also adds the Lenovo Legion Go 2 to
the extreme mode quirks table.

On some Lenovo Legion devices there is a thermal mode called extreme
that corresponds to setting ppt/spl vlaues to the maximum achievable by
the cooling solution. This correlates strongly with an overall power draw
that exceeds the DC power draw capability of the internal battery. This
mode being mapped to performance when extreme mode is detected as
supported, with the actual performance mode being set to
balanced-performance, has led to some misinformation being promulgated
that performance is always a bad setting in Linux for these devices.
There is also some confusion that the mode labeled performance in
userspace, which corresponds to a red LED in Windows, shows as purple
when set using the hardware extreme mode.

I'll also note that as the hard TDP limits are refreshed when on AC or DC
by the ACPI notifier of lenovo-wmi-other method driver, no special handling
of the battery is needed for safety limiting extreme mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

---
v3:
 - Rename the vendor specific "extreme" to a vendor agnositic "max-power"
   to better allign with the "low-power" platform profile.
v2:
 - Drop patch 3/3, keep extreme mode quirks table
 - Add Legion Go 2 to quirks table
 - Fix nits from Mario
v1:
https://lore.kernel.org/platform-driver-x86/20251026081240.997038-1-derekjohn.clark@gmail.com/


*** BLURB HERE ***

Derek J. Clark (3):
  acpi: platform_profile - Add max-power profile option
  platform/x86: lenovo-wmi-gamezone Use max-power rather than
    balanced-performance
  platform/x86: wmi-gamezone: Add Legion Go 2 Quirks

 .../ABI/testing/sysfs-class-platform-profile  |  2 ++
 .../wmi/devices/lenovo-wmi-gamezone.rst       | 31 ++++++++--------
 drivers/acpi/platform_profile.c               |  1 +
 drivers/platform/x86/lenovo/wmi-gamezone.c    | 35 +++++++++++--------
 include/linux/platform_profile.h              |  1 +
 5 files changed, 40 insertions(+), 30 deletions(-)

-- 
2.51.2


