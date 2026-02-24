Return-Path: <linux-acpi+bounces-21106-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJDkN+M3nWn5NQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21106-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:32:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83126182006
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 852673121EF1
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 05:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D876A2D6E70;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWpAg1qj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418052BCF45;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911053; cv=none; b=ialfuhZiIdemZP+pOxY9ZufUhQvbDsK2Z4aZO5iF1ZnWbYc+UvFzKWdkMywtniLZmh3MoaYkMIzVs33BUVeMuIJ9g6/8GTUvKNEXSHQcwuceqHw8Z65aYiYOOIRe/D8dCqCHyIiZ5ti2WaqdwuNb2VnLxSRqwVRHsPcBYPDBJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911053; c=relaxed/simple;
	bh=WhTZq+K6TuaX44CN0DoROJYudpXusVMVY0rd0r/mYcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=opyhFmq7J3chUnWboTJtzYX4zaGsGst8jkPT4oKelSiasDSNtLKaZnpOUjXvzA3rZ8L7gsw4jAj9KBQnLh3znlKfIDmzaC5iiTNUQqnD8wV8dePe5sd/pxE9AvTLqFwxuutdahJDYgGIN9Bw89H/HQsIdBEgbL9dCFzeuem21Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWpAg1qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04C17C116D0;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771911053;
	bh=WhTZq+K6TuaX44CN0DoROJYudpXusVMVY0rd0r/mYcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DWpAg1qjDmrDOOEZM0eDhhY1yAd1KTskPcNFpivpgkLK+JvMF78tNnkJfrTnPqXKA
	 FIAsB1yh/hn3ei+uh7bVF2nSlvfgX/UbTQV3kY8qShtftCL5NwpMkAfV1eGHdJPKdl
	 9CfgBRAwcroZ88gaHEg3r/uENu8DSL9rnzyML4YOZvOh2GshcS/4HlxzkU2y40cwYi
	 DkADAmGHp4P51tphxF7MQJGKyBgmo4DImVUvrhlIh15RyM7ifm7eKys9vkWf221fSU
	 8YTNDnS4JnEVUYGUpq8Ubmb76Agvw60pd8ItfC8yJtNL/PAJmFFLAtHHbddFcwGgVK
	 2Es2+QHPNo9Bw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDB7EFB801;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 24 Feb 2026 11:00:52 +0530
Subject: [PATCH v5 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-pci-m2-e-v5-6-dd9b9501d33c@oss.qualcomm.com>
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
 Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=M1p28ZrNyChHwQecpcVA6dKuJdcr6xMtVXucrfIuJ+o=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsica94xK55/R88r6fObC/8sc8mdt1FS+pBygkxIfctJu
 +1uTtysnYzGLAyMXAyyYoos6UudtRo9Tt9YEqE+HWYQKxPIFAYuTgGYyE8FDoaetCPW+zguiUfa
 z2pT28w+LXa7ePR8NZM/DXfFkg+bPDfusrHmc+SymO+67WuA6c9d7ZlHwnmUJJwXPeOLm707sYi
 p3eOQ8+4eVXO9D+vF3y6bf/3xxPrFk1c1mBiYx9dH3lNmfvuyZp2ln3T9rOfb5nZ7eu0/UfF704
 H0v54/DWRsPnokFt0JeaHh4rPX/C+jpuzfj/8mzix438/CH5Xt8eiEoKXX7gI+bo0mmzBRnhsG5
 2c979Bi/j5H06E+q+JiJMPlnjYOhruu01pNnrItUw6NfdZjVBCivrv9W1P2RCG3ktvv9317K86g
 WjUrdELbspvrS1exp54vVO9ijN65dWFtXGx5UabC5KzpAA==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21106-lists,linux-acpi=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-acpi@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:replyto,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83126182006
X-Rspamd-Action: no action

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
spec, it looks very similar to the M.2 Key E connector. So add the
"pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
to reuse the Key E binding.

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml       | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index 82dfd776d480..48fe80846cb4 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,14 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - items:
+          - enum:
+              - pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.51.0



