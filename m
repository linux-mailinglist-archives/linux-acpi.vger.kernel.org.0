Return-Path: <linux-acpi+bounces-14206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A272AD073A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 19:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE923AE0F7
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D752289E12;
	Fri,  6 Jun 2025 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrjCs8N7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0111AC44D;
	Fri,  6 Jun 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229841; cv=none; b=VCodB4mv5IQeGOQOZG/01HWPGM8g3KSYufO5vnuo5m+MH8R99eY/oFGKqAiQF5e/44NC+abQjMnH/VY1XmuFlQDaAx2RxJAs88CtSOc4WadE1i13Qm27eQomLSpzHeJtesMhKE/eUgdDanWRmIM/6r56E68ZFtPozE1nq/C1vpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229841; c=relaxed/simple;
	bh=BSMddBCJ41Ilbd2FWYJhzQ/QPewb+Wq1Q5rcDoc8ck8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CU2rb5DoIFSqnC57b3xM6evKxsDvWkug7w1bCYNcG7xnLP2K8Weq9Hf5LS42VnVyEnFlAQsx2WJvKmnH1EmHxHry+Q1lAMeSdBPXUA8FN8OkbOz3fa5gHfoGO1dp4nrKJ09ljHDDYmjcAuTioW9g/fyNYtEDzYbhDU0OY9HFNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrjCs8N7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso22105445e9.2;
        Fri, 06 Jun 2025 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749229838; x=1749834638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gV0kqico3uMlw+LKBx7wC9FFLyMg8FZyPDHUacfhBv0=;
        b=UrjCs8N7e8KVUXXDtGD04wil/po2PON+tKzBosKjvYzF1m60xwrEPfd7NMJRj9ftoL
         IRoBlmLz4vn+kFAKyXHWMDnsaomSaRirM+7YjIQO1XfCZsJ1dD43PY4QQv5xZiZDEGxV
         YVpFSgK+BiUVPi2o4D+C9oAEHWUTb0CZl6Cwtmhlu1b2quwJgVLmnZICoMETVWiiYka3
         CeJI2YlQ48D8iY+fz3cCm/ochDLndj8sERvoOAWvnUJa+jaf/2KOddtf82eIJpH8x3js
         rqJSyyWrcoZI9+ivQmrm0xtjui6z8S0tmW+iSlJ9fDu9QnztHK5nDa/IV8CU6VmP1hih
         VfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749229838; x=1749834638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gV0kqico3uMlw+LKBx7wC9FFLyMg8FZyPDHUacfhBv0=;
        b=ffWOAjxXWnpUUQnFXHSKFZNE5lmiXRwoAxNFajR9NyT7YpP0J+vYvs55WUFRriIGPr
         Cv1DHNnlerjL6FuU7fXjszoRDOtqGLWUB3YzG8nw73zQUe4dyxERzp1nGahpGC35yXuS
         rXIXo1xZkSOaojvdlb6dBk1XMcKKwUFJS+bJmsf0AghGXhyGkjIg42maVmfOxc904WeA
         ISbKG4FCq2BuYH+4CtSc8IQN34b6mpk7M6rPEaCVngNSkEpbC3aS6sY9jaQwkRYAlSqX
         qXgxjpBAIWF+pdLuMGL0Dy2NiC/ig06LhSBM8QH0r3QpXAT7DzoCFNFD67b/D1xXzhWz
         T2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUyC4O6iwQ78tS0ohaAC/GZLzRGeyjegDu6NFo0LwRd4ypDbitfshNoLX6ZdIIs3OI46iY8qixmsoYt@vger.kernel.org, AJvYcCWRptTS+ChKDxiGDJqxDP1wAUnL3V24SQrCe5aQXWh5E+vZOMwUvWvQbe3HC/RC3fRJXuWbEuNPpvsvsro3@vger.kernel.org, AJvYcCWly/+smI9y4RVHTHFz8CpgCvUd/VSfcj/VcseGbRXMVwGxG+0NBFUCQEdvO1CkGZ9ah4s5ho220G6Gb3N/hk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BkSDifl9H/r/2I+iqPSqy0XdxhEkwMt09qysA36j/gNAypnd
	vQDcJ3gkO7YqtQRVudLTIL7hxuQ1j1+DqF4TVAFC8BvTu+oK7+De0pFj
X-Gm-Gg: ASbGncv13fzuFMisNgdWDXGeI05mmJvb+b9Ci09/N8Ioq9HjkRvBupLIqy/3pBcbsO/
	rU+sxGKiACca1OT94XG29E+R7aMmxH8ubCg4mejAXMR5SVU1uX1T4KwL9MnBi5mOtkBflN1JEom
	RsWhXAU3iWvaC09/bj+XIr1T97v79DtOvbtGBNJI1kpJKnMRQ+423nYKoEVknudiQkQsLXtYjrV
	doJRTYjk0lDOhnpYWf0uO0bzUNAzIVgSCLRHDW+Gv8Dpfb8F9YizSopK2W6U1/kAkZ9Avxv4j97
	cLTpeWGs3dwqvVy1DND6tXfiSrZgnCB/G3u5LXpb9eTksMC19Ihcnh7ME8XHrulGWfit1ezDw+K
	1tZXnbbrJDpN0
X-Google-Smtp-Source: AGHT+IGre1DzsJsOknujs9mDOmhMZQMaGS4A0WKDhGwFd4n2uetUZU5P4xfB3pK5rJjYQ/YrR6WQ0A==
X-Received: by 2002:a05:6000:25c2:b0:3a3:648d:aa84 with SMTP id ffacd0b85a97d-3a5319b8ac6mr4174578f8f.5.1749229837424;
        Fri, 06 Jun 2025 10:10:37 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e0563cesm29798395e9.1.2025.06.06.10.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:10:37 -0700 (PDT)
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
Subject: [PATCH v3 4/4] samples: rust: add ACPI match table example to platform driver
Date: Fri,  6 Jun 2025 18:10:33 +0100
Message-ID: <20250606171033.3882079-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
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
 samples/rust/rust_driver_platform.rs | 96 +++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index e3992e7a71e9..be7c311dca07 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -17,10 +17,104 @@ struct SampleDriver {
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
+/// OF/ACPI match tables for Platform Driver implementation
+///
+/// The platform::Driver requires declaration of both OF_ID_TABLE and
+/// ACPI_ID_TABLE, but if driver is not going to use either of them
+/// it can implement one of them or both as None.
+///
+/// # Example:
+///
+/// ```ignore
+/// impl platform::Driver for SampleDriver {
+///     type IdInfo = ();
+///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
+///
+///     fn probe(
+///         pdev: &platform::Device<Core>,
+///         _info: Option<&Self::IdInfo>,
+///     ) -> Result<Pin<KBox<Self>>> {
+///         dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
+///
+///         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
+///
+///         Ok(drvdata.into())
+///     }
+/// }
+/// ```
 impl platform::Driver for SampleDriver {
     type IdInfo = Info;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
-    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
         pdev: &platform::Device<Core>,
-- 
2.43.0


