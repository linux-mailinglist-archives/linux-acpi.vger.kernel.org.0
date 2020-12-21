Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011572DFD99
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 16:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgLUPcs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 10:32:48 -0500
Received: from retiisi.eu ([95.216.213.190]:52220 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgLUPcs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Dec 2020 10:32:48 -0500
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id E1FCB634C87;
        Mon, 21 Dec 2020 17:29:57 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/1] Documentation: media: Document clock handling in camera sensor drivers
Date:   Mon, 21 Dec 2020 17:25:29 +0200
Message-Id: <20201221152529.25417-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Document pratices of handling clocks in camera sensor drivers on both DT
and ACPI.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../driver-api/media/camera-sensor.rst        | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/camera-sensor.rst b/Documentation/driver-api/media/camera-sensor.rst
index ffb0cad8137a..4e8e92fdd8b4 100644
--- a/Documentation/driver-api/media/camera-sensor.rst
+++ b/Documentation/driver-api/media/camera-sensor.rst
@@ -15,7 +15,7 @@ Camera sensors have an internal clock tree including a PLL and a number of
 divisors. The clock tree is generally configured by the driver based on a few
 input parameters that are specific to the hardware:: the external clock frequency
 and the link frequency. The two parameters generally are obtained from system
-firmware. No other frequencies should be used in any circumstances.
+firmware. **No other frequencies should be used in any circumstances.**
 
 The reason why the clock frequencies are so important is that the clock signals
 come out of the SoC, and in many cases a specific frequency is designed to be
@@ -23,6 +23,24 @@ used in the system. Using another frequency may cause harmful effects
 elsewhere. Therefore only the pre-determined frequencies are configurable by the
 user.
 
+ACPI
+~~~~
+
+Read the "clock-frequency" _DSD property to denote the frequency. The driver can
+rely this frequency being used.
+
+Devicetree
+~~~~~~~~~~
+
+The currently preferred way to achieve this is using "assigned-clock-rates"
+property. See Documentation/devicetree/bindings/clock/clock-bindings.txt for
+more information.
+
+This approach has the drawback that there's no guarantee that the frequency
+hasn't been modified directly or indirectly by another driver, or supported by
+the board's clock tree to begin with. Changes to the Common Clock Framework API
+are required to ensure reliability.
+
 Frame size
 ----------
 
-- 
2.29.2

