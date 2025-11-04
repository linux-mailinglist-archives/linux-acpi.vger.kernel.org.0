Return-Path: <linux-acpi+bounces-18500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95EC31F83
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 17:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9CF1887DC8
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690C5299AB5;
	Tue,  4 Nov 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0VT8l1Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39026F445;
	Tue,  4 Nov 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272378; cv=none; b=M8MSmwGYLi5ZrJ19hQjS29tXlFR0D6dr7CkXZnFMnLbFQE+OjT0b9KqzRCoU4YOAOhgwRimj853BCdW9Q9G2nsnMpftIVvpt9YfsDH6AWBIvA79Mv149m8PhzN09xVQeJPhFYFbeX0HRZ74QRLaxKVJlm9/dakY+12yF9ODprGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272378; c=relaxed/simple;
	bh=cqnsj9XBWpA/oXMHKuywF+Rto0eI5dkzdtMZHlTkuqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6ysXpUDwA1kv4QWHJdHqPfqghJu5BMjT2fiEMoxR/sQKMkHL5AuaBN8bMv6od/nIu0uHmpX51uoUZJZhJQGyrE5v45WGY9anp9SyVHseVU+ZCJc1zLgyf26k61lzOen0TS0q8WO4K905y4SVluWZe0Uble92UpBl8cJ5e90gXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0VT8l1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A37C116B1;
	Tue,  4 Nov 2025 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762272377;
	bh=cqnsj9XBWpA/oXMHKuywF+Rto0eI5dkzdtMZHlTkuqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0VT8l1YwCz0aL5Sk09v0FM4wvGDp5jij9JpYzehChgsUIj2u6uqPYDJB7zV782j1
	 RecSNVoTaDhPf0H+nE3KEStkTYStPtppR/swvppzJ2uzFfQZi7ousHGgrxo4SElonq
	 JWxZynB1J1tkgJsFw+a8Ftck4Izuo/a2BsXqNCUtSQlqJj1QRN5uGqx79WZqW9NqKE
	 /bCXMvn+ElEJj31ot6BotlPjou3zy3dZbozlCHYfvgWy0shS3OU99oNNwN8h4i0W+s
	 x1m7I6nXGhwZJ1idJbHp9Wr9ya/JyaYuB1j2D7dhb+EdscmNmDFsDOniANWq3v7zKa
	 ZYnMPZ+lnnvDw==
Date: Tue, 4 Nov 2025 16:06:12 +0000
From: Will Deacon <will@kernel.org>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Message-ID: <aQokdBkjFqw9ZGRt@willie-the-truck>
References: <20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com>
 <a93e845a-b084-a680-7158-68363c492b75@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a93e845a-b084-a680-7158-68363c492b75@huawei.com>

On Mon, Oct 20, 2025 at 09:23:05PM +0800, Hanjun Guo wrote:
> On 2025/10/17 15:39, Kazuhiro Abe wrote:
> > AGDI has two types of signaling modes: SDEI and interrupt.
> > Currently, the AGDI driver only supports SDEI.
> > Therefore, add support for interrupt signaling mode
> > The interrupt vector is retrieved from the AGDI table, and call panic
> > function when an interrupt occurs.
> > 
> > Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > ---
> > Hanjun, I have addressed all your comments.
> > Please review them.
> > 
> > v3->v4
> >   - Add a comment to the flags member.
> >   - Fix agdi_interrupt_probe.
> >   - Fix agdi_interrupt_remove.
> >   - Add space in struct initializsation.
> >   - Delete curly braces.
> 
> Looks good to me,
> 
> Acked-by: Hanjun Guo <guohanjun@huawei.com>

I wasn't cc'd on the original patch but I couldn't figure out why it
uses IRQF_NO_AUTOEN when requesting the irq given that the first thing
it does is enable it.

Will

