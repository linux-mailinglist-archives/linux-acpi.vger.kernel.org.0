Return-Path: <linux-acpi+bounces-14288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621EAD5D9A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9847A2E00
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A7F229B38;
	Wed, 11 Jun 2025 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MND96yGu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AEB188CC9;
	Wed, 11 Jun 2025 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664707; cv=none; b=W24lNVw5t1bZDYP7nfysvMksOOX4NTHnCXhqq1PJ35UnP/LXtp+iop88vnrjHw8eX8qanzj+2AKvuqd6e1GPySqtpZjAHtGVq9iXVTzmumojyxTu74giJDKyODu8VmK60WTgkS5nTEi6whYf5WToPp9CLqzng9QgrkEe26xmprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664707; c=relaxed/simple;
	bh=5+kbWDXXq4IG8sDuXqes6a43G6RDWXt2POCGQmcpyOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skiltTbEQGl4EeTgfpf8kiX4BvCEPJRsvlSG7hI1yQC8wJUrTJMezg/39PDzMsCjXZiJWVhNpPgBekGEhOLTAcQy2Kk6Wf5Cde/QEHEGkMrFrEZBTg3i/CWxechW8JQA2xrvAqqnZwYi+9HfbAL2f09etscAi9G+o0GJbRXT1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MND96yGu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cea01b9cso311295e9.0;
        Wed, 11 Jun 2025 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749664704; x=1750269504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuauSSTqx1TDFESDgGFVyFslKTU+wwALp8k7RA41ffM=;
        b=MND96yGuGsI/mxw1pkY2GBK/SYPyWN7LsLlV0QnwIvXzeTXpyyQt4hRVep5Gcfi8cW
         1+t3DGg3YVo+W+s1GIo4uqiuonEOXMpmsrTkbrYSYomVBfdCIW5qdRMhs/0J/qqzPk9g
         6iCmPy970p+8dUUBaSr5y+ABEodxcFyjhmJfK91qMntTVEeriYVzCYSOREFHoGj+8T5Z
         cNjdUCzjOuXkLaVRgmQUkUwPiO7n863act+s1GsFILBTHXA3bqGtLna7bDqreiWIyvJS
         dpnNRgFmlpkvnsZl0/TJbSBAcqarDEJnxaO53VnA+YJ9i/Vs3IxEemtAIVcw04pse/7i
         UC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664704; x=1750269504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iuauSSTqx1TDFESDgGFVyFslKTU+wwALp8k7RA41ffM=;
        b=oMQ1dlmD5yeBUxQfffSHhfJi3GoVUyZllfKEYMHKU5nR+CVQJRdljquDxQ9x7sOpWX
         Dd49QPo6XlCLkjTC+DOr81ACmcldfaxs+OQ0JKwXwU8sS7b4TkQzp/vv5nrW4KoDsm7r
         nwDyjyuYpNxGbak5IBheMszFXNckgWmJbM2jh70kQM8gWJIa25DqwPyR0TilvB1Q14Qz
         0UvaLKnf9KEx56KT872lH0gdXeh9EOEoJ7tK8V7kM/uUevI2qBRCs3O6YJYk6SSElOlA
         VThB4LhLFQP/c/+krx70gXSBc4uqgx6mOhqmrCIwdRdClm0pjQtT9PVjUfWCoq62tMl5
         6AeA==
X-Forwarded-Encrypted: i=1; AJvYcCURbX4v3unlNzFNXOcoBqtQvGR9qAHq2nZgxIz/kB/bOS2K8mCJTbAXUJLhqHzGzvjyotjbLLjL3DFs6B3m@vger.kernel.org, AJvYcCUVeaWu6gp6GTa6WBBJfeidQCp1x5iM9mHy7YOA6gEOcx20x5rzWAPtME4UeOa7HLHzdcW+f+4rGWso@vger.kernel.org, AJvYcCW+kMXnnaRhsH+rKD/Nc85TT0vFBx271d7a9a4DFJc8hqAiY/U7/MT0KBSGWsNdwZBthINUkirtoi/LyrXTxDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYlHRDLclxPFYDREImFZdSmNrJmDpeTNRjBXZYE5IdXIEa/Wl
	UKCwC2ZgrTcAGSia3SDm9RVDSaxotD6CjMTko5txJj/Q4MWCAcjpZJzUa3famaJ+wHg=
