Return-Path: <linux-acpi+bounces-15071-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6747AFDBF2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jul 2025 01:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4A83B3A1A
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 23:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1122FE02;
	Tue,  8 Jul 2025 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePNnI1Rk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9818E3F;
	Tue,  8 Jul 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018410; cv=none; b=imX2ALCHwkJNxbmopHhOmcc0UO6knc+B6wSla3znsV3/xkLgG4qAAfavoAQmfcQrFNhLcc1YJOcnXbKKSGYi6hTVneJU2ME+U5W2DQsGHPIHJGBsipzhwocyaBJTpiaZ0jbAZEP7OkLRs+8OyS+BWGax8ViGp1liy9hUsqWKHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018410; c=relaxed/simple;
	bh=MlpSgduVRBJdk395iMJ6yLimjvXQpIqGCCEMgZlsg6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YirD9FG8efdxxGgfRop/ua55RsH0NLfUeRiERaiB4zn4GOQRC0ZSoW0RSTZOJD/ClrBorbpM1Hy1lVNfodRGjeQHKNnR9Xty1tXU+hvsXI2nxxzJd4T9r76Ql2GOw8WoNmjzIF8ycMeAj5jWJ2ONRPUaOmyw4Bgg01meFrfP5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePNnI1Rk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752018408; x=1783554408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MlpSgduVRBJdk395iMJ6yLimjvXQpIqGCCEMgZlsg6M=;
  b=ePNnI1Rklo/1c2CII06FDMTNPFxv5YffmQbqisch/9WWMn35i+LhjeB0
   JaxFqVmki9COX8GuMa5qaIta9S3tGP18/v4L6PcdfIHXwS2yqhA+28BP1
   F2T84YjhWXKsh+ydKTWNK5VF0aUiBGosWL/H6liiHAoZhCb9mm6c5yZCE
   yNnRyexqtIqGVX91SlABMJbPGLXyUDjLifoRaO88jHw3xafxH8fLk5N5O
   81iFyste7mneSFlAgw1FdZkkR6908EV7sWpB7xu5c1G6kPWckSDY/QPwX
   LcjU9Zicw1R4GWSFkWG4IIGM4sEYUW3kCNV+VWSwUgFolloVkpn9OGATB
   A==;
X-CSE-ConnectionGUID: 28bilIjgSmSguQIamSAKww==
X-CSE-MsgGUID: yNVnkYAaSVqHo/4g1PqZUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54412895"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54412895"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:46:47 -0700
X-CSE-ConnectionGUID: q7oi4U30RgSdrHZGPh6ycA==
X-CSE-MsgGUID: 7IJhBtTFS2G52EautX/oBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="179305651"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:46:43 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 5D9BD11F8A6;
	Wed,  9 Jul 2025 02:46:41 +0300 (EEST)
Date: Tue, 8 Jul 2025 23:46:41 +0000
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
Message-ID: <aG2t4cxwXKJ9MSQX@kekkonen.localdomain>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org>
 <aGw_1T_Edm8--gXW@kekkonen.localdomain>
 <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com>
 <aGzjTRSco39mKJcf@kekkonen.localdomain>
 <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>
 <aG0NI2V0Tfh2HZ6O@kekkonen.localdomain>
 <CANiDSCu=wU_Oi7CLPcYTC3Xf_pGbDroaVitPAiAj7ND5pXy-6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiDSCu=wU_Oi7CLPcYTC3Xf_pGbDroaVitPAiAj7ND5pXy-6g@mail.gmail.com>

On Tue, Jul 08, 2025 at 04:58:25PM +0200, Ricardo Ribalda wrote:
> On Tue, 8 Jul 2025 at 14:21, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Tue, Jul 08, 2025 at 02:09:28PM +0200, Ricardo Ribalda wrote:
> > > On Tue, 8 Jul 2025 at 11:22, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Ricardo,
> > > >
> > > > On Tue, Jul 08, 2025 at 11:16:25AM +0200, Ricardo Ribalda wrote:
> > > > > Hi Sakari
> > > > >
> > > > > Thanks for your review
> > > > >
> > > > > On Mon, 7 Jul 2025 at 23:45, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > > > > >
> > > > > > Hi Ricardo,
> > > > > >
> > > > > > On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
> > > > > > > The v4l2_fwnode_device_properties contains information about the
> > > > > > > rotation. Use it if the ssdb data is inconclusive.
> > > > > >
> > > > > > As SSDB and _PLD provide the same information, are they always aligned? Do
> > > > > > you have any experience on how is this actually in firmware?
> > > > >
> > > > > Not really, in ChromeOS we are pretty lucky to control the firmware.
> > > > >
> > > > > @HdG Do you have some experience/opinion here?
> > > > >
> > > > > >
> > > > > > _PLD is standardised so it would seem reasonable to stick to that -- if it
> > > > > > exists. Another approach could be to pick the one that doesn't translate to
> > > > > > a sane default (0°).
> > > > >
> > > > > I'd rather stick to the current prioritization unless there is a
> > > > > strong argument against it. Otherwise there is a chance that we will
> > > > > have regressions (outside CrOS)
> > > >
> > > > My point was rather there are no such rules currently for rotation: only
> > > > SSDB was being used by the IPU bridge to obtain the rotation value,
> > > > similarly only _PLD is consulted when it comes to orientation.
> > >
> > > So something like this:?
> > >
> > > static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
> > >                                      struct ipu_sensor_ssdb *ssdb,
> > >                                      struct
> > > v4l2_fwnode_device_properties *props)
> > > {
> > >         if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
> > >                 return props->rotation;
> > >
> > >         switch (ssdb->degree) {
> > >         case IPU_SENSOR_ROTATION_NORMAL:
> > >                 return 0;
> > >         case IPU_SENSOR_ROTATION_INVERTED:
> > >                 return 180;
> > >         }
> > >
> > >         dev_warn(ADEV_DEV(adev),
> > >                  "Unknown rotation %d. Assume 0 degree rotation\n",
> > >                  ssdb->degree);
> >
> > Maybe:
> >
> >         acpi_handle_warn(acpi_device_handle(adev), ...);
> >
> > ?
> >
> > >         return 0;
> > > }
> >
> > Looks good to me. Maybe something similar for orientation?
> 
> Do you mean using ssdb also for orientation or using acpi_handle_warn?
> 
> 
> I cannot find anything related to orientation for SSDB
> https://github.com/coreboot/coreboot/blob/main/src/drivers/intel/mipi_camera/chip.h#L150
> 
> Am I looking in the right place?

Ah, maybe SSDB has only rotation? At least it's less duplicated information
in different format, so that's a good thing. So this just applies to
rotation, it seems.

-- 
Sakari Ailus

