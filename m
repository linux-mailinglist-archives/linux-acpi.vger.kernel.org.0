Return-Path: <linux-acpi+bounces-8617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62AF995411
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 18:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F327CB28352
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11751E0495;
	Tue,  8 Oct 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSLy971V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047F1E498;
	Tue,  8 Oct 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403836; cv=none; b=rUmD6/8NChKYDUQN/6ShejP/UfYLZDnfMpt4YJ30iE7X7QaiYaJMEJl6Q0GFNHUx/PrVVXM736C10ciftGaZIFdYPi3AulmfrO3CGzHgLU+bFj6KuFijdly74BVzVvHJ3VHD6H2F6uhTCoU+Wj0ILxnyZZeeC5nEXtIw+lAc+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403836; c=relaxed/simple;
	bh=r7mEyXf1ZjwYZC8Jb+xbA1l4DsVejATdpcD82SdWp+g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hb7VWUu6VigBBlv5O/5pu/KIyL+WbHKdXVQWwoUaWRJThUb1a4rTxpaj2GKHGZ3C/1HZF3Ce3on+aS2biJW3eylMnL3OJCcNO7I0OruO+ZRLRyCoETPwzdICQh/ZzeWqSkZxl9T2uAp16KWkNrBdpviZscN4++C/RNPep3qzvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSLy971V; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d375ddfc0so331393f8f.2;
        Tue, 08 Oct 2024 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728403833; x=1729008633; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9a7LfuOs1NbeujelVlPKPSzT8OPKYTCPHEBo+bsTRco=;
        b=OSLy971VQE4SU0Y7DJFLveIXH8D7yXGxhZHdE9p425v7XF5GxjAUqd728taxeQEnLY
         9Xj5MIwfDGVPzn6Fn5bmXCA2ol8MBzrf1s5LL7tvQaWBlm7D+5W61Bk0mZ7EGFhJedg7
         +io69lYWfJnpSTEx2vareJs1YOYz/ufu8mN5zFdlws6AnMYdOjS/WUTKd8DcBe4W6r1B
         +HKCQwujZ0xRorjj4EAEI9UrCmLbYqN1FnN7qrHfHgNr78hX8nOR9ZWSzFDJy34VKwlW
         t4naFxa4aVa1TLagd6OR3FQO2TwIR4XbR7R2gL5JjdI9aG/95olJ/rLPX07DK06IpOsr
         lbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403833; x=1729008633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9a7LfuOs1NbeujelVlPKPSzT8OPKYTCPHEBo+bsTRco=;
        b=OrZCltnVW1U31ysSUDdLjcbTQ/xkiGpi4MvjvXiIIDgXbMTSjwQmucwAy7xfwxbH1o
         X/6/vcp/2odaE7Np8knAH/YIvQzro2eXJaACxZJbmFK/IGWkZKQDpJsEggcepgpp/r3r
         q/oA0+UdHrtFNEScLiua01cekR32FBQobV0ZQEeWU6hgKfl7o0K6u45SsezBQXXcJIyr
         1FbPiHi2/h5KzMk0Eh/sI2yg8UJEdxPWv5mthJ98oRbKV7jnhPhWtGAGvYBZMZmx4TDe
         MWVP1g6vgrdmaezotlAB+ix0wf2lSL/34QqK9FYJiPwV9si2z3pYEFEj7NEkuQ3Gd8ib
         ZXlA==
X-Forwarded-Encrypted: i=1; AJvYcCVrg5m0NYRopXBGMSy1nx1qHhNQ+40dybjjPBPF9PlHxPG4ycT+VSQ5A9n6pXontv7RNbui3a5JOrDP9rQ=@vger.kernel.org, AJvYcCXsuVWWAJLaL1qocCyoQIF9qyKslaTC2AuRKWbHIOCdumjBaYlbeTHxO54SHBYRkFo/sIluyzgY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2D1GKryEw/Yk5bhoVGJG410FUwjwgfUEVs7K+leLB2xbcW0Qt
	tlERUPQYtG8Il9z3QVZy3zPHGd3iFV91dvj/lcZwM+RFblfaJQHQC89RXxVg
X-Google-Smtp-Source: AGHT+IH8RgU9JvlhYvJcIwAb+cJCcTDEwjzENs+domo3S9hsJa7Hhhwnth6Igz1dDZJCQIiwLJI/qA==
X-Received: by 2002:adf:a199:0:b0:37c:cd0d:208f with SMTP id ffacd0b85a97d-37d0eae30dcmr8625123f8f.49.1728403832954;
        Tue, 08 Oct 2024 09:10:32 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-f2f2-fc2e-cc91-5c72.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f2f2:fc2e:cc91:5c72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec71aesm113505385e9.33.2024.10.08.09.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:10:31 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH net-next 0/3] net, device property: fix led node releases
 in mv88e6xxx with new macro
Date: Tue, 08 Oct 2024 18:10:26 +0200
Message-Id: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJZBWcC/x2MwQqDMBAFf0X23EC0YmN/pUgQ82wX2lWSVBfEf
 28ozGUOMwclREaie3VQxMaJFylSXyqaXqM8YTgUp8Y2bW2tM5/NOXSq6t8Iyc+7LAF+/WbTX/u
 2w210BSr9GjGz/t8PEmQj0EzDef4A5gbY73UAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728403830; l=2352;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=r7mEyXf1ZjwYZC8Jb+xbA1l4DsVejATdpcD82SdWp+g=;
 b=uY2eosIrS6TFt07rJl43cqlejlZlmyh8kFffYX1G5Z4Ik9bg0lp2RcDoCp4Ni85bdLUYcqkJj
 l6fkBR/ijFhC11lUozwAE1BS5JQaS1YyO9SrBVXaJX2jF3HegSTNyhU
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series introduces the scoped variant of
fwnode_for_each_available_child_node() to avoid the common issue the
non-scoped variant triggers: forgetting the required fwnode_handle_put()
upon early exits. It is strongly based on the existing
device_for_each_child_node_scoped(), using
fwnode_get_next_available_child_node() instead, and of course fwnode
instead of dev.

A fix with this new macro has been proposed in this series, as well as a
second fix for a node outside the loop by means of the __free()
automatic cleanup mechanism. Given that the bugs were recently
introduced, new approaches can be used without affecting stable kernels.
Of course the issue could be solved by adding multiple calls to
fwnode_handle_put(), but the scoped macros and the automatic cleanup has
already showed multiple times that they can save us from introducing
bugs and also help us fix existing ones.

Note that the declaration of 'leds' has been moved to its initialization
as it is preferred when using this mechanism to avoid releasing
uninitialized nodes. It could be left on top with a NULL initialization,
but that pattern is less common.

A more important modification is the use of the _available_ variant of
the macro, as it seems that there is no need to walk over unavailable
nodes. If that is not the case, please let me know why unavailable nodes
are required, as a scoped variant of the current loop could be
introduced instead.

This series has been compile-checked and statically analyzed, as I
don't have the hardware to test it. I have been using the scoped macro
for a while downstream, but that is not saying much, and actual tests
with the real hardware would be more than welcome.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (3):
      device property: Introduce fwnode_for_each_available_child_node_scoped()
      net: dsa: mv88e6xxx: leds: fix led refcount in error path
      net: dsa: mv88e6xxx: leds: fix leds refcount

 drivers/net/dsa/mv88e6xxx/leds.c | 6 +++---
 include/linux/property.h         | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)
---
base-commit: 489cee4caeba4f70a29b7215cfd18152dcadab7f
change-id: 20241008-mv88e6xxx_leds_fwnode_put-93946e7a87a8

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


