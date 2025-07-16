Return-Path: <linux-acpi+bounces-15192-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7326BB075D3
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 14:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452F57B8167
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373562F2C58;
	Wed, 16 Jul 2025 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIhaCUc0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0C2F4A0F;
	Wed, 16 Jul 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669381; cv=none; b=K3P/JdtpK+JR4A+ScGwfzZ5Z+BGf/VIplhS2GC9NQCavlL3tujLvaDo8lPvcN9UI6VqpgIpD0cQTS7aFJaFNUt/vD/OeOJlQ7AUPnEmZvGkkS1MJ1SGk4ovvMAztcEOqNUX3yAqwcO0M1SbOjvgkgaKnuIQHgS3wJYDfj22APSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669381; c=relaxed/simple;
	bh=MhPnxBCaHsMGyPMqBT8rooSn67JckirHUam+E7Tp1vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJh2PDBtNuju+2d6wmAa1VhEYicFrqP01/8G7bl1UmW2X0fT3JPQFm7CywWisRnyvVLRZGfte+V9wnyaPGuNa2nhq2whylIgyNvgSPDo1aEhz9ZsT59KdxhDTXwxp9Y0ZRyXpZJw1ngh7MZBu2HyNKnNL5gs+JMCg634iQm9SoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIhaCUc0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so1595905a12.0;
        Wed, 16 Jul 2025 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752669378; x=1753274178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCpLTOnlJ+qMUDZelMGJUeO9FUm3yBfJ/9TU3z+9NFc=;
        b=CIhaCUc0xt4CvmrSps/gWJjzgWWnX2wizASTcBGk07gZ4NUZei1Tsw5s9uujYvPII6
         psI7NWebse/ZNGItv3giqwaAotNdPn1fg+YA82c33Z307zCyUPgVCpJWNUJ4O97eHmzO
         aDG9LC4v9lH+2QD9+IzGVUeoPMuPrBkZJT/nBYJj6Q2RRKzUYHWoipOHHjrjdFAfqVwb
         42VWSZmDmOZ9NK3uVEcUWj7/CDa7ryDcqh++L4vqWC2IBc4RqVups9pkSJvUlBspPYkW
         /ES4ge3ndscZl3St0idw39eVccr0V29CDBuHlz7uEkA9YqEe68jsLUz3ITDbbiQlUYZx
         zW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669378; x=1753274178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCpLTOnlJ+qMUDZelMGJUeO9FUm3yBfJ/9TU3z+9NFc=;
        b=eVHEUdD6oVZpVuBu8tQuOMmDM8utBpzCSOmdbZd3nKAPZ8R3cqFuCLxemMNGHMcZ7R
         a1XTsSvWJmY7MiN68uKhvXzF++JRty4cVodXK6YQUJGGSl49krAG6y7xTuIuAHkuJhD0
         wYpnPcMCKJDU397wax+LBOG2Q6ixR47c6Jm4RFdjqb5DGSn0rSIjVVxFSFnhSxTLxUVP
         RgeYVrn1bcgqgmXLJ/L4WwJukAwEqWsG36rb8e1eWbq7noNG+zRbjstRCOZhxgLcTyFP
         Jxd1ZFZq5AZEeJhxyKEpazpoPnO8HylODq4fY2/5SW7cFhbA4VdM1dhAPqEvaPy3muJ2
         iBMw==
X-Forwarded-Encrypted: i=1; AJvYcCUoFUkIQww5w3Ed29RwCPn7hFfX+nn/sVmqqpEkITQh+fZXw+4PmHEObi8rmSAO3ElTxjWhf7pltCrs@vger.kernel.org, AJvYcCX4pWwsKQi8MabsGIz2wT80MGRm33XAFl+ZpmvJPGebMUpetv6DiCDJvoiO8TpC1dIz1EqPr3kuAt07uBgy@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQ/+nJ5vX1xfgiunRb0Zw5/YZBI2iowmN5iz4/cDXjPIYjqw3
	X5ql/nGWNpXh3jNLhjhITtRb5VOyGzjfPq7AJtoLDtywoLUcjZ+h+U4V1SWhZuC9yz8=
X-Gm-Gg: ASbGnctuS2fcWKQZZ1nVnjaA9r5EvchNJh9WxbeLBHPucPdTGcshMmIPUGf6UqHCdMf
	6gp9apk6QoLb2b9p5l1JO/Pu1rZxCMTAoNrXZQeiVkQs30M13y7Hoti890dUiv/6055+TOIiBL6
	3UhOtqd3M77edsrJ/cUvZ0wyFlMMO2WBiNNSYYReMpGmWqo1FNO8APqdqHOZDoukftu3FQ1Zg8f
	5k1Foc+IbLDzJ1uuR+N94D9xROK2zsarGwsSgV7pWnzHw5Djqmyfm6mm6DUgiuONWhXqhrAqDXZ
	GCA8n+n6ZiX7FLUWL4yN7hJHXoqBSoLWo+s9btKUlWl6Iir9UA/qN2LPaM78HRt8qAYxdcv+O6y
	AiDE3woJyJI4XOtODgt6Jg+830tFv/HPUiYemt8+lcp/OwNZJR7+lJu8tLueJ3tqK0vrxrpiui6
	ZBc8clLgGuAkljoZLBC8A3iZzwhHLknpqtceERJLNUTA==
X-Google-Smtp-Source: AGHT+IG4AJ2vXsHWCqNgvb55Yup3qbwKkBsJJGe/HXtjGWR/IQElp1XokC6HEs28IFOzm4nDF5gZxg==
X-Received: by 2002:a17:906:c092:b0:aca:95eb:12e with SMTP id a640c23a62f3a-ae9cadb895amr223967066b.24.1752669377383;
        Wed, 16 Jul 2025 05:36:17 -0700 (PDT)
Received: from hsukr3.localdomain (dynamic-2a02-3100-40be-9000-93cf-b11c-7d47-1c9e.310.pool.telefonica.de. [2a02:3100:40be:9000:93cf:b11c:7d47:1c9e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82e3a8csm1192891466b.154.2025.07.16.05.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:36:16 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: rafel@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] ACPI: TAD: Replace sprintf with sysfs_emit
Date: Wed, 16 Jul 2025 14:35:43 +0200
Message-ID: <20250716123543.495628-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace use of sprintf in *_show attributes with sysfs_emit for writing
to sysfs. While the current implementation works, sysfs_emit helps prevent
potential buffer overflows and aligns with kernel documentation
Documentation/filesystems/sysfs.rst.

Tested on an x86_64 system with acpi_tad built as a module:
- Inserted patched acpi_tad.ko successfully
- Verified /sys/devices/platform/ACPI000E:00/time and /caps are accessible
- Confirmed correct output from 'cat' with no dmesg errors

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/acpi/acpi_tad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 825c2a8acea4..91d7d90c47da 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -233,7 +233,7 @@ static ssize_t time_show(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u:%u:%u:%u:%u:%u:%d:%u\n",
+	return sysfs_emit(buf, "%u:%u:%u:%u:%u:%u:%d:%u\n",
 		       rt.year, rt.month, rt.day, rt.hour, rt.minute, rt.second,
 		       rt.tz, rt.daylight);
 }
@@ -428,7 +428,7 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 {
 	struct acpi_tad_driver_data *dd = dev_get_drvdata(dev);
 
-	return sprintf(buf, "0x%02X\n", dd->capabilities);
+	return sysfs_emit(buf, "0x%02X\n", dd->capabilities);
 }
 
 static DEVICE_ATTR_RO(caps);
-- 
2.43.0


