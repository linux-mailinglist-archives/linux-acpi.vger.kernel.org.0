Return-Path: <linux-acpi+bounces-14434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A06ADE826
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869ED7A5570
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A7E29DB8F;
	Wed, 18 Jun 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQGmoPYw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5E296153;
	Wed, 18 Jun 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241081; cv=none; b=TeV9Q37MivG9eJDQKhPWDZRKFDHBkO8UOGSP+OceJbQ79oqEMeRYiuvMwtbTUq9pGTHKXxo6dWfA2VJJ/WQYJB+pihZlP7nWP8BsZ7DIbbqrU3NGw4mWg5VIWgp89wAHu0B/og0vckEEGAcy9bjgeL0Okl6aaaEWxqXRG9QX1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241081; c=relaxed/simple;
	bh=m6cTzl15Gzmvo4GBPCi+25M/GblYyw4j8kZYb6v7v+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M6CtPA9Bma2sFNQyuCKEb6FWdAcsbPxdveIWpAeS26w7VqGlU0m+P5+lACE37BZczH8R/ffbNnG+K9JSRQ5M5KNMGAA1Tc0mE4Nze3hmb07vS3EAmrWsl/+OhtTG0NZ/g4pdoqHd3kjvbRZ5gy1U6ZQOKKtJfQ7/V/cBLpE960Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQGmoPYw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so4131349f8f.3;
        Wed, 18 Jun 2025 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750241077; x=1750845877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cTgK4oiuA8WvDKr+6YArL7F7kHsl+YqCkp5AU61fnZc=;
        b=YQGmoPYwnwk2nBEjBSdfhKflX2syb+Z/7nlFZLTtlTv+qHBNXoc3V0jx2oVURRwP7l
         D/uJqFdVEHMrMicZZcqXi+lkkkf18NBOqnkZ61C40nhQPkaNba7NHHQHilHx7yo529Gx
         EYpU/I7VZS88wxAvEktnfJB0iFpfdpW1TnNmRsZbFiXxgM81XxOGJY72yhPqq/sBhpJX
         TxKarcxgvLMvXJHXx4Icrrdv1IhCwp4envmCWet6W6rMZlr4UxMLRkFarSHY6MpmkLAq
         bAhwjdUmO1XYpcnCyQd6V9YHDV550WhTGochTsmHYYXww+oA9IFtptpwao8CBfybzzSA
         M/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750241077; x=1750845877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTgK4oiuA8WvDKr+6YArL7F7kHsl+YqCkp5AU61fnZc=;
        b=nvZ/b3TEsl8QQE+bCdqNhMz+IsnEXVw+8giu54y5PQwhwrujhzBxpw6L0dCKCIoBsR
         M7VRfLGhrIJMUEnSR6NM53vK0Iq9HrMfiXK/1LDn8CyMOwgUBK5HIPPCbU73YJofKUh+
         ixE4zXTAuoTdp+WFNarf90s+ynLggnV/HdAANX/am7YsoPgl8dTP1uCEx4YJfe5JQUF0
         oWj2TrE0DCZbcy6NMv0aJHvMqp2v8LeHsbXvWyt4np0OlCZPp9+oF2kk8A9anCTJmQko
         LBKFs2vDXdaYtXTGQqFRowDrT1fcPXzE4JvRwK5vOs+88llvDhcoJZg9JM7UdWOo3uyD
         hZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGz0tkOkT3Nvb5xCK/YDgTJ4IW6TJtujCNzN9fWrmDZ6mBmboUiQTu3uNNlVU3w4QiRHaprV9dAL+7b7xO@vger.kernel.org, AJvYcCWTftJQrSfmGMesnVklBVbC5mHe7+h6lSY5WN3gJtKq/JrjLEEQBHKVgO5bZhFE2F5U+Zg+Gm1yDnKWEpfFoyg=@vger.kernel.org, AJvYcCWb6wOe2B2E7W4/AOUw9MZXwNGHc0XELrVESaREBSU+cUWFAztIflVHMtzyiBcq7HPWtfyI3i0g/A26@vger.kernel.org
