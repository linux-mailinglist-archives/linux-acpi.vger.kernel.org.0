Return-Path: <linux-acpi+bounces-1602-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69EA7F108E
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 11:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC0281299
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1871913AD4
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyKoa68Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130C085;
	Mon, 20 Nov 2023 01:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700472680; x=1732008680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=t09/YrhvYMZJUMyfRagj+DCqVSpysPowlqgW54xheG0=;
  b=iyKoa68Y07l5CSqxbwhT4vl1v2pxWSCSOR+UJUAS1ljc7vhBpAOBB3WW
   Fetll+ePye8C90kai9D9Cbs6nicFVTPJr2nrKb8tKECV0Nt6z8xF+CgGv
   RH/o/ylY3uHNr8drMVPJb8uzeE4amESe/AodpaxNXln8CR0flRfWbO7uK
   p2VhoqCdUplp7b2GxlFyYaU2CZgtSWWB4jJvSuMI0ehSlJetfi89QK+m8
   NqnqqbQN3Czq2QguJIQrn1evOG+GN2kqxZmKuOBL4Fj8qt4CPxFf1asuk
   rZGR3dvCzx3VWGlTFPHLnvV4DOxPxNr1Qq+bxd3I/QAPE6hQIYtVO6qFf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13137463"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="13137463"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:31:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856938838"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="856938838"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:31:16 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 4BEE411FBD1;
	Mon, 20 Nov 2023 11:31:14 +0200 (EET)
Date: Mon, 20 Nov 2023 09:31:14 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 3/7] ACPI: Documentation: Document acpi_dev_state_d0()
Message-ID: <ZVsnYjjWAiNPdHPG@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-4-sakari.ailus@linux.intel.com>
 <20231118185049.GH20846@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118185049.GH20846@pendragon.ideasonboard.com>

Hi Laurent,

On Sat, Nov 18, 2023 at 08:50:49PM +0200, Laurent Pinchart wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> On Fri, Nov 17, 2023 at 01:14:29PM +0200, Sakari Ailus wrote:
> > Document that acpi_dev_state_d0() can be used to tell if the device was
> > powered on for probe.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  Documentation/firmware-guide/acpi/non-d0-probe.rst | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > index 7afd16701a02..815bcc8db69f 100644
> > --- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > +++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > @@ -24,6 +24,14 @@ there's a problem with the device, the driver likely probes just fine but the
> >  first user will find out the device doesn't work, instead of a failure at probe
> >  time. This feature should thus be used sparingly.
> >  
> > +ACPI framework
> > +--------------
> > +
> > +Use the Linux ACPI framework function :c:func:`acpi_dev_state_d0()` to tell
> > +whether the device was powered on for probe. :c:func:`acpi_dev_state_d0()`
> > +returns true if the device is powered on, false otherwise. For non-ACPI backed
> > +devices it returns true always.
> > +
> 
> While this is true, I don't want to see drivers having to call
> ACPI-specific functions, the same way you dislike OF-specific functions
> in drivers. Please find a better way to handle this.

The functionality is only available on ACPI and the function does the right
thing on non-ACPI platforms. I don't see an issue here.

Feel free to post DT binding patches on suggested device power state during
probe. :-) I think DT would benefit from this as well: the at24 driver is
widely used and suddenly making probe() not talk to the chip (or even power
it up) at all would probably be seen as a regression.

> 
> >  I²C
> >  ---
> >  
> 

-- 
Regards,

Sakari Ailus

