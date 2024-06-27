Return-Path: <linux-acpi+bounces-6655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F4C91ADCB
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 19:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7653281613
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928519A287;
	Thu, 27 Jun 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IvVj8Ffg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45531C6A1;
	Thu, 27 Jun 2024 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508643; cv=none; b=qlDdN6J3vO4XG4XrIRHTvXk3pusswMKMlD98l1EKBBGlZKbwVGuok/CBGltfomnelGFBDD1VhnaavHmTUh7I9pNg/XZrb1Rxklu9SyCUts/qfZgDubPxj0zy/dxADfOV0azcFtgs137ZZUFVEgVk4PWAfdkB2DO8pKlHDmImkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508643; c=relaxed/simple;
	bh=9Q/pog2xSjMT0jgQZHRrF+D+sHNG81NCOjNxL27WFJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRkn0jufMnw7v4PVeXkQQK7ZNCtega/yuuz+0+xOiGn1zAS4ZL55cpzR9Nzo61DjbmaonOBVV5e6mOr8iXYeziLdqafAwr0Hn3pu6JMpx9UepHdO8RgMhu/NG6wXNCyuo1ikiqyHeza2cr0KsCcrBrB6y1EaGZBzgtS1bRsodD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IvVj8Ffg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719508630;
	bh=9Q/pog2xSjMT0jgQZHRrF+D+sHNG81NCOjNxL27WFJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvVj8FfgV+AOBT4EHIbLCR45qpXIbsvhzgRmpgevM30AlPXtYecaeA/kljCusl6pG
	 WfnLcm1VeC6mBzVB4m6BD+D54X56OS+eEAA4sZSyqLKoQbyIs9eQqhSEKQhrP7ot3t
	 NmhebQnYPjHu8Wj/cE9fy5ZzWQ0kEFYXext++txc=
Date: Thu, 27 Jun 2024 19:17:09 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH 2/5] ACPI: sysfs: use device lifecycle for _STR result
Message-ID: <4cd2352c-4e95-4ddf-a366-75dad45bf7e6@t-8ch.de>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
 <20240613-acpi-sysfs-groups-v1-2-665e0deb052a@weissschuh.net>
 <a72495c3-c996-4be7-bc64-ba10d5400971@sirena.org.uk>
 <111f7a2c-403b-40b3-9e25-8c4a040d8dfb@t-8ch.de>
 <d599e864-9961-44e3-8b9b-bc41a8044319@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d599e864-9961-44e3-8b9b-bc41a8044319@sirena.org.uk>

Rafael:

Would you mind backing this series out for now?
I'll do some more experiments and resubmit.

On 2024-06-26 16:39:10+0000, Mark Brown wrote:
> On Tue, Jun 25, 2024 at 11:56:18PM +0200, Thomas Weißschuh wrote:
> > On 2024-06-25 21:57:13+0000, Mark Brown wrote:
> 
> > > <2>[   50.236703] acpi LNXTHERM:08: Resources present before probing
> 
> > This does make sense, the device is not yet bound to a driver.
> > Which apparently precludes the usage of devres.
> 
> Oh, yes - I really wouldn't expect that to work at all, devres is all
> about tying things to the device being bound so trying to use it outside
> of that is not something I'd expect to go well.
> 
> > I'm also wondering why the _STR attribute behaved differently in the
> > first place.
> > Does the patch below work better?
> 
> That patch applied on top of -next appears to resolve the issue.

Thanks for the confirmation

