Return-Path: <linux-acpi+bounces-18518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE163C348BC
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C24EBBE4
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA3A2DA760;
	Wed,  5 Nov 2025 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="csPyQdkm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074420311
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332473; cv=none; b=oxwpZEpc/dUwSpzsD95VqP7AnuD8ti4rkGxaaSApm2MriyFuzkXyoNJ+8M73LfqrsSfqmLFvOt+LKgCJVLNkGRWf/qbQfLaTajtwMjNnpdn7aPbKbNHPJ1ecVwfS8VyM8PLg+1FHIuZaXoSJ5prBSskDT5dhXhUlx/NslSZ9DUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332473; c=relaxed/simple;
	bh=n0W+GjH11HLje3IhUdA3ENShv95X23NrewxjjizzwVY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YesX/8KHI4+peibUZwGxaBH8160VC4uXV8MBhOTqbkZuNTPELlq3dPrkBKE8gXzdnQa5hzBoZ70aRgC6fovc+eMSRD6UA4Zxv5PdE8HorKzE1TEbZX8DAAjiHQdALkt0nN2cPortHgAi5VxfV4fAqGwa3TBkWgbJJnajPzGZSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=csPyQdkm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-426f1574a14so3879905f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 00:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762332470; x=1762937270; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5Ia+5vxBYJJ5tiYhztEpLGZioifLc7KB1NHxxtTHEE=;
        b=csPyQdkmzDcSrcXmr6UaQlhzEcQHnWYfdYdYrPd9k+stvFJKLHcnOyEnZ52qa3etnt
         7xOxzVCWbw3T0pfapbWgJY8eSyIRPxZCDe2cAVljzYXSTxL3UFkBu52dovKTaRX/yh1d
         ge01J4icF+gAO1nB1dLjuwlrI2J6J/PksUTUUI+apr+UnzvL24sqBPzpLLsKxOc5kDlS
         r45zZ3ItJCk1mD2GCSXpGtLf9o6AdYYiVPsH6oWFLIPPzXHewblspelM/ssnOf1g2VPp
         j3l6Z8jI33pl4444d+7i/IDCcaRa5/674El7s1NR/Mf9EMXzl/jE1LrqRBMjLuQs0CqP
         RCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332470; x=1762937270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5Ia+5vxBYJJ5tiYhztEpLGZioifLc7KB1NHxxtTHEE=;
        b=McLTvfmqSFz6yUjedXoysPSGGpDFXTzE29IPZYvMn8m9iT+vW3dhNjYJF1KOIKZA9d
         XmlWF4wnbfD2UlYQDT5h1DTd6Uwb3zAWe1MFe3SQH8SzMhlEZ6N7z6A69cAzlGq0cYNa
         z+sQYgMUL481HqTLwz9ptmUqLYtRrxk98IO8VEiSj2QdfR0fz6KsEvM10ISSZOrplxTM
         G7p7seaO9xQkPMRyOFVXl7ygUIjV/DT7TbDC3H4Xocaa4L+HDYmzz+OVVTGeF3Wp3L//
         lYoF3kPXpo9b+WL8PLi/yfoUMePOAOu9xxQCcxsb+EC6VTzjmUr5qtY830D2uG813Vju
         I1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXHMi66OOa/kya1PwshISHaJ/vWhP1+27UE/O39pbaE1Im5bvrm4lhGAcwvf75wWMajS3mUR+V/fnzk@vger.kernel.org
X-Gm-Message-State: AOJu0YxypZYHcEPjbMMBPknaqEsl6dFt6Ozx+2SOFFjk8FWasBDyI/4H
	GOcyGCIrDDEVVucz0CY7h9xm3Qh/twdkktFx2JfdgYvgL4n3Vlm8i5YRwLSseJP52gQ=
