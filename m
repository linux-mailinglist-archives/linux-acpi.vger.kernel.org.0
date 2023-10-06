Return-Path: <linux-acpi+bounces-462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7187BBA58
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B80282262
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD4726E01
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1zaLxvx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335241D690;
	Fri,  6 Oct 2023 12:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA64C433CC;
	Fri,  6 Oct 2023 12:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696597180;
	bh=iOWyeF/KRwGpiqZfKpX3chHM50vO4O6sz4uB89KKvbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1zaLxvxNrq/JKivnpB19VtMWfwwpgXr53MZ4plq4TD5Lv6tqCzOQzjEtI4kwUqq9
	 fW9g2+YNXBj8Tty4Pki+pG/9Jr8ruf+WVYddCHdV/Hifx/TM9Cii+EpmmhEDz7rJZx
	 LYzmf6m0uPyOYlNJKDDO1E/NCl+NVWMDWaovub0H+a0q34H6WFgiF8EM5VABHOiZVy
	 gM6FYvgiS3HA/9XVKi8XNo8w0ePseSOejkcZyPPFC+uu1LCPfzMVPjtLhOZIxx38SP
	 tVysBsxR2fxYfEtuv6Bvr5+kB27ShcKNgWyghtZM8zMHgXGh3rDNtTJE6ytlKLa1tM
	 T9CikPZ4LOCIQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent property
Date: Fri,  6 Oct 2023 14:59:25 +0200
Message-Id: <20231006125929.48591-2-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006125929.48591-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GIC v3 specifications allow redistributors and ITSes interconnect
ports used to access memory to be wired up in a way that makes the
respective initiators/memory observers non-coherent.

Add the standard dma-noncoherent property to the GICv3 bindings to
allow firmware to describe the redistributors/ITSes components and
interconnect ports behaviour in system designs where the redistributors
and ITSes are not coherent with the CPU.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/arm,gic-v3.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 2bc38479a41e..0f4a062c9d6f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -106,6 +106,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 4096
 
+  dma-noncoherent:
+    description:
+      Present if the GIC redistributors permit programming shareability
+      and cacheability attributes but are connected to a non-coherent
+      downstream interconnect.
+
   msi-controller:
     description:
       Only present if the Message Based Interrupt functionality is
@@ -193,6 +199,12 @@ patternProperties:
       compatible:
         const: arm,gic-v3-its
 
+      dma-noncoherent:
+        description:
+          Present if the GIC ITS permits programming shareability and
+          cacheability attributes but is connected to a non-coherent
+          downstream interconnect.
+
       msi-controller: true
 
       "#msi-cells":
-- 
2.34.1


