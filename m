Return-Path: <linux-acpi+bounces-18583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E4C3BCC1
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68573B302F
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1521770A;
	Thu,  6 Nov 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NkMz5ajF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594030E826
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439566; cv=none; b=scuQiol1+rjaZqpP5+Nf+zuFo2rL/hPQw4gAkF4h1o2DRLrVwpK+3jTUDKHPzLT648AxZsN+ZJ0XUPBHQ19kn0StOXE5uzBBJ7OuBT3vLN2TagylhDNB23D136oXD0UCTPmwJubG5xItaKkdRQOSaubrzjkvCkH9LxQ9bCfWy/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439566; c=relaxed/simple;
	bh=ctODtsC0esXCVWhIY/sr8GjZ8CcJ4i+JiJY0LqQGWMU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QduBkuErAAivivsYv5/IDTsH15RIWIJ0o8l8coS+0cwiuz27OTSbnKcLEgGJLr+OpmViNd5yIe8Rp41Zn3iH2bBL4iz2MyXfyY7RLwg45t7uzrpVBjtzlkHDWD8bG2V5GL8A5GH7HESaJgSVl1aAPN+ybyCXsxVNfsHKX3JVywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NkMz5ajF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so9151645e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 06:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439563; x=1763044363; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3QQfmyFob5b081h0eUWQHPYT4hWgdjaHxmWN9i2alqI=;
        b=NkMz5ajFHDv/qEWltRNt4Q4cOVtOIZXq/nDr9ODEQZz0/L5hx2lzvdSOE39VatigMM
         HWSmchofZo0sbT705ZmliggQq/0Nnq9t8iHxDfg3qdYCRPXNL/W3IcHctDpNZcmCHcZd
         IcjPSlO+pG0T0aFhwbjQOy5fLLbMmtG0wxJez1yzLlYBW0yij53mLQSLgtuPDakIa1ac
         OZgDy6NOLierTtGoALgA/HwhuszgUPTbOebw5ra34fffhVVv86pHtbWs0mL6M2kwGZ03
         aJeMRfyDGWU5SbjnsUGfa1x9n+ApZJHDBE2Jv8M+3JnS7PE3VuS9o8m5eTHU2p6uW3mG
         cYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439563; x=1763044363;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QQfmyFob5b081h0eUWQHPYT4hWgdjaHxmWN9i2alqI=;
        b=rl1qOYPHe3F9yBxYlfLgsPqqetyzJXk0gDJpY3C8dh/iNVMQBZg3gZbHiFXuHvJ0Ic
         SIBeNFBGWDH9QSCNa19+uJXRhH3OkdUyn3n2RdGv7yO0AQ92YeOjaqUPBe1USjoOSkq3
         mGva1761PUNjzkRbJPkoAY2hYl5EHTV5rMYhDwdbwIigOeEI76bFMpyyAFOnDL9cRGkm
         6qorq8+O0PYS/cIs6M0Hoq8zA5xCg9PmNfp/dE5+TTSW2v8LPoveGBTubXsGrig0mr/c
         L7oVjb1hHojhyTIudO8b0k0mdwRC6AqTDSbOZd4aUP6enS98e4wid42rhsZ+F31+w5NR
         Fk2A==
X-Forwarded-Encrypted: i=1; AJvYcCVikII/NDKDGTCO/aFUsPsYt3bRQuKVYMIw9IuSOKkNIUjc/8yqRs+cUEAKTTjm5UTXsaTs2FcaaMxg@vger.kernel.org
X-Gm-Message-State: AOJu0YzOp7iTptbTNV90qCgphV5DGFOtbp3hwgHyPxRPYYCKm54gTmII
	yZihpFdJ7bGeaIldKFyWENvXBR22JGMhmpAJi4KSnJA7qDmZDedbj/nBkdMwFU8EMA4=
X-Gm-Gg: ASbGncvwJx6XfWvnIdJ801/p93ZGZOUuTQe0hcXYcFVjYuW9R0VVX1Xzkd5Lie59SBh
	vI6nFJfT5bkjKyK1i124l4thKBrOglwX4cV+VH4BV+r5rG0HwaSmbplQxib8+gByd2v+au8ICIa
	393cejUU76omJnRUv3K+WYCbVgTAvfts5oj4YAGfThjKcrkssAQCj/erWHxFVMrKKzJF7MYkRBQ
	ZxfsQ6wDBIF5TnQ8IWLslLCHIdATkCDueiR7M6iVapwM4Ao/taQZKEr50mad0bt73qoILWX/Yj6
	l+jeaQS4vezIqHwPg4qJ/vI9x0b5k/77ZZmMCnzZS0m8z9SYI7kXL0xIPUz6GITnW5CeALXBpoM
	Bbp40Bdh1/8PqQ0P6NDMIx4GCCpo43WW276rU+suauolOwoKMLrQwAk6eBpSJvBETYquy
X-Google-Smtp-Source: AGHT+IFrvsh9BDvGdM7+2fX+/+Gs8y0NYdBYNnBOWHnoflSRv7bon6UeTIae4LlH4+5boKMynR0Zig==
X-Received: by 2002:a05:600c:4e88:b0:477:5c70:e15d with SMTP id 5b1f17b1804b1-4775cd3a4afmr70743025e9.0.1762439562439;
        Thu, 06 Nov 2025 06:32:42 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:41 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v6 0/8] reset: rework reset-gpios handling
