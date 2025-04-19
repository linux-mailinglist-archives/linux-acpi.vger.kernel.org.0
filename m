Return-Path: <linux-acpi+bounces-13121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404B9A9422D
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Apr 2025 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A8518954ED
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Apr 2025 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67D17B4FF;
	Sat, 19 Apr 2025 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBfoLQox"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF29288CC;
	Sat, 19 Apr 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745049116; cv=none; b=SgF5zVN+6UCqL68HqnEt9Wu4yMsNlvNodnyyz27LLiZ/PbMcuJdVSZZIS78RM2yG02tJlvFNAmXd9kZl+k8aocKnw7OayV7Jyqe1GoSfWhwvu9yi+twR6vJ9Sos8AwsrOsAnTxH26FooAHgYgf38byGHuoK8SHIPjKW7vQkvQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745049116; c=relaxed/simple;
	bh=E25V98aVCwrCilbltTLlWt2+/aCJN7l5q9y98oKOc9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfCqYWEbThZPxfflwt080UfAShg77EDq2sZVpcFQWeHxRY+FaAFREZ8tIFetzFxpiBZ+Q94Dd+A7Z+pwwXrM2pVjnRnms53mHgX8xf/B6lllDJdPvUGfQGTul1pwfhwRjRsfJpGtPyiUglIcJYpyRj7ExN0RHi0ApVl9a89DhIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBfoLQox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03E2C4CEE7;
	Sat, 19 Apr 2025 07:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745049115;
	bh=E25V98aVCwrCilbltTLlWt2+/aCJN7l5q9y98oKOc9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBfoLQoxO0nmDpeDfxZD4Hke/hxs26KgdXJXCEsaz/TXl8ohNPna2SWzdn7hfnCsJ
	 otvtUAOIF/vf7nas6lNOc92rrG/gP33Tm1JMq9bH+CY6fSUQQHqTwzYIiI8pX1NgYg
	 rWGVJsmAXOHYN2OaP1e4qCyzbbS94E8NOg2MGlADP7/5cJp+9NbfxWBVtAMsOXWibS
	 0xGGzQSen4+Al7XEInYTICel6ifyjdOcDSBS2s2Jwd+OVJYIV8R6kL814MeZ+OLeME
	 g3E/weD77lKzJJGRhJlOZrdH/bWLNm3aqyxFEuaDp3rQmzBGLbWVOmtagrOJkjTr+0
	 BTM5Xum45YhhQ==
Date: Sat, 19 Apr 2025 10:51:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
	akpm@linux-foundation.org, david@redhat.com,
	Jonathan.Cameron@huawei.com, dave.hansen@linux.intel.com,
	dan.j.williams@intel.com, alison.schofield@intel.com,
	chenbaozi@phytium.com.cn, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/1] LoongArch: Introduce the numa_memblks conversion
Message-ID: <aANWElXU6wi4QJt2@kernel.org>
References: <20250409070250.3225839-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409070250.3225839-1-wangyuquan1236@phytium.com.cn>

Hi Yuquan,

On Wed, Apr 09, 2025 at 03:02:50PM +0800, Yuquan Wang wrote:
> "mm: introduce numa_memblks"(87482708210f) has moved numa_memblks
> from x86 to the generic code, but loongarch was left out of this
> conversion.
> 
> This patch introduces the generic numa_memblks.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
> 
> Background
> ----------
> I am managed to land the patch[1] "mm: numa_memblks: introduce numa_add_reserved_memblk"
> but kernel test CI noticed build errors[2] from loongarch64-linux-gcc.

I think you can just add a dummy static inline numa_add_reserved_memblk()
to arch/loongarch/include/asm/numa.h to fix the build. Then moving
loongarch to numa_memblks won't be a stopper for your change.
 
> Link:
> [1]: https://lore.kernel.org/all/20250409040121.3212489-1-wangyuquan1236@phytium.com.cn/
> [2]: https://lore.kernel.org/all/202503282026.QNaOAK79-lkp@intel.com/

-- 
Sincerely yours,
Mike.

