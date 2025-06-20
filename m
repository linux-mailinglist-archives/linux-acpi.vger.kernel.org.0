Return-Path: <linux-acpi+bounces-14486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC68AE1F51
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D47517E4FE
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64F2EA494;
	Fri, 20 Jun 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oos1hSQm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67952E763C;
	Fri, 20 Jun 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434340; cv=none; b=NnWMfv9uqAn3A74WPpRSWUDb0bkP3ub0ezahdabSdLjeUzGlq8YgjNQhj/halTEHA18fRnGc+SLlOSsAfRyLAumDerf0GAT3gjOeKhOPj4RlncyzuB0+ZrPhLm42qu9rLx+PFCLQ+5WSGMEvkcDLSzvBhwftpSzyH8FKCYNt554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434340; c=relaxed/simple;
	bh=fCZg+qa6/P+Asbd0KRfxqaW80M7dwYJ1XuU8KBHp+rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw1HrWcN2wXsQdMrJPz6Wvej7FAo+MU4h7CzU1fZ+UnNZQmk8UyGiuxSo1c1Je++gfXgBPFrs0/LbVgo8mXg5HWS2bx0udQsocb7Zgxr5jfTSE52NpU+i2TdCGcHtfZtpgM2HkraxymaBn1Dq1xZMIhxtzbItTjmnTGi8o/9pGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oos1hSQm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d54214adso15157165e9.3;
        Fri, 20 Jun 2025 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750434337; x=1751039137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKJ+35t8HG4O3r9CAZlhOHv1jc/h4zjJpE9N6VOcuWY=;
        b=Oos1hSQmL3OFjFa45TXg9QQlZ1ny/4S0FXwRelAY8qKVvBx4ppwtOroYVLCLw2AIv0
         /9gSVrkE7T7eV5PD591ENT6tST24QSUs1ePcem1Ay322kMVXzLUhAn2s6GtYJtOVTLMy
         WUAJMyCZeJQn2dTPdfyEN05CA1hned80a+auoEXBSErAgIuoVBXdutqTpXhQzGCDElYK
         cgRg3QEAwdozWYtw7PwBygCdBMAUQY6vvhoLidpgMJf0L4d1fnyzOGG1EMelBPRe5ynE
         eDdNLT+mNcNQT8CzbPwILMFelX5YX3Hzq/fN7UxOhe7K4lJoCpDzATeR/ck6vewjjRjz
         fyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434337; x=1751039137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKJ+35t8HG4O3r9CAZlhOHv1jc/h4zjJpE9N6VOcuWY=;
        b=sHCR+nVyNJjdBN+jFMumCjKs8Sqfwv8L2UtX8rQvuZ2IuSue1buOEf4C0tfbau42Xi
         4WMkKmyhpguPVSlU+4n55lwX7ReGGCrdeUnq2fM505+GL7fzjhlOFv+RZRNa2ELGa660
         J2Ax8E9obL/+nlkGuYmJja6k9BN7BcPDG78+M1JGo92nzBj7L31wQOtkzCERTzqT1mrf
         QnDcd4jNGEqRusgx5YtCI279oBJwYWuLMFjkV6Vun9R0F6LAAwn4pdAM+iySsPClaK9U
         UrMbZv+aO1yd8gyFOVZdaEvFm2twjabmmqgKHLZtT87nT4IXFcD7R8mPDlbttxkYPusK
         iUMw==
X-Forwarded-Encrypted: i=1; AJvYcCVIuBYKJMj7GB8GidO0zaJ62y++VRLiNa8f2sGgUo8VeauQWtf8nU5M5rubjYAWUYjHLFpaiP0nldd1+sM1@vger.kernel.org, AJvYcCWDc2BXFxLB/ZOP799DKInUn2GmA4MIoJRZRriAAvAeAvCmQUzLXCs5cqWgNRqohsLwT2XfGxwJYpS+@vger.kernel.org, AJvYcCXJHhjcoiXMFQWYdrLqOp0zXhTVd8scTJQTxShHQhaRa4ftaUBR9Eh0BHZD9haQkQiEmPhY+y+ACxhFUPVhk34=@vger.kernel.org, AJvYcCXUsimV84OrPqc/Vp7qFYwDCq21KsWKz5q02F2V4BXrDeq2DuEXHfX7vqzrZMSEWyPJIdXrsopk9lHQkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OO4VkDigmHyQsbpBdHYKngCgZqln49cku1mirBoToeTsoz37
	BRQz8r47dMqSAWrLa57I5hmdE9ptlBkbfnGkaeFERIqLuqqnJzGJ5UTC
