Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD1707E91
	for <lists+linux-acpi@lfdr.de>; Thu, 18 May 2023 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjERKx5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 May 2023 06:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjERKxs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 06:53:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0B82A4;
        Thu, 18 May 2023 03:53:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D1C7113E;
        Thu, 18 May 2023 03:54:30 -0700 (PDT)
Received: from josmar02Desktop.cambridge.arm.com (josmar02Desktop.cambridge.arm.com [10.2.78.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 138053F793;
        Thu, 18 May 2023 03:53:43 -0700 (PDT)
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
Subject: [PATCH 3/3] Documentation/arm64: Update ACPI tables from BBR
Date:   Thu, 18 May 2023 11:52:02 +0100
Message-Id: <20230518105202.451739-4-jose.marinho@arm.com>
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

The BBR specification requires (or conditionally requires) a set of ACPI
tables for a proper working system.
This commit updates:
- the list of ACPI tables to reflect the contents of
BBR version 2.0 (see https://developer.arm.com/documentation/den0044/g).
- the list of ACPI tables in acpi_object_usage. This last update ensures
that both files remain coherent.

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
 Documentation/arm64/acpi_object_usage.rst | 81 +++++++++++++++++++++--
 Documentation/arm64/arm-acpi.rst          | 71 +++++++++++++++++---
 2 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/Documentation/arm64/acpi_object_usage.rst b/Documentation/arm64/acpi_object_usage.rst
index 484ef9676653..1da22200fdf8 100644
--- a/Documentation/arm64/acpi_object_usage.rst
+++ b/Documentation/arm64/acpi_object_usage.rst
@@ -17,16 +17,37 @@ For ACPI on arm64, tables also fall into the following categories:
 
        -  Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
 
-       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IBFT,
-          IORT, MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT,
-          STAO, TCPA, TPM2, UEFI, XENV
+       -  Optional: AGDI, BGRT, CEDT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT,
+          HMAT, IBFT, IORT, MCHI, MPAM, MPST, MSCT, NFIT, PMTT, PPTT, RASF, SBST,
+          SDEI, SLIT, SPMI, SRAT, STAO, TCPA, TPM2, UEFI, XENV
 
-       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT, MSDM, OEMx,
-          PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
+       -  Not supported: AEST, APMT, BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT,
+          MSDM, OEMx, PDTT, PSDT, RAS2, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
 
 ====== ========================================================================
 Table  Usage for ARMv8 Linux
 ====== ========================================================================
+AEST   Signature Reserved (signature == "AEST")
+
+       **Arm Error Source Table**
+
+       This table informs the OS of any error nodes in the system that are
+       compliant with the Arm RAS architecture.
+
+AGDI   Signature Reserved (signature == "AGDI")
+
+       **Arm Generic diagnostic Dump and Reset Device Interface Table**
+
+       This table describes a non-maskable event, that is used by the platform
+       firmware, to request the OS to generate a diagnostic dump and reset the device.
+
+APMT   Signature Reserved (signature == "APMT")
+
+       **Arm Performance Monitoring Table**
+
+       This table describes the properties of PMU support implmented by
+       components in the system.
+
 BERT   Section 18.3 (signature == "BERT")
 
        **Boot Error Record Table**
@@ -47,6 +68,13 @@ BGRT   Section 5.2.22 (signature == "BGRT")
        Optional, not currently supported, with no real use-case for an
        ARM server.
 
+CEDT   Signature Reserved (signature == "CEDT")
+
+       **CXL Early Discovery Table**
+
+       This table allows the OS to discover any CXL Host Bridges and the Host
+       Bridge registers.
+
 CPEP   Section 5.2.18 (signature == "CPEP")
 
        **Corrected Platform Error Polling table**
@@ -184,6 +212,15 @@ HEST   Section 18.3.2 (signature == "HEST")
        Must be supplied if RAS support is provided by the platform.  It
        is recommended this table be supplied.
 
+HMAT   Section 5.2.28 (signature == "HMAT")
+
+       **Heterogeneous Memory Attribute Table**
+
+       This table describes the memory attributes, such as memory side cache
+       attributes and bandwidth and latency details, related to Memory Proximity
+       Domains. The OS uses this information to optimize the system memory
+       configuration.
+
 HPET   Signature Reserved (signature == "HPET")
 
        **High Precision Event timer Table**
@@ -241,6 +278,13 @@ MCHI   Signature Reserved (signature == "MCHI")
 
        Optional, not currently supported.
 
+MPAM   Signature Reserved (signature == "MPAM")
+
+       **Memory Partitioning And Monitoring table**
+
+       This table allows the OS to discover the MPAM controls implemented by
+       the subsystems.
+
 MPST   Section 5.2.21 (signature == "MPST")
 
        **Memory Power State Table**
@@ -281,18 +325,39 @@ PCCT   Section 14.1 (signature == "PCCT)
        Recommend for use on arm64; use of PCC is recommended when using CPPC
        to control performance and power for platform processors.
 
+PDTT   Section 5.2.29 (signature == "PDTT")
+
+       **Platform Debug Trigger Table**
+
+       This table describes PCC channels used to gather debug logs of
+       non-architectural features.
+
+
 PMTT   Section 5.2.21.12 (signature == "PMTT")
 
        **Platform Memory Topology Table**
 
        Optional, not currently supported.
 
+PPTT   Section 5.2.30 (signature == "PPTT")
+
+       **Processor Properties Topology Table**
+
+       This table provides the processor and cache topology.
+
 PSDT   Section 5.2.11.3 (signature == "PSDT")
 
        **Persistent System Description Table**
 
        Obsolete table, will not be supported.
 
+RAS2   Section 5.2.21 (signature == "RAS2")
+
+       **RAS Features 2 table**
+
+       This table provides interfaces for the RAS capabilities implemented in
+       the platform.
+
 RASF   Section 5.2.20 (signature == "RASF")
 
        **RAS Feature table**
@@ -318,6 +383,12 @@ SBST   Section 5.2.14 (signature == "SBST")
 
        Optional, not currently supported.
 
+SDEI   Signature Reserved (signature == "SDEI")
+
+       **Software Delegated Exception Interface table**
+
+       This table advertises the presence of the SDEI interface.
+
 SLIC   Signature Reserved (signature == "SLIC")
 
        **Software LIcensing table**
diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
index 01171b10828a..49a69a1cc463 100644
--- a/Documentation/arm64/arm-acpi.rst
+++ b/Documentation/arm64/arm-acpi.rst
@@ -170,7 +170,7 @@ hardware reduced mode must be set to zero.
 
 For the ACPI core to operate properly, and in turn provide the information
 the kernel needs to configure devices, it expects to find the following
-tables (all section numbers refer to the ACPI 6.1 specification):
+tables (all section numbers refer to the ACPI 6.5 specification):
 
     -  RSDP (Root System Description Pointer), section 5.2.5
 
@@ -185,20 +185,75 @@ tables (all section numbers refer to the ACPI 6.1 specification):
 
     -  GTDT (Generic Timer Description Table), section 5.2.24
 
+    -  PPTT (Processor Properties Topology Table), section 5.2.30
+
+    -  DBG2 (DeBuG port table 2), section 5.2.6, specifically Table 5-6.
+
+    -  APMT (Arm Performance Monitoring unit Table), section 5.2.6, specifically Table 5-6.
+
+    -  AGDI (Arm Generic diagnostic Dump and Reset Device Interface Table), section 5.2.6, specifically Table 5-6.
+
     -  If PCI is supported, the MCFG (Memory mapped ConFiGuration
-       Table), section 5.2.6, specifically Table 5-31.
+       Table), section 5.2.6, specifically Table 5-6.
 
     -  If booting without a console=<device> kernel parameter is
        supported, the SPCR (Serial Port Console Redirection table),
-       section 5.2.6, specifically Table 5-31.
+       section 5.2.6, specifically Table 5-6.
 
     -  If necessary to describe the I/O topology, SMMUs and GIC ITSs,
        the IORT (Input Output Remapping Table, section 5.2.6, specifically
-       Table 5-31).
+       Table 5-6).
+
+    -  If NUMA is supported, the following tables are required:
+
+       - SRAT (System Resource Affinity Table), section 5.2.16
+
+       - SLIT (System Locality distance Information Table), section 5.2.17
+
+       - HMAT (Heterogeneous Memory Attribute Table), section 5.2.28
+
+    -  If the ACPI Platform Error Interfaces are required, the following
+       tables are required:
+
+       - BERT (Boot Error Record Table, section 18.3.1)
+
+       - EINJ (Error INJection table, section 18.6.1)
+
+       - ERST (Error Record Serialization Table, section 18.5)
+
+       - HEST (Hardware Error Source Table, section 18.3.2)
+
+       - SDEI (Software Delegated Exception Interface table, section 5.2.6,
+         specifically Table 5-6)
+
+       - AEST (Arm Error Source Table, section 5.2.6,
+         specifically Table 5-6)
+
+       - RAS2 (ACPI RAS2 feature table, section 5.2.21)
+
+    -  If the system contains controllers using PCC channel, the
+       PCCT (Platform Communications Channel Table), section 14.1
+
+    -  If the system contains a controller to capture board-level system state,
+       and communicates with the host via PCC, the PDTT (Platform Debug Trigger
+       Table), section 5.2.29.
+
+    -  If NVDIMM is supported, the NFIT (NVDIMM Firmware Interface Table), section 5.2.26
+
+    -  If video framebuffer is present, the BGRT (Boot Graphics Resource Table), section 5.2.23
+
+    -  If IPMI is implemented, the SPMI (Server Platform Management Interface),
+       section 5.2.6, specifically Table 5-6.
+
+    -  If the system contains a CXL Host Bridge, the CEDT (CXL Early Discovery
+       Table), section 5.2.6, specifically Table 5-6.
+
+    -  If the system supports MPAM, the MPAM (Memory Partitioning And Monitoring table), section 5.2.6,
+       specifically Table 5-6.
+
+    -  If the system lacks persistent storage, the IBFT (ISCSI Boot Firmware
+       Table), section 5.2.6, specifically Table 5-6.
 
-    -  If NUMA is supported, the SRAT (System Resource Affinity Table)
-       and SLIT (System Locality distance Information Table), sections
-       5.2.16 and 5.2.17, respectively.
 
 If the above tables are not all present, the kernel may or may not be
 able to boot properly since it may not be able to configure all of the
@@ -450,7 +505,7 @@ version 5.1 was released and version 6.0 substantially completed, with most of
 the changes being driven by Arm-specific requirements.  Proposed changes are
 presented and discussed in the ASWG (ACPI Specification Working Group) which
 is a part of the UEFI Forum.  The current version of the ACPI specification
-is 6.1 release in January 2016.
+is 6.5 release in August 2022.
 
 Participation in this group is open to all UEFI members.  Please see
 http://www.uefi.org/workinggroup for details on group membership.
-- 
2.40.0.141.g8d90352acc

