Return-Path: <linux-acpi+bounces-9876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0121D9E0616
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAACB47C17
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3020DD65;
	Mon,  2 Dec 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QsrFClBY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F38720D511;
	Mon,  2 Dec 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149949; cv=none; b=ag/y+DV5+URchxo1ajDPs8BwPEFTq6K6KNHMft1CYIKMJg4uv/8KLjWwiEqXoxI3ga9s1XRdYrN4Ql+hx+kFkFZ9LtC1oYlkOfG483ROgkhzekiweyN1grJIz7ZxOR0hbKpP+KWB850Ns47/1OoJgxgilyNCvlM7n30b+pwPgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149949; c=relaxed/simple;
	bh=2zFv1AtOrG66Agxpkqi+vBOS91JwpVr62yukq7E/GxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKeqXd0uP8kIAWO26IrEZRsb/cP80PNqONT1vpJRF9MTfwI5jsPFU51zndOaDYiRzV5Svib/ZSLs1JnXReCO1knO7oJ+drW2RPWwcXZPzAW6j1LazTbUyq9edTax0jWdVOaqMZsLbwszTxwTnuWMlueER78VEVkAHx/LmbmKo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QsrFClBY; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733149869; x=1733754669; i=w_armin@gmx.de;
	bh=dff0OEGhYPTrkd11UE1HMB+sCm05D5j8m3PY3KktpLY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QsrFClBYjV5plSIK2+YlpkAJuQuMi9HqfV5hDsskX7GySktJDusKoWT62KgrU41d
	 wSR5516+uYOactq92I0zCqhQwtPRqKnAsS4VTYckzvRQAKjg0MrLoc/fr3wQPBcvg
	 5CBZVLczgn9tIifODeq/ygz24w+PWPO85w1K41ad5p4Wth/45B7VT66M+3ssy/7fL
	 wa9uFREwv1BstHpSe4sPgEjG9Vt+4e0AcRhT1FBWZr/YrEHDAe+NQ5tf7dZMZp2en
	 tXND33LpkU8lojn30OJcoZRJEnFBaKu143lGXAwPDcjs67zbikAZOcW5Hg9pxRw+J
	 EjzfM1Qb0pxRrwwk+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5Q5-1tUXmM1Oad-001ZDQ; Mon, 02
 Dec 2024 15:31:09 +0100
Message-ID: <63590d1a-ea53-4cdb-b451-e83a7a3d9224@gmx.de>
Date: Mon, 2 Dec 2024 15:31:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/22] Add support for binding ACPI platform profile to
 multiple drivers
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eHBOPBVM+ozXi7qQvpBCqWto44fLeja4GIMi+e5lWrFfndRsXCq
 4tHwZeYE8lkML/2kHdB+cqv+uaOiVwUn6DA67z8Wh/qqMKl92dVE0mU3TRLnKSPqRFfUyVZ
 n0XiHzpWr4P9tZelasnUMN0mx54KPRzisa+dkARZvcdh6jIe4uYfZKbyRUwOTVf6XLx0klK
 W2TjVXLlq+nmDmfUigGdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:de05/H5W5HI=;Zgq16+20JqyrWwL8nwAn5SS32py
 zBfg9xVBBjD1L0mo/qZyKTggO4QXFtWKClgOVxNdcLqRp5OE9dAgd/EWMHwZKWrh/jDMY6rBt
 7a0E4Pj1A14haKfOMLd3v5F1SrulRvVLdZD1vN7glsqS++pivTZtFyEG//E84pGFhTv3YGHd1
 8pUhtyic9z3c7rI8rKu+d2wfoK6WJB5ZID8C2Ia89zeuzKbK02E4HPrle3QlbOFQ7t95P+xRO
 fQdSAtTsKy5sXcDIeNEp8KxLIC626vBXPoBktgxKWeTI16OnpKKKXPFgb6GWVO0wVPk/VSzRS
 BNLkQLc3lren8IQz8BkOzE7PO6DeW0J+rJemZKo7niiR3bqzCgX41a3SU7/ezWAyrwBzQZkMn
 90wzeHD4jPdYYKL6bX1sl01x+cflWNlOueF1tqTcMqJ38ruG7q1/IpTMMvE+1kZ2S953WaolE
 F761YMpW0knmyH9xbKvfXmyy4u+Yjxvp14mUhXHmx2r3qLT8qJ/L+Zx9zOrKew+UZPa3lDQ0v
 tVnXEMVQ06/Bz8id3W8HhR3aRIgXUkd+GwLAwO3teVQcQC2bLCQH7j1fCvkrtuuaclNdPYWF+
 5z4+mRUxJ9G5GleDqspliMYspyNYMroWRTHrpeO5FbEKm63TRKg/9/CFHoQl+7a+URfUjsWsM
 jlqKjoNFTe4SS8x5uMdOHViib6qYKOvcjI0JmojiLLjsK/J/VkxF1IneDNnCQYiXEfs6rCA8a
 pGuhNHBAbmhTERr07HeaMJJUzCWuYedR/9bj/R7U4T2JKlCQLaSAvYld5BysBoNNiLfuGkECw
 wR6rZvE/c1JLwnvqGXH44mEK+vjsl02oDk2DpAF2BnfmJvsdKRTwD4uhBmvopYCok8qN+TEo3
 sDpastae1CNTN2BDeYt0o4zfzmsj4tVx8Zw28Se7N7LgFDfyaOxCAuzOYxp+znqBXvjeZAT1Y
 bYth0pfy6FLVHzbIzDYilGXNwp6Rdrs4HDaRyOZlXW6proszH2XTJFKSN9DvWk0q1Kq5leW0v
 7bS+d2cCantwRLhfA8C7lVd/GN+NLMWkx/BRcHYwxLzJeoJ9unGde3oXeY4BH7vYJDaB2sLGL
 RMcK/hicVeo/5vhEfffiCwY4jrY1Wv