X-Gm-Gg: ASbGncsQSTw/Xha0dCid/INaZvlTceyojVSTetNlViut2HeiJ3R8FSciaYdYCSptKvN
	SCNwwigOAXxXHaQrOPdJsiCkDoTTSUrLjVHHCADbBPqy6wMfm8l51eGO35DuwEhlnAxAoCGpygl
	erncvLMiogu9Y2lS4qSgFDN4Y5UbrU95ZcYtku4R65AAASQxohxasx4XtxdOikUUNvsW0j3DLlo
	Tisy8ZMkvzrcScj43VZffVopqpZwdchERPGaGOIumxyfRaeBWOljpCh/cK60XheCZFGKp2cG1Z6
	bDiNghc8QxP/rNWbYmDxlh+y0ikb6bHjehcjKlO6Kb57GQxw1ovNhA45235FJzj0sL/8yzIWxhv
	Vr+fRtqYQbc7NTF0aL1khiIuCvmmTtBqin3Ar
X-Google-Smtp-Source: AGHT+IH2C53yc23XxCYNlV8ObdMQtnKhsc1hQMOEdirQJq6qRcmhyC9b16FY1hfzZAuThldE6PXaFQ==
X-Received: by 2002:a05:600c:c103:b0:43d:24d:bbe2 with SMTP id 5b1f17b1804b1-45368780588mr10681265e9.28.1750434336707;
        Fri, 20 Jun 2025 08:45:36 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f19e7dsm2478995f8f.38.2025.06.20.08.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:45:35 -0700 (PDT)
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
Subject: [PATCH v8 8/9] rust: platform: Add ACPI match table support to `Driver` trait
Date: Fri, 20 Jun 2025 16:43:34 +0100
Message-ID: <20250620154334.298320-1-igor.korotin.linux@gmail.com>
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

Extend the `platform::Driver` trait to support ACPI device matching by
adding the `ACPI_ID_TABLE` constant.

This allows Rust platform drivers to define ACPI match tables alongside
their existing OF match tables. These changes mirror the existing OF
support and allow Rust platform drivers to match devices based on ACPI
identifiers.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/platform.rs | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 2436f55b579b..0d00ab9acef7 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -37,12 +37,18 @@ unsafe fn register(
             None => core::ptr::null(),
         };
 
+        let acpi_table = match T::ACPI_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
         // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
         unsafe {
             (*pdrv.get()).driver.name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
+            (*pdrv.get()).driver.acpi_match_table = acpi_table;
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
@@ -96,7 +102,7 @@ fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
     }
 
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
-        None
+        T::ACPI_ID_TABLE
     }
 }
 
@@ -127,7 +133,7 @@ macro_rules! module_platform_driver {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, c_str, device::Core, of, platform};
+/// # use kernel::{acpi, bindings, c_str, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -140,9 +146,19 @@ macro_rules! module_platform_driver {
 ///     ]
 /// );
 ///
+/// kernel::acpi_device_table!(
+///     ACPI_TABLE,
+///     MODULE_ACPI_TABLE,
+///     <MyDriver as platform::Driver>::IdInfo,
+///     [
+///         (acpi::DeviceId::new(b"TST0001"), ())
+///     ]
+/// );
+///
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
 ///     fn probe(
 ///         _pdev: &platform::Device<Core>,
@@ -164,6 +180,9 @@ pub trait Driver: Send {
     /// The table of OF device ids supported by the driver.
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 
+    /// The table of ACPI device ids supported by the driver.
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
-- 
2.43.0


