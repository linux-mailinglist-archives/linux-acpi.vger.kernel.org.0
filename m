Return-Path: <linux-acpi+bounces-19124-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EE3C7158E
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 23:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1AD54E3EBE
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 22:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182593321B9;
	Wed, 19 Nov 2025 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="rpfaaLJ3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8332E72F;
	Wed, 19 Nov 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592170; cv=none; b=Isu0g1fkeeH4OpK1WQ+eDvOmNZIp9Da1ZWKByWhiR/BaTVZytPQAvWeME+WgWC9uckMpiar0sDTP2v6pSouYcwbinqIz0wJNT7lg+6UX344SfyJxlmarLUDLbuX63Gf5w8Emm24TZqPqO2cE59goO0vTyE/HKjTpbHKY8Prm7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592170; c=relaxed/simple;
	bh=fTWK9ZhtNPnMQsRMSYCwnTbkedaLi1ZBLXjISTRbQ40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPydhWJ6YLVcg9RT5vcz/dpQMcc7EBt0xPNaIeXJ3tQYcKWl3vv/Ri3QDWqC2rVKNsdjQxdTg85tQY3M/gIZOsFFnm9rTJQeaUcnyD2C2epJSeY1doltU51aylIv5KrhxYDBj+At/cx9oLpvVTktIrYBqBeTHQdqlidVzqGHyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=rpfaaLJ3; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsw-006ysY-Bb; Wed, 19 Nov 2025 23:42:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=C+jBZ6fI3hOCBTXkSkePKXZdnNx+tfzsbryObn4krGs=; b=rpfaaLJ3GB9BL5rQgtrWmJKuOi
	3v/X1BM8s+PLxOA+f2mEmLixYZLH4HoxnWBqGeYqwWOpRMuPYaR/tSaU8dPYMmxLBr/Q7zjEqBgKX
	LyIpXoZvDZkod5fFIitgNWX0kJTGMOciUy/s5HDE7h2dfYdx1Q210no62RGtrBcBhk8QmLHiqsnfJ
	XKNPuPo1fnYZ3rPy4xMiqiFyvT/9XR8oLoeKv12Fku36vzF+75P61hxtSWJJ9cFdlQkuv7HMcQEyJ
	zpaF8rLGTofbIfEMa1n25J5B+pxcddaVPVAVA8xjK4/z+Sdh55WYqHhjfm7xQ7LqS1MhBEO8VNOQI
	oIWcER0A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsv-0000Cx-Cx; Wed, 19 Nov 2025 23:42:45 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsa-00Fos6-Li; Wed, 19 Nov 2025 23:42:24 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 13/44] drivers/acpi: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:09 +0000
Message-Id: <20251119224140.8616-14-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case the 'unsigned long' value is small enough that the result
is ok.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 43d5e457814e..e427ab24cde7 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1280,7 +1280,7 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 		ret = acpi_copy_property_array_uint(items, (u64 *)val, nval);
 		break;
 	case DEV_PROP_STRING:
-		nval = min_t(u32, nval, obj->package.count);
+		nval = min(nval, obj->package.count);
 		if (nval == 0)
 			return -ENODATA;
 
-- 
2.39.5


