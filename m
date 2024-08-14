Return-Path: <linux-acpi+bounces-7565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF579518B2
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 12:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17D828430A
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B6B1AE041;
	Wed, 14 Aug 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht5HaaGt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141A1AE035;
	Wed, 14 Aug 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631262; cv=none; b=A32eK1X6FqOVnqfnrtUAcE7TLgKfaxn7HnX9YMg/y6zwNgCzyWiO+MBk8bgxZcadKfk1N06ZNM5cZlH8QkdzvkeU3wTASLTWKKS3i5qnRRjIZOP1QH2RXlCHPKH97kSAI5epeknjFQzI6dXgbo5in1p0mlYnUP3HoajfrTalC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631262; c=relaxed/simple;
	bh=bccfXKNQg4zXJu1vTYibUPZ1egmOE0fcVgH0I9p1RQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTTggu00Goc8I+E4GBg1rFs/sHZI1FE0CkRD0Fzui3IOMw8fwa4zU0ATiEjE6BpR/QktU8ZogWD444qQQ14luYZWcKJBA9OXCdrjC+4NRvWHbD5hC4yHyMPVcI6Am02K9JpECoLL5IxKEtAxOM3jWCJP0e0DrBhcCXBCIs/bcbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht5HaaGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AB3C4AF0F;
	Wed, 14 Aug 2024 10:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723631262;
	bh=bccfXKNQg4zXJu1vTYibUPZ1egmOE0fcVgH0I9p1RQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ht5HaaGtFvdLXjItrGNiK2UNWkxTowH20tw4PYjVwDP2YWRfDDLBhuTvpfHeQm++h
	 0zxeScNhxz+uj9fhdNJQ0kVkioscBLQHWN1BLecJ+Dw+EtXqeS2Gr0xHxhMtum4ZL9
	 q9MPjHRWmwUV0ahmH6yxvK4tDtddsCl0OrnNnSyezfVtmPi3NqlsW13SISR82gYQYY
	 68B/28rasUyFmjj/vIT9VSOAKNsLPVvwh2RShvBUMJEp93ibcBoWJSE7fVL1w/EMRP
	 khRXuP21AtBJs6JvDFwy1/dcfPXUCPJTRT/FB3un/+cd2zF9ar4nfC8GqZHMcQTq9S
	 dZUnuO8+4JqCA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Aug 2024 12:27:25 +0200
Subject: [PATCH v3 1/3] dt-bindings: serial: Allow embedded-controller as
 child node
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-topic-sam-v3-1-a84588aad233@quicinc.com>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
In-Reply-To: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723631251; l=1059;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=AEK+ZmsmJizLVE9FBJTu8k1auOuumDvPus5JrcIw9W8=;
 b=os/J7mgXgi06d/WzJo+6BaZEm+K5FVZQIikmkJ39IYSJ3AbESMA5cJ/i7QRA4twnRREtx08sC
 JA3RDg9PUPsC5jBBeGA847zxNvKoTIHV1KqXd8++gxce7W1r6tKjmWQ
X-Developer-Key: i=quic_kdybcio@quicinc.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <quic_kdybcio@quicinc.com>

There exist some embedded controllers (like Microsoft SAM found on
Surface devices or Apple Oscar found on old iPhones) that connect to
the host device via serial.

Allow that class of devices to exist under serial interface controller
nodes.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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


