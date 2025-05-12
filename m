Return-Path: <linux-acpi+bounces-13690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10766AB4745
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 00:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1609866633
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 22:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5BA29A306;
	Mon, 12 May 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kh2sX2TV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C41929712E;
	Mon, 12 May 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088985; cv=none; b=gincuhZA+oMLbymeAg9yDN6+BTqp9Bw0bg7PqPsvEGAjt15NXUD4zZqWHxCl8NHH4qXcI3Ywhs6aLa5MxodL2iWBtNw8tPJNjY7huKqxsmubgdbS03SieAeWCuYe2R9/MjD62aFr3UPEpFNh1AUzBpXiKUgzsy/J4Ds8gk8QERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088985; c=relaxed/simple;
	bh=5CqDU14g/oFS1Y8GRNwcNL1FWflWWtY4uExr2eEpAmQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A/14vv6yspmTtwuLxza4Nf44PNBKV9EaqGxQeA1iYn7MyRQFcYYg57mN+jnzhGSOcdE7EiKny2Aav9hzyj9QTwHV+GFnVc11MlNqPZaPdNX3EL/eYCzD1GWin0XFoXKzjl/FOFjN0SvtRyGKaD8SKxZAIhqmahd/DzlTXyV+cbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kh2sX2TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792F6C4CEE7;
	Mon, 12 May 2025 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747088985;
	bh=5CqDU14g/oFS1Y8GRNwcNL1FWflWWtY4uExr2eEpAmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kh2sX2TVWN315jHAHFHy9vXhsd+xoCU41dGNMCjEMg1Omz0IBS/J+3lNXTsv9QClO
	 QOted5NLME6FqAh7U3+w88vsjeRVX8PKecV4YB5ZUo41a4v5SLnU4RRL8Zt6pu2oFN
	 7nVwJ46k5TcD8/WizQ4edEBs7Uqta1NiBt5icBSk=
Date: Mon, 12 May 2025 15:29:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>, gourry@gourry.net,
 honggyu.kim@sk.com, yunjeong.mun@sk.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave.jiang@intel.com, horen.chuang@linux.dev,
 hannes@cmpxchg.org, osalvador@suse.de, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
Message-Id: <20250512152944.eab80697d7404a803f9f65e6@linux-foundation.org>
In-Reply-To: <20250512142511.3959833-1-joshua.hahnjy@gmail.com>
References: <87zffizk4r.fsf@DESKTOP-5N7EMDA>
	<20250512142511.3959833-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 07:25:10 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Andrew, I'm very sorry -- do you think you can fold this fixlet in as well?

No probs.

In future, something a little more formal would be preferred, so I
don't have to write your changelog and forge your Signed-off-by:!


