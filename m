Return-Path: <linux-acpi+bounces-6521-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C72DD90EB2C
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738481F24779
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2013B290;
	Wed, 19 Jun 2024 12:33:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E875817;
	Wed, 19 Jun 2024 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800394; cv=none; b=SFtA0x1+MWJXsxuFMCVCQgEsTKw0H4a6C6B2G4vSyzfIi5jc037pCVPSuZ9Ud/m9n4H0hYfPQ40Jzi0+JQBQ4kwEiDgwynIQWHJOPx5bbcFUwA4vA4TA65iDNjNEsaYDvvzYsoooC7meOq8oJUXMR5Nc8+YQIzZRywkdHQvR85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800394; c=relaxed/simple;
	bh=lrKGpX+o18W4uBnalsCs70J5SIrWWSxlNStGVVkPopQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ9tgcrkfXhPNbmszguNY+zn0XM6F9cqrGNlgtXCtvJCna05iizCxz1Zvy8ModcvUmTlJiGsRJFQnYo472kHa3jjh6n9HgZ+Bh2ruyfAUxCAhnjLhKcMHO/LUuJmQtisBsnBNJwpvh4bVWm2ZsPGqcoUBgGsb1YXVJyyIl6yGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 744FCDA7;
	Wed, 19 Jun 2024 05:33:36 -0700 (PDT)
Received: from bogus (unknown [10.57.89.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAA013F6A8;
	Wed, 19 Jun 2024 05:33:09 -0700 (PDT)
Date: Wed, 19 Jun 2024 13:33:08 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Youwan Wang <youwan@nfschina.com>
Cc: lpieralisi@kernel.org, guohanjun@huawei.com,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org,
	rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] ACPI /amba: Fix meaningless code for
 amba_register_dummy_clk()
Message-ID: <20240619123308.ti54nduhj6cayfvl@bogus>
References: <20240618115845.261297-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618115845.261297-1-youwan@nfschina.com>

On Tue, Jun 18, 2024 at 07:58:45PM +0800, Youwan Wang wrote:
> Defining `amba_dummy_clk` as static is meaningless.
> 
> The amba_register_dummy_clk() function is static and
> is called during initialization. I think 'amba_dummy_clk'
> should be NULL each time when initializing
>

Also I missed to read the commit message, please update it as follows:

"
ACPI / amba: Drop unnecessary check for registered amba_dummy_clk

amba_register_dummy_clk() is called only once from acpi_amba_init()
and acpi_amba_init() itself is called once during the initialisation.
amba_dummy_clk cann't be initialised before this in any other code
path and hence the check for already registered amba_dummy_clk is
not necessary. Drop the same.
"

Also few other things to note:
1. You missed to add my Acked-by which I gave to your v2
2. This is v3 and new reviewers of this patch have absolutely no idea
   what got changed from v1->v2->v3. It is always good to add change log
   across versions
3. I asked you to add ARM64 maintainers as we would request them to pick
   this up via ARM64 tree.
	Catalin Marinas <catalin.marinas@arm.com
	Will Deacon <will@kernel.org>

--
Regards,
Sudeep

