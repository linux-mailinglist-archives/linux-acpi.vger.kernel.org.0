Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8B707E8B
	for <lists+linux-acpi@lfdr.de>; Thu, 18 May 2023 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjERKxr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 May 2023 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjERKxp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 06:53:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 102CDE6E;
        Thu, 18 May 2023 03:53:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E0B5D75;
        Thu, 18 May 2023 03:54:28 -0700 (PDT)
Received: from josmar02Desktop.cambridge.arm.com (josmar02Desktop.cambridge.arm.com [10.2.78.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F6C03F793;
        Thu, 18 May 2023 03:53:42 -0700 (PDT)
From:   Jose Marinho <jose.marinho@arm.com>
Cc:     Jose Marinho <jose.marinho@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Subject: [PATCH 2/3] Documentation/arm64: Update references in arm-acpi
Date:   Thu, 18 May 2023 11:52:01 +0100
Message-Id: <20230518105202.451739-3-jose.marinho@arm.com>
X-Mailer: git-send-email 2.40.0.141.g8d90352acc
In-Reply-To: <20230518105202.451739-1-jose.marinho@arm.com>
References: <20230518105202.451739-1-jose.marinho@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch:
- Updates the reference to the DSD document,
- Removes the unused reference to AMD Seattle,
- Updates the references to BBR, BSA and SBSA.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: James Morse <James.Morse@arm.com>
Cc: Rob Herring <Rob.Herring@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Signed-off-by: Jose Marinho <jose.marinho@arm.com>
Reviewed-by: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
---
 Documentation/arm64/arm-acpi.rst | 56 +++++++++++++-------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
index 1cafe38fc7f9..01171b10828a 100644
--- a/Documentation/arm64/arm-acpi.rst
+++ b/Documentation/arm64/arm-acpi.rst
@@ -3,11 +3,11 @@ ACPI on Arm systems
 ===================
 
 ACPI can be used for Armv8 and Armv9 systems designed to follow
-the Arm SBSA (Server Base System Architecture) [0] and SBBR (Server
-Base Boot Requirements) [1] specifications.  Please note that the SBBR
-can be retrieved simply by visiting [1], but the SBSA is currently only
-available to those with an ARM login due to ARM IP licensing concerns.
-
+the BSA (Arm Base System Architecture) [0] and BBR (Arm
+Base Boot Requirements) [1] specifications.  Both BSA and BBR are publicly
+accessible documents.
+Arm Servers, in addition to being BSA compliant, comply with a set
+of rules defined in SBSA (Server Base System Architecture) [2].
 
 The Arm kernel implements the reduced hardware model of ACPI version
 5.1 or later.  Links to the specification and all external documents
@@ -31,7 +31,7 @@ Why ACPI on Arm?
 Before examining the details of the interface between ACPI and Linux, it is
 useful to understand why ACPI is being used.  Several technologies already
 exist in Linux for describing non-enumerable hardware, after all.  In this
-section we summarize a blog post [2] from Grant Likely that outlines the
+section we summarize a blog post [3] from Grant Likely that outlines the
 reasoning behind ACPI on Arm systems.  Actually, we snitch a good portion
 of the summary text almost directly, to be honest.
 
@@ -270,16 +270,14 @@ Drivers should look for device properties in the _DSD object ONLY; the _DSD
 object is described in the ACPI specification section 6.2.5, but this only
 describes how to define the structure of an object returned via _DSD, and
 how specific data structures are defined by specific UUIDs.  Linux should
-only use the _DSD Device Properties UUID [5]:
+only use the _DSD Device Properties UUID [4]:
 
    - UUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301
 
-   - https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
-
-The UEFI Forum provides a mechanism for registering device properties [4]
-so that they may be used across all operating systems supporting ACPI.
-Device properties that have not been registered with the UEFI Forum should
-not be used.
+Common device properties can be registered by creating a pull request to [4] so
+that they may be used across all operating systems supporting ACPI.
+Device properties that have not been registered with the UEFI Forum can be used
+but not as "uefi-" common properties.
 
 Before creating new device properties, check to be sure that they have not
 been defined before and either registered in the Linux kernel documentation
@@ -307,7 +305,7 @@ process.
 
 Once registration and review have been completed, the kernel provides an
 interface for looking up device properties in a manner independent of
-whether DT or ACPI is being used.  This API should be used [6]; it can
+whether DT or ACPI is being used.  This API should be used [5]; it can
 eliminate some duplication of code paths in driver probing functions and
 discourage divergence between DT bindings and ACPI device properties.
 
@@ -491,31 +489,23 @@ Documentation/arm64/acpi_object_usage.rst.
 
 References
 ----------
-[0] http://silver.arm.com
-    document ARM-DEN-0029, or newer:
-    "Server Base System Architecture", version 2.3, dated 27 Mar 2014
+[0] https://developer.arm.com/documentation/den0094/latest
+    document Arm-DEN-0094: "Arm Base System Architecture", version 1.0C, dated 6 Oct 2022
+
+[1] https://developer.arm.com/documentation/den0044/latest
+    Document Arm-DEN-0044: "Arm Base Boot Requirements", version 2.0G, dated 15 Apr 2022
 
-[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0044a/Server_Base_Boot_Requirements.pdf
-    Document ARM-DEN-0044A, or newer: "Server Base Boot Requirements, System
-    Software on ARM Platforms", dated 16 Aug 2014
+[2] https://developer.arm.com/documentation/den0029/latest
+    Document Arm-DEN-0029: "Arm Server Base System Architecture", version 7.1, dated 06 Oct 2022
 
-[2] http://www.secretlab.ca/archives/151,
+[3] http://www.secretlab.ca/archives/151,
     10 Jan 2015, Copyright (c) 2015,
     Linaro Ltd., written by Grant Likely.
 
-[3] AMD ACPI for Seattle platform documentation
-    http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/Seattle_ACPI_Guide.pdf
-
-
-[4] http://www.uefi.org/acpi
-    please see the link for the "ACPI _DSD Device
-    Property Registry Instructions"
-
-[5] http://www.uefi.org/acpi
-    please see the link for the "_DSD (Device
-    Specific Data) Implementation Guide"
+[4] _DSD (Device Specific Data) Implementation Guide
+    https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.pdf
 
-[6] Kernel code for the unified device
+[5] Kernel code for the unified device
     property interface can be found in
     include/linux/property.h and drivers/base/property.c.
 
-- 
2.40.0.141.g8d90352acc

