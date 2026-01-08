Return-Path: <linux-acpi+bounces-20086-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3804CD066D9
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 23:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D669930021CC
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 22:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2832570B;
	Thu,  8 Jan 2026 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbj/mTtb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8C1B4223;
	Thu,  8 Jan 2026 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911395; cv=none; b=Ut6PRxDHbfSusad906Xeh0iZ74mrFSUTRnN654fRTl4pVj4uwynI/wyTRzZSILyV3dKTRNGyRPePlU9GfANDEVnbbp9y1VfEEr+Gw6S2u33YuznhOLMrhSgKNkwU6ONcwZMSy26KjYvTztP+4iUaknSUBFSs+QGV2kXrUyIZMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911395; c=relaxed/simple;
	bh=Rw/mLLceo9+Wq7pVKPpVKEevuaEDSUDBh0SspUIhv58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVOrKdQ7680/Mde5YBkcIiltvTw+ELDjUmvj4gY43Ui6NpE0BZPkCb+07w8sbd0kZ1jSyzuMPMQf61VjkaqBM0un46w5LjVC+JcUCSdPH+G/VsjFKcJG2julcxzOWXvawRFrDZzr7lF/BPv4HrvmNwxBDdOsRcVqUOAZrhIHlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbj/mTtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A512EC116C6;
	Thu,  8 Jan 2026 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767911395;
	bh=Rw/mLLceo9+Wq7pVKPpVKEevuaEDSUDBh0SspUIhv58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbj/mTtbvEbZrElAKU0dA4NUc8mFm1sVo7ByUaDNI+e16sSTs1wpWKWK55gR5rXxn
	 ZCMVCjybD4YWrAYRsW3YDFELC8B+ClZOT7SIgwhaH9g6bqtZ0+UlLP1FQXIx/Pl+4z
	 s57c2iYl3CvsB9eE/02/MHsoBLgg2Mp8HdRPFhmr57u2UK6+PyeaKqDM8QwL9UzEqZ
	 4hluHPJDuiEPkAQjDMEDpnxngU9w62XdHYEM3iYi42SqaJOPca3PkhzrC4yqggBoIi
	 ro3naBoQqxLtJt+hS0ghUski6vG6uHC3/+ASUjbzmmNvVg6McyhSLYDOsJOxAJ4GSc
	 c3+wEPmVpqidA==
From: Will Deacon <will@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Koichi Okuno <fj2767dz@aa.jp.fujitsu.com>,
	Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6] ACPI: AGDI: Add interrupt signaling mode support
Date: Thu,  8 Jan 2026 22:29:45 +0000
Message-ID: <176790957965.1541183.5588102547570547773.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108075636.524722-1-fj1078ii@aa.jp.fujitsu.com>
References: <20260108075636.524722-1-fj1078ii@aa.jp.fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 08 Jan 2026 16:56:09 +0900, Kazuhiro Abe wrote:
> AGDI has two types of signaling modes: SDEI and interrupt.
> Currently, the AGDI driver only supports SDEI.
> Therefore, add support for interrupt signaling mode.
> The interrupt vector is retrieved from the AGDI table, and call panic
> function when an interrupt occurs.
> 
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: AGDI: Add interrupt signaling mode support
      https://git.kernel.org/arm64/c/f7d5e9e70302

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

