Return-Path: <linux-acpi+bounces-6589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCFF9138D8
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Jun 2024 09:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D89281452
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Jun 2024 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0DE288A4;
	Sun, 23 Jun 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guPUoAxY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E4E1758E;
	Sun, 23 Jun 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719129510; cv=none; b=H/qW9QWiz6ZMvN0+yu6b49YQb7FzWs/mxMoR9Zs5b19SLUVjSTtQVsAS2rTH9hpH/npJo08C/w4GnY/YVi+vB8gTjrCx6uoSrBi6D8ryDCoRAyztZ91NcT9JQJXd1rdZTxdRfo8L8yAJ2JF3lCPSZaRNvEn9YRKYH9BncGe+fRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719129510; c=relaxed/simple;
	bh=a6KNXhusZlGB9SXt+4RuMY0cEgs/mQtHIhf1RjFFZ2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5TCvHB4G07xuL9M3VVohTghkHt7nxRcXUdHKwnV8CvG8gdy9VRcREG0m9bQ/W0uchh+Oa8CGaJ3bYl4xoYvfZcyKIA9OcP6KCrjIBB1fGYEsK0fGWEqfN7n1G0rpySBNDteNIzBeA4wpI6rpXSnz6+V5qEjZS7jK4ecJy8ZvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guPUoAxY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f480624d10so28199545ad.1;
        Sun, 23 Jun 2024 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719129509; x=1719734309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzKNaXqjYLYXB0OpmzE6jKXefCOFO+eG6hhbZpLsjY8=;
        b=guPUoAxY9aruD0i3m2Zw66a3QmLnq74NqGuBWZoogt84aiF1FXfKKauWVDwBvxLaCg
         cacXtdTEb51WjkJURBSsehMzJtWMquBbsU8ws3j2/X7LYJJw8UK8Uv8vb7DBB+26vtqh
         Wwj2CglBYYIMxG1ywYt1KfcqzNXJuQ0iGJ8pxO3P02Wpk9/7UTjLGPXQ5k9kGfkFMaSP
         zu6Iz07v1XtWlctqBhK7ukSzT4Jsc5Pw5xlYbjRWs7mfyBLyB7gSZyvKQ4s71CphfHmG
         NcZWcL4H5Q2MUXfwOrfvdO0zA8oEqxtDia68eQGK595uXxENuGF+VydA4dX41UWSx7vL
         dhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719129509; x=1719734309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzKNaXqjYLYXB0OpmzE6jKXefCOFO+eG6hhbZpLsjY8=;
        b=KJCkxm9yXYTxlTzHCDNhLRL7fwZk4HOLvtpVTvhf4z0zozthZM4ugfSoDoLMvnLmL+
         Y7G42anaaTJ+/mkhZA1borxnZ5cqQnj78oFkR/Znu8zsn7U87Tub4Uz/KG2xUjfNzGeB
         Iq5RlRQZG5FbJhojUZU82jaC+V2oMnn3fYQBmAhVEB8lGE84MQnG6F/z27slsnrTZ9th
         JvbOQNdFJ1tk/BrERtsozJokXE33i5KluiWKsNdYV4O8mw96oewLTDuwyK+QmEaCcqrt
         3DoWASoS8i+SZmlPTg4O8QeFAYbJ3ufQLfapSklou28RtGucMIYDHOpctqwDaZYA8zFh
         2WbA==
X-Forwarded-Encrypted: i=1; AJvYcCWSz2vDVOskcE5fEoh64jaMmC/f+aIdgB2JUJRI+92XFZExpl05FDBHa7ZrXplgRNP2a0lRtY63bM3gJwa6NkLUw23ugRN949JX+9xqB4Md1W2FY14cNZi9xtprvzce04iKC6S9rrOeqQ==
X-Gm-Message-State: AOJu0YxivwEZ9oJVjJ7Z8SfagY2UC/qTk5QXZkku2z1xh3nO3SAb0ZMS
	eLqGYJItSN5DvxkOd8BDZoajfj+d2r6NhOJWjtNnj0NGlme50i4F
