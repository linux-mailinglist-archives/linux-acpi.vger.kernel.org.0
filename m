Return-Path: <linux-acpi+bounces-14163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD81ACF4AA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 18:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D077AB96F
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72B32750E9;
	Thu,  5 Jun 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cf3LkkBz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sonic314-20.consmr.mail.ne1.yahoo.com (sonic314-20.consmr.mail.ne1.yahoo.com [66.163.189.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C217274FFE
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jun 2025 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142076; cv=none; b=Jj6LMhfORwDC8wIY7l5hN7xfVLm68GtxU7YaKemajCgTCqlYGithbPsZtsNx2D2KitJNPQT58QLOqoY6OCl+XRAKVbSxzl/cyxRwDZZ3apy3vZVa9QRPTiT0gm6IPbNs0NEsFj7nZxk/UDyKt+PZhDNVjrWUmpqXG3qgy1rusrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142076; c=relaxed/simple;
	bh=Se4lCUBfbvGUn11s4S6E/U27wBzXoxFTAw4Zl9wtOuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLRfOGqdiI7ctT2L6miscPvvig9Or0ZZVdL8OYZOeTse9mTk0cJsPP1KP56QSob1EieKHAOVBcm+bxiwjAYkIR+rBSCk2rgPTtzLv9LeVlFEGomafHuHMOip5mQ4TPLCGf3p4YxD08O8JriLR45sF1nFR8Tkc3fBoVT/fUotwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cf3LkkBz; arc=none smtp.client-ip=66.163.189.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749142068; bh=S9xyrmw89L7efj2UYVH5a+PMETFLh/nhQ4bVH6JaxCo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cf3LkkBzgxP6OF7krUZv7prVC2Pv4cnC6O1P7htqwhspsnZfS0XtFFc33me3vIMbcZbJVS3ge+KXOGBHcLOVe/jdi5uHJmf0NyCJiu4ydDYBuaL5cWkSWav3aEpV1NsJETmAsZcB5Sy0KoOw1hLppowdJG6WOjZNb8wRzQG83w+gY9XJ96+0GeRRGyP/6mGiv98OBwDvRTM6gpWHvobulmpX0vhOG0dV2Y1y0unng8r9uRUvn4xBuNmHqhJqnjPDVOgFs6e9REi4+mopibgXzBQLNy+YUqnF4DvF6tQpTvX9EOv0h2/b1mNyO2vEc7C/9cH/26+3V5CmJSqafIV4ZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749142068; bh=HomjqXZteuJnRzPw207/kh963/FTH6pgqj1vsX57Kly=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BtXLVAV3zL1Nmj8nY2UYiNRd4E0ZWV7X08991InX54rZgVBJs+zXbscAVaPsSht73iK7+DxGAFX9qTqqk1ylhpVQTwSKkrAZZNhNcJhh/BGcnUi9eNt72CM2LOIPtqbUEwATeEmSmm2vfSjbFIqf6j5icTqwyz0Q28iRe2qGzGWEpnCDo+OvzIknAmdkakaxeu6uyfu6UHTEs/vBaeA5vT/mNwaUFhmxL8uj6WPBbzarC4R15b1HiUOubOB4HdPhVwu9oBdFM2f84WxXb5uN2k62XXPxPHfXpqb+xKm+ffn81IrQ698VckOSN6RvINli4NYHeMwxFRayWwaOiAPPkg==
X-YMail-OSG: QFNIsLEVM1mqoF7iwn5REm71RGrFrfpkmo.PUXNRvSpoz6r1XVdmfQmkwLrXD3Q
 RX_ivAtcyUkxFRJJnvOADjvekpEoOgbvNWgl4KTu56TxvIZdG34nbVhwpBYo36F2Q3sXzjQANiV2
 LIz0anEhqJNZpopYEWNnjKkh9fuRJuZM405cASisd.RIrjSrqXNS6EQnq.0yP.OrIpcbqs5z1Xav
 ZBvDQK0QXp0sVadLK.nMXLC.6qr4w2ypbWkLQ__u5d9LcS0MDcOnWpr8bB.gzmH.YkkWny12Hk_s
 GkeC0Zt8iuUW7MK8A5mt8U0R.cIgKiH0wxM4NdLkH_dy0HirMbTCibcW.8lw1NCNtsh6U_M.MkAS
 N_i9lIwIkOuspdve.NzGBn6JnWcxWR4b0aPZ7C4LPuAfi9.e0Dy2WdG6rQnbUjq_D5.K_x8k5JAW
 qvpeSUs2S7VN9lB00UlDnLbJcYECgiExS3CrvYVqbREMTNkloSLKMZpSjNkee8saXM8WkJmWhOeL
 Iy9hvSGFDMbv6zZyfvc8x2EP5_zShrGaOEk9pJ3eIReeGyQwFCWiycWYevvuo8lKASg8fwjAzNtg
 onQSx8Q_4HcwfHI551Pvz9osMHiRoXi4TyH3joqA2FEPzlXkns2PmW2LLyzVX0Vuy880xTOjT1Y3
 BE.5Ke7fjzIc9a1Z86_fJVJw5IbKoBTwLF3VtIF0pEcdFOuPtrYL7sW9_VcKC_f8X6ek3vgoSx_y
 wrh1z1ZsYFrolRguzm7SWlnO_rzfWeAAhE_kBkS3A2wHiVXXsoXXqDFgU9cPrwTwGFW0UTsobBg0
 9kDh.UjeOe5YGf_vbIdfxs5mXB0wdA8a.xKZWxOiDoaWpgPKgZMWb4rpcfiB6fyhUJLxz2AqEMe8
 TVNFmKHgPPkv0I6piIAkkIzijt72B94ADS.520wZWmpe7Yi9QeB3xdwl92vgxkWL9g7OIa16GVzk
 TvFyAlZdMPpUMC2Fq0Kb9yXE6UF01jQ1ThJsC_Kfu_UjEYbZfYIR6nDfiVhQBxHjIP9SGO3OYVli
 u8PcNYPMu0HKhaE6yJIqa_S.Y0ncBSpFczMAyWSa_tkrfTvKa5XXF.k_XTvss3CzoLkfNcgQP86l
 1UEabv_QOkYDaHZr49BBwacHA0jP_bNh9e0gPdJyLz2wjvvx7EmD.lHLLoaqdHhTIZkPjZBzbmn_
 NxYs96oHCfXsqQWa3yXCkX89ggkaubvv2KNPGk_oH350skRyTYz.X.E51PtVHmF2aDO.1rL3uEud
 RyIyGFE35yRU0v96iu7f0hSKHPmjj1yRJiYtihtKkJ6S4_GZ2W5bcFnJnvMBbZnVIxwEar.oFO_b
 BC0yy6khmGqymWTIy_8QOn23COpxMyJDGRdUQ89cBCtDePNtZWwT_W9UOhoq1XyQbhG5ey9xMuv6
 mROMsztHB.9sForSjzDAdgm.Fu8dh0aMxTPiWZtG6nI0NqQckC4ve5dl5abJSF3BFLaoGQXB5lX2
 tJ7K0jMq3bfxqXWvMbJjcCCx3FGX6yIPJPHenoVkZtZn8m1ud1G1zlj2xBmXc_7RHQ_MY.kk7ec2
 RV2FTnlkIKpIkWCGPlypPfWhtI0UCvPHaXYYESLe20AlRZj7MbVZ7QZoyDPe0XNqKMC_MMrAves0
 XIqk_f8p0DzT4YYAqxfTddQ35_UUcJfBOJYEjeCUOYSHOqm_eAB4rJZiSfu.ucmw6yZPB5CZk7Kf
 KwYtjuayJmOwkfORE4_LlC2qhF0SXqPiwmnRoiX2K5WpRgrTdt.DM4eRsfARLU093YmB9oLS2nJi
 oWP_by4C.mCWXg_XF4prul58qAxA4PP0zzqrlxEs0MDSvqs6PRTauFD6lRq1NLkvrMDrTvhzkCIw
 PR5wrkLDbJC91jHQh9dZev97yKbavrtoFuS2ez5sPNR5VO_qTNzxrfXFjijeQkSXjEil.4sVP65h
 KZe76DbFvzHMQu2vW92GRhQ5GSasXoWrjcHsMcX3EAqFjnI2mJSeucnFxHAdcVESo8cnWavonaZm
 b3E_yzClCuY5Ea0b2kBmDRds5qwG_tD5n56EZbxxlyeZG4SMahjnENhjOaDEpZfKNgB8DTh8Rru0
 ewdaqImohahTlrZarj1g0wSKQD3.5l0LrwD_FS5Xusqdqgd3Y6yFZrJXz7pulvTmKsd9hV5cbgF_
 ieljg_4C8pYcsGs9.QwWlkybJN9.Bd16izDwSHQMlbuhlxcKqtEz8hSGdwscw4Hjsz7TDQDVkT1I
 3CH.1kNwYXviPicTUzdJWL.pvfXLfxFClgQD.3b1L9Ps.m6E0GJk1NT5oGJP_KFjom7Q83GE407X
 FGGr.Afo-
X-Sonic-MF: <igor.korotin@yahoo.com>
X-Sonic-ID: a01551b3-4643-4ab3-9acf-f5730c6599c7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Jun 2025 16:47:48 +0000
Received: by hermes--production-ir2-858bd4ff7b-rsjdf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d1e6bdcafa85f1c72d86546e65fd43d;
          Thu, 05 Jun 2025 16:27:31 +0000 (UTC)
From: Igor Korotin <igor.korotin@yahoo.com>
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
Date: Thu,  5 Jun 2025 17:27:26 +0100
Message-ID: <20250605162726.3659792-1-igor.korotin@yahoo.com>
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

From: Igor Korotin <igor.korotin.linux@gmail.com>

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


