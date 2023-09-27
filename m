Return-Path: <linux-acpi+bounces-205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B767B06F3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7156E2826C1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56950450C8
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFD38FA6
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:29:39 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3609812A
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405524e6740so92790065e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824975; x=1696429775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VT0WdcTksCG2+UKw1ktH9eYBkLxpuYQp80r+6apmKoY=;
        b=PuI19BwO84FEuZJmenXvcE6ntpghmlrkZc6xkjHz/ZED3lS6gD0JChq8qyHR8NZ3lW
         Ph50wq4Nad1RIZZeFqXwXj3hDcR/pqzYBo5PUQxZIpn8hVXLrYii3kX9k6pEJseKEGiE
         GOpEqWxwyczJqyePnErebtPJB3sJp1vQGdMwhhqTtauOwf3TltWf17iSKGRoq8LKdbMt
         XakZ+6euzir4ZWNKlYSKlJrx6zeD2dETLICioi2wTbxj1a50wx5SNQWv6fgEkn4tC8gf
         yZFRpvsWOJLJ8gu74Jklfqjx2TD/K70mszEXziD2gwAi43wg+iGHNrGrLPyr9pXBnCUr
         z49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824975; x=1696429775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VT0WdcTksCG2+UKw1ktH9eYBkLxpuYQp80r+6apmKoY=;
        b=cgDlkOwURMpf5kPcsbXrWsI/63QXhbxwoGz9GQc7+PqsyfyNVqwYH6cyYilVwvNzS6
         NeUa20ykDoLKlOFWMqIkEAHkHAJ2tcldy+5z1v1ie/WYaPowPgyXIwcWbI8V5XxqWOpV
         Z4ynWorO77CRKZRHwOCtu7buK5pcwaufzVBjRUpRakpB2eCT59kYxar21xrxfLfe+2TY
         9/p3Rh88qXVGqHsiaMvptvn14cX9eadWJZdwHIaxpRNWKUNX0WvsrcyATOZDT58dQgjx
         NLQGFB9rwomm2hi496d7b+bexSevcaTdqzmxCsi95BQALBOXZHX43CZbPi5hGjbVNP6K
         KtFg==
X-Gm-Message-State: AOJu0YwdxR9FqXJgN1xkKurwlUyoZmPF+4uZbYm4g1Z6qaurvmTvIoay
	3V296Z7jW3Nb7mCcRQby4fD0uA==
X-Google-Smtp-Source: AGHT+IGQbkdLDUIFtvI0l6HTHcvn9T5lN2sV20CE/sJBjcHLb7iJvcvut6d3+8/Q0lUmoZrKTf3qHQ==
X-Received: by 2002:a05:600c:b41:b0:401:b2c7:34aa with SMTP id k1-20020a05600c0b4100b00401b2c734aamr2154897wmr.33.1695824975441;
        Wed, 27 Sep 2023 07:29:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 00/11] gpiolib: work towards removing gpiochip_find()
Date: Wed, 27 Sep 2023 16:29:20 +0200
Message-Id: <20230927142931.19798-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is a reduced subset of patches from the initial sumbission[1]
limited only to changes inside GPIOLIB. Once this is upstream, we can
then slowly merge patches for other subsystems (like HTE) and then
eventually remove gpiochip_find() entirely.

The GPIO subsystem does not handle hot-unplug events very well. We have
recently patched the user-space part of it so that at least a rouge user
cannot crash the kernel but in-kernel users are still affected by a lot of
issues: from incorrect locking or lack thereof to using structures that are
private to GPIO drivers. Since almost all GPIO controllers can be unbound,
not to mention that we have USB devices registering GPIO expanders as well as
I2C-on-USB HID devices on which I2C GPIO expanders can live, various media
gadgets etc., we really need to make GPIO hotplug/unplug friendly.

Before we can even get to fixing the locking, we need to address a serious
abuse of the GPIO driver API - accessing struct gpio_chip by anyone who isn't
the driver owning this object. This structure is owned by the GPIO provider
and its lifetime is tied to that of that provider. It is destroyed when the
device is unregistered and this may happen at any moment. struct gpio_device
is the opaque, reference counted interface to struct gpio_chip (which is the
low-level implementation) and all access should pass through it.

The end-goal is to make all gpio_device manipulators check the existence of
gdev->chip and then lock it for the duration of any of the calls using SRCU.
Before we can get there, we need to first provide a set of functions that will
replace any gpio_chip functions and convert all in-kernel users.

This series adds several new helpers to the public GPIO API and uses
them across the core GPIO code.

Note that this does not make everything correct just yet. Especially the
GPIOLIB internal users release the reference returned by the lookup function
after getting the descriptor of interest but before requesting it. This will
eventually be addressed. This is not a regression either.

[1] https://lore.kernel.org/lkml/20230905185309.131295-1-brgl@bgdev.pl/T/

v3 -> v4:
- initialize managed pointers when declaring them
- drop unneeded casting
- collect more tags

v2 -> v3:
- use gpio_device_get_chip() consistently
- clarify comments
- fix buggy chip assignment
- check for PTR_ERR() in automatic cleanup
- rearrange code as requested by Andy

v1 -> v2:
- drop all non-GPIOLIB patches
- collect tags
- fix kernel docs

Bartosz Golaszewski (11):
  gpiolib: make gpio_device_get() and gpio_device_put() public
  gpiolib: add support for scope-based management to gpio_device
  gpiolib: provide gpio_device_find()
  gpiolib: provide gpio_device_find_by_label()
  gpiolib: provide gpio_device_get_desc()
  gpiolib: reluctantly provide gpio_device_get_chip()
  gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
  gpio: of: replace gpiochip_find_* with gpio_device_find_*
  gpio: acpi: replace gpiochip_find() with gpio_device_find()
  gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
  gpio: sysfs: drop the mention of gpiochip_find() from sysfs code

 drivers/gpio/gpiolib-acpi.c   |  12 +-
 drivers/gpio/gpiolib-of.c     |  33 +++---
 drivers/gpio/gpiolib-swnode.c |  33 +++---
 drivers/gpio/gpiolib-sysfs.c  |   2 +-
 drivers/gpio/gpiolib.c        | 202 ++++++++++++++++++++++++++--------
 drivers/gpio/gpiolib.h        |  10 --
 include/linux/gpio/driver.h   |  16 +++
 7 files changed, 215 insertions(+), 93 deletions(-)

-- 
2.39.2


