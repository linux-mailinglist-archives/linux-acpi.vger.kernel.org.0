Return-Path: <linux-acpi+bounces-14504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A8AAE4312
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33E3189993A
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D3D25229C;
	Mon, 23 Jun 2025 13:23:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9C253B67
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jun 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684985; cv=none; b=E/Hi/t6cDBZ0+t1+INoTXTSkHGbCBgiGBRNYSkZ41syyNOuXAZYVw+uYF5ATpLirfYMcvFlJWs9G5Qc1PHcO8JmmEGiRz5sDJC9NFK7UvfIfBQ2f/GRX44Tg6cCAsDz40dTLh9I4kb7i73x2qwbfZenVgjXwudZ7AoNjl8gZ7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684985; c=relaxed/simple;
	bh=1v9xqiVxQoxrfhwSTh8Ua2g915xnaw8XgNXFfWF7RK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2y3yUK/iZAKoveUoZizC0g8ATrfwTWqPgf39KiZ95U8FFJeDqcvXD8sZPz7/BPjSbNwYT28pGg6lDomJQSIjDf57+9mOZJHFoz4xpWWsPH6NENti2/BnVSARCLHcawkkg45Uod8Mt8mzdrNt8aX78sv/fFNsyQh2tayI5f9TLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 989A5113E;
	Mon, 23 Jun 2025 06:22:45 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C6183F58B;
	Mon, 23 Jun 2025 06:23:02 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:22:59 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: James Morse <james.morse@arm.com>
Cc: <linux-acpi@vger.kernel.org>, Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, <jeremy.linton@arm.com>,
	Rohit Mathew <Rohit.Mathew@arm.com>
Subject: Re: [PATCH 4/4] ACPI / PPTT: Add a helper to fill a cpumask from a
 cache_id
Message-ID: <20250623-witty-exotic-poodle-3fe0cf@sudeepholla>
References: <20250612171336.4858-1-james.morse@arm.com>
 <20250612171336.4858-5-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612171336.4858-5-james.morse@arm.com>

On Thu, Jun 12, 2025 at 05:13:36PM +0000, James Morse wrote:
> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
> 
> The driver needs to know which CPUs are associated with the cache,
> the CPUs may not all be online, so cacheinfo does not have the
> information.
> 
> Add a helper to pull this information out of the PPTT.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

