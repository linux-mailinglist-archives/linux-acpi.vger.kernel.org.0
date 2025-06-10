Return-Path: <linux-acpi+bounces-14270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B666BAD3C48
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 17:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571EB1896E4F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9B23536E;
	Tue, 10 Jun 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSrWe3LN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2723505B;
	Tue, 10 Jun 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568208; cv=none; b=gEsVt2hZjy/R5MrManUKEdwkn+q3gKBQCKreuUNPc1Zrj7GGUeY9I5EB4JMmlb7hJudrgfIeSpff7G2zdC3XuS0lpUh7bGmrXHTd7Ypf7gygfmmerxvhkRSbtrAsTsQZC5FUBCynuf5LB2IvMh0u/r3XIBXHTVTptm+/oZlWpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568208; c=relaxed/simple;
	bh=EeIZ6B+cRl+uBMGLEJG3W+y7GnZuoGZNCjsH+pbxTUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDoL7RImZM/eHAOPqzDBcOR/yLxzyWNOuErQZA7c0Depq/k4cRZ1Ph0MgcZVxLysm4kIcd+9aLe3Rd4T8YdCZ1Yv7I0CnHNXsSFpOJyOlgCNoSrk1f55H9/NeqhTsdq7yqP61gMffweakorP+iWmya+fIPnjfVXFSQmWbeBshnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSrWe3LN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a51d552de4so3025525f8f.0;
        Tue, 10 Jun 2025 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568205; x=1750173005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcfCdyEquE4b+F62tUtsvgUsQ8ZebVumYr2H061MwVw=;
        b=LSrWe3LN+GSbA628oDAYZ/xL4iBAYFzK68NP6A7/6OUKCLkEW681cs3MDm4dJhsOwX
         1eZNzbE/alg/E5PvnCeULyU8BWvZdVwYQRs0JvVpVh4X7YEms8T0IFLF0M963pnCDQBM
         eQ7V8exZxAsjEiWxE3cHP32I1IO+hdEpIRaik47tfKthjhYjYDb85tJ9tEihlH7alPeq
         zNTNxFZKybYZWHinyr31HR4PgLQgzvg2ryqjAMicWtCHTiTb5YZbL/D3VkUXmmi3o5xQ
         HrjxzeND4aocn35/jSHNgBggT0R3uMV9Iu6//NLWnHNkFCp2W9+2EGI0qZih2yGtJjri
         e3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568205; x=1750173005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AcfCdyEquE4b+F62tUtsvgUsQ8ZebVumYr2H061MwVw=;
        b=vrS7b5W69hcqzZWYXT3p/mFIWlN3iRWBfF98NlkcY9cb9F72eb/QZ4CRQt1jY43wEh
         gEBAfXgg+7Guq0FTIxxUUrG7hKlFHkk3L3b9EJUXqaImv0TfmCPC/qYXkFHBO05Hvxze
         JPWoAxtltSwHyrH9lXWI49DFxNduKzrJxTbKxeMddElQgzNZcDXxoO0vB+80TXLwxpfU
         jPxDqben1afqNvwn+ntNZi7V84QVWPjnaJdY6jeS8gqiFSOiwhRdN7qLN3PAR0Ga8s1x
         ZGw70nq0tvb5jnDfxmtxELQ9jgAcbxL9ASbdlAiMpzLBxrWKX3LUEmamy8a9666eCcW+
         t7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbjZWCKgrw84iWdmJxp3u6Y8IURKRn2UZ9X3iHup75NftLhYC4dO3SXOM8GYKVCG/cpbkGTHYX6b7s@vger.kernel.org, AJvYcCWjal7eINagaPYZ7jKwisRcppft6BSff+DdCshzeifmMCDPT8I1nro1Daj5eK7gk4OdsN5MpwCjG7vCs/PxS+Y=@vger.kernel.org, AJvYcCXTvrrVdeCI4Im5jaMeJ4hTIJBBIUrDyV5CDLQe5UKSleRKlWnf/yNvisHACDXPSw5ZQNL9SOAJXrpURaDm@vger.kernel.org
X-Gm-Message-State: AOJu0YyFyJIzESL61/mpN//LCWEqbpnZgsVPstFxk27CZ88knaP9W0uR
	VgPLl7VKM+zpFfJmKVPvOtutlZ8iXzcgnEofCIcYj1an/WmV+s8MNinD
X-Gm-Gg: ASbGncsB7rY1CsFuLKKO1hTbYmzHtueAqDVCX5emvBuFg5CAF/q3hSg2h7b4OFsS+Jc
	BSzKi3PefikrYY+ACJnWzT+39Hvi3CF1rkVpmHhP05tnLZsYkT6uMPxKN1/VY9B6pvAdu3gZyE9
	NohhRlFgHZKZ1Ve9+9HJrWsa1p3kiiKxrBMxLtn/QFNUFm6B52tgrwBbN/LP+ad0Qnl7jgcpqy3
	24T7kG627YzQUbzT9qO+S4cusWeqfYlL0aWbnjsMkBuXbIRmKROMMlvgEaBaQSpnDNAYKx8Iy5g
	tMdiWoiAc/ydJAsvsm7MXZRIyDpCgffoG31dDgjU2akHyvYNiYNYRCidt7d5iYlW14b0nfSOQUs
	tKnn8t7Z8RP5734mqilUFwMTeq8Ycm6/WpvnE
X-Google-Smtp-Source: AGHT+IHcpiLJhodJRLVjtoeEtX8y6dCV2mx6RpniIxolzQ0szt1L1NR72zhfiiuxXn3WZ7itWaw1bg==
X-Received: by 2002:a05:6000:25c5:b0:3a4:e189:b685 with SMTP id ffacd0b85a97d-3a531883887mr14033774f8f.19.1749568205408;
        Tue, 10 Jun 2025 08:10:05 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de17sm12877653f8f.18.2025.06.10.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:10:04 -0700 (PDT)
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
Subject: [PATCH v4 5/5] samples: rust: add ACPI match table example to platform driver
Date: Tue, 10 Jun 2025 16:10:02 +0100
Message-ID: <20250610151002.238890-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
References: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
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
 samples/rust/rust_driver_platform.rs | 70 +++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index e3992e7a71e9..35d5067aa023 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -17,10 +17,78 @@ struct SampleDriver {
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
-    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
         pdev: &platform::Device<Core>,
-- 
2.43.0


