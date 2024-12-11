Return-Path: <linux-acpi+bounces-10093-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAAA9EC7F2
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02D82898D5
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AE1F236A;
	Wed, 11 Dec 2024 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4x8tEW6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9711F2360;
	Wed, 11 Dec 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907438; cv=none; b=aMid4V/qR9ttoJwK15xr5Tsblj30QYwFwkRXpGjaSpA5w3wlCy+h8Dx0FKCNpEK5/WLTi1+MiWUSKBprOmBtliEAWRKQ214oNwNUkPAnplL8mRP5tWtkhjhcv/nMWnTV6N1d8M5xD2o3Ei4K4aQd7rViKEcwWpy4NF1x57nuPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907438; c=relaxed/simple;
	bh=le+Mh1wjBLqBi2bTTLZH6gClWn3WW5fXnLXugLgMUN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bv4A/wkZP4tNMhHMMOq0GadJFFSiyZ++cRsC3UVfg1lwG9zVm7o4M8s3xMp3Lj0iKfcujx7av9KeWwMJmjsrm2AyRreXzsBlJ8ltXnaXL7IGNkV/AISVgO6u1kZCsQuz5WZ7Cp4vb5QeXQODXj971Lt3Hm44to33A3rA0XDczfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4x8tEW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC81C4CED2;
	Wed, 11 Dec 2024 08:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733907437;
	bh=le+Mh1wjBLqBi2bTTLZH6gClWn3WW5fXnLXugLgMUN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G4x8tEW6qh3o72XqlueHI99hHI5sdgY7JzBvC/ssQPnsr241HDBap/SW6bpTjx29d
	 1OyEje2fmgLrmgDzruHlDK2OHbxeIngPoRdhxiyB7KBMVaW7Kf0GvYwMZLkF2uHOBI
	 Y20t+42nJ/OR/sZzpFGNg2TIyKZ//bMFf/elyM8fYnm+rqK9rCtn48zOa6w0e51SnQ
	 kRCAyg4M0AT55he3dau35ARu/sHsK5r65wiqSwU6yrxE51k3uAChFn4osqSab8XTSQ
	 Q1MlUhtD0890xIk4ZrVHrI0MsihvikSh/Uv39l1WF1ly7AVy53dx9aqmGDycfYWvnY
	 gM7y5fcXPIEhw==
Date: Wed, 11 Dec 2024 09:57:11 +0100
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
Message-ID: <20241211095711.19909f0b@foz.lan>
In-Reply-To: <Z1lR869cuIw_p2-l@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org>
	<Z1isHpuHqHSX-jHd@kekkonen.localdomain>
	<CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
	<Z1lF0ij99KpbVKQs@kekkonen.localdomain>
	<20241211094037.26aa369a@foz.lan>
	<Z1lR869cuIw_p2-l@kekkonen.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 11 Dec 2024 08:48:51 +0000
Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:

> Hi Mauro,
> 
> On Wed, Dec 11, 2024 at 09:40:37AM +0100, Mauro Carvalho Chehab wrote:
> > Em Wed, 11 Dec 2024 07:57:06 +0000
> > Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:
> >   
> > > Hi Ricardo,
> > > 
> > > On Tue, Dec 10, 2024 at 11:35:35PM +0100, Ricardo Ribalda wrote:  
> > > > On Tue, 10 Dec 2024 at 22:01, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:    
> > > > >
> > > > > Hi Ricardo,
> > > > >
> > > > > On Tue, Dec 10, 2024 at 07:56:03PM +0000, Ricardo Ribalda wrote:    
> > > > > > Provide an implementation of acpi_device_hid that can be used when
> > > > > > CONFIG_ACPI is not set.
> > > > > >
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > >  include/acpi/acpi_bus.h | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > >
> > > > > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > > > > index 4f1b3a6f107b..c25914a152ee 100644
> > > > > > --- a/include/acpi/acpi_bus.h
> > > > > > +++ b/include/acpi/acpi_bus.h
> > > > > > @@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> > > > > >
> > > > > >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> > > > > >
> > > > > > +static inline const char *acpi_device_hid(struct acpi_device *device)
> > > > > > +{
> > > > > > +     return "";
> > > > > > +}    
> > > > >
> > > > > I wonder if any caller might expect something of a string if provided?
> > > > > Valid _HIDs are either 7 or 8 characters whereas the proper version of the
> > > > > function returns "device" when one cannot be found (dummy_hid in
> > > > > drivers/acpi/scan.c). Unlikely to be a problem perhaps.    
> > > > 
> > > > Good point. I changed it to return "device"    
> > > 
> > > When ACPI is disabled, it's unlikely that string would be used anyway, vs.
> > > the case when ACPI is enabled but there's no _HID. So I think an empty
> > > string should be fine. I wonder what others think.
> > >   
> > Returning "" also caused me some attention at the original patch. IMO,
> > placing a pseudo-valid HID would be better, but I guess "device" is also
> > invalid, as, at least I always saw HIDs in uppercase. Also, I guess it
> > is always a vendor ID + a 4 digit number.
> > 
> > so, IMHO, something like "DEVC9999" would be a better name if we fill it.  
> 
> How about post a patch changing "device" in drivers/acpi/scan.c? :-)

Yeah, keeping it coherent makes sense, but see:

	static const char *dummy_hid = "device";

This is compiled for production kernels, and not just for COMPILE_TEST,
while:

	static inline const char *acpi_device_hid(struct acpi_device *device)
	{
		return "foo";
	}

is only COMPILE_TEST. They don't need to be aligned.

> But I
> think the string also needs to be an invalid as a _HID object so it's not
> masking an actual hardware ID used by a real device.

It doesn't matter if if ever conflicts to a real device, as this is
for COMPILE_TEST only.

Anyway, from my side, I'm just giving my 2 cents. I'm ok either way: 
"", "device", "DEVC999", ...

Thanks,
Mauro

