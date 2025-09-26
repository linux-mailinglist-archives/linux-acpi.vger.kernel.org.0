Return-Path: <linux-acpi+bounces-17345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A50BA3C57
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 15:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A381164861
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DE2F6577;
	Fri, 26 Sep 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E+MAVfef"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3B2F5A20
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892294; cv=none; b=LgKk64KPdx0xYaJAjkpyeJsvfrZ7LXlDdkKw/JYZJGt4FdyoRilz1SyjEUNGb6PGwZYxuomMKvUobRWL+qeSeju//QsKDBGcqeCPFmahDOAhqQU+pqLPXLlT5PvZ5zKRKr6JgadyWy+xyh8n/wyqoGsp3OmwOWQq0OXn8rRDA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892294; c=relaxed/simple;
	bh=kTIx/gbW5FMHGZwkamAX2U1Vd88ShDnf2ZfAQ8RTCAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y77anvvQD7kdfu05eFghYlbWgL6dK4y50tuBefJGlE3pTPRWaLqh4exzoTi4knMo/fyNRBhbBuBxPHQX91nvIBascGuc2Utgc0c/llD0oXZESoNaQGlOeeIGEy742urQQTAmwSOhxnevQcque0NgVFrJAO942lXOvhMr76Z1CVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E+MAVfef; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso2744376e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892290; x=1759497090; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDmNVhJHkWPdowxg4squkpPV1N/rsJjSEr9LXYJ99w0=;
        b=E+MAVfefudY7/qxHnbxhDO+KX3qvhh1WTGF6ko5dEZjljYzb2UEGn4YGO1SKeYgwmS
         voXZONIQftp+duXOgrhEID9XNOiiKM9mDq4Ymso1T4oj6MajO6i29sBs0XRH72aeW+SK
         AHYcs1q6J+wj7vntFU86T+ZHyr7BjvGRVmi0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892290; x=1759497090;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDmNVhJHkWPdowxg4squkpPV1N/rsJjSEr9LXYJ99w0=;
        b=pOJx55V2AbAtXsYViZMxiaV3PblX6Ngc6jv71nWH2JwGbGUPBNNrqzUcZz7QK5ek/s
         wI+/szVvwgaDRFbUgP3W1s9+YT6EOHezV+6m9526JWgfIAvcPbVHWU8PAV2l1Rf0caPK
         x/G2qXlhnjxKtAkY6/KJvoJ7RHHVnXbTOfYcuIYH7A0NgRKl+DsfAv5Ai1oKoA6A/NE8
         dGUnFfewSxquSk7MAhCC9azUyKzTnqeDXrdNQ7i1T9DFUiGxjvJYb/YXL28JnipUFbHe
         lprVzW53KYTYzwL9yPev1WEuF7aoDiNnC9FnMfzP+009E0xJSu2wAQu6w/PPLs8esPpq
         seew==
X-Forwarded-Encrypted: i=1; AJvYcCWlG46heflxrBVvePFvo526Zdnsr0KaO7DnsJNfiJgRDWFjIRrCsWUt+PCUpZAELcDuJJAw5UBeFN+E@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBmxrCTIJWi2NUMrpP6qGam9/iwGE8aFYv/UDIwDOFVm7cdxF
	PnOh8eyv2UWu3+nKjnaLrQuKIfPSrVHCUHLUJyCCXZcov7iC0nj4Gf0zeM4ms2ASDQ==
X-Gm-Gg: ASbGnct8oZ4/fQWPdmOXvkxJpe+bsou/d4JeVlfxSZtuhzS3RJfcnM6CM981iC0o1G2
	Nps29iA8KvPWvp3j+6ISk4d5O7qpB9qv0dY+TVTjWl9Y9qq/iGBozcQPHnjewZ3Yyp8xCwlUYCu
	cy1/RbFjNEL4RYmWryCxAiAR8D85DXiSY8LJwd9eOv6aCNs+eBLSViw7sRyTDoS7R3j0ETIB4Zj
	Rr2Iv6Dd5vrBRKjBNRIvoQOfDDOxfpo/2HVCz941pmORojxXcmzk4btY753WtUjRc9nCAFxxW09
	Q9vKjgoiMwR846FWuUdMLsuwnepOAgjC6TuSHDEEu391/zkgeE8gkqrk5xoE8mxTbANVqCIEtp0
	u2uUBNy1DU+hna8FStvWCJAE8VCG/02uSBwITe8LQvVupLB3UE+JaD9r3+QxL5I4/qq7jefZ+0R
	s6OA==
