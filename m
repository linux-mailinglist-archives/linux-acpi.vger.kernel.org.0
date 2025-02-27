Return-Path: <linux-acpi+bounces-11548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D169AA47DED
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 13:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4927C1893362
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552FC22D7B4;
	Thu, 27 Feb 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N8sF/g18"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5322F163
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659826; cv=none; b=A2+BuNkbo/rKALKNgwSZ377py2Dj9lainhfebT0nvis76qO3gZnUHjkZlsBTmwY0wpu01W089CK0hdZ1SWEMJ2FzhH8jkCa9ThBttW4xYq5NhEZ6ISI3aFCyUuzGMXtjUNfvyEZI8wEVY1lEZBisAXe6q9L+VF+FnoPJuJUYy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659826; c=relaxed/simple;
	bh=Z//TrE4r/P2ORzzHAfm4GTTR/FxL7V8in1j3CWT877s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbyluQ4cIUTMpoFzsmYm4Kti5nGDu8TLOgQHE9Fn9SCXpIRiVXOM2XDKO1eLYQ9YOZ/Zb4VFZneOoCoSWKDjb1OQfmPo4N7VKv7D3uktyJYKB5t7nDEi+U/blbdpcpVb1qQx4h+rMcalTvKDpBZnXB+9ENiaFeOSmztSbQuUPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N8sF/g18; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c8f38febso14516645ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659824; x=1741264624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtQ05xO+EnCCpS3XXknTi9mJFSuRz+8Y7aZxhDwaUdc=;
        b=N8sF/g18F4mULr2QnOeMcijsv9rbPzKDiy535tf7ppdmm6v90UZrtJ+px9jcdoKXXR
         nc2bbymnOr+QWE3R6+lNFbdCR6Dzye5GzAAMBAJZ3u3BZEBpCJ/KBhBcJKuSUwPJYaps
         wnFoL67qy8MkzA1QCI3Njl/g55O+s1PNcRCd9OW70JKtoQFwuqd0nvsWVsOd6x7ayG5O
         4uwbHPvTklIYnX1VO+UcFvY7cQ/wf+1GhZZRsS0vXrmBOJW8fJtQwS0FhVzSNtQT/rrt
         RqqKtX0SSI1b4AMgabkD/VhcU+q6dp/RbY51yghXY4GzNbElV/VTJZGatbR7r2s3ePH/
         UQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659824; x=1741264624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtQ05xO+EnCCpS3XXknTi9mJFSuRz+8Y7aZxhDwaUdc=;
        b=suT95i8eTGUSQNCp+Qw7QhiH6Da17RFhabs7pWAjW9OogNB5iWdcIMHlsNzgFnmKDf
         n+WlFcfyiqHnyl/tLgQBVQr6s/vARPb4TOTT/QdiBAEij0p7/IQ4g445pDMpBemfUt2Y
         3dDY/JTGN15EBAl8PFIPCdA9Bu1MFrYbhpHCqKc3YpHx9mx40GLU5cjZ2NaNC8iT3RU9
         pyt/IGGPYakx/HudHNrPPfHh3aCbynud/fKwi23C/vOlsnw42HAiJNF8T//bh1Qk6nAd
         i1GlLjSwUB3c+Bm+4a/5n04tPcb5O7vfobDJXKTSZlj/30Uf7Rz4vGZw16+Er44scfyZ
         kRFw==
X-Forwarded-Encrypted: i=1; AJvYcCVL9gFIysY2XrG+zPngCo6Bd+RsPBD8tFThEx3j5Ypifm8PaYxm3DPpXIJWzIKy/VS6/wh3pjdK3L/B@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7ZE+k+Gxzotf0pk5INopBXPwBNEAJr87G+bNRdkg6kaAxxTN
	/4SlawtqW6uRu2219E6UbIeDOWfJZgo/q6wu7gTRxnuNzHYtMvUb6deichSQ+EM=
X-Gm-Gg: ASbGncvtg2UuvrkD76bOqc8E80z3S2jURJKSkSp9l6J+T/wQ+Ine3ubuoDcgmq853SV
	cN7h+jmDgGz6QbeVk4yUgBlYB/tjjc4vSOeaSWofG7xFahHG9zUoUVJOumYOI0OkJR0LWK8bern
	WmcEJr9pxWqW4FSFyP22Nl0oy9xcZ579t0ayA9GSZ7CNBYuoc5tar+RXgASky0nsUtYeQoIa0m4
	1JqaeoQ+FYEh3aUdQiC6Nw44tfEzOv81vwhT5KkBhdWkJbprVXTCZXPih+8vj6uK0aYo5ovRJha
	eea3eyD2KMoPlVbvGJuoXFQgLJ6zU8VfQGAE
X-Google-Smtp-Source: AGHT+IFkP7CS9xqANnPn4d9Sz+3RrDXTk1H1Jji56UTUSX5o72PLQQPlMQJClQVJhKn4XxMTw6Hpiw==
X-Received: by 2002:a17:903:2288:b0:221:331:1d46 with SMTP id d9443c01a7336-2219ff8278fmr376544635ad.2.1740659824356;
        Thu, 27 Feb 2025 04:37:04 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:04 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 05/10] riscv: conditionally compile GHES NMI spool function
Date: Thu, 27 Feb 2025 18:06:23 +0530
Message-ID: <20250227123628.2931490-6-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b72772494655..8a1029163799 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1231,6 +1231,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1249,6 +1250,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0


