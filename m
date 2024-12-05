Return-Path: <linux-acpi+bounces-9953-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C5B9E5E37
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 19:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993DA1883B58
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 18:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E94227B99;
	Thu,  5 Dec 2024 18:24:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D4226EF2
	for <linux-acpi@vger.kernel.org>; Thu,  5 Dec 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423054; cv=none; b=OZMnl1KGdRdwMy1YVQani6XMVvOPkGoSNXTSjLQuXkkXfcBXp/zMDJeVyBBotatz1G5oJ9sG2W3BHNLxaqkGGLHznfTqqZfnX7BWxkg1hw+s5CNkpOPPaL8PKl3sAq8Z7TSaY1za4S2XhdbK/bSSPbEBGKrP11Q57o2ZA5H1rCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423054; c=relaxed/simple;
	bh=3lNftIjZAMke2351YPmEdhMNRN45nzbcwZW+oVQRKHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOnGYdwF7X5dvPSMUjiGTrQlRhWrXawkyOjFjOGg6TnEAu+QIsKX+dHQxcSlsgkIJYpoEfNIV4LOGd0arQrh1fctrFbuX177S/KLRDFZdJdTHNg7tmN622e8f24Nv80PYnuZowT7M2CPNpxz87Js+vEcV5IcRkXEWr66B278x/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D265C4CED1;
	Thu,  5 Dec 2024 18:24:12 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: guohanjun@huawei.com,
	lpieralisi@kernel.org,
	sudeep.holla@arm.com,
	will@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Qinxin Xia <xiaqinxin@huawei.com>
Cc: fanghao11@huawei.com,
	prime.zeng@hisilicon.com,
	yangyicong@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v2] ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A
Date: Thu,  5 Dec 2024 18:24:10 +0000
Message-Id: <173342292873.1735998.12216158136590332848.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205013331.1484017-1-xiaqinxin@huawei.com>
References: <20241205013331.1484017-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Dec 2024 09:33:31 +0800, Qinxin Xia wrote:
> HiSilicon HIP09A platforms using the same SMMU PMCG with HIP09
> and thus suffers the same erratum. List them in the PMCG platform
> information list without introducing a new SMMU PMCG Model.
> 
> Update the silicon-errata.rst as well.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A
      https://git.kernel.org/arm64/c/c2b46ae02270

-- 
Catalin


