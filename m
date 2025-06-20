Return-Path: <linux-acpi+bounces-14487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1C6AE1F70
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DE2189EAB0
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2E82E9ECB;
	Fri, 20 Jun 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4kU49/Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A02E763C;
	Fri, 20 Jun 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434478; cv=none; b=BmyxJQW5Z0LGE4rYq/A+QUzWu2bGUrW+AezR/dwwFwoRvz15TqC8IdFfqUpvBgtF7fYRBUJqk/jJiqz7RjQV7w9AaI5nCe0I20DCCj5tiGj2kQlGk/wQdJMwrPpF4SGAfTj7gOUEdBEpTQ4NIcn7DCAMXhdscj2w9iutAK3q0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434478; c=relaxed/simple;
	bh=puPbHpytOZW7mie8GfL84As9P2RFvRpERNKNKQE1xwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmaIicZC6sJ8eWw1BHS6y3X6WMdpHsBSgdj+RgW5pvrzrtpT1gnIRGb0UHEYkulfAk8rGq69GThhl+kHTqA3p9RtTNvoW36yDFUYMSzIbKctDkvJNxffOc7rhWERWoWoJyctMV6lOFORHd2fv5WkgIJw440eajK/nl2bEiLARo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4kU49/Y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453647147c6so10377325e9.2;
        Fri, 20 Jun 2025 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750434475; x=1751039275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqFUjW8+uNCNgRtyXVYxbhOT3igrLvGYOROHOkaDs3Q=;
        b=l4kU49/YCMtXxAV9xfHhoLUTfzCMwTHjrNNI4ZAEuYnBLDMFt8fBSJcCSHfIJGQAdE
         bEXQjV/iAKGnR+BlMPXIsspmNMJjD4qjeQ1tT+N977UloaLbgYYpJ2wj9JCx2FzeMfSD
         rmDbELZyuBNy6FkCkvHptQ5P4yR70VU5g/35uY9AoG+Pcdq9A1UH7MGSqdvgQRjMqgMC
         RkQdQKVE1u0AfgQp0C3yrhtLJZHJiFdZ26cAIa9a22G1czCdbRN7BOw4d/y6Xsy1yBOI
         nWEjyKtg568z2ZMCzuVfXEqfLIrEIJiL9is88HwlQ2LRiUPbUTAunzcAMOYniUQifqKz
         8kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434475; x=1751039275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bqFUjW8+uNCNgRtyXVYxbhOT3igrLvGYOROHOkaDs3Q=;
        b=kwAL+DVblYmuanI09kS63ZNSSoZrhNwHyNG9vplPYg7L46EpyJua5EPG+YBEVBIKeg
         9EwfuyYTqkl2jgrg0qqJgOjbJ+rqN9jlfS+p0zaZJU3pFJzAfUdBKa1pLuG4w+PqAVgf
         Gl8LxJp9DYSQv9gb5bNXPY0SBf6NLDUQp8pKDZD4hTy4BxxxxfI2MqFdqcIe+d+MGSTn
         yKdKdVaSVCDErZgZ9zxAaI3c4vAYblKdpuVjymUwSuf2V53u5ELKLAKMJFlUj5W3yVY+
         3ckPLsDxW7xBOHpgTQ3tGAhsJWKBroQAlrTVQ0Rh5EY8vKU9Uio3X04LsvL8o0gT5WOD
         PQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGPMt8k9nw+lo/zmHXjqvkSGFDGNXbSiassgnQUChP7zTV64WXXHIBjIEVNk0TN6rdgL15FDAK6bp1CYDU@vger.kernel.org, AJvYcCWkNWAD9n5MYeXxWnTFbZrMLhx5I4OFsKWjZYt1rpZBYzSgi/wKNKu+J71xHdTNZ6oL56Pw2cbn+q6LzTQAk/0=@vger.kernel.org, AJvYcCX1xZJkiQ6c/iaeSPAhLWcJFBDakCCOagHl9b9RzrfVtooxEQEuoCfNWQ9PtBoRE8ppP3PN8uE1i4nFBA==@vger.kernel.org, AJvYcCXLSjO9jokepqSYoG8KuPUUMDGr90u2+IYGrWIiLvJnHHGO9vIHubXwqPf6zVrpifOv6N7EDWnQ36yS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0WcwUsdnlwtfR4RcscUoEEtqRF0DJPm6dgZkDnFvI86gcWLR
	9bE0LlShQbTtTuoXMmRl/SJh8PSlKEsfiB/iitwffVKjgMVm6lWidEww
