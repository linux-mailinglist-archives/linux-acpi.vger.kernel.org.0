Return-Path: <linux-acpi+bounces-7488-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D4E94D9C3
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 03:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B384A1F224F8
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052FA62171;
	Sat, 10 Aug 2024 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/AEc//R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892959B71;
	Sat, 10 Aug 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723253339; cv=none; b=Zc2C5lXR1IvIZeOWMhXJzw2M3i/PsqbHNGAFoorwneJ/4+gco1bhGXWkGJlg28zDjvpvNjpePIxYZnzWIf6QATIBbLwFCxWiID9XNbJzq1BibS8aAY49X9OwPeMeJAZgMmmmaWyE2GtBGCzlNCmYkW1vPUNvUaEiE71cF3Tw+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723253339; c=relaxed/simple;
	bh=rA+01Z/gLFkM+gmZBJbSpxummam/O2KWdZZBGUwIzDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MRyZwhenJ6ztkRQTqcvp559drb0dv2wku0XIA5AgaM23steCRcPxCZMkZ7deNt7EBlgs/6VaooP7cX7P+ahT4iCXwFjmLTvYiNRR5WQiqMTiDZLawZ88liY3GnAxlHK0ri1wwUek4z2a4TwZZf3DJWjRlxdhxwfD6iTYI0lCJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/AEc//R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A665C32782;
	Sat, 10 Aug 2024 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723253339;
	bh=rA+01Z/gLFkM+gmZBJbSpxummam/O2KWdZZBGUwIzDo=;
	h=From:Subject:Date:To:Cc:From;
	b=S/AEc//R0IiQj9gdajGt2URd3kuCRBgJegG80maIbnf7Bk0I95AykHGyOvPYkakq5
	 H7wEhywvP0qweb+ecV6lIGcuEmjc9Jg8DHaXTt1bbdpqBVy2OUPiv/6aEj2tMlpQmt
	 f4RTu0nfJ03tiFLNDENHO/C1qmJUCajaD22rV1FSPQbSBBYg7JdVibyLYX+uJ87TzV
	 ZQS8JW2aHReGl7WTwyVSaUqjb4tdoMS+uqYTkmiSjK8h49Z0AEteJf9dItD9ZK4L38
	 ir+UVX8GS/spzrhK73LTa957ppFUdqppEHtb6fX7vcc+cunsR6QV5tidBaNE8HKZnE
	 Ih7I+syV59Qqw==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2 0/3] OF support for Surface System Aggregator Module
Date: Sat, 10 Aug 2024 03:28:37 +0200
Message-Id: <20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXCtmYC/23MQQ6CMBCF4auQWVszLaDiynsYFnUYZBZQaLHRk
 N7dytrl//LybRDYCwe4Fht4jhLETTnMoQAa7PRkJV1uMGgqvGCjVjcLqWBHVXdsemRqyjNC/s+
 ee3nv1r3NPUhYnf/sdNS/9Z8StUKF9YOsbkpz0tVteQnJREdyI7QppS9fBI3KpAAAAA==
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
 Konrad Dybcio <quic_kdybcio@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723253333; l=1552;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=rA+01Z/gLFkM+gmZBJbSpxummam/O2KWdZZBGUwIzDo=;
 b=bbxPQPQxEc1SzVvbdKB8s3Eji8+geAwKHbptIaeMd2fw1gWk5Z2bfdrpFM+WXlKzO60dCv89n
 0YcjUG71acKB3dLaicCYBiN+fOGbAJ170tcb0XjBYawzdNYFlVLqOfe
X-Developer-Key: i=quic_kdybcio@quicinc.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Wire up OF support for SSAM drivers, to use with Surface Laptop 7 and
other Qualcomm-based devices.

Patch 3 references compatible strings introduced in [1]

[1] https://lore.kernel.org/linux-arm-msm/20240809-topic-sl7-v1-1-2090433d8dfc@quicinc.com/T/#u

Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
---
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

 .../bindings/platform/microsoft,surface-sam.yaml   | 50 +++++++++++++
 .../devicetree/bindings/serial/serial.yaml         |  2 +-
 drivers/platform/surface/aggregator/bus.c          |  2 +
 drivers/platform/surface/aggregator/controller.c   | 67 ++++++++++++++----
 drivers/platform/surface/aggregator/core.c         | 82 +++++++++++++++++-----
 drivers/platform/surface/surface3_power.c          |  4 +-
 drivers/platform/surface/surface_acpi_notify.c     |  4 +-
 .../platform/surface/surface_aggregator_registry.c | 44 ++++++++++--
 8 files changed, 215 insertions(+), 40 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240809-topic-sam-5de2f0ec9370

Best regards,
-- 
Konrad Dybcio <quic_kdybcio@quicinc.com>


