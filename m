Return-Path: <linux-acpi+bounces-17609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EDCBBE1B7
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 15:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1B03B801D
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD602848B3;
	Mon,  6 Oct 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MRdCdOUh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54628284662
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755638; cv=none; b=TSD8XGKkmZRppKXhSam+VwcQVdGxAu0TRbI9OZkX2pgyu5KpYiZMMF2JgjYRu/r4PAsyit66nwKMIAt6yR8TKsJblF3K1wn8wF6SJFKvsHW+vFFSsFnP0XcDhe6niQxbdd6KSkxkLl38+3g99oZMYhiSXBqzcF5HZsSFPAqV9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755638; c=relaxed/simple;
	bh=n+4ffXDpgFyGOLQMhxiSPekyXCMPRcmWwb+9e1abpNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ofgYa5fvO6e5we3Hh6zP5r2rqWLhAg9bX3ObbgvePvfw8UKpJhBmRqwQQpmSndCVx4ORUZ9A6/xASH1DVSJ+VuOFaoyBaGYV8zdfO1bO8e3s/DkDJmvvaNH5amzAKQ/hAL9qqTK1HthQd4TWKr2+KQuom4KVfWAv3plfAfIIJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MRdCdOUh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e5b7dfeb0so20177955e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755634; x=1760360434; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9eYqGWM6RlRvXgz6OtNtf8fZRKYG9N14afkb4u4Kg4=;
        b=MRdCdOUh1kBWuXW5qxV3aqNkOxXobbfGa5gsQcK3O+TveVHzxMNMl9aPL6a8iqiWCv
         JZmmn8OPJmHiqZXxaHLea0gwtUR/WntXDAWC+g/b4HjlI3LhNEO8EsQdt5MJOjEHWKER
         Z9SEeCYCh9TeJHEyoPfJI7WyNF7RCNzsJnaA71iofHDMIX2ffcTvnqM3pGRS6PTYxFYP
         bdeByLaV3k4o0FHrCZa8YtLfv4x5ehuuv/euA/futqeooo3Kru4Nq3w7SnAyfVLm7RLd
         wmvFkiZMBVLLPtVv7cz07/i4AUFpFcUi8hu12r2N6oLb9lWMqII8VF5GGuDAqAWHHEll
         +b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755634; x=1760360434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9eYqGWM6RlRvXgz6OtNtf8fZRKYG9N14afkb4u4Kg4=;
        b=Swgj9c4qHhAyK/wULomBQPK6VRXZk4ei7EDTjs4NI83gbQ7unpFmr1MBBuHOmHPjTa
         vxF8F2bYs/vZJcidQpF1CJxboqCkAj6HXLlw9xUAHiZvfXd/iIDLp9sKA3pynl0nk2LJ
         jh9BROZNk7hO+iSw3NnS9MqUX5iFS9AemVdRkZzvnQLXHPNzlSjOAdQxzlyhDRdCCJmC
         RS8I+4+SrMJ9KQnyLQ/EOSIuV6nHMY3EDFXpVHALbo0QO47oXs9KFGlMMnRVY/t/mJc/
         /YTaotJRtiymkLtyy6BQeO4pq/o9qaAm9BWJhsyYvtwOaT2xJjDzLwVyL+bG1yS/dQzu
         lOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjG9eg1puvyLk7JXIXB3I0TCvH2RUqFxsJpi+PlZdLUe1VINS8IJehGypagN5RD6nUlOaJsPW1zr3F@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Iq9/bUWh/10/w+CpA31hrXN5SELIAfbUxJmIwb6Wx29nJrPd
	11i1QbYgDfW3dUu97Y8Kt7Gw7KUgn3bfMEUd/8mmLenhfI67mcwwFIKslqZvPFghg3w=
X-Gm-Gg: ASbGncvjkEKkdz6yLd76N3Jy8VM3kuXJzbPyd9I3Oxpif1O9cYAmM1MH/8jurrE4GKU
	m+FgS+r+NDjXVHgTRiByGJgPzVSBCGuX+j6dB79zRcZLGCnVIiT68GbtbthYPTpxoXhTrjBfLTI
	7BqJ/esy0CUXUUEoGJaC6X5+gPtRUnuKfGWFKjRUEIjL/t+dgx0tOEoci28qWt8kVLQKJa0c9YM
	AujkhCDAhTeF3gz+Cg1y2NFM1pgn16qY8FAvYymvo73rAmvKfYMatfRgNkE+CA/BsIx6amZcP0R
	nP6JWEo1OL7UiOFucya5aYAdzA5T/aDedT1+di7c2HO6WFwIVcrvZO2laqtWO6GEg3qvsYMUm1e
	FoFPrWXQNBA96HewtF6NdVDWIxtEjY7oetNDPkS2mFdGRTe7Z773m
