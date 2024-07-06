Return-Path: <linux-acpi+bounces-6788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3300C929469
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 17:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D2F1F225C2
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE8B13A412;
	Sat,  6 Jul 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0Ibaz1B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BA132492;
	Sat,  6 Jul 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279435; cv=none; b=NnOtu4ae+nz/xtGAMn1AlF54c6A76nZZmaCt1iwnFuEggumcgLe0gyHvPhbpmEl3nyf1e6QwUvoXXsSdHT8uRSTqVSo7twD/LXqvoK5RqxWRnVqJacy9sFe32BEZGpfAxgsMj8qPCXZ8A7cVqsi0mYuypcXLcRkrMYb1EQ5ZfxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279435; c=relaxed/simple;
	bh=5SxVpHq21OxCvsGFYfj0CAfF5z+ueyVU4jGw3jVNyGE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ktKWjWUWflK8T49e4X83VCsQEaPMF4cjqanPZClpiusUjfxfjq3r2ZLjnuSz7gD3qqnM5dPsZf9B6Spv3t8f0PZCGoTlU+j1eThCdZkY5/wE6HN+zDEo8cJsMjZrl1GZbTQQZujCM8Fp3NCUpCT93zlQckjeY9kWYCzeWflCBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0Ibaz1B; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367ac08f80fso797498f8f.1;
        Sat, 06 Jul 2024 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720279432; x=1720884232; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3q+USBToABJwmfqPMV/gavBxVc+orXVDvte1zTYf7JY=;
        b=O0Ibaz1Bfy/d1smMUazXbKXETnkldvNp7TWpl/XwkzdZcL5B+Vbcdq4Oivirpbj1JG
         wID9G+7pqt2kYnznalihbLnW0Wg4KfCZe+HM2/WcHJsGQ9I+2wEyQnwY+ehqqY1oC+xp
         1DsZgzJLBrGChjkBtGMPydzvdIqlh6JHeByn7ZukecfsCwDpcJX8tsOfciucYu4exPXh
         k8oMmAovFcDNAPbfs31vu4wN3EAnDKMKq+G0SfEYYhMpOEStyhaD+HA27n/IW9U/93D7
         XeFIUih3DGRrQv9ANUhOr25GhoHYAi6EVSCqhdikb2OIP+C5Udg5ZPKnBOqK5FXvsTHA
         j0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720279432; x=1720884232;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q+USBToABJwmfqPMV/gavBxVc+orXVDvte1zTYf7JY=;
        b=JsFYswUpywLiFRO1kD4AZkYagzvxrHZKoJaLMP8j8wUikUeqEJeFFUADe5ayRjIVw1
         n8Pe/Xip54e9Vy0Nv0nF4pyZKEU2Cc3MnsXctA0aBUwPcXFGjAkrjJvET3NjMuBqkmuE
         t71o1eXxUkRbobWDHAe7ZIoJypqO26GyHI2DDlhK6vIqx8H3ASlHpWEL6jBm+I2W75rt
         LjnPcog9+xwimz7tKY9JJH9YDezu/TA2Rtv96tb+y2MHrlzexmcr9GBA3cWGHEPD4MRT
         /uKqOUL6ENVC8mPNC8hJgJclb8jKvNXZPq5jEQDEoXiQZoKr53BsaZzid4mFHUD3gdL6
         Lf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrqONptZsrQJwJuT+c3MsickcLK+NikAaYrgE7W4crodAKstCCLP3NL6Ym9DUiH8hE01VgpPPJDvNC1UQXEls60czQl17kjJoAgeOokfnho+S/+tUQirDu12U8hwOkz3qEYNTHDk3JyCNwQFoOdYc9sjv7Fug80/4L6P49jV7QCn17us6wge52owsBMxpFl1Y0y/recG5o5FD0odnH
