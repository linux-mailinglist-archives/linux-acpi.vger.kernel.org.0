Return-Path: <linux-acpi+bounces-6474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13ED90C874
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDAA2871AD
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6D41AC77A;
	Tue, 18 Jun 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au4NDwXR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529191AC777
	for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704305; cv=none; b=ZhrO+hWDkFsRo+ytP7rvFJgR0MBiARiD4iVYMnEdjCSQreMzf8QzDvskWmkjV3m0IuEexDY2E4YgjugyWJK/qqlE2Ri+bP2TL5fUHmpz1KqoHHVWVz0usQy279VJUyaVUWBUtCU+x3DAgZqwCa8G8kjgN4iRUoJ+Tu6nSDcOUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704305; c=relaxed/simple;
	bh=1UEKZXEiHcznlwNYY1sOKe9kTsWIIfi4151yyWZPJ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V5QjrqAcZWedPWilkZnXABvWjE+xFEaHOIppIu7TGP1f7d4D3WwgdODCWk5C4ndKgK8CeYmxKll+z5z2Ao/hIs88jO4fGKOqZT5xDQEDTbZe9DkmjK9yzCnHxw63cZePtV6q3YEqfpUXQcvLhjnk1FUpZLbCkzOerNVdE+fXnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au4NDwXR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f64ecb1766so37661915ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718704303; x=1719309103; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apytBPxV5QWAV0tFy6GF+cxwKHn8bm3gelK1GxXYFMM=;
        b=Au4NDwXR1/dwkG8B9SSa4Cdtred7gdJnnMYQOmkga4RRQIT4NnVLGU8x2/jTtOffbu
         6y7oRlQNqyv57SlIAOVH36JN86e7ICrlp10EWV9gLFFZtbuHBH0LQY9ttTJ/kfLSZ/jz
         FjPnUs6hacWruTJJyiyczDgxa09GJRbmlJd6kv2V2x8KVcLiPGAdc0owLWMVwibyhOvE
         lVkA9TsN/WIjvSUsW0JfgL/jnylFLwNZDejHM7FPFptX/o0QZS80wEz/I2NltkB+lAk2
         R1NNzOoUsN3lrLjeZNa9RbhzOkt/WdMz6H1BsUodFpzLDsWUp3HDodc13oFpZoOg3kZk
         P3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704303; x=1719309103;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apytBPxV5QWAV0tFy6GF+cxwKHn8bm3gelK1GxXYFMM=;
        b=ZWlKhmpHPRtb1fTLpMRnu5Mmg8R5jvMoFERdxA1Opk8dTZDflwRh0bJy+dgTrSxnP1
         Bftd6iBen0yEvrzA6iBRt5IhGB/+Lo3RdhDehQJen3/tFT5Y2zxT3HfLwM8bpLi0omNs
         MtNCf86zuGDudB4B62aB/3FCuI2ol0DEpIAq3EU9lpVZyO8OgdpZSRUBiXSl9KUJeBLC
         X0LSrxv+XfAFzdAtqmgorni29iWY2A5nh0U6C62KGI68mQMKP0CthjzWW5mn1OBXA3gQ
         d/T8an3laJ0/WG4az/OPC+NrHbrNhiYlJLA510OLkk5Se4sz4xP4dcv8iuRKdgs3MySq
         i8qg==
X-Gm-Message-State: AOJu0YxBNQAHojNan4DCzOF1u8ZWR7DkbA3leEDpO/NTiWmQFNKTfEG2
	RN02fTKCwhC8DNK/NFyXLAn7fbqJEAvBGN+DeFPq1Dax8TCIZ6RG
X-Google-Smtp-Source: AGHT+IH7t4LcmTVsJ2bwQDtI7wyr5AYMFZUjxRQrovHqZk7ovnVJ4ngkHfg0TCOvNGBrV2g29+v/aw==
X-Received: by 2002:a17:902:e88a:b0:1f8:5a60:842c with SMTP id d9443c01a7336-1f8625c05f9mr132607485ad.5.1718704303429;
        Tue, 18 Jun 2024 02:51:43 -0700 (PDT)
Received: from ohnotp ([2001:f70:860:4100:e712:ac1a:da07:2e53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9969c4e78sm9624275ad.161.2024.06.18.02.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:51:43 -0700 (PDT)
Date: Tue, 18 Jun 2024 18:51:33 +0900
From: Yutaro Ohno <yutaro.ono.418@gmail.com>
To: rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, yutaro.ono.418@gmail.com
Subject: [PATCH] ACPI: EC: Use ec_no_wakeup on ThinkPad T14 Gen 5
Message-ID: <ZnFYpWHJ5Ml724Nv@ohnotp>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On ThinkPad T14 Gen 5, EC interrupts constantly wake up the system from
s2idle, resulting in high power consumption.

This sets `acpi.ec_no_wakeup=1` to fix the high power consumption issue
in s2idle state.

Signed-off-by: Yutaro Ohno <yutaro.ono.418@gmail.com>
---
 drivers/acpi/ec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 299ec653388c..c7d5231edca7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2248,6 +2248,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad T14 Gen 5"),
+		},
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-- 
2.45.2


