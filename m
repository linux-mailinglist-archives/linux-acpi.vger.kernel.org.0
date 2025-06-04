Return-Path: <linux-acpi+bounces-14131-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D0CACDE02
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 14:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089B23A6140
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB2228F94F;
	Wed,  4 Jun 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoA3e9R+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B828F930;
	Wed,  4 Jun 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040341; cv=none; b=HbDaNxosk/POjzmpHx6WdrrxMgDaYWvnZO+HZClyGPKbZGiV9R+XoFmam0T5QL/yx7I4FHFkvLgAo7IryeU8zB7kuJRSlpezgb0mBnMKpiVlYkcRppPhq9dH0LQw8w8XuSLj4jSPu5/fIZr8yT/Aj2WY8G+p/VaWGtDIEYTGwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040341; c=relaxed/simple;
	bh=pwyfEO34JmMzSrSCOCcsHlL2iqGjz85h0/93mVFh7sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYZGaslQe9OfejcLN59zvtlwWvN1zU7ZtM92e6bmOBeuee9K87MYdd0BoFxCDVOL9/JjXhH9DbaIsXqPgm9s0jbTmCdwckalTGcdmZ7RdA6r4QAQi/Zf2sY18wGbE1150KMpHtvsEwOPfU+s2ZhMBXbyhNVP7wo3BcvwVbjJ4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoA3e9R+; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so75477125e9.1;
        Wed, 04 Jun 2025 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749040338; x=1749645138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1m1B6nQXZ8mPeTAYsXRWJ8xyXAKXvkl9Kc6auAK6DM=;
        b=CoA3e9R+TEMzvDgf+I27IRAgZHMvSdcZP+YupLwIvZ/GS5Mv1rkdTUvotDTjqygKwJ
         HRU6L6na4s9knKj+uMCIjMSzSWzevsTi6te13bCaMJWl68FmYuPXJXSVIC8MsXIv0/1N
         yCQOg+hR5ya97C7kJpLDx6cYbA8qBRy3Yabr8oQtD9VMWdedgkSYYY7xWmeI1B60HU8b
         V0AFWri6grZLWFnG2L9dOmlBIL2soT9RL2NVK7OD2gxi1g7ydCALBJVD+Ks2VAkYhFQq
         QjS2hwDJuf4SvpO2XntBdh4jAATTNIEkNXNXZKqkwv62KUG6HMAuXutbdzaYISGk2swK
         RmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749040338; x=1749645138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1m1B6nQXZ8mPeTAYsXRWJ8xyXAKXvkl9Kc6auAK6DM=;
        b=fyCaiyX4xuQKThvZZCUMYSYLhm6IYJdIrUVIylYO3Qsh//EptzniN71d/PyxSrOpb7
         OtaVJn0m+5JBltid+kPSm1RQ87UIcFYtWpgF1q0TPLn12xZCANUphEX8+ksgCP4Y46hD
         /tSLcx5SL3WBi/Klzbdc9OsCE6JF3wpaVDGaYwDQZY9QL1HZ0cotg6c/FZMdmTk596kG
         o4tw4sJDlSeqFSrz81GGJxBb8IoGHIHC1omY3bGDsjueSwwssw4FLk04jcKfzeLPtvvQ
         kxGd9TKya3JgFO2ZVHsl+vda/VZk6ZsVQ7kcP4isvh0H39XJ55fv5yjyjh1eotCv0k18
         Ilmw==
X-Forwarded-Encrypted: i=1; AJvYcCVFCDtTCXqPsewgs11757CpX50hTGIO7hQhwC+1SPkLZ12qRO6x7fZoEj+2k4BQ864mq8HgvuytoZkh8g==@vger.kernel.org, AJvYcCVq4FBrN9C8z6vC3BnZdUiJZwgEDR/XFoIK6YV71JOBTW3KKUJ38x9KiS7cilHWma65jcsmSdm3ACY/@vger.kernel.org, AJvYcCWXXs/uy+vbGrN3SfBAZ7x8Uy/rlHddxfBURdjNaedjVSGEDE6bEql4SPt5Nq8jE/e5i9VZk+PZJbDyOSQv@vger.kernel.org, AJvYcCX6juoxa4D51ZYj3axJfDUoiGeUm7hOqs2+oaeBZVad4RNFC7VpB4i2MeVfa/XxknmhrbX2yUDNfWX6t8UIOH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylFN4eSHSc+MRWvFaIYSGDagTA0pdFsAEmSaXx5+MEeRDJkcxS
	24nFWQr24XL/ZCyqyQw32439edhoo+xjLslDho1m4xs2XzoyLy1EcjpZ
X-Gm-Gg: ASbGncs67OJh67JDbq4vQ7EAZ3how2OHC0VR/XiJtkaTsRQVL5T4JxM+jxxcJHMJrfK
	UPVHJU3v7gu8zjdW29qZipZlXrPIoc+DnV/PCQAc/fYef3vrcliCjyUAB3WcMTn/AJ3idvc9nHf
	vXy+KS4PqLrJE3vxSyNk40T58S7bhI8dxEUVitm5drkYw2FjnFyXcB6d/pV+9tbrWhl9t/of5M5
	GG/HJfF2kznRz6RJKLC+V+vIEDCWlulUwCgK6GCTGb24FrKrVw8F3A9fUlv6FG4cNBjOD62owKU
	kcw8KtdKdGKKpGrz6N1+mk/gaqsqyR5mEnlIsskp4LUf/3Sn9Fm+R5Ind0zC2RVRtEMJWPn0gMF
	t3Mak0Q+ouZmmq+oQm+Y6uVcx4MTE
X-Google-Smtp-Source: AGHT+IHYOI06cvRGt50ykegAltB4i7nq6E7sxnPwIWOb+6NGXuDFwm3fuQ2tv8cYgQ2DY3Jdaf0AXw==
X-Received: by 2002:a05:600c:1e08:b0:441:d438:505c with SMTP id 5b1f17b1804b1-451f0b54b6fmr23276895e9.32.1749040337673;
        Wed, 04 Jun 2025 05:32:17 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8006c21sm194467085e9.33.2025.06.04.05.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:32:16 -0700 (PDT)
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
Subject: [PATCH v1 2/5] rust: helpers: Add `is_of_node` helper function
Date: Wed,  4 Jun 2025 13:29:41 +0100
Message-ID: <20250604122945.3445776-3-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
References: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
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


