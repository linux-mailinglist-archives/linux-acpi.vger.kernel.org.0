Return-Path: <linux-acpi+bounces-14436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9AADE83A
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC80B164EB6
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F53283CB3;
	Wed, 18 Jun 2025 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1prG0PP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD481E5215;
	Wed, 18 Jun 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241597; cv=none; b=l58jvThrc+XjQnfUrakPEd6Mx+qQieLa4dgTQgQL/5xfdFPYlZPZ7iu/lOyBNK9uss0WFfLHbKJnCeFfz1cU1/biQNktuVgZW7k+37prGg9pjPjsyC2ZrNqd/P7KiOqylZN8QZeeX1720Xj2c/7LYQo/I3A6blymfbfCo7pWGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241597; c=relaxed/simple;
	bh=pNNwV/XGoxOQv1CG9hWq28XZ9aN6GRVjgDsVYJmJ5t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN5EBxFL+oF8LbsOB/TmoK8gQjh4AnVpKqQC4/4MW1siFfmwK4lld+Qyl1lOWkh5fCkgFWdQaZeEp9XQHJ59d4rz5yzoKyMzOpQuWPfhiiPxFvdR4YLpfmTmlN+G8d9l9K0wQ4D0uHrLNhDmO0AZA3J8eceFjE12OM0Pitu5T4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1prG0PP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4531e146a24so41332835e9.0;
        Wed, 18 Jun 2025 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750241594; x=1750846394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcnlFSZlZ2x3eUss2ZhS1aBPVnMt3wLpmm8ROrRN7RM=;
        b=h1prG0PPtxMCuTenFbwAPmpP8Xa9geIZMxrSa+bQje+Etbycp7wiCgBIJNZ5HIBOwi
         TL3dT/+l0ATTLJqNRZPAC2lZz4+TmOJSg58de+wJwncXGeyBEFmGGcOqqTR2j4rDZ7Dt
         JuboUWcLTp34kVeQ2lMsv9lt7xX8sn3zxksR35zU+TQhy+ob7F3fvVRtXJck/wBoyLZG
         O/wC6wY5X4XmTsCr6amKUEVfn4RWMC7Ga792a009oVz2dkdquVdLDVM+yDgWBYkC1XcS
         Kr3zT0Rz6BezFmfN4Y+XfXcwYCVHhp1oPyfgLPKqhuA5zXVIUAjktz1u2YJaFDxyxcPn
         boow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750241594; x=1750846394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JcnlFSZlZ2x3eUss2ZhS1aBPVnMt3wLpmm8ROrRN7RM=;
        b=NPgGuyh4ixjxf6pjdTvUmCCjo3MOt1AYaHowASPj5wA1n8cI/515INUPTnJd6iEGdA
         H8xbRv+zR0NsOZ6d76TrMZH5NVvLsGwFuvcvNBm4M1hWblC3wFsTkS5Cqx0TnubDMMEt
         PFyyMPhE7Ev14NxAnCfq9surK31dGgIeJgTcWxlg+42tfhlC4TcG9fPZKC/SCLPpghSu
         L7ArdebOtjaqKNHJvTncj8crNCdprasPjPaa52yKAK8z5pnEC2D1N7gL5ld35binhxhe
         SP9Xydjx0JGDjFgsiMNoWQirlF1pCfzYJXUzpESMgvfwmcRFf6JPoVUZlbPV1y7zXEPD
         BHIg==
X-Forwarded-Encrypted: i=1; AJvYcCUFTPDRH1bPPCNdzLvbXfOhMtXbes1IpuW75re8Z/jJSFAP3Xvx2bHArHxZ5hKZyKUQSSsJKYFOyBAx@vger.kernel.org, AJvYcCUHmN8JLpg0qTqY8l461XMow1weye8v6eW5+VxAdo/TCLUg+gN2g0WvXgzG/rkO4lEzhKI00+Nd0EcNclBR@vger.kernel.org, AJvYcCWswsqz64Ix6ZvGzhNMsKBK6Wl0bQ3EhBuV09VFR2BiEC9sCS53UYPu6OVIUwpyfnVj75+nMtFqN06LvZ7Ob00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmqj3lMJOSxL/h5tL7lpFLnE47LVo7PqlzBgOCjq1T/gg/GqW6
	yDzeUnzgwVTn/S1hInIq2IlphOx2mxUhLjEpc9J+HejhDo5D+DnBu8wY
X-Gm-Gg: ASbGnctiBwJnPniGsKYDVn0zGToCfs/tut96A4bDyNPPVObX9In1H3ULe/ofiRPtcYY
	LSI50yclAtPKee/1pDdRiAjvtvSq4eCf5e5lziWlqB2Pze7aZ937ohufXust4g+N55ddeEk8ewS
	gLGE/++i5wm7x9dRKanBpByRm74QzuMadE761gMHt1/rmRXFL+5BniMvBskWaawe2ByuIdpTWHX
	b//mMCoj3vEaTWXSF5TGVko3gzZOfwDs+xnfx/NuoXKqfYot0iCWnj1xTNOrrxC2XJrwAAeYbv0
	yzZncma6YFYYLmmLZ26qBjEtlQFm5nV42AVaBADEWidsif2dD0rfa6eKMTpE2yjeg2cUI1H8cAI
	+FeFEQ25YL2Uzgdl3+2lYG1eScyearR1l/3QRLB4=
X-Google-Smtp-Source: AGHT+IEwXfOH3FNaIAS2a78UClizMEIMKgdGdRhw9w824FJtI+ggGZqCrs6PgMh0KumZibH7adUEmg==
X-Received: by 2002:a05:600c:3e8f:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-4533ca468e9mr157629865e9.5.1750241594282;
        Wed, 18 Jun 2025 03:13:14 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e256b95sm207100275e9.30.2025.06.18.03.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:13:13 -0700 (PDT)
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
Subject: [PATCH v7 2/9] samples: rust: platform: don't call as_ref() repeatedly
Date: Wed, 18 Jun 2025 11:11:11 +0100
Message-ID: <20250618101111.3047980-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
References: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

In SampleDriver::probe() don't call pdev.as_ref() repeatedly, instead
introduce a dedicated &Device.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_platform.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index c0abf78d0683..000bb915af60 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -32,13 +32,15 @@ fn probe(
         pdev: &platform::Device<Core>,
         info: Option<&Self::IdInfo>,
     ) -> Result<Pin<KBox<Self>>> {
-        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
+        let dev = pdev.as_ref();
+
+        dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
 
         if let Some(info) = info {
-            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
+            dev_info!(dev, "Probed with info: '{}'.\n", info.0);
         }
 
-        Self::properties_parse(pdev.as_ref())?;
+        Self::properties_parse(dev)?;
 
         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
 
-- 
2.43.0


