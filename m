Return-Path: <linux-acpi+bounces-6586-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 453CD9135D9
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2024 21:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB96F1F23C67
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2024 19:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD03CF74;
	Sat, 22 Jun 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2u5hIK/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BB45014;
	Sat, 22 Jun 2024 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719084545; cv=none; b=HJUQlaBpYv4e0FfS1AWM9jnlt7A/tBCtW1o07lbZvSSnvMEx/GnVwlFVWXcpsZ88IDmV4Pn/Za3dCkowvEH8lzW+ijV9cuv0vmWSWJxDbt9u9i9kI6Z0iEyX+soizIdYPENMXBlBrYixcBB4Pb7It2IzPhyTBBtO3xUTuDjgYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719084545; c=relaxed/simple;
	bh=DjTv+T73AIrqk4MEwe1aSVO/4HNm2PKC104ZkCWZ5PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEAVYBSglmWi0SVVhmregUmPagfyyyh/YdcqOzcESIkCHprHM8eEJzwdQseHtIf7O4ITYv1H3XyQ8uILgZ7sVE/wYN0qqre6P2Eu6EpH/QDe8/MUIw4NAPtEChEduHEytsxudk9tm6tkPLktFXPRbjeChoFE7DQO8NiPr6BWAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2u5hIK/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7066cba4ebbso294816b3a.3;
        Sat, 22 Jun 2024 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719084543; x=1719689343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQbELuDe1M8YclthuBMvwZLhrYr/zB7BIDBvb8NO9Zk=;
        b=J2u5hIK/Sta1TmI59g5JOnT6vdMT7FbF3f7U+hzSuoDta4bp9IUbJzPMJNZgN8BzR3
         kSPU/jAAbACPJYgJ6fqzrBPnkNJNPyW9pCy652hYSK6KTdEtwGUC3Q/k/kY+rPI9a6GP
         HE5AzGT6/KlOjWXkvKV85xjo4ktT73wLZbFyJI3Nsc1PVDCNEJZwaos5atoEEA8n9/6d
         yOTRs4JdBxUtvS+qFbk0TC6u9fVa6QdZamqw/p/buqMCqoXDNf5pGqoF/hUIA+CfMoJe
         dkT4u3qwF0JVJSkMPSkleAuircp3Bo884Uxe/K9NXJiqo6j/rhT1OiausLak33wbT1Fx
         7VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719084543; x=1719689343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQbELuDe1M8YclthuBMvwZLhrYr/zB7BIDBvb8NO9Zk=;
        b=mMD2ns7Jv99SyxT9GK0fkVmGZA182HpX4gA0YalijOq9GLSpe6M7VK2lwpkcNaqKq5
         tKTMPNC92t0AqR0DqOkD3qLNtvNvuSqrhJNE36ttGaaPbQF+hH2bcrWvZaPYreScvoM4
         flf1kGbeRtQ5AVgxkc9kZnSpaScWGz0XVPoIvkaecknEitvrYYVu9VlHoUCpYZxM8Mf2
         4iAOc54crbkyapYps13qnS+upF6TcUUEqpAEe9yUOkw6hOZurIK1VMCL22WQBYUneefh
         Pqe/YqX7NaLTZdV9pNduC+5s2cvE1paKvIN4mCRCvIS+MQAJ2vfmHRDAaxMCti7Cb8Mk
         uExQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHJBcEjQ+MJCyLqQUgoqid20PDny9MKOxFwCBcaQF0/zuFVtDo7xSvDeBrQJ/SweuAK26BNtOeWuOXvELbMT1ESi/5ztZ8xxLm4DCGTDTf5u7gAoHbNuKFI33rhnMQWSD6bPRb4BUsCA==
X-Gm-Message-State: AOJu0YwEPaEyzkJaJGKY+bJJhnttzaXct/BJXw+exNz4QqAQK8KBQOJJ
	vYB4hdLV2Y0I8oYwzXS5/UfV582C6+m0hyFkImZqhk/kseobPp79HmOHxg==
