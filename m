Return-Path: <linux-acpi+bounces-10888-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F3A27094
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 12:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D741656EA
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F2220C470;
	Tue,  4 Feb 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUAbFiqM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E995205E3B;
	Tue,  4 Feb 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669521; cv=none; b=lbcCIiHLHiFwZhKOXcBCszSC6xsBLaLuFf0lNJVeCKMcYyHo/I6WZz7M7Ov+wCMMFoyQa4LzCoGXrw5uZnmt7sAxeTn4NLrRiUuFHXzRht6O7JV410hGpnNVMKkX/NFYsYrKK4rKMX4/m6bDekdcT6EjHM/sz3rHQT8Id8vzTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669521; c=relaxed/simple;
	bh=RGvjMtppj6z2gs5Z/P1+VmNjOS9nfP9lzJ5wIwtOn7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvGX1KcWrU4SaPYOVJoJ0XPCtyqwKbzMf24TePPM+BQ/ibU90isp0Hb5twAllhslkPHvZngw0sdX2UerYrKVvOqsdmLltd2wOHxX9lLL4HatMxKZUDt2t35UijIxM7tYFMsWo2OO4f+Zgm3I8YGe+uadG2FRZ6hmd/aXYdzpTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUAbFiqM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738669520; x=1770205520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RGvjMtppj6z2gs5Z/P1+VmNjOS9nfP9lzJ5wIwtOn7U=;
  b=aUAbFiqMZA76nqDH80wMEn0JQq4JY+hKHtUMnFBnSfs+zdhEadwLxOAZ
   XV45v1DnD2+F94Q2GTrO1uHdVsnuvFCHPsgDDdRd3Kf0D36hEeUNaqINZ
   xp3LxaYFfLpKkeOY3lD270hSEUAB4D8cZkArM+PYvlMLo+qqA46e/EquD
   JC74Lh5XWE4BnMsbbus4jnt2YHcKGieJLI3OniFDHEVn4hgvvFFcKa8U8
   8vd/BB99pYoaUqIyGnzw/viwPfkYJvTimVD6QGqL6DPzoaklXJ2nNwc0H
   Pf2HM7q9DhRtCDm5XaIhkPPo+c2bCXA4um8yz77oj5ovrX46e2wWB4UFI
   w==;
X-CSE-ConnectionGUID: OHEVtsO0SY2oDkXUsgz9lg==
X-CSE-MsgGUID: 7cJ1dRAETKqFOseOOGg/4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56729167"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="56729167"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 03:45:19 -0800
X-CSE-ConnectionGUID: I1FHtHwsS0y+mwqoUQy+8w==
X-CSE-MsgGUID: 14rZOyTFR5+AFBUZFubQDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="115573113"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 04 Feb 2025 03:45:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 03DAB299; Tue, 04 Feb 2025 13:45:15 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Use my kernel.org address for ACPI GPIO work
Date: Tue,  4 Feb 2025 13:45:15 +0200
Message-ID: <20250204114515.3971923-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to use my kernel.org address for ACPI GPIO work.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6283fad64df..26c8b7055531 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9878,7 +9878,7 @@ S:	Maintained
 F:	drivers/staging/gpib/
 
 GPIO ACPI SUPPORT
-M:	Mika Westerberg <mika.westerberg@linux.intel.com>
+M:	Mika Westerberg <westeri@kernel.org>
 M:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 L:	linux-gpio@vger.kernel.org
 L:	linux-acpi@vger.kernel.org
-- 
2.47.2


