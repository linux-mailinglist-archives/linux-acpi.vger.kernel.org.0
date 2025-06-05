Return-Path: <linux-acpi+bounces-14162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B746ACF435
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0276F1891D83
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA69235074;
	Thu,  5 Jun 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvCyPG+a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC8205ABB;
	Thu,  5 Jun 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140701; cv=none; b=U3Vq/yCDHPLBzM7jMwceGavDsPYkgBoX0/cHFc12RiQZT4bL0G91tPsoSRx7Rr7ZRJD39tFwvYsSZeCrLniXUECQ/Pt+Us3CYoZPJE/Pls/6n5L2mxPfAaTfVmWwRebGDz6JfdwInpO7ZbW/ubLTOCkDpxv/UYpMiVYnpCNOb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140701; c=relaxed/simple;
	bh=pwyfEO34JmMzSrSCOCcsHlL2iqGjz85h0/93mVFh7sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhAmPUrAV70srPlMUIuYvj+pZyZo6RH36394Wtk+AiCrqcp27HxyWciWVcHjS9NRleOyff3aCMWNUag3+drEUvd4gUX2wI4KoO8hwWCJNYoeqb4D/C5vvuR2JfJxPLSZPCrH8/g8rtwcp08XkvNZ53PemyfGA+XB2rxaLrGHy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvCyPG+a; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-450caff6336so7287585e9.3;
        Thu, 05 Jun 2025 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140697; x=1749745497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1m1B6nQXZ8mPeTAYsXRWJ8xyXAKXvkl9Kc6auAK6DM=;
        b=EvCyPG+aUmDIqYVfudE5M7d6435+ur2jdppRIwgDLkmGm6M1+3EKiPQJcN9GwazhvD
         nbAEbuTu1BH6OyJY680dtzKwVOe/CsR0FC63vyXeNWzv1YzIZFsuThb7tLle59bNQ/Yq
         PAhZw1qQmG8A9n/4iPvGTl42M8R/0mcbEu5uG4bG97fzUxleNUGSoxmgYBvHdV1RzzLU
         cwYp1U5OxSIsTYGAcECdRjHMmH6qJhg1QzpkM9iRxlAy1s0d8LxweF0dGJdqUJzXM1qz
         FylMXAqu/HdK7HHnEbgyWsMVIOJKrYfoga7IZLWyDbAu/G8WY1PYY2szAezMHqtZA0mW
         5F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140697; x=1749745497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1m1B6nQXZ8mPeTAYsXRWJ8xyXAKXvkl9Kc6auAK6DM=;
        b=vE3N1Bmq/8xMcIGSMaT0AajwIQiq4+n6BQxv0DnU/zBBXmDZ9wElpXAarFAoaJWgPt
         WXmRF6wHkfofYPk6vRYoTUAwvkPYUMGki7He7cWS4MYHxsjtVt9vTCW2ZCvOn+bMs5IG
         0grl5ITh9tV3F5GJyJ4ShHKd157ncFq5Ve/zTZSZ4GqxudzJvoCZ8QVa9DFaVbCMBgLt
         ehs3Dm+9co2e7bHE5uXg35NnjHIVTCOYtZBSoXSlxev8jrNLMn2r9W6adi+Osq9T2h8p
         dS2YiU1GYxI5fpJ5EOye0odNyhuyP0+8uhCPAHIHHX+QYhPe7l/cZEqxNmj23jB8O1IM
         mNvA==
