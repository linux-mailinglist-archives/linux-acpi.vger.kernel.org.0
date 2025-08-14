Return-Path: <linux-acpi+bounces-15662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52538B25AB3
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 07:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39957B99EA
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 05:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7021C195;
	Thu, 14 Aug 2025 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MkSCPga1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5021A44C
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148333; cv=none; b=IGoisobmPwllfBjimjAEbeZJH7uN6SUB1GiI499Jvk2aBRdKcQtHuKtPuBllBvMlO+0FpgP3mK8bD5exg7OEiSpazc0W81ld985Dzr744pukoY+8CGAX2FK8MC9hTqAjAw+Sp/99rvVjj2v7dOvZuPtvkk6bmtfdEVJnIGwpAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148333; c=relaxed/simple;
	bh=YaF6qaNbfZR7C1UmE5o7deC1mp8iVKvjMQoaZqOQFxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zbd/4AXxCU8JdcZsgt+YaApcyibmhP7uSib/y+tb0RMkZgJDaq5IqgEchoW6mZTaXFWNlCPXWD9FjU4mTvcN8sx56hbzvlA+v5SZ3E49k0/HXHWIoj/84hFVXfj3dJ1a5i9XpAQ2pX36qhsUjoc66WO/wMIi2i0CXgiYgAoEXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MkSCPga1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b657bddso1044332a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2025 22:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755148328; x=1755753128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UUaCbQk/tQidZQRYXdHI6wdrBH3WftKB2sa5wcWzvs=;
        b=MkSCPga1F8ROO/73OwExDxZ30IIkxPfsTbp7VVUYF0fF49q0cqfGEpjhLHaiU633HF
         rigVXFScFOb6FJnYs3MG5F1tG6d/sCYuBpKz3XqVWTC9De/TKSnZsFUMWXa2cDOB3sxw
         JOzpJuD8doyqiOssXLH4B2dIMdoYUvziu6+y0Gg5nc2m56ZMbG1o6hs9GfRuHvGyyi8w
         4ajivJ8lVAufAXnhtBhi42zEQUYyhXYQZEziZyzyB2VRcGpY9rxUbKmBTwBVjsAlvYXy
         d5HhOJRvoUfVjUZawoEjMWgELQKyRKKDG3chgZxyCmdUBwfLzpICK9p6h6o1fkPdLmUH
         bEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755148328; x=1755753128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UUaCbQk/tQidZQRYXdHI6wdrBH3WftKB2sa5wcWzvs=;
        b=VheKP5b1I77UujHha2DmitqbyOJi9W4ZwHUxN9iscqxqxOnZU5PbaalyffXp/2zg9F
         u7sqB6Sc2fw5zHcQsSvqpmK0TrCBwr+fZ+ofL0mDTKZfI3xdXjjjcjFnHk6KHLzdi+LO
         gHAATpxD4kndXTvnvwjaQUhd9cro58zVXitH2w0oicOM8Rl8F5WewsOjvDdxBNtvoBmb
         emzP5+ouwCs1jHs6XTRNjBRg/qxBb8qH8ctZIpKcze8gXSldwk/TfY8HPZ60FeTAzJts
         AhFubFiadZF4ozRlgbnAksK2bWgE9weVQGskJAMfg91/tEGW+PWaPt4FApkNKTIV9e9g
         HE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/n7jf0ydYIfsxpwoDIpqF2kqfBAZVzhassCBgM/BQQ8AsdVFcpfXmG2+nWwFYarEnPZ57T7s/7PpL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Tj0gqSxWhYa/aI/gpQ6yOE2BTIC3R08O9/FiDO04XHRYTlLI
	w5E7qEpiAIf3L6zckobMssMqTN3YxqFcPWxsrWSU8aaOtLDk1rE1Qc5k96lFars6E24=
X-Gm-Gg: ASbGnctOHxQyMDTh1iyLAyA6Xdbi0dQlihw75KAqkjz3x07o1V0+o9o5XThllnzQS3n
	z2E++qznixC0JCsEqn6ILuQET07p/vll3l8OKoKNHCGme/TseMyZZaRJjGPSn45jXjrkAo7hlfd
	92OQFEIgPBLmDaG50GeKuMAJMbDlAffEVSQWlHMM98OMydSKTNKZXGNZd/yBQdpnxwlBiRF8vFH
	frPRVOJgXVTk47OzvSLzpQWd6pvsglzXX+wAGvBeDOo32WpF7FPnYuWT23BhtsUOGN6EWKvI+ci
	qp7NvfBUNa751rHq9Q+VQvgMs2gqArlXxjPBvLLJJMwRK7EtJlpw5rq39xHuOyJPnJ6MVU7LAwy
	4BhchtozLeLkYKeak9wbHGgg5L0A6C4Soshk3dw==
