Return-Path: <linux-acpi+bounces-10089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7309EC77C
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1978516A56D
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8D1DC98C;
	Wed, 11 Dec 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB4L+/l2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA911C5CD7;
	Wed, 11 Dec 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906443; cv=none; b=drzv9vTVX0W2iBwKDi4NDDdNvMopBDMGUcVIRw8OgxZZRPJ0E0ixwxgAdReoCoNRjHiYz8Oi9g5iMVV6+zQZFP/p5IWLXHumBO2g2hWAbdY9bQOZ2K0KSmtsG/P5Ud3bchxi+Qy44OgeZI+l2yLQkFhZoFmoy6V0sVwQ68xtMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906443; c=relaxed/simple;
	bh=04AqKpIJCfX17gb5Qy8K9EzFf1JmdE4mp04DNnMHcdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jpi2ssNgfbNd7pNcyFLPCbtON6zTgEUMBdGdFBrPObCm3+wQ96ThIDhmfik0ks/C2QAYyEbwxIRQTR65k1myQmc7ApLOX7R/M7Cpp8yckResJDsfBt0wUyeeEqOe3XPBHGbYjC0NaumVTPcgMXJ/z8xZ5XFnMXVRzgL78vqru5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB4L+/l2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E60C4CED2;
	Wed, 11 Dec 2024 08:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733906442;
	bh=04AqKpIJCfX17gb5Qy8K9EzFf1JmdE4mp04DNnMHcdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QB4L+/l2nfq8ldkIX2s6HVSTpkyM1bdg73mdxRzOmKe8vGyusGgtoFBihphP/o/jA
	 qYxyk1cqikGOxZ15Xzmj6Ik/i1ngjCwcS/gvwOgW0s0o8vgd+GGqhOswo4vf2vzdV6
	 cwDNLDvCIMR1l9NgVYLuAk0gtRX1nBS7WUQoJmZuYZZMrtMouViBAsUqIiCqQ4eQdn
	 bQJ14rCel0gJRsmz2DFBilzzyZ8VK0q/8Km5yUc4euM8Bc56FLjJDtslbdXhNYu4yK
	 qyXegGCgsun2XErmxjmz4FIheZ2GYieq6EXYD3BW48brAjZ3gC+NNS+6FhQQsqhtsK
	 ftoX8yQE+DZ9g==
Date: Wed, 11 Dec 2024 09:40:37 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
Message-ID: <20241211094037.26aa369a@foz.lan>
In-Reply-To: <Z1lF0ij99KpbVKQs@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org>
	<Z1isHpuHqHSX-jHd@kekkonen.localdomain>
	<CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
	<Z1lF0ij99KpbVKQs@kekkonen.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 11 Dec 2024 07:57:06 +0000
Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:

> Hi Ricardo,
> 
> On Tue, Dec 10, 2024 at 11:35:35PM +0100, Ricardo Ribalda wrote:
> > On Tue, 10 Dec 2024 at 22:01, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:  
> > >
> > > Hi Ricardo,
> > >
> > > On Tue, Dec 10, 2024 at 07:56:03PM +0000, Ricardo Ribalda wrote:  
> > > > Provide an implementation of acpi_device_hid that can be used when
> > > > CONFIG_ACPI is not set.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  include/acpi/acpi_bus.h | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > > index 4f1b3a6f107b..c25914a152ee 100644
> > > > --- a/include/acpi/acpi_bus.h
> > > > +++ b/include/acpi/acpi_bus.h
> > > > @@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> > > >
> > > >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> > > >
> > > > +static inline const char *acpi_device_hid(struct acpi_device *device)
> > > > +{
> > > > +     return "";
> > > > +}  
> > >
> > > I wonder if any caller might expect something of a string if provided?
> > > Valid _HIDs are either 7 or 8 characters whereas the proper version of the
> > > function returns "device" when one cannot be found (dummy_hid in
> > > drivers/acpi/scan.c). Unlikely to be a problem perhaps.  
> > 
> > Good point. I changed it to return "device"  
> 
> When ACPI is disabled, it's unlikely that string would be used anyway, vs.
> the case when ACPI is enabled but there's no _HID. So I think an empty
> string should be fine. I wonder what others think.
> 
Returning "" also caused me some attention at the original patch. IMO,
placing a pseudo-valid HID would be better, but I guess "device" is also
invalid, as, at least I always saw HIDs in uppercase. Also, I guess it
is always a vendor ID + a 4 digit number.

so, IMHO, something like "DEVC9999" would be a better name if we fill it.

Thanks,
Mauro

