Return-Path: <linux-acpi+bounces-13591-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7343AAE475
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A32F9A7264
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733CC28A40A;
	Wed,  7 May 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzuj0wmz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405672135C9;
	Wed,  7 May 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631312; cv=none; b=NCpKhGBoC4xLZbcfiiFPdb2fDO0Ov/H62XCrtqNYuJma1KglQGiDWhU7YC8Zb7WH2N/6dRTegT7vJgRG4XpQYI7pERN5eQpZyfkrLs/HDsK2y45QtMOAfFqbxYHP7IKITSe7wznHNPq4W0I5ao614FAL0fR4eKoEoy2azejwfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631312; c=relaxed/simple;
	bh=+Pl1wgxLDGfI331J470iytuKu5DjqgecfozUU3odKcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNH547oF9eIjWwNA2/VgMAUK0tbnmGgf5cCGUDMl8CqqJmZwQctPDUjS0FuA2gyqm9TrY60elRsoGC9j75fs7JYYm9C+xtNH75gy8FJ/CV5krIVcXV0YYk2hxn+oE6TD58yNs7+MEqfL/QCFaHC6qeFOVe70aDcWQVlMTtNOEhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzuj0wmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07578C4AF0D;
	Wed,  7 May 2025 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746631311;
	bh=+Pl1wgxLDGfI331J470iytuKu5DjqgecfozUU3odKcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzuj0wmzcA99+V/TrfvfgKAhHT8WTkJj6fPsC2ZXFpyAyZmjb/KtCfHa7xCh0fe+h
	 SzVSO83oLHaJrdQOtVl3g5Tbo3Dq+rHCzZetZLsp/ew6LfqhgVpvN/QwE1n+s2wMc+
	 AXCBa8DjRfRF5U+GB7JygCElsE0RH2FplypRvVNt5c7ixsHhJH8PQi/YT5ArJH8LOj
	 M7OizJ4M4TJ7sXHo6hhGALe7rw6fSoGH94UzlqtAyVJitbrXrU7i+N5igXDywOmaJ4
	 Vl/pA4n4BnNpFIVFGSXn5XgHFyMifq1smbpdx1edsLxTRuOBhsGUd+hV65rz+0BV9n
	 TmI5yMtxM+mjw==
Date: Wed, 7 May 2025 18:21:42 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rafael@kernel.org, lenb@kernel.org, alison.schofield@intel.com,
	rrichter@amd.com, bfaccini@nvidia.com, haibo1.xu@intel.com,
	david@redhat.com, chenhuacai@kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, chenbaozi@phytium.com.cn,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-ID: <aBt6hihp4m3fbd02@kernel.org>
References: <20250506062245.3816791-1-wangyuquan1236@phytium.com.cn>
 <20250506185544.474d025e43ebadadaedb982a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506185544.474d025e43ebadadaedb982a@linux-foundation.org>

On Tue, May 06, 2025 at 06:55:44PM -0700, Andrew Morton wrote:
> On Tue,  6 May 2025 14:22:45 +0800 Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
> > acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> > with the expectation that numa_cleanup_meminfo moves them to
> > numa_reserved_meminfo. There is no need for that indirection when it is
> > known in advance that these unpopulated ranges are meant for
> > numa_reserved_meminfo in support of future hotplug / CXL provisioning.
> > 
> > Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> > ranges directly.
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > ---
> > 
> > Changes in v2 (Thanks to Dan & Alison):
> > - Use numa_add_reserved_memblk() to replace numa_add_memblk() in acpi_parse_cfmws()
> > - Add comments to describe the usage of numa_add_reserved_memblk()
> > - Updating the commit message to clarify the purpose of the patch
> > 
> > By the way, "LoongArch: Introduce the numa_memblks conversion" is in linux-next.
> 
> So is this patch dependent upon "LoongArch: Introduce the numa_memblks
> conversion"?

Yes, the previous version of this patch failed to build on loongarch.

-- 
Sincerely yours,
Mike.

