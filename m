Return-Path: <linux-acpi+bounces-10163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F059F3C90
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C17165133
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173B41DB92E;
	Mon, 16 Dec 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OZKlqkrt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF331D935A
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383853; cv=none; b=U6ECWFyZje0gQYqtHwMmFA+d5O8DD8faOIQGO9jJnzxtnV3gSXHkygxTQFNAI8R45LRWR7IgXmnjb7ypdOrj+Y3N5wJpxrblII1deKI4RMedJECKmqg7Evn9Tjs+G/EiwvNSk5+vXf6RSIazdZRtVP6jbPVa/pjZ/ae8xAqByX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383853; c=relaxed/simple;
	bh=95QUI19i+vnnT5+G1KHFOpDSO/pMrFLiSHBGkodQPoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVz4Nw5NH807cIfQRQAbMr85WctH8aQh92gBIph3Q1EI43ByejrGhY0GhJbprOuLo7onAWmK2thQCvUuvf8FSqBa6YhtEeYxov4IOKNNHl2pQtD5EZPMT7vC6KwwrljbOanM21lnSuqHjBa3sc5B5uN8pR0dY3aSkedF2BEWJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OZKlqkrt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46677ef6920so38208321cf.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 13:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383850; x=1734988650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9wRik7VAWXozMa2pBEsGGs4ayCPfnrgn33kguAxeWI=;
        b=OZKlqkrt9/2ONupx19ZzXA18kP6cweiU/xz/phCbkZJv0oh8Qajw9vF0Y1tWpO8MBE
         R1kwkFWtqtyfkzDbyWgXHOPB53jkFsqq0SJrkILJ+zKZUmHrjcGbbzW+G50g+LblXBPs
         iCbi9ciTLTmUskmHGwYd1H7CDftzpPmg98WFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383850; x=1734988650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9wRik7VAWXozMa2pBEsGGs4ayCPfnrgn33kguAxeWI=;
        b=H05W1wegbS1fg1TFkQyatXCwfFAsrDtOkV4tx/x+e3vDm7bvYMpGKe611nHhmuwzq9
         yCgWR+kYuXUVBNwrvgCaVzgsVfKNjpsjhgTsoIp0OO5AqHWXtb4fR2/t+687xJgWbIHI
         hcHCnDOKSLd0SK01O1EPJNy5vseDHW3Un7OtZpYH95H1dahkE+frS5jt4HmghgP6ltQz
         uxQWcGmtMGYjcQpATeWXM2c6rrBqTT4iHo0UqsmIOEKu8+TonPPujrlXF+hxTVeLPpkR
         FwYtaY5dGbwzZBeo6e16ZgpKZl/6lyhZ0oFA2LStlR3nvUc0BzETNjLFVZHidJdjb/Q5
         ItXA==
X-Gm-Message-State: AOJu0YyNaCcESPBmwsOKmCUpQD5M9PIUQcdS1dw48gULabrNKzLwuIm+
	Qp89pPjFgrhJm2/kxU/QoMCQuTiOeCzRI2ZA54LSqF8jk6++dhZz5aznuhUPiQ==
X-Gm-Gg: ASbGnctwytexOSF7mQeWf/gOt3+QaqgA1aq3LMurY0G/TYDLZbmkOMPyVmr3VEGUBH1
	J4v0NtfjnTcz2PDTXCdg7fSobZcuS3G3VYTua7CJeMMcm4t9C9sfPWNv2Q1mzgl/U200Ui3hwGI
	adwlVKKd4sQ8PsMr2QjhpyuCFrrqqm2FBUCN+XXzWaqS8plu/Wvhb+bgqJfJYdr0tvlVWUj7l/v
	H4sM3Z+LYMk+zjEJBFGxUoT7f0JD6/VUYtISPpwAJEpzRb7IIlR35c6eERDJpi15KxkcE6MKBd7
	eXeI68KxV26rtGJ9reiyl7mqur5fr5s=
X-Google-Smtp-Source: AGHT+IEWoLxfSlaf8rXHfYGdo/dNrMIk3fj9viLQXfHndjp90WcsgvICJeewTTVu5HvfhfYK4N5nnA==
X-Received: by 2002:ac8:570b:0:b0:465:2fcd:cb0b with SMTP id d75a77b69052e-468f8df3bcemr12486021cf.24.1734383849763;
        Mon, 16 Dec 2024 13:17:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:29 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:19 +0000
Subject: [PATCH v5 5/7] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-5-3d6b35ddce7b@chromium.org>
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

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f38e8b1c8e1f..68c0e2fb029f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1009,6 +1009,9 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	return false;
 }
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.1.613.gc27f4b7a9f-goog


