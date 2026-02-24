Return-Path: <linux-acpi+bounces-21104-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBeFLck3nWlINQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21104-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:31:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD13B181F7D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F4830F05D2
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 05:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459F2BE63F;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpRhNN6w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81528B4FA;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911053; cv=none; b=nJsW8AEOxxPpIJ6S2If29c1oyPg2rxJnwOp4XwXcsSSatGqHZZNgrCwEE3ysJm+IEp8wPkDYD4qBfeXUJAqcQ9wpz8laGmFY/7OyN1igrTvGTJSBxC6PCSo6l2z1n+G0JKATGoMeekow0mEpTTQQpesY3xi+xZ6aY3aOv57p0Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911053; c=relaxed/simple;
	bh=HpGVKc0NY5imy2HoLh3gTZqlP+PKdsOsRjHmaFdWlwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTvwiC+ozGK6bGuHZCe+A8rivjd7YE0NL2UP9HY5qWaRQb6B2BU+SXYt2ZHL96ps4FfCVDz4exhk9Vw7xGZM31Ac7hbM5sfS/y51+f/EBG/iiVjE2G2HMJYPkufccndjQGP4XK7wh65mqc55DDqMqwUi2xYqXr3qhsSqPLH2qU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpRhNN6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC3B9C19424;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771911052;
	bh=HpGVKc0NY5imy2HoLh3gTZqlP+PKdsOsRjHmaFdWlwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WpRhNN6wmYYtMagYhYig5HGWe/MTOnHSg8Fq7vjHTzFBKj1UufsSHZBlMfj+MW7uB
	 vYgaXwaXCYHr3TcsF1PEGwA34D+PF4d9azi4TPQwyyAC3c1w67pyRllmsbRKrHbIYP
	 i1hoOiF0bAA6+OsmPmwSdYpNyG3yLByH7fcVS7Ny8N1z2Bzn+Rc3KhlqofWDJIPLDV
	 Z4Vlws5oMMeMLX+O/0rv0adRYrdQfUaOrnzpHKstlg6OFU2IUaimLEx8R1+mZTG3wt
	 9ygX1yJk7FfUIFk5MRoql4vriBLfqnCv+m0Kh4JvuckNcjDhB9rW2/+Ba8cHWT2ksV
	 8yW1XsuwbTaVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF03DEFB7F9;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 24 Feb 2026 11:00:50 +0530
Subject: [PATCH v5 4/9] dt-bindings: serial: Document the graph port
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-pci-m2-e-v5-4-dd9b9501d33c@oss.qualcomm.com>
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
In-Reply-To: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=GL3e+NsnxRKZAnbhCXHzDHMKMZEirA8W+47KdhQACxY=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsica96h277e1mjKV56q0/LmB3awLD5x31z57eMMbc09s
 +cJXKgp7GQ0ZmFg5GKQFVNkSV/qrNXocfrGkgj16TCDWJlApjBwcQrARO5pcTA0eZTuv7x4Q2bn
 uqCt8enKuUzNLMv5LoWutl67SpRndqlnBrvSg7qeLvN+eQ6Vh+8+fNu+hyF/lpPATPUyluu+ZzV
 deabMr3vRf/Ful1XgnoYH936r7N6js910QZeVgFyGXVi3k2NYPu/35qLQkIcv5dR8FJXv/1aUNW
 BLeO9uImTs5BIdlDqt5buX7uEwLaE1uzhLJzyuDH4npOhxulcl9Zq9VP+NDHVT2cIJpSEdzUHTC
 g+LsduJmzK56xxNEZxfdoilPP5jesIGRvuvMcr7U6c/VFf+pPFz0ZGdxw5rbXfOZN91zv+2Y+ih
 I58qmg+6Cdic/5k8jVfP8YJWxtrsuR5qcz1/KjFLyP4AAA==
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21104-lists,linux-acpi=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-acpi@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: AD13B181F7D
X-Rspamd-Action: no action

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

A serial controller could be connected to an external connector like PCIe
M.2 for controlling the serial interface of the card. Hence, document the
OF graph port.

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 6aa9cfae417b..96eb1de8771e 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -87,6 +87,9 @@ properties:
     description:
       TX FIFO threshold configuration (in bytes).
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
 patternProperties:
   "^(bluetooth|bluetooth-gnss|embedded-controller|gnss|gps|mcu|onewire)$":
     if:

-- 
2.51.0



