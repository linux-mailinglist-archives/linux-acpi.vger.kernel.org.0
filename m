Return-Path: <linux-acpi+bounces-7451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C894C82E
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 03:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E0C288F02
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF38F66;
	Fri,  9 Aug 2024 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AseslaAJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648212E4D;
	Fri,  9 Aug 2024 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168117; cv=none; b=KzryrT8bybqVftnYjLMub2Ivi42R32x0/V5UnsQ4e2QSFqU13wND7mmIqOoYCBWfjo+AHqWg/n4QI0YGiefZnT+C1yYIfAvOnYu5+bMIf93M1QMer9r9issh96bGPEuy9OjdosSy0nla1P4F1hnIWOqSw5vSq+4lcQ2kP8LEZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168117; c=relaxed/simple;
	bh=PiR+RGT8+T5sbZULWQstEIGiMhDXq6bLUvLaeTPOXMM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EZAwt+lyUibMy3Ilpi+4uR1ra1Y2WxXOhkmvbpKZ3DDXmbWxVrwFMY4XsJG6Wct+NoN1OeW4FkUPy+ICxJindF19NwOmppyD+v7aMxzPpbKzs+z2qNA/bWLkhNnFsXbsMENm2vIXn+Nz2pCCURoHhK1gqvktkoNlnvsP+jENf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AseslaAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384ABC32782;
	Fri,  9 Aug 2024 01:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723168116;
	bh=PiR+RGT8+T5sbZULWQstEIGiMhDXq6bLUvLaeTPOXMM=;
	h=From:Subject:Date:To:Cc:From;
	b=AseslaAJL/0UvZIlkcu8gjUzK2T2iMyDpMM16CJSJTLXfEHh14FHiXDiV2zcldUlz
	 LGnudfkhqM7crkAGnSEG97XhUD5Z7Jkzr/6xbehIESOh7dYJwtBdMLF1hJT394ho86
	 5i9/relWJ1Hz45Ik+cno09kk/jNiR7ZYgwqZW1OJQIQblhd6saXCpPki8MGpp6C3U0
	 F0rh7x+6zcY1+kDH47OCzx9IlEHBuxOXpkQTxRyqOKwIbC4rtoztc6A4ofXVWdfGSf
	 1ELUZthUE/SBL1c6mKrHdiYzcgngAzcJ++vjbmV/U8zCaXguuV59y/vHmKuX7F9NdR
	 g1GKOrkWveRBA==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/3] OF support for Surface System Aggregator Module
Date: Fri, 09 Aug 2024 03:48:27 +0200
Message-Id: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGt1tWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNL3ZL8gsxk3eLEXF3TlFSjNIPUZEtjcwMloPqCotS0zAqwWdGxtbU
 AoYdHBlsAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723168110; l=1228;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=PiR+RGT8+T5sbZULWQstEIGiMhDXq6bLUvLaeTPOXMM=;
 b=VF1H9/H6BQh6L+UE5ix2Pgu/7p66FOcS/+04Kk4ILuPcH0WDQzojNBM8oZzrmM0LCXXVz2jMF
 Bra4x7gB6cSAn8Ea4/P5/m58wbFLc07MCqnMKSYtns0sTay2XHfBUKj
X-Developer-Key: i=quic_kdybcio@quicinc.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Wire up OF support for SSAM drivers, to use with Surface Laptop 7 and
other Qualcomm-based devices.

Patch 3 references compatible strings introduced in [1]

[1] https://lore.kernel.org/linux-arm-msm/20240809-topic-sl7-v1-1-2090433d8dfc@quicinc.com/T/#u

Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
---
Konrad Dybcio (3):
      dt-bindings: serial: Allow embedded-controller as child node
      dt-bindings: platform: Add Surface System Aggregator Module
      platform/surface: Add OF support

 .../bindings/platform/microsoft,surface-sam.yaml   | 50 ++++++++++++++
 .../devicetree/bindings/serial/serial.yaml         |  2 +-
 drivers/acpi/scan.c                                |  3 +-
 drivers/platform/surface/aggregator/bus.c          |  2 +
 drivers/platform/surface/aggregator/controller.c   | 72 +++++++++++++++----
 drivers/platform/surface/aggregator/core.c         | 80 ++++++++++++++++++----
 .../platform/surface/surface_aggregator_registry.c | 44 ++++++++++--
 7 files changed, 218 insertions(+), 35 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240809-topic-sam-5de2f0ec9370

Best regards,
-- 
Konrad Dybcio <quic_kdybcio@quicinc.com>


