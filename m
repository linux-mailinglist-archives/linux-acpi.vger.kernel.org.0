Return-Path: <linux-acpi+bounces-7614-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467F3954D76
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 17:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55B2286CA9
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117911BE871;
	Fri, 16 Aug 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVq56FS2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F841BDA85
	for <linux-acpi@vger.kernel.org>; Fri, 16 Aug 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821385; cv=none; b=ohdMcAtJTHAd85/VhKGgay91GlSAAyKMPd9NNJ6yyjTwrKMSp1bdfY8PSURiZDJMxy25VxprAiCwArv2mlgQP0lFOvqLSJ0DMv/Nh+oSgP8bZ6VI8Ah6zInNyACZD/dH0vhS42RVQjeKYwYrb+bFXQkXQ/iGTsQmNR2DOziP3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821385; c=relaxed/simple;
	bh=+2Tn9kmllXDj7JkE8vNvNFNbw3H4wLxCwr7GO6xQww8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlNyjJx8vp4xK8Ll97Or9KX1HLaN2GViRU1azIyDaikWzMxbZ7hpFAZvjuUa6eUnTE9xjt4YPQpPB+sd/1AMn5mye5S4F6G4IpHb7fW6RAhOxO7XoPfpKsn6zfs7XAOzcaXSR72njoI5gDKUOW1ROImlo/cbP0ByVTFZO27bYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVq56FS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1267FC4AF0B;
	Fri, 16 Aug 2024 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821384;
	bh=+2Tn9kmllXDj7JkE8vNvNFNbw3H4wLxCwr7GO6xQww8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVq56FS216WhCH/vpr/yASPP+0nLlAxgKUV2aDEMPlccA9XgLlnpSrHcjmkO2ZdHs
	 La3FRjNwomOs9sY2akDTGWQIlu70sqe7FtIPrLCA1de6tA82F9n/vbcHMf++q4ex+V
	 Yw/CDXWOYzbhfgMGgbaLohmeEHMEPqYGgQctNyMpZKSkXA+UZWMdra50Dfs8Nf11+x
	 mcEcabN7Ks+i407htz+flVgHsrln/1dbFNjWlDGQTaIqEk/h5bsKVW4cjutGu9xPI5
	 9UZSbZBDi0S3wglete2HfQ0E0gMCus1Aaw9YOlyqQZDq9KSQYLycemxKOYjPsp8en7
	 aBJOG9iUYNdgg==
From: Will Deacon <will@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ACPI: ARM64: add acpi_iort.h to MAINTAINERS
Date: Fri, 16 Aug 2024 16:15:56 +0100
Message-Id: <172380442476.1161703.15655431391686267540.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240808130946.1028376-1-guohanjun@huawei.com>
References: <20240808130946.1028376-1-guohanjun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 08 Aug 2024 21:09:46 +0800, Hanjun Guo wrote:
> IORT(Input Output Remapping Table) represents the I/O topology of an
> Arm-based system for use with the ACPI, so acpi_iort.h is for arm64
> only.
> 
> This helps git-send-email to figure out the proper maintainers when
> touching the file.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: ARM64: add acpi_iort.h to MAINTAINERS
      https://git.kernel.org/arm64/c/ba8b7f7f2b79

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

