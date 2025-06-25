Return-Path: <linux-acpi+bounces-14604-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7B8AE8804
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BB7166BDC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A6F2C325C;
	Wed, 25 Jun 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djEyL1xf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0122DAFC3
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865010; cv=none; b=EHH49lwosz7rLhRROaxtEzgHvUa/eo1/m/nK91B3em22nd8G3TXCrYsEovEA+/gQnkvy7scpcRGhjJBcRckuG2lqT0UdWuo36QPZyVRJ6NwQnQsLZWFkfjORwMc9n0DGY/eTPQjAA8Tfc92TQ3k3wZw0n1XGl3e2e3XP9cZj1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865010; c=relaxed/simple;
	bh=5XtjxA/sFkLGx0MrFCZy1IwBNpCsiboRk5u0NA3i6Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fkrYKJQPhJJY8b/Q0+N2CIgQOWL9ovy4Dfq85wdK43EwKcU7jy11WrbY1GtuevKwPB1W26Hm2gq7dwZ63aJcQrWNjJMhLPaTw7vhH0djYqCsMbu2FB6AjYrsHvy5x+Lilu82sOa1/ERj2hNrudJLMz3dxfklNqM+IxIj/z+/mNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=djEyL1xf; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2efc0ed41efso17713fac.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750865008; x=1751469808; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URcIX0mY/nhVqSMfP55/sPY1bEZRgky9TRvamUcBG98=;
        b=djEyL1xfKYOING1WtmLgBb2CQjgtw+l0VS+mQT9NGVtVrWq7fVe5q8QhJilw/lHjhy
         Rv9+UVrP1j0q+IK7Pp0wE5REhl9RwHWfp+piIoMFHJxzbs/jhWU7EVFj4lJC48YtzO/i
         06ZdqCnKE9WnzaIlbF6B4wpkUd00+yQHf7h8UedakoW/R3dXiuNqKQblcvviEltAg24y
         wEM4932hr72dNSo+3IySjx8yiRohk295du38bGvaPc3+EuGdMaBsBUnPd0kMrnNhzUDK
         UP5RtZMziWuSVdyNkRRrUOmQvE13xs4P60eeNJRRRAmYIIcLA8+CUZLbpcN48ECZODIS
         XE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865008; x=1751469808;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URcIX0mY/nhVqSMfP55/sPY1bEZRgky9TRvamUcBG98=;
        b=Rq0w4Z6/vxngVJKkZBqobPKI2RANtgyQiGyRfUC5SPoIj6xfiBfzuqL5YSoLUoWS25
         xq/4A6waZJjcoVwMnIp6sIu2nWH6gI+HOp0NgwChZnjum5jbQJAtZ7IAmoYQkzK/6j38
         WJ9ydcIIRPdW9PajJ0CS5tAZvo3MUb+VGJfpEn3/6+BFYicogrW2rWDwmPxpHuITlCrI
         /4Ivv3r3L3qcFJQ36ta97rDrLa6zae1mZaBZvQQZykQ/qln481zmvh3Ug54Gm6P1ox9I
         KZgFPWsp/Bodym8h3/77re6YGOZ7Zok7PTrQFjJTGzsVdR/y1UeDbNIND/vaECO1SOQ9
         3IgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIsTr357dPUjfV12dcAporuuDnagBpotxrZ85aReBoV3XIpjBl9QXMlGyHSeELzW2AZbDX9od9XQUR@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwwqPmIjHbRV+ssy4FIgu5UOyvrNZKbteduwrosoxUmtiMNqr
	fBno4Gv6p/Yj4hXMMDVnfXe7aK+vgP5ZGQK3gWjIxhmVtEBXy/CKmF/P889rtrc967A=
X-Gm-Gg: ASbGncsnIkm+qLyK0RdSqKy3ACtGIUaq5gSfB67hJPUeMfv533tQ7Eqq/FHTxXT9/1+
	rXttZDq4JUMqEzUc/2PSaKJ0aZ2soRtEA2rfld+h0/sj23LKyrqy+002BJdS3CoY6cPhze2MpOG
	aD3Kl2jJzCgl4PygXnrQPYhWikhgp6sfzrDR0CN++ONmQy84LTlYl+OdegHTTXlosAboJiqjOXz
	7X38lRbtrGn7SqleE3fEam8UdrYzvzIjsBbnrIGhWQGjTShwkJgaj52Xyi+CinnP0qb6ZBCa35/
	KVKdtvzD47SvtGGofzmnfd67AUzjWkYS9PHygDWWUuBhJHFRkYnRj6SFSlD5QKtUSw2FtA==
X-Google-Smtp-Source: AGHT+IE78ssGm4pxFnUIN1SeZUSbBSiN255lPYOdn0sAye7rxVXzd1Y/pn+8ekMWbb/p+HqcMVQI8A==
X-Received: by 2002:a05:6870:b015:b0:2c7:6150:fff7 with SMTP id 586e51a60fabf-2efb2459f79mr2603151fac.35.1750865008000;
        Wed, 25 Jun 2025 08:23:28 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2eead8b1a05sm2570977fac.38.2025.06.25.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:23:27 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:23:26 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
Message-ID: <4d800ffb-fb1a-464d-adcc-2802187cfa9a@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "einj_buf" buffer is 32 chars.  Verify that "count" is not too large
for that.  Also leave the last character as a NUL terminator to ensure
the string is properly terminated.

Fixes: 0c6176e1e186 ("ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/acpi/apei/einj-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index d6d7e36e3647..e77c0d4b4ee5 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -826,8 +826,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
 	int rc;
 	u64 val;
 
+	if (count > sizeof(einj_buf))
+		return -EINVAL;
+
 	memset(einj_buf, 0, sizeof(einj_buf));
-	if (copy_from_user(einj_buf, buf, count))
+	if (copy_from_user(einj_buf, buf, min(count, sizeof((einj_buf) - 1))))
 		return -EFAULT;
 
 	if (strncmp(einj_buf, "V2_", 3) == 0) {
-- 
2.47.2


