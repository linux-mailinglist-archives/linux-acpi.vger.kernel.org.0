Return-Path: <linux-acpi+bounces-15549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A945AB1CA82
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B013A3FED
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E772BEC21;
	Wed,  6 Aug 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rai60qGb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16529ACC4
	for <linux-acpi@vger.kernel.org>; Wed,  6 Aug 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500537; cv=none; b=c9WAcdsqmXn4PfHsr+cJ+qJkabRqnFHFEybn2Mv0U6hWv0CoSQvaqmNfChuug/g7ho/u4YloXj1ono9AOil4fBWSnojNFsYPVLmoOXJevOn7NnLraEKrnnZQstK+NhFXCwqSI5WooZttGGtmuBRbKyaZZ3eP5DxtMBBcSYyATxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500537; c=relaxed/simple;
	bh=fxGXWoIzmV7fwfLiALt+GghX9DniVQ8lfeVCx87P5kw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bLbOkRJDsnf+q3hscfn9gJozDyhcSpUetkC8RTGiftbxcG1RcxG8OvYtpABnbfU8Bz0McOLNBmEsz/Hkjl8z9t2eX/tg6r5pVmnBBZ/96Ar3Er/Wl8rXHlgGokXDCS4qe7e7J7LGM6HhcSwCzPL5n+UDOdWMznB5XWHg2h3P+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rai60qGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4EAC4CEE7;
	Wed,  6 Aug 2025 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500536;
	bh=fxGXWoIzmV7fwfLiALt+GghX9DniVQ8lfeVCx87P5kw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rai60qGbLRO3cvn0H8lxYf92NtVL9N8MDFzuvtcePewnRKY3yhlUlQl5wISrSFHEi
	 5AXxe0nJe2LFkEY8rZB+3sGS0JIIbvPPgiPogQrTG5hrudlRqZEROxqdHaND+zw4Uk
	 fhrVkXE+z1XGz4eUKvqKHFv8XRpLqQRpvyF/8rQp6WbRSiR388ezdC6FMDxMXqq6d2
	 OpLj8zbPy5GdgkktykgrhLnaxwxgTUJdFbETro82C49xwfMmBew2rv+EDT2cayoE3w
	 ehBvFr7dpJQNYUkLESaiKshOTROiHpeS31apO/Fl9bF4jrfxX+IsfJantZ1Tvt6BDw
	 RU9tdRCKAw4Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBD383BF63;
	Wed,  6 Aug 2025 17:15:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] ACPI: support BGRT table on RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450055074.2863135.7748247249569837976.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:50 +0000
References: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, aou@eecs.berkeley.edu, ryan.roberts@arm.com,
 alex@ghiti.fr, rafael@kernel.org, catalin.marinas@arm.com,
 kernel@vger.kernel.org, cuiyunhui@bytedance.com, linux-acpi@vger.kernel.org,
 akpm@linux-foundation.org, lenb@kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Tue, 29 Jul 2025 15:15:33 +0200 you wrote:
> The BGRT table is used to display a vendor logo in the boot process.
> There is no good reason why RISC-V should not support it.
> 
> Remove the architecture constraint.
> 
> Heinrich Schuchardt (2):
>   RISC-V: ACPI: enable parsing the BGRT table
>   ACPI: support BGRT table on RISC-V
> 
> [...]

Here is the summary with links:
  - [1/2] RISC-V: ACPI: enable parsing the BGRT table
    https://git.kernel.org/riscv/c/1f768661a03e
  - [2/2] ACPI: support BGRT table on RISC-V
    https://git.kernel.org/riscv/c/bf2825bf00ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