X-Google-Smtp-Source: AGHT+IFDDoVjuhaI8yQebraUmXub4r1NLDjpC70dEVN1YESkE8eowaKqMxBNjB1McCG+t5Ci8DAHrQ==
X-Received: by 2002:aa7:8005:0:b0:705:bf9c:4cdd with SMTP id d2e1a72fcca58-7066e543be2mr1101311b3a.16.1719084543261;
        Sat, 22 Jun 2024 12:29:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d2ec:59a0:2c5f:4460])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512eba04sm3407547b3a.188.2024.06.22.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 12:29:02 -0700 (PDT)
Date: Sat, 22 Jun 2024 12:29:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3] software node: Implement device_get_match_data fwnode
 callback
Message-ID: <Zncl_O-NjMRZYGeA@google.com>
References: <20240427203650.582989-1-sui.jingfeng@linux.dev>
 <ZnXbaubPVAUdDIu0@google.com>
 <7b5305b6-78b0-4add-9e70-271159cfad95@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b5305b6-78b0-4add-9e70-271159cfad95@linux.dev>

On Sun, Jun 23, 2024 at 02:04:00AM +0800, Sui Jingfeng wrote:
> Hi,
> 
> On 6/22/24 03:58, Dmitry Torokhov wrote:
> > Hi Sui,
> > 
> > On Sun, Apr 28, 2024 at 04:36:50AM +0800, Sui Jingfeng wrote:
> > > Because the software node backend of the fwnode API framework lacks an
> > > implementation for the .device_get_match_data function callback. This
> > > makes it difficult to use(and/or test) a few drivers that originates
> > > from DT world on the non-DT platform.
> > > 
> > > Implement the .device_get_match_data fwnode callback, which helps to keep
> > > the three backends of the fwnode API aligned as much as possible. This is
> > > also a fundamental step to make a few drivers OF-independent truely
> > > possible.
> > > 
> > > Device drivers or platform setup codes are expected to provide a software
> > > node string property, named as "compatible". At this moment, the value of
> > > this string property is being used to match against the compatible entries
> > > in the of_device_id table. It can be extended in the future though.
> > 
> > I am sorry, but this is not really correct.
> 
> I fine if the maintainers of fwnode API want to reject this, but got
> rejected is not really equals to "not correct".

Your statement is factually incorrect. As I shown below using SPI bus as
an example, compatible is only used for OF-based matches. Specifying
"compatible" property via SW node does zilch for matching process. There
are drivers like atmel_mxt_ts that check presence of "compatible"
explicitly (I added it to ensure that the touch controller has all
necessary properties on x86 because older Chromebooks were using ACPI
HID names to differentiate between the touchscreen and touchpad and I
wanted something more robust) but this is not a part of the matching
process.

> 
> Software nodes are used to
> > augment missing or incomplete parameters, but are never primary objects
> > in the matching process. Sometimes "compatible" property is used with
> > software nodes, but it does not participate in the matching process. > There are several ways for various buses to match a device and a driver,
> > but none of them operate on software nodes.
> 
> It's not participate in the matching process in the *past*, but what
> we present is something *new*.

I see absolutely nothing in your patch that would affect the matching
process. It is also not a part of a larger series, so there is nothing
"new" here.

> I fine if you adhere to *old* and/or
> *subsystem-dependent* approach, but there really no need to persuade
> other people to follow your "old" idea.
> 
> Consider for example how
> > devices on SPI bus are matched (see
> > drivers/spi/spi.c::spi_match_device()):
> 
> 
> This only make the driver be able to probed in a non-DT way, but
> it doesn't tell how does the *additional device properties* can
> be get. This is the key point.

I think you misunderstand what device_get_match_data() does. It does not
deal with device properties so there's nothing "additional" there.

