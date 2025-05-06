Return-Path: <linux-acpi+bounces-13502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A991AAAC6CB
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 15:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92C33B29FF
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5C27A932;
	Tue,  6 May 2025 13:43:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9961A76D0;
	Tue,  6 May 2025 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539026; cv=none; b=RSc+R8ytttdtWnvKwMKU30f85xQj7AYk6gHlm7MZhYh4iw3qrlKQLPi7ltvthWBWfIFqMMenulEhm1TBxVOcxsZUNIEBNWRkygmDgyXa0LA4x1inbk73Rbx3QiumWp3Eozdml3ZJiITw0lUabaSVR4mJyft4nr5e6cm9rg2tZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539026; c=relaxed/simple;
	bh=XocqdyJgxexFcKlv+xjrOjUreYGb7sVH8TwH3tHnuTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf9HYirj7QlXaOxkrIJaPPK5JNNdb5QFR4EdAnhi8Cyttgx32DIgoEWKKHrNFPQ6IU7da6RfgelqORPhcGdus0u5LlRPJ+CEh73GK+xiij6B5GjDyMldox/H8QNWWiqFz3dSJvB6Z23j5lDGefxhM3n3H9s1WKL/tzBe7FsXMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 027A71007;
	Tue,  6 May 2025 06:43:34 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B9B3F5A1;
	Tue,  6 May 2025 06:43:41 -0700 (PDT)
Date: Tue, 6 May 2025 14:43:39 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
Message-ID: <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-draco-taped-15f475cd@mheyne-amazon>

On Tue, May 06, 2025 at 01:13:02PM +0000, Heyne, Maximilian wrote:
> Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
> sizeof() calls") corrects the processer entry size but unmasked a longer
> standing bug where the last entry in the structure can get skipped due
> to an off-by-one mistake if the last entry ends exactly at the end of
> the ACPI subtable.
>

Unless the firmware has populated an incorrect value for the header length, I
don't see how this is possible. The table_end should point to the address
immediately following the last byte of the table. None of the headers are only
one byte long, so what am I missing that could explain this apparent
off-by-one issue?.

-- 
Regards,
Sudeep

