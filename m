Return-Path: <linux-acpi+bounces-14500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6141AE41A5
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 15:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04C916A36D
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jun 2025 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6478F24DCF8;
	Mon, 23 Jun 2025 13:08:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FDB1F1522
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jun 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684111; cv=none; b=dwCplpZAW+Nb9bLPSnYS375qGkKptQEoTvOs4yUeWfL3upVoig2BQSGAn95odZRWaMOhtWfxUl1hF9E9U8UD/xPBLdj1MHW4Q8c5wrGRjWyePRpnPQE4ay21DG5nhHP3ZUhXI5s45FxmRiCodofAHSas+B7rfAo6CV/Ecn59oUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684111; c=relaxed/simple;
	bh=Iu5KsYnynntJNNojcb2cbIH2ck3zJc9QBlBXk5S1rsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrxzC6nJodkb9iRy1S2k+4rfK0A7KTnJdL+23LwUhXMnwktCcicX7hBN3RnBQLCG8CkYO1VvFn6IxS17tZl76/Q+Mz4An3uKy45M/WG3lz8UbdCSlVkOTtEJCH+f92cydqB732Af34LVUtAepl7le8QykWI5hWbSwp7BcOJn/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 023C0113E;
	Mon, 23 Jun 2025 06:08:11 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 194373F58B;
	Mon, 23 Jun 2025 06:08:27 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:08:25 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: James Morse <james.morse@arm.com>
Cc: <linux-acpi@vger.kernel.org>, Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, <jeremy.linton@arm.com>
Subject: Re: [PATCH 1/4] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
Message-ID: <20250623-incredible-overjoyed-foxhound-baa930@sudeepholla>
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
> @@ -298,6 +298,97 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
>  	return NULL;
>  }
>  
> +/**
> + * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT processor node
> + * @table_hdr:		A reference to the PPTT table.
> + * @parent_node:	A pointer to the processor node in the @table_hdr.
> + * @cpus:		A cpumask to fill with the CPUs below @parent_node.
> + *

Is this cpus mask always cleared before acpi_pptt_get_child_cpus() is called.
Just checking if it makes sense to clear it before we start the loop in this
function or do we have a need to start with a pre-filled cpumask ?

Other than that, LGTM.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

