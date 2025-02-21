Return-Path: <linux-acpi+bounces-11369-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9466A3F4AF
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D69B189776C
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67591E489;
	Fri, 21 Feb 2025 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1N2zuu8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F3C148;
	Fri, 21 Feb 2025 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141931; cv=none; b=hdMt4Mnd/naptOFW/2Q85yCi9ULoPcxhg7tShJH7UcLNGiHx5zgXoJ/M54263S2Z7hCj1FTfMoCz7LdCaiSAKIFs10mX21UWY4AhsSFlJeusLDPcOxP4nFQmh6AFSp0ZTd3BQk9TE7BfmSOujANR7GG4GEPFrPX6tsZxfIKHcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141931; c=relaxed/simple;
	bh=RBXMEDSJ83N9frFVcMZIclEL2HZ8R+cTooDFwtl8fwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fymF63fsh/pBs2vMr7Tz9HHjGaLOvHS0djweYIELRlSDSQ+sZcs6n0N3ZTO28EvMyyXUGtgUaxU/LxSeTDcXROoo4rQLICw7JejGGwIIWjHZ9A/vVYbodFFXrPCaI7Rc0SksdiZVw+tGeDBgzFd+FemiHjlxc7SS3fdoy37f5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1N2zuu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA89C4CED6;
	Fri, 21 Feb 2025 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740141931;
	bh=RBXMEDSJ83N9frFVcMZIclEL2HZ8R+cTooDFwtl8fwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1N2zuu8V2cjuqY5N63qf7bv1F6BWEXKod4y6N8JzipHtSedAQGqejMo+B/GKPOsH
	 1wDp666pN01+RhsYZYUIV1K2Eme+YP0qCnq4J5pz0QPTouwIApni6KB6/BrafJQK/w
	 2exS1/vm0W0xDfhzuJ484f1t6n4AjKkCaeqU8TEi6WTFik9Jt3uKVdE+uMjpNlX+3O
	 THbq/fZEL9ebSfDCYnkcuxdPrn89Adpxu0ax7wyp7Dnjzet7R0MQBTy/DbwmnKRKJQ
	 ouApp8cJwf0Oz861rEKrlxzBHlLmW+No+fsQIfg4+IczRaUO/FWiaWHDVLBjPBxddu
	 eeGYDJLZ0CTaw==
Date: Fri, 21 Feb 2025 14:45:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, rafael@kernel.org,
	lenb@kernel.org, maobibo@loongson.cn, guanwentao@uniontech.com,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	dave.jiang@intel.com, haibo1.xu@intel.com,
	linux-acpi@vger.kernel.org, zhanjun@uniontech.com,
	niecheng1@uniontech.com, chenlinxuan@uniontech.com
Subject: Re: [PATCH] ACPI: NUMA: Move get_numa_distances_cnt() helper to
 needed location
Message-ID: <Z7h1XWyjKIkyR2zJ@kernel.org>
References: <D87315C93AF20D4E+20250220042037.942802-1-wangyuli@uniontech.com>
 <Z7bHPVUH4lAezk0E@kernel.org>
 <13526D98D27F6E36+705ff063-e7f6-49ff-a29a-0f5e5101c000@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13526D98D27F6E36+705ff063-e7f6-49ff-a29a-0f5e5101c000@uniontech.com>

Hi,

On Thu, Feb 20, 2025 at 02:25:33PM +0800, WangYuli wrote:
> Hi Mike,
> 
> On 2025/2/20 14:10, Mike Rapoport wrote:
> > There's no need for relocation, just drop the unused function.
> 
> Okay.
> 
> But  please take a look at line 295 of the original srat.c. Should the type
> of variable 'd' there be changed to u64, as mentioned in the commit message?

int is enough for more than 2 million nodes, I don't see a problem with it
 
> If yes, I can quickly put up another commit just to tweak this one place.
> 
> Thanks,
> 
> -- 
> WangYuli






-- 
Sincerely yours,
Mike.