Date: Thu, 06 Nov 2025 15:32:29 +0100
Message-Id: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH2xDGkC/23QTWrDMBAF4KsErasyGv1n1XuELqRYdgTFClJQU
 4LvXtmbuljLNzDfG+ZFSsgxFHI+vUgONZaY5hbU24lcb26eAo1DywQBJViUNIcSHnS6x1Ro+Z7
 TEAodvJQ8KA1WetI27zmM8bmpl8+Wb7E8Uv7ZSipbp5vHAFTXq4wCVQPnKL11o8CPrzi7nN5Tn
 sgKVtwhiH0EV8SCMZIDWuYPCN8jto/wFeHGiatv5wA7IOIPYcD7iFgRoZgB8EpreUDkHun/uMq
 GsFFpYa0zaPQ/ZFmWX5qe++3LAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5994;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ctODtsC0esXCVWhIY/sr8GjZ8CcJ4i+JiJY0LqQGWMU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGDY523SfozHo1LnbBBlG6oxqvIx3S1AVwTg
 vTpeSyLmUeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxgwAKCRARpy6gFHHX
 chO8D/9RT7hiVkWYEusuakykM1KOSErO7g8xn3anmQ38AT2HDI1SYWBVH6ACzMPpFprgZ5oK8uz
 aZ863AN+oYdlnBCY5sfYws5seM3Jo1cuepLoLYcx43S2bgMz2jkLv14sYL22+f2PTb98HagWamq
 /UPvcT3mTFguYK2jvJHNbbXNRnFeNGBXQ45hClywmPbmY5/ejYbbyqV1iJ067+BpptcilTLpIDN
 kLrACWV+gp5UwEzgt1ott8zIh0wPcI7oFMw9vV2I6uEJsW8+lHwEquq+NTk24zTu36p1UYA2/9l
 g0dHibuhm1ignFGRZOPTYWLc0s97AoKuRrTsLSh9ZusnaN5nhM+VzgY+Eok44LDe69nf1G1cV2E
 mtGhAtoxS6KZCQ5r5hgVk96JNxPLNBcYecnNd2kWXdOWcxMV2w+7lvBDM6V8N6ILGr8NOfmdvIf
 9oAX8FrQNMCBXqNvd7oIkU2jQDbkSUnSZHjA8Tub0KnLir1GoEJqUx3uBgmfUSirMv0J9HSVwAm
 dWHr8AmYWPlh0LpNQ8Qursx/JN7Y8SvTWeU+QRx1h1skTUatmOIG1TIehCzbmVsAhg5KAF9lgdO
 ajYeNNqk6mFjZAfVSepL279H9rTSpwFjUdQag7UBF7IX60pnA/QnF803X64MTquRcfG+DkNhaFO
 IsYaokiFVmWaFQg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

NOTE: I've picked up commit e5d527be7e69 ("gpio: swnode: don't use the
swnode's name as the key for GPIO lookup") into my fixes branch and will
send it upstream by the end of this week. It will be part of v6.18-rc5
which tag will need to be the base for the future immutable branch
created by Philipp.

Software node maintainers: if this versions is good to go, can you leave
your Acks under patches 1-3 and allow Philipp to take it through the
reset tree, provided he creates an immutable branch you can pull from
for v6.19?

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
Changes in v6:
- Do ref[0].swnode -> ref->swnode in software_node_graph_get_remote_endpoint()
- Fix some nit picks from Andy
- Link to v5: https://lore.kernel.org/r/20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org

Changes in v5:
- Use _Generic() even more and simplify the patch allowing to reference
  firmware nodes significantly
- Use _Generic() to avoid adding more macros to linux/property.h
- Don't rename macro arguments in linux/property.h
- Drop patch renaming the GPIO reference property
- Pick up the patch modifying the swnode GPIO lookup to using fwnodes
  into my fixes branch
- Simplify the patch allowing GPIO swnode references to reference
  firmware nodes
- Link to v4: https://lore.kernel.org/r/20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org

Changes in v4:
- Fix an issue with uninitialized ret variable in reset core
- Use _Generic() to simplify the __SOFTWARE_NODE_REF() macro and remove
  one of the arguments
- Add a comment explaining the relationship between swnodes and fwnodes
  and why we're using the fwnode API in swnode code
- Allow longer lines
- Link to v3: https://lore.kernel.org/r/20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org

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
Bartosz Golaszewski (8):
      software node: read the reference args via the fwnode API
      software node: increase the reference of the swnode by its fwnode
      software node: allow referencing firmware nodes
      gpio: swnode: allow referencing GPIO chips by firmware nodes
      reset: order includes alphabetically in reset/core.c
      reset: make the provider of reset-gpios the parent of the reset device
      reset: gpio: convert the driver to using the auxiliary bus
      reset: gpio: use software nodes to setup the GPIO lookup

 drivers/base/swnode.c         |  30 +++++++--
 drivers/gpio/gpiolib-swnode.c |   3 +-
 drivers/reset/Kconfig         |   1 +
 drivers/reset/core.c          | 145 ++++++++++++++++++++++++------------------
 drivers/reset/reset-gpio.c    |  19 +++---
 include/linux/property.h      |  13 +++-
 6 files changed, 130 insertions(+), 81 deletions(-)
---
base-commit: cb69ab793066d9038345da89e54545aea34aaef0
change-id: 20250925-reset-gpios-swnodes-db553e67095b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


