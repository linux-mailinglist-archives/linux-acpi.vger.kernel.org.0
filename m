Return-Path: <linux-acpi+bounces-14887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0884BAEFC4B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1654C166C80
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE072749D9;
	Tue,  1 Jul 2025 14:28:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A16DF49;
	Tue,  1 Jul 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380106; cv=none; b=eLeDmuQnZUstVCvZjvgkHTwTEhFSreniG+uJAHqvOiWC/FyPlIUdYortZJyfLjsvjxXTP0NxWBPHLinF5/Zia0VZuzqb7HeVLPmlH0eSiSUCUGAzc5CdRvUamL0CbeqgQE51x6WIN24s9OxRuyWkkgHe7/yqF0l2mo2CEGdUjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380106; c=relaxed/simple;
	bh=C4shzNZu6UdyapRgoSK+RNBLoF3i5rNrUSKzA3InY/8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLhznwnLeKX6gMCzlDqlJ9ZcXT0M3eWCeQGRk5iyEWfLfca5chYiDqwONc+KRpL1eDMh/iUhDwmR/CB19Rbekw5FzoTMwDMXVye7uCPLdaOq9okUzdjcXxtBXniOPVS5rV1xBQY+dt3gS77gF3qrcvoxyPtvVn7js2ae5W0RQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE45C4CEEB;
	Tue,  1 Jul 2025 14:28:23 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Hanjun Guo <guohanjun@huawei.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Liu Wei <liuwei09@cestc.cn>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Li Chen <me@linux.beauty>
Subject: Re: [PATCH v2 0/2] ACPI: Improve SPCR handling and messaging on SPCR-less systems
Date: Tue,  1 Jul 2025 15:28:21 +0100
Message-Id: <175138008828.1963850.11865219339288044710.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620131309.126555-1-me@linux.beauty>
References: <20250620131309.126555-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 21:13:06 +0800, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> This small series improves the kernel behavior and output when the ACPI SPCR
> table is not present or not supported.
> 
> Currently, even on systems that completely lack an SPCR table, the kernel prints:
> "Use ACPI SPCR as default console: Yes"
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/2] ACPI: Return -ENODEV from acpi_parse_spcr() when SPCR support is disabled
      https://git.kernel.org/arm64/c/b9f58d3572a8
[2/2] ACPI: Suppress misleading SPCR console message when SPCR table is absent
      https://git.kernel.org/arm64/c/bad3fa2fb920

-- 
Catalin


