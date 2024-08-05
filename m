Return-Path: <linux-acpi+bounces-7294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 657D6947D1E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D191F21CBE
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941C139CE3;
	Mon,  5 Aug 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaFSo8yy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01327456;
	Mon,  5 Aug 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869413; cv=none; b=LHLM1IDr2k01fvybggE1tfZYNY0Js8pgBiMECpMDuuOa0NlHsrfuYi+NqS3sWFp7iORfmkeEebsCItlHfG9fbarpKYepnpfq4ddw8kSS82WpEJGhK5NSk9HdWkkNYZYySaU/hQvuZzUGot7SIiUoLpWFZEYIAIwLzd9jUlh/s/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869413; c=relaxed/simple;
	bh=e2XChZutQiZV3eV2TsEMr6wB2G5qocswctw5/nIP66E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uiPNNvKQ9u/mmVhz7vyUyKLFzgpKTeLcmdFyuwdwxG1KvongnSWVSvVbUWpmJK2R3sEgn5E4HMuCiHcmDQel/KbKD1dsGfldI8HSm3iaIYJpWCDhdurlPgTis5JDbopjAq88uRPBfF2hAqA0Rael6/+zFnBfvgwjjPQ7KxC+ep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaFSo8yy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso10836485a12.3;
        Mon, 05 Aug 2024 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722869410; x=1723474210; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ljthz2dQuk3rQ+R3lwybi0Jem8M58ZqE9rA2r3Unn78=;
        b=QaFSo8yyNpagwx9myFEHCBatDWkZ1slE7HhJ/0eZMGJoy8iceK3DncdfA2FcCretLf
         VzbAA5zhoaIvweRrwtb0h1NIxsp/6g2BxsO8MFA1ukys7zoRIZ6XK6vd8DnT5/6rCKVH
         5g+0UUo6kL2YZxIyv2UJlvPp6v7itXnP6kd+cLt14mQeoWME32UIK2ZhsYeOzL3mNzDg
         xiuIRREL7ZPWiBEXZE0Z7RJnP9BhZjl/Zj1dvvuji8uA5fu2s0dIP43wbsUIgA+HdQm7
         4lOtufrYfHtsWihPhworfws6ow92tiz8k8dIIl3VZVxBtg17fVYBc19cqmikZAEPf1FO
         mUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722869410; x=1723474210;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ljthz2dQuk3rQ+R3lwybi0Jem8M58ZqE9rA2r3Unn78=;
        b=r5zVqXzp+gdPO9hwBJX5ODgX7eQ33x4y3MaVHXYSiYDTQdFDjDMCBOQ4uVwb2IVhtQ
         icmdX5Nnf8WdcznQFL/rqv16uHcyD5G+PNTJwIrTVwmQheGjZjH25kZ4KulQ24RNu9/X
         e8zXw+Ip2k6yRYBNbnCDDegQf2fCVH7/qEhGUKawHEyWueHGI0YnaXfUbnXYTW4ymz8T
         vSAwMIcF6qeJKSL9tjqXa+E6rPPySgvrbpRPD78PF+b3xtAcKttJKPOcZkgMB/p1aQ30
         rL97X2l+CUpKkkt0TzR55b+jPqmHg/K6rXVixMN5tf4Helb2MTKnBINQVZCdKiYrkf/N
         eI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCN0dvnNrJoC5z74jTNqSXsX4hG02Q8dhLeeyeFoY7OGZOEIZyInBJLWHZru50CL8PMnNPXXPXuci4bpqm1ZPBgbQzrtvYEYiS+Wa+TjBj2+K5QFP0iUlwrMY7yVbbN95Vlpkf1VRbZ/Y+BuVdH7XHBVV8LkeH+BjEWqm8FiFFilOFCJEe1FUbO2L4iKFPo0F/430PwTVzmTyR21a5
X-Gm-Message-State: AOJu0YwW6MArmCNNv9mXf8fSCsRK91fG88IPW2LjXpaA3+JYAss7UsVE
	PcX0qxgw8eYcBnoiBB5gUAW5XmlHZS+5+hVMIk7jicIkdNn5/FgMefgKH3Nq
