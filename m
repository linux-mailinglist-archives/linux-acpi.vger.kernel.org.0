Return-Path: <linux-acpi+bounces-13636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9618AAF674
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 11:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6620E464E7E
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 09:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE44263F4E;
	Thu,  8 May 2025 09:13:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB72263C69;
	Thu,  8 May 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695586; cv=none; b=dX7x30+iei9c+X3ei3n+exybHKHSUCbdfXgzjOrid/48zLwz75W2NyAcJ5oehRwqSR41Ilqlgcwct0gc35e7MCLuCKHh08n2+3SuWjstuzcnaYqrU0q+Q/yBdl5XdiJbE3L6yfGP5yGqH88GZgy5XoPuJoGdRXO0h/YqsaxkGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695586; c=relaxed/simple;
	bh=gh435jeZEeyBXMCwUX0HuByLGXx9vywK+mE1D7NoKDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EShvgbqawNfDDbwvlaDhLK5ZOdspUhq2xFKNewKbr6ExriNXuJ7FuWUN0HUENPju29OsZ85KW33arR8MX9urOqmhlqli08tSpdBxholusDTndDuz+Zh+QOTnFEe2UPuQ+ZclfWNKq5t5AIBg/4kOOJePXUB1kVSyN63dl5FMwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1FF9106F;
	Thu,  8 May 2025 02:12:52 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D2BF3F673;
	Thu,  8 May 2025 02:13:01 -0700 (PDT)
Date: Thu, 8 May 2025 10:12:58 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: <rafael@kernel.org>, <lenb@kernel.org>, <jmeurin@google.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Maximilian Heyne <mheyne@amazon.de>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PPTT: Fix processor subtable walk
Message-ID: <20250508-abiding-enigmatic-mustang-ab3bd2@sudeepholla>
References: <20250508023025.1301030-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508023025.1301030-1-jeremy.linton@arm.com>

On Wed, May 07, 2025 at 09:30:25PM -0500, Jeremy Linton wrote:
> The original PPTT code had a bug where the processor subtable length
> was not correctly validated when encountering a truncated
> acpi_pptt_processor node.
> 
> Commit 7ab4f0e37a0f4 ("ACPI PPTT: Fix coding mistakes in a couple of
> sizeof() calls") attempted to fix this by validating the size is as
> large as the acpi_pptt_processor node structure. This introduced a
> regression where the last processor node in the PPTT table is ignored
> if it doesn't contain any private resources. That results errors like:
> 
>   ACPI PPTT: PPTT table found, but unable to locate core XX (XX)
>   ACPI: SPE must be homogeneous
> 
> Furthermore, it fail in a common case where the node length isn't
> equal to the acpi_pptt_processor structure size, leaving the original
> bug in a modified form.
> 
> Correct the regression by adjusting the loop termination conditions as
> suggested by the bug reporters. An additional check performed after
> the subtable node type is detected, validates the acpi_pptt_processor
> node is fully contained in the PPTT table. Repeating the check in
> acpi_pptt_leaf_node() is largely redundant as the node is already
> known to be fully contained in the table.
> 
> The case where a final truncated node's parent property is accepted,
> but the node itself is rejected should not be considered a bug.
> 

Thanks for picking this up and describing the issue properly in the commit
message.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

