Return-Path: <linux-acpi+bounces-12427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADA2A70BA8
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 21:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D271881F97
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5F9266573;
	Tue, 25 Mar 2025 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No1TN7R0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67445242918;
	Tue, 25 Mar 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935208; cv=none; b=ZNz7Q6cSRRcft/d2PZrEDP16tqgCwEXq4GBm6Rtl9M08Rk7uR66BEJ2zyPxUjqchH4ExsL5WOFk90pOw0wJ7ymQOXSZZNcbHtR4peb5pW+8DKMIkd4JJuHMpvqdCabeSiAGgNsGr28+zCAgEvMjQM7E0YCOmL6+FjEAlGQ8wLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935208; c=relaxed/simple;
	bh=D86E6BYFMd2Fp5J90ilzXhmKsq3mI7+tGtgKlnXeE2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V7Mr4qxGCojxixKSH1wZtRcS50u6FaeUL1hdyF0E7H3LMRLVCgwfSiywJO5zJPsAr1lAn+rVML4JD5aXlL+Ia9lYMx5x0iqbQW/iRzaC0s21KDWR60CEoMMr2ZE6xGqfPZ7egP1BKn9pcIh9AocPFRkeqzSf6Vtre6j3JIk/bK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No1TN7R0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fd89d036so125873845ad.1;
        Tue, 25 Mar 2025 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742935206; x=1743540006; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCSIZbSYnkrCmNqKo+NkuiBjeNp8i28kuq9+kFrqnns=;
        b=No1TN7R0f1gZt3LUTVLUMzYMdIzd+cL9IHTAbG0lQcuf4KTADtcvglQibrvmsK9BaN
         Qow1qgfj9ms/AQqhbmkCBm/g3/M2YEePOD39YbSMx9XGeZvZg18t/tgXnLWtLYKVnkol
         VIJ8pBxoKz0nlSgcWNpzxdQ0yZcL5eSyEzHLpakULhs72oekYRYGpi+yq34UItD9oZRN
         XDlOlcYVA55GvsFX4+X/t4kqJFa8ZuGMsyRIEMQ8D9uGhtN4kqjFC2txEyQuCIel2o6s
         0RfDrKQUPeXaKLesE7e6R/coc2myBB9TLSEIk4TAZBv9EmKZs+yu21dBL/MTCIZZhnYx
         DCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935206; x=1743540006;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCSIZbSYnkrCmNqKo+NkuiBjeNp8i28kuq9+kFrqnns=;
        b=iVIYX0FKGzMBvuLC6QdLqpDlzK4BRwxpNWnXdU53RierRNzqDPk+Wyjuamx1T+1COp
         nrtRvq+/Cte2drpbYUNyWuEYQzr9+zEzUd2FG5NGyvEQuzxweyKZPOm5Si3i6IgAZqza
         /5cz7qut+DXsPFpVx91ZbTm7XAPV9DHWKbu7/EsachsaFLnn280sZbex2DBUwIkTgnC+
         u9y6SYfeUEO2IqpBA33RrFn6lmdHDAN/onfau8ANoBrE20Gl6fP0dUL3ql6JrmWeFrle
         njMDVsrPsIhl9/psuskdMlc97zDUXs2PM66U0vyUzme/ELlCfc2wovKF5ncXAWt/kQJN
         s4zw==
X-Forwarded-Encrypted: i=1; AJvYcCU3D2CbewLbxPosRvYKJureoDr4dWqyawLy+4pYM8+d/lP2p/wShQt7CzXrpfETOYd/n3AE6MxJA/bq@vger.kernel.org, AJvYcCXgAGuVkdKDG8cMRJW7pPK/JqNlD8NK6JCEvWYehSCoCnYMJW7pxx3hgnaF1zO0EMwjdgNllTEM4lLM9qao@vger.kernel.org
X-Gm-Message-State: AOJu0Yznzudeiu6SZgO0vvpSEVbzeTAdgh9+534V6sRCn3mbeKkQ+7PN
	QjZ24x4XZeqGx/oRtFb2h5PFUyoFnCAzrLiR5QolvCJgrphwHLFH
