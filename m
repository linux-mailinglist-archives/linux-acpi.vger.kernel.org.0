Return-Path: <linux-acpi+bounces-7564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B497F9518B0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 12:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674DC282957
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12F41AD9F9;
	Wed, 14 Aug 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdESapip"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE71AD9E9;
	Wed, 14 Aug 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631257; cv=none; b=p1wRk+dBuk3zDkag4hxMQqWRhCEilB6HalGOWXMCS4uwZaf6okGxZJsZmp+vhBkIARsacnNU6f3+HbmG4iJVhVKOXjsCSQV8OgvaQ1mfCWvR9fA0MvKf8ApCrrojkvUjmlwzlbiebZQJm10l17on5NQStahqpdEc3428TL0zEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631257; c=relaxed/simple;
	bh=XrksYAElZXHucG6gfLrmkQtdkMucFaxd9qeLam6HWIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sZeec9lWwp2zmpQepZfCpDv4DUxgvkoTbv32qKu/+olxjutZrSsFVPk5biPdWdRXGY9yeuaWIaNMeYflfYAJ1dUDsp78Nl+BswGimq3UCT7qV8OO01dV2/JclbQk/P6/l9YpusBL4hJBxNgXyqqEO46k8XJJPyvH2aB3WcLuNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdESapip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3A3C32786;
	Wed, 14 Aug 2024 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723631257;
	bh=XrksYAElZXHucG6gfLrmkQtdkMucFaxd9qeLam6HWIw=;
	h=From:Subject:Date:To:Cc:From;
	b=OdESapip5tOxOcbaB1IjVif4JmU8yfTV++rwLPqdJJxqvpv9iPEe9G7d4tyzu6Hnq
	 OHX1QtYb6LudZ9kD1GnaOk0H12cfUlmoUrK/sbZVZMvoBLKjUhiTxOIzEfQKsYmsrd
	 /7sVNoGXJXAzCFqDoacRfRvOYesHEke9LGir2pn5rkarZUzAkt3rFeImB9jNbxLiWI
	 pCMH5gxD8bgXeW71XY/51hJHvCuvpiPkzapSuBFDTNQRNq4myjfKLI9F366UQAZHpm
	 WJj90Nj4XrxKSGzxfCf4FMRTI2tPklG7mDZR/n3PZPJGJYVs6VhrMi2cYZz2nsHWxY
	 JawfY6bI4lfLg==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v3 0/3] OF support for Surface System Aggregator Module
Date: Wed, 14 Aug 2024 12:27:24 +0200
Message-Id: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI2GvGYC/22MwQ6CMBAFf4X0bM22BSye/A/joZRF9gCFFhsN4
 d8tnDDxOC9vZmEBPWFg12xhHiMFckMCdcqY7czwRE5NYiZB5qCh4rMbyfJgel40KFtAW6kLsPQ
 fPbb03lv3R+KOwuz8Z09Hsa3/KlFw4FDU1ohKyVLkt+lFlgZ7tq5nWyfKgyvg6MrkaqOxVqU2e
 Qu/7rquX6fgxhzgAAAA
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <quic_kdybcio@quicinc.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723631251; l=1948;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=XrksYAElZXHucG6gfLrmkQtdkMucFaxd9qeLam6HWIw=;
 b=7+x3D7LZROQvWYEmizFPY1IfZqTQOg3iEjHt+n+EtXoPlRIuVH1F7VYilc8qLhBSsnKT7oX2U
 sQnEKxX+sAuApWyla/7cx0+CNU3uA6JXPCCqQR8WuUirFgMnTIqh+ez
X-Developer-Key: i=quic_kdybcio@quicinc.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Wire up OF support for SSAM drivers, to use with Surface Laptop 7 and
other Qualcomm-based devices.

Patch 3 references compatible strings introduced in [1]

[1] https://lore.kernel.org/linux-arm-msm/20240809-topic-sl7-v1-1-2090433d8dfc@quicinc.com/T/#u

Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
---
Changes in v3:
- Drop unnecessary nullchecks
- Add MODULE_ALIAS in the platform hub driver
- Fix MODULE_DEVICE_TABLE after rename
- Prolong the '----' comment to 80 lines
- Change the current-speed bindings description to ": true", in
  preparation for krzk's serial device bindings reorganization
- Link to v2: https://lore.kernel.org/r/20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com

Changes in v2:
- Fix kerneldoc
- Drop the drivers/acpi change (oops)
- Style fixes
- Don't assign int to acpi_status
- Don't scan the bus twice in SAM core probe
- Link to v1: https://lore.kernel.org/r/20240809-topic-sam-v1-0-05bca1932614@quicinc.com

---
Konrad Dybcio (3):
      dt-bindings: serial: Allow embedded-controller as child node
      dt-bindings: platform: Add Surface System Aggregator Module
      platform/surface: Add OF support

 .../bindings/platform/microsoft,surface-sam.yaml   | 47 +++++++++++++
 .../devicetree/bindings/serial/serial.yaml         |  2 +-
 drivers/platform/surface/aggregator/bus.c          |  2 +
 drivers/platform/surface/aggregator/controller.c   | 67 ++++++++++++++----
 drivers/platform/surface/aggregator/core.c         | 82 +++++++++++++++++-----
 drivers/platform/surface/surface3_power.c          |  1 +
 drivers/platform/surface/surface_acpi_notify.c     |  1 +
 .../platform/surface/surface_aggregator_registry.c | 47 +++++++++++--
 8 files changed, 210 insertions(+), 39 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240809-topic-sam-5de2f0ec9370

Best regards,
-- 
Konrad Dybcio <quic_kdybcio@quicinc.com>


