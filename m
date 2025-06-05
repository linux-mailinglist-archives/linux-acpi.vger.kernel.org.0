Return-Path: <linux-acpi+bounces-14160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3460ACF417
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 18:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5AE189A86C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9FE211299;
	Thu,  5 Jun 2025 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKRjHVlX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F3B1E5B7D;
	Thu,  5 Jun 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140535; cv=none; b=pC7RZktvfJA64yT93katQ5qDdLg0/O4B7M8FqgcFM5xOP4wX/8Oap4ikmPkBgXsaCsb0lZUPdPV6U0/5Kbmtz84J3vg6a1gkk4lVYu/9RNiwuGT1BYQkTiGVe4kHMPhZlT+kB4Db8qUHO4iVNIHsIppkEjKNRpxlA89V37MQwoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140535; c=relaxed/simple;
	bh=WOEAx/OuSA6ujJIrMf+xRi70l3LrT+6XGNIYC00yoYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7imois8n1J0DFacpqVS3rwSTNIhHbPZuUwpyHyuuvONlDQARPQ+A6kZkGGJxoQ8sl7aQPsM38o8KoLmy7zJIIuQDblUo4du5xtEnna50///+1UkBrpn6GWGlY3aFTXhUjvewMGvrIK+5eSxZqnzKejx+1kbmUANph7yYfjNvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKRjHVlX; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-451d3f72391so14480955e9.3;
        Thu, 05 Jun 2025 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140531; x=1749745331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LY3Zmm9CwcbsqE728Ul4F6AXczl5eGOeRnNMCNxXAoY=;
        b=HKRjHVlX0FJ2S65FHKl6MC/HmxSipJZoyPSPTAfZds4XrLNBLqhslT/MkeWYzmRyMx
         7QFkuW8WLQvV9kzpFZ8x5Bm3V+SiUa4D4EiqBaMx7TSarCquZI/W+8hQ1fvjPhZAOEGp
         ZG0wK9sVule0sVJreWgXJWvNlO2bK/jPkN+mnZv2C1eynWBtPrzLbrCSOWloqKrhMLCO
         Heeq+4F9b/c95eCCMI89eUMgHnNqIBVK98jUqYOomm9RF1cyczTfp0j3CjLiCi562YQ2
         ji4RM45UIeBrM+9SBuSA1H7mvMu6JdWu/rvOW5iB1eMXeykqVy5QGxH/k1B/vHArA/de
         aKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140531; x=1749745331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LY3Zmm9CwcbsqE728Ul4F6AXczl5eGOeRnNMCNxXAoY=;
        b=ikbqEaatKC6ovS7iwJze+IOPLOApmLSOxC0COTrzBu2SWPEdQXIWeqK//P+dTpbyV3
         emvfwlyh4XkOYL42YOJOY8GBVQcgc7n8J3gBLCUZ7usVGwW2VmXc5LnVmCO8Yv4OHPXY
         TWkGtN7acmkIjG4y3W2PqPQLrMXuoD15mWBEc/Z47vf61SbDfyUaa/T/3Rf+vv4XUtNh
         ADrFhcEcftIHESy2OV8V+vxh+NXTEtanM6MNgtvGis/SgQ21eDTc0uzvGbCQHR18GMHH
         Jy6GXoLpXNQ3hF+UzPNu3bxXr+kQ98U4r94vRUUooTJ8xBhSoluiQoQ7WCYjJzSOI/fv
         WkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5/5jh8NVgmcSoY4mXoy7FFJCXn7H8V8E+pT/fyGwRg88hIzweCUsAH8FL5V498tWnUjtURrNPS+oTug==@vger.kernel.org, AJvYcCVJsR0MDu3uOsWLwb0INcYIL5Y8WQco/JZYBkWa8bkizNT9dISZipAgUBuqPGTtOhnIAuOPZXwonU3Imn6WdbQ=@vger.kernel.org, AJvYcCXDUtGGBo0+r61qmcHfAXbJgulM7FyJ5pAAAQKLlteUTmWUxRJHrBmNMw9BEmrYPyNIqGZpxLKOq7cL@vger.kernel.org, AJvYcCXj0emg7DaKm6T/z8BI1CzdVtgAj8zuEjbvC4p00SE0a5VcACcVF1Jx7/8mIcb2HimiiG3xWGUUls1fZq/m@vger.kernel.org