X-Google-Smtp-Source: AGHT+IE2qNMmiWwpZbVyrEo69mF6dA6ewxgwveepPO3c3U2g6RrCgHK7XTCos3mlcSqU5U6vEPad3Q==
X-Received: by 2002:a05:6402:354c:b0:615:cb9c:d5a2 with SMTP id 4fb4d7f45d1cf-6188c1fb55dmr1316865a12.18.1755148328431;
        Wed, 13 Aug 2025 22:12:08 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61865823411sm3172298a12.28.2025.08.13.22.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 22:12:07 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Zaid Alali <zaidal@os.amperecomputing.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: APEI: EINJ: Fix resource leak by remove callback in .exit.text
Date: Thu, 14 Aug 2025 07:11:57 +0200
Message-ID: <20250814051157.35867-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=YaF6qaNbfZR7C1UmE5o7deC1mp8iVKvjMQoaZqOQFxk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBonXAe4wXCd+w9j012xGyTT62s1jZjYP8qMlwkY VgjJDWWVa6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaJ1wHgAKCRCPgPtYfRL+ TneRCAC2WyUwTXznndtVthjtYInPYamfSX2NFfpWVuHokH3cjFu3g5qKEMAbIyhhImFwn3LAHFM q2EBEddDIFu3hhV0bfaFW1WAAWQnUw/wLTbZOfMIMjT8y5TDSycQdjjTK0WIURH6lfshxqzILxM 4eYP4zuLu8XAv/j4k1Smzyt6JFFdA0bK6rpIkz4vx+X7tD8/8gjVPNSAp31xarETNBOMiK0t00s NF5jqzx4G9X4oFozftrXlZk9MDupzmRLsWyWFVc+FmHTNxEi4q/13KFciAte9zzs05BnmzmzIFC p/56E0SgI9fUGJ6d+80/klkpUfWHCxf2fCzDU8zh1piFDpVn
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .remove() callback is also used during error handling in
faux_probe(). As einj_remove() was marked with __exit it's not linked
into the kernel if the driver is built-in, potentially resulting in
resource leaks.

Also remove the comment justifying the __exit annotation which doesn't
apply any more since the driver was converted to the faux device
interface.

Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

note that the intention seems to be that this construct is safe, see
commit c393befa14ab ("driver core: faux: Suppress bind attributes").
Note further that I don't have a machine to test that so this is only
based on code reading. An appropriate test might be:

| diff --git a/drivers/base/faux.c b/drivers/base/faux.c
| index f5fbda0a9a44..decb15f1194a 100644
| --- a/drivers/base/faux.c
| +++ b/drivers/base/faux.c
| @@ -39,6 +39,8 @@ static int faux_match(struct device *dev, const struct device_driver *drv)
|  	return 1;
|  }
|  
| +static int once;
| +
|  static int faux_probe(struct device *dev)
|  {
|  	struct faux_object *faux_obj = to_faux_object(dev);
| @@ -56,7 +58,11 @@ static int faux_probe(struct device *dev)
|  	 * Add groups after the probe succeeds to ensure resources are
|  	 * initialized correctly
|  	 */
| -	ret = device_add_groups(dev, faux_obj->groups);
| +
| +	if (once++)
| +		ret = -ENOMEM;
| +	else
| +		ret = device_add_groups(dev, faux_obj->groups);
|  	if (ret && faux_ops && faux_ops->remove)
|  		faux_ops->remove(faux_dev);
 
(quoted to make sure that this hunk won't be used when the patch is
applied).

Even if the faux device interface is fixed not to rely on .remove() the
comment in einj-core.c needs some love.

Best regards
Uwe

 drivers/acpi/apei/einj-core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index bf8dc92a373a..1204fa3df285 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -1091,7 +1091,7 @@ static int __init einj_probe(struct faux_device *fdev)
 	return rc;
 }
 
-static void __exit einj_remove(struct faux_device *fdev)
+static void einj_remove(struct faux_device *fdev)
 {
 	struct apei_exec_context ctx;
 
@@ -1114,15 +1114,9 @@ static void __exit einj_remove(struct faux_device *fdev)
 }
 
 static struct faux_device *einj_dev;
-/*
- * einj_remove() lives in .exit.text. For drivers registered via
- * platform_driver_probe() this is ok because they cannot get unbound at
- * runtime. So mark the driver struct with __refdata to prevent modpost
- * triggering a section mismatch warning.
- */
-static struct faux_device_ops einj_device_ops __refdata = {
+static struct faux_device_ops einj_device_ops = {
 	.probe = einj_probe,
-	.remove = __exit_p(einj_remove),
+	.remove = einj_remove,
 };
 
 static int __init einj_init(void)

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


