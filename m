Return-Path: <linux-acpi+bounces-13731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA48AB831C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 11:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332A44A4CEF
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71634297B7E;
	Thu, 15 May 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ABhYLL+G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D1280A4B
	for <linux-acpi@vger.kernel.org>; Thu, 15 May 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302254; cv=none; b=Uql2BdpKIJ/1tx08TvNP1hrWPYz2i7go+8y9PxZF+AKbgEeqoMhligQir1UrpUqWBly9Y07CwgtU8ndxia6qQntxjd20Ts08e9zmY8W/EWg8Znd/GeeNj8ZTzbsoyc3lHfpjvnq4XCA9aNv268lNPxalJY3VIZwLFHe8NmfRbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302254; c=relaxed/simple;
	bh=9GNL33PY49lW6OGb3bRrDrd7fcNA7Gh2hmvPnbryDDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R8T8v0HCPxIwFV+nDKDDcviftZD09t9l1UJ1v13BW1zjJLU5Mj+mf39yECnN3W7p2HcVTyTbZgQcK/2UsVEYRIvDHvsGEVe+P9nrdTBbOeKoLlDcxacWPdRKtRIcn/Ewe/HXQl7c7yXvC71D7rNZnGv0bBIyZ3U4RknMwMhwwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ABhYLL+G; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742596d8b95so962363b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 May 2025 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747302250; x=1747907050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6FV+5tXVPlvC+Cy3Z2x3GFn7teypKn9hvM6n9ipgsE=;
        b=ABhYLL+GiGq2PR/nvcerzw3z+vmBmjVmML2EpWI6MTHr1Xqcuhmi60fRJHcKDkj1PV
         qT29CUH5ygb2imSZhRymqeZXqz2c1aH3SIsW/RSxmqn7Qjt3dWpMmhWuu1IC1UYfQ/RN
         SdSL0/YQPKftP6VJP//nGSVQx9D3/vMOEd4ndinGtw09awh8VoZ4lqLWA7mGpM0XyV2Z
         QP7/+HZedidil0mIQftTyGxOQ6/QvBCVeVi6i+HfzwYq0CqX6x/uLqMk255keT+dADT6
         grGkG1BPwiXbME7IMkREBwYe93FjEEqwZDTKrnZotL+lS9qjonmDQPQYy9aknIKq7Tu1
         Mh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747302250; x=1747907050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6FV+5tXVPlvC+Cy3Z2x3GFn7teypKn9hvM6n9ipgsE=;
        b=KfDSVZMMBmmu6Prm9cm9KOih/g5X7j581ec8Qwp14tWuZdhp3Ya9ZlbeIZlppmefCk
         IH0b9pVi6+mPShdlRdhOv1UVEQTjXDV0bRZDCbokXJSI4k+5KJkSd5Oc0Ftin/7x4Z8U
         LQlM/QuFJCRj+3t22LMkvDsUaAFenqomlXkyyB7Qe4S9nny5rtZ7fkfRDPhGJi5inETU
         uRZrui+RpckjjPMRXoAGSAxm2Uw6jy4DFgfJAqhQK/JT0Zyla80zJ/5yj+h0LSRqtST8
         2D0+Ttf0MWU0dmwu914bHprIeX2O2eOd4wjhplL9++kOCKOKRYMDIFTinobwrZTirVy9
         pBfw==
X-Forwarded-Encrypted: i=1; AJvYcCX3cskvsQAiEtXYShYw8gg2OwlKjuqYKURuKxfyzZZFGkb1elue0kmNUh0C8cGZM5xUMUri08L5hqV6@vger.kernel.org
X-Gm-Message-State: AOJu0YxVi8i08GczYU5X2KX9s7B3bgUgR/CmMxaPMi62wmKSVU1O3cRi
	xWGAN5eyNSsBwHaMmJhH3evbvre5FaiSbFPdu7rEgICEkKMTyt1eebFV57GgVP8=
X-Gm-Gg: ASbGncu10M3VjlKL4LPV+2ZboSbIVYSwZ0Z1wAL0bu2VArIlH+jpElI1I7OpRGl0cyi
	mliFzL5iA8cBQ/qPwPmmOSPAsf9XSYAxFJbCyfuvT8oxXq0+XHhigB4vjCGJU7HioKC0r9OInJl
	4oYXVXy6HmLUeSYnwRT2uRakUUNpvjCobfCBa6O3sZNlQuOlzuyQO3o1Rv2/KHkPh3WzgffiWAH
	JHeyjG8PzdK/c/+G0YeaeLEks9ZLe50MyWvvWvWB0xAzRcF/PoCQ3f3BvBW+5DyqOdMq5144Nah
	+oBZAzSs/STLVaggxe15O0u55i4KJ2+DoDFQu3rfQ+HrEtaGNoA5uUB7acmp1tGztu1f6BWu0qQ
	riI2LOImlKW0O71aQ
X-Google-Smtp-Source: AGHT+IEh2dxMPj7kTH/MLpVyfxHPA3w9CgIogon2Q5H7XcXm3dZOwAfa/YfCslxFD2QlnH7LR4V86w==
X-Received: by 2002:a05:6a20:559c:b0:216:1476:f6c with SMTP id adf61e73a8af0-21614761195mr1115182637.13.1747302250378;
        Thu, 15 May 2025 02:44:10 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234941b886sm10299693a12.2.2025.05.15.02.44.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 May 2025 02:44:10 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: sunilvl@ventanamicro.com,
	rafael@kernel.org,
	lenb@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
Date: Thu, 15 May 2025 17:43:01 +0800
Message-Id: <20250515094301.40016-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the read of CSR_CYCLE to cppc_ffh_csr_read() to fix the
warning message: "CPPC Cpufreq: cppc_scale_freq_wokrfn: failed
to read perf counters".

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/acpi/riscv/cppc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 4cdff387deff6..c1acaeb18eac3 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -69,11 +69,14 @@ static void cppc_ffh_csr_read(void *read_data)
 	struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
 
 	switch (data->reg) {
-	/* Support only TIME CSR for now */
 	case CSR_TIME:
 		data->ret.value = csr_read(CSR_TIME);
 		data->ret.error = 0;
 		break;
+	case CSR_CYCLE:
+		data->ret.value = csr_read(CSR_CYCLE);
+		data->ret.error = 0;
+		break;
 	default:
 		data->ret.error = -EINVAL;
 		break;
-- 
2.39.2