X-Gm-Gg: ASbGncu7hoXGWWKcve/1fHx1FSwwiVWMRUKzbSNL7mPkgk/mGVuFBNXCerJgm34fxUb
	alQnZPVm5sS07GHxIwo/HsaMWXKItlYefcJ07FDdQsfdNcwgDIM72FTGEjAHRju/8eGNs5ulg2p
	jS/Kfabkq9H6evcvhzKWr0HfDe03FOHXZ3yKFlb0AkKG8IALzNGvK6fIdN3R7VBjMindiPkzEeZ
	I9chHRNPlSI4yr9ZfpuHmshNMEEThEqgQqxkitJ9Br2NmEYrntO1nvabqsaNRwLbjkEUr4VAMzj
	ytqQeprDxgxneCW0kPz/HKaB4MstTeWYkZz0g/NGtt7Tnh6LVRSYPe5ZP8itA96bmgi8yjO6T3W
	m/IlBiAlf8gRNeDdVjIxIJILLKMjEeKHT33har44ooQ8b2B7AFM1TgtJT+6Hx6vTCPvReoVofzn
	M8Qeo4
X-Google-Smtp-Source: AGHT+IFdPJBhhemQwfLCnNlhg1dIictiE4Pv7xg48hHSQtNuuDa4pWjvLdjYG8HbrR1Hf6zK/YqBRw==
X-Received: by 2002:a05:6000:40c9:b0:429:cacf:108a with SMTP id ffacd0b85a97d-429e32e4479mr2107000f8f.19.1762332469552;
        Wed, 05 Nov 2025 00:47:49 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4e71:8371:5a52:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9315936f8f.34.2025.11.05.00.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:47:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v5 0/8] reset: rework reset-gpios handling
Date: Wed, 05 Nov 2025 09:47:31 +0100
Message-Id: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMPC2kC/23OwY7CIBCA4VcxnBczDAwtnvY9jIdix0qyKQZMV
 2P67kIvauzxn2S+mYfInAJnsds8ROIp5BDHEvSzEcdzNw4sQ19aICCBQ5KJM1/lcAkxy/w/xp6
 z7D2RZtuAIy/K5iXxKdwWdX8ofQ75GtN9OTKpOl08BWBXvUlJkLbXGsm77mTw9y+MXYrbmAZRw
 QnfEMR1BCvioG1JAzrlvxD9jrh1RFdEt505+vIOqC/EvBAFeh0xFTFWtQDeNg19IPM8PwG615o
 1hgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5765;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=n0W+GjH11HLje3IhUdA3ENShv95X23NrewxjjizzwVY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCw8tAPorImn4K1v+h95OxESBYkTVCHeRmU6M9
 W7hm8CD64eJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQsPLQAKCRARpy6gFHHX
 crzPEADiZvW5zXIEC9XU3ES6W0jbEe+jZdyfYVGO3kBwid2zewFcrwTbMg74LYXa7dyGVZ2IhF0
 MSze5CihyzkkrDEPJJMBrA1PZCula9/Eedz+hF+xDCRSxdyiNCJNhCb/uAZanbuLsTxE34A0dTX
 yvJYWzsRJEyCHe8pwF43bbkg/IrggWJUZbNMs6WtNugaapOWjBVVUDS9ClADNWisJ1TZ09Sf+mC
 q178VTUwiRxh3GWICg8fX7vkcCY+q9wQntNW012lzTd/dtueBy50cTvN+fX/duOIIOlle31Js8E
 QU5WSlh2WVVbttydz6HcJvLe0bf9dRNcAS2jVGfzb6ARxRniSpEOopWeCdhYQG2ufowgYyfW0jz
 Vjfy+XQfyOR99Dm//JcSKu0yk9I0BhlXzPflsbGWBBXD8zeQJFzepsSvU4cWtjr0gyh4dDB8DP4
 rIcf5lR3v5kuX/wsT+9HyOVFOIpbA5oq79nk7aFaEQ9WknUOkoXlgRaK61gH0emVMqLxAVPiCPw
 GpobqUJa9KwG7SzCA9ofegpsSGz6WoqjsaPjodi4LVgPqGe9G/VtOMg7oBCsVNK+omlBRspfPQ2
 mRL321dPSo0iT9BuzVjeESUQnQRFl7B+pwpWu1nM14RZNAjDE07nAK0tkLfYn7a4b83OWVV8FS3
 UfmghuSBEla/qCQ==
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
 drivers/reset/core.c          | 148 ++++++++++++++++++++++++------------------
 drivers/reset/reset-gpio.c    |  19 +++---
 include/linux/property.h      |  13 +++-
 6 files changed, 132 insertions(+), 82 deletions(-)
---
base-commit: 761a9e21fbdf60933bc8a4829151d42509853ef1
change-id: 20250925-reset-gpios-swnodes-db553e67095b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


