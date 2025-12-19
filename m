Return-Path: <linux-acpi+bounces-19719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83697CD0809
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 16:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECAF4301A6DA
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDBA346AD4;
	Fri, 19 Dec 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gej9VTqK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8FF340D93;
	Fri, 19 Dec 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158242; cv=none; b=HLhfrp3FDbhPEIReHQfBHjPVuQj611LuK3RGthgyLFdtJS/XXCgFzRF4akocN3VcLnhCU060TTiFDXvaN0PU9EAQ3CsCz5UatDW/RBZQPTXaS1res/X9z7pRmGH+983PWbOcn/YGGgTBe2Aplv8skXuaduZuhYrivaua/0Cllvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158242; c=relaxed/simple;
	bh=jt4o90nFqHZWWhidO6jTOb7JTdQc/098/qNRW8giZpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksZlEuvCRb4MQoFwvI3uFpUesdVWnTY1ehmXEqO5JxQFde/6jhS7yKGKSHBJzAdjqa7V5xH5SLQYVEmF4CFOB7UaKPnuqkVhlvn2M7uZPBOd7qbOGdQtlt4bOeD4Ns36izsGq3QfkboD0oiZKk9UvLl3khZFYcBCA81Z4DmCGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gej9VTqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA550C4CEF1;
	Fri, 19 Dec 2025 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158242;
	bh=jt4o90nFqHZWWhidO6jTOb7JTdQc/098/qNRW8giZpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gej9VTqKwoEXwiCEGCqUZY6iQ4PNWwaeW79Gzxr5r9nFMikliZ5LXqTsWFPG3bCIv
	 2oXHGCkF+YspSK7e0mHuWvyOzSgmsB63m9QrAWizqGO9KL9ZhHd7RSviFSmn9bVMyi
	 p8wQfqICFrz3bcbbYsNqcw8/xzOICei13f3EYzA0fZ6riCEiSMYVC61h75Bon+6CYK
	 YbwxTq3akrcn01sWbH9+dPumAodrbAXX7BdcN/AdbjQIQI72GhF+0fHBtMZ2cScLRs
	 sYbrrDtdgow1zlq0cKZJGdi35OcLVfbY+UsiobuaAOXvPt0LyiiebZ03JfzC/SsQYq
	 QcRi1CSAJpwfQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vWcRE-00000006Q1i-0mcd;
	Fri, 19 Dec 2025 16:30:40 +0100
Date: Fri, 19 Dec 2025 16:30:40 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, tony.luck@intel.com, bp@alien8.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, linux-arm-kernel@lists.infradead.org, rafael@kernel.org, 
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com, Michael.Zhao2@arm.com
Subject: Re: [PATCH 03/12] ras: add estatus vendor handling and processing
Message-ID: <euhams5heiuaawxq4e5ty7iijuvwt5gvdx3flsm4npligjeulq@lv3cwekyb2o2>
References: <20251218170453.23be9049@foz.lan>
 <20251219144943.2798169-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219144943.2798169-1-ahmed.tiba@arm.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Fri, Dec 19, 2025 at 02:49:02PM +0000, Ahmed Tiba wrote:
> 
> On Wed, Dec 18, 2025 at 05:04:53PM +0100, Mauro Carvalho Chehab wrote:
> 
> >> Teach the estatus core how to walk CPER records and expose the vendor
> >> record notification path. This adds the section iteration helpers,
> >> the logging helpers that mirror the GHES behaviour, and the deferred
> >> work used to hand vendor GUIDs to interested drivers. No users switch
> >> over yet; this simply moves the common logic out of GHES so the next
> >> patches can wire it up.
> >>
> >> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> >
> >...
> >
> >> +static bool estatus_handle_arm_hw_error(estatus_generic_data *gdata, int sev, bool sync)
> >
> > Huh?
> >
> > This is a CPER record from GHES. Why are you moving CPER code out
> > of ghes.c, placing in a file named estatus.c? Doesn't make much
> > sense on my eyes...
> >
> > Same applies to to other GHES CPER record types.
> 
> GHES still fills in the CPER record, but the parsing and logging logic is
> shared with the new DeviceTree provider so I pulled those helpers into the
> estatus core. 

I see, but this is not really estatus core. Instead, it is part of GHES CPER
handling logic, which is defined at ACPI and UEFI specs. moving it to estatus
sounds odd, at least on my eyes.

Perhaps I'm failing to see where at ACPI/UEFI specs how CPER would be
integrated with an OpenFirmware approach to handle CPER without GHES.
Care to point to the relevant specs, if any?

> Both providers already call into the same notifier chain and
> memory-pool helpers; this patch just moves the generic CPER walking routines
> next to the rest of the common code so the DT path doesn’t have to grow its
> own copy. If you’d prefer a different file layout or naming to make that
> intent clearer, I’m happy to adjust.

Moving the code from ghes.c to estatus.c or to elsewhere shouldn't make any
difference, as the DT handling logic could simply be calling the functions
from ghes.c (or estatus.c). I fail to see why they need to be moved.

-- 
Thanks,
Mauro

