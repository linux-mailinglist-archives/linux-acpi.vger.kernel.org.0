Return-Path: <linux-acpi+bounces-7452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2494C833
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 03:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517B01C20FBE
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B698E11CAF;
	Fri,  9 Aug 2024 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhiY+hPJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7901642B;
	Fri,  9 Aug 2024 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168122; cv=none; b=SO0e4q3qxNcya+hFXwSvG7rGjMTHl4XJLD8cY18yRKXleclucf1wUGjPnK05bNJ7DEwKZzijlyeAAX7VA+Fy2OwAD9dH1dHpR3yXiVCJT7ObAlPydjMYOmmeWp3sYhiN8LCswbO+oMKUZu2zmdSi0Kpjuzm1GLVMBur2cCNpjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168122; c=relaxed/simple;
	bh=4SyE3li13fjLPwavf6bHMoEU85A4KFBeN5v2ikNfOS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0CfDYHDG9I3PyUECjS4I8e59uRECso0TzHVfDDLmzdxdg48VEmwvdsyTjotGi7+9+62cLsonHnCs0grSKlmZ6naiW40u7s7hkYMMKTFK08KG2WVXIXO+cdO5ZyRDKiEd1DKcdEEwevlWFqBwF4NNtyCwm2354RC/OuWOKQfRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhiY+hPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE4AC4AF0D;
	Fri,  9 Aug 2024 01:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723168122;
	bh=4SyE3li13fjLPwavf6bHMoEU85A4KFBeN5v2ikNfOS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mhiY+hPJvfxc4u84quNiuABXsF2zjZ97BVClWjnBUw8fT9Cfkz9KhlsCQ5AJr/kCu
	 Kp6SU8mBm8eOz431gsiNU1dlOeb7pK+EVvaOcjtiddNSdcnxLyGeRIMo+vQgVLF5K7
	 BcxIidDGLPfdNzLidDgZf2r02EZI4ZTtzT5AoVpQ/6m8lOQ66nbC7260iDaBW32tlr
	 5ldqbPIQWFG24R7QOdi12aX6+CSydxVkTs/g9FVq5ixUBbdUhbqkdYhL3jY0nA71oZ
	 SBLsEbWG5w4oelEcBlZv49f9FmW/Ak6tvX8A6n6GK7mpLK+7wB9NDW7fC8G0Cczs8c
	 6cNc84NJZlsyA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 09 Aug 2024 03:48:28 +0200
Subject: [PATCH 1/3] dt-bindings: serial: Allow embedded-controller as
 child node
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-topic-sam-v1-1-05bca1932614@quicinc.com>
References: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
In-Reply-To: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723168110; l=1007;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=iPyhH97sgWQSvAYoTnYt3DadKCYesRP4ToQqaY07uPk=;
 b=3EcseN/6IzFVElwY5bHIMl3uP7B9u9h0nYnqNlo7tesrzlHG3C7MeSAeSd3YiEN5ELXoBU++4
 XOs+60oQLrwCtpGYbXzJyUQZx1ID9zIsLTq5wycALkoKxnSuKG+OiQy
X-Developer-Key: i=quic_kdybcio@quicinc.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <quic_kdybcio@quicinc.com>

There exist some embedded controllers (like Microsoft SAM found on
Surface devices or Apple Oscar found on old iPhones) that connect to
the host device via serial.

Allow that class of devices to exist under serial interface controller
nodes.

Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index ffc9198ae214..9b2c94796371 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -88,7 +88,7 @@ properties:
       TX FIFO threshold configuration (in bytes).
 
 patternProperties:
-  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu|onewire)$":
+  "^(bluetooth|bluetooth-gnss|embedded-controller|gnss|gps|mcu|onewire)$":
     if:
       type: object
     then:

-- 
2.46.0


