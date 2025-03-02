Return-Path: <linux-acpi+bounces-11694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DDAA4B257
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 15:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7DC3B1454
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DDF1DB377;
	Sun,  2 Mar 2025 14:47:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D666D1172A;
	Sun,  2 Mar 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740926878; cv=none; b=N6eS5VWFnQBtw6U9AWjRwU+86KxcH0SCjlf23UcRRXfAXA3dQtA1mofR2Ov7sTqmVroMfu8ST0z3mlJShaLCPBAiZ11f2qwxTCvcsWmL2nasN3w1nVPlZci+A0RMX4xUFOBqHjZnroagAekfGpjmFaWK8385NSsetbvqrFGSiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740926878; c=relaxed/simple;
	bh=TvNlMy5a1zeWKovlaBsRCjV4/2uNeb1Zo4cBHz1PjTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFN5CKGDvIX9srUhmavuieZQIIE6TejT3uYnT8qy08drtAJGdKOF0CXW/450VHOlxj2m83xECGYD/Z1NI/bOFL+Lo968ZEIYFYBayJBsaoUok2O98/xok3YbsiaMeVXo2sny7vYNBddmhLnGr0U7A0LkpwL32m2LombImH1AtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99407106F;
	Sun,  2 Mar 2025 06:48:03 -0800 (PST)
Received: from bogus (unknown [10.57.37.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E03F93F66E;
	Sun,  2 Mar 2025 06:47:47 -0800 (PST)
Date: Sun, 2 Mar 2025 14:47:44 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, jassisinghbrar@gmail.com,
	liuyonglong@huawei.com
Subject: Re: [PATCH] mailbox: pcc: Fix can't clear level interrupt of type3
 in cornor case
Message-ID: <20250302144744.h6ybi4sstxduesvh@bogus>
References: <20250227072341.28693-1-lihuisong@huawei.com>
 <Z8HlHDAUWqQOjrCH@bogus>
 <05e7a220-7886-77ad-af58-7847c679579a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05e7a220-7886-77ad-af58-7847c679579a@huawei.com>

On Sun, Mar 02, 2025 at 03:30:01PM +0800, lihuisong (C) wrote:
>
> 在 2025/3/1 0:32, Sudeep Holla 写道:

[...]

> > This may be correct way of fixing the issue here, but I am questioning the
> > existence of this flag now. I have some rework on this file. I will pick
> This flag is for shared interrupt case on type3. please see:
> 3db174e478cb ("mailbox: pcc: Support shared interrupt for multiple
> subspaces")
>

Yes, I looked at all the history of this patch and I saw I had suggested
it. So it took a while to recall why it is a must. I was reworking some
of the recent change added which I couldn't review and got merged. I was
convinced for a short period this flag is not needed but I was wrong.

I will repost the patch with minor updated to the commit message as part
of my series soon to avoid any conflicts.

--
Regards,
Sudeep

