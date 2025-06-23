Return-Path: <linux-acpi+bounces-14502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF38FAE42FF
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 15:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82ED217E5D5
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E162D25178C;
	Mon, 23 Jun 2025 13:21:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC7239E63
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jun 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684868; cv=none; b=at0wWLxwBkoqtr4AEKmOSehr6ABlOW3NAsK+ITyzJxA9fITdAPMc11w8208LEi/bmDcPV5huIlwmqiIxFLL5OwHfAlAmSU8ZOL4uwlkwJeMDyQNwbrEkMxQDzvtOvJBbgfDeYhcp6ToA5HeeEmaBhkjxeEHUZBUc2l8TlUeCThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684868; c=relaxed/simple;
	bh=W+aey21xm7NJLVxB+DorO24UkUWRj60mzg9shLB6nLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imteRIZ8Ex25Y729H3GHeanmW5V/a0ImVxZpBwwEVv3pu8drJ+v4RZ5a9eNGQwwXUEps8eXXm4zmxkQiBVG8eYYX+JW0T3hjJc68wiBJhkSRcktFPdUvRjEhpcJS6+MeBH2cOkvb9jo6zHSM3consc2ULYzqAeCKO5u/9hC2C6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3337113E;
	Mon, 23 Jun 2025 06:20:48 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 930643F58B;
	Mon, 23 Jun 2025 06:21:05 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:21:02 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: James Morse <james.morse@arm.com>
Cc: <linux-acpi@vger.kernel.org>, Rafael Wysocki <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
	<jeremy.linton@arm.com>
Subject: Re: [PATCH 1/4] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
Message-ID: <20250623-optimistic-chicken-of-merriment-fbefe3@sudeepholla>
References: <20250612171336.4858-1-james.morse@arm.com>
 <20250612171336.4858-2-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612171336.4858-2-james.morse@arm.com>

On Thu, Jun 12, 2025 at 05:13:33PM +0000, James Morse wrote:
> The PPTT describes CPUs and caches, as well as processor containers.
> The ACPI table for MPAM describes the set of CPUs that can access an MSC
> with the UID of a processor container.
> 
> Add a helper to find the processor container by its id, then walk
> the possible CPUs to fill a cpumask with the CPUs that have this
> processor container as a parent.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/pptt.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  6 +++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 54676e3d82dd..aaf9b5a26d07 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> +
> +/**
> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
> + *                                       processor containers
> + * @acpi_cpu_id:	The UID of the processor container.
> + * @cpus		The resulting CPU mask.
> + *
> + * Find the specified Processor Container, and fill @cpus with all the cpus
> + * below it.
> + *
> + * Not all 'Processor' entries in the PPTT are either a CPU or a Processor
> + * Container, they may exist purely to describe a Private resource. CPUs
> + * have to be leaves, so a Processor Container is a non-leaf that has the
> + * 'ACPI Processor ID valid' flag set.
> + *
> + * Return: 0 for a complete walk, or an error if the mask is incomplete.
> + */
> +int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
> +{

Just noticed now that it is not used anywhere in the series. Can this be added
along with the user later instead ?

-- 
Regards,
Sudeep

