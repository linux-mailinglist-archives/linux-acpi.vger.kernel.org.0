Return-Path: <linux-acpi+bounces-6628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44558918200
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 15:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7AF1F24693
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B759187567;
	Wed, 26 Jun 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZLjufHX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8519181CE5
	for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407400; cv=none; b=Ij5HqWEdpb/Xc0pqg5EZmdhJrdOhKzzuJTzeynM+jI2pu7gjg9TGVTDbna2HvKFe5wxDVaZruUe5xXPxyKSNDBuyHuF4IIni2f1a3P6/c2fE+KCqWBrJP1r50unnfAoNz8Oext5ivbggO9OeCHI9iBXD35B3nKgSVmap/VOh1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407400; c=relaxed/simple;
	bh=0GMiRghiL0posL3lrMPp5WIHVaYiKqjyKnFHan3H/Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPwIXUDqTS7tY1KnjHHBGVYQqYb8Xeu3FGYcIychRDW075SeI4Dkwzukc1zNztHMS8H6dn+4NIgWAMjAbeyZi40kPJ6N2cgxJpAuMPo/xhUbjiyctT/X8S/bKlqsK7ueiexIILZeVnRPqnIX2UYVuTiLyt49NfkDmzStQ+FOSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZLjufHX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6fabe9da3so54488785ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 06:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407398; x=1720012198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FeCRNCHw66f5uF47Aw5id6R8f6m2JpOZR2R+WLXG7U=;
        b=fZLjufHX1U0TcowDtNOMBuGDv50YBiMKd8xxSBdhFX+EKZexZ1KOIyyLMBL7v0615H
         aOJRbgl4JaMwZxThzGHh6Q2xqnCTGBUo7WtOWUVt8ky14i//G75esHhu8RDMeNcauNvQ
         Ig6DgnACpXKTFmY/cgePVwioISxMK7cPJ0F/OVH/UAscjd0xGoLM0Lnq7kLQ7KVSHYgz
         hMBwlY4N3MKegKhwxK7U3REPjdS0qgS2557234SCK0M0mIb2YD/skLXcxcuypLrxzZNn
         Wa3qza4bkBhVenWbZRYrzvwQ3QlpNRJvEPxhgDV2odrzZ3DjSM59wi/YnXDEeCT3/3jW
         eXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407398; x=1720012198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FeCRNCHw66f5uF47Aw5id6R8f6m2JpOZR2R+WLXG7U=;
        b=WcTy7nAl9+VlslFDhbbcsPVH6nAZtBSRpkLhYY48PYvdray05m328eTEWRIvGhqh3v
         5lsmBQXispFYPp6SCJrJMr5wfbI7nlgZgP54PToI84AoLfcywbBGmI460IBlZT+ScXCH
         QWNOeZWBB1YFoEUK31MHKInHKBxUv0KSumXEUY+8Tyyald5aN4qaGiDAkGY/4B01/lM1
         v22xG7ixLBgCjbYdw3jT/Se0EE8aOMGJ6gUCgN0Zl+f6J1B7h5FwI66Jx/LhjHfAzoNa
         0TqNR2gSyZWcM5/49LzF1VbYlsUMS5ozv5Mvvxlp1hqPac/3xVzIJaM2dHq+KmLQJnWr
         wCZQ==
X-Gm-Message-State: AOJu0Ywsk00+vX2aHfDiNCe6sJ9c8We+7zKKnLSlMUXI+neZULfkVAHq
	utdvCZT/Sfs84ryRnDhc+aFUHBtApvxnAj5gto9uNxhJupUrsoX3rbn6mQ==
X-Google-Smtp-Source: AGHT+IGz7Yk/pcB+38Tfc0zFlGYMXmAQdSrhAE41htgySAQqgzOptzSP0CB8EcT/4D7lkWG2yzJIsw==
X-Received: by 2002:a17:903:2302:b0:1f9:f83c:8b6f with SMTP id d9443c01a7336-1fa23f15ba8mr110511475ad.51.1719407397705;
        Wed, 26 Jun 2024 06:09:57 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb3f1esm99049695ad.265.2024.06.26.06.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:09:57 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH v2 2/2] ACPI: PM: Use max() for clearer D3 state selection in acpi_dev_pm_get_state
Date: Wed, 26 Jun 2024 09:09:41 -0400
Message-ID: <20240626130941.1527127-3-prabhakar.pujeri@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626130941.1527127-1-prabhakar.pujeri@gmail.com>
References: <20240626130941.1527127-1-prabhakar.pujeri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
---
 drivers/acpi/device_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 3b4d048c4941..a90ae059fb60 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -760,7 +760,7 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 			if (!adev->power.states[ret].flags.valid)
 				ret = ACPI_STATE_D3_COLD;
 
-			d_max = ret > d_min ? ret : d_min;
+			d_max = max(ret, d_min);
 		} else {
 			return -ENODATA;
 		}
-- 
2.45.2


