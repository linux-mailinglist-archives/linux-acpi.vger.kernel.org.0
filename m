Return-Path: <linux-acpi+bounces-6111-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF6C8D60BF
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2024 13:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E48C1C23A7C
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2024 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA063157488;
	Fri, 31 May 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="stdfbrAg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D998173C;
	Fri, 31 May 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155303; cv=none; b=prMno+7F5lmgmoVaU0W9sTQ5vf/vi225hqGSrgfnhW9eV7J5rGIMZuBht3ZWOTen5B0H0cYQceGuZfexL0ax/103WRh0l2SiS3WmAW2AEnDc7zZKIq4iv/TveaL56ooGvpZ/erm5nRcX1MMvMk7Nw//uKyvCeVpIEeYMOXH2HCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155303; c=relaxed/simple;
	bh=BCulwwdYr/KSnyKqgtvuTyOnil71EDFeqJBJWRTrdjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gw0g4nEzQ5cSmIhgO0Nov8Y6yN6zH2QQwp7KN0DNoGbi2cKRYnH7A56IsFlZGRFFemulLY68HRKZd9o37bQXY9hkUDKaV0VcxeXq3XKm2SrM4cUSjgKcW6srrbY0xoMlB31PI45fBI4j7P8171oTMelLGq05E2NomnhSCC/UfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=stdfbrAg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717155300;
	bh=BCulwwdYr/KSnyKqgtvuTyOnil71EDFeqJBJWRTrdjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stdfbrAgFa6eirwM9A9FExFkiI+T9UTFZiG8pJBuCO//NzYE0TGsZVHs841M0zehE
	 ZRafkHT4gXAgkDjLDnpTa1vnOXmiD08fG01WCvVB0QzercN1barPPixmmiek1CRYCR
	 SXdhXYdgeYZNMH3NegrZdwPswFK4lDFtTX0JN2Of4jH+9KJG4ut2osedriGmFu1gjt
	 eEZff7DzrmWUBls/foADLuGXUI7wcFFFnKv9R1jY273L4XUfFC3krTKgruzfShzRtg
	 oK/BgbRLNGKa0Wm/ubpj+88PigmwYJ/k5vpX6IUftf87/kaNL3POMjrSE7xnqzGCY9
	 peZl+0XZ0Oiow==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C30403781FA4;
	Fri, 31 May 2024 11:34:59 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: kernel@collabora.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] probe with driver acpi-fan failed with error -22
Date: Fri, 31 May 2024 13:35:34 +0200
Message-Id: <20240531113534.577055-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240530153727.843378-1-laura.nao@collabora.com>
References: <20240530153727.843378-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On 5/30/24 17:37, Laura Nao wrote:
> Hello,
>                                                                           
> We have identified a regression in the acpi-fan driver probe between
> v6.9-rc7 and v6.10-rc1 on some Intel Chromebooks in the Collabora LAVA
> lab.
> 
> For the Acer Chromebook Spin 514 (CP514-2H), the following error is
> reported in the logs:
> 
> [    0.651202] acpi-fan INTC1044:00: probe with driver acpi-fan failed with error -22
> 
> Similar errors are reported on other devices with fans compatible with
> the same driver.
> 
> On Acer Chromebox CXI4, ASUS Chromebook Flip C436FA and
> HP Chromebook x360 14 G1:
> 
> [    0.488001] acpi-fan INT3404:00: probe with driver acpi-fan failed with error -22
> 
> On ASUS Chromebook Vero 514 CBV514-1H:
> 
> [    1.168905] acpi-fan INTC1048:00: probe with driver acpi-fan failed with error -22
> 
> The issue is still present on next-20240529.
> 
> I'm sending this report to track the regression while a fix is
> identified. I'll investigate the issue/run a bisection and report back
> with the results.
>                                       
> This regression was discovered during some preliminary tests with the
> ACPI probe kselftest [1] in KernelCI. The config used was the upstream
> x86_64 defconfig with a fragment applied on top [2].
> 
> Best,
> 
> Laura
> 
> [1] https://lore.kernel.org/all/20240308144933.337107-1-laura.nao@collabora.com/
> [2] https://pastebin.com/raw/0tFM0Zyg
> 
> #regzbot introduced: v6.9-rc7..v6.10-rc1

The issue started happening after: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/thermal/thermal_core.c?h=v6.10-rc1&id=31a0fa0019b022024cc082ae292951a596b06f8c

Before this commit, get_cur_state() was not called by 
__thermal_cooling_device_register, so the error was not triggered.

After enabling debugging for the acpi-fan driver, I noticed these errors
in the logs:

[    0.682224] acpi INTC1044:00: Invalid control value returned
[    0.682635] acpi INTC1044:00: Invalid control value returned

The value stored in fst.control is 255, which is indeed not a valid 
value.

I suspect this might be a firmware issue that is now manifesting due to
the addition of the extra get_cur_state() call.

I'll dig a bit more and report back.

Best,

Laura

#regzbot introduced: 31a0fa0019


