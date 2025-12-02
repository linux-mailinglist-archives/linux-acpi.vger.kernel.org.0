Return-Path: <linux-acpi+bounces-19390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8FC9D20B
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 23:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20A08348717
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 22:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7392E62D0;
	Tue,  2 Dec 2025 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ShCxkifo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460872DAFAC;
	Tue,  2 Dec 2025 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764712824; cv=pass; b=tMDSV/4wRNrqn7vcJJW2SEju8VDUm+ch0or/NL4qI5whvzuL/oBmylgrx/RKjNbfIwDNGzTI3WoAWpmyUGTUGL+u/9717sNiWB3e1FWRIOEIc0Q7hWe7qNBilA9AysJerWsxqc10mCsv55pE1L8c9pkX8urWDgQJ/Fuo2xiWRss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764712824; c=relaxed/simple;
	bh=dix4fMGgchlbQniirJUrnCknH4FOySsDmjeH7QCeSvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUwunfFJ11bJWKTJ+r355E7ZBEssYZ8YG8q/Le94YOrpQrj+iO6S3nBhv/GLsLKxm6w68R1F0uyuCG2LqJowaWJEtDDDSVZSvGSKZXrSlkPKSJAGwFHtLZNowjYmwzHvK/CzvrJcTSbVSrwL7JSXA6RLQgfdS6uRZGOw3uy9Kyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ShCxkifo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764712794; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RyY4x3y73JDAvrmA2XAlJJut/RJBOmMNHd4i4T3NEo4Jc7VnHFd+Jg5m85P2FVRRjx3Uxee5AeH+a00Myfvjc3n2EI+gqU54+a5W8PR9jm+FBEdVi0JzcMoPmj+c129Zwc6TCA6zdou1hoMWUiC+kYnZZ8vTGa+3hP8WzMZR5tk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764712794; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mLWrpzQlIvNrNxL1D05yxaLM5qnjARg0YSVpK57B0KM=; 
	b=kSU+uQZV0tGeS4w5e0zgX+E/NGh0cm7xxJzXYz/b3m40otCqG17W60UbhvxVCxQCrtQRpAPkMmEFai4UiLEWwKgwxZMVD+lr1EXVuK9Yg1hEOuHnnQg9mpHBTJV2AC1dxWyp+B19q8fs4mC2w6bnOnMO1vSTeYvK1aTVtd15hyE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764712794;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mLWrpzQlIvNrNxL1D05yxaLM5qnjARg0YSVpK57B0KM=;
	b=ShCxkifo4nWIm9+SxwG8JmMumC1gILK+uTrsjsd5czBsJNpQn9VEgNn/mUKW2MVj
	vXYCBczQ4EQwROP7wfRY5FFjZL26yoBvvbXYm9M17kP7mDJsszUF1p3DNyDWigaXNW/
	HyIzLgBVW7OYZn5zWToRFW5ING6FGQCps3nhT6d8=
Received: by mx.zohomail.com with SMTPS id 1764712792306882.9934385686995;
	Tue, 2 Dec 2025 13:59:52 -0800 (PST)
Message-ID: <3142dc60-4a54-45f0-a4e7-c2e55bb7f39b@collabora.com>
Date: Wed, 3 Dec 2025 00:59:46 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <superm1@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>,
 systemd-devel@lists.freedesktop.org,
 Lennart Poettering <lennart@poettering.net>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/2/25 12:32, Antheas Kapenekakis wrote:
> Hi,
> thanks for having a second stab at this. My initial series for this
> was kind of complicated, I would need to rewrite it anyway [1].
> 
> I will second Mario on the integer values. The main.c file provides
> the capabilities used in other power sysfs values and an ABI for doing
> string options.
> 
> For me, I have a bit of a problem with the ABI. I kind of prefer the
> one in [1]. There are three sleep states in Modern Standby: Screen
> Off, Sleep, and LPS0/DRIPS (and a fake resume one I added). The only
> one the kernel is suspended in is LPS0.
> 
> So the ABI should ideally be able to cover all three, even if at first
> you only do screen off. This means the name kind of becomes a problem.
> lps0_screen_off implies lps0 (is not the state, is also an ACPI x86
> specific term) and is limited to screen_off (cannot add sleep).
> 
> I used /sys/power/standby in my series, which I think was fine because
> you'd be able to add hooks to it for general drivers in the future.
> This way, it would not be limited to ACPI devices and the name implies
> that.
> 
> Two other notes. At this point we tested pretty much devices from all
> manufacturers with my series. These notifications are used to control,
> for sleep: thermal envelope, fan, power button light, for screen off:
> keyboard backlight, device RGB, for lenovo power light as well. Yes,
> DRI should be cc'd, but no-one has used these notifications to do GPU
> specific stuff yet. You can call this ABI with a screen on just fine
> on all known devices.
> 
> Handheld manufacturers typically tie their controllers to them as
> well, as xinput does not implement the new suspend features in Windows
> and blocks restricted modern standby, so they have to be turned off
> beforehand. The exception to that is the Xbox Ally devices. This is
> because with the Ally X, Asus switched to the Xbox GIP protocol which
> does support these suspend features but still kept powering off the
> controller. For the Xbox Allies, they went a step further and no
> longer power off the controller.
> 
> Another difference between those two states and LPS0/DRIPS, is that
> the LPS0/DRIPS specification binds the state to the power state of
> certain onboard devices specified by ACPI (ie when the GPU, XYZ
> components suspend, you enter this state). With Screen Off/Sleep,
> there is no such requirement. For Screen Off, the general idea of a
> screen is used, but sleep is completely arbitrary and in Windows is
> defined by which software inhibitors lapse. This makes more sense
> because even for LPS0/DRIPS in Windows, the way it enters it is
> programmatic now as well (after all software inhibitors lapse). To
> that end, there are three types of inhibitions in Windows, one for
> screen on (such as video), screen off (such as compiling a kernel,
> writing a CD), and sleep (periodic system processes; email
> notifications; low CPU%).
> 
> Antheas
> 
> [1] https://lore.kernel.org/all/20241121172239.119590-1-lkml@antheas.dev/

Thank you very much for the extensive reply. Haven't seen that series of
yours before and haven't considered the sleep state handling. Upon a
quick review, your points sound reasonable. Let me think it over.

-- 
Best regards,
Dmitry

