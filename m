Return-Path: <linux-acpi+bounces-12374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECBCA6AC90
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Mar 2025 18:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899FC487E94
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Mar 2025 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925AB226CF4;
	Thu, 20 Mar 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IgdTDTb1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09504225403
	for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493446; cv=none; b=luxnsWE8OxX6i7Loydfl2kmJglJLCiI/K0HDMd1mrBiGdBYBDlEZUp/NGw04wnJ9lJJ/fsJUJoD8pO/+EIgRxvdNrwGmg2W4Z0duXP5pdHAz3H1DRtl3+11i13ZrFZcAKKIRbIztJm9nTCxF/A4yexLmYp/9dDbMqBQ/YfFd2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493446; c=relaxed/simple;
	bh=mO6ApbMHzxFMCtQxPMSGmJnnaUVaxpdYXWiMJjhdnYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVV9uA0f1h5A647KyGdXebHKlnnb8ICE4+F+GkQGgBpUEjaZENwjptprRA7dpBm81vfxqsFPmqI3Uo3vEGGfKoBxgOmcVtcXxkyGGq1nyI3U8wOzzNTyVM61Vl20BiA7GIIk1Qtx22SZyVnX1DH0dPEtVJOKRQgAI0MHG0FDvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IgdTDTb1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso3588259a91.0
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2025 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742493444; x=1743098244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZBuAO/4lH4CVBlD86N+IBRXOKzZiRkJHD/4cEnzLg8=;
        b=IgdTDTb1X2qtQtOkDRsbcKFEP0YT598B/9Y24roSjP6k+N94B0usGnhtgNhRHvg0oA
         ug/vDzEqKyvbWyEoPZoWX7T1fP0ze0kP5URxeXtgHY3H1yKyh+FQBkONrq/sUv+v4HRb
         SAI/w/sQUA+DLKkcAVN5KHw+yH3qNxSmovIy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493444; x=1743098244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZBuAO/4lH4CVBlD86N+IBRXOKzZiRkJHD/4cEnzLg8=;
        b=nd8lVYaTpXO5tNg+OmRmTzJ+vLd8V3yU+A4RGVRU0I50co5jyOTx9+Wem6lQS6UlTQ
         gIFB1b37a+LqF4RLBZ3cjNlgRqvu8zecShIoqAg0d9GXLcxelB9GoA1uVUazXhTupwnA
         OPT1L2BNIlvwP1HUcvlm70O9eJqoI674rB15hlVx/UpSEpTYqt5cyOil9YJH08eqffZD
         TlCffpbt4+EZVaZrfY8tUN6DHLrM2O8MrtraPovO5z4Afkfr7SqG4DdVAePoOSHJPxnB
         seuj6xZ3EnSXcdmvKpCHlG1k8TvyqixrbMjlGIHicPHHxAmK9F8+17ToB0aF/BKMQY8+
         cZGA==
X-Forwarded-Encrypted: i=1; AJvYcCWeLHJz8rxiEPyEoeDapcqIKkhPyzxL3zGd69uKfJxIsOR3Rz5S+elvQmHXUTPIYS3/FudhEalIfIJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YzzW67u4t7zB/R8deBJ9O5eF2/PlxaWBIZR9pEEIg+Z+2G3GU0D
	Z7m0pDTQEWRatALTsIVkynppVEN44j+EilS6oYBNMpWnwRAKqN0fvBDZX2KGWVVSc2K1/yIDssw
	=
X-Gm-Gg: ASbGncswK1YEbNybZNaK1ydWIz/Q/IQUnRn3HEURXCaaqdOcyrxKdxvs7ROK8tjf7JX
	PsgBnoCt/5NToJjRgIuwPwbuc8W5QUPZMIl0srRXy/jjP1MpT5JeXM3fWnFHopFInLJuAJ7Tiur
	XJEYf0VSboPVrHWf1erjI6Hmak3lhN7+qGMC1W054prL3wYPjqKG4LtbwO57hkz8lp5VKSGWCe5
	QOy1vQCeVz+28tgBw55AFOXDyDLtw+tX6CEHfk/kT2F1d2zuCyCigLHBWO0CVuzNtpR9uyMqKZ/
	LKZKOWx9UQR+G6OR/cLxnA852W51SpEEcGpTd/mtp7y6fTFw0Kv7hRg5mM+OE5f0hjkrsezKiWD
	KbhIoqMQ=
X-Google-Smtp-Source: AGHT+IE7xF5qbvgKRnHfx2I3KfMDgIwTK12qXs2qkhWYJrmEZMMPOAnefkb2h4CcUxPOX3VUqrZHNw==
X-Received: by 2002:a17:90b:54c7:b0:2fe:93be:7c9d with SMTP id 98e67ed59e1d1-3030ec2a985mr625654a91.7.1742493444134;
        Thu, 20 Mar 2025 10:57:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9e6b:24df:389d:f71b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301a5ea4e9asm2514396a91.1.2025.03.20.10.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 10:57:23 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:57:21 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <Z9xXAYA4KS5BabhE@google.com>
References: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
 <20250228174509.GA58365@bhelgaas>
 <Z8IC_WDmix3YjOkv@google.com>
 <CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com>
 <20250313052113.zk5yuz5e76uinbq5@thinkpad>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052113.zk5yuz5e76uinbq5@thinkpad>

Hi Rafael, Manivannan,

On Thu, Mar 13, 2025 at 10:51:13AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 05, 2025 at 02:41:26PM +0100, Rafael J. Wysocki wrote:
> > There were hardware issues related to PM on x86 platforms predating
> > the introduction of Connected Standby in Windows.  For instance,
> > programming a port into D3hot by writing to its PMCSR might cause the
> > PCIe link behind it to go down and the only way to revive it was to
> > power cycle the Root Complex.  And similar.
> > 
> > Also, PM has never really worked correctly on PCI (non-PCIe) bridges
> > and there is this case where the platform firmware handles hotplug and
> > doesn't want the OS to get in the way (the bridge->is_hotplug_bridge
> > && !pciehp_is_native(bridge) check in pci_bridge_d3_possible()).
> > 
> > The DMI check at the end of pci_bridge_d3_possible() is really
> > something to the effect of "there is no particular reason to prevent
> > this bridge from going into D3, but try to avoid platforms where it
> > may not work".
> > 
> 
> Thanks for sharing the background. This could go in the commit message IMO.

Yes, thanks Rafael. This adds a bit more than the guesswork I've done so
far.

> > Basically, as far as I'm concerned, this check can be changed into
> > something like
> > 
> > if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
> >         return true;

I suppose if this harms any non-x86 BIOS systems, we can just add to
bridge_d3_blacklist[]. This works for me too.

> > which also requires updating the comment above it accordingly.
> > 
> > This would have been better than the check added by the $subject patch IMV.
> 
> Looks good to me. Brian, could you please respin incorporating the comments?

Sure, will send shortly.

Brian

