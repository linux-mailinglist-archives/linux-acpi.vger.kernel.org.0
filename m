Return-Path: <linux-acpi+bounces-17611-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4617BBE1C6
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 15:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349DA1897524
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0344285C8B;
	Mon,  6 Oct 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2TEjaxP0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BEE284B37
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755641; cv=none; b=VdUHKdltfBmQw87AvMVE0/TT7bf60/Tg73YJJd0Q7OUU7Pybgj1UZ4eQP+X2jzYt0CzALVElT5sBNX4na8/YiGGdoY1VjeYLbsUU+2CTefYBBc+cl+6fyOdMmy/8TdaNV/1jS0idFjAuFnJOWKgVtnqCdZK13Xrhp4Rjru037pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755641; c=relaxed/simple;
	bh=fQI/x1mfXGLwGHQU2jPShdqMN7mTN0xvuZeF3kl8J+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7SwXirbwLpqyTvF30407nkCzBEoiGoxjK8FlQGzAkOGYKr8QW/QMoGpO8nh0YN0vmwr0dbG0UuJSrkpRtsnwtVGchLnlemnutATQEP683HvAKijgVcYyoD9mSQ4NWxYze5LelUdnjhIRBG2VI2602xhYtpRDSDHcCS+PACtvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2TEjaxP0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso35696465e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755636; x=1760360436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWNKnqg+rjVWS75Xku977zgkREPrPcBc6PcBPNb4lsk=;
        b=2TEjaxP0buZCzXIOPLHjHvGj2aO/f1dR964eIX3cfAqq0y/tKpZQtprJRRRjww6opj
         sllyxopZwc0n020VAvZluiQtZqjBR7bp3UL2aFFIwuXgxnAVuKOlJ83V7pW0YIJEGRJi
         l+xiLFDBWLQ1hhg0yvNgVoJmhiFE//smj9SSEQL5qxUc7ciy7nchuy7s4dfHihYv58nC
         wRIxIVNP8XblRKfH/Xa05qedDCsZ2eXbI4ljk++cs7jFa/2RlWAwby/PGzPCSm8CSKk3
         JwxLn+xWbGxvnVPrDSEbTfnRZN7dESuNT0Wk3y9nDwI0a4g8IGm59LKhx/RHawrC1zrG
         XvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755636; x=1760360436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWNKnqg+rjVWS75Xku977zgkREPrPcBc6PcBPNb4lsk=;
        b=mfib0l2VC34fwsAXtitG+5AZk7CdKL0U3p5xCv0KFUOkerMhlB6WsMqFivwO/Bg03X
         25+reObaei475ZWLUFmxEqVlfCIJP7CPuQ4vpZoB134rArNUaF0WWcA6CuWFfGVVE1qg
         IiDZVQKHRvt0croVt7O09BvlO5dJUIzC3m60t1QulwUHciJqjVMrLWPavjWspFkp3UXT
         7px2qdhyJSt8veIvaD4yrmCF/h4as8+lrXAvTEm+6+OGXFSMm2JDqOxADAbnwEHiRLIC
         +yahxQYXTfsEU4Or+SGo7R4RoZ68rp4s9HuRNQI56aydZPD9byZWio19cutfOA1f7OkJ
         CXWA==
X-Forwarded-Encrypted: i=1; AJvYcCVGWOl+TTmXrQB7eD0gpyp25aVWhQw6ziPt9OEZb9eT1hFXTNeDHSXAbgzoWnTpHWntsHhyCZrJmSVE@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4vW8y2sEqXW1Ayn/t60ui3v6VS9KyJy/sl4U9rkoWzAWy/2w
	uqMHcDtxhP8UoWaMCIcMyTWa/gWcWI2mv0wCZYH2LUd7Jy/ibb28hTUtqawwG0haGJM=
