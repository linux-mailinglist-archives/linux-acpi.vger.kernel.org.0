Return-Path: <linux-acpi+bounces-14166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 627EEACF4C9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 18:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 023C77AB8BF
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D414275864;
	Thu,  5 Jun 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9dkOuxw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFEE274FF5;
	Thu,  5 Jun 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142357; cv=none; b=YDk9vSClL+bWP825VFEIfKv0RO/8EGV6tMqzW/NgDzMPT0NcarnzQFVg6VXnU+8MzNWEylPX0XS9WzRYYAJCNyueYYQF61UqUV2qKe8KNQoBalSjMrCnICVutAHL1MvXMkrvE/LiQSKQO7sQgU1sZZHrpr/KkNYDb+dQTqRaZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142357; c=relaxed/simple;
	bh=eX5FQHelIYrl38B1a0jr4ldOd7+nuInFcQIy7hA5GlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsN99hg2PSLkohWMQ3KewkTkZ5fRIdthcLdBlEfYbOjLHL5F8JJ2q9dn5/AHWSTqp8dZJyUFwzzH/ZsBUIL2S3957r97R+vgUdAwrLlog4GV1+RKass5ZQ9zF+DSpMkuvRZNXsGWPC+GM08O4TlMSMKDv5w42mvlXa0rlKOPRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9dkOuxw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d54214adso10653295e9.3;
        Thu, 05 Jun 2025 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142354; x=1749747154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYiYcUa0Zpd9O4aRs/ez0DwzmhVXN2VCaXs0fidvEQc=;
        b=S9dkOuxw9mBB+OGU0v9Knwtg8W9X6lcu1Lgs0B9rd25bCxCdWSBdsz+9naimxUZpNT
         zXKoXlZORkpr3S0TjV3pG1ycyRK2d84m5/ovPo/trWkmDA2J/QzkD9klymZJ0fNC5zt3
         txZk0zNZOuXHCGi/477nCC9mDBT+IzRts9URxqsmsmKI5DgLMFJWDsyFA+0V9qH4OvLE
         jKZ6igxDjf/gXatGGgZZBdv9EUgeSnlSmsArsPSgPp/MaGcTJ7lYrrU1m/Bsu8xDKj9X
         8H99VUR9E3Qd1ahRztb2naz/GrBhTH0/tD5vtceHwFxfWdEmZEogXPKZpYxpRg0HjdXw
         F3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142354; x=1749747154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IYiYcUa0Zpd9O4aRs/ez0DwzmhVXN2VCaXs0fidvEQc=;
        b=iE+wUVVBPYFMJ4d8rA0YCVa5ZczN4zSedoHPIqJwQX3kbMfQlBQLtgDB4v8RV5lM3O
         hrrubXlCHkFKd8s4tcM2Q7QERTZPr28RFeR+FRBpBOlXHqX3wd63nvaAtoRrIT8gXF+r
         PaKAhQ+XP2hJIRPkTdyvB5SCGEV6tMbpX6c+DqIzkxqv5hqlgAqEcT8fbdJ0jVgT/ewG
         fUT00TVJcWOQu8nqTI1pUllv9lUlzYSIIJ38ObIV0//Yu6VCuwAsYba2rVn3ypcstwK0
         N7LmZ0hsg8XgBDqsFQrnL3gcahW+6lknMJ566zKVO9NylP6hNIpljpPpvFs9sVh7D7DL
         r37A==
X-Forwarded-Encrypted: i=1; AJvYcCUEjqxbczcnG1vvPTrAMHfbnYi0XBft5eYRAFeA2kAsw+Q5fa3weCrQ1VwoChNUxsQgqO8ZwzzQLAoaYnKp@vger.kernel.org, AJvYcCUv6O7DI5a9Fgz7s2uG+9qRvgI5eAYXo+IYnryfAcxhY3sZp4XtGgJZY8HxUtBUU/y2PVplR4MTRkWK@vger.kernel.org, AJvYcCXTg9F+iHMYPjCZUmP/H29DbBK3Ge9erMo+OP91X2FOVId4vGzBqpmNr8wSRMKJ9eZutqbG8KLRIvGLETK2Gi0=@vger.kernel.org, AJvYcCXlphbJHqCqNBdA0Yfr18H4lNlq0ZSL3ZfB7xILrpVoN6aiC0/h5C1lRlSp5m1FNEb744qsAZmxG+HoqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWcJlsf23o45L3vqZp2nQ8TyoP8HTLcSyT5p3TjlrT6Cft67q9
	uRh8S8+tQFiqG8Aaa676BnLujep/bNr/Bve7ZpOl6wAH/P4UxlSKOZBG
X-Gm-Gg: ASbGncvibyhaH127r5EwQL/SHVvdFuACb0tIG2dlS/sr2/J4/sM1sCmpvg6qyYIFAVu
	FBqZlQ0bNzaJfE7lhkAisP4qLL1JNuPHqwe2ANVl4AAL8jM2JBDhcJkgEipVXUI+7ZXgE8FKtvC
	Da+kgyKZA+nQS8HBPkVoZ5BHEmQLn57QNaF4I/Vcy8VWP9f4JLHp19j8nLBzFawwBLbAx1OwxJv
	EbAFEUQdNjWH85weUq2R0seP3K+FzIInhKEBqCBVa2lItmFqbjPQPdmKl++fL2ElRwgiPfLp++w
	dzu2hYL2Nv2nHaAqjrs0FVh4cPxwX6aGzSia7vlLhRt71VvkTYreLoDMtmSN9AW/ooWzOFG2k45
	aYx2mi8A/mG+q
X-Google-Smtp-Source: AGHT+IHeFI6tIeh1xtFilZ//Dhpls7kj68vpPnNlI9lKURjevXM8botgo7CebM3JFPfxAU3VtdR5kQ==
X-Received: by 2002:a05:600c:870b:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-45201350c40mr291925e9.8.1749142353614;
        Thu, 05 Jun 2025 09:52:33 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a52a1993ebsm2184495f8f.93.2025.06.05.09.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:52:33 -0700 (PDT)
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
Subject: [PATCH v2 5/5] samples: rust: add ACPI match table example to platform driver
Date: Thu,  5 Jun 2025 17:52:31 +0100
Message-ID: <20250605165231.3663810-1-igor.korotin.linux@gmail.com>
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

Extend the Rust sample platform driver to probe using device/driver name
matching, OF ID table matching, or ACPI ID table matching.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 40 +++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index e3992e7a71e9..ee0780c1d6ae 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -17,10 +17,48 @@ struct SampleDriver {
     [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
 );
 
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
+///```
+/// impl platform::Driver for SampleDriver {
+///     type IdInfo = Info;
+///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
+///
+///     fn probe(
+///         pdev: &platform::Device<Core>,
+///         info: Option<&Self::IdInfo>,
+///     ) -> Result<Pin<KBox<Self>>> {
+///         dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
+///
+///         if let Some(info) = info {
+///             dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
+///         }
+///
+///         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
+///
+///         Ok(drvdata.into())
+///     }
+/// }
+///```
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


