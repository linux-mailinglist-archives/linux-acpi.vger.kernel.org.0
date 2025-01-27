Return-Path: <linux-acpi+bounces-10840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA9A1D3A6
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCFF161769
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AAD1FCFEC;
	Mon, 27 Jan 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2HmUB8Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC41FCFE6;
	Mon, 27 Jan 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970766; cv=none; b=QiAdB1RWPPPT2mWH4+ZGbdfgbwtpkRgIiBW5cFcGH53rQjgvtT4Qun4Md9Kx3E55yw1j8pu+OoQK53dVYhffHWTmRmjngIqQMLp5mINCrBPV3Gbl7PauCQJUDokN84yNtzdTXIej2QJyqx1mTTbxRl8o24reRZIlWuGQYEGUNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970766; c=relaxed/simple;
	bh=fAwoLnpoPz47PmBAunPSbxRMJUHOaZzW6Ywv2OukBbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIAMUJDH8R35SJgXwZNgTMf4TBz36SA9fAghA4JGk+xWXzHk0n3kj12B4OD6uWt/d739a6TwceIzsfB7dy8cdsrPDZ7mEQokn63s9m0LVaOI4BGk1HyuZjXg5O8NJC9AflSW5gecwe3DG2khmmnle3KsTK2dRvHiKcG7eQunq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2HmUB8Z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163dc5155fso71736465ad.0;
        Mon, 27 Jan 2025 01:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737970764; x=1738575564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BU/+ngc0rwkOA68GGUKrKhCFkJ1MEoDFNReGer82ENI=;
        b=b2HmUB8ZDzykiRLu01CygR4mbrfHllWe/4LG7WbQrX8+IdToD8kKo1+qQa/fI79sMq
         pBoMZDQ5gS1b8najn5r5XfZlsAEl619S30SVNmjFdh7fKAhaVRueN0ht6x7AE1/3ATcD
         YXZ3AtYJmuOTMC3t75EXejcXyOBA9pD9IGwQ0+rcn6jsiuU4cK2EhMQCL5kGqY7VlXNB
         LcMDxMGRRvUJnbJhXvyN+6F9RWp4pKBxAs/LYGOr4HtkREobVlIqkbXIwNNwF8s+dDGk
         CgpRXjrmDoKQyU8yP9z+zLmdKH3eNstqQqWqTXohtNBCdTimbnEdSY696tz8HdLvvLgJ
         5qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737970764; x=1738575564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BU/+ngc0rwkOA68GGUKrKhCFkJ1MEoDFNReGer82ENI=;
        b=DXe2yAENtczgIzcxW4auY1SCbg0HfcGMySSgYGpfku9Nt+ieMZ7wNHh5dWBU4LBVnw
         lTFe7fB1QhF2QR1V7LJ8M/uuUYqfeKYOKofcEn0tsEGpbYiMbKpnWCP/mfQ8HgwJPK3j
         RkaDqZpB9Kx920YdVsvLdYhFclFX4T1pcBKLUQ102+kxrXEsY+11lhfVDREWv8abWJcd
         5NWphyksUUY/HxcgiywkVH39kAjI5PEqqytJ/I4E5f2WhDf3ER/bqabPTAcHkCW4+5G1
         Umwvu3kv4N22Jsu1c3Q3CT+SXrrYhR7SPn/zlCf4rW3qWu/PkUUfgeT4hTMNGXbkKLr9
         b8iw==
X-Forwarded-Encrypted: i=1; AJvYcCU5fGqXjGHZHWMiIUFkRjzCSjfDCy/jL/Z36Y9Z9nbUt7jGD+2o6FoUM/r5whgVJ2rM1D+Zr37gUuUqkUJR@vger.kernel.org, AJvYcCVBFGsrnwAf5DKNg+pbpuTZgkcSUejnJekO3X4sEey2mERc6cFBZkOXZGi2hwwDS4S+ZwNM+RZu13wa@vger.kernel.org
X-Gm-Message-State: AOJu0YwjI6dU/3gKUlzbrLJKmQCYtKYwisLOSedwm/bMdN1NGBasU46n
	hZFWb9gGVtJwFuAWJAeHnw344I55CDD163oFl1Cs5bGQzz3fAMHr
X-Gm-Gg: ASbGncva/iUQ9dL6Hc/P9NbydZUlTFHiVWoMzj85dOQi0g8aIisemAUVy8yN4ebA0aI
	/sIBCYwbxC3aiPgxtc0ADtEgbEgBhsMg/OGWVdKKtsE0k75E8rL8RwhO0j8Fg8SXwt2wnK5rsBj
	8fxw7grET0O6uu8TS9bWpqkKl+eG8DVmjH6FTxyET6pomxYVG73pTEBwo4yikIwFpUB43fOOXTV
	d5JX5ucdwIcfAvnX+Z2MzRHrvDisqVnB1pkMuL7rpSQSiSZ9QA/ljaaSW/uDzYD3pdO5FTIiP9a
	+s6sk5TSzheYUMvjnkkaQTI73F7Odt9lIU1xcF483kbKWpwCwSoUj+pfhA==
X-Google-Smtp-Source: AGHT+IE85ened9sCDR9H7KedNAjHvfIVQPwWkWoRLk86Z6FbVIvSZFExd7ci6WpZfwwyvsuaVoiEIg==
X-Received: by 2002:a17:902:f78e:b0:215:a05d:fb05 with SMTP id d9443c01a7336-21c355dcf9emr623095975ad.32.1737970763975;
        Mon, 27 Jan 2025 01:39:23 -0800 (PST)
Received: from localhost.localdomain (160-2-169-228.cpe.sparklight.net. [160.2.169.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da413f712sm58474175ad.142.2025.01.27.01.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 01:39:22 -0800 (PST)
From: Gannon Kolding <gannon.kolding@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gannon Kolding <gannon.kolding@gmail.com>
Subject: [PATCH] ACPI: resource: IRQ override for Eluktronics MECH-17
Date: Mon, 27 Jan 2025 02:39:02 -0700
Message-ID: <20250127093902.328361-1-gannon.kolding@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Eluktronics MECH-17 (GM7RG7N) needs IRQ overriding for the
keyboard to work. Adding a DMI_MATCH entry for this laptop model
makes the internal keyboard function normally.

Signed-off-by: Gannon Kolding <gannon.kolding@gmail.com>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 90aaec923889..b4cd14e7fa76 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -563,6 +563,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "MECH-17"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
-- 
2.48.1