X-Gm-Gg: ASbGncuzJlJQVZY2y4crmKlF5HRk/VhIbcMPvPhECB9bOrIt32fHy8lXeYCJLJq0jEO
	7gTOXDRR9fh7ENW8EWIRA9ymD1D0Q/s7B7bQqHtYjrDWy7epmarQUZ5i6If2Uzm3ORIULSTDEBr
	5q3AQmbF66CApRXRjXDGy1cLUwPgkiHcP21reMmJEOnVzARZrnd7ZKVfSqsMWGEX6k8EDx2hCUr
	yg8vHGJ5GsCTPHTVyq7x1uuoT9hPD+Rco9DqB9UN0Grn+eYbWQS6YbBVbu+QbE7oe9KLyVqEoVl
	/5fF8TOCSoXIDazwfyYqOFljbSz0OQYMLKTSZjkOkx3d
X-Google-Smtp-Source: AGHT+IFsrXEZJouBZVR1sHC3IfRdJf5FCp29tGxgVj0TxQnh2e8ChT8ApBwtcQBi31rolwXpdISRrA==
X-Received: by 2002:a17:902:f548:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-22780c7e29emr255787495ad.11.1742935206478;
        Tue, 25 Mar 2025 13:40:06 -0700 (PDT)
Received: from [192.168.1.26] ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611cafesm10967566b3a.109.2025.03.25.13.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:40:06 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 25 Mar 2025 17:39:53 -0300
Subject: [PATCH v2] ACPI: platform_profile: Optimize _aggregate_choices()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-pprof-opt-v2-1-736291e6e66b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJgU42cC/22MwQrDIBAFfyXsuRaziWh6yn+UHKzVZKGJokFag
 v9em3N5p3kMc0CykWyCW3NAtJkS+a0CXhowi95my+hZGZCj4B0iCyF6x3zYmdFaOum6fngoqH6
 I1tH7bN2nygul3cfPmc7t7/1XyS2r46IXQslBKxznVdPravwKUynlC1z3mN+iAAAA
X-Change-ID: 20250322-pprof-opt-caa7f7f349b8
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

Choices aggregates passed to _aggregate_choices() are already filled
with ones, therefore we can avoid copying a new bitmap on the first
iteration.

This makes setting the PLATFORM_PROFILE_LAST bit on aggregates
unnecessary, so drop it as well.

While at it, add a couple empty lines to improve style.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v2:
- Mention bitmap requirements in kernel-doc
- Link to v1: https://lore.kernel.org/r/20250322-pprof-opt-v1-1-105455879a82@gmail.com
---
 drivers/acpi/platform_profile.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index ef9444482db1982b19d2a17884e1c3ab0e5cb55c..26d7ba49e9dcff1fded246cb6b5c836b180e07e8 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -245,7 +245,8 @@ static const struct class platform_profile_class = {
 /**
  * _aggregate_choices - Aggregate the available profile choices
  * @dev: The device
- * @arg: struct aggregate_choices_data
+ * @arg: struct aggregate_choices_data, with it's aggregate member bitmap
+ *	 initially filled with ones
  *
  * Return: 0 on success, -errno on failure
  */
@@ -256,12 +257,10 @@ static int _aggregate_choices(struct device *dev, void *arg)
 	struct platform_profile_handler *handler;
 
 	lockdep_assert_held(&profile_lock);
+
 	handler = to_pprof_handler(dev);
 	bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFORM_PROFILE_LAST);
-	if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
-		bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
-	else
-		bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
+	bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
 	data->count++;
 
 	return 0;
@@ -305,7 +304,6 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	};
 	int err;
 
-	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		err = class_for_each_device(&platform_profile_class, NULL,
 					    &data, _aggregate_choices);
@@ -422,7 +420,7 @@ static ssize_t platform_profile_store(struct device *dev,
 	i = sysfs_match_string(profile_names, buf);
 	if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
 		return -EINVAL;
-	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
+
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		ret = class_for_each_device(&platform_profile_class, NULL,
 					    &data, _aggregate_choices);
@@ -502,7 +500,6 @@ int platform_profile_cycle(void)
 	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
 	int err;
 
-	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		err = class_for_each_device(&platform_profile_class, NULL,
 					    &profile, _aggregate_profiles);

---
base-commit: 9a43102daf64dd0d172d8b39836dbc1dba4da1ea
change-id: 20250322-pprof-opt-caa7f7f349b8

Best regards,
-- 
 ~ Kurt


