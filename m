Return-Path: <linux-acpi+bounces-15063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B77AFC6F1
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 11:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8581AA647E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18930221561;
	Tue,  8 Jul 2025 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQKJrstN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0818A6DB;
	Tue,  8 Jul 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966552; cv=none; b=HD7pEqLdNrnJFRAQfwxu8czfBWRqR/iUE+QsSW4jfLXQCO2vXUwx0YU11NS9qtLNwTRdlQuNtg5Ljhn4uIMxnSlMqxaB22v+o3ZRql4YJHmz2WEGo3jFkk4FduG4y2kwEVYVQVQV2FpI/iIhqwj8uGWrNQ4MGULqeL07IoOSoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966552; c=relaxed/simple;
	bh=fNi8CbZrsjp3UKvN9dNkFPX/M5mAjHbTzquxS2QTpn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXx/tSLduDrfNSXCVnecK4ddfqxTGlUcIzYP5Cn1dYCk8nm5fJoVaDvd+E6SIRZn0xATu96Ne6mHSqmjlNjLma0SCogWo3ay21VGy/9TN4kXY6b7BHZWTLdxZi6uvdDcAoAYBeDbfuSmHSzkjJNBdMDYessToGFOEsyGFrz7d8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQKJrstN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751966550; x=1783502550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fNi8CbZrsjp3UKvN9dNkFPX/M5mAjHbTzquxS2QTpn4=;
  b=VQKJrstNfvTXSNJpjuVxs4xGZ2b3HtNuHR7XGHVjnfq5VDK2eR6QpVbl
   /A5ohxPKmMPyMCmkfx8AtZLfUahv/+rR5ndr6bS1zWjuGhy6NaErb3Owg
   dDRV2OMLFYoeI4Ej6Mi9SCZM2E180TkH7lsCuas6uSm5qEhU9ue4UGhY3
   jT7R7u0y+U9jZbzMTiwETIlXaoWwYEz87BsB7Y76ATIAhof0xPOfXRIzc
   ESuKA0tr1cdW1S+N2qfdw28hjSwGt0U7bIATBj9sCQVkp8/gowR3yMZJr
   2toGZOn6RhzaU8l8c8Px0P4Ai1YQqYUDH1lrLlonfXEbfSlBpvPBCfbw3
   Q==;
X-CSE-ConnectionGUID: yGV3DAE+Qmy4O/azHvOqSg==
X-CSE-MsgGUID: d9ivVSDNRk+gEIUOcVH9Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54292759"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="54292759"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 02:22:29 -0700
X-CSE-ConnectionGUID: TkV4LM6ORbi8hyA8Fqmigw==
X-CSE-MsgGUID: Vx4UtHpvT3iz/IQlkz607Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="179117759"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.230])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 02:22:24 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C6BFD120898;
	Tue,  8 Jul 2025 12:22:21 +0300 (EEST)
Date: Tue, 8 Jul 2025 09:22:21 +0000
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
Message-ID: <aGzjTRSco39mKJcf@kekkonen.localdomain>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org>
 <aGw_1T_Edm8--gXW@kekkonen.localdomain>
 <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com>

Hi Ricardo,

On Tue, Jul 08, 2025 at 11:16:25AM +0200, Ricardo Ribalda wrote:
> Hi Sakari
> 
> Thanks for your review
> 
> On Mon, 7 Jul 2025 at 23:45, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
> > > The v4l2_fwnode_device_properties contains information about the
> > > rotation. Use it if the ssdb data is inconclusive.
> >
> > As SSDB and _PLD provide the same information, are they always aligned? Do
> > you have any experience on how is this actually in firmware?
> 
> Not really, in ChromeOS we are pretty lucky to control the firmware.
> 
> @HdG Do you have some experience/opinion here?
> 
> >
> > _PLD is standardised so it would seem reasonable to stick to that -- if it
> > exists. Another approach could be to pick the one that doesn't translate to
> > a sane default (0°).
> 
> I'd rather stick to the current prioritization unless there is a
> strong argument against it. Otherwise there is a chance that we will
> have regressions (outside CrOS)

My point was rather there are no such rules currently for rotation: only
SSDB was being used by the IPU bridge to obtain the rotation value,
similarly only _PLD is consulted when it comes to orientation.

-- 
Regards,

Sakari Ailus

