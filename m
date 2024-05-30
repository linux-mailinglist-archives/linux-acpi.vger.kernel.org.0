Return-Path: <linux-acpi+bounces-6104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D088D4F35
	for <lists+linux-acpi@lfdr.de>; Thu, 30 May 2024 17:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC681F218C3
	for <lists+linux-acpi@lfdr.de>; Thu, 30 May 2024 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61531183079;
	Thu, 30 May 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jCFzdPmN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FC17C23F;
	Thu, 30 May 2024 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083422; cv=none; b=WkKmwFFSQhbtjyPesB5CMbgIT0t8mNwbn4rS55x1It9iJRRZlypyNI34ibFH/nyAaPgts5KCCC0ANkIVveY+VYUErFMRSnRMGwAm9ICgG45Fxq3+84nWp4dnWNja1trttyq1DWcj9TGxYDT/JUB0hFVPLEI7lhoTCuqSYypbws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083422; c=relaxed/simple;
	bh=qYXmXSvbAlekhnuFdmhAUfv0lEDD1lyfWRJPeN4+j3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KexeECn0MLG8RTJFtT1RzAEfIhAFEBjOR4NFyPHZFsiHKDeQalFBT91kkRyBKcMmftuC+yIg+pi+r0xr4eziXi19EwdsutMMkUFMmbr81fW2Vh0CwAAg2Qo3aynvV90bi2/gwFlsvU2YFCoIr04l4g0EJAB2zmUqzTrSAR+yneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jCFzdPmN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717083419;
	bh=qYXmXSvbAlekhnuFdmhAUfv0lEDD1lyfWRJPeN4+j3I=;
	h=From:To:Cc:Subject:Date:From;
	b=jCFzdPmNksdQ6ixasNR8Ax/vf1J5L0nS0DN8hqQ1od/kxeAWAQhHvoirWn5ZVWzSA
	 A4SxCSz9AkS5vFPP53Fi49ALkuJ2Mi6vOiUGvKOJYRQ0A/MRp9FKfZfwjm2ZpLq/bI
	 wET07lZV5jWnz1xtsbRG6QelVCm1HLOX1dPAtd4vOfHfvODduh5yMZGgIzo2uAnGo+
	 OD3viB4EAtyqh0cM82dLt+l8dOLx58aTk67CSU/3TRVx5OAOl4U3Z486Bf/Rq4NLX7
	 bq8WRUolSB68sUaYp/KP9dAd49pPvPB5M+sCHYobdOURLGbn37faAvllWDQ1GSjIem
	 zsxukvpuZ3yMA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 90FF73781104;
	Thu, 30 May 2024 15:36:58 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: regressions@lists.linux.dev
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [REGRESSION] probe with driver acpi-fan failed with error -22
Date: Thu, 30 May 2024 17:37:27 +0200
Message-Id: <20240530153727.843378-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
                                                                         
We have identified a regression in the acpi-fan driver probe between 
v6.9-rc7 and v6.10-rc1 on some Intel Chromebooks in the Collabora LAVA 
lab.

For the Acer Chromebook Spin 514 (CP514-2H), the following error is 
reported in the logs:

[    0.651202] acpi-fan INTC1044:00: probe with driver acpi-fan failed with error -22

Similar errors are reported on other devices with fans compatible with 
the same driver.

On Acer Chromebox CXI4, ASUS Chromebook Flip C436FA and 
HP Chromebook x360 14 G1:

[    0.488001] acpi-fan INT3404:00: probe with driver acpi-fan failed with error -22

On ASUS Chromebook Vero 514 CBV514-1H:

[    1.168905] acpi-fan INTC1048:00: probe with driver acpi-fan failed with error -22

The issue is still present on next-20240529.

I'm sending this report to track the regression while a fix is 
identified. I'll investigate the issue/run a bisection and report back 
with the results.
                                     
This regression was discovered during some preliminary tests with the 
ACPI probe kselftest [1] in KernelCI. The config used was the upstream
x86_64 defconfig with a fragment applied on top [2].

Best,

Laura

[1] https://lore.kernel.org/all/20240308144933.337107-1-laura.nao@collabora.com/
[2] https://pastebin.com/raw/0tFM0Zyg

#regzbot introduced: v6.9-rc7..v6.10-rc1


