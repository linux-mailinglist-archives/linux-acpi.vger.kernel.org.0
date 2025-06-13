Return-Path: <linux-acpi+bounces-14320-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1800DAD8D38
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 15:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130F7189F911
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D97158DD4;
	Fri, 13 Jun 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvuoxziV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2D15B0EF;
	Fri, 13 Jun 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821861; cv=none; b=DDvuHSYpEYoq9zDFHls5n3OValqXctQkCEbUFMEZakAUn/mD6TDGXTrir/2r2/kErw82I32KzoSkGS1bbTb6pFY/YXlN+2XTUYQWJRk/+VpOkQ/wbMBRqP5XjNrtO/FgRM245wCSWc2Cyey2Wj5Y+UQbKiFoQVHotm3KREVX578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821861; c=relaxed/simple;
	bh=1WD1jj5PlSIXON2dAf/X3+A1XrTksu+aG8VctVQYa/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAGzGz5OjKpHuYheb/7NeoZI7rEeIL2nfA/tv24m7QubCKobzJQrXdQy5NKpK8G4wVinK9x8PNqeFYbYzSTRV0zYosW53KuMpKUt34JsuauLVHoy9dPOQbgO7BeKVF+ja9CqYuXtqGCthtALGRiaDYg1dcgzIfgH2AKaLjVIspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvuoxziV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442f9043f56so12545035e9.0;
        Fri, 13 Jun 2025 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749821857; x=1750426657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ewdpFu+JUq9oZpU5NEM0XWzWun+XanrMGmzqVHwgcFM=;
        b=dvuoxziVlM9gBijmzxBo+aQc0OK/j34gVFAg5soluXPY0bwthzz77RKt9qCMCb0vhV
         TBfUXPipjnLiakaTR7vZmeGXs4ihG5PJG2x/t+q/cEfzOXhmWwi/d7x7wjT9uKmkXCN/
         zt5T+U1iV+uomHTRLH8STdWwKZEBRig+zPeX6ebf41hKtRGQ/hO3EGIYa1zqeLolktLh
         3zpSVehnrAA9ek91fMPKVKcuF/x61JjLoWxybFVbeU+UbL3n5zAy6M89A5gJVxoADpqk
         IfJIRcxYfErqshfuwd9skHiy7H/kQFob2VwEK/Sxxcc8B5OU+22MabJuv62SS5YjRnzw
         0oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749821857; x=1750426657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewdpFu+JUq9oZpU5NEM0XWzWun+XanrMGmzqVHwgcFM=;
        b=l5lnVocY1/9EArObu2NJHzvrTXcQhm3Y+PZaforwe2MmykqCRoJWsFmTqnjs81v0MS
         gCShs3u3iqNlahL3mwQIvyMfHuKVfLfCIr5TIzICsCmHey0yTcv/IOsEL2KPRcjfXEvn
         rzLROsh6BXX4bAFdModLrLT0NJxnBnwJ37KN61n4ti2uoLsGjJsyHHGnoXW8R6TGpP1h
         rTotAYYqRSYtKmGPEvOCMHSZQH5GCmdSBmg8mZCMgWFj+5MevaZbDk//T5K2UY4YhvIx
         6AmMcQ/0ulHsjQi3oi40NrbQ1V09JQmIezG4/Ks0zLXnei/Xj9rLcnoM0B8d7WmtB6pu
         p5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU9SjVjrKOe0gv9jJP3+ey9+zypm5GZ/AGhE7zfvG2w9+/+GcJY9HY4uHY62KgwjZ/tB8ZvPbVYkkxG8kGD@vger.kernel.org, AJvYcCVQ/F07TxRK6OzHIE/Ufsq9ZzkdJWhEpq7s5y22AGtwmWUc5LiP1h1rZeGjwJWgsowj6XCbmdrZnZSIXt/oI3k=@vger.kernel.org, AJvYcCWPkwmbe783OEJ422f0Y7FlYk/yGjyOzuRBVBIGuITncwYxifN0X+dtONBOcXdqKbbEJdQ5IDpDOIcv@vger.kernel.org
X-Gm-Message-State: AOJu0YxwV7SxSni1NQNR6R8Yk3mjMlnir9H552S2rFljpuQYS08SroZY
	mgH7C0XilKEYFUIH62pu+QancROob3g+V1Xg8UEfdKJ7lrtVQYLy9VlC
X-Gm-Gg: ASbGnct0d3GWvmLyhlVL5tbg3TpT3eFSCSoG+9B3CQy49ktTXuFDRkPEJ0nvYdU84EL
	x1ToQPgbzFf5/2+XJnH/nQWNWjcaX+8utMB9xyNjuIL4NuK8ogs1o8LiyQq25JdkwduE6t8SiG8
	yrIQRBCZ8J/b/zyR7PNODKeju/GxOY3EfXwqjLKOCu8mxkQ1jESsA8h+d/SW6aKOoFKqFR9p2JC
	kMEn6gYI+CONoTcbD1MbGpKa8KVCXIkZJKIwpsPV3WpGeqwDEo7J3D3J7rP2WzN+1ThFnJX14R1
	hhRg+pQbbokElP9Sr5pkekTARpnmaBax0XUT2VZiX38xRW0cqOV8aXSxDy1PH7Fe4OE2Xz8cykO
	xAz08lVejGvE53zNuKpCKydxOOxhZUzBJOUqP