X-Google-Smtp-Source: AGHT+IFre7rGlPJYVo4GSUWdzdcqW6jFgSmqfsnv6P/WyQ1IpYAO/8aDPCOXsn/mCcLjhUPmvTsyZQ==
X-Received: by 2002:a05:6512:159b:b0:579:f4b3:bc3c with SMTP id 2adb3069b0e04-582d37cacaamr2234865e87.55.1758892289663;
        Fri, 26 Sep 2025 06:11:29 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 00/12] media: uvcvideo: Add support for orientation and
 rotation.
Date: Fri, 26 Sep 2025 13:11:24 +0000
Message-Id: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPyQ1mgC/3XNTQ6CMBAF4KuQrq2ZFgvBlfcwLsb+wCygpi2Nh
 nB3CxsTjcv3Mu+bhUUbyEZ2rhYWbKZIfiqhPlRMDzj1lpMpmUmQCk5Q8zlr7stkSpjKLVeudaI
 zqNDcWVk9gnX03MXrreSBYvLhtT/IYmv/W1lw4AJBa9UpbKS56CH4kebx6EPPNi7LD9GA+iVkI
 VQrwHUGakD8ItZ1fQP1BMLt9AAAAA==
X-Change-ID: 20250403-uvc-orientation-5f7f19da5adb
To: Hans de Goede <hansg@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

The ACPI has ways to annotate the location of a USB device. Wire that
annotation to a v4l2 control.

To support all possible devices, add a way to annotate USB devices on DT
as well. The original binding discussion happened here:
https://lore.kernel.org/linux-devicetree/20241212-usb-orientation-v1-1-0b69adf05f37@chromium.org/

The following patches are needed regardless if we finally add support
for orientation and rotation or not:

- media: uvcvideo: Always set default_value
- media: uvcvideo: Set a function for UVC_EXT_GPIO_UNIT

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- refactor dt bindings
- add media: uvcvideo: Use current_value for read-only controls
- get_(max|cur|def) = swentity_get_cur
- virtual_entity add codestyle
- Codestyle
- Fix xu get_info and get_len
- Drop ACPI_DEVICE_SWNODE_DEV_ROTATION
- Add missing select V4L2_FWNODE
- Link to v2: https://lore.kernel.org/r/20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org

Changes in v2:
- Add support for rotation
- Rename fwnode to swentity
- Remove the patch to move the gpio file
- Remove patches already in media-committers
- Change priority of data origins
- Patch mipi-disco
- Link to v1: https://lore.kernel.org/r/20250403-uvc-orientation-v1-0-1a0cc595a62d@chromium.org

---
Ricardo Ribalda (12):
      media: uvcvideo: Always set default_value
      media: uvcvideo: Set a function for UVC_EXT_GPIO_UNIT
      media: v4l: fwnode: Support ACPI's _PLD for v4l2_fwnode_device_parse
      ACPI: mipi-disco-img: Do not duplicate rotation info into swnodes
      media: ipu-bridge: Use v4l2_fwnode_device_parse helper
      media: ipu-bridge: Use v4l2_fwnode for unknown rotations
      dt-bindings: media: Add usb-camera-module
      media: uvcvideo: Add support for V4L2_CID_CAMERA_ORIENTATION
      media: uvcvideo: Fill ctrl->info.selector earlier
      media: uvcvideo: Add uvc_ctrl_query_entity helper
      media: uvcvideo: Use current_value for read-only controls
      media: uvcvideo: Add support for V4L2_CID_CAMERA_ROTATION

 .../bindings/media/usb-camera-module.yaml          |  46 +++++
 MAINTAINERS                                        |   1 +
 drivers/acpi/mipi-disco-img.c                      |  15 --
 drivers/media/pci/intel/Kconfig                    |   1 +
 drivers/media/pci/intel/ipu-bridge.c               |  58 +++---
 drivers/media/usb/uvc/Kconfig                      |   1 +
 drivers/media/usb/uvc/Makefile                     |   3 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   | 201 +++++++++++++++------
 drivers/media/usb/uvc/uvc_driver.c                 |  22 ++-
 drivers/media/usb/uvc/uvc_entity.c                 |   3 +-
 drivers/media/usb/uvc/uvc_swentity.c               | 107 +++++++++++
 drivers/media/usb/uvc/uvcvideo.h                   |  22 +++
 drivers/media/v4l2-core/v4l2-fwnode.c              |  84 ++++++++-
 include/acpi/acpi_bus.h                            |   1 -
 include/linux/usb/uvc.h                            |   3 +
 15 files changed, 441 insertions(+), 127 deletions(-)
---
base-commit: afb100a5ea7a13d7e6937dcd3b36b19dc6cc9328
change-id: 20250403-uvc-orientation-5f7f19da5adb

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


