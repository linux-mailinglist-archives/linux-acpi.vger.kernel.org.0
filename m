Return-Path: <linux-acpi+bounces-19970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D738BCF5EC5
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 00:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21ADE30D1BDB
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D63090DE;
	Mon,  5 Jan 2026 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw9S84SF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1173009EC
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jan 2026 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653929; cv=none; b=IsCvrHeRytiDzfxOtfgk0Eh15vpebWoKyqOmWOzF7mzdvvpXwXwMhu+ufPdL3FDh2GQecPf3lzHF3WWcQeeGOzl+ss2l4+StBc5xqqNA499nBP9471nuQjk953YihLmieA6fPn0o24c0fmy+NurQ5u+CZOJLu1+d/egziXRhpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653929; c=relaxed/simple;
	bh=eVFCFughzWlleH6dRyl2s/mRvVF8Hq50KtBaaSeHaKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZqn31q48fUOl0PPeSznzs2I7SxqgXBXq2OD8+YaSq3XyXatcor/M1Fu+rncOhjhN8xayNYiPA+lcqhXiWfH9YWSRcLtJJ5iY+E5D3oLzLKzWu77DInJYnKkkkkvDH9Mol7QvWhKYSP1924zDqhxvGInnfjz/peiuTzibYG3fU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw9S84SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E911C16AAE;
	Mon,  5 Jan 2026 22:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653928;
	bh=eVFCFughzWlleH6dRyl2s/mRvVF8Hq50KtBaaSeHaKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mw9S84SFVQ9vZkjs3dY/ABZIsCCfHcb+c2xNb+ToYs3bv3jbPUHk9qosudiEfJlSr
	 veQa8LoOS7kwNdGEn35dSHMfcwDCfyXDR8hBrFU43GTGmTXg1XyHgfpP3fzzpK2wSG
	 zzjaGLfs5Bl4pMnTFrI6Qk/C/kFvFEZGpm4dJygGi3kzAP6pbQb9W4C0NDBhFLSLhN
	 4e/XTY4zbTFdtXKoLxn5hTh/iQgxAK/4krPvRH9dEi2lMOgygJcpkyaaRlVxXD/XjN
	 M6gXdPfA5FCifDMoxWlWelVep+R69eILz5QhmFHnB2xtgLq8kGsTVahIa0g9O2HniJ
	 +5to89oOMPdNg==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Update the maintainers for ARM64 ACPI
Date: Mon,  5 Jan 2026 22:58:22 +0000
Message-ID: <176764576478.1442346.3568871194644962163.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219144906.348353-1-guohanjun@huawei.com>
References: <20251219144906.348353-1-guohanjun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Dec 2025 22:49:06 +0800, Hanjun Guo wrote:
> ARM64 ACPI patches go via ARM64 tree, but the listed maintainers
> for ARM64 ACPI don't include Catalin and Will, and there is no
> F: line under the ARM64 architecture entry, so emails will not
> route to Catalin and Will in an automatic way.
> 
> Adding Catalin and Will to the maintainers entry for ARM64 ACPI
> to fix the problem, it will make life easy for merging ARM64 ACPI
> patches.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] MAINTAINERS: Update the maintainers for ARM64 ACPI
      https://git.kernel.org/arm64/c/e97e3e31d898

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

