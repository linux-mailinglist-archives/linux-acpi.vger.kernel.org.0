Return-Path: <linux-acpi+bounces-8475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796AB989128
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Sep 2024 21:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37051F23D5D
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Sep 2024 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4360914C5BA;
	Sat, 28 Sep 2024 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Saw4FWia"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AA1CA80;
	Sat, 28 Sep 2024 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727552863; cv=none; b=ENUO404v9WhnneAvU35Sf0TkbaUIrxRO8BmX+Q7jBV8oSMQKRlkLXmRcmmttuQ/JsRrWB/m6G9rzi4rEI+IHorCEpshvHG7fL9XJ5fnGrc/eHWgsRWQFsPhrVxEkRj8mmR8jyXOVvtgYjJh+rliuf6HIm89DDYwJ4aIiKt0qIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727552863; c=relaxed/simple;
	bh=fJbNOcFYaMgvZAxHv1kP7f+VXmQr9ZxxO7woGGuT5To=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fIAHb8FCm828/S/tiEtnz2ID/lwCMaT6VKs2jXijRfb/Igu2dCmtc4hYHh3AUFpibiWCjQjlQmJwHus7WjnWz9RGASePBUTNKdgfbLDt/4tCCPQLYHAJq/IZ6XEpI0ndr+dMObBZxmPJbM+RMGJgVzIeHDDXuJVgFt62922g8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Saw4FWia; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a837cec81so231221066b.2;
        Sat, 28 Sep 2024 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727552859; x=1728157659; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GWovy5iQy/WwBffEzIR4Ih+XX2NVmGXEc9tW1BzRk0=;
        b=Saw4FWiaru/e8pUoaxnTEdUJSEL5Bfk2AEVMK9ib4W28520siXc8ontfoRy5uXxi/v
         Yq0brnx48MDBTDhlmHDwcG8GcKi2bT5mKXkDWFoTjf2oKkt/dfNMSJOKa1jco2MeM9bx
         NoFocd6LlNmJjWuGNR1ydLO42N8IBFz6qBVus61+AOjRjkyMzRoRx7Cd9cb+MGJFDKHi
         LEm+aC6RWpsf7LbDF3TQOnlbVuf/BbxdadyjKx71j31w4c2Aqx2M/ofBYNJ9hX9OjLj+
         jt3fRGNlxWlQK9AygMvS/QZ50SkK8c43yjMoT3gpsGz4N0qPnanH51uC71Gt+4Ao7Zxa
         XH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727552859; x=1728157659;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GWovy5iQy/WwBffEzIR4Ih+XX2NVmGXEc9tW1BzRk0=;
        b=CkmmQPWLV49/S/6BPsZMFLhr7iNaxYnDxftVB1ubs2x7qrl1yENca6VNyy3snjPEVT
         vjZPL6AFVWC+SdNtXfCxWGwBZBQYyeaza8N8x3d2GVyY8lic7SKI4dYMdKhxzAtpwAOg
         FOvQSFK45++Exi/8pnj5wmXHsLped4IHEIqlqax+4SxKX/TAAxPnCak7158FGmYxoCAN
         qSxjn1kij6cqm3N6ou9IFLKM0g5khb2lOZ+PQ1x/2h8lWiov7ys/e49QhNiJf6Psy5yj
         gr/Ey0Dt31dXx6sFuRVtX10/iXUyWjumBk4u1zarjoAUYF7tuX8KaPZXnU6unxElzzC9
         5zSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiM5F7pG/L4wOCcIqpYSzZt3awM6KpOzIVLM2sAYIlQYgmcq+39K8TUnXby7m8JtMSGCZ71Fzjx74KXYAQ@vger.kernel.org, AJvYcCX6dTFRizPdTBPaoL9Gz62sPgAqTGKCjPWDXe5gMvU2sueVfK07Sxa0e9BFjNOHoyw7NaMRlTguo5GL@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHf4NTBaJSi6D5vsN8iiGLgJtcnymUVZG+0kJ+yPvcnky0yYT
	mpYwAEfGDfOkhAhpdmMnCXy4cto+7vzWs3NZtVysM0tAIikUs24PKr+RZg==
