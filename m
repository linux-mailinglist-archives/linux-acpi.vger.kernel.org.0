Return-Path: <linux-acpi+bounces-7489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D543F94D9CB
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 03:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD0C1F22DB9
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 01:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759B913211F;
	Sat, 10 Aug 2024 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbcuNSF2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6324087C;
	Sat, 10 Aug 2024 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723253346; cv=none; b=H7MRe99RoRtOnCQMMkP0x/SYU3O4R0jSAoWfZarjIPQppkt1E0USI+YeS9MiBdjROeNjTBvBRnPY+dBP6X/3NkcOPEVMVRDIGY3RudtVaCWTNFtQnq+5b6bLTRKbV/ZCi8qMKtqrg4vHujCHe7OhHbLp1A2xCndNmGsHWhgQMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723253346; c=relaxed/simple;
	bh=4SyE3li13fjLPwavf6bHMoEU85A4KFBeN5v2ikNfOS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2XFjo+2HJY0tk/yMjJNIGmPftEHRL52KqCHpyNXXVWWN91ezcrT58A/EvrUv/P8tSlwD5Hy8i6BmL1IWuzFlMaN7ELa2x8mE1hA2/Ye9CWlZrX96ca74wCy/i0gVdNJxo7BgBPVpXQ5a/NS8mlvZFg0ImOkePRkG1meej9hze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbcuNSF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE224C4AF09;
	Sat, 10 Aug 2024 01:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723253345;
	bh=4SyE3li13fjLPwavf6bHMoEU85A4KFBeN5v2ikNfOS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NbcuNSF2DYNYYRKJG94vXh75HLxGijtUjeQPLc0td6ayqya1vCCOr8n1hFkZXBdn4
	 FXSIluZ8fkoW+UiBqzx3HcKnXwHRU2YmCAgoA7ZbIVM6z8XPWg2mmz6FhNQWdmL/go
	 2omjwGmk0FwrWm+CYvMpq6UtWQbgqSUbVHDv+B5G5YOtgn7U53gFSCghJMD4/NDkNu
	 wD4HTMRW1AENQ2Uj4oNnnKWgUjYWi8h2FLNhESLM6QZkDe3kiL+Jx8wOnLibOEJqlg
	 mJh/k6RUdLjmheaUA6DrJ1ELhdprAMJJ100ooAUOTp02h0/lVdUmFcF62sKAHiMI3U
	 y8QRkBrQ9gsdw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Sat, 10 Aug 2024 03:28:38 +0200
Subject: [PATCH v2 1/3] dt-bindings: serial: Allow embedded-controller as
 child node
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240810-topic-sam-v2-1-8a8eb368a4f0@quicinc.com>
References: <20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com>
In-Reply-To: <20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723253333; l=1007;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=iPyhH97sgWQSvAYoTnYt3DadKCYesRP4ToQqaY07uPk=;
 b=9lKKuIOOp7WYVX3w6+26X30PFGf1TkRIosBETn9SmIYEgw1Lf0wYmj/9Egt8VM5VfBFwzmpaz
 IEb2KalqmRgAeidDtPBDG+oIxXR5NWUbrADH0a/TVCFwbjJgNe7FUGq
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


