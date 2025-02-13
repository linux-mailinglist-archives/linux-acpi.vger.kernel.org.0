Return-Path: <linux-acpi+bounces-11150-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35EA3413D
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 15:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC93A4E63
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753EB24291C;
	Thu, 13 Feb 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAwhYkup"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F8242910;
	Thu, 13 Feb 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455158; cv=none; b=QS8wjSNybbm1gCRjKRS/sqrgnMSEyYp9h07G6Bygb2DIdjVC+MQmxRpaHEd2lv4mrO/c8gTYvlqfEnui5EB4v6UwcYVQtsY9jjlEk8BsmC6niGlm9ozjBdV+ziu+LrgOgah0LO+MH39dnq4bj9vAbJTYH5fZG4gq3HmGXRFZ03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455158; c=relaxed/simple;
	bh=+yOaOrU3SfpDJ08BIfLD5TlmYaKF+rtZSYB5MoqJ7iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0GQPcAuu4KQIaP5Us9Cx2nDtt+3hpqAUGbq9AEuXDn0iN1Ly90JTv+ifA58t40O/gowpatLm/B6jErG6EyziOrt15bL6puEaeXcuNVmkjax5Vc7UORp1XLsKul2JTXSUD7V40OQrCDE2FzB8DKtc4jQbIEJwXo82/cPpDIZalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAwhYkup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D265FC4CEE8;
	Thu, 13 Feb 2025 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739455158;
	bh=+yOaOrU3SfpDJ08BIfLD5TlmYaKF+rtZSYB5MoqJ7iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAwhYkup5eKlG2Xz6cQXi9HNC/yphKU1h/lW3n9rqNux8T2iM8CXW4RCb5NOGjjbR
	 PZWvmCdXQ+Jgt7079SBSvV/Fwf7aSoytMLIC88CBu2CAnOQvAJ1DuEZe155IBuJBew
	 UQsmwW8Z3XJ+na7FaxgZXDy6TCqhby7tBdP5BcuaUde4rPps/sbWdGJWDP8ZMndljR
	 iPwO3eBZG4l6wHuesirxe1+hhYj4dnYrUBDoel1Cttmg8ke0TFWhThvUtjUS0r9xpU
	 Tuyi7RtzcdtaydK8ZvxBSvAQGzje7kw7gOMlfXLP3wZK06asvU10m+jqrs84NRZ07x
	 ApWRLwUfiaa+A==
From: Will Deacon <will@kernel.org>
To: linux-acpi@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: GTDT: Relax sanity checking on Platform Timers array count
Date: Thu, 13 Feb 2025 13:59:04 +0000
Message-Id: <173944516851.2607091.1871789456035802538.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250128001749.3132656-1-oliver.upton@linux.dev>
References: <20250128001749.3132656-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 28 Jan 2025 00:17:49 +0000, Oliver Upton wrote:
> Perhaps unsurprisingly there are some platforms where the GTDT isn't
> quite right and the Platforms Timer array overflows the length of the
> overall table.
> 
> While the recently-added sanity checking isn't wrong, it makes it
> impossible to boot the kernel on offending platforms. Try to hobble
> along and limit the Platform Timer count to the bounds of the table.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI: GTDT: Relax sanity checking on Platform Timers array count
      https://git.kernel.org/arm64/c/f818227a2f3d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