X-Google-Smtp-Source: AGHT+IFB4AA8QBh5vxmyKXSwxK56TBUS1OMZBryQXvn+OIq5H7VPbL4+NnfzpwD380/ZUNiEF3ibPQ==
X-Received: by 2002:a05:6402:254d:b0:5c8:8cf5:e97a with SMTP id 4fb4d7f45d1cf-5c88cf605d4mr3527444a12.33.1727552858777;
        Sat, 28 Sep 2024 12:47:38 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-2243-8f1c-2a7e-ca73.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2243:8f1c:2a7e:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775c22sm283707466b.20.2024.09.28.12.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 12:47:38 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/3] gpio: switch to device_for_each_chilld_node_scoped()
Date: Sat, 28 Sep 2024 21:47:34 +0200
Message-Id: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFZd+GYC/x2N0QrCMAwAf2Xk2UJXplN/RUYoSboGpCktiDD27
 xYfD467A7o0lQ7P6YAmH+1qZcB8mYByLLs45cEQfFj8I6xur2rIwyTBZA0lUkbK+mYsxoKdrAq
 7GPw6J7nSnW4wYrVJ0u9/9NrO8wc/womTeAAAAA==
To: Hoan Tran <hoan@os.amperecomputing.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727552857; l=2253;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=fJbNOcFYaMgvZAxHv1kP7f+VXmQr9ZxxO7woGGuT5To=;
 b=NhdBexuFeqVrtB/652gbzbQT6DhLkk7TSGkGQu5d/3b8Fx0VIVafDDhXtm6JYgA0/bQ4VxRKb
 zdW2GrNUSfCAPdBwAUX2PPxYUkyn2PoGwlIMgHTgY++gM2o2QWWv68d
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series switches from the device_for_each_child_node() macro to its
scoped variant. This makes the code more robust if new early exits are
added to the loops, because there is no need for explicit calls to
fwnode_handle_put(), which also simplifies existing code.

The non-scoped macros to walk over nodes turn error-prone as soon as
the loop contains early exits (break, goto, return), and patches to
fix them show up regularly, sometimes due to new error paths in an
existing loop [1].

The uses of device_for_each_child_node() with no early exits have been
left untouched because their simpilicty justifies the non-scoped
variant. In particular for gpio, there is a single case in gpio-hisi.c
where the loop does not have early exists. But if desired, it can be
easily converted as well to enforce the usage of the scoped variant when
"borrowing" existing code.

Note that the child node is now declared in the macro, and therefore the
explicit declaration is no longer required.

The general functionality should not be affected by this modification.
Apart from automatically decrementing the node's refcount when it goes
out of scope, the scoped variant works exactly the same as the
non-scoped.

If functional changes are found, please report them back as errors.

Just in case, and even though the scoped macro already has multiple
users, I carried out a quick test with gpio-sim and a few nodes defined
in a devicetree, and everything works as expected.

Link:
https://lore.kernel.org/all/20240901160829.709296395@linuxfoundation.org/
[1]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (3):
      gpio: dwapb: switch to device_for_each_child_node_scoped()
      gpio: sim: switch to device_for_each_child_node_scoped()
      gpio: acpi: switch to device_for_each_child_node_scoped()

 drivers/gpio/gpio-dwapb.c   | 4 +---
 drivers/gpio/gpio-sim.c     | 7 ++-----
 drivers/gpio/gpiolib-acpi.c | 4 +---
 3 files changed, 4 insertions(+), 11 deletions(-)
---
base-commit: 40e0c9d414f57d450e3ad03c12765e797fc3fede
change-id: 20240927-gpio_device_for_each_child_node_scoped-a2071fe5c8c6

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


