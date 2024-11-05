Return-Path: <linux-acpi+bounces-9323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3076F9BD319
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA213283C4E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0D1DE2C2;
	Tue,  5 Nov 2024 17:11:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91BE1DD88D;
	Tue,  5 Nov 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826694; cv=none; b=luHolNTsGXlKlAazpW6Z4JMucuu0ModBbFESp+ui6BXUoq97ik6gLlE1hxSop+jKGB6WaYENczThqgArX9huHNCP/pJR90DwWVMehnyZdokDgbJoGN6nCoAj+NjBPeu6Ib0/x0nHpwogLlEDL36fagR8yLYnjsasslOEJuocPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826694; c=relaxed/simple;
	bh=k+13sDOUemdCoEV6fkj1PUKssHgSxnKjxUfr4Ze/nP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH41HDx8aCdSLBKFSoTndvFsXp8M6p3hY8neT0MlqJROo8Dz6xd51FW5kGWqAV7+UShIoufYsFHlmrvUabsytGLrf2tsGmETPZ0RobYqQClxZolBqCFQbykhgCCyTriTA448ejlP2qBvuGfKTD7Fi5yr4iHoK1WQzP9/86O7an0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 082ECFEC;
	Tue,  5 Nov 2024 09:12:02 -0800 (PST)
Received: from bogus (unknown [10.57.55.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 209EE3F6A8;
	Tue,  5 Nov 2024 09:11:26 -0800 (PST)
Date: Tue, 5 Nov 2024 17:11:13 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: George Rurikov <grurikov@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ACPICA: Fix dereference in
 acpi_ev_address_space_dispatch()
Message-ID: <20241105171113.vifd2x2suoebpt3r@bogus>
References: <20241031173146.1459-1-grurikov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031173146.1459-1-grurikov@gmail.com>

On Thu, Oct 31, 2024 at 05:31:46PM +0000, George Rurikov wrote:
> * # Be careful, this email looks suspicious; * WARNING!  This email has multiple suspicious indicators that suggest it is malicious, please handle links and attachments with extreme care. *
> When support for  PCC Opregion was added, validation of field_obj
> was missed.
> Based on the acpi_ev_address_space_dispatch function description,
> field_obj can be NULL, and also when acpi_ev_address_space_dispatch
> is called in the acpi_ex_region_read() NULL is passed as field_obj.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>

LGTM, please submit this to ACPICA project as specified in the documentation
if not already done. Otherwise a reference to the merge request there would
be good here.

--
Regards,
Sudeep