X-Gm-Gg: ASbGncvmYLyT/Kjuk8YMOdRCde246fvNEyrAAj2rlAYGnN8yMCX67s7gZZ5+kMcuN+c
	LHLOsFeDaZQ0+imYfUJxu7uK5EVXrynng+mEfyqj1/3H+T3vBBNwxw4d2VmEyPzjK47MHGOI/iB
	Zxe2Nv4654uwL4aLNyrzjtA/lnRj3iJVGtjcjYOh5bpnV+kSc6Oge9dxVF/rq5kzOJhf90fegDh
	EGCQfPsaf/WjrkNx7dJKYiuV/+TsmDS68pbrAR+fPAgqaf3pBdG2bPKY3NYk5cfV3XnXmKXWt8W
	U8sZ6AxTTerJPiM9g4iatUOao1g1xl/Ys0hZzaI7BO93G8w4WTwxpOJ8tCw+BF4zYXUctJvk5YF
	6lIGYKoyqj0xhtXUo+XUBqyy0IdAYe+Fb9rpT
X-Google-Smtp-Source: AGHT+IGq8HrsMga9eVPB6fzJA1zoMGuoKpuD12G+vs6rwDV90u10qjjl3ByW06NQ8l5TR4U+898YzQ==
X-Received: by 2002:a05:6000:248a:b0:3a5:2fae:1348 with SMTP id ffacd0b85a97d-3a6d13129c6mr2772728f8f.51.1750434474935;
        Fri, 20 Jun 2025 08:47:54 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f18a29sm2442795f8f.36.2025.06.20.08.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:47:54 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Alex Hung <alex.hung@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Remo Senekowitsch <remo@buenzli.dev>,
	Tamir Duberstein <tamird@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Len Brown <lenb@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v8 9/9] samples: rust: add ACPI match table example to platform driver
Date: Fri, 20 Jun 2025 16:45:52 +0100
Message-ID: <20250620154552.299932-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
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
index 8579290eecb3..9c16945e6c70 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,8 +2,68 @@
 
 //! Rust Platform driver sample.
 
+//! ACPI match table test
+//!
+//! This demonstrates how to test an ACPI-based Rust platform driver using QEMU
+//! with a custom SSDT.
+//!
+//! Steps:
+//!
+//! 1. **Create an SSDT source file** (`ssdt.dsl`) with the following content:
+//!
+//!     ```asl
+//!     DefinitionBlock ("", "SSDT", 2, "TEST", "VIRTACPI", 0x00000001)
+//!     {
+//!         Scope (\_SB)
+//!         {
+//!             Device (T432)
+//!             {
+//!                 Name (_HID, "TST0001")  // ACPI hardware ID to match
+//!                 Name (_UID, 1)
+//!                 Name (_STA, 0x0F)        // Device present, enabled
+//!                 Name (_CRS, ResourceTemplate ()
+//!                 {
+//!                     Memory32Fixed (ReadWrite, 0xFED00000, 0x1000)
+//!                 })
+//!             }
+//!         }
+//!     }
+//!     ```
+//!
+//! 2. **Compile the table**:
+//!
+//!     ```sh
+//!     iasl -tc ssdt.dsl
+//!     ```
+//!
+//!     This generates `ssdt.aml`
+//!
+//! 3. **Run QEMU** with the compiled AML file:
+//!
+//!     ```sh
+//!     qemu-system-x86_64 -m 512M \
+//!         -enable-kvm \
+//!         -kernel path/to/bzImage \
+//!         -append "root=/dev/sda console=ttyS0" \
+//!         -hda rootfs.img \
+//!         -serial stdio \
+//!         -acpitable file=ssdt.aml
+//!     ```
+//!
+//!     Requirements:
+//!     - The `rust_driver_platform` must be present either:
+//!         - built directly into the kernel (`bzImage`), or
+//!         - available as a `.ko` file and loadable from `rootfs.img`
+//!
+//! 4. **Verify it worked** by checking `dmesg`:
+//!
+//!     ```
+//!     rust_driver_platform TST0001:00: Probed with info: '0'.
+//!     ```
+//!
+
 use kernel::{
-    c_str,
+    acpi, c_str,
     device::{self, Core},
     of, platform,
     prelude::*,
@@ -24,9 +84,17 @@ struct SampleDriver {
     [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
 );
 
+kernel::acpi_device_table!(
+    ACPI_TABLE,
+    MODULE_ACPI_TABLE,
+    <SampleDriver as platform::Driver>::IdInfo,
+    [(acpi::DeviceId::new(b"TST0001"), Info(0))]
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


