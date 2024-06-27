Return-Path: <linux-acpi+bounces-6654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A365F91AD44
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AE91C25F8B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB6199E9D;
	Thu, 27 Jun 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4oN3vk+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413A199E95;
	Thu, 27 Jun 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507350; cv=none; b=NLHPe2oElwS+nLz+S0KRgiOSW+xhzSLVwvki0psej5xh5PfOpyUeqZZRcdGGV2AEPYREugpmlTB0vDQLq6eUbDyNTSZ3pDlCVAyFwetQRbOIPIuVFLWb9xwbBhYJIu3nzMruZeYJB6YuGFNmUcKZImR9ELBn8yRrMourYEW315o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507350; c=relaxed/simple;
	bh=xvkRHSLvleq9JewIgqEgp50FoppkKYPfytn/SZo3dDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcUSV7nia4y7NLJztsxyBzYsBvtUq6N4mNt6EIBj2PbZRuW1lJlcPrffWuR5Q7Bl3dmMS8Y6qvVhQbEn8hSMMUkoR3QqBkD/ppmqpH+VO/CjBd32H//D0brzU8YG0yAPkLc9kzgjMwZpKHWNJbK+y4nhxdcrHcwj25FY/pOqztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4oN3vk+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4a5344ec7so15031025ad.1;
        Thu, 27 Jun 2024 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719507348; x=1720112148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5s1GCZEfuoRlEtDfGX4Z4uRrKQp7qaRojctirsO209Y=;
        b=O4oN3vk+1/hF6OUchKx/NPjpyjGAUEyT6QtEp83ILHylz9yM2Q0xQmp4alihYjUt6u
         awqMQlnRFMiI/mrqbpiuF2Nr9AUlL7IGY+0+bhKKZp/HAlM0XDuJEb6i5sexbZ3AMeiV
         NKauk6i6RK9ktP4JRoHIpmYX+lD738HMvEuvDV0XciIiE/LEx8e+B9vrEQAEMBEFv7qh
         kOmctc0XG3GAzUaIDEQyIc7vFBYgxQB7aXzUcT6OSX83/hdCM1rQGT08eI7Vqp86JRcX
         uwGfbj2SH5BeXIrO55CJnsD0GQk/JEinopWKgndy0OR/VdLDj2GytPmTz5V069QCEmlG
         RAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719507348; x=1720112148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s1GCZEfuoRlEtDfGX4Z4uRrKQp7qaRojctirsO209Y=;
        b=BcjaPXhpedgAZzktSnjWYicRtrHRjWd5TfAN2KBVIyp4jPgkrrrWnywDnOqNHL6MX2
         vdI/FqoyMJPYX1C1WHymtgMI9tk9Eql5CJyXvThy8YWttE55pFob9UkRK+aCfpxid4xD
         9uC6XT4GgnG4DRV02LpITFoLJF3bJV06sShLYCuw3UXYvCUMSSBlyAp6rwbo1z1cu9hp
         jEY6xj+yHjsZBNHSyu7+8my4MnFV52kWCJSeRok2Cazodp0fG9ps8Vx8v3MGSaZUCfRF
         tmAepAKnCXX5F3ex73IpYlwFAtVJ17D3PBGaJhsBDDct40Js9GASojeiwTezmU8cD+1+
         WrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKUqsC7OHutMNTzryFJVibpsV8IHSZYPJx2UfR0tNDX4+HDl4o0bJGAfA5zwbUJz+zp44KRM4qPvAgCRZN4lWOMqXhJzhTmO6wKGdUpgI75lqqTMXnZhRhAz9E4jQo3esZXeOqhMJTOA==
X-Gm-Message-State: AOJu0YyG5nC3ISweb+v+ffwfz5ma9i1+sliVWoLVHfWkbNCOg1PaKcnz
	LB37ZETCSDRxIRiBcMNuRHAcx84D+8p7EOdgn30PT9uaYqdHE4Ozw9BDUg==
X-Google-Smtp-Source: AGHT+IG6BL8fEiaMXCecNTPZwvWd+gBRgHcwpMbKnA2cp6Z6UbQEM8oUa0CJwRE9vNd+622oh685uA==
X-Received: by 2002:a17:902:eccc:b0:1fa:3a30:dc8b with SMTP id d9443c01a7336-1faad004f06mr35978975ad.3.1719507348398;
        Thu, 27 Jun 2024 09:55:48 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c4ea:7ce4:91ae:d360])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac99a30fsm15859035ad.223.2024.06.27.09.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:55:48 -0700 (PDT)
Date: Thu, 27 Jun 2024 09:55:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3] software node: Implement device_get_match_data fwnode
 callback
