Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A904AC7F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfFRVFw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 17:05:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbfFRVFv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2019 17:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QtAOSZpbxXOSMRds/InKAMA97jUuNyRQoI3TiAtqpG0=; b=Hxp8HlZxCL0r0RBpZtpnPfhJ07
        MA2ajCjn8jMepM0CVyv7IpS7yRLjKgj7T/Bkv2hkQ5MKV1B0KKD5x496LKATfe9tTGtpXevb68uVC
        nUfLV1KNGWiwtJzf6p6PuRNKxB5kQXsZP1K2PFQoECHXKdu8yRAx6HFzroDYVtRr/3dcQooV8wruO
        4ag+iQ5ZXOUdbVWgfHr6eqqPUK4gN6PA/86heKmhGZhEgMCVUN63RJg3s3dsC5lhbfJxVJ9JyOexJ
        KAb7gzNb1syryLjXbO+DOHbTjaze9I3sMgc9LAOMiX5VFpQ1LhBGdymgbaoPB7JJ85a3r/E/k2i9Q
        nUuJ8pog==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdLIc-0006yv-82; Tue, 18 Jun 2019 21:05:50 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdLIa-0002D9-69; Tue, 18 Jun 2019 18:05:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v1 20/22] docs: extcon: move it to acpi dir and convert it to ReST
Date:   Tue, 18 Jun 2019 18:05:44 -0300
Message-Id: <b6d199c3e7c8c868acbb313a1a516ea8aed042ee.1560891322.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The intel-int3496.txt file is a documentation for an ACPI driver.

There's no reason to keep it on a separate directory.

So, instead of keeping it on some random location, move it
to a sub-directory inside the ACPI documentation dir.

For now, keep it with .txt extension, in order to avoid
Sphinx build noise. A later patch should change it to .rst
and movin it to be together with other acpi docs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../acpi/extcon-intel-int3496.rst}                 | 14 ++++++++++----
 Documentation/firmware-guide/acpi/index.rst        |  1 +
 MAINTAINERS                                        |  6 +++---
 3 files changed, 14 insertions(+), 7 deletions(-)
 rename Documentation/{extcon/intel-int3496.txt => firmware-guide/acpi/extcon-intel-int3496.rst} (66%)

diff --git a/Documentation/extcon/intel-int3496.txt b/Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
similarity index 66%
rename from Documentation/extcon/intel-int3496.txt
rename to Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
index 8155dbc7fad3..5137ca834b54 100644
--- a/Documentation/extcon/intel-int3496.txt
+++ b/Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
@@ -1,5 +1,6 @@
+=====================================================
 Intel INT3496 ACPI device extcon driver documentation
------------------------------------------------------
+=====================================================
 
 The Intel INT3496 ACPI device extcon driver is a driver for ACPI
 devices with an acpi-id of INT3496, such as found for example on
@@ -13,15 +14,20 @@ between an USB host and an USB peripheral controller.
 The ACPI devices exposes this functionality by returning an array with up
 to 3 gpio descriptors from its ACPI _CRS (Current Resource Settings) call:
 
-Index 0: The input gpio for the id-pin, this is always present and valid
-Index 1: The output gpio for enabling Vbus output from the device to the otg
+=======  =====================================================================
+Index 0  The input gpio for the id-pin, this is always present and valid
+Index 1  The output gpio for enabling Vbus output from the device to the otg
          port, write 1 to enable the Vbus output (this gpio descriptor may
          be absent or invalid)
-Index 2: The output gpio for muxing of the data pins between the USB host and
+Index 2  The output gpio for muxing of the data pins between the USB host and
          the USB peripheral controller, write 1 to mux to the peripheral
          controller
+=======  =====================================================================
 
 There is a mapping between indices and GPIO connection IDs as follows
+
+	======= =======
 	id	index 0
 	vbus	index 1
 	mux	index 2
+	======= =======
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index ae609eec4679..90c90d42d9ad 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -24,3 +24,4 @@ ACPI Support
    acpi-lid
    lpit
    video_extension
+   extcon-intel-int3496
diff --git a/MAINTAINERS b/MAINTAINERS
index e07cbd44d48a..b7c81bd0f8e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -321,7 +321,7 @@ F:	drivers/pnp/pnpacpi/
 F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
 F:	include/acpi/
-F:	Documentation/acpi/
+F:	Documentation/firmware-guide/acpi/
 F:	Documentation/ABI/testing/sysfs-bus-acpi
 F:	Documentation/ABI/testing/configfs-acpi
 F:	drivers/pci/*acpi*
@@ -4881,7 +4881,7 @@ S:	Maintained
 F:	Documentation/
 F:	scripts/kernel-doc
 X:	Documentation/ABI/
-X:	Documentation/acpi/
+X:	Documentation/firmware-guide/acpi/
 X:	Documentation/devicetree/
 X:	Documentation/i2c/
 X:	Documentation/media/
@@ -6057,7 +6057,7 @@ S:	Maintained
 F:	drivers/extcon/
 F:	include/linux/extcon/
 F:	include/linux/extcon.h
-F:	Documentation/extcon/
+F:	Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
 F:	Documentation/devicetree/bindings/extcon/
 
 EXYNOS DP DRIVER
-- 
2.21.0

