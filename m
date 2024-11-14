Return-Path: <linux-acpi+bounces-9592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14D9C94EB
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 22:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED03285B72
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 21:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560E91AC444;
	Thu, 14 Nov 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="U+oN7WS7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB72AE77;
	Thu, 14 Nov 2024 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621508; cv=none; b=Ldntl0WDjEogQeHkkCd32NxZXDg+p/J+REOpXgLyqBF0Q0AORwMj8Cjl39Zw5KdJ+dWD2MrbClMUflpfn/EB8RJ0RKLmMnBZ4c/D+X1nczsAOezufD4DoZEVgWkVETveU++Cke0s/9jteSB1wqwo0QxQDr9Rpf+ZyHvlahfZc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621508; c=relaxed/simple;
	bh=SVNwqJjmnsb0X1m1vCU8tBtVz5ugZhutfaGtXYB9eCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OH1OgtZs5mtfYZSIKYemmYg0d/weS8hNKaLpRVAEfBi7xuEiYO/HR+8XXHpintwtgmYK2FW+t0H8AqZrSa0Yjte1g3MIF7WJA7Lxb/shElr5jCXCxviI9ch9+j2SuwF2q4iHCHM0EgVsLR6g4YxeFx/r9tH9XwA4TiFGQM//leE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=U+oN7WS7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731621429; x=1732226229; i=w_armin@gmx.de;
	bh=9qcgA3bnA+s2XSWe/fPuo00dRocehSJwUpMf7lnNoc0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U+oN7WS7hQ5omKckKsQalAXp39WpzLkDW2zQaec3NTeF1w2Qn5xsYydB8ZhqMXkB
	 eRCia7XoQInLv5v5gUKNYVRWDuUYMM2zttTMLu1MAzd2Z8wR2j6Y6nMBZ4HrS05kf
	 05uBefAgA8yhSFXA6Q8C9zlQZcEhOAi/cILdNVF+2Btgm4f/zMyWIaZp6GprgUyB1
	 EtGdba5j2fpalCZWwc0Ck8y1DVm+Ze4GepkTRdFbT60Zu4H6lLLpEi2jvRV26pxeH
	 9stx4jNPmBue5OEet9BV/Qo1BbJE9pVyKpB1eXTzDmA/4mSxRAVXL+lJvz/ULQJro
	 dA17snBEKDS+rhcSYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBlxW-1t3z7x0dAa-004x0z; Thu, 14
 Nov 2024 22:57:09 +0100
Message-ID: <7d06c91a-bf89-4880-b640-1fce38d51036@gmx.de>
Date: Thu, 14 Nov 2024 22:57:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/22] Add support for binding ACPI platform profile to
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
References: <20241109044151.29804-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JvhZIOKluCBSC5Iz9+0fdCabppxDp0AZeCcAXaJhwcw5Wyw3okj
 82u7dnvPU3FZz5UAbVOZYQ1RK5xKtDshTfi7Lt3fs6qU+pMb3xTGAgheI391b2rSIxsjhmM
 5BL9q/4vsEd5Z1aVMzQtRYXXJI6rrO+iNRUwTbl3uzq5w0UW3gRtuzU9Jbrq9HZEN/7Ku20
 T55YdJL6YosgUSCrRrS8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jslF+/9MuvU=;Aj9vo/qZ7jV5bTlvLIgQWcpUfUa
 RxOWcZlF/dRgyUcoqwNrcPZ9IY3JFOcPZ579kwjm7RcQ07AZ5bR35xGIgH4C1loRphTL0cM0C
 b1kUT8oqSXfBAbvutf+lVyveDcUwnjt7WVIE0uapG68iQko4qZZXXX0K6hLu1Tlxc3lDQZbZR
 IBFe32kEiNYtO2Q7TfoRFOzFeCaO+sv50R2Vj0MtJvPm9Je6RKCZ9ha1iN/VrJ8NmTXRJGE6f
 Qv3td9qu0qGz5awtpZSnUCWnHJA9cAhJ3h+vqi0q2Rc4Prxum5H2WkNGW/+6RxMBdzwUfJSCS
 oxMr2VPgWDvfw9IRH6cKODRVT0G4E+VUNyxwqHjXmVQg7k7Vw9wo5xNMBF8eV1sStheZfSaXz
 s2TNPAlQf8q91F3MUFRX1ad+CWmt7k2/HwOcy5+eLL9DL7+b7iY9FFTL2MW8n3XrFn8Su8YOx
 NpcvDHQbKAWXOlcQvjRKMgxJS+nTCgzn0Mm+JnXvkmo7scqW0SaTZwV2Ehpzay9HQ0JKbWat8
 V5sH06rTsZE2Zjtm+GZQS0iZe1dJkEZH8z+UjLBcqpB1jBc219SNrvgIbK4WcRa0+Smd4rTUw
 GPdunby3BWyFzVTAeJ+wygMzUloVIkjlkSg1I2kgOiyDtHuFE/wRJiRq4BBBa49pQS3f3sFv1
 PeHnu9GjZWIQXQxyfRezV2N8rMZAEJjsCg6cyHo85OcuQXlo3YohB1etrVK94DfnVaHp8kmZE
 wBddiR3mkSpCcstwf4ZdtETON+F0cf+Ydnnz3PBvePcFPjOkm9MCfIOsaAW2/+fyi+fjGS5o2
 VzRFoHq6WlqExBkOcsYHo68IkwrgXr82ffPYYuRg8Ofqp/xaZz6nmqjVbCad2Yo2ZTBmWCUFp
 AFibFYONOGIFgi+gjFCyjpovaOXHJbYVWik30nM6lAZFztbg+pufdy6+5

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

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

Sorry for taking a bit long to respond, i am currently quite busy. I will try to review this series
in the coming days.

Thanks,
Armin Wolf

> ---
> v6:
>   * Add patch dev patch but don't make mandatory
>   * See other patches changelogs for individualized changes
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
>   .../userspace-api/sysfs-platform_profile.rst  |  28 +
>   drivers/acpi/platform_profile.c               | 537 ++++++++++++++----
>   .../surface/surface_platform_profile.c        |   8 +-
>   drivers/platform/x86/acer-wmi.c               |  12 +-
>   drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>   drivers/platform/x86/amd/pmf/core.c           |   1 -
>   drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>   drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>   drivers/platform/x86/amd/pmf/sps.c            |   4 +-
>   drivers/platform/x86/asus-wmi.c               |  10 +-
>   drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
>   drivers/platform/x86/dell/dell-pc.c           |  36 +-
>   drivers/platform/x86/hp/hp-wmi.c              |   8 +-
>   drivers/platform/x86/ideapad-laptop.c         |   6 +-
>   .../platform/x86/inspur_platform_profile.c    |   7 +-
>   drivers/platform/x86/thinkpad_acpi.c          |  16 +-
>   include/linux/platform_profile.h              |   9 +-
>   18 files changed, 553 insertions(+), 213 deletions(-)
>   delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>
>
> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2

