Return-Path: <linux-acpi+bounces-19425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C0CA3C50
	for <lists+linux-acpi@lfdr.de>; Thu, 04 Dec 2025 14:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 922733080AF7
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Dec 2025 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3631342169;
	Thu,  4 Dec 2025 13:14:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF603396FE;
	Thu,  4 Dec 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854075; cv=none; b=OmGPRBnoEEmeE4jU7zkgz7e94J/+9APydJgnIiXeeK9j652dIEEzOUfIOrjh9ox23NIybFcycF6+P60hqGRbq4gXhIF4SSbwLslIi9wmv4of1s2PdtGHbGqExlYP5xs2077vOd4DghgXIZyjgosi8LuIhMKaZNcUrner1zApBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854075; c=relaxed/simple;
	bh=zBWKn0P2O+rLsRZ/F2EWDzprh9B9QbAOe3NY8MQ01iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcfGse2WvDJSBj4wk1m0Hw7Z/d5JZ7JYjMYD4zmL78tHVtBn5EgrRPL+okHsdIilzvS6lJ4gBDfCbRLipYLCxyMQ5A0+R4EHyNuGWT3KsC55TdJBk4lfsRtoJMX4uLVbweaNaFwe4Z1ANs1jPfns0Rz5rWBjXyiUcDPM/4YToQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FFEA339;
	Thu,  4 Dec 2025 05:14:26 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E4C3F59E;
	Thu,  4 Dec 2025 05:14:31 -0800 (PST)
Date: Thu, 4 Dec 2025 13:14:28 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
Cc: <jassisinghbrar@gmail.com>, <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <olivier.dautricourt@sipearl.com>,
	<olivierdautricourt@gmail.com>, <rafael@kernel.org>,
	<thibault.cantori@sipearl.com>
Subject: Re: Re: [PATCH v3 1/2] mailbox: pcc: support polling mode when there
 is no platform IRQ
Message-ID: <20251204-mauve-bear-of-wholeness-e13a4b@sudeepholla>
References: <20251203-persimmon-condor-of-essence-9fc43d@sudeepholla>
 <20251204125938.3025022-1-andrea.tomassetti@sipearl.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204125938.3025022-1-andrea.tomassetti@sipearl.com>

On Thu, Dec 04, 2025 at 01:59:38PM +0100, Andrea Tomassetti wrote:
> On 25/12/03 10:28AM, Sudeep Holla wrote:
> > On Tue, Dec 02, 2025 at 11:12:14AM +0100, Andrea Tomassetti wrote:
> > > The goal is to allow clients to submit a message in both irq and polling
> > > mode of the pcc mailbox. The ACPI specification does not require a
> > > platform irq for pcc channels. Let's implement the case where it is not
> > > available.
> > >
> > 
> > Just curious if you have a real use case for this polling mode on your
> > platforms or ...
> > 
> > > Tested-by: Thibault Cantori <thibault.cantori@sipearl.com>
> > > Co-developed-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
> > > Signed-off-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
> > > Signed-off-by: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202511120243.soxAFpqQ-lkp@intel.com/
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202511120558.Cln7LF6M-lkp@intel.com/
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202511120729.R3XQNSnx-lkp@intel.com/
> > 
> > You are just trying to fix these warnings. If it is latter, we don't have to
> > add support for polling mode especially if it can't be tested on real
> > platforms.
> >
> In our target product, we're still investigating if PCC-based SCMI communication will
> rely on interrupts or polling. When we started looking into it we realized that polling
> wasn't supported and that's why we decided to work on and send this patch. We thought it
> could have been beneficial to other members of the community and it brings the driver a
> bit closer to the ACPI specifications.
> 
> We're using ARM Fast Models for prototyping and that's how we validated and tested this patch.
> 

I wouldn't consider that as real platform especially if it is not std. AEM
models that are well maintained. Many Fast models are short lived and never
maintained long term, so I don't want to push any feature based on that alone
unless you have a real platform with missing or broken interrupt that needs
this polling feature.

It is burden for long term maintenance if there is no regular way to test this
polling mode feature.

-- 
Regards,
Sudeep

