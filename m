Return-Path: <linux-acpi+bounces-14503-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C112CAE4327
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832FF160C67
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F5D254844;
	Mon, 23 Jun 2025 13:21:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35722522B5
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jun 2025 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684918; cv=none; b=BxS/6UfV/WTB00zdyE/zxTFsBEQB+J/XeOOMEg63ccN6jJlA1gPqayJWorKiedMdQMBbgPi0Z33j41pkq/1LDq+Si8sD1HvqZfCk2QCG/F8pVwuzmXddm5M0g+CUoFHNt2ndlIQhBPpuW6lddwIRTUVlq+JwPXg0bz5cZj5YWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684918; c=relaxed/simple;
	bh=0XRNcluacRYsAi08j/Cuq8xpenx91XTxp/Mp7WBjW/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw1bC45ydjPgS5dcflwpb2RkkkCWzhQvW8CCVoR0OE/lPXmua8XFEF7b7lrfFP1P/7aHMUwAntF7hHQsKp19jZaeLF+kZ2i8kvn13uqnbhWioH/i/Gf2CmuNqDiPzGaKdLgTHwSx17YeDJTHs31QWmubSgSPlr4ON6qpNQ9Witc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=fail smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE203113E;
	Mon, 23 Jun 2025 06:21:37 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 100FC3F58B;
	Mon, 23 Jun 2025 06:21:54 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:21:52 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: James Morse <james.morse@arm.com>
Cc: <linux-acpi@vger.kernel.org>, Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, <jeremy.linton@arm.com>
Subject: Re: [PATCH 3/4] ACPI / PPTT: Find cache level by cache-id
Message-ID: <20250623-archetypal-wildcat-of-youth-b79630@sudeepholla>
References: <20250612171336.4858-1-james.morse@arm.com>
 <20250612171336.4858-4-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612171336.4858-4-james.morse@arm.com>

On Thu, Jun 12, 2025 at 05:13:35PM +0000, James Morse wrote:
> The MPAM table identifies caches by id. The MPAM driver also wants to know
> the cache level to determine if the platform is of the shape that can be
> managed via resctrl. Cacheinfo has this information, but only for CPUs that
> are online.
> 
> Waiting for all CPUs to come online is a problem for platforms where
> CPUs are brought online late by user-space.
> 
> Add a helper that walks every possible cache, until it finds the one
> identified by cache-id, then return the level.
> 
> acpi_count_levels() expects its levels parameter to be initialised to
> zero as it passes it to acpi_find_cache_level() as starting_level.
> The existing callers do this. Document it.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

