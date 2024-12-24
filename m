Return-Path: <linux-acpi+bounces-10294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9099FBEF1
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 15:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA36166724
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5E1BEF75;
	Tue, 24 Dec 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LECwDeSW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223C1E4AD;
	Tue, 24 Dec 2024 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735048968; cv=none; b=TgaQ2zFqdeehRWlKcM/riVeLFP1GrLOXgvOaQUgoz0OZlv+g5BnAti1ViyRNINDZuVq+P/NNmMUFLxbEKPacRc9CWeA7xZv8lc3ZsWuoPKQSIt0hOlCYNZgLKHAUUYjeRCdnvPocngYwchtod3K/35fmT5LbifFwjT2k5rok9Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735048968; c=relaxed/simple;
	bh=mm5t+vDZxpcLfc+zLossESBR8FPFq8TgP4dqWpK16Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTVug+s0fBo20Stx/wLXoJ4JeT77cT14ooXHKSFatcgj/z6AzF7Ws31Nvret/IfJt7b7zfmODq3T97ANj66OyZ2UWcfjDtd4IHs+PuyAr1UqdB73Iiu1h+GKEHZKYbV1jq56BdJ535UfzOUo4ACWKDXmylKdpYYn4eHNU6lKEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LECwDeSW; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3a26de697fso4410846276.3;
        Tue, 24 Dec 2024 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735048966; x=1735653766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMT9wD1DBkXEsFu4JGsu9qb/61ZjdOZDRwzwISnYJTc=;
        b=LECwDeSWI/TnQsNIN2Ikhr50EDi3/mU4wzL3mpVvQcqHhdSuMgKTVA+0L6CniyyZks
         gSAS6m96kVA6ZBnmYVKZbiiQDxH4t7uTxz4Y2xV5zZy8WGtL7bPrFcHQllWdIrA36+W4
         XxriPk9p37ZWeY6vdCUztqh4d+WuGn/C0cbtpmsi4KhADHJA6fuSi82nsV4ZimSB7mmV
         yns5nTpM5u+4uth+Hv9n8wG7fWfGsYRlXLq1sCkm+/Y4iwPJ3JfoNhf9qKVjek4R20BD
         5cDz+Q5fGM8IAdzq5SkeacbSbOjxsK3IJix+NgW9zxaGyA/Ww554jmmEpGBpj+j6ZusG
         Bsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735048966; x=1735653766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMT9wD1DBkXEsFu4JGsu9qb/61ZjdOZDRwzwISnYJTc=;
        b=DRpr+o7cHExnREgq22BNee5bNm1tpFzW167uTtbovVDz3TIokOZA7BZmAFVZ9C6JW4
         VzbvBLwBM76pgSoUM4vuelcIBRw6+u8lwsnezuDrj48gsin2n5L1veeGvQIsnrG9X1Tk
         Zt7Rfs+kSn2NkAgfuYzNJFSNPZBlaKUTV+fr8YRUEiv6Q/zvE5eKSGd90cdF2klPFU0P
         gNUnV9CTbEUcgu5XEgSc8PGbSFY9ZrgdCGu9mAMz9nb4+biF+3Vlxf7F67eG/0rFhCYe
         GKPDncfQ185n3thbqwvVdoRHAlNOcTqFnkst2wgffTf/INkuqEBOGAFLQ/R2dEivgSpv
         3yFw==
X-Forwarded-Encrypted: i=1; AJvYcCU9n3VppfXBBhtB2t+XKRNo/H5SKh+9fDnU5zFYWSvQAPfAQCoxirx1KZcXgqcoRaaonJEnuhywg825@vger.kernel.org, AJvYcCXU0NztpTlIp2RX6fdREthKjq9nd+B1nSsP9OLJJRCA3tVncndI/dK3ty/Zi61N9mz9dIAjq4T3KKItjuRw@vger.kernel.org
X-Gm-Message-State: AOJu0YyCz4oKuP8cj40RIdnuhMgi7i2vEWxkaapDsrwST9p80yzvVWf/
	0K0XA5iqdd9sJ9wRhSaaKFwp8ys2Ro3/zwwhnKpq0AFQ+caI1E1/6DmhAA==
X-Gm-Gg: ASbGncuMulX4MGEAs9p7CV/qHZsVAmTYPax65ysUSapdNnEoGl/2rOjnJIhANoThbpa
	kTb1eXP3I1k4WO8pRl86Ea4ZS7RrVqIOyecsUwteVkVFKYn/mLBL6vcya1wdxNT50iD+HWFlUuB
	VwTAkWHVVskQOp0rDaTMmZT8kYOtUcdMH005WlVDk8K2s/+9HaJpz2eZyc3M78RthAOawhOYKnq
	UzzQSw554QayX6gbvLOxz1YrPc4DFgJEZfJ6cgi4QfKTX37Cp5B+6cpQp7rFnyU
X-Google-Smtp-Source: AGHT+IEy/ulUa/tD1bs/d0nlRXNcAVSpuHSqQGlMdmCDtsIRfOCa+C5DZsL3MOwiXTiJKlX3CfXqSQ==
X-Received: by 2002:a05:6902:2801:b0:e38:b85c:31a4 with SMTP id 3f1490d57ef6-e538c25d2d7mr10675561276.14.1735048965729;
        Tue, 24 Dec 2024 06:02:45 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cc79049sm2976051276.33.2024.12.24.06.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 06:02:45 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	mpearson-lenovo@squebb.ca,
	rafael@kernel.org,
	soyer@irl.hu,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 1/2] ACPI: platform_profile: Add devm_platform_profile_register()
Date: Tue, 24 Dec 2024 09:01:32 -0500
Message-ID: <20241224140131.30362-4-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224140131.30362-2-kuurtb@gmail.com>
References: <20241224140131.30362-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform profile's lifetime is usually tied to a device's lifetime,
therefore add a device managed version of platform_profile_register().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c  | 29 +++++++++++++++++++++++++++++
 include/linux/platform_profile.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 75a1415190ac..4c4200a0b1a6 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -519,6 +519,35 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
 
+static void devm_platform_profile_release(struct device *dev, void *res)
+{
+	struct platform_profile_handler **pprof = res;
+
+	platform_profile_remove(*pprof);
+}
+
+int devm_platform_profile_register(struct platform_profile_handler *pprof)
+{
+	struct platform_profile_handler **dr;
+	int ret;
+
+	dr = devres_alloc(devm_platform_profile_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = platform_profile_register(pprof);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	*dr = pprof;
+	devres_add(pprof->dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_platform_profile_register);
+
 static int __init platform_profile_init(void)
 {
 	int err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 0682bb4c57e5..f1cd4b65e351 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -41,6 +41,7 @@ struct platform_profile_handler {
 
 int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(struct platform_profile_handler *pprof);
+int devm_platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
 void platform_profile_notify(struct platform_profile_handler *pprof);
 
-- 
2.47.1


