Return-Path: <linux-acpi+bounces-18326-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C27C1A81C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 14:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B246A427E50
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB83128CD;
	Wed, 29 Oct 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ULKV6xBN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2837A3DD
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740932; cv=none; b=QL56lE0pUMn8iJ0ef0Z6bT3mRImkF/oVLD04Hs1DUyjiXODynKibo7MdlSfXy2ZL6afIVjFxohNXwN0lsuxPm5mChnXtaiKMuf0jBkT3kvrErMc/Q8Blil4t7GUoSPLxFKEJlyBtjVd60mQYV5l6Ujmi3qzZcbVMahlkuRENE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740932; c=relaxed/simple;
	bh=+fd/3iqijZWE6ruePHbh2ZeE4Vvwsaoa6eHE5+01rLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BY7S1V0mi22dmzEJvwi/EzjWv0Ll0DBpEUWNzSgp7kN4df1LEYQS/6Gof7MsMBV/vr3+0/eUroqz7SyDfStrMElpsmrKMp5RtfvHkCZQggiVxHAqs8RmQsfzrPQTlq7/2nTe/M67eUOJFHOXrt1gb/UXE1oJ4W/Zqjf0PzQE14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ULKV6xBN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47721743fd0so3488905e9.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740928; x=1762345728; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1VdFdqkJWeoovDcep89eqJy/KpmVn7+tbn6n9mmZQ=;
        b=ULKV6xBN+K83RyXQeedO5MPxzDnZ/Dzg7YGRCS0RgJgZeuZ5iaJIy8f5REUdTFaN1F
         7NDZllCH7Uw9iPZzMw+sUDThv3Lk3OPhay9jFz2xvPD9g/aODNYjMvCB27Fz8ZMFNcLa
         8dVEx1F/vPzz07Yw8QlAtOJuzRsDANHk72/BezCSXUYjYR3JL2CgU+p6okQOu5aFH0k0
         ar+fimgIYRsB6lLfiWaFW3jm0jzqT1dWulCksjQKT+w5VnK7+2cS6wjoeHnsu+ineHef
         1cuR/tEdqS8357xugpDNoe5vCrvW4dWxHFk/qIYjphvdloQpbKIzs9Y+NbfnVNO94H4V
         5fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740928; x=1762345728;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6s1VdFdqkJWeoovDcep89eqJy/KpmVn7+tbn6n9mmZQ=;
        b=VM7aSuX5vtN7qE7XY/CFl2UgKVVqvIXPwb0NZLfmga0JhVKj1M/GVzgTAM69Qkj2ph
         4wwDVF8NJuCXScoAZRX/FdgA9rLXyKpwRen//sbAppxWfdbPj5NgIDMGxvUm7t7i3hnf
         lMo1CX2phLBEaL5NtL09/pOceAuhXerToxbqex6e/DrGSA6FKejiMbyHYknNgaWIBVIn
         NKgqihqD4wmoTcgliSMTLk0aqytHjVVV2ymcSTEw1GSbIWRvF10iGSlyxh8CSFoitU/u
         S61mcKkzLk/TdELNI0E/RFSYbV2lWusZMhuuLnDLod1YS93/Hd9mMfVX/S1tcDydF/x9
         j/fg==
X-Forwarded-Encrypted: i=1; AJvYcCWbwYIlpJebV7BEM0i6eRx6f61aRnXDJl15P9inhS0c9JaMV9X5RrYdU/8FVee8Onv6OqM3jOCBIcXZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLLFLX2YbBX4ETtAXtzRIA+PWed+vwiwp8swRd1QlWQZflP9m
	EJnT6+7UagoUkrAcpQin0FNyGCv4n9jXDdkVHsaOfUh7MC/Hggio3SEeKQKdNwpbQK8=
