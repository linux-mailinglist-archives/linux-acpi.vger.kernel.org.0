Return-Path: <linux-acpi+bounces-13942-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA16AC8077
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158134E2792
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FCD22CBF7;
	Thu, 29 May 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="G+h+1tov"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0081ACEAC;
	Thu, 29 May 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533399; cv=none; b=W4rjo30/IdFSPaZJ02rBfZqCj2V8vr9MYP1PirR7xlo9yNUF4jBxIlXF2u44D5whqvGQ4ODhUOgbQYX58fTKRnKNFZxTYICcQil5yTP2mLiHJcs/YeH+zJTnyvo1ruqRwrTrpwuNxZ3g0eMt52QR2G3mJbsbJerLnpqskcQFAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533399; c=relaxed/simple;
	bh=nT4EJ9//7/i7lYgj71XweZ2ap8MhOeoP/XVLg6Sf6PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YMNV16YY1WWuiOgLo2NRwNflhrfEFKYbHPjp3f6sFkVx/0rtnuOm33nO/RKXIQ7QRIfFDP7TCTICbi38p7ZU4o3JS1tESkSryegbqz8TO6rYeOnyk3GQh6HVqa716E2tBA3VVN41auO7DVjqrPs8NUCTOCeR1kxuwNqr2aWu4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=G+h+1tov; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C1F7866991A;
	Thu, 29 May 2025 17:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1748533394;
	bh=nT4EJ9//7/i7lYgj71XweZ2ap8MhOeoP/XVLg6Sf6PY=;
	h=From:Subject:Date;
	b=G+h+1tovbHnAI0GgPMrcYJskg5TMmrAYndKwB2T1D0tuFluO/75AXSuOxWMBr+XVk
	 h6Uo9XTGwMUV4jvq7H2YREwFhGyMW9JrzphHF2iehpdHNO+XHkMd/9w7T+Nv6pIKEN
	 J5xOduJEN3xIdPM4+EFD5QWANAK/YCmUTNhQPXmmRmqMKve8nSbVP1+AG4RC3wJWFH
	 RSOQ9zXEYPQVb7a5IXFK8ztUr50kKAc2zxvBzomZ+K94VqTSXtJSK2aEu8VTJP81mG
	 6wTfufp3lnvGLIoPgiafYJnBYooMDQtYlnEtJ7UDtDtUELS9/5c28iz6CVP7vqurXe
	 +rYtdqjZoSj1Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject:
 [PATCH v1] ACPICA: Switch back to using strncpy() in acpi_ut_safe_strncpy()
Date: Thu, 29 May 2025 17:43:13 +0200
Message-ID: <12685690.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTGjO+6eyIOh1ueVyVDvBEFwzR0ItAwhC5JrET/DJFlJbsXXyGcPl95o7FpX8+KY/fOMS2RxWYq0k1MQtHkHyffKLU57yIzW6+LZyxs6j/p7KJUTivF088xqOmAk26oNgfJCT0l5VPkh9KcJZ3UHK69upsSjjG8avaVh+IiiTz2fTMCvTByWMZiJV3pXUjy1spLCPVbaCC3u0Z6pHJTFv3yUSiVHbLjfFeYEG+Dh/BgsCaLMTDN21keAxHc8sy0ut6gfmyyrXZn3o3Iny/heSjlt6JrgTyxqXS76kdS9oRxFj7HyC7SPLnT22fgm8WjeiSJ3vbipvHlXUr6Ochuj/DsUjDW9eTYun9/dBRqYs2HB/5XiPji5ihA9t34wKpEg+5pnBYuZHnxJm7bDrIla1J1ZkE7g35X4yM4o19v+gqyqaVg7Od00C766FpeLb7ea9uIFo2fgf0pY2A/Q6voQE01Nxw9aJNXTiheGmeM8TwmcrTtzXf4vnUoO4r4SqClEMYBW9BBtf9faSOM95wdQbNwTCzFj//kBtPqkWbd67yH3wJLMVm1+xW/hE+64Q7bkVZ7QYAitfS7nhL5YtWECs0OMRol+GN2NgTnLs3C6IFjs0kT8N0AzMRBRJ2DDMFkCX6VUo/jnCMeVDhEJy6M0j0hAHBJYpO6eWt4GK1PpTnFk7w
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Ahmed Salem <x0rw3ll@gmail.com>

ACPICA commit b90d0d65ec97ff8279ad826f4102e0d31c5f662a

I mistakenly replaced strncpy() with memcpy() in commit ebf27765421c
("ACPICA: Replace strncpy() with memcpy()"), not realizing the entire
context behind *why* strncpy() was used.

In this safer implementation of strncpy(), it does not make
sense to use memcpy() only to null-terminate strings passed to
acpi_ut_safe_strncpy() one byte early.

The consequences of doing so are understandably *bad*, as was
evident by the kernel test bot reporting problems [1].

Fixes: ebf27765421c ("ACPICA: Replace strncpy() with memcpy()")
Link: https://lore.kernel.org/all/202505081033.50e45ff4-lkp@intel.com [1]
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202505081033.50e45ff4-lkp@intel.com
Link: https://github.com/acpica/acpica/commit/b90d0d65
Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 utnonansi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -Nurp linux.before_name/drivers/acpi/acpica/utnonansi.c linux.after_name/drivers/acpi/acpica/utnonansi.c
--- linux.before_name/drivers/acpi/acpica/utnonansi.c	2025-05-29 17:24:27.130073452 +0200
+++ linux.after_name/drivers/acpi/acpica/utnonansi.c	2025-05-29 17:24:22.076757944 +0200
@@ -168,7 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, ch
 {
 	/* Always terminate destination string */
 
-	memcpy(dest, source, dest_size);
+	strncpy(dest, source, dest_size);
 	dest[dest_size - 1] = 0;
 }
 




