Return-Path: <linux-acpi+bounces-14164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFCCACF4BF
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 18:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D64174AA7
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BDE2750FB;
	Thu,  5 Jun 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFxxUJNK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4B1FCFEF;
	Thu,  5 Jun 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142277; cv=none; b=ar9LYdoQz4DpoON0cLSlllyWH6VWe4sZWIqVUe/dH3LSnEKz35OyKvvvdt7ubkKqpYzij8njzQPluHACtfJYECP4AG1Y1uAfVYp/NcL4boSuD/UFlrEy00XgHCHp8FEJWpQf56S0IPXU8CB15TbB/XnbEGP1fkBj84F4Uk8XSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142277; c=relaxed/simple;
	bh=zFICxLJ7QOuBQtUlRFqXRP/ffC4QY3bC9sQSxn88Aj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHMxSiJFlq2ZSbcwRCD+o1CZbtWFf2JXYPfFonG1XbnX9CS4tmtjUQeTH8hzWsfPNr7SJbzfqe26fQglKjew1GL0MdbEZ2HO35ptvUpvSmh3+5vR1rPy52SpKvtgRpqWl2x9oxol6MwpS9zf1DlNa0KIz4rgeSZE6Vzj1QtSLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFxxUJNK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so1044970f8f.1;
        Thu, 05 Jun 2025 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142274; x=1749747074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gws1FSnzirsIRI31OhrbcqvSnTpowd3o+HlbUmORps=;
        b=NFxxUJNKlLVHiztlJ2xngXiwD7Ox9V6Iji+w1eaPErqxJbK1AieLycZem0uXtNdqHA
         oT7fnUgVRCr6Y+gLE7YnUnRoYj7oi8bOUO/gRZyy+MAkviPa1UIWHp3QuF/hlHf4V7gf
         OVLmzDEGQiMHCiJ8njtu+Bud3K6tRk1c+dii19rfUcKDh9SWBEEK11kjYS3mhC4S5Vde
         MN96QBDSAJRgh06jQgIlWFGm0BsxdrBukCQQPMGqAha3wGlfg46S7OJVLOgkYsl/WNCa
         k7DEgJubL9lQNDCVRl9PvtJBrE6iWfjS3wU2OE5JQh7CF/BhrvRc3QRFzQEy45Acecm0
         Anxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142274; x=1749747074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gws1FSnzirsIRI31OhrbcqvSnTpowd3o+HlbUmORps=;
        b=mhKsMwZrrE5tPau60/oOusTv4eJZ3krbez4H5gkaaNakNOkSzodtJYUGzeGcjdC2Ji
         VqXXCLZ601QLQyKwh3pLB9rz+N2Gdza7f861KZGMk0U6/ssAwtkNMxYxVbCJBYQN4WMC
         Mbbre53R0CnKRJmhLE4R8YMj0Mz1MK0PIyt31rcLAVbG1DA/SP6RM2RCdGsFcJWc0BO8
         9HrRc9MJDQL5ZQiZmiDDhY819tM7jbDwI0OPUzou6jk4oFvgAteVA7/DAFZG8/S5Lsau
         Ttp7Akt5xlfbnxHHKkvacmIVXcuHAinqNfWlhwHhi29NJB9aokxejnFv3goh8K6HYQUs
         yp8w==
X-Forwarded-Encrypted: i=1; AJvYcCUeqjuArp58zsPZXNwuL8NnVqmtGgRJ/4kxlhhJpaCgRutKw63Zep87gx6WxTd18dwHPb1UukMtknI+@vger.kernel.org, AJvYcCUujMBOnlz9L0CHZEY/ODuMRsNVrqD1mgWtOEOk3j5fDPLqLMwV/C08ZV7rHbbYvNJEncii+MNlRfsR+Q==@vger.kernel.org, AJvYcCVJRtA3bnbQNhfGx9w+gSfVXTVKE2qkxDXpnvbsmvqk2Ykji1FnDdWgkBeGoC/kjgFcwd5qVntRwTyw7Zo07kE=@vger.kernel.org, AJvYcCWx/ScIGONjf7K1JZEi2/y1URJkZFSeVz9Ndq1RBIOkEKgEddL9Xp038eQjpKW7GspRDnA55UM2Gj+Zu4Cm@vger.kernel.org
X-Gm-Message-State: AOJu0YxScwW27TQuYRVVaJNphvMdAJ13cqtu5+wynWuovo0WjiZ5E3nQ
	1VvS41qNuu4r0siijByH5Ikpk+mTcI6AGuQRgweycffyPlI34LoeOBcjeyn3LAsKyMM=