X-Google-Smtp-Source: AGHT+IG1N3aoOhQBtDgIkdWBGPMaaGv1AodMjqsazNsb7LVP7tCkKAAnsXIXhM4sUGVzTUTKPB1Acw==
X-Received: by 2002:a05:6402:148c:b0:5b9:3846:8bb9 with SMTP id 4fb4d7f45d1cf-5b9384693abmr5399294a12.10.1722869409505;
        Mon, 05 Aug 2024 07:50:09 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b82f308sm5004088a12.63.2024.08.05.07.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:50:08 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/4] use device_for_each_child_node() to access device
 child nodes
Date: Mon, 05 Aug 2024 16:49:43 +0200
Message-Id: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIfmsGYC/42OSwrDIBBAr1Jc1+Ivn3bVe5QiRscoJLFokZaQu
 9cECllm+WaG92ZGCaKHhG6nGUXIPvkwFeDnE9JOTT1gbwojRpggDaHYlCMN0oYoQWkntfODkVM
 wgFVWflDdAJhqClqJrhbXChXVK4L1ny3zeBZ2Pr1D/G7VTNfpP1AfC2SKCW4Vt01NKxBU3/ux7
 C46jGgNZLaTsoNfZ1aklvNGtNa0HTN76bIsP+mrwbQtAQAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722869407; l=2974;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=e2XChZutQiZV3eV2TsEMr6wB2G5qocswctw5/nIP66E=;
 b=ZuHNNlHXc6sQtn3WJk8SBGaxbxD4yTcx/hgqlMP+Ca9wWPKxugXH1pEVTvteQMydxrBdKad+0
 8rgtvuNxp6oCh+94zKShrK2Zh21OvfLFMak8er6EZiYjS3j/0SOU9x1
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series aims to clarify the use cases of:

- device_for_each_child_node[_scoped]()
- fwnode_for_each_available_child_node[_scoped]()

to access firmware nodes.

There have been multiple discussions [1][2] about what the first macro
implies in the sense of availability, and a number of users have opted
for the second macro in cases where the first one should have been
preferred.

The second macro is intended to be used over child nodes of a firmware
node, not direct child nodes of the device node. Instead, those users
retrieve the fwnode member from the device struct just to have access to
a macro that explicitly indicates node availability.

That workaround is not necessary because `device_for_each_child_node()`
implies availability for the existing backends (ACPI, DT, swnode).

This series does not cover other points discussed in [2] like addressing
uses of `fwnode_for_each_child_node()` where `device_*` should have been
used, using the `_avaialble_` variant of the fwnode loop whenever
possible, or adding new `_scoped` macros. Such points will be covered by
subsequent series to keep focus on the "availability" issue.

The conversion has been validated with an LTC2992 hwmon sensor, which is
one of the affected drivers. The rest of the drivers could only be
compiled and checked with static-analysis tools.

Link: https://lore.kernel.org/all/20211205190101.26de4a57@jic23-huawei/ [1]
Link: https://lore.kernel.org/all/20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com/ [2]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Rebase to next/20240805 and drop applied patches.
- mvpp2: fix typos in commit description.
- mvpp2: add patch to use port_count instead of node iteration.
- Link to v2: https://lore.kernel.org/r/20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com

Changes in v2:
- [1/6] property.h: drop "if found" from the description of
  device_for_each_child_node()
- [3/6] bd2607mvv.c: fix child node usage.
- Link to v1: https://lore.kernel.org/r/20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com

---
Javier Carrasco (4):
      device property: document device_for_each_child_node macro
      leds: pca995x: use device_for_each_child_node() to access device child nodes
      net: mvpp2: use port_count to remove ports
      net: mvpp2: use device_for_each_child_node() to access device child nodes

 drivers/leds/leds-pca995x.c                     | 15 ++++--------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 31 +++++++------------------
 include/linux/property.h                        | 10 ++++++++
 3 files changed, 24 insertions(+), 32 deletions(-)
---
base-commit: d6dbc9f56c3a70e915625b6f1887882c23dc5c91
change-id: 20240701-device_for_each_child_node-available-1c1eca4b6495

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


