Return-Path: <linux-acpi+bounces-19121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83927C70C6B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 20:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABA804E2F80
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57B368290;
	Wed, 19 Nov 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBAss/d1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAD3596F1;
	Wed, 19 Nov 2025 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579875; cv=none; b=jg1liRnXEEXkoqySDkLS5xmS/2MYblmhiqXLVqbwyBRW3prbLbGfKf7WvuzdkB0oe5LmYNE1lEeaqXNcE1Rh/vUnoQyoMospfrv8vweWjSM12Iv8SLrrjhKoyjd/KqFzARKZLUiC4vYc0uZWFcnuEOu3YkwXwLUh6csWuoUbms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579875; c=relaxed/simple;
	bh=JQi84GrjRxDal74Vn3H2ScBlsWz6XMmDJZX90zdNxjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mepwVPg25HCl4J1PnTCTKMEJ5KYjlnzs6GLlz9NDe0ZW6FA4UHu79yYOFiokrRNsES3EzW7nQRFyf02p4jahLdJ4+e65jKZ5WcUkMmGURfg+h6BDZJIHh6+k5UZWqsdGLu3QBsJ2FdldVycezfr44Vgv22RmQM2ZbumvpBwNQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBAss/d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0543BC4CEF5;
	Wed, 19 Nov 2025 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763579875;
	bh=JQi84GrjRxDal74Vn3H2ScBlsWz6XMmDJZX90zdNxjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBAss/d1aX9jIqZ4mGzPS2rYQglhv84BKwKHTuQkOgX+0T3huSIkFimS5mZjCQbHV
	 aWZWYvEnJ6P7tauFGFkU9a3StwzbH063dzVu/D6yEHmOVWcm849oCDwVgXvzVgkxP5
	 WRUyOkb77m43TAdKvkIW5Yuh4jW0pVk5sOJwiH7SKeAYS7eblseFHqRdENyjR7jp/a
	 eDSUAT4kxf2kLH4w/yPGuk2fsLYone4iUgfKnrsuDlwmcZ0Z5/VnVkvBpUHdwlmvmc
	 PTBWbBIkdSK6pCrBTR0FoOBdVOG6bWCOq2AEVJQ1J/ZDq8dqSL+QJ5jLWAn69zeEhm
	 HimCnimqKcTKQ==
From: Catalin Marinas <cmarinas@kernel.org>
To: james.morse@arm.com,
	Ben Horgan <ben.horgan@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	amitsinght@marvell.com,
	baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com,
	bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com,
	dakr@kernel.org,
	dave.martin@arm.com,
	dfustini@baylibre.com,
	fenghuay@nvidia.com,
	gregkh@linuxfoundation.org,
	gshan@redhat.com,
	guohanjun@huawei.com,
	jeremy.linton@arm.com,
	jonathan.cameron@huawei.com,
	kobak@nvidia.com,
	lcherian@marvell.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	peternewman@google.com,
	quic_jiles@quicinc.com,
	rafael@kernel.org,
	robh@kernel.org,
	rohit.mathew@arm.com,
	scott@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com,
	xhao@linux.alibaba.com,
	reinette.chatre@intel.com,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
Date: Wed, 19 Nov 2025 19:14:52 +0000
Message-ID: <176357969271.2096121.17612291613784127358.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119122305.302149-1-ben.horgan@arm.com>
References: <20251119122305.302149-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

On Wed, 19 Nov 2025 12:22:30 +0000, Ben Horgan wrote:
> Just a handful of minor changes based on v5 review comments. See individual
> patches for change lgos. I haven't asked James to host any branches for this
> revision but please let me know if this would be helpful to anyone. Thanks for
> all the help with reviews and testing.
> 
> Previous cover letter from James:
> 
> [...]

I queued the series on a branch to give it a bit of exposure in -next
for the next 10 days or so. If nothing falls apart, it should go
upstream but there's always a risk of the series being dropped at short
notice. I aim to keep the branch stable and only apply fixups on top if
needed.

Greg, I haven't got any acks from you, I assume you don't have any
objections (please let me know otherwise).

Applied to arm64 (for-next/mpam), thanks!

[01/34] ACPI / PPTT: Add a helper to fill a cpumask from a processor container
        https://git.kernel.org/arm64/c/796e29b857ae
[02/34] ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear levels
        https://git.kernel.org/arm64/c/eeec7845e966
