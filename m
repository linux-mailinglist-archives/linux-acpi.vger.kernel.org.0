Return-Path: <linux-acpi+bounces-14287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE3AD5D8E
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 19:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E385F3A9600
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA88236430;
	Wed, 11 Jun 2025 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpS2/qJ+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F3230BFC;
	Wed, 11 Jun 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664562; cv=none; b=DZ/ijCMac9TB3ryF6zvODjaMEQDpitIUbCVIPgod+fdhXqke4K+diSwY2O0aAEF5RBLGCnoB380eATyO8McHLVNIvrsw7DCFRmwAboQ8b6yB29bqmWuHLJmTDXvy2398lgpoDF+VR3NyCoGeqGkMJjih5fkxsP3BHeTkDR6PU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664562; c=relaxed/simple;
	bh=9fNPWzQXE6cKwryeefEjE504/Qv01BUzHuW0hAhRs2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuBi27t2CkhuzgEgtOcjfUusYkgT5AqGG5LAIXYb7MrmLXYSssBWYPGnBIy5ZRx6kZbsY/klX451rfEWhPoGzHBwbvZ1N0w2Ysh6nijtWO4VK+Sj23Jk5YShDJTckbhu8PHCvHvHI19fZDDSBdy09InylIr8dv1VkcF57H/tc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpS2/qJ+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so239295e9.2;
        Wed, 11 Jun 2025 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749664559; x=1750269359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKy2YdV53E/AFNFLMwrNi4oE9E3ostFMU8yHIDbBt1s=;
        b=KpS2/qJ+2VVcGs4/hTvp+EWqjm06iXfTUO3OgjmK1ATiHsUROELcqcg4BiNaviI/Ep
         y9I44FeJgLKrrxYejC1/LIaLPejD6moy+o6B6q0IKAD0bW1oKjON803/LhNozRd2yj+h
         DWpcDb55KhV1zi4Dz3uyH+Cwq35vsUKs1FYk/6MVHQd0UXW0rtzAEETT+7xflXqrmm+2
         0BZM0LxxYp0DGsovc6cWCIFAo7EDbFSvSNuhg+TgkQGwBuGqXGL9qGhJnllEaGMamVUX
         GUhftk4BmAuK4Jlw18atL+FKwf8xsu1Oh6KMqp3vj5gBGVIDE2AiHacxbpvQ57GzXL6r
         xE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664559; x=1750269359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKy2YdV53E/AFNFLMwrNi4oE9E3ostFMU8yHIDbBt1s=;
        b=xRpPxWsBVIxLM09UfewPdr9Qzure5fxtBeyG12vXy2kAIo1v2uPsBkmwWqyk8fNl2u
         4vIMReQ6Fa+9/pmsdoW/JqPRXymwosO8Ffh3lLzP5TY+Gq/RrpIk0J561VpQqRzpV0M0
         72z2HvAtadoVsmovklo7KFH9bhGbpE8GjxpRvwHW0J18HGwqbJoI5vpSTI1V0Dji2xKz
         oP/Xah/Yn0GYNGWuWwFOJ+Jj3eeJOwD6pCa9WtaYZhch/1SU+p/skImyAeNJe+B2Inef
         uaSHjuF+Fm9J0yXp6uewhuS0INeKNFCdBPMWx8yFBbkwc/55oqrw+oDm0IPIhBwiIrhb
         Omeg==
X-Forwarded-Encrypted: i=1; AJvYcCUONAfUq9JL5T6tYT9o2GbWjYjOtnEUsep/cgB6qqqAuan1et0vJDTyD4CMDljljAPQG4PL64Nt0kWqgNX/@vger.kernel.org, AJvYcCWYiuFLkHsCL1jQ0/kcIB6R03CTXu8zszOpf0rljIiCVli67yYH3ypIg1UjTVsdxNCrvyUsv9kf2Hnq79XThos=@vger.kernel.org, AJvYcCXE24gVoY49Q5tMUH1c2Id0dYF0uAFXDG+tfyHTsV1aHpGbDtc1Zg35AbZ5YMYeLepAK9aAUvfWeY/X@vger.kernel.org
X-Gm-Message-State: AOJu0YwtWAS9q0u1la5Knlo4FG5BmNuZvGWe/+olpEBc6TwcHZXRiPE/
	+TeQCHb+SOkCtSF3vcoAMseJIE65SGwD+L+LgC7L2wLcX0kZvm958cgB
X-Gm-Gg: ASbGncu4DtREdf6fIdq1FTHfZ5p/6QPkryQbgfA76HJ8UQLsDpkvVDF85Ixp5b8fp0f
	3J95TqjiCGgEvQa4XyePqRwT57bC4PeeUfbHw2Cm14G1amSdQ+Ua3itSzPVQt7RKZA9awbgsCJR
	uXzb3YUNdAhopwi0SS5CYiJLQtciSpqzlxhJ77CRjpgvHSWU182HgUZ2/bB0s7/eUWxGhlXnEHV
	GTGL1Fcz6LLK156v8Tcq6ElUxmVBiR5INan7HLQ1e0Hqw7zmWU0g7zhk8SmNlg9u/B2dfSgyMSt
	X5Yz5CZ3Pbtq+b5wTe8xuRB/aRuUdAaBhBhqKBJuacS4JJ2EyczQzLie9IKMfHcsIUfdkHEnLE/
	+gwxj3ga+EM56KenkgHFEV62UuFpE99LeoLrGxI4=
X-Google-Smtp-Source: AGHT+IGGASlUeMTo9rc5uxwo086ujx5KrDNAyUjiQI20KWPNO95XcMXGwbdfWF5Z38D8Kl8Y5gy1+Q==
X-Received: by 2002:a05:6000:2302:b0:3a5:2cf3:d6af with SMTP id ffacd0b85a97d-3a5586e95c1mr3242839f8f.45.1749664558892;
        Wed, 11 Jun 2025 10:55:58 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532452d7esm15972558f8f.85.2025.06.11.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:55:58 -0700 (PDT)
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
Subject: [PATCH v5 5/6] rust: cpufreq: Remove unnecessary `of` dependency in cpufreq example
Date: Wed, 11 Jun 2025 18:53:53 +0100
Message-ID: <20250611175353.803835-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
References: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the explicit `use of` and `OF_ID_TABLE = None` assignment in the
cpufreq driver registration example.

Since `Adapter::OF_ID_TABLE` now defaults to `None`, drivers that do
not require OpenFirmware matching no longer need to import `of` or
define the constant explicitly.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/cpufreq.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b0a9c6182aec..789c4a8936ab 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -842,7 +842,7 @@ fn register_em(_policy: &mut Policy) {
 ///     c_str,
 ///     device::{Core, Device},
 ///     macros::vtable,
-///     of, platform,
+///     platform,
 ///     sync::Arc,
 /// };
 /// struct SampleDevice;
@@ -887,7 +887,6 @@ fn register_em(_policy: &mut Policy) {
 ///
 /// impl platform::Driver for SampleDriver {
 ///     type IdInfo = ();
-///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 ///
 ///     fn probe(
 ///         pdev: &platform::Device<Core>,
-- 
2.43.0