X-Google-Smtp-Source: AGHT+IGVcSD1mQg3mpoyjCkfH4RAG1TUXktirt1za44bnqpVSTvX7FY8Nn1swXT0r2wVHVp5+qXzSQ==
X-Received: by 2002:a05:600c:3d97:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-45334b07fe9mr31150995e9.33.1749821856990;
        Fri, 13 Jun 2025 06:37:36 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13c19esm52865445e9.25.2025.06.13.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:37:36 -0700 (PDT)
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
Subject: [PATCH v6 0/6] rust: Add ACPI match table support for Rust drivers
Date: Fri, 13 Jun 2025 14:35:17 +0100
Message-ID: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for ACPI match tables in Rust 
drivers.

Currently, Rust abstractions support only Open Firmware (OF) device 
matching. This series extends the driver model to support ACPI-based 
matching, enabling Rust drivers to bind to ACPI-described devices.

Changes include:
  - A new `acpi::DeviceId` abstraction for working with 
   `struct acpi_device_id`.
  - Updates to the core `Adapter` trait and `platform::Driver` to support
    optional ACPI ID tables.
  - A sample implementation in the Rust platform driver, demonstrating 
    multi-bus matching.

This is especially useful for writing drivers that work across platforms 
using both OF and ACPI.

Tested using QEMU with a custom SSDT that creates an ACPI device matching
the sample Rust platform driver.

Igor Korotin (6):
  rust: acpi: add `acpi::DeviceId` abstraction
  rust: driver: Consolidate `Adapter::of_id_info` methods using `#[cfg]`
  rust: driver: Add ACPI id table support to Adapter trait
  rust: platform: Set `OF_ID_TABLE` default to `None` in `Driver` trait
  rust: platform: Add ACPI match table support to `Driver` trait
  samples: rust: add ACPI match table example to platform driver

Changelog
---------
v6:
 - Moved set `Driver::OF_ID_TABLE` default to `None` to a separate commit 
 - Removed out of scope change related to cpufreq driver.
 - Link to v5: https://lore.kernel.org/rust-for-linux/20250611174034.801460-1-igor.korotin.linux@gmail.com/
v5:
 - Got rid of unnecessary consolidation of `Adapter::acpi_id_info` methods.
   Instead, firstly made consolidation of `Adapter::of_id_info`, then
   `Adapter::acpi_id_info` is added using the same pattern. 
 - Set `Adapter::OF_ID_TABLE` and `Adapter::ACPI_ID_TABLE` as None by 
   default. 
 - Removed `Adapter::OF_ID_TABLE`/`Adapter::ACPI_ID_TABLE` initialization
   example due to irrelevance.
 - Removed extra `of` dependency and `Adapter::OF_ID_TABLE` initialization 
   in cpufreq driver.
 - Link to v4: https://lore.kernel.org/rust-for-linux/20250610145234.235005-1-igor.korotin.linux@gmail.com/
v4:
 - Fixed code example for `trait Adapter` in platform.rs 
 - Fixed driver implementation example in rust_driver_platform.rs and moved
   it to `trait Adapter` in platform.rs per Danilo Krummrich's suggestion.
 - Consolidated `Adapter::of_id_info` and `Adapter::acpi_id_info` methods using
   `#[cfg]` per Benno Lossin's suggestion.
 - Link to v3: https://lore.kernel.org/rust-for-linux/20250606170341.3880941-1-igor.korotin.linux@gmail.com/
v3:
 - Removed fwnode type check in `Adapter::id_info` per Greg's and Danilo's
   comments
 - Removed `is_of_node` rust helper, due to unnecessity. 
 - Fixed example code in `rust_driver_platform.rs` per Danilo's comment
 - Added an instruction of testing ACPI using QEMU with a custom SSDT
 - Fixed minor code formatting issues.
 - Link to v2: https://lore.kernel.org/rust-for-linux/20250605161956.3658374-1-igor.korotin.linux@gmail.com/
v2:
 - Removed misleading comment in `acpi::DeviceID` implementation. 
 - Removed unnecessary casting in `acpi::DeviceID::new`.
 - Moved `pub mod acpi` to correct alphabetical position in `rust/kernel/lib.rs`.
 - Link to v1: https://lore.kernel.org/rust-for-linux/20250530123815.1766726-1-igor.korotin.linux@gmail.com/

 MAINTAINERS                          |  1 +
 rust/bindings/bindings_helper.h      |  1 +
 rust/kernel/acpi.rs                  | 61 +++++++++++++++++++++
 rust/kernel/driver.rs                | 81 +++++++++++++++++++++-------
 rust/kernel/lib.rs                   |  1 +
 rust/kernel/platform.rs              | 29 ++++++++--
 samples/rust/rust_driver_platform.rs | 71 +++++++++++++++++++++++-
 7 files changed, 221 insertions(+), 24 deletions(-)
 create mode 100644 rust/kernel/acpi.rs


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.43.0


