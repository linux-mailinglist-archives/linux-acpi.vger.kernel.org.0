Return-Path: <linux-acpi+bounces-3810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D2E85ECFA
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 00:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AF72841D4
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726DF12E1EB;
	Wed, 21 Feb 2024 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtDxyuo1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAACB12AAF9
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558257; cv=none; b=V5JWxE4AI5Gi4WYPetgNyzsEkRZuUGBdDBOTa/ow54uTwqqWe9FWGZ7snUUEAZCQI1G9qcCcLbppZXVOjrqZKTa4ldUiTXDDKucn9FWncusMMnyjN2qvEWvQ/0FUIkluSn8+o1UtTJT8c0iDLL92DecdWuRocKxnCUsPropcGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558257; c=relaxed/simple;
	bh=jUX4qJT8DPbrff7AecTpaNd/U/+p/bjh3Aq7WNnY2rU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=fwy/5bRdgwHeu16HLkEKcQZdMpRaIpZ0bTSH6P3nYJycKTxzwAKjqqqtdADeHZEVRuNsdnfP/3jT2eWpNL3Mc6CHCtMYVL3rrC5/fk03WSrfIzgnofEhEKnwa19tPbgmxWJgaW1jUebv5TEaypVRIrbJtVEnjfkVSYyHpuub1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtDxyuo1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e8e8c2f1so119256247b3.3
        for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 15:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708558243; x=1709163043; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vosJNO3Zn4Xnibp+U/swV64D06bjeRMU8MziMRFin+Y=;
        b=AtDxyuo1yLNiljUl4l7lFhtdq1a4LD6pL8rdED9ZbyyobDdwGwLG2pRmv7ikpgc/HX
         T4ZowgFnTJCPzdfv0dqk1qelcW/775LRrhGjZiEyIMOg9R7gX8KtoaDZ1MIKIHqWS+vw
         h4wxB4eNA0aK+EOUgwVBrbo9/xY1mMWqdPo1Y5tmizVb5/wmwSqOa/J9XIGyvdGuSfZE
         5FmF+L5YCHD5/JyZu4IL6+PPmXFuZMHXqLEyO9fndxYmyPhPA0K/6Jk1tlZ76D1LU/zW
         btJasIXE31gmgkymUAeXTK8qQXQhUVsUfImoxNKQl7UeT3L6OGb7lJ2Up0lkBRkj9BtO
         1LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558243; x=1709163043;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vosJNO3Zn4Xnibp+U/swV64D06bjeRMU8MziMRFin+Y=;
        b=q5qw0QzR5eMqd4kFy49jblKhsIpRfZH8hfyga3f/Vv4EbjUbOxomPyGwg1ns+Xbn/W
         hJ7EI8s0NZuM8ZR8zRiv0t6NTo0ilX9k9MppiF5Bm0vVOC40sdj1cmnhdP4m9Dv87Zll
         mi8s3DNzG9H2ZLft0cVO0zQMhJunfVqEjOyKWwANV1K8e7+z0qVCMAOwIbOCzJgUcSa0
         iSo3ayqojnWJ/OYQ/C4n9CHjJdRWWlK8hZ+3xXQM+ek3ml1U1cU9tF8dA5ZJ7eM8a8qL
         V7k4aGV02LaZwMQShzFcXyA4oT+KufPYUWQ/ercaaI2i+vIDgvjJQ7YkHwhAGr9P7mJo
         pEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpqFX3LsKSD+7NqKItQaEBgSN29N6c0+TbHwXGXCP+bKYnlEvYR93AtC62A0LIIfAWptR/h8cPFiBkTGaajVUqmJsEKHd8yHXmaA==
X-Gm-Message-State: AOJu0YyaDn9CTns97SlZBikp37pPGEHjuxIZ5GukQsdrunZJ3bql6BPn
	vpmpmCAKf5MHg3sRQf7vGa3d5ltjV1179PINq+SKK7/hlRHBFoGWtABczejzFGJf8d9UZeMN9xW
	DTeUnLxx2iVbfmg==
X-Google-Smtp-Source: AGHT+IGL2ZYbxV2XYZv11Spt/CZwrBjB4bou5Zs7lK/79XKoUNdBwEDMEovLjXi3KFWQWuESaBODFPai4yCFY2o=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:4e1e:336a:2b30:13fe])
 (user=saravanak job=sendgmr) by 2002:a81:df03:0:b0:608:8f74:bbfb with SMTP id
 c3-20020a81df03000000b006088f74bbfbmr350946ywn.9.1708558242802; Wed, 21 Feb
 2024 15:30:42 -0800 (PST)
Date: Wed, 21 Feb 2024 15:30:23 -0800
In-Reply-To: <20240221233026.2915061-1-saravanak@google.com>
Message-Id: <20240221233026.2915061-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221233026.2915061-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v3 3/4] dt-bindings: Add post-init-providers property
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The post-init-providers property can be used to break a dependency cycle by
marking some provider(s) as a post device initialization provider(s). This
allows an OS to do a better job at ordering initialization and
suspend/resume of the devices in a dependency cycle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../bindings/post-init-providers.yaml         | 105 ++++++++++++++++++
 MAINTAINERS                                   |  13 ++-
 2 files changed, 112 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/post-init-providers.yaml

