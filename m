Return-Path: <linux-acpi+bounces-12945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD0A84486
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB9C1748D5
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D742857F4;
	Thu, 10 Apr 2025 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gfXKreyj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5DD2857C1
	for <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290785; cv=none; b=jtvx7l31SNkjSfKeNi/4aLmR85cSIB8dhiO6/bwsQXigHiGqBymMebq9EYeIhI29GbT1Our5hMw7Ui3B7omGBonUR5fD5lKavvR0gn51wDBZB7A3fgoFjkkToo++2M3ujgZz1TmwqEXLybEiawMu+XJ2BGNgiAgwX2wacv+TyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290785; c=relaxed/simple;
	bh=15HsixBTU7E936hX6eeIQrjloqcVYDnNGQInTaKDu4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwkrfHv5EDCLgn2lCFWs1iqur99SIEn8Qe6PT4YstAmIAYyGepnomXwHYwStQkA/rNz2iEunFXfutzjcLJRfFl2nbr73wmj4mtpKexp8n9/naAfWE8t2E09xlFllzEo2dfpCTzIdX1TZ3LpT06KIf6M78vdBGJmTk/cDxXGKu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gfXKreyj; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=odcYI2mczDWySCh1nWDA1e5Ya4Ph3MEIyp8O5AwNBSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=gfXKreyjxlvlc+MO2ortfyPmOhB+s9lSwYDd396fSG39fujzLHzd/p5hhEqaXGx2+
	 5bnWwKfxoBaIOq5a7x+TjPMcu4iFQNDJKAkUFJmGND6xCCk70Wvo7caP8d1IuixbLk
	 lmKJ2GqK3a5ZnEqDWIGMOFMCrULKL38nBLiYpzNg9vJgXWMFp5U9/K7K4xe9Re4leY
	 y7aLL7yIm/wyDIRnFjWtLPy+k+EaZf3tlmX63JN8UV2FxHH5uqBSAcCruVrBUo0+E6
	 67FlIyPQwFAnO/8XZTRuNhvwfoowCuPtME96yHdenjAKTf9U9DkH2oPoFzu3Cnr68o
	 V31G0l7v63nPQ==
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPS id A64853118C29;
	Thu, 10 Apr 2025 13:13:00 +0000 (UTC)
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 3089F31189E1;
	Thu, 10 Apr 2025 13:12:38 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 21:12:12 +0800
Subject: [PATCH 2/2] software node: Correct a OOB check in
 software_node_get_reference_args()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-fix_swnode-v1-2-081c95cf7cf9@quicinc.com>
References: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
In-Reply-To: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: -O5YQR9OKrBsdyiKo-onRiNXjjrVg6Of
X-Proofpoint-ORIG-GUID: -O5YQR9OKrBsdyiKo-onRiNXjjrVg6Of
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=677 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100096
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

software_node_get_reference_args() wants to get @index-th element, so
the property value requires at least '(index + 1) * sizeof(*ref)' bytes.

Correct the check to avoid OOB access.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 67040fff99b02c43999b175c2ba7e6d04322a446..efaac07f8ba38fae55214b71c2ecee15b5a711b1 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -529,7 +529,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (prop->is_inline)
 		return -EINVAL;
 
-	if (index * sizeof(*ref) >= prop->length)
+	if ((index + 1) * sizeof(*ref) > prop->length)
 		return -ENOENT;
 
 	ref_array = prop->pointer;

-- 
2.34.1