X-Google-Smtp-Source: AGHT+IGEpWbbny726Q3htn6XKcMmi4++Fu3v9DNQtTRzF7a9NIY1QXUPMWFlEmnWJ72ew/+300ULFA==
X-Received: by 2002:a17:902:f648:b0:1f9:cbe1:ae9 with SMTP id d9443c01a7336-1fa1d66823fmr31602725ad.44.1719129508450;
        Sun, 23 Jun 2024 00:58:28 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c8b4:4b16:721a:ce0f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f02f0sm41610825ad.7.2024.06.23.00.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:58:28 -0700 (PDT)
Date: Sun, 23 Jun 2024 00:58:25 -0700
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
Message-ID: <ZnfVoQmCE-wJbIYU@google.com>
References: <20240427203650.582989-1-sui.jingfeng@linux.dev>
 <ZnXbaubPVAUdDIu0@google.com>
 <7b5305b6-78b0-4add-9e70-271159cfad95@linux.dev>
 <Zncl_O-NjMRZYGeA@google.com>
 <ee4e8724-4a19-4814-9b7e-9eb6eb0ac6a3@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee4e8724-4a19-4814-9b7e-9eb6eb0ac6a3@linux.dev>

On Sun, Jun 23, 2024 at 03:38:23PM +0800, Sui Jingfeng wrote:
> Hi,
> 
> On 6/23/24 03:29, Dmitry Torokhov wrote:
> > > In case of non-OF match (which
> > > > includes the case where you use software nodes) the match data is coming
> > > > from matching spi_device_id entry in the driver.
> > > 
> > > We don't care about much how it is probed now, rather, after the driver
> > > probed by a non-OF way, how does the additional devices properties
> > > can be get?
> > > 
> > > 
> > > Say:
> > > 
> > > 1) "device_property_read_u32(dev, "rotation", &rotation);" and
> > > 2) "!device_property_read_string(dev, "pervasive,thermal-zone",
> > > &thermal_zone))"
> > > 
> > > 
> > > For those spi/i2c/platform devices, what we argues are that
> > > those drivers really should just depend on "OF" before we have
> > > a reliable fwnode API backend to redirect to.
> > They are working fine without such restriction now,
> 
> 
> You still *NOT* answer where the additional devices properties[1][2]
> can be acquire.
> 
> [1] device_property_read_u32(dev, "rotation", &rotation)
> 
> [2] device_property_read_string(dev, "pervasive,thermal-zone",
> &thermal_zone))
> 
> 
> > so I see absolutely no reason imposing this restriction.
> 
> The reason is rigorous.
> 
> You are acclaiming that works by hardcode or by ignoring the flaws
> is fine, then all driver are working fine by *your* standard.
> 
> Your personal standard has nothing to do with this patch.
> 
> > > Where the additional device_property_read_xxxx() calls redirect to?
> > > 
> > > What if users want to invoke more device_property_read_xxxx() function?
> > They are being directed to first the primary FW node instance, which may
> > be either OF, ACPI, or SW node, and then, if property is not present
> > there, to the secondary FW node, which can be either again.
> 
> 
> What I'm asking is, on the non-OF and no-ACPI cases, where's those
> device_property_read_xxx() calls can be directed to?
> 
> > At no point ->device_get_match_data() callback in involved in this
> > process.
> > 
> 
> The patch is written for people who need it, not for people who don't.
> 
> It will be involved if the device is associated with software node.
> Its for fwnode API user to get a consistent experience, that is
> to get a matching data without introduce extra/duplicated match
> mechanism.
> 
> The patch is focus on fixing the undefined behavior, is discussing
> the correct way to consolidate the fwnode API. Its not going to
> discuss how does the those *old" and/or how does those non-fwnode
> systems works.
> 
> Its NOT discussing how does the driver itself can be probed, a driver
> can be probed multiple way and is another question. Being probed and
> extract matching data can two different thing and is perfectly valid.
> 
> Your problem is that you are not fully understand what other people
> does before you rush into the discussion. You are putting restrictions
> onto other people, while leaving the problem itself there unsolved.
> 
> Its not a place to express your personal value or you personal status,
> such as, you are "ready" or "not ready" for something. Or persuading
> somebody should get used to what or teaching people to talks with a
> whatever tone like a God.
> 
> None of those junk words are technical, I can not see constructive
> ideas.

Yes, indeed, it appears that further discussion is pointless at this
point.

Andy, Heikki, Greg, and others: FWIW this is a NAK from me.

Thanks.

-- 
Dmitry