Message-ID: <Zn2ZkcT5fsUrYUdJ@google.com>
References: <20240427203650.582989-1-sui.jingfeng@linux.dev>
 <ZnXbaubPVAUdDIu0@google.com>
 <7b5305b6-78b0-4add-9e70-271159cfad95@linux.dev>
 <Zncl_O-NjMRZYGeA@google.com>
 <ee4e8724-4a19-4814-9b7e-9eb6eb0ac6a3@linux.dev>
 <ZnfVoQmCE-wJbIYU@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnfVoQmCE-wJbIYU@google.com>

On Sun, Jun 23, 2024 at 12:58:25AM -0700, Dmitry Torokhov wrote:
> On Sun, Jun 23, 2024 at 03:38:23PM +0800, Sui Jingfeng wrote:
> > Hi,
> > 
> > On 6/23/24 03:29, Dmitry Torokhov wrote:
> > > > In case of non-OF match (which
> > > > > includes the case where you use software nodes) the match data is coming
> > > > > from matching spi_device_id entry in the driver.
> > > > 
> > > > We don't care about much how it is probed now, rather, after the driver
> > > > probed by a non-OF way, how does the additional devices properties
> > > > can be get?
> > > > 
> > > > 
> > > > Say:
> > > > 
> > > > 1) "device_property_read_u32(dev, "rotation", &rotation);" and
> > > > 2) "!device_property_read_string(dev, "pervasive,thermal-zone",
> > > > &thermal_zone))"
> > > > 
> > > > 
> > > > For those spi/i2c/platform devices, what we argues are that
> > > > those drivers really should just depend on "OF" before we have
> > > > a reliable fwnode API backend to redirect to.
> > > They are working fine without such restriction now,
> > 
> > 
> > You still *NOT* answer where the additional devices properties[1][2]
> > can be acquire.
> > 
> > [1] device_property_read_u32(dev, "rotation", &rotation)
> > 
> > [2] device_property_read_string(dev, "pervasive,thermal-zone",
> > &thermal_zone))
> > 
> > 
> > > so I see absolutely no reason imposing this restriction.
> > 
> > The reason is rigorous.
> > 
> > You are acclaiming that works by hardcode or by ignoring the flaws
> > is fine, then all driver are working fine by *your* standard.
> > 
> > Your personal standard has nothing to do with this patch.
> > 
> > > > Where the additional device_property_read_xxxx() calls redirect to?
> > > > 
> > > > What if users want to invoke more device_property_read_xxxx() function?
> > > They are being directed to first the primary FW node instance, which may
> > > be either OF, ACPI, or SW node, and then, if property is not present
> > > there, to the secondary FW node, which can be either again.
> > 
> > 
> > What I'm asking is, on the non-OF and no-ACPI cases, where's those
> > device_property_read_xxx() calls can be directed to?
> > 
> > > At no point ->device_get_match_data() callback in involved in this
> > > process.
> > > 
> > 
> > The patch is written for people who need it, not for people who don't.
> > 
> > It will be involved if the device is associated with software node.
> > Its for fwnode API user to get a consistent experience, that is
> > to get a matching data without introduce extra/duplicated match
> > mechanism.
> > 
> > The patch is focus on fixing the undefined behavior, is discussing
> > the correct way to consolidate the fwnode API. Its not going to
> > discuss how does the those *old" and/or how does those non-fwnode
> > systems works.
> > 
> > Its NOT discussing how does the driver itself can be probed, a driver
> > can be probed multiple way and is another question. Being probed and
> > extract matching data can two different thing and is perfectly valid.
> > 
> > Your problem is that you are not fully understand what other people
> > does before you rush into the discussion. You are putting restrictions
> > onto other people, while leaving the problem itself there unsolved.
> > 
> > Its not a place to express your personal value or you personal status,
> > such as, you are "ready" or "not ready" for something. Or persuading
> > somebody should get used to what or teaching people to talks with a
> > whatever tone like a God.
> > 
> > None of those junk words are technical, I can not see constructive
> > ideas.
> 
> Yes, indeed, it appears that further discussion is pointless at this
> point.
> 
> Andy, Heikki, Greg, and others: FWIW this is a NAK from me.

Even though I said I will not discuss this topic, I stumbled across some
of your patches to the DRM subsystem and it looks like what you want is
actually to help push through this set of patches allowing buses (such as
platform) define their own ->get_match_data() callback so that
device_get_match_data() can be used universally:

https://lore.kernel.org/all/20230804161728.394920-2-biju.das.jz@bp.renesas.com/

Thanks.

-- 
Dmitry