X-Gm-Message-State: AOJu0YwBN9HNfGnh4whQ74deFVpP6gAYA4dYUNaHhJcn2d9a9jm2VCPp
	h2FRPn0oVZMgXUFju9UDqDBQjrOWnvgRb/lsYsK9yNYf2GA97+MymKuz
X-Gm-Gg: ASbGncsmlaZ22pPu4U3Qqi4yY1ge8bAsFW8VifA1M7LaG1Xc7I2cmETOB1K9AKL1+tF
	k8YHvGyy2Pi2bHMdL0V1omZSEJaiQ9z4QrYBmFQALyZzti70IICxYuXaVYmp4yN68N/ZUOvh+9G
	Cnq7nHcN4W2L1R9qCtJM6XhO+NHMCQHWQaeIDuBHMxgVimexLkUtIFlyasTDI4AlJb5hgvfOauB
	MisAAGjc7nt108T2E3nRdwTj8h7b5BFRvsKhoZK1n06I6yWqSdAoRShj1Tec7nfWbnR/zxcEDoS
	MeiNnuR9UGFimblzCt9f9uBAK91iZkdD2oxjtzB4G/6u4AQM5gkIe4ms4BiQRY7r+cBwxy2JLfG
	vEnGd+JSfTIIW
X-Google-Smtp-Source: AGHT+IE4y9d8vikxgvAwpXIodBENHW2PgVwG5bQuSLsdfkNT1qH9L0nf9UIIGAtpDXr/v+6N33XcPA==
X-Received: by 2002:a05:600c:348e:b0:44a:b7a3:b95f with SMTP id 5b1f17b1804b1-451f0b249a2mr77239945e9.25.1749140531225;
        Thu, 05 Jun 2025 09:22:11 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cf14sm30010615e9.25.2025.06.05.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:22:10 -0700 (PDT)
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
Subject: [PATCH v2 0/5] rust: Add ACPI match table support for Rust drivers
Date: Thu,  5 Jun 2025 17:19:56 +0100
Message-ID: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
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
  - A helper function `is_of_node()` for determining fwnode types.
  - Updates to the core `Adapter` trait and `platform::Driver` to support
    optional ACPI ID tables.
  - A sample implementation in the Rust platform driver, demonstrating 
    multi-bus matching.

This is especially useful for writing drivers that work across platforms 
using both OF and ACPI.

Tested using QEMU with a custom SSDT that creates an ACPI device matching
the sample Rust platform driver.

Igor Korotin (5):
  rust: acpi: add `acpi::DeviceId` abstraction
  rust: helpers: Add `is_of_node` helper function
  rust: driver: Add ACPI id table support to Adapter trait
  rust: platform: Add ACPI match table support to `Driver` trait
  samples: rust: add ACPI match table example to platform driver

Changelog
---------
v2:
 - Removed misleading comment in `acpi::DeviceID` implementation. 
 - Removed unnecessary casting in `acpi::DeviceID::new`.
 - Moved `pub mod acpi` to correct alphabetical position in `rust/kernel/lib.rs`.
 - Link to v1: https://lore.kernel.org/rust-for-linux/20250530123815.1766726-1-igor.korotin.linux@gmail.com/

 MAINTAINERS                          |  2 +
 rust/bindings/bindings_helper.h      |  1 +
 rust/helpers/helpers.c               |  1 +
 rust/helpers/of.c                    |  6 +++
 rust/kernel/acpi.rs                  | 62 ++++++++++++++++++++++++++++
 rust/kernel/driver.rs                | 58 ++++++++++++++++++++++++--
 rust/kernel/lib.rs                   |  1 +
 rust/kernel/platform.rs              | 17 +++++++-
 samples/rust/rust_driver_platform.rs | 41 +++++++++++++++++-
 9 files changed, 183 insertions(+), 6 deletions(-)
 create mode 100644 rust/helpers/of.c
 create mode 100644 rust/kernel/acpi.rs

-- 
2.43.0