X-Gm-Gg: ASbGncuwfCYYhytHAz3U4AkFX9Fte5M3NdKwiKX/Z9x5nMcMWgPvfG5rXsZTv4N3+J9
	xTRxfwqgknKi/So/V3go3BWBlJyChNmL6X65lWNK+U2psUgOMYkedR+E2QqAyWY1o3vBnmuXGQV
	aIxe4Bo4B0ehYUNLdoGCP2x95pA4u8A/ffGeEKKXNTUWnEA+xIjfqysmPaisoyXhwqvsEGG2qlZ
	KdHz2frsFDIQZ7ra6hzkzuvpdpNg7T/llLrKUNS61Um03Pszer0D9fqIVd65SGJswKKKe8UZn1+
	gUP2opGmktQJ4cPGCl8MxiGGPya4SKcJCHyfbgH01quGQdiFFVSftO+xHVYLzsfrrbbev2G3Dvq
	qC7Wysh3a1iDYF2DcdMXVnFOOFMFqzUkCKAJxlEAgk3UZZhhltZ+MPA0RnuduzJGgHn7AYQ==
X-Google-Smtp-Source: AGHT+IHMlM8eyAqPOulQC1tnFXIQIiiorv7v1to7ZewkoNlnAbXuTrqAt3rqd0Pt1HZLQUD17/+L6g==
X-Received: by 2002:a05:600c:6215:b0:46d:996b:826a with SMTP id 5b1f17b1804b1-4771e24ce01mr27359885e9.36.1761740928502;
        Wed, 29 Oct 2025 05:28:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 00/10] reset: rework reset-gpios handling
Date: Wed, 29 Oct 2025 13:28:34 +0100
Message-Id: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMIAmkC/23NQQ7CIBCF4as0rMXAILW48h7GRZFpS2KgYRrUN
 L27tCtNuvxfMt/MjDB5JHapZpYwe/IxlFCHij2GNvTIvSvNQIAWBjRPSDjxfvSROL1CdEjcWa0
 V1mdhtGXlckzY+fem3u6lB09TTJ/tSZbrunlSiHrXy5ILXjulQFvTdie4Pn1oUzzG1LMVzPCDA
 OwjsCJGNI1WAoy0f8iyLF+iHfN+/AAAAA==
X-Change-ID: 20250925-reset-gpios-swnodes-db553e67095b
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4411;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+fd/3iqijZWE6ruePHbh2ZeE4Vvwsaoa6eHE5+01rLQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh4cPx3Yp6F1lBbEjREoOK0df8M+aQNPEdWm
 Ar1aJWISt6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIeAAKCRARpy6gFHHX
 cg0vEACrtTV6dfMYlP20/k7I2Ztvb6RdmNHXwYf7aqrnLHk8sfVHXRLASrT1ahc1PGAsWC9G9RB
 Zrphn0P5YsAiANmOfG7oi6prfCkBfaybVePLXJRnoWLr5Gg/DyZvE08Fj+9Bn5NfMh/A+CgY9vd
 FMeJa+hvB2xDqB+7CxuRB6Ih3WF0TpVPzFegeJXm/eFFPdeQXZ6CxtJ528vQivNWOts5oeC6JAp
 zc1iwxALhfDW1eKdmJtUa/Omt0rjy2z9grimop8qlmHzebtrwJrrL4OZKA+F0V+UIYUbo5oV4rT
 55EaH9y9CbdhHypv2zlMKHnOk++ZGkOZbB2jYagOdec4u2YzatTTkop8fB0CDNMvB0EFqVgLmKd
 QfJ17Avdvir0++FU1ULnuSdIa3oGLrp+0Jfh5bOxU7U4dRd/M46C5wsl7qvfMT78jVjdfQ0jlEf
 x84PJPBLirOEEgr8QPlgg/9I/CR9J7kNyhAhWAfdoMs24qWXZjO4SaDjbR12ETj5/rkzwyR6TYh
 BnEwsFh1DJ4ir27sc3IiCweHtblaD/dI0fglmk9A20Vec3szqYFIpNupukLZDpreRzEHlaJ9uqR
 RPSTCsTDQ8ZjaE3i3+uYQmojVJ3PZ9AC3kZQav2M+xP4ox90fVr/Tz5Lp36+WeghEg1xA6qgdpX
 rmx08a0k8wQtzcg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
