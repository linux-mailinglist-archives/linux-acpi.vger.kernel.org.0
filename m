Return-Path: <linux-acpi+bounces-5966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9328CD78F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8643B282294
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F9D11C92;
	Thu, 23 May 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM8h9LZp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0AAD49;
	Thu, 23 May 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479254; cv=none; b=YUD7DmzNz6xOH2ZApXBxFLhk+7V3utG94KEN2LZVg14cBvRrf/C+MTOeoGstdCDKFgm19GH30hsixY98d0U5QQAd6TNYLv/G8YMuE4bItL2xdDFa2yDuwdNj0g2UAPxsfWGb9xe9LX6fG8CyV8BZa/Tc5E7SSHyl7b0M6doP4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479254; c=relaxed/simple;
	bh=D2zB9oTuuFtkMQqmGUvI6YlJeksrcGZZQQ7omxucUB4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SEqsPmlsoAqL+JIOJmv14Uf9EQIFAgzeNcNTH3nGEv8Av54ccr1es6yKKH+3tSz6iLeLHj2DJqVTlB55tuLYJvmh6PBO6qAuvmtaIf9cVxaDE82ENqN6fytTAPbxx019NIsqMpmQJDZR0mXgLg5/yuveBLCw/zkl74JvlNqdVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM8h9LZp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420160f8f52so21414315e9.0;
        Thu, 23 May 2024 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716479250; x=1717084050; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JL197cT3QzETxXdjAAEsNcyOFt/5C7nRid5WqhKtJcs=;
        b=dM8h9LZpHYT/LLbRaZ/4ere6KsBqNIzjOeZnY2cSV+zixk/ASCMl/A3UCf7BWdX5YC
         A6D+MTNLFPxel6Z3FEQIdM4FVuNMKqBkzJBAQ7Fc4AF2GT9hds1sThHRsIODM3+02wfc
         dDz27xwqPHNeSCb1G1k+axMKv6aPr20V+69rhOZlIjJvZRqYAN3VJcO9+hR2vRl3VnlM
         01dlGew2afBzBrOUbAdKCcKbQU9zBLCwCufuVFJ2hQ/sRCVXoOasIOJPFrO6zmi5Q4w2
         iNJogVAEC3soU0TbAvN2HGfWm4Qkf8+b/96nbuPo+sTJRN/sHm0JQtXA5y8uUf4C3F8F
         Spgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479250; x=1717084050;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JL197cT3QzETxXdjAAEsNcyOFt/5C7nRid5WqhKtJcs=;
        b=uN38sVMrw+eDO/gr5EL66OxjscO82/QSSwSMjYXSkbXdvgDVT6MU/uNhHTQWIGEI7H
         +LJUS0/fhIU/wzxAQwp0mz1eOpcpdH9pniQloUAqqIXmdvR0xBfZYcEb/s8Y1Z1F3iDX
         Du80XHucVNLuExlYi617+l9zhPzaS6HUvmcBTxuqTQIXx+PVk+M9l2iawJl2OHWn4UyN
         fEM+fgWOpEyq5uDJLOTXVRQvmbfxL0xAKghgjgaqUmMA9ppdCwiT7QzBkaDwUcHEN2TX
         b0Oegqtx+7pRwehRbAdAGmAD/OfVPKpAOTXEpapYssZGww1HQVIVszWk+CW67eODpLx4
         r1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUPqerbPGtA18mLegXMgSPyuOwbEv0nFFtAZ+kbmxKYdoiWcWL2L1IET2/udHWIMjZ9PDIONEzpHOLMaZHLND/0IEBGSKMLtZ7NuT4Nka6UmUaWFYbqlJsitJy+EBvpaFMQmmHyqRF4torIYDqkjjwzQ0e/N+IDzRkJATrAXKhDIk4=
X-Gm-Message-State: AOJu0YwEwTZ+S/vBNEB+1sbl+BA6X30z7YM4g3mHJTXeo5WKj2+npcfk
	Uqg4/N9dBwZidi0WpdwcO49hW7joCVNbXR+PbCMExEVNPGMMVu+X8+nEe+gHEOA=
X-Google-Smtp-Source: AGHT+IGxPsVE4oweh+WP+FUJLBq0xoaVtpcE2qE4/N2ImfMss5nL9lxKfwnmsp+sN2I7K2Oddpq1HA==
X-Received: by 2002:a05:600c:c2:b0:419:f9ae:e50 with SMTP id 5b1f17b1804b1-420fd375f0dmr40635925e9.37.1716479250321;
        Thu, 23 May 2024 08:47:30 -0700 (PDT)
Received: from [127.0.1.1] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5a576sm28569725e9.22.2024.05.23.08.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:47:29 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/3] device property: introduce
 fwnode_for_each_available_child_node_scoped()
Date: Thu, 23 May 2024 17:47:13 +0200
Message-Id: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJlT2YC/5WNUQrCMBBEryL5NpKNCtUv7yElbJNNs9A2JZGol
 N7dWPAAfr6ZYd4iMiWmLK67RSQqnDlOFfR+J2zAqSfJrrLQSp/UWYP0zyk6Mj4mQ2iDwYI8YDe
 QsYEHZ7Y22ziTk40Hry7uiKCsqI9zIs+vzXZvKwfOj5jem7zAN/159F+eAlJJgKbplEPQzt76s
 a4PNo6iXdf1A7Tyb6jmAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716479248; l=1994;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=D2zB9oTuuFtkMQqmGUvI6YlJeksrcGZZQQ7omxucUB4=;
 b=Or/oGb5gVgcBZHPU8VAUKL+asN5MqmDl3TD2Wn6EhUnkhZg0HNxH+ikvLV/RJSmkQ+980RKmL
 r/vumNcPDmYCo2ykIpn8M6URtL2lgnoig9r9OZUwbf5frZthXoo2xLP
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The _scoped() version of the fwnode_for_each_available_child_node()
follows the approach recently taken for other loops that handle child
nodes like for_each_child_of_node_scoped() or
device_for_each_child_node_scoped(), which are based on the __free()
auto cleanup handler to remove the need for fwnode_handle_put() on
early loop exits.

This new variant has been tested with the LTC2992, which currently uses
the non-scoped variant. There is one error path that does not decrement
the refcount of the child node, which can be fixed by using the new
macro. The bug was introduced in a later modification of the loop, which
shows how useful an automatic cleanup solution can be in many uses of
the non-scoped version.

In order to provide a backportable patch, the conversion in the LTC2992
driver is carried out in two steps: first the missing
fwnode_handle_put() is added, and then the code is refactored to adopt
the new, safer approach.

@Andy Shevchenko: I kept your Reviewed-by in 3/3, that now also removes
the new fwnode_handle_put() and braces added with 1/3.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Fix the memory leak in a backportable patch and tag it for stable.
- Refactor 1/3 with 3/3 as well.
- Link to v1: https://lore.kernel.org/r/20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com

---
Javier Carrasco (3):
      hwmon: (ltc2992) Fix memory leak in ltc2992_parse_dt()
      device property: introduce fwnode_for_each_available_child_node_scoped()
      hwmon: (ltc2992) Use fwnode_for_each_available_child_node_scoped()

 drivers/hwmon/ltc2992.c  | 11 +++--------
 include/linux/property.h |  5 +++++
 2 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 124cfbcd6d185d4f50be02d5f5afe61578916773
change-id: 20240521-fwnode_for_each_available_child_node_scoped-8f1f09d3a10c

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