Am 02.12.24 um 06:50 schrieb Mario Limonciello:

> Currently there are a number of ASUS products on the market that happen to
> have ACPI objects for amd-pmf to bind to as well as an ACPI platform
> profile provided by asus-wmi.
>
> The ACPI platform profile support created by amd-pmf on these ASUS
> products is "Function 9" which is specifically for "BIOS or EC
> notification" of power slider position. This feature is actively used
> by some designs such as Framework 13 and Framework 16.
>
> On these ASUS designs we keep on quirking more and more of them to turn
> off this notification so that asus-wmi can bind.
>
> This however isn't how Windows works.  "Multiple" things are notified for
> the power slider position. This series adjusts Linux to behave similarly.
>
> Multiple drivers can now register an ACPI platform profile and will react
> to set requests.
>
> To avoid chaos, only positions that are common to both drivers are
> accepted when the legacy /sys/firmware/acpi/platform_profile interface
> is used.
>
> This series also adds a new concept of a "custom" profile.  This allows
> userspace to discover that there are multiple driver handlers that are
> configured differently.
>
> This series also allows dropping all of the PMF quirks from amd-pmf.
>
> NOTE: Although this series changes code in acpi platform profile, I think
>        it is better to go through the platform-x86 tree as more drivers can
>        be introduced during the kernel cycle and should make the changes to
>        support class interface when merging.

Thanks for all the good work, the whole series looks good to me.

Thanks,
Armin Wolf

> ---
> v9:
> - Rebase on top of 6.13-rc1 tag
> - Fix LKP reported issues on patch 2
> - Use Markus' logic update suggestion
>
> Mario Limonciello (22):
>    ACPI: platform-profile: Add a name member to handlers
>    platform/x86/dell: dell-pc: Create platform device
>    ACPI: platform_profile: Add device pointer into platform profile
>      handler
>    ACPI: platform_profile: Add platform handler argument to
>      platform_profile_remove()
>    ACPI: platform_profile: Pass the profile handler into
>      platform_profile_notify()
>    ACPI: platform_profile: Move sanity check out of the mutex
>    ACPI: platform_profile: Move matching string for new profile out of
>      mutex
>    ACPI: platform_profile: Use guard(mutex) for register/unregister
>    ACPI: platform_profile: Use `scoped_cond_guard`
>    ACPI: platform_profile: Create class for ACPI platform profile
>    ACPI: platform_profile: Add name attribute to class interface
>    ACPI: platform_profile: Add choices attribute for class interface
>    ACPI: platform_profile: Add profile attribute for class interface
>    ACPI: platform_profile: Notify change events on register and
>      unregister
>    ACPI: platform_profile: Only show profiles common for all handlers
>    ACPI: platform_profile: Add concept of a "custom" profile
>    ACPI: platform_profile: Make sure all profile handlers agree on
>      profile
>    ACPI: platform_profile: Check all profile handler to calculate next
>    ACPI: platform_profile: Notify class device from
>      platform_profile_notify()
>    ACPI: platform_profile: Allow multiple handlers
>    platform/x86/amd: pmf: Drop all quirks
>    Documentation: Add documentation about class interface for platform
>      profiles
>
>   .../ABI/testing/sysfs-platform_profile        |   5 +
>   .../userspace-api/sysfs-platform_profile.rst  |  31 ++
>   drivers/acpi/platform_profile.c               | 523 ++++++++++++++----
>   .../surface/surface_platform_profile.c        |   8 +-
>   drivers/platform/x86/acer-wmi.c               |  12 +-
>   drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>   drivers/platform/x86/amd/pmf/core.c           |   1 -
>   drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>   drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>   drivers/platform/x86/amd/pmf/sps.c            |   4 +-
>   drivers/platform/x86/asus-wmi.c               |   8 +-
>   drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
>   drivers/platform/x86/dell/dell-pc.c           |  38 +-
>   drivers/platform/x86/hp/hp-wmi.c              |   8 +-
>   drivers/platform/x86/ideapad-laptop.c         |   6 +-
>   .../platform/x86/inspur_platform_profile.c    |   7 +-
>   drivers/platform/x86/thinkpad_acpi.c          |  16 +-
>   include/linux/platform_profile.h              |   9 +-
>   18 files changed, 541 insertions(+), 214 deletions(-)
>   delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>