X-Gm-Gg: ASbGncsVmv0xVSfmxYhykwhn0KjGUzDcbMNRTCNURvyOmNrwZBFX2BJroEXJd8mftdJ
	O8WeTlKaPfPJrVqeHU+0FwYCyT5ZboWg9PYAYJyVPwM7hjy49ppBKcDt5EoKVWzBDhk8Gf+F/8/
	Y/Jx6wPI46/v7gn4JjxIUP6h6wFFyDCA9aL34J/Hx8gAybABBnJc7B8yN0LAfyh9U/ftq9j9Cf9
	6JVW/94twoW8m7Ob9byV5kjy8zIlB8nuIO0d+tlW3Uusc3XUHs7hl38xuuDBk54rUNM9SJnXcmi
	DNDwlNAxvNaVEUjT7hpCj0ZrnnpmOw/EN0Uhr+/9H3UY4MEL6ZQaO4wSVjObBhsjkM3Mvj9Uewm
	8cqX7VmhcJRqbFmJ/qYZnNoo=
X-Google-Smtp-Source: AGHT+IETQzNQRtz4ljBAITFGPNNxQ8l9shjxzB/APN0oRFkd3PaYObXcukoJTxiNospnSQEsDUdM7Q==
X-Received: by 2002:a05:6000:1448:b0:3a4:ffec:ee8e with SMTP id ffacd0b85a97d-3a51d968aadmr6341812f8f.36.1749142273474;
        Thu, 05 Jun 2025 09:51:13 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm13286175e9.27.2025.06.05.09.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:51:13 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>
Subject: [PATCH v2 3/5] rust: driver: Add ACPI id table support to Adapter trait
Date: Thu,  5 Jun 2025 17:51:09 +0100
Message-ID: <20250605165109.3663553-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the `Adapter` trait to support ACPI device identification.

This mirrors the existing Open Firmware (OF) support (`of_id_table`) and
enables Rust drivers to match and retrieve ACPI-specific device data
when `CONFIG_ACPI` is enabled.

To avoid breaking compilation, a stub implementation of `acpi_id_table()`
is added to the Platform adapter; the full implementation will be provided
in a subsequent patch.
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/driver.rs           | 58 ++++++++++++++++++++++++++++++---
 rust/kernel/platform.rs         |  5 +++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e0bcd130b494..d974fc6c141f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,6 +6,7 @@
  * Sorted alphabetically.
  */
 
+#include <linux/acpi.h>
 #include <kunit/test.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ec9166cedfa7..d4098596188a 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -6,7 +6,7 @@
 //! register using the [`Registration`] class.
 
 use crate::error::{Error, Result};
-use crate::{device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
+use crate::{device, of, acpi, str::CStr, try_pin_init, types::Opaque, ThisModule};
 use core::pin::Pin;
 use pin_init::{pin_data, pinned_drop, PinInit};
 
@@ -141,6 +141,38 @@ pub trait Adapter {
     /// The type holding driver private data about each device id supported by the driver.
     type IdInfo: 'static;
 
+    /// The [`acpi::IdTable`] of the corresponding driver
+    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
+
+    /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
+    ///
+    /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
+    #[cfg(CONFIG_ACPI)]
+    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        let table = Self::acpi_id_table()?;
+
+        // SAFETY:
+        // - `table` has static lifetime, hence it's valid for read,
+        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
+        let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
+
+        if raw_id.is_null() {
+            None
+        } else {
+            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
+            // does not add additional invariants, so it's safe to transmute.
+            let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
+
+            Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+        }
+    }
+
+    #[cfg(not(CONFIG_ACPI))]
+    #[allow(missing_docs)]
+    fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        None
+    }
+
     /// The [`of::IdTable`] of the corresponding driver.
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
 
@@ -178,9 +210,27 @@ fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
     /// If this returns `None`, it means that there is no match in any of the ID tables directly
     /// associated with a [`device::Device`].
     fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        let id = Self::of_id_info(dev);
-        if id.is_some() {
-            return id;
+        // SAFETY: `id_info` is called from `Adapter::probe_callback` with a valid `dev` argument.
+        let fwnode = unsafe{ (*dev.as_raw()).fwnode};
+
+        // SAFETY: `bindings::is_acpi_device_node` checks `fwnode` before accessing `fwnode->ops`,
+        // and only compares it with the address of `acpi_device_fwnode_ops`.
+        if unsafe { bindings::is_acpi_device_node(fwnode) } {
+            let id = Self::acpi_id_info(dev);
+
+            if id.is_some() {
+                return id;
+            }
+        }
+
+        // SAFETY: `bindings::is_of_node` checks `fwnode` before accessing `fwnode->ops`,
+        // and only compares it with the address of `of_fwnode_ops`.
+        if unsafe { bindings::is_of_node(fwnode) } {
+            let id = Self::of_id_info(dev);
+
+            if id.is_some() {
+                return id;
+            }
         }
 
         None
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index fd4a494f30e8..3cc9fe6ccfcf 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,6 +5,7 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
+    acpi,
     bindings, device, driver,
     error::{to_result, Result},
     of,
@@ -95,6 +96,10 @@ impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
         T::OF_ID_TABLE
     }
+
+    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
+        None
+    }
 }
 
 /// Declares a kernel module that exposes a single platform driver.
-- 
2.43.0


