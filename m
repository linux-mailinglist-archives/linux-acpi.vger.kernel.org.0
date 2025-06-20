Return-Path: <linux-acpi+bounces-14481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444DAE1E8A
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4A43AE6CC
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA52E62C4;
	Fri, 20 Jun 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/UMaeWA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BC2C0302;
	Fri, 20 Jun 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433019; cv=none; b=jk4gMfCztH/rqYJnXpB3WD8y/wB70jw4PeaHIQXY8/rj2BvBK4CT8M1MO+Wp5E+3uLi36zL8LmqJlaxT2cIZYbf1kLB0sNChd2Lm5nn3DrRjDuoM0I/XjR8g1R4fUb98e9rQvK7uSxguSFYuI7fOolv4CmbLAzd0j5ZBGiSFG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433019; c=relaxed/simple;
	bh=dvtN9eJlUFurArdkvVXhsE2a5bCUKBuAQsM5cOZ1ULE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+LxttqsU3lqEH5uwZCFApT9mdqqL2VuInn0Pm2GpcdEFGvZGbbn07XD2fBoSpF5bC+jhZfWR5hSdYjlApkLs5qE3OOIahly48tV/BLw5Fv3T78J+QTcftaCvljrKUuxjLfjVJnA26W+GamSFFAj0ISvneZxrcTa99ON2PpE1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/UMaeWA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so15084895e9.1;
        Fri, 20 Jun 2025 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750433015; x=1751037815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNAXzfmh7HFb857b4kPNw1wjOg7WWnf6DO/mp8yJ9IU=;
        b=V/UMaeWANHT5yNDPzRREVPfL5IUh6ez+wasTPC3nI59nux5DpL7bWCy4YZ1ONwAlfy
         /V5izPlrx07uy7uifKdzD5MxCIPj3QTpfOMub4ZS2eUruOWYaMSh3BgERm25gsKeOX4U
         VoXqP36MQlTIT4Q214gW+66MTC6x7AuSiwD1Gk9+ynBt/HzZhm4S86gR2WYEkQVL6l8l
         zlNqqkEZ3/9zHTnUQHPUYxVEGACiH7Gs6cwv2jYZ6cPThXnc5ge1wCnyUEYcmOICIef/
         ZO0AP35VjkJXarfhtBCPN42XJFMgf5VoUq/5LD8LT8zQUNFOUfpYuVSWEMLz1hjCHfgx
         vdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750433015; x=1751037815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNAXzfmh7HFb857b4kPNw1wjOg7WWnf6DO/mp8yJ9IU=;
        b=FIs6Xy4hQXqsjBsusWYfORbfUyK9MO/abGC17tqCJ8mHIduocARo+2e13n5QIXgRpe
         4wNiG5Je5KEQIdcuGmD3dd60Y73wz6rhJl4XmKvyP5zs8oTfM/zRfEU5mA2R2zFsJ06/
         x6Tm4wZLIbKWaewW+QKlfiXBxIivl+3tVZ04sx7qu7wiXQmouiOGtuXbaynalDDHqK6g
         iwPlHXNjsEIZG8GrFmuGURx9zW1UTy6a0fde5g7oIjIWkNMu4lY+NjxRkIc5YcPByl7f
         3LA+kd/JHvJ4v9odcY+jeGUUnjTMngjkJE89tDeWfpXovoiveZd0q11DHqecPYS4/D04
         mStg==
X-Forwarded-Encrypted: i=1; AJvYcCV8J6vCBX88XJiH2vSvAPCfpiRrbrG7Rqw5nRIQbNkiqvDWubWZLndkqkBhy9yP6ozZaT6lCuE1Qcf7uw==@vger.kernel.org, AJvYcCVumfv91yMUjZLK7PmF4EY2M1mppEpvWaJGj3sBXZbeETWzd+9am8+JcwsuwVOory1L+xeRlHmITLI5L5oZMpk=@vger.kernel.org, AJvYcCXkYJ6GQ0Om/1lnKfLomiKFfNPry4OxT04BG7isrHhhEnsag4SZ8caLa8C6dtAWqOterzSzT8y6aqxV@vger.kernel.org, AJvYcCXrWOmPKUdmsyfumP2f1OwPqc7jfoXlV++cVcaa9Kac209ANRdtC85vXEqVY4cvBTPAalHGwQodYKa5rUhc@vger.kernel.org
X-Gm-Message-State: AOJu0YxccZpzymLWKkxHhfuvkRioTyhEYNdPFAmmyQzxlTfDxIMrd4jy
	+nyS5rwkyIUpUUFDaaTkTz4VfPdtTQ15BZr0BqqRmjUaTAHb+hvoEJs52xrvjtZLWX0=
X-Gm-Gg: ASbGncu2H8f2WeyFC5MbRJ01VyA2GvICaqDjHDzvjjXyJFVe7K3cTH1ysxlmLFCLR3h
	EC4sHGFRvVkksoNd3xifXFVyJrAnpaQFng+uBdlC4v37YyTaq7iW/8llohmkPgU0WSv4vTCuaa3
	MWsTgB6zXkLZ0M6bN53WXGErtErLzLsHHTybx54nI+GOMLKbVoWzFcKqDRUNxwVkqvjzP9XzcJI
	VVMh0m/H7BjPbnDHb5bZRC8KecJ7ImPVGlo+07yMMz/AAl3HwZK5aaRgvEFZc2a6GPqs0Fh/oSL
	X2VIcVgED5kYBTufOzUVgcj5O+ivAe4+Ct52wF2f83K7VdDmXRyO1tKnw07gh5xnWi+JMLW7hpo
	GeqtrQuHBuatrtk2vGdos4MZ/qAK0y91v3XauEJiOI/csQ6I=
X-Google-Smtp-Source: AGHT+IFihYFIqfttAHK5bJgnnS222iRdKvNF+qBgQzgtvlXsebluzOgG6hM64nIzrSpanqXdiR1uSg==
X-Received: by 2002:a05:600c:46cb:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-4536877fc08mr16753075e9.30.1750433015111;
        Fri, 20 Jun 2025 08:23:35 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453624554cfsm23696085e9.0.2025.06.20.08.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:23:34 -0700 (PDT)
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
Subject: [PATCH v8 3/9] samples: rust: platform: conditionally call Self::properties_parse()
Date: Fri, 20 Jun 2025 16:21:03 +0100
Message-ID: <20250620152103.282763-1-igor.korotin.linux@gmail.com>
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

From: Danilo Krummrich <dakr@kernel.org>

Only call Self::properties_parse() when the device is of node

Once we add ACPI support, we don't want the ACPI device to fail probing
in Self::properties_parse().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 000bb915af60..8579290eecb3 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -40,7 +40,9 @@ fn probe(
             dev_info!(dev, "Probed with info: '{}'.\n", info.0);
         }
 
-        Self::properties_parse(dev)?;
+        if dev.fwnode().is_some_and(|node| node.is_of_node()) {
+            Self::properties_parse(dev)?;
+        }
 
         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
 
-- 
2.43.0


