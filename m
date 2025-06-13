Return-Path: <linux-acpi+bounces-14355-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A0AD8E9C
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6473BD89F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240DC2E764F;
	Fri, 13 Jun 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRUMvw6W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7A19B5B1;
	Fri, 13 Jun 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822975; cv=none; b=Hxfg+3AlrkG1u5+c4CCid8TmgBQaQSt7tpRGBBSk993IHkTAEzSYxamm5DDdAuQhBohAk84VNczM5R4oMQSiTMTL6Dm7DD25KFLHSRxpKYwGIQouraU8nr0nzkmdbuzAHayhGBfCNZm4b5dFq+Q3xVyWgyP4+hLnAeitIKLWhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822975; c=relaxed/simple;
	bh=5+kbWDXXq4IG8sDuXqes6a43G6RDWXt2POCGQmcpyOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ7RrU1SMlgtKb2iiiUfZKID63qg6gnjEpXcQrwSr5b6J3RJKFne4CNTbGhZszHpw5z2BsAfpMvl0IRcvzyPHNl4AuMHLEpHW1pv792quk5DbRI7FYIM2VnhMl2QdZS6Tw4pXIeR5AxjNI1AdIpyWAri83W/xua7YDMJkL/MzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRUMvw6W; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442fda876a6so18932965e9.0;
        Fri, 13 Jun 2025 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822971; x=1750427771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuauSSTqx1TDFESDgGFVyFslKTU+wwALp8k7RA41ffM=;
        b=jRUMvw6WisV+ILtgTMas4DgTJTEiYQxV3Hzm/l6ykxsTgDHvOCUOPS8k3g+w0A4xdy
         BFyQBSBWqBDBV6oC8wAHQqZaNQkdCfxzno+K4BitIkbEefOJGICEHN+nA8cXz98uwtmb
         p6Gt1VQGdlBHoJyVBWw8gfnPhaCk79nYQ0Ar4XXNGIRSahDM25kV3HHUaJq3SLwX9vGw
         77/07mrhdMuymd7F7J/jj6uIfkC23xUtqMsTqCWgXoML4G66pRiRH6xsDTYNqdT4X2MC
         VK2rpCkCJq0kAQJ7ND8TR8s7FZDvOIBX9swBFGE9pORDqetlnT3wJpbmwlA4BK9PX3lg
         YUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822971; x=1750427771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iuauSSTqx1TDFESDgGFVyFslKTU+wwALp8k7RA41ffM=;
        b=MoPAFXQhCzafSyAOmmoB1DxNuil7ZX104/ush2znxxIaupQLZBZLBotkQlvZZ2Jx7H
         eCr0IfM4TlJehTxdYYU6G7bSiPTAXLWowpN9iZlS8EQwTuIUGHdt45Va9Yu7aoops5YG
         4rNrLXZAz2DK6KKzWJKIT3cSWpNj/qTcZNvSXPSUnrMuDPYiAO7fHxXvyNRxzTZYyYZ5
         uGijrT6tzbjsj0iIH+9rTNSvRjQhsypXRgutBFbVFYbp5gKqdmo4gHvQ/OsK/oZxgf8v
         wgAwUV14/My6UYSGxbN+cRToR4R6zcEAZTTeSxwxin+d/E4bIoJw24rfyKRTPQblC6Ya
         FCYw==
X-Forwarded-Encrypted: i=1; AJvYcCUtRKb+5/v1k4mo9JaiM2JOX9zp4iSCIbIartapHopbinSE8bxO+9mPDKpjGVea4C10wwpFE/0LDTMN1NWi3to=@vger.kernel.org, AJvYcCWk48ICRaf2wdB3pwYQDYtLwp++BlBdMI4VE4jvjIPLAO5f0UGH8qAIitX5IpcrzyYJZ9iwtMrzi35e@vger.kernel.org, AJvYcCXEFuLNC7rb+Rq8iOJkETTCtoNAwXuSJuVbhHQxoWBi0pPYVJpzU6uAA/fSnZwZVnr+ssEhv3McUDh5/cda@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+27auW6SsGqhycFQ9jjm6RwYjx6ZI0dZ8UFK3ZnRbIsx3HHy
	VWmxOQbpzw/W9KXMqeXASFAW6bR/RuRHFvaV5DHCNcrGPSPGbTryVSrZ
X-Gm-Gg: ASbGncvHr1zSEMMmzsI8Oyvnqk+jY8VcWQzcbMM5BXVO3zZ1k6xL68G7/gHWx8AO2m+
	xB2pfhMjEqqL/IRchN2FNlX7cN8hESxljJV8jfl4whPD3mOps9tvXEs27Dw9jaK0X4lTDfzxbjN
	FW8LWmC5wR8EcCmfGpm5oIuDo6OazRk5oIqv98c5NQEMmgY83VavzyM7WhYIk0FqXQlWYsp7b7+
	bzxQKagKfdutzaevgfT7bn+LPJxDS9bH6wPDwDBywpXRUMbMz1xVTiQB1d7pQbYbWDJFU5BSGeI
	E5KyfTVUUSNuL4a8AKaL2BK9QsIsdkFu4YU+sRzy4F/6J+GpNTr/VIkj3WjFCib4P50xxpP1tRn
	VhaiNznvGPj3OWG5vIWXdt7huCdjlaGGS8kSF
X-Google-Smtp-Source: AGHT+IGTzyy552+tppB1feCaA+V2C1A6hMR43WFjhXbodmqD/BBCl9OoHG4w6shHYXb2kVogl4oGFQ==
X-Received: by 2002:a05:600c:3f16:b0:450:d104:29eb with SMTP id 5b1f17b1804b1-45334ab20e4mr31162545e9.5.1749822971229;
        Fri, 13 Jun 2025 06:56:11 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e195768sm53600045e9.0.2025.06.13.06.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:56:10 -0700 (PDT)
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
Subject: [PATCH v6 6/6] samples: rust: add ACPI match table example to platform driver
Date: Fri, 13 Jun 2025 14:54:07 +0100
Message-ID: <20250613135407.1233005-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
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