X-Gm-Gg: ASbGncvhjCzYvaflWuoMQx/kvPLElfG9qqyCgbsZ+fWdsmPsa/ne0Y3JL654I2YPkiG
	mPpxWkLXEVeg65lQMkXmw0bshZ6ao6Yyr+PbIHB2bLif4VD20nH9VTupb/ZF8k6fIgrbPIWPCHd
	5lFn1DYYkH7fUKeaOQImluaMk+F9O8KEsYinP3Yp2ePSXbg/KnkagQOI/jJh40xOFC/Pi49IqY0
	xt3ho4IVx1b70Aosbn1jg2bDEPvNUIs0zOyaLu7zOk1nHH0MbtvymkJzS/HnwSkt88q9DUXGDpz
	CF5p5BCuPe1KDG6Gt4oTyVvwZHQLk+JpLuT/avRXIUmdwdrrpNdPzK3yxAXwrMlO/WUI1ULCHGX
	Ie4lPG9g/ewwHnxP53sGpcMtYKFsvZs3MQww6zV4gQg==
X-Google-Smtp-Source: AGHT+IF8QYCtllO4mHewnOdNKwyg7VM7sonfF/iAif7DtVHOdnSxT2xKV7IG3D+F62nGaaXjHu14Rg==
X-Received: by 2002:a05:600c:4447:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46e7113ceddmr102522015e9.17.1759755636178;
        Mon, 06 Oct 2025 06:00:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:16 +0200
Subject: [PATCH 1/9] software node: read the reference args via the fwnode
 API
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-1-6d3325b9af42@linaro.org>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
In-Reply-To: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=O2Bm8zK8myf8pkCc6yVByD6bQNfFHPINhpPFtP7hF18=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471v6m7oxteEZyESdFKLOSTziNaLss3w9jkI7
 CFUp3WLu7WJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9bwAKCRARpy6gFHHX
 cuYDD/9ytGdRu/CtE4of0wQOC+lY5AA6NHbxW4y00dovav8+EestNKOrbwTfXvNs8TakPPw9pf8
 UmOs/1CbTbVGY3EcLdC6OgoI1JALLGd24bWbjibom89VSr//6m02QQrAp5Z+LfaHvLmPvpizNbn
 4UMWZRgqiy/U+lZZQVigCatheQ7JxfW1BlVOergWWZByTEnzxrHzqAF9XkPbfUE7/Yx7z8+TGib
 GLs3y9t1tSz3EO12/yaJePTuFR9zXWXbcMcItgTTWZbqh2fOc0BEaoG1DPhFIyplT4prWrkuBax
 S3SBO4mh9TX0JymOXKxHkeyS0VCjdGs+S44B18z4EEfp/tiDBFoIGEBzJcQFeq8ctogQBCvBmgC
 Nb9aHZxZM/iQ0WacOk5hgeR+F7lN22T6EVBURTr+MSvLAchm62IIn5We/8SDFbE0yTqrGGQZ/LE
 wTqa8TH0aThr4XrmY0KYYwd2H7V+t82uP+S6ecYqn7Qq6qRSDzPobbx8T9W870xD3H0qKD/uYd/
 RYzbLfUF8DEkf7WkFhtCI68FrALzdeVKFloqtCOhXNmDF1IkWvMMxOSeuT0usFrJq/75lSSST4c
 uBOORRAIPyRoWVFh1wSgYAg2alqD4cULdktEOQLEHWF2as8qgqm4vaFCyH7hTB9eXOVoSTxsuAd
 IvNrQtd63c1UVag==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference all kinds of firmware nodes,
the refnode here will no longer necessarily be a software node so read
its proprties going through its fwnode implementation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index be1e9e61a7bf4d1301a3e109628517cfd9214704..cc48cff54d9c3d4d257095b6cb4a7869bf657373 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,9 +540,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	if (nargs_prop) {
-		error = property_entry_read_int_array(ref->node->properties,
-						      nargs_prop, sizeof(u32),
-						      &nargs_prop_val, 1);
+		error = fwnode_property_read_u32_array(refnode, nargs_prop,
+						       &nargs_prop_val, 1);
 		if (error)
 			return error;
 

-- 
2.48.1


