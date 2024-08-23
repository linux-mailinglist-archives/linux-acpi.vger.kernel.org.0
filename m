Return-Path: <linux-acpi+bounces-7797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDCE95D021
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 16:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BAE1C20C8D
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13C188920;
	Fri, 23 Aug 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIkSXfAt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFD3BBC0;
	Fri, 23 Aug 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423588; cv=none; b=SDPWJGjJRb/eB77eQB59vjzIVz06mxY3dhakGSY9/P5snJj568wbm4+oX2cNN5Ot2K4dT17C6eBGuZjVgpJFvu+GD0drsLRr1JQbgXXBm+mmyuERUKF3kR8bI9VedvVQBpYQRvsTtWuADgg+EUKrVhS560Vnebak3Jo2+eNj6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423588; c=relaxed/simple;
	bh=QS1E7YlYU83ircHH/+tUWA3+lbIf/YzH74r9ILKvUQ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Y0As0HQwo6LuvoaPzDfWUFlckT0J9LgAy1PQCm1iCE7tFMrDdil+N+nR2o8WJbPbndv5gd7EgsuTJ3KqE4+gOINSVzfLntN7ix0yqEjqcZPvxaNcQzlIR04O6PZ1vHJ8kmIrSAjNKuvYvTJLWPYFBP8FKjis5pHWSfxF7R6YWII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIkSXfAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1827EC4AF0B;
	Fri, 23 Aug 2024 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724423588;
	bh=QS1E7YlYU83ircHH/+tUWA3+lbIf/YzH74r9ILKvUQ4=;
	h=From:Date:Subject:To:Cc:From;
	b=MIkSXfAteYdrLCYDoaZA5ckRtt5GghBo6/gx8NEIVmp/xetp2uvwf0hswnnzGtHlO
	 +XlMgvkILOcxjTql0J15juid0bPwioOvGkkrlfxlGdiWI6uehy9270cEsRiCC5DcR6
	 fySjovkeqD5DECRjWCCxweG/ZnsjI0eOrGWk2zW5tRX5sxZDXIE43n08lvd4IOsTjs
	 hxns6yap4DDsrUP+/Wt5pc12BwlWXDIPFLubN4SInphqKUFWNCCW0nUBQqIuHFA7E5
	 ox3EyNfyEIfpzMFaikuWi5ZvZT2/+5nsJG88DK7FE+XsibH7DSxz++nKDI28i/lZxj
	 yo6x59FYiXqXg==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093472356dso1539217a34.0;
        Fri, 23 Aug 2024 07:33:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3nA8AwpAQTz5ICRHZkuevLOpedUCF7zpGPnLjwV6Y0IGjmMly3ppvMu9XDnO8sJycw07JnicLDJ4KSMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8bjbv7RjrNw1tTQfcIZ3jzU7W4szcXMSKbyj5I/vd1E8VjsO
	yM8VMMn66qj2g2ZAl2EiBYjCRFkxkHyzA8odWTe20hRoSmDYsLVEDQfq0Xa7i75X1sey8gS1t4i
	xSkTSU3KuKZ0SIVCcv7oX26rw2+c=
X-Google-Smtp-Source: AGHT+IHQTurZp/7M396/cD8Y45dC3BwWhKm0YGmREek5xr7qquC7Vt21IYBrl5zOuAKipikQHh8efKgx8QeIIkKvrJ8=
X-Received: by 2002:a05:6870:8a25:b0:261:1dfb:3f35 with SMTP id
 586e51a60fabf-273e672a2a0mr2643693fac.48.1724423587327; Fri, 23 Aug 2024
 07:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Aug 2024 16:32:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJobeqPY7fZCQAiZg-fP=Vyeak-6mEt5Rt2cdat5ChvQ@mail.gmail.com>
Message-ID: <CAJZ5v0hJobeqPY7fZCQAiZg-fP=Vyeak-6mEt5Rt2cdat5ChvQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.11-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.11-rc5

with top-most commit 5c7bb62cb8f53de71d8ab3d619be22740da0b837

 ACPI: video: Add backlight=native quirk for Dell OptiPlex 7760 AIO

on top of commit 47ac09b91befbb6a235ab620c32af719f8208399

 Linux 6.11-rc4

to receive ACPI fix for 6.11-rc5.

This fixes backlight control on a Dell All In One system where a
backlight controller board is attached to a UART port and the
dell-uart-backlight driver binds to it, but the backlight is actually
controlled by other means (Hans de Goede).

Thanks!


---------------

Hans de Goede (3):
      ACPI: video: Add Dell UART backlight controller detection
      platform/x86: dell-uart-backlight: Use acpi_video_get_backlight_type()
      ACPI: video: Add backlight=native quirk for Dell OptiPlex 7760 AIO

---------------

 drivers/acpi/video_detect.c                     | 22 ++++++++++++++++++++++
 drivers/platform/x86/dell/Kconfig               |  1 +
 drivers/platform/x86/dell/dell-uart-backlight.c |  8 ++++++++
 include/acpi/video.h                            |  1 +
 4 files changed, 32 insertions(+)

