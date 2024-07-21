Return-Path: <linux-acpi+bounces-6993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF16938520
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031362811AA
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219B163A9B;
	Sun, 21 Jul 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFFJ9Dfc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB1BE4A;
	Sun, 21 Jul 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575164; cv=none; b=FKPD5QZ3l6pHNfcMafeYfNvXUk9yTTJ7NSY6Gg4jZV4Q4dG55sRfNOIdnvNimR57thLX0kPyuOmjS2BnlICsOHdPDM+j6/IL9ZIDeA6q0r+idrrcvu5R3t3QU5gSxFZ9KJnmlKwxrGz+f3fnPjo5dUt6DeNzr1FsD6K7T/IG7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575164; c=relaxed/simple;
	bh=iECviPiLxbIDeNwd7lZgRlGP7QBU8L0W/xcKzi/7eL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hfEmO3kYapONJ9jOeF7iWYk1uTTkcqW7d/+kurqkqfP15/ZSz8Ty22Gpe3/bghVSuWYFLtEi7Z5ppnEjV5QX38N9OlTj4jQRMorONEtXq656KmUY+u87sxHaKVtOYBtZbsJoJ9Yb+2O0SuvUP18P2GRvUDANqcTmPnnUCz4xEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFFJ9Dfc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a79f9a72a99so809108966b.0;
        Sun, 21 Jul 2024 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721575161; x=1722179961; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKjiY2q9D/IJTj7xjCvHyfue6J9JJMW2sTDYqTbZhQ8=;
        b=fFFJ9DfcWKAwblzGqzt7VSz1XXJvfOBPrenUfvKkQ7KE878JYKhgLHpGROFC3kjRx9
         NQdU95jEbnJeC5vEnJDN1DvgPYrxvz8MBIdy0omJH2+g2JlyFawY7ulMUk///e0NPAWZ
         UnRNyp1T8zvawm4U3cHD2JxH7kY5MumCGdy1Fl9D2mjj3kB1WRTO3NYxinVArsgd3UYn
         RrpuVXSb+N9QxcTLaL2I8vXgn88xVyBFUoO9PUf8nSEk5gyvhGO/czDqj5rs3XBLoW9s
         nSN4Ne91ZlJPsLoHM+atXAsSiWkh+awLJ3HWykT1FRsRhVJwflov3cPHJe8y1xarsWPN
         frJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721575161; x=1722179961;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKjiY2q9D/IJTj7xjCvHyfue6J9JJMW2sTDYqTbZhQ8=;
        b=DsNVmEwg6mnPpTMJTiQXRH6Fc2JL+v8VcREbKbmpmpJ5jPHez+oaH3N+cKMVtfPr25
         mjqnT9BsgPSu93SCJVQxivUHyQfsK6k/iAMTnInFSPQ7jCfNJUS0aUBt8b5V+b+tAOKE
         0rY6Kz1iRBmKLdTiSQWVGLqyKZJjAJRKXfJGVqnt7B63YRoaojTo81hDJFBxCHkUEe4g
         o8q2i5e7qs4Tz1MeNWtGzVidIffmCvYI/LwtS+yh+aboMeyT34UJi+OqNRxDeEe13XVF
         AVS7EgP562lTzuGs70tH8M8OqQswrxPqJtNfpIYs4jch2c7WBwMcPqtBsGaHqN7ZJj8G
         xhWw==
X-Forwarded-Encrypted: i=1; AJvYcCXF9HY8khu53o1Oulim6s6qdeCSvNtnb1WD/QiQXEe3hneuIJSmLCMPtk8MyUbEEKhIHqtUFGBGawScJQ1RRLwsST+v97gQVI7sduXrTUr/7d35J+/p5U/IyfH5/Evml3LzWDQSbrTmmmhK4b415+tAh9NrrUXGVgcQO0XRGXx6NZFLP/rGVytFwBFccBA3vu0AC52VHoHKALFL3BfB
X-Gm-Message-State: AOJu0YwANUiKU7G1ZR7xgQTnQassvidM3TOQ7u6sYKoTIJ3tLKqI+HeJ
	RpmbAfBksdOklk07XMLjvuJatSex/Z3A2VoZXhMhkg6buJDgQbO/
X-Google-Smtp-Source: AGHT+IGuFT5o7tFaAB+rT43+V0Q6skqp3Is//7ongFxMMjGa7R0X/luYvqP52OxydlryQJCtoCOs0Q==
X-Received: by 2002:a17:907:7244:b0:a77:dba6:346 with SMTP id a640c23a62f3a-a7a41cad827mr450606966b.32.1721575160644;
        Sun, 21 Jul 2024 08:19:20 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-859e-243c-21d1-9ff6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:859e:243c:21d1:9ff6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78603dsm302270366b.8.2024.07.21.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 08:19:20 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/6] use device_for_each_child_node() to access device
 child nodes
Date: Sun, 21 Jul 2024 17:19:00 +0200
Message-Id: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQmnWYC/42NQQrCMBREr1KyNpLUtFVX3kNKSH9+mw9tIokEp
 fTuxoJ7l29mmLeyhJEwsWu1soiZEgVfoD5UDJzxE3KyhVktaiU6IbktI0A9hqjRgNPgaLbaB4v
 cZEOzGWbkEiSCUUOrLg0rV4+II712zb0v7Cg9Q3zv1iy/6U/Q/ifIkgt+Nqexa2WDSsJtWkp3h
 LCwftu2DwZGzanYAAAA
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
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721575158; l=3084;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=iECviPiLxbIDeNwd7lZgRlGP7QBU8L0W/xcKzi/7eL8=;
 b=r0+QjQ41ZdcUU7E2S9yd1wSzG5IQfzKmkUP/N4oGIT6Dpc9LaAY5YzTIS/WHeGOXn3YpOGPp2
 W6bXOZPnpHtC7vvRXSVWaTaNAcbF5jSinpT7qgNO9k4P/f+qcqOSCCI
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
Changes in v2:
- [1/6] property.h: drop "if found" from the description of
  device_for_each_child_node()
- [3/6] bd2607mvv.c: fix child node usage.
- Link to v1: https://lore.kernel.org/r/20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com

---
Javier Carrasco (6):
      device property: document device_for_each_child_node macro
      hwmon: (ltc2992) use device_for_each_child_node_scoped() to access child nodes
      leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
      leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
      leds: pca995x: use device_for_each_child_node() to access device child nodes
      net: mvpp2: use device_for_each_child_node() to access device child nodes

 drivers/hwmon/ltc2992.c                         | 19 ++++----------
 drivers/leds/leds-bd2606mvv.c                   | 23 ++++++++---------
 drivers/leds/leds-is31fl319x.c                  | 34 ++++++++-----------------
 drivers/leds/leds-pca995x.c                     | 15 ++++-------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 +++-------
 include/linux/property.h                        | 10 ++++++++
 6 files changed, 45 insertions(+), 69 deletions(-)
---
base-commit: 41c196e567fb1ea97f68a2ffb7faab451cd90854
change-id: 20240701-device_for_each_child_node-available-1c1eca4b6495

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


