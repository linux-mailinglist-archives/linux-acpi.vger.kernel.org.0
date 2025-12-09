Return-Path: <linux-acpi+bounces-19502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F89CAFB89
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93669300AC60
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27AB2D23A8;
	Tue,  9 Dec 2025 11:11:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B762046BA;
	Tue,  9 Dec 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765278704; cv=none; b=bdRZ2qmcQ3hoDL6iT/ebqXCTUy5iJE6ydfPt6bGvsYkhYADPBdFGMIvrMZfp6HTFbx6hFk1kzzo3Xys3UkdhDL38qbbnLB+REO1OPTYnxj69uh1nMxBV3Zf0FGbxEObO6CqnN/Xt3faTl0qMdcUO4bk2VCoYJ6TwIysNlOBD7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765278704; c=relaxed/simple;
	bh=Z/nOVQTJ8VAST9aYHlScqt+p5Qz4dLTAUT/dWtvFh04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNVfV1amY4qoZRcQU2pRMbxXwaWsax93hZrbR5kkDUBVYFCSXDXKDqEcm2u0DgtYd9V/dMXlNaSuxS+hxbHw2c2xW/hbHDgwBjL7oVOAFFx5896LiBg3mRjDFVx1TFsn7uYtvHNbtwzh1U1rRSAV3soOuEGahluvYpyTVnm2xkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 815A41691;
	Tue,  9 Dec 2025 03:11:35 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B36433F762;
	Tue,  9 Dec 2025 03:11:40 -0800 (PST)
Date: Tue, 9 Dec 2025 11:11:37 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
Cc: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lkp@intel.com" <lkp@intel.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	Olivier Dautricourt <Olivier.Dautricourt@sipearl.com>,
	"olivierdautricourt@gmail.com" <olivierdautricourt@gmail.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Thibault Cantori <thibault.cantori@sipearl.com>
Subject: Re: Re: Re: [PATCH v3 1/2] mailbox: pcc: support polling mode when
 there is no platform IRQ
Message-ID: <20251209-singing-organic-jackal-b8f2ec@sudeepholla>
References: <20251203-persimmon-condor-of-essence-9fc43d@sudeepholla>
 <20251204125938.3025022-1-andrea.tomassetti@sipearl.com>
 <20251204-mauve-bear-of-wholeness-e13a4b@sudeepholla>
 <aTf8bzYaOPe9naLN@dc2pvlnosz001.pub.int.sipearl.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTf8bzYaOPe9naLN@dc2pvlnosz001.pub.int.sipearl.com>

On Tue, Dec 09, 2025 at 10:39:53AM +0000, Andrea Tomassetti wrote:
> On 25/12/04 01:14PM, Sudeep Holla wrote:
> > 
> > I wouldn't consider that as real platform especially if it is not std. AEM
> > models that are well maintained. Many Fast models are short lived and never
> > maintained long term, so I don't want to push any feature based on that alone
> > unless you have a real platform with missing or broken interrupt that needs
> > this polling feature.
> > 
> > It is burden for long term maintenance if there is no regular way to test this
> > polling mode feature.
> > 
> Fair, I totally get your point. Thank you very much for your time.
> 

Thanks for understanding. We can always revisit this if this becomes a
requirement on a real platform in the future. I am not against that just FYI.

-- 
Regards,
Sudeep

