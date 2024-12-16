Return-Path: <linux-acpi+bounces-10162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E945F9F3C8C
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 22:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C7D7A5183
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4181DA617;
	Mon, 16 Dec 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fkTiktYF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22671D86ED
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383852; cv=none; b=oNlFmp5jtwGI9QagU/0U8htW/UGRbkLMrSbIwUA7boCXOGHVTdjIY7EOWMe3T1AaVzbqknrLYLEqmsJgBdsA29o6LCEDWXuquPxUeha35QPrS7Hlj9l/j3f8W2ChOM7Iv8/yxTTCb8X43WjiE0WdHKpi8uOqxDUDtv1ml18ij4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383852; c=relaxed/simple;
	bh=OSI5+enbqVnK80hh3GRt2v2/xjuyertlyl2dDt3BvaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5q2K0xFEeZYYb0d2miQS+0Psi3dHQ18QuHDk4fx5MRpt5ZZ32E1frkE6PVFeFy9pa35EDq9m1QcQ6UExIIrPX5KIvzm884uJLncIsJdUGT82m+BgPwf/eeASaacvr88C3gWjgWdmdHpZ7gao2/xmiqZkfPzhDz6wxUu8+s3YMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fkTiktYF; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4678cd314b6so45809691cf.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 13:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383849; x=1734988649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94GpRvEFGP1zDl7TooYa5XXxiXoizWnVF+RBMjgEO9A=;
        b=fkTiktYFTPmDeU9C4JP925QArvW+eKnHcm6j/H5w2zAykkSRytleeNs+VWy4zzwKTB
         +aYKjrb1UEjiGE6Du8jzPlIzSkdGhavIKg0Gbnk2WkrGHnPO3naJwCBiMxKlW8mBpNuN
         GOsPXWogbrd2ZH1g8Gj1fL7YemXx3isGnfgSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383849; x=1734988649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94GpRvEFGP1zDl7TooYa5XXxiXoizWnVF+RBMjgEO9A=;
        b=J1yggekVQ/tGKzZ/MfM66E1Rki9ltECV1abPmGpB7H9hNo2t03UwcGSvSXI+hUePZh
         sP4m7c1ZZKZV5iHf5zUHlS8Nw6OW0dufkIGfWfm/ASgyrlSweWfpobxcZXEOJK/3xlT6
         udKdSc/VUPaUgio41jrhWT/MSx/D3CbAZhLVFEkohaLGwpoyVt1IDnCUluCQLlvjg6fl
         Sjdlmz3sVlmVhHZ19o7qDEjZ5/GyEUi8aUfsAsuaS4lFxYU8d2gdCoJ0SBpCqqGX4Hk9
         eEKK4KpVVM4X3qGki4FZEeN5boSuRnOA5TawMITzkCm2C46TfVcy0wdSnRyNnqrm3I2T
         bvTg==
X-Gm-Message-State: AOJu0YyccqPIn/RxwCss6HGuieOwBPqPZU7eJyzpNf+T3wrrltlp4q+a
	m6JerT0aSzYRtlsHtQzwzNTl98OPnRadN2i1V6nQ8ZafGgyFVNocEBZ54GXbZA==
X-Gm-Gg: ASbGncs/VGOsrcYlPrRmawHtLiVmzuNxW1b/EE9omUj5iD6vrGjEoKTm1c6ps6uGyny
	MMFlCnmT7lp8WH68DtE7EVOdci43JlfEa9FvwRmw0LOEYirNdFh1A2QpK7gDu84l89p729i4bU0
	AocOaKK5L4SRLH39igYmn9StgeUeoc2Pv1m7kkzP/YJiiNnXCpY5bFPHnDlHeSTpnDRNZLBEG8u
	OlRCXCuHF/6KeaK6qbatXg1G2lhleHsnvNtzRw87tYpE4Yw7Wu1jtphGhIbn7pfcK1TIgnNxlmL
	CfacIvfN5eP/YFojPnbcL+uOHlXHjzI=
X-Google-Smtp-Source: AGHT+IFyzGw+gglrqm8+RhNerLly3LfTpt0cYg/FTCF385N1SMb70IaANKI6otHSuU62jnflMlYR+g==
X-Received: by 2002:a05:622a:1210:b0:462:e827:c11a with SMTP id d75a77b69052e-467a575a86emr267051701cf.19.1734383849004;
        Mon, 16 Dec 2024 13:17:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:28 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:18 +0000
Subject: [PATCH v5 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-4-3d6b35ddce7b@chromium.org>
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

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 05f39fbfa485..fb88f21bffb2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -854,6 +854,11 @@ static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 	return NULL;
 }
 
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline bool has_acpi_companion(struct device *dev)
 {
 	return false;

-- 
2.47.1.613.gc27f4b7a9f-goog


