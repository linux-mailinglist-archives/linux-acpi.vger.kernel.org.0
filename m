Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A88D410
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfHNNBr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 09:01:47 -0400
Received: from retiisi.org.uk ([95.216.213.190]:37348 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbfHNNBr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Aug 2019 09:01:47 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1002])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 7F4C2634C88
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 16:01:33 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Subject: [PATCH 1/1] Documentation: ACPI: DSD: Convert LED documentation to ReST
Date:   Wed, 14 Aug 2019 15:58:58 +0300
Message-Id: <20190814125858.30969-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Convert the LED documentation in text format into ReST.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../acpi/dsd/leds.rst}                        | 20 +++++++++++++++----
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)
 rename Documentation/{acpi/dsd/leds.txt => firmware-guide/acpi/dsd/leds.rst} (90%)

diff --git a/Documentation/acpi/dsd/leds.txt b/Documentation/firmware-guide/acpi/dsd/leds.rst
similarity index 90%
rename from Documentation/acpi/dsd/leds.txt
rename to Documentation/firmware-guide/acpi/dsd/leds.rst
index cc58b1a574c5..946efe2b2936 100644
--- a/Documentation/acpi/dsd/leds.txt
+++ b/Documentation/firmware-guide/acpi/dsd/leds.rst
@@ -1,4 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+========================================
 Describing and referring to LEDs in ACPI
+========================================
 
 Individual LEDs are described by hierarchical data extension [6] nodes under the
 device node, the LED driver chip. The "reg" property in the LED specific nodes
@@ -25,8 +30,12 @@ entry shall contain the string "led@" followed by the number of the LED,
 followed by the referred object name. That object shall be named "LED" followed
 by the number of the LED.
 
-An ASL example of a camera sensor device and a LED driver device for two LEDs.
-Objects not relevant for LEDs or the references to them have been omitted.
+Example
+=======
+
+An ASL example of a camera sensor device and a LED driver device for two LEDs is
+show below. Objects not relevant for LEDs or the references to them have been
+omitted. ::
 
 	Device (LED)
 	{
@@ -71,12 +80,15 @@ Objects not relevant for LEDs or the references to them have been omitted.
 	}
 
 where
+::
 
 	LED	LED driver device
 	LED0	First LED
 	LED1	Second LED
-	SEN	Camera sensor device (or another device the LED is
-		related to)
+	SEN	Camera sensor device (or another device the LED is related to)
+
+References
+==========
 
 [1] Device tree. <URL:http://www.devicetree.org>, referenced 2019-02-21.
 
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 90c90d42d9ad..ad3b5afdae77 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -10,6 +10,7 @@ ACPI Support
    namespace
    dsd/graph
    dsd/data-node-references
+   dsd/leds
    enumeration
    osi
    method-customizing
-- 
2.20.1

