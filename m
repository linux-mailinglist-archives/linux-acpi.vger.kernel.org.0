Return-Path: <linux-acpi+bounces-9277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2FC9BBB2D
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F0A1F2166F
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF091C9EB7;
	Mon,  4 Nov 2024 17:10:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F41C9B87;
	Mon,  4 Nov 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740232; cv=none; b=Q1DV6ydGIogEFwCE9rMaRzOQ902ugDmqMOu5cbd80V2MSaH1FX+17/XU/Cs3A7C/mPuAkRIFSsrO0HldOUQo5H9LIsPAZWgiBKozmJtmSUi88aTTsDenUhcK2pW8zrb4dIIKs7Z0Z9mwfGoCeHQKaQI0MMqsAG3s+a/LNuSUwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740232; c=relaxed/simple;
	bh=Zf3gnnTOoOSPqmF5CftdgqWrAV3uUDXCZKgqq3mjYr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sH9TEDrDcB6WOheDNZkrCSlMxfcwEA0VXUwhBuGOYybm606ODjobBsXyhWv56yxH19899qqXw8IeHzEWW3p1GSxREvCx7cwghzqrwVmOEH3PXf9dqoOgYr2oeWwkUNQ1tCW65Q72vn3rz5O7dw3qfvvdsfQUqVaTKzU21afzASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD02C4CECE;
	Mon,  4 Nov 2024 17:10:28 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	Zheng Zengkai <zhengzengkai@huawei.com>
Cc: Will Deacon <will@kernel.org>,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: GTDT: Tighten the check for the array of platform timer structures
Date: Mon,  4 Nov 2024 17:10:26 +0000
Message-Id: <173074012623.2444105.8147260766565910600.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241016095458.34126-1-zhengzengkai@huawei.com>
References: <20241016095458.34126-1-zhengzengkai@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 17:54:58 +0800, Zheng Zengkai wrote:
> As suggested by Marc and Lorenzo, first we need to check whether the
> platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
> de-referencing what it points at to detect the length of the platform
> timer struct and then check that the length of current platform_timer
> struct is also valid, i.e. the length is not zero and within gtdt_end.
> Now next_platform_timer() only checks against gtdt_end for the entry of
> subsequent platform timer without checking the length of it and will
> not report error if the check failed and the existing check in function
> acpi_gtdt_init() is also not enough.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] ACPI: GTDT: Tighten the check for the array of platform timer structures
      https://git.kernel.org/arm64/c/263e22d6bd1f

-- 
Catalin