diff --git a/Documentation/devicetree/bindings/post-init-providers.yaml b/Documentation/devicetree/bindings/post-init-providers.yaml
new file mode 100644
index 000000000000..92eb9a027443
--- /dev/null
+++ b/Documentation/devicetree/bindings/post-init-providers.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020, Google LLC. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/post-init-providers.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Post device initialization providers
+
+maintainers:
+  - Saravana Kannan <saravanak@google.com>
+
+description: |
+  This property is used to indicate that the device(s) pointed to by the
+  property are not needed for the initialization of the device that lists this
+  property. This property does not make a device (that's previously not a
+  provider) into a provider. It simply downgrades an existing provider to a
+  post device initialization provider.
+
+  A device can list its providers in devicetree using one or more of the
+  standard devicetree bindings. By default, it is assumed that the provider
+  device can be initialized before the consumer device is initialized.
+
+  However, that assumption cannot be made when there are cyclic dependencies
+  between devices. Since each device is a provider (directly or indirectly) of
+  the others in the cycle, there is no guaranteed safe order for initializing
+  the devices in a cycle. We can try to initialize them in an arbitrary order
+  and eventually successfully initialize all of them, but that doesn't always
+  work well.
+
+  For example, say,
+  * The device tree has the following cyclic dependency X -> Y -> Z -> X (where
+    -> denotes "depends on").
+  * But X is not needed to fully initialize Z (X might be needed only when a
+    specific functionality is requested post initialization).
+
+  If all the other -> are mandatory initialization dependencies, then trying to
+  initialize the devices in a loop (or arbitrarily) will always eventually end
+  up with the devices being initialized in the order Z, Y and X.
+
+  However, if Y is an optional provider for X (where X provides limited
+  functionality when Y is not initialized and providing its services), then
+  trying to initialize the devices in a loop (or arbitrarily) could end up with
+  the devices being initialized in the following order:
+
+  * Z, Y and X - All devices provide full functionality
+  * Z, X and Y - X provides partial functionality
+  * X, Z and Y - X provides partial functionality
+
+  However, we always want to initialize the devices in the order Z, Y and X
+  since that provides the full functionality without interruptions.
+
+  One alternate option that might be suggested is to have the driver for X
+  notice that Y became available at a later point and adjust the functionality
+  it provides. However, other userspace applications could have started using X
+  with the limited functionality before Y was available and it might not be
+  possible to transparently transition X or the users of X to full
+  functionality while X is in use.
+
+  Similarly, when it comes to suspend (resume) ordering, it's unclear which
+  device in a dependency cycle needs to be suspended/resumed first and trying
+  arbitrary orders can result in system crashes or instability.
+
+  Explicitly calling out which link in a cycle needs to be broken when
+  determining the order, simplifies things a lot, improves efficiency, makes
+  the behavior more deterministic and maximizes the functionality that can be
+  provided without interruption.
+
+  This property is used to provide this additional information between devices
+  in a cycle by telling which provider(s) is not needed for initializing the
+  device that lists this property.
+
+  In the example above, Z would list X as a post-init-providers and the
+  initialization dependency would become X -> Y -> Z -/-> X. So the best order
+  to initialize them becomes clear: Z, Y and then X.
+
+select: true
+
+properties:
+  post-init-providers:
+    # One or more providers can be marked as post initialization provider
+    description:
+      List of phandles to providers that are not needed for initializing or
+      resuming this device.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      maxItems: 1
+
+additionalProperties: true
+
+examples:
+  - |
+    gcc: clock-controller@1000 {
+        compatible = "vendor,soc4-gcc", "vendor,soc1-gcc";
+        reg = <0x1000 0x80>;
+        clocks = <&dispcc 0x1>;
+        #clock-cells = <1>;
+        post-init-providers = <&dispcc>;
+    };
+    dispcc: clock-controller@2000 {
+        compatible = "vendor,soc4-dispcc", "vendor,soc1-dispcc";
+        reg = <0x2000 0x80>;
+        clocks = <&gcc 0xdd>;
+        #clock-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..5c97a0b5e9c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6060,12 +6060,6 @@ S:	Maintained
 F:	drivers/base/devcoredump.c
 F:	include/linux/devcoredump.h
 
-DEVICE DEPENDENCY HELPER SCRIPT
-M:	Saravana Kannan <saravanak@google.com>
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-F:	scripts/dev-needs.sh
-
 DEVICE DIRECT ACCESS (DAX)
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
@@ -8300,6 +8294,13 @@ F:	include/linux/firewire.h
 F:	include/uapi/linux/firewire*.h
 F:	tools/firewire/
 
+FIRMWARE DEVICE LINK (fw_devlink)
+M:	Saravana Kannan <saravanak@google.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/post-init-supplier.yaml
+F:	scripts/dev-needs.sh
+
 FIRMWARE FRAMEWORK FOR ARMV8-A
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.44.0.rc0.258.g7320e95886-goog