X-Gm-Gg: ASbGncvtQfD2CqKxyMoMHgqOdRozUfIhG2nZnKWLOWyI/4YgKmRCVG3qhnucsyPndcF
	CcSQZR/LDwS2DG9tUVonmlQw6P437cMILlndf3yMkGNUCDCgC+9M3WTJG+P+D0tdBysHtvR/wdl
	vTUL9O9sJb/nc4RgVEFR5exZ6B7ct374uZYyPWRWyOAc7pSBma1qWa6stvA+UtP6RYKydhlmx+w
	TNALSlM75gzwFHbv0Nuh2p7YD5ONhtLZvLi/SDCkzd9C01N4TuBq2xJ3rLbfWeXt0NpTxBGFIhv
	0LjkG55qhaIt2zfLLHsp7VOSD0TYshypQYZ+ZUKY3C04J6hkcgPhyMAjtSI+NAOilhNYmVqMsb9
	9ar5m2knzs5s5PE9oR4z5Zk6DQ0iqrprVq6lw
X-Google-Smtp-Source: AGHT+IEg0k970DGPt+HOeiv6kkgVg9C2xgXIHwMpy2WRypQIpwqG83M++zCuuFAXKTvjT5p9ZNVqEw==
X-Received: by 2002:a05:600c:1c9e:b0:450:d4a6:799d with SMTP id 5b1f17b1804b1-4532b8c5807mr7781705e9.7.1749664703588;
        Wed, 11 Jun 2025 10:58:23 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532513e27fsm28248385e9.1.2025.06.11.10.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:58:23 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	lenb@kernel.org,
	wedsonaf@gmail.com,
	viresh.kumar@linaro.org,
	alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: [PATCH v5 6/6] samples: rust: add ACPI match table example to platform driver
Date: Wed, 11 Jun 2025 18:56:20 +0100
Message-ID: <20250611175620.804242-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
References: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the Rust sample platform driver to probe using device/driver name
matching, OF ID table matching, or ACPI ID table matching.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 71 +++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8b42b3cfb363..35d5067aa023 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
+use kernel::{acpi, c_str, device::Core, of, platform, prelude::*, types::ARef};
 
 struct SampleDriver {
     pdev: ARef<platform::Device>,
@@ -17,9 +17,78 @@ struct SampleDriver {
     [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
 );
 
+// ACPI match table test
+//
+// This demonstrates how to test an ACPI-based Rust platform driver using QEMU
+// with a custom SSDT.
+//
+// Steps:
+//
+// 1. **Create an SSDT source file** (`ssdt.dsl`) with the following content:
+//
+//     ```asl
+//     DefinitionBlock ("", "SSDT", 2, "TEST", "VIRTACPI", 0x00000001)
+//     {
+//         Scope (\_SB)
+//         {
+//             Device (T432)
+//             {
+//                 Name (_HID, "TEST4321")  // ACPI hardware ID to match
+//                 Name (_UID, 1)
+//                 Name (_STA, 0x0F)        // Device present, enabled
+//                 Name (_CRS, ResourceTemplate ()
+//                 {
+//                     Memory32Fixed (ReadWrite, 0xFED00000, 0x1000)
+//                 })
+//             }
+//         }
+//     }
+//     ```
+//
+// 2. **Compile the table**:
+//
+//     ```sh
+//     iasl -tc ssdt.dsl
+//     ```
+//
+//     This generates `ssdt.aml`
+//
+// 3. **Run QEMU** with the compiled AML file:
+//
+//     ```sh
+//     qemu-system-x86_64 -m 512M \
+//         -enable-kvm \
+//         -kernel path/to/bzImage \
+//         -append "root=/dev/sda console=ttyS0" \
+//         -hda rootfs.img \
+//         -serial stdio \
+//         -acpitable file=ssdt.aml
+//     ```
+//
+//     Requirements:
+//     - The `rust_driver_platform` must be present either:
+//         - built directly into the kernel (`bzImage`), or
+//         - available as a `.ko` file and loadable from `rootfs.img`
+//
+// 4. **Verify it worked** by checking `dmesg`:
+//
+//     ```
+//     rust_driver_platform TEST4321:00: Probed with info: '0'.
+//     ```
+//
+// This demonstrates ACPI table matching using a custom ID in QEMU with a minimal SSDT
+
+kernel::acpi_device_table!(
+    ACPI_TABLE,
+    MODULE_ACPI_TABLE,
+    <SampleDriver as platform::Driver>::IdInfo,
+    [(acpi::DeviceId::new(c_str!("TEST4321")), Info(0))]
+);
+
 impl platform::Driver for SampleDriver {
     type IdInfo = Info;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
         pdev: &platform::Device<Core>,
-- 
2.43.0