[03/34] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use pptt cache as one structure
        https://git.kernel.org/arm64/c/cfc085af8398
[04/34] ACPI / PPTT: Find cache level by cache-id
        https://git.kernel.org/arm64/c/41a7bb39fede
[05/34] ACPI / PPTT: Add a helper to fill a cpumask from a cache_id
        https://git.kernel.org/arm64/c/a39a723a6f1e
[06/34] arm64: kconfig: Add Kconfig entry for MPAM
        https://git.kernel.org/arm64/c/d8bf01d80919
[07/34] platform: Define platform_device_put cleanup handler
        https://git.kernel.org/arm64/c/f5915600cc4c
[08/34] ACPI: Define acpi_put_table cleanup handler and acpi_get_table_pointer() helper
        https://git.kernel.org/arm64/c/96f4a4d53e66
[09/34] ACPI / MPAM: Parse the MPAM table
        https://git.kernel.org/arm64/c/115c5325beae
[10/34] arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
        https://git.kernel.org/arm64/c/f04046f2577a
[11/34] arm_mpam: Add the class and component structures for firmware described ris
        https://git.kernel.org/arm64/c/01fb4b822472
[12/34] arm_mpam: Add MPAM MSC register layout definitions
        https://git.kernel.org/arm64/c/aa64b9e11051
[13/34] arm_mpam: Add cpuhp callbacks to probe MSC hardware
        https://git.kernel.org/arm64/c/8f8d0ac1da78
[14/34] arm_mpam: Probe hardware to find the supported partid/pmg values
        https://git.kernel.org/arm64/c/bd221f9f82af
[15/34] arm_mpam: Add helpers for managing the locking around the mon_sel registers
        https://git.kernel.org/arm64/c/d02beb06ca2a
[16/34] arm_mpam: Probe the hardware features resctrl supports
        https://git.kernel.org/arm64/c/8c90dc68a5de
[17/34] arm_mpam: Merge supported features during mpam_enable() into mpam_class
        https://git.kernel.org/arm64/c/c10ca83a7783
[18/34] arm_mpam: Reset MSC controls from cpuhp callbacks
        https://git.kernel.org/arm64/c/f188a36ca241
[19/34] arm_mpam: Add a helper to touch an MSC from any CPU
        https://git.kernel.org/arm64/c/475228d15dd6
[20/34] arm_mpam: Extend reset logic to allow devices to be reset any time
        https://git.kernel.org/arm64/c/3bd04fe7d807
[21/34] arm_mpam: Register and enable IRQs
        https://git.kernel.org/arm64/c/49aa621c4dca
[22/34] arm_mpam: Use a static key to indicate when mpam is enabled
        https://git.kernel.org/arm64/c/3796f75aa795
[23/34] arm_mpam: Allow configuration to be applied and restored during cpu online
        https://git.kernel.org/arm64/c/09b89d2a72f3
[24/34] arm_mpam: Probe and reset the rest of the features
        https://git.kernel.org/arm64/c/880df85d8673
[25/34] arm_mpam: Add helpers to allocate monitors
        https://git.kernel.org/arm64/c/c891bae66423
[26/34] arm_mpam: Add mpam_msmon_read() to read monitor value
        https://git.kernel.org/arm64/c/823e7c3712c5
[27/34] arm_mpam: Track bandwidth counter state for power management
        https://git.kernel.org/arm64/c/41e8a14950e1
[28/34] arm_mpam: Consider overflow in bandwidth counter state
        https://git.kernel.org/arm64/c/b35363793291
[29/34] arm_mpam: Probe for long/lwd mbwu counters
        https://git.kernel.org/arm64/c/fdc29a141d63
[30/34] arm_mpam: Use long MBWU counters if supported
        https://git.kernel.org/arm64/c/9e5afb7c3283
[31/34] arm_mpam: Add helper to reset saved mbwu state
        https://git.kernel.org/arm64/c/201d96ca4c86
[32/34] arm_mpam: Add kunit test for bitmap reset
        https://git.kernel.org/arm64/c/e3565d1fd4dc
[33/34] arm_mpam: Add kunit tests for props_mismatch()
        https://git.kernel.org/arm64/c/2557e0eafec1
[34/34] MAINTAINERS: new entry for MPAM Driver
        https://git.kernel.org/arm64/c/ce1e1421f8d8

-- 
Catalin