absolutely no idea what the GPIO provider is or when it will be created.
However in the case of reset-gpios, we not only know if the chip is
there - we also already hold a reference to its firmware node.

In this case using fwnode lookup makes more sense. However, since the
reset provider is created dynamically, it doesn't have a corresponding
firmware node (in this case: an OF-node). That leaves us with software
nodes which currently cannot reference other implementations of the
fwnode API, only other struct software_node objects. This is a needless
limitation as it's imaginable that a dynamic auxiliary device (with a
software node attached) would want to reference a real device with an OF
node.

This series does three things: extends the software node implementation,
allowing its properties to reference not only static software nodes but
also existing firmware nodes, updates the GPIO property interface to use
the reworked swnode macros and finally makes the reset-gpio code the
first user by converting the GPIO lookup from machine to swnode.

Another user of the software node changes in the future could become the
shared GPIO modules that's in the works in parallel[1].

Merging strategy: the series is logically split into three parts: driver
core, GPIO and reset respectively. However there are build-time
dependencies between all three parts so I suggest the reset tree as the
right one to take it upstream with an immutable branch provided to
driver core and GPIO.

[1] https://lore.kernel.org/all/20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org/

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v3:
- Really fix the typo in commit message in patch 7/9
- Update the commit message in patch 3/9 after implementation changes
- Don't remove checking the refnode for NULL and returning -ENOENT
- Move lockdep assertion higher up in the reset code
- Simplify patch 4/9: don't change the logic of inspecting the gpio
  device's software node
- Add new patch that still allows GPIO lookup from software nodes to
  find chips associated with any firmware nodes
- Drop the comma in reset-gpio auxiliary ID
- Drop the no longer used type argument from software node reference
  macros
- Link to v2: https://lore.kernel.org/r/20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org

Changes in v2:
- Don't use a union for different pointer types in the software node
  reference struct
- Use fwnode_property_read_u32() instead of
  fwnode_property_read_u32_array() as we're only reading a single
  integer
- Rename reset_aux_device_release() to reset_gpio_aux_device_release()
- Initialize the device properties instead of memsetting them
- Fix typo in commit message
- As discussed on the list: I didn't change patch 7/9 because most of
  it goes away anyway in patch 9/9 and the cleanup issues will be fixed
  in the upcoming fwnode conversion
- Link to v1: https://lore.kernel.org/r/20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org

---
Bartosz Golaszewski (10):
      software node: read the reference args via the fwnode API
      software node: increase the reference of the swnode by its fwnode
      software node: allow referencing firmware nodes
      gpio: swnode: don't use the swnode's name as the key for GPIO lookup
      gpio: swnode: allow referencing GPIO chips by firmware nodes
      gpio: swnode: update the property definitions
      reset: order includes alphabetically in reset/core.c
      reset: make the provider of reset-gpios the parent of the reset device
      reset: gpio: convert the driver to using the auxiliary bus
      reset: gpio: use software nodes to setup the GPIO lookup

 drivers/base/swnode.c         |  20 ++++--
 drivers/gpio/gpiolib-swnode.c |  21 +++---
 drivers/reset/Kconfig         |   1 +
 drivers/reset/core.c          | 149 ++++++++++++++++++++++++------------------
 drivers/reset/reset-gpio.c    |  19 +++---
 include/linux/gpio/property.h |   5 +-
 include/linux/property.h      |  38 +++++++++--
 7 files changed, 156 insertions(+), 97 deletions(-)
---
base-commit: 5218492f1eb93da3929f0d993d2995a4665ca760
change-id: 20250925-reset-gpios-swnodes-db553e67095b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


