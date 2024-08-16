Return-Path: <linux-acpi+bounces-7615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E3954D7C
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 17:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF431B24E51
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382891C0DDE;
	Fri, 16 Aug 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXuRLkfX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A11BDAB4
	for <linux-acpi@vger.kernel.org>; Fri, 16 Aug 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821402; cv=none; b=lVPBTVNUZCTwjDInA1XHGNqtlzpU8GbmB08Ed7A33ajTYzwCX2K4UBEGQUG2eDODM8ME7+jnMS+4k5WMFK9aEZox35MWgGeZx6vn5I20ZDn/QBwPC6ZQcHjDDodopL2AZ6/At1GriiGFv8COKbgMGZ0M8C/WHUiTZGVunEJ56UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821402; c=relaxed/simple;
	bh=k5xMKh/2+N66I5RIPs1ib7JMO8pbOEJ44sMMTiShnQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7A4zNFN7Ht00Vrr9zuF3HOmrvWXm0Xr7moqxAgkO5LVovxWUd9Wi3dJxr/V9vf+q/jvUBSoOFgRSC2K+WL65f73lzjbKWa8BzrQ7YkKjfYl7+AEBaPPzQ6yoIKCnVftzjy9cCig/qFDjws6CgKVU8oKeGAO+jg+z+uhQ125J00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXuRLkfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55125C4AF0F;
	Fri, 16 Aug 2024 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821401;
	bh=k5xMKh/2+N66I5RIPs1ib7JMO8pbOEJ44sMMTiShnQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXuRLkfXaciAF2RNfXxTLLKCcWp4WhS8iYRdaki6FFEAhrWjzQCDtm4xL7d9Wjalt
	 Bg86phaF8X1OGkblSqTyM6KEzN+jRouqkYUZ/gJ7T+kLR5frEYdswC31K31kHkaR7G
	 4pwq7hGsZuxvoA+tbkbrzY7dtn4RobomiDuTmCQY8vx/K1A1g3TKxhBwvgzLaeWHWs
	 z5Uz/FhGx0FST1DOSOckoDIbKlYuZm/XYQjiXghZPJDQXl82BbNnL/aJQNM8Z2DvYT
	 GZZABQ+jP00FMGF4LH9eg8J9BjDNHDkEShHWSx9Aa1JD1P4qwQi7Gvmc2BmXPy+Xet
	 HMyDZY+McA96A==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	corbet@lwn.net,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linuxarm@huawei.com,
	prime.zeng@hisilicon.com,
	jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com,
	xuwei5@huawei.com,
	yangyicong@hisilicon.com,
	hejunhao3@huawei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH] ACPI/IORT: Add PMCG platform information for HiSilicon HIP10/11
Date: Fri, 16 Aug 2024 16:16:01 +0100
Message-Id: <172380823847.2918952.639821097889794649.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240731092658.11012-1-yangyicong@huawei.com>
References: <20240731092658.11012-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jul 2024 17:26:58 +0800, Yicong Yang wrote:
> HiSilicon HIP10/11 platforms using the same SMMU PMCG with HIP09
> and thus suffers the same erratum. List them in the PMCG platform
> information list without introducing a new SMMU PMCG Model.
> 
> Update the silicon-errata.rst as well.
> 
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI/IORT: Add PMCG platform information for HiSilicon HIP10/11
      https://git.kernel.org/arm64/c/b43d63ceb562

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