X-Gm-Message-State: AOJu0YywBFjQjZPH5RBBvSOicDNNDdzTS5bnvsJ+Ut4ZqH4sov3softQ
	Cr4d2fMYiH483ln0GcyLlbuVX9GnAlBard3UUC7zq6TINs9U2VDNxnNK
X-Gm-Gg: ASbGncuof52iDjsZMUSTEVdyLcyJ4FRFV+Glf8SlfffCkcrS4P6sTgNZgg5kZPxIkxr
	Pk69kUylC6QJP8VS+CiuH4AlMFEopX/gksY1BmDquypbuI5Trij2l6y2ysxNseeezbXo+fPUbNS
	BRNWvs9XJFEHgwLWdghYxdbP+Qvq/yNAXPrzl/QY9k4ityP+a3toWND2rd1hr8gl+u6RPdWHJDy
	W5tckiHeu4bHip82gKRFGOluwcdjf6b0MdKZAJsRivTRlXqDjtmYeCp6HuwEvy+dXBSe5sDcpSa
	Sz6XpBfQqUywJCHiV293FV6bHl5k3+9hV1yMghyLltz7kgngY/jQ6pC4aBOHcpS5WhnhKAc6RxI
	SFS/BXhIznOJrHc1R9ayG0gjhZN9d5MH5YOPXaZ8=
X-Google-Smtp-Source: AGHT+IHKE1KsApyZ3jJoPJ7YWhXAxEFJ2ntRfYhmrTl91c8B+E7DhkRUqnrlt+jet9w5FT6nRopZ4g==
X-Received: by 2002:a05:6000:1a88:b0:3a5:2182:bce2 with SMTP id ffacd0b85a97d-3a5723a2928mr13880244f8f.17.1750241076566;
        Wed, 18 Jun 2025 03:04:36 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25302dsm195480495e9.26.2025.06.18.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:04:35 -0700 (PDT)
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
Subject: [PATCH v7 0/9] rust: Add ACPI match table support for Rust drivers
Date: Wed, 18 Jun 2025 11:02:17 +0100
Message-ID: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series is based on three patches by Danilo Krummrich, which 
introduce general improvements to the Rust platform driver. These patches 
re included unchanged at the beginning of the series for completeness, as 
they are required for the ACPI integration.

Danilo Krummrich (3):
  rust: device: implement FwNode::is_compatible()
  samples: rust: platform: don't call as_ref() repeatedly
  samples: rust: platform: conditionally call Self::properties_parse()

Igor Korotin (6):
  rust: acpi: add `acpi::DeviceId` abstraction
  rust: driver: Consolidate `Adapter::of_id_info` methods using `#[cfg]`
  rust: driver: Add ACPI id table support to Adapter trait
  rust: platform: Set `OF_ID_TABLE` default to `None` in `Driver` trait
  rust: platform: Add ACPI match table support to `Driver` trait
  samples: rust: add ACPI match table example to platform driver

Changelog
---------
v7:
 - Rebased onto the driver-core-next branch
 - Incorporated three of Danilo’s upstream patches as a base
 - Switched from `assert!` to `build_assert!` in `acpi::DeviceId::new` 
   for compile-time checks
 - Renamed the sample ACPI HID to `TST0001`
 - Moved the ACPI test instructions into the module’s top-level 
   documentation comment
 - Link to v6: https://lore.kernel.org/rust-for-linux/20250613133517.1229722-1-igor.korotin.linux@gmail.com/
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
 rust/helpers/property.c              |  6 ++
 rust/kernel/acpi.rs                  | 60 ++++++++++++++++++++
 rust/kernel/device/property.rs       |  9 +++
 rust/kernel/driver.rs                | 81 ++++++++++++++++++++-------
 rust/kernel/lib.rs                   |  1 +
 rust/kernel/platform.rs              | 29 +++++++++-
 samples/rust/rust_driver_platform.rs | 83 ++++++++++++++++++++++++++--
 9 files changed, 244 insertions(+), 27 deletions(-)
 create mode 100644 rust/kernel/acpi.rs


base-commit: 2a1ea59de83bf367215e2a4dd9bf8bbd061349b3
-- 
2.43.0