X-Gm-Message-State: AOJu0Yz5nU/u2sJiw4Gcru+xiDv+8btleBTD1ub+bwf3MaXS5c3KMY+z
	kWUcPhOIFmbb6sABR/NKODnWuk9vYgTXNBsHC+8bsSxFV1ZIEWev
X-Google-Smtp-Source: AGHT+IGuHZqxCDsXWKNtqXwxfkmruJRlYvIuEJdJ6FlHcSNlIFM4AEDcUXXIzcKRm0pz28bW9xsSOA==
X-Received: by 2002:a5d:6843:0:b0:367:89d3:6581 with SMTP id ffacd0b85a97d-3679dd2ac1cmr5487729f8f.17.1720279432233;
        Sat, 06 Jul 2024 08:23:52 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679ed376cdsm6421593f8f.114.2024.07.06.08.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:23:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/6] use device_for_each_child_node() to access device
 child nodes
Date: Sat, 06 Jul 2024 17:23:32 +0200
Message-Id: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRhiWYC/x2NUQrDIBAFrxL2u4IG29JepRTZrC91QbQohEDI3
 Sv9HBhmDupoik7P6aCGTbvWMsBdJpLE5QOjcTDNdvb2bp2JQxKEtbYAlhQkaY6h1AjDG2vmJcM
 4cRD2y80/rjRS34ZV9//m9T7PH9bIF8V2AAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720279430; l=2810;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=5SxVpHq21OxCvsGFYfj0CAfF5z+ueyVU4jGw3jVNyGE=;
 b=6igQToqzmVSyatfLO2WUUbucw6CfBOiYElJ7VeY8UcOezRZ2KA6I7fk3qVtingGNye1FV+Vn8
 iOLZgXQ3CliALlvVgV5PzU5ynT4JSC4+p/9XeJOUnWwqFIe3mJ+sITO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series aims to clarify the use cases of:

- device_for_each_child_node[_scoped]()
- fwnode_for_each_available_child_node[_scoped]()

to access firmware nodes.

There have been multiple discussions [1][2] about what the first macro
implies in the sense of availability, and a number of users have opted
for the second macro in cases where the first one should have been
preferred.

The second macro is intended to be used over child nodes of a firmware
node, not direct child nodes of the device node. Instead, those users
retrieve the fwnode member from the device struct just to have access to
a macro that explicitly indicates node availability.

That workaround is not necessary because `device_for_each_child_node()`
implies availability for the existing backends (ACPI, DT, swnode).

This series does not cover other points discussed in [2] like addressing
uses of `fwnode_for_each_child_node()` where `device_*` should have been
used, using the `_avaialble_` variant of the fwnode loop whenever
possible, or adding new `_scoped` macros. Such points will be covered by
subsequent series to keep focus on the "availability" issue.

The conversion has been validated with an LTC2992 hwmon sensor, which is
one of the affected drivers. The rest of the drivers could only be
compiled and checked with static-analysis tools.

Link: https://lore.kernel.org/all/20211205190101.26de4a57@jic23-huawei/ [1]
Link: https://lore.kernel.org/all/20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com/ [2]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (6):
      device property: document device_for_each_child_node macro
      hwmon: (ltc2992) use device_for_each_child_node_scoped() to access child nodes
      leds: bd2606mvv: use device_for_each_child_node() to access device child nodes
      leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
      leds: pca995x: use device_for_each_child_node() to access device child nodes
      net: mvpp2: use device_for_each_child_node() to access device child nodes

 drivers/hwmon/ltc2992.c                         | 19 ++++----------
 drivers/leds/leds-bd2606mvv.c                   |  7 +++--
 drivers/leds/leds-is31fl319x.c                  | 34 ++++++++-----------------
 drivers/leds/leds-pca995x.c                     | 15 ++++-------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 +++-------
 include/linux/property.h                        | 10 ++++++++
 6 files changed, 38 insertions(+), 60 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240701-device_for_each_child_node-available-1c1eca4b6495

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