> 
> 
> > 1. OF/device tree based match. It *requires* the device to have
> > dev->of_node which is coming from a DTB. It does not work on software
> > nodes. In case of match the match data should come from of_device_id
> > entry.
> > 
> > 2. ACPI-based match. The match is done based either on OF-compatible
> > data (which includes "compatible" property) in _DSD (if driver supports
> > OF-based matching), or based on HID/CID data. In the latter case the
> > match data is coming from acpi_device_id entry.
> > 
> > 3. Name-based match, typically used for board-instantiated devices. In
> > this case match is done by comparing device name under which it was
> > instantiated against names listed in the drivers id_table. The match
> > data is coming from spi_device_id entry.
> 
> The statements here sound right, but it's useless. Because the problems
> isn't solved yet, nor does you words point out a practical approach.

I am explaining you how the system works since there appears to be a
severe misconnect. I think you need to state clearly the problem you are
trying to solve, beyond "completeness of the API" argument.

> 
> > Similar matching processes are implemented for i2c and platform buses,
> > as well as others.
> > 
> > Your patch is effectively hijacks the #3 matching process and
> > substitutes the bus-specific match data (from
> > spi_device_id/i2c_device_id/etc) with OF data. This is not expected and
> 
> Please stop *contaminating* other people's patch, if you have better

I am providing a review of your proposal/patch. That is what happens on
LKML and I suggest you get used to this if you want to become a regular
contributor to the Linxu kernel.

> idea you can posting it. My patch open a new door, and there do have
> programmer in requesting(need) this in the past.

Please point at what exactly you are trying to solve here, because it is
still not clear. Start from the beginning. What are you trying to
achieve on a practical level? I.e. "If I do *this* my device does not
work because of *reason* and to fix this I need *that*". It may very
well be that right "that" is something different from what you are
proposing,

> 
> 
> > while we may want this in a long term (so we can eventually remove these
> > bus-specific device ids and only have ACPI/OF ones) I do not think we
> > are ready for this yet. At the very least this needs to be very clearly
> > documented.
> 
> This is your *personal* wants, if you want to remove something,
> just do it. Keep quiet if you are not ready. Exposing your concerns
> doesn't help to solve any problems.

This sounds incredibly rude. Please consider your tone when writing
your responses.

> 
> Or, if you want it to be clear, you can contribute to Documentation/
> gpu/todo.rst. Other peoples help you to become clear there, thanks.
> 
> Please note that we are talking about the completeness of the fwnode
> APIs, what's you say above has nothing to do the device fwnode APIs.
> Hence, is not revelant to my patch, again is out of scope.
> 
> > > 
> > > Fixes: ffb42e64561e ("drm/tiny/repaper: Make driver OF-independent")
> > > Fixes: 5703d6ae9573 ("drm/tiny/st7735r: Make driver OF-independent")
> > 
> > As other people mentioned this patch does not fix the aforementioned
> > commits because they are not broken.
> 
> You still not really understand what other people does, I'm not saying
> it broken. I'm talking about the completeness.

Completeness for the sake of completeness is not an argument. As it
stands your patch will not change these driver's behavior.

> 
> In case of non-OF match (which
> > includes the case where you use software nodes) the match data is coming
> > from matching spi_device_id entry in the driver.
> 
> 
> We don't care about much how it is probed now, rather, after the driver
> probed by a non-OF way, how does the additional devices properties
> can be get?
> 
> 
> Say:
> 
> 1) "device_property_read_u32(dev, "rotation", &rotation);" and
> 2) "!device_property_read_string(dev, "pervasive,thermal-zone",
> &thermal_zone))"
> 
> 
> For those spi/i2c/platform devices, what we argues are that
> those drivers really should just depend on "OF" before we have
> a reliable fwnode API backend to redirect to.

They are working fine without such restriction now, so I see absolutely
no reason imposing this restriction.

> 
> Where the additional device_property_read_xxxx() calls redirect to?
> 
> What if users want to invoke more device_property_read_xxxx() function?

They are being directed to first the primary FW node instance, which may
be either OF, ACPI, or SW node, and then, if property is not present
there, to the secondary FW node, which can be either again.

At no point ->device_get_match_data() callback in involved in this
process.

Thanks.

-- 
Dmitry

