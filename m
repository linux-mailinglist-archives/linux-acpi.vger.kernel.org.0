Return-Path: <linux-acpi+bounces-10339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A5D9FF06B
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B9B188075B
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206219A2A2;
	Tue, 31 Dec 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoiIw4qq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E31C683;
	Tue, 31 Dec 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735660415; cv=none; b=YeE+KewZVNvkgbQCv+lugD8tTGGt6zL7b8VAKXZcOIg4o6rBecDkJe6XmCWZnbFFZk94MRgK2c2M5E7fC2m2RKyD3dGf5+A2zMI7Y348AoUmTlHLvdkiAQLbjmIgh5EM6g+sKCwLp1fCKFMDXdhlRX0fiycnpL5AtoE5qdex+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735660415; c=relaxed/simple;
	bh=KDLIaVkCTXgvi/X54ec26dlRwP439BW45tSdxoVsiAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw7CkkQVm3ZvfOuXcC5WxEyGOix4omhGP9CfzPcZoIpUnnF1/eWXsJZ/X17SStmCj1APmYEeVS1FUxdA7Me50UQcZEdKmSkeMr3/nIDEQanVY2QTXg97JfjyM7wRtIwf/22otEPRYqSjOwakA7ExSh6kkTx2spN8YoDMkW/gjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoiIw4qq; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso13831212276.3;
        Tue, 31 Dec 2024 07:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735660413; x=1736265213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EwRpEjFa+TS9Mg3MENxMxqboRhcmn0cpNw5dodxNHeE=;
        b=JoiIw4qqJGHuaehze+rZFyIbB6I11JoeTcWBczxQ5sx5mpW2hx+IDisQsFqvdSqY0R
         Gitt1LKSJ3Xb4iFQk40BqaVk3uyahIyiBB6P4cnjsHKQwuOC86J1wMl4rLDJJIRkWy9c
         /7zz2ZBMbTTnuXDiFuhip0vXoY5G7gQS46MzBtVrVZdP8E7lAxD3Zn/ehQHqSQJ8XCAC
         890Ps297J1pubgnd/q9MZKe8BgJJoLaG8Fx1Ln3/wYpoRd2Sr7FQuaE+rC/3j7gBvLAX
         +VjL5tX99Bxan2LdnIgww3wuzg/g6ZoqslQR0Q9X6ZTMSPGMNV6SKak4b6K06banqKqx
         hetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735660413; x=1736265213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwRpEjFa+TS9Mg3MENxMxqboRhcmn0cpNw5dodxNHeE=;
        b=Von9vD3RHYFLy5UL+EpOR09mv4FRfp5J+KzlMuEmUScH8yklhmbcs9myGwi2G6bAW4
         Z8yMUJZbTqFUEEcSUDw1FVeMLzhdjet5EpjQxSOrYTTNCTQNwefF/ER9q/ktuGML4RQq
         MCO8GfpbY2jatPc34fUB4n530hGMdK5zBtbDoRh3M9Mq4kvWfNGZDK34e7OhFDWAXcjc
         g+9rBvCFfNBYo2F4ANc1cPkfe7cFEqQMN4nqUZZiYSMudz+v4tneu3Pggn8evDfGlXJL
         g+7Qx1HUfF7kOxHcRHdAc6vgr3H8qoANoJiLHGKIgbfr2YyuQxRzfmUwZDt7Qwm7wKGt
         06Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV5+39iTJ0yDsGo7wP27wlAJoW8YzcFea2IcIQwjXghh5tpQf78fpil9IxOokQQjhDWTgG7rHpv7wYC@vger.kernel.org, AJvYcCWddv6Euhvt943pvp9su2HCOI/BBOOhLZc4e6+r8yF5Hs18ARZ6Vz+G39+Y0N6E8PWurxLuFNu1DSiRpiTb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ImOgqjQdSuozEQ9SNJZJfOFODGWLL/Ic+WQ8TRLntjnJnW71
	dhvTFMq7ashPufTOAVnN0ADR1+LRVPdsTGeBQEgI3WLOWvyUe4l8
X-Gm-Gg: ASbGncsinseWYf4/eiAFu3KR00rTT1hsOmnIP+mUOyCPm07jbBt6dYpXCmN59KmPYDX
	awDOJYU3lBstv3tYLXTjWomF18B4NNEApcwt+4aF2K1yndBCbIeqFzmpn9PCAMOXKUpEPIcglYS
	igGVSkpkPDM/5lp7ja3nMaQhttBpr0PNBAjDrYDIPXChhwsmvRtx5gcbp+5qj2rbeBvssWiAjwi
	iuUU0Cbi2/RSDlM1+VJlDFqW9cS/sdF26VkS0vewzxihZgwYdhSmg==
X-Google-Smtp-Source: AGHT+IHG5538UecNtk5l/e74GYoViHNtljjB53ijuISnTo4lQqorJp6NeNcdbIqzomUTSqY3NX8NZg==
X-Received: by 2002:a05:690c:7481:b0:6ea:7d88:ae3f with SMTP id 00721157ae682-6f3f8126208mr298915027b3.17.1735660412746;
        Tue, 31 Dec 2024 07:53:32 -0800 (PST)
Received: from alphacentauri ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e73e76cbsm62880087b3.22.2024.12.31.07.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 07:53:32 -0800 (PST)
Date: Tue, 31 Dec 2024 10:53:29 -0500
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, W_Armin@gmx.de, 
	Hans de Goede <hdegoede@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Rafael J. Wysocki" <rafael@kernel.org>, soyer@irl.hu
Subject: Re: [PATCH v2 0/2] Device managed platform_profile_register()
Message-ID: <q45nl5wdout46frnjbkufvi2pmyhz3cfyp72qyqrsnhpnlmhue@3no6u65stho2>
References: <20241224140131.30362-2-kuurtb@gmail.com>
 <00b64207-ec35-5c99-9bdc-13c77e51e453@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00b64207-ec35-5c99-9bdc-13c77e51e453@linux.intel.com>

On Mon, Dec 30, 2024 at 08:31:28PM +0200, Ilpo Järvinen wrote:
> On Tue, 24 Dec 2024, Kurt Borja wrote:
> 
> > Hi :)
> > 
> > This is meant to be merged on the pdx86 tree.
> > 
> > ~ Kurt
> > 
> > v2:
> >  - Replaced convoluted cast with intermediate variable (1/2)
> >  - Restored dropped empty line (1/2)
> >  - Couldn't incorporate Armin's second comment. I probably didn't
> >    understand it (1/2)
> > v1: 
> >  - https://lore.kernel.org/platform-driver-x86/20241221070817.3764-2-kuurtb@gmail.com
> > 
> > Kurt Borja (2):
> >   ACPI: platform_profile: Add devm_platform_profile_register()
> >   alienware-wmi: Use devm_platform_profile_register()
> > 
> >  drivers/acpi/platform_profile.c           | 29 +++++++++++++++++++++++
> >  drivers/platform/x86/dell/alienware-wmi.c | 10 +-------
> >  include/linux/platform_profile.h          |  1 +
> >  3 files changed, 31 insertions(+), 9 deletions(-)
> 
> Thanks. I've now applied these.
> 
> The first patch is already in the for-next branch and the second is 
> currently in the review-ilpo-next branch (as I wanted to retain ability to 
> easily separate changes into platform_profile.c from the rest, they go to 
> their own branch first).

Thanks Ilpo!

Should I rebase the alienware-wmi rework patch series on top of
review-ilpo-next in v3? Currently it's on top of for-next branch.

~ Kurt

> 
> -- 
>  i.
> 

