Return-Path: <linux-acpi+bounces-5624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B88BC2B1
	for <lists+linux-acpi@lfdr.de>; Sun,  5 May 2024 19:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FA41C20977
	for <lists+linux-acpi@lfdr.de>; Sun,  5 May 2024 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209E3FB01;
	Sun,  5 May 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Zg28Ek3i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97A374F9;
	Sun,  5 May 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714928618; cv=none; b=pVAijcsp/XIK+opncyUjBFUfJyb36RYRdps0HjcK0INuZLeMCODYmmqUeEVaHN0YDnitCY5689SedC0ZmCQgZS7aegKDCaBEAHtOSqm7U7nuwGftQpoj1+ZZHzRYdZHduDpgX8FGg2Qy0eywGu1PlhLwu7+IOwUVoA5QBgXPmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714928618; c=relaxed/simple;
	bh=vqXWGqoD0WEge/EGtT/dl0H0d4bIOExo/fiKtp+dLj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUcG6JK7UcWEPZuwN+uNpxjllfx8spAemyGD8cp79yYH7DsiB1Fm/rmStQeH4zERrdf7X1zyTz/EEeA2P017MNq54Ea5klqxKiab56ws3DLYW7HYnR/F+ihLLiyI33urCCeck+9XpF7c1PAOu6VuuKPd7m8h5qwKMpz/EISI2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Zg28Ek3i; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714928604; x=1715533404; i=w_armin@gmx.de;
	bh=vqXWGqoD0WEge/EGtT/dl0H0d4bIOExo/fiKtp+dLj8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zg28Ek3iy01Ok4ns67Gqv66QWQ4Th//v9urnVSzmly1Nf+z+YkWUsikV+EW3929v
	 YkA5XmGPPMPCftrx1tdmUendrOfvM2DkyLViF5Nzwm38NilLXCi5STI33sgc+kMIt
	 lSw2M2LQbIWpwrqb8KnlhEFuE4IbF/m8naAvVyLIDZ6PeB3vXHnqc/j+gm3qCe67A
	 GT/i691XnV2UlOnejkX5WO7OxEV3o0vdSxzemor3jQbzvpGpbrTAfDx/d9mZXsS3G
	 89x9bcSuiWbpQsYs/h/FGuDB4NdsECxDVWGJ81I73fAW3QWXzVzeJHgiUvV849wyW
	 RlELkTeADvL1oyt1fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1s1jzf1n1D-000PnO; Sun, 05
 May 2024 19:03:24 +0200
Message-ID: <a2be7595-53c1-42fb-8633-2299ab20de64@gmx.de>
Date: Sun, 5 May 2024 19:03:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown
 <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VYh0oW7NlAshmBPzG0maSLFgnt9EwLV3EjBVekYW/2ctcZmteWh
 vFM52r1NidXOUezHd7EbfgoCxdFLYdgIWiImqfqlXjvnu2kYu4Elh2fRZjP8X898MC3A7Vh
 yXOf6q/g2a/jE/dfHOyg8QNSj+4Yt/IhKh1iirrMm7eq1txNTXwyHRy3O7UiamEfiNo/+At
 lFOqhWs/5J4MW6YVXIaKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7JD+9MewmTw=;um97ztQmkdUn+IIxzlfuypDxmB1
 Z1d2IULncng6wkhpFTsMC+REsFjvd+8dDmZI1WZo8fkmxq9Z6Wv9FsbLsXp2oy4eWgwK0804/
 xOk6VeGnm0h7/eMEtDv+MeCdB3vvbCWURzu3E1Ln4UJokEbAFnwyIS8pkf5npxNfg6sTvmmm0
 l7lMGZ389rLKCdpTlYiUPh79PawetRV138u+Sn5Eisov4po7OKgjY0SDw6SzQNwCq4hsB93zX
 p12AFGIPHRxgw8Ujh5ALHVDhX+FuG+5fO2u5rYIR7fdLiADEB9tVtuqM3tTQuA6y3rYZU7RO1
 r2LaMeQ54Y4rizPuYzI9HmJl9hWOvJ101ztlddeuFaW6TpbqCtofYeARYT29SVm6pRkgYW/SR
 ZkUwwLUSdLSwb/dkrBr2G3/Y+XPbKoEat7zh26bE00f5DDmbSf4mqb1mZlc3jRF5ORfZNB6xs
 97mFO4+JFgu0K4yY5s9lg8AgtPbRPpaacb1WVqNbK/sz+eHl9/FdViw6cj42+Y2f6zJsqYuP0
 ia9gReopbPUwYHfSBqBr6oWir9Jeew5IWR1D6jjCuIkeYY8LNRr6CQY+sWCOvrePRuWUtREVT
 s6VwM9LWcgfSdUPB3MoSQd7ul0HTaOYsWPT1/MCMhFOxnWj1OExuyu046FUl027hWoooN+6zl
 O+ECOaAnIwqyxE4Md/wCoRqclJB0QQwBFK2J4n8h/h7vxv7s5rtXG9ViF9kXqxS6xr50htAYS
 DiXxjuOu4utLGqrzNC7takFbJR5Wmvu33Aaezf5zIR4+VRbmnw8sFPkRdns3dsPKG0cYlBMAX
 x5awEuFOavzampFofxE2VyrbKKUV9uFWdjZD8fknr7wgs=

Am 29.04.24 um 16:54 schrieb Heikki Krogerus:

> Hi,
>
> There's a bug that is caused by an EmbeddedControl OpRegion which is
> declared inside the scope of a specific USB Type-C device (PNP0CA0):
> https://bugzilla.kernel.org/show_bug.cgi?id=218789
>
> It looks like that's not the only case where that OpRegion ID is used
> outside of the EC device scope. There is at least one driver in Linux
> Kernel (drivers/platform/x86/wmi.c) that already has a custom handler
> for the EmbeddedControl OpRegion, and based on a quick search, the
> problem "Region EmbeddedControl (ID=3) has no handler" has happened
> with some other devices too.
>
>
> Br,
>
Hi,

i support your proposal, but i think we first have to figure out how Windows
handles such cases. Those devices are build for and tested with Windows only,
so Windows seems to specify some behavior which allows for this.

I will try to contact Microsoft and ask them how the Windows Kernel handles
this OpRegions.

Thanks,
Armin Wolf