X-Forwarded-Encrypted: i=1; AJvYcCUgascl+yGN8WeOekGb/g8AIKD1mAxVmQLj8lJjGFXKqhWLexIAWwuoQ6Zn8sRFE2iQkCSuioG7nxOo@vger.kernel.org, AJvYcCVZbg97FKNMD5idStx7bJvWowPSbAxbdsnit6Efb2OjR9PVLhCsoG/TUFQOpjYRwjTO0l85gbJDIegPr+wuJoA=@vger.kernel.org, AJvYcCWdwvnrjFMuUJ64Or3KMZTmloUOTR19mC4M26F8ZsQpeai++Vlxe1i0H0WMeCJIanFFq7/u9X9J9kztAKWF@vger.kernel.org, AJvYcCXqcVE2fn//2foFy6ZuJ5LfYtvmfYSxHTdZnGRg/z28qsLR+nqwLnkjHvcuS1BXchzi8xfNbAEtcsWHbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysTDrHp2dNu/+CrTnJwmBCO6dzNXZv2CCrcneBhMSMtTYizppG
	cDYcP8qt6Y0OtWx4WMIEAaI7/TCVk9PXKJCp3b62hyd+DqV0q2RptSrP
X-Gm-Gg: ASbGnctw2vqdgHdFNePAe5ZCSxEC8xxpfj4tYHWSSlXgmRZqcbORYZmXmW5d1Dtq3l7
	xcS/zyfQeDa7y3bli32nILV8FgamNVY5yCF6lbbGm5DL69iPa7yn/RQQqxCZETWaa597OIXlIYQ
	yWHF/0jFQ8menMajWqOQZLSyQ+Orr/1kT36OlNI6PYv6FLexynu4jIQvTkdoilvlZLmhZ8r3j4Y
	Tf1mA+V10K6MON75YtczJK+775fKnxzWqPd29SZRqXdEA+kUtjMYSDt5ij2USUyC+nZqZ6JwKFU
	7yYqK3n/QswJY0AJoCgkljOtIxSzHduLdmz5NXWcYwsAQ2X1SbQTOOXOswSBRXmCtF3jcfcG1wA
	pY/lETYMUespqbTo=
X-Google-Smtp-Source: AGHT+IGWavlZhoQ+/UyAySuEJA2L+CnHKDxy4aTjsHiVQaqroh/Imb+eG9Mk0IdvcIUwFOomrCjnRg==
X-Received: by 2002:a05:600c:3106:b0:441:b3eb:570a with SMTP id 5b1f17b1804b1-451f0a6a94bmr75309925e9.2.1749140697424;
        Thu, 05 Jun 2025 09:24:57 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a526ddb8afsm2822451f8f.0.2025.06.05.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:24:57 -0700 (PDT)
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
Subject: [PATCH v2 2/5] rust: helpers: Add `is_of_node` helper function
Date: Thu,  5 Jun 2025 17:24:53 +0100
Message-ID: <20250605162454.3659309-1-igor.korotin.linux@gmail.com>
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

Add a helper function to determine whether a given device appears to be
an Open Firmware (OF) node.

This function will be used in Rust driver abstractions to support both
ACPI and OF matching simultaneously in subsequent patches.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 MAINTAINERS            | 1 +
 rust/helpers/helpers.c | 1 +
 rust/helpers/of.c      | 6 ++++++
 3 files changed, 8 insertions(+)
 create mode 100644 rust/helpers/of.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f8dfae08454..d6cadaa592aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18215,6 +18215,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 F:	Documentation/ABI/testing/sysfs-firmware-ofw
 F:	drivers/of/
 F:	include/linux/of*.h
+F:	rust/helpers/of.c
 F:	rust/kernel/of.rs
 F:	scripts/dtc/
 F:	tools/testing/selftests/dt/
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 80785b1e7a63..2fc5242aa47a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -21,6 +21,7 @@
 #include "jump_label.c"
 #include "kunit.c"
 #include "mutex.c"
+#include "of.c"
 #include "page.c"
 #include "platform.c"
 #include "pci.c"
diff --git a/rust/helpers/of.c b/rust/helpers/of.c
new file mode 100644
index 000000000000..8913eaced716
--- /dev/null
+++ b/rust/helpers/of.c
@@ -0,0 +1,6 @@
+#include <linux/of.h>
+
+bool rust_helper_is_of_node(const struct fwnode_handle *fwnode)
+{
+    return is_of_node(fwnode);
+}
-- 
2.43.0


