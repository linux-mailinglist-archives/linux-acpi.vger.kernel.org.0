Return-Path: <linux-acpi+bounces-19468-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15DCAADAC
	for <lists+linux-acpi@lfdr.de>; Sat, 06 Dec 2025 21:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBA513005A64
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Dec 2025 20:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385E428640F;
	Sat,  6 Dec 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzlsifMz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102411B0F23;
	Sat,  6 Dec 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765054252; cv=none; b=WwWRypDoBX2KRQp3QcuWBCtL2pBp/o6YFzDWFhn+K7O43r/Jv05EYA/5XvevYMsZqbFdTJwxBo7l88HOONYG/pksHdT0zgsD40T7vRCTNQuwwUk1eXmpJsG5iSHH9uuCMhJFRIdCsg7k66dMZ/WBIE7DCbrTO+6w56n+6o3B3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765054252; c=relaxed/simple;
	bh=sRnFIg1VrYNqYjDurSHX00/GOt5sT0Dy1tFsDVtl7RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riVQc/N/uR3iFSlxK4T8LS8UZAbM4sCQRsk0wzZ9O751sH9/zvf+dusBKh60UgOJL89PXd2VEvf6DredVwKXmdxZAR3UxOY+qBFXaYSokNGdcatGJRAeK/d4ZYKEHSwIT3PnL7/Sp8xbdq3dDQ3xs0bQyHZR+BoE667wtxWpnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzlsifMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73445C4CEF5;
	Sat,  6 Dec 2025 20:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765054251;
	bh=sRnFIg1VrYNqYjDurSHX00/GOt5sT0Dy1tFsDVtl7RU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CzlsifMzqKBO/+z3sgnOMph+21Zi4siFLJAB2Ag5D3FCADYYGlBc5yaHOVTdilJEr
	 6+we04suoMWewPlmHG1Q1NHELPVDO69sd8rVnIArt5jY9Gd9XcqPNBo3D3YqVUPnZc
	 OS1+DkG2X650XDwzruBHAcFpyIIb0H6oTMNCbs2JZliya3QyNW2GR12g5NzYkU5PP2
	 xpfhFqnVrhnkobmNgE2tne9aABgVOPqIScD2EC+pRJYTbMFHDb/1f1Vt8qBqHfugYI
	 JdqFohiTZM6NRxaJ5vDf+BYSrcUla5bqufJLsQ/v1OPzor5QypwLgFwIwnioQHM1vN
	 er977CNh3kLMA==
Message-ID: <2711fe57-1963-483e-b8fa-0c5ed0bd2ea9@kernel.org>
Date: Sat, 6 Dec 2025 14:50:48 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Antheas Kapenekakis <lkml@antheas.dev>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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
 <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
 <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
 <a0d91fa6-bf95-4bbb-a4f9-9d8cceae5543@kernel.org>
 <CAJZ5v0hkkurEK6X3_d_AErKMOn9uicusEb1OhDAv5sFHr7_ahQ@mail.gmail.com>
 <411ea5f1-7cc7-4a2e-99b4-2891f3aa344e@kernel.org>
 <CAJZ5v0hQMGarx96oU-OHXh8665FJ2UP4dJpVKoxCgdyi8fZ1QA@mail.gmail.com>
 <6d7b916a-8c37-499a-84a6-5facbe0e3bd4@kernel.org>
 <CAJZ5v0jqdQw57t7Moj4o2eWt54t1wBvn8_0N9L-orn_JzFGWyw@mail.gmail.com>
 <CAGwozwGafykCaiEa+EUS+QQsFBXR53-D4aYpW-SPRX=Ax1-F2w@mail.gmail.com>
 <CAJZ5v0g5dwWSOQCTUFeD+ztFLyYrRR1Z=vt2C+c48SRbaNLJzg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0g5dwWSOQCTUFeD+ztFLyYrRR1Z=vt2C+c48SRbaNLJzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I will reply to the earlier reply from Rafael with more context, but
>> runtime suspend of the GPU is not part of or related to these
>> notifications.
> 
> Of course it isn't.
> 
> What we were talking about was how to get from the "displays off, no
> GUI activity" user space smoothly into system suspend and back.
> 
> You are saying that this has been done already on AMD, so I'm not sure
> why you want more.
> 

I'm not aware this existing in any unique way for AMD.  The decision of 
displays off; start a timer and enter suspend would be the same for any 
vendor.

But GPUs aren't only used for display.  If you're actively running a 
different workload (for example an LLM) using the GPU and happen to turn 
off all the displays you wouldn't want it to suspend.

What you would want is to key off:

1) All displays are off.
2) All GPUs are unsused.
3) Some time has passed.

I feel that if userspace is going to adopt a policy like this kernel 
drivers need to use runtime PM when displays are off and the GPUs aren't 
being used for anything else.

At least for AMD this doesn't happen today and would require driver 
work.  But the same kind of work would be needed by any GPU driver.

