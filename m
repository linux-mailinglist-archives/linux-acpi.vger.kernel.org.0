Return-Path: <linux-acpi+bounces-9502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF59C5CEF
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 17:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5A42856F7
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114A2205125;
	Tue, 12 Nov 2024 16:10:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0E2038B0;
	Tue, 12 Nov 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427836; cv=none; b=ZgZFnCFg0OovOado5COKs59KPvbjYZrOjz2nUJfGikXjG2mP7/03m6g76h0ccTogHKyIQNQzSgLzjEKU7d5pvLwPKJPIqrn4elFaFnjTZlDluhz9PnHWXF8y7Q/0Lnu+uX3sO9RYpUnpqcUiTh6BSBpxqlrSTztGe3XFZ1iql18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427836; c=relaxed/simple;
	bh=QLra7NV28lzpjazv6l8OdPtEw2eWo51juuvnnwEKi2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbAioQfEpGWDr7fB+E5uO6gZMx5VGRK85AWZP3VKfoAXLs1o/xH4uTKM8Ozz5U5Gln16greeeXjz2IrvzkPbMH44oAYJaZxpvTSCx8XndWT7Lh5gT1EhAGAOxNLVwd6l88Vfncr0JvD+3K6UFkodVIP9yxxmNQAoEliOZC8DnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFCDC4CECD;
	Tue, 12 Nov 2024 16:10:32 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Min-Hua Chen <minhuadotchen@gmail.com>
Cc: Will Deacon <will@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi/arm64: remove unnecessary cast
Date: Tue, 12 Nov 2024 16:10:29 +0000
Message-Id: <173142780465.896456.12212628053726419059.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240917233827.73167-1-minhuadotchen@gmail.com>
References: <20240917233827.73167-1-minhuadotchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 18 Sep 2024 07:38:24 +0800, Min-Hua Chen wrote:
> DEFINE_RES_IRQ returns struct resource type, so it is
> unnecessary to cast it to struct resource.
> 
> Remove the unnecessary cast to fix the following sparse warnings:
> 
> drivers/acpi/arm64/gtdt.c:355:19: sparse: warning: cast to non-scalar
> drivers/acpi/arm64/gtdt.c:355:19: sparse: warning: cast from non-scalar
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] acpi/arm64: remove unnecessary cast
      https://git.kernel.org/arm64/c/f95382d73ec8

-- 
Catalin


