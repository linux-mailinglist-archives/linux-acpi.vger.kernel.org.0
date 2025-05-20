Return-Path: <linux-acpi+bounces-13832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7708ABE22D
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 19:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A54C16A537
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 17:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E09325B1D3;
	Tue, 20 May 2025 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZqBsc5HF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37B1A83FB;
	Tue, 20 May 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763601; cv=none; b=pmxxcQwjGHg6ORr3D5+7XcdsMxJEb7oTN5ear/Re8A0T1YTcuVWbB9pQRDw1gkdmz7JB88tD6sDcDZ8KGSZAbj8SCHhMLaLv8TgnX1KueKOXZ2Nwbq7SJixX6afOi25SmqznofC/FD4D8kxVtJgMa3boCcZlzFxB0twRL1hhWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763601; c=relaxed/simple;
	bh=k3NQLgEEWquiEaMW04bfBp11JwsCzmF7UqfW52cvxC4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rtskkVsgx+mJKV+ZgwoGr2KytMhN25HATasQs3qA5Y0oYLdCc9YmO8G/LGo1Gf+7u1pKeKtYxwslg3i1DX53oXHuMPTA/v8cP93o48DyF7fUDRvcw88qfVdXCHIJJI1aaU9orJbQBLcJ1YcrlLh2dfX7MQIoIBK7w9vbU56km1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZqBsc5HF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB50CC4CEE9;
	Tue, 20 May 2025 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747763600;
	bh=k3NQLgEEWquiEaMW04bfBp11JwsCzmF7UqfW52cvxC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZqBsc5HFIPyN/31NShiUu1aE6ezcxCZLt0AQY8Be4Ubp0fGYvIKRKOhlAE4r8GDQ6
	 tFtOh/AFHYKtriMjtIbvOdUDlGZkPzLmT83E/Cvin2R7ELx1QKgraQFIkTro+5yquU
	 so9nc7FFf1Ol0QTad9+fWk8kUlZLpzF8psk8Ou+U=
Date: Tue, 20 May 2025 10:53:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
 honggyu.kim@sk.com, yunjeong.mun@sk.com, gregkh@linuxfoundation.org,
 rakie.kim@sk.com, rafael@kernel.org, lenb@kernel.org,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
 osalvador@suse.de, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v9] mm/mempolicy: Weighted Interleave Auto-tuning
Message-Id: <20250520105319.99f3f2f980617e213db6be20@linux-foundation.org>
In-Reply-To: <20250520141236.2987309-1-joshua.hahnjy@gmail.com>
References: <20250520141236.2987309-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 07:12:35 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Changelog
> v9:
> - Code cleanups & wordsmithing
> - Added tags for Honggyu and Ying

Honggyu's Reviewed-by is the only change I'm seeing between v8 and v9,
which is unexpected?


