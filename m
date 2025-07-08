Return-Path: <linux-acpi+bounces-15066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C2EAFCA43
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 14:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D27F56558B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CFF2DAFC4;
	Tue,  8 Jul 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBsfBTuC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190A2206B5;
	Tue,  8 Jul 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977261; cv=none; b=p/JPKkGx4aj0Js51okdcuzLn3vIafrfSovz845ZRmsncZp6Uxbt8Q50BfJtLeRxir2U5ALxHKdCOjbLEUPrAHxNRXEgqIKnST93ksIZohEOp2yThOLeC2HUgXr4oDSJXJ/or8p3qn1qk60eL2rJjhH5HhgqyWNNJa/ji++kuOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977261; c=relaxed/simple;
	bh=vSIFe/QN5UIvDrm7x9u+fC7buwPeO/L9ZXThcYA0c3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHboV0VIyNTOlm4akmclpkzPzkG8Cr4jvO4lrNcfpynVcnoIwdZNMuMGGB1iFVNQdloyj7d1By3/t+PamSXpCaK6Tx6QYDpu42uKvNKUIqXVSUFXhKczamfUUq5biENmW+qXIN3UPfPCpJn2FzJojs1NtIG5UBtRTqeGd4kAmVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBsfBTuC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751977260; x=1783513260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vSIFe/QN5UIvDrm7x9u+fC7buwPeO/L9ZXThcYA0c3k=;
  b=bBsfBTuC/ih7+T1mkz1Psd8+a0Lo1Wb2l8lR2mCwrVCq2pfH2BAd2gmZ
   Z1PGYUolLYKgKBRrilFxU9isxJjPUm5VfRvgjtmfm+F8W2PV53QlaEZAR
   gveSt3rOwklQxeaJKTOAylArn60u2Jv0FmLsEnV14xf8ogBVupZozZz5y
   RPqsBZelmwOAhnYTrdYFpPqtahoEdT1hSDySEF8Jrf87pGnnjqVWMOU39
   6K7LdySGrUADrVghKhOyJRwMRBmjnrfWYdvqjdWIXcQSWMVp3lbTvWJR9
   jArcu+dNARnWwH79SF94kkAY6MhcB6HATTFwUK751ltZD9Mlv24kS88Nu
   w==;
X-CSE-ConnectionGUID: RUekw/AcSE+y8dZ6LLKuhw==
X-CSE-MsgGUID: IHNf5CfQT0KUTjMW5WCpEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54072003"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="54072003"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:20:59 -0700
X-CSE-ConnectionGUID: Lmw6y1e9Q6qQVY/1oalpTA==
X-CSE-MsgGUID: f+rlOOn3Q+eRdENeAMKh3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="186505342"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.230])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:20:55 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 6AB3811F980;
	Tue,  8 Jul 2025 15:20:51 +0300 (EEST)
Date: Tue, 8 Jul 2025 12:20:51 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 05/12] media: ipu-bridge: Use v4l2_fwnode for unknown
 rotations
Message-ID: <aG0NI2V0Tfh2HZ6O@kekkonen.localdomain>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org>
 <aGw_1T_Edm8--gXW@kekkonen.localdomain>
 <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com>
 <aGzjTRSco39mKJcf@kekkonen.localdomain>
 <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>

Hi Ricardo,

On Tue, Jul 08, 2025 at 02:09:28PM +0200, Ricardo Ribalda wrote:
> On Tue, 8 Jul 2025 at 11:22, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Tue, Jul 08, 2025 at 11:16:25AM +0200, Ricardo Ribalda wrote:
> > > Hi Sakari
> > >
> > > Thanks for your review
> > >
> > > On Mon, 7 Jul 2025 at 23:45, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Ricardo,
> > > >
> > > > On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
> > > > > The v4l2_fwnode_device_properties contains information about the
> > > > > rotation. Use it if the ssdb data is inconclusive.
> > > >
> > > > As SSDB and _PLD provide the same information, are they always aligned? Do
> > > > you have any experience on how is this actually in firmware?
> > >
> > > Not really, in ChromeOS we are pretty lucky to control the firmware.
> > >
> > > @HdG Do you have some experience/opinion here?
> > >
> > > >
> > > > _PLD is standardised so it would seem reasonable to stick to that -- if it
> > > > exists. Another approach could be to pick the one that doesn't translate to
> > > > a sane default (0°).
> > >
> > > I'd rather stick to the current prioritization unless there is a
> > > strong argument against it. Otherwise there is a chance that we will
> > > have regressions (outside CrOS)
> >
> > My point was rather there are no such rules currently for rotation: only
> > SSDB was being used by the IPU bridge to obtain the rotation value,
> > similarly only _PLD is consulted when it comes to orientation.
> 
> So something like this:?
> 
> static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
>                                      struct ipu_sensor_ssdb *ssdb,
>                                      struct
> v4l2_fwnode_device_properties *props)
> {
>         if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
>                 return props->rotation;
> 
>         switch (ssdb->degree) {
>         case IPU_SENSOR_ROTATION_NORMAL:
>                 return 0;
>         case IPU_SENSOR_ROTATION_INVERTED:
>                 return 180;
>         }
> 
>         dev_warn(ADEV_DEV(adev),
>                  "Unknown rotation %d. Assume 0 degree rotation\n",
>                  ssdb->degree);

Maybe:

	acpi_handle_warn(acpi_device_handle(adev), ...);

?

>         return 0;
> }

Looks good to me. Maybe something similar for orientation?

-- 
Regards,

Sakari Ailus