X-Google-Smtp-Source: AGHT+IFplL+wYW0ASyblG5q1pCT8dN85S5Go6G0tr+/YExFQE8jVUN2hnvcYdOb8AfDTsyxLjpWR9w==
X-Received: by 2002:a05:600c:3d87:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-46e71144748mr72059875e9.28.1759755634489;
        Mon, 06 Oct 2025 06:00:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/9] reset: rework reset-gpios handling
Date: Mon, 06 Oct 2025 15:00:15 +0200
Message-Id: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+942gC/x3MQQqDMBBG4avIrDuQRkbRq5Qu1PzqbBLJlCqId
 ze4/BbvnWTICqO+Oinjr6YpFrxfFU3rEBewhmLyzovrvHCG4cfLpsnY9pgCjMMoUqNpXScjlXL
 LmPV4rp/vdd1rdWLMZQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=n+4ffXDpgFyGOLQMhxiSPekyXCMPRcmWwb+9e1abpNU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471nCukcB5mOpjt0Vl+S9+RC5wFDV7pPYXv5/
 9pi3fImdLeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9ZwAKCRARpy6gFHHX
 cnNxD/9UQkzPqWTSg6hL8zs9lUxsUNWz5ieU9CeRCpjozDezpCmM1a8Wm6U9JuYM7fEA8GqI1nX
 jit6TLLNTMOmQDa5DrpvfwA89dEAGxASZrU6eg9VUhVbEWr7Pek6ADRfyy2g3sSi2R6TpAficms
 iwoHOAgyNxZyvKv5l3wXZ/fMBW6bwTcSum1fYGXhuLK9OvxprAXSfzImNJQimxa8uBAUo7aLgKu
 8pvGryOObar7xq3FoOQ0P7Isvqzqyxvck0mLpIL82sEHSpX+InAuFCHNCII5aoqSTmytujTN2lR
 EW5Z8Qq19AX5w5S6bbMBg7syeYEXm0NnR/6frvtx/4upqE9OEt7NIqomO4XinC8j8+Jni748GfT
 7LGX6yrIpQJi4i5C8GQ2zdWN+7MApcpINeGYDuWU+eWt3fqcPQ3JXfeRaIAyGLpB5V0OIhmvnja
 7+AcB0fPLKaAc765bGS7g88rwRm+3DBFNzzj4cIl8Z+mYdgyF0t94KtdeG9gxaE47zF7UUn+2Ru
 CZNuSLYyz04BjQqx/AXsmTtt+t1w3StTp4A4ydgftLtnVzIq8WMyYygZPaMKt7CUeS6HCvVz/8b
 zittoWZkvam7bNKBFT71aYenD+YK8JpekbCuZQty0KJvXxjtAs5qEAsVhesbQ0EdMrW04OXx0CW
 RsDwomLiQ/FTYIA==
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
Bartosz Golaszewski (9):
      software node: read the reference args via the fwnode API
      software node: increase the reference of the swnode by its fwnode
      software node: allow referencing firmware nodes
      gpio: swnode: don't use the swnode's name as the key for GPIO lookup
      gpio: swnode: update the property definitions
      reset: order includes alphabetically in reset/core.c
      reset: make the provider of reset-gpios the parent of the reset device
      reset: gpio: convert the driver to using the auxiliary bus
      reset: gpio: use software nodes to setup the GPIO lookup

 drivers/base/swnode.c         |  28 +++++---
 drivers/gpio/gpiolib-swnode.c |  16 ++---
 drivers/reset/Kconfig         |   1 +
 drivers/reset/core.c          | 151 ++++++++++++++++++++++++------------------
 drivers/reset/reset-gpio.c    |  19 +++---
 include/linux/gpio/property.h |   5 +-
 include/linux/property.h      |  51 ++++++++++++--
 7 files changed, 174 insertions(+), 97 deletions(-)
---
base-commit: 097d5ce7a680da489516958e943910fa962e574a
change-id: 20250925-reset-gpios-swnodes-db553e67095b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


