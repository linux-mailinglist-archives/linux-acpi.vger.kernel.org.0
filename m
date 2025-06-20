Return-Path: <linux-acpi+bounces-14478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92612AE1E41
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498665A4DEB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0E629C355;
	Fri, 20 Jun 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYkKydPK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23A2BF3D7;
	Fri, 20 Jun 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432415; cv=none; b=CULMyVX1IT1tjfOiC/uG1Wku2Zet/69gtW49UhNtiKHbN4MOEvvctvg5zFJI9XvjZkJkr3xrSJe6pXlE01RY13PCSTucQxAwMchZHToRKJak7RuqoRG+RVbtVDpmy/ntBbuTlD8xiME6vGf2O0qgHU4lBEkgUwFhzRzekSU1OgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432415; c=relaxed/simple;
	bh=La6pk9H26/bpjKQuvWN5PPW4SZbFgZLl7FVv69yhG8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f1Rg1VFeWmqmBt0h3rRDE515QP7CC3T91bfI7m84RHCnjMNS6z8r/u5BNGN1p8XwVl8271mODAgSvddPtiDh8APRECgkUk7sZf+73frgGuF4kCoe/XjY8YQVOF29eFGR1zxP/NDRfnPI/ToPLmbMQlWafVkBhDlVPTDXn1zjRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYkKydPK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1196713f8f.0;
        Fri, 20 Jun 2025 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750432412; x=1751037212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd8rIVXOWJDKzY1bPiiA23oWqQqx2bHkD00sbIK0oyg=;
        b=GYkKydPKtLm8gkLXjioyWtUkJK77fSy14NCwb97I3vvQWfuFUTySZUVQW5BvvTD2P/
         At5gSIbmO+0rphBGBnXlKhzAC3dz4WqgWi+7GY06G+7bN2S2xgaz5cwksLJyMkMD+T+t
         vxXkYnLnqg67tdk9kCkaGcfZlhhq6RS921sKLWLEj5sRr8uoiwACzJbdEtdENbQjykM+
         pQcMpn4fBf4b+/3WcCPAIcgiBaTh9a+y6sgC/l1YiZ3HV6u94qp/NVyGXnwnok5vgMS9
         vrJZf00J+ak5Mvfo/h/Zi7oa4oqUexzgHtPDmvVeKT0cSsVk5wAYrW90+yTRwE07tX0r
         NQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432412; x=1751037212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd8rIVXOWJDKzY1bPiiA23oWqQqx2bHkD00sbIK0oyg=;
        b=VulZ42egaF4uluxCQMifPQfBUE3QXZnmOXyiuX1XM4FHj6HKGScUg1YHH6Yg8Fbf9D
         MIM1z2MTtQfH9brp+c7ei9i3oGRrX/wLpZk8xmQtIahn2W03OtM9tXVfReYCvCyghGxz
         bFHDuw0PiMjBqlzIuup9mlujGx2I/ftZU7sJ0srE0BzoQI5+hVX6lhbdm190/A0N8ufv
         q8v9B1YBWEbNGM2q0mtCQfb8vVjnEQwdTthu3wvAhszFbA06XY4zHM2I7NMudLDCHMaw
         4XHHGrg6pDa8IFxPukOQ3YiLDxqAuVKdeSaD2KeYpP5VoqvHAsv/A2SZHEsTxRpAr7Bl
         49CA==
X-Forwarded-Encrypted: i=1; AJvYcCUOW+O8ngF0jvHoJ+mE6HZxKPdOBrNAI6zTfLHgV9mudfub6e2KyAh1mgB3gVtRU3agchsK+58Gqfzp3A==@vger.kernel.org, AJvYcCW+J64QNEfClNKnugtUDOnz2ONW/akieO2cg/6XM/aKoky3Udq6ewsdvS/wQ7iZyio7Y8hUrj/5aYAyXyhUXCs=@vger.kernel.org, AJvYcCWZDnJkof2aOP5CP00OYE6uXaJcH45CffDte13YOah1nxKfY0p7TPkJSsCgkXWUMho/2GhXUaPmqOqT@vger.kernel.org, AJvYcCWkEwssWY6r77OvwqThnCVgmWuzaNEkAGc+Ri/WoB67cEiSFjhl+rCj2K6u+QMZzst9pxDZjVRmKOEhc7TM@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZuxBGLYytdK9qEzjzLvpwVh5+nEx/m8OmPBu9SAql0NhRHH1
	pyUmQYcdl2cKtn1URzlAtyMVJkMI2rflBHhRIVupBy0luyaZUgSbM1IT
X-Gm-Gg: ASbGncsLx4x5Sgw/lZCxY2U+ec4Ah6EYIcK789iOn+WZC8ZuyJSfPnJxx0uKiWsOOXV
	sagLHiD/v1ga26pbHG+bFOG/+49Ng32VaQO7/81z1j9+KwQbN6ZQrHljUlrYiXZUuWUWjxI+FYI
	W7AtS4M864FJvArXdEBcrWhCCGerzpT4ri6IHfd33vh7Pb2q+/bKhQlpE6WZkeQtw9K6BZieFeu
	fCvL33Nqom+iRhZodugJBEIExlTGu7XE97YgVAs6Am+2+lqKMKhro9WXFTsJ4I8gOQIyOzcatsc
	k5wi5AlguZux9fsQgEWnR3760u8lDsfuWaHiwZkXhtDzeWq8S2zD5ur58uuV4BVv2lGgP52u98x
	voyy2X/2HavJa+STFBQ75J64rgEzFI6lc6AIi
X-Google-Smtp-Source: AGHT+IEiQS5a6M/z7+a+7H4+mmNgx+XDfQPrstdLX634ovqwc56MLO4MSVvB9pX/lYkaCnyDyKTcVQ==
X-Received: by 2002:a05:6000:1ac8:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3a6d130168fmr3360160f8f.14.1750432411973;
        Fri, 20 Jun 2025 08:13:31 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453647070cesm28172575e9.33.2025.06.20.08.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:13:31 -0700 (PDT)
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
Subject: [PATCH v8 0/9] rust: Add ACPI match table support for Rust drivers
Date: Fri, 20 Jun 2025 16:09:13 +0100
Message-ID: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
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
  rust: device: implement FwNode::is_of_node()
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
v8: 
 - Rebased on top of the latest state of the `driver-core-next` branch.
 - Replaced `FwNode::is_compatible()` API  with `FwNode::is_of_node()` 
   per Danilo's request. This includes initial commit and conditional call
   in `samples: rust: platform: conditionally call Self::properties_parse()`
 - Link to v7: https://lore.kernel.org/rust-for-linux/20250618100221.3047133-1-igor.korotin.linux@gmail.com/
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

 MAINTAINERS                          |  2 +
 rust/bindings/bindings_helper.h      |  1 +
 rust/helpers/helpers.c               |  1 +
 rust/helpers/of.c                    |  8 +++
 rust/kernel/acpi.rs                  | 60 +++++++++++++++++++++
 rust/kernel/device/property.rs       |  7 +++
 rust/kernel/driver.rs                | 81 +++++++++++++++++++++-------
 rust/kernel/lib.rs                   |  1 +
 rust/kernel/platform.rs              | 29 ++++++++--
 samples/rust/rust_driver_platform.rs | 80 +++++++++++++++++++++++++--
 10 files changed, 243 insertions(+), 27 deletions(-)
 create mode 100644 rust/helpers/of.c
 create mode 100644 rust/kernel/acpi.rs


base-commit: b29929b819f35503024c6a7e6ad442f6e36c68a0
-- 
2.43.0


