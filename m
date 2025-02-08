Return-Path: <linux-acpi+bounces-10945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E3A2D305
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 03:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E1A3AC3A8
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 02:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADDA154C0D;
	Sat,  8 Feb 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G0CBnfR+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC41547E7
	for <linux-acpi@vger.kernel.org>; Sat,  8 Feb 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738981211; cv=none; b=k+K8JfVm7Yy42KT7C7KJNU2uFv74IUHae0dnp2PfRk0TY3rvA5QdF/m/tIL7NPkTBTJB1mSzFXNhKeoxMzmM2ZmnDoM95Jf0waw2uS7h6Jm/r4gE83/BMhBwM+vBxI9kPjdt69ovp9ZjuNr774vxwNMiJiECjqui2FuNWAVUbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738981211; c=relaxed/simple;
	bh=SQmuHBME72TvK2NLzJcsMzKVVHhZRQ5w/WQRGMmDBTY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PgjG2p7DDEv3Kcjjx2XkXc/so2nfryu+gUGHqN0YxL2LHGMAO49takIWVjX9y5U73OhU5P1YqrCaNmjXaUpJUJ+haSVjy2KgEp7Cvy7NHwwTA/lLVNKSCvVCUl9ky5lI/idh+xpWOgZF06V8ALn7Ue5wirnbFSnOiGxooK89VKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G0CBnfR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B2FC4CEEC;
	Sat,  8 Feb 2025 02:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738981210;
	bh=SQmuHBME72TvK2NLzJcsMzKVVHhZRQ5w/WQRGMmDBTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G0CBnfR+r8GsYvMtK51cAQ4P0lYZCQiXV1lzOfbpdd4vGoScucXAEDHGFQ+NA5KS/
	 gdngN9jzOv1nACTI3xltpWDcGgkCKOfxd5PmJEAjNehGMSatJXb12KIv1lh8pLBqdz
	 19QQXFViYyfy6g74JXyx+Vo/wrrlTZ+W8k3gTjd0=
Date: Fri, 7 Feb 2025 18:20:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, hyeonggon.yoo@sk.com, ying.huang@linux.alibaba.com,
 honggyu.kim@sk.com, rafael@kernel.org, lenb@kernel.org,
 gregkh@linuxfoundation.org, rakie.kim@sk.com, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave.jiang@intel.com, horen.chuang@linux.dev,
 hannes@cmpxchg.org, linux-kernel@vger.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Message-Id: <20250207182009.7fc099c3074ad00338f25e0a@linux-foundation.org>
In-Reply-To: <20250207201335.2105488-1-joshua.hahnjy@gmail.com>
References: <20250207201335.2105488-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Feb 2025 12:13:35 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> This patch introduces an auto-configuration mode for the interleave
> weights that aims to balance the two goals of setting node weights to be
> proportional to their bandwidths and keeping the weight values low.
> In order to perform the weight re-scaling, we use an internal
> "weightiness" value (fixed to 32) that defines interleave aggression.

Question please.  How does one determine whether a particular
configuration is working well?  To determine whether
manual-configuration-A is better than manual-configuration-B is better
than auto-configuration?

Leading to... how do we know that this patch makes the kernel better?

