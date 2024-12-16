Return-Path: <linux-acpi+bounces-10160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3869F3C84
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 22:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D15E162739
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E261D63CC;
	Mon, 16 Dec 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+n7Bm4s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E61D5150
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383849; cv=none; b=cZfM83WVz/hjjyHVipDN3536drkXhbFKkrgN6ZovP1jt106S1drNzACm7woRAr14cX0QcInRZXBInb22VIxu5cNu2y936r2f2G1Rulc9EUqy9UWEATbecRHJsW1gYgJsjrC1CBVgSzu7jM6ZOj6x4115Kkq1BG2kWR6PTWyIYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383849; c=relaxed/simple;
	bh=e7SFMwzDWsXgzO/ZNzsWTCVExP8H4avRE4Psyn2EYBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Crad5TRV5pvPmkcKzKS+Bbf0DuUUxWun7iRhNXK52IajWau85/rztZDWdgdtthlI69MsqhC4z3f0UVV4s9xfqBpScH1wQrNM1hMM8rKZyIOdAe6/oWCtqPBMicO+aYFyUKWDjkb/lnI1H6VQyd+FEj7BxF8sqxDQ9LuHk6bFF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i+n7Bm4s; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4679fc9b5f1so38514651cf.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 13:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383846; x=1734988646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wrx/XZpVy8CcSfrt0QCmmOTT7oU2GR+FF7o9rBsUVb8=;
        b=i+n7Bm4sReOYy2is0Ik2ld+rfDnMgcXNbiTuFJ1dnSXDVn3+nUqdzXnM4x2DVcAuj9
         6QmUyC5Ak9ZyJ60EkyD7e1aDHLcbwFvuVbSDl9sfmnEpeDRHc0MTSMemosc9KEATuTj0
         1k1dFsHB4MThXVJpPJt6OAQrErapz1VA+sCFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383846; x=1734988646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wrx/XZpVy8CcSfrt0QCmmOTT7oU2GR+FF7o9rBsUVb8=;
        b=evgM1OPkm409DxEarCspJgeJbkAEZ4M6F8pvxgGMHVx/g7HkWzctJ0SMsekwSoWbbF
         xW7k3yyusgqkcBtuQl/un8Zi46n/5C3BM38wivBuR1ysozd7aZs0HAtauG3Zc+VvvVsl
         ANM2M5SJvf/WAw/+xhDEpzbdAeEI36ej+eS91dGOWFYPnW/AbWttzNvzFkADsHcEpuKS
         W0KXo9kvfx+16MSMDkDhL8MvW2toZ51xSAzKGb6RwToT0KZuWruKT13phFIrvVE7TvLD
         xkJR1jmRnZo4oZDcPkWeWYY2rgbnCAHhjYNZAJ7RNKYIKxXyobGjLgqZslOwlOJMppaU
         vBDw==
X-Gm-Message-State: AOJu0YyrAAwvAthedFWojHEYHMl+oKnhop22uiI1z+dBW6JHe6ZkYIrN
	9uCtgP9jo3ztfKM/9TeeYh+rbywEWLTC/1ZdmhjSli1pL+mYGMROLVVKz/ec2A==
X-Gm-Gg: ASbGncvN6p8ceyJfwHaMJTKV5cim1AmH4iisrdL0KtSK6xM0h68UuXlBShpYKXqP0fI
	QecW7pxABCjtwJ6fZVwX1hlf8SK9oEFK+4H4jTAEQbu9wLCl1GE1vNkl8/5uciHKqAwUCWHN49D
	jMl8K14Rqk68oA33T0+cRpu0XBbOVwz1EwEUlnPm1HmOQ6qMlez892WKZKlkWt4JSr3TiV1s8a6
	4t7MQkdvn2oh2GA1JXKN3oJunANcsCJJgIzcx+eaHlKdEuuwdHe5JQ8RZaHaDNFEN/CYcbBawit
	F9Sowmf2rvnI39uT17t/Z60IafaGCrU=
X-Google-Smtp-Source: AGHT+IFe0W9f2W39cOFyxGiYpi+wHrRevZyo7XAuH0Mr2XhLF/7Z6NTzZgUOvov+yVRzbUrbAYKkSw==
X-Received: by 2002:a05:622a:115:b0:466:9a61:273a with SMTP id d75a77b69052e-468f8b66f1emr17164551cf.52.1734383846255;
        Mon, 16 Dec 2024 13:17:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:16 +0000
Subject: [PATCH v5 2/7] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-2-3d6b35ddce7b@chromium.org>
References: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
In-Reply-To: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_dev_match that can be used
when CONFIG_ACPI is not set.

The condition `false && hid && uid && hrv` is used to avoid "variable
not used" warnings.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 19f92852e127..a9b5a5204781 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,9 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
+	for (adev = NULL; false && (hid) && (uid) && (hrv); )
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
2.47.1.613.gc27f4b7a9f-goog


