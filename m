Return-Path: <linux-acpi+bounces-9414-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF189C00DC
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 10:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332331C21092
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83731DF990;
	Thu,  7 Nov 2024 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="P9tTBhTJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA01D7E4E;
	Thu,  7 Nov 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970446; cv=none; b=Fxg6yLWhd9WtxuRSPMPTXp/ftYOjw2a8EoYV1Q2GsrJKGU0V2sobSmdGnMXJnoLDFt0GDCjOHl7/XS6uHS3fpk2vY28ZjX1I03JKs3/5OXMNAFOptjucEBGQa77G8AL4CA95rRjYZWMwc+qomRNYQWiYt2pCMlA3O3lJfITfGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970446; c=relaxed/simple;
	bh=c0AR+fpzTIK5s8uK07cVd2kj7HaWcTpZQ6qVaHTvz74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfWruA6W7LAseNi0LnCS4RjHOFb+zUMtjxUPGjs7eDsVTO4x43R3weOfmn8N1s80SaWzj+M+BdPLp/PY7gBxIHmWCnqCmWDF/seEVeY56PxqBk9zf8u5q5GAiFKBEjKPXQtik2ZdJHmHeqv6VrR3dbU/9JrDUTH/Aw8u+jwZQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=P9tTBhTJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730970371; x=1731575171; i=w_armin@gmx.de;
	bh=XdYRMmPOaL0bdKpulzDtr3bLJFniavxTjhe4U2Z/1Vo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P9tTBhTJxM7G1/UXf5qxPp5NH7vQnRU3zwgyBuWbKVqqOl8wAhZvDryxciOA7luw
	 oMqFHKfWZlp6GC8jm+bCIVUYi758SuRuw6sdxZL++128AH6Bp9d2eJVpqt3KTBk0O
	 B2EW5wAjpyYs3VN2uZsHmsxm+WxkswG43scDOtuhsPN6ydiqeL54rXoHtoIi+Qsf9
	 tXp1NsDTVlcuWqZOv1Tf03lAmsMRxrElhNcDdQJe3ZpcXWEjIelYtHrf1ZmI12mH4
	 1NpprcFae5D32X+sfEATAn4AcanoLfV8uz4cbCJtwawS1BoDq1nHAW5de9R/qeQwy
	 oqzCmxejxgAifELhww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1tGVXU2zEZ-00OoLq; Thu, 07
 Nov 2024 10:06:11 +0100
Message-ID: <d08d40f5-5482-4e7f-99b4-a5d9e403b828@gmx.de>
Date: Thu, 7 Nov 2024 10:06:07 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] Add support for binding ACPI platform profile to
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
References: <20241107060254.17615-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0FkS/Ipgh8gdAfk/1/DbhdP2EHLF6LIIUa8bYx4+XATEaTJpOcc
 RExZ3bZ0j/texE553bWcJVc0OvxPMu9UyX1So9zjeHfr3by5Fumi+FUFyUAFY2JZXbCjmJb
 H5lj6TU4MBUbJRcnBmcLxZsamnFsKzU0UH19FIazqXscDpQXpAy+C4DKBDoxV7jsu/T6kGF
 +sHsjxk+E80458LAh1iEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oTAlYrmi7Ek=;3Kr3Mzkv+0IT6IGp7y1RRu6O472
 /snG/IRpye+2IznBaSWbEjF+LEJAAeRjKKOUFMFERWDVyKE7vzRuObJRbaCrtqo/6ZawpkXa5
 fCMaefv4SdGbPdRIEX5DatPxmkDs0JYWNSunkjc54H5/wJgM54KVHjQ54f7Q1fby7WuK5XxTR
 O/3OioUxC0v3fC4mhUqcKW5gInBNRiVBn0UC0JcDpPd3kl7/Zd/ozN3XXkJdw2YZpYyG2h1GT
 oshAJagOVL/wW7Z88MNW9ngWfuYjxS9m7oUDqncCxcK/uWA7a4Y8g+xxFtnZtwR6VJ+GIgpBN
 p6/rSo+IntPgUDvWE+jNUm+JJTWE6z6HrZQlX6Vxo7gDpRGvjQoVtoTDox/89w4/60tpzC/vy
 ARpP3bo25qh0qY5VWdgqr+TzJsoK8V8VAXXc0hi5yElyFwFMHWgR4orxypL+9qeGGg/c7J/3g
 87bhrvJBiFN4QQRuuTcoCoH2Az8ZMu1ZMfa+7nrirrTVyb1NTMy0t2mC5eyuezKksSFRsWzmb
 tO9xMph/aEa0WYF76menNs4yMhgGUdmEgMXbrIAEzxwTn4vZUtOZftRLJphiOC6aTBEp93oSo
 2DDri4x64pBuVCdVWnGkcoeDFRdJ2rvtcXj1yUjOe+QVKfnhueAwY2IBT2DuvUpxTLabd+eqK
 NxAHjqZTTXqviKXPC+XrFOHHNUruxT+VTwk0HPehiYgmuRjubO5QWgGbT12T7d9i2hDtPp3ul
 /exx34mzMzex0OfnqAAE/FD+k5PJd22P86eTW05A3wPyBLqIh28GVDOFs8V9DDwyjOCRGPCCW
 8BMgvDZ6Q2QvpgA/l0QyaDLqv07Ev+oVCtuH3weKINLbY=

Am 07.11.24 um 07:02 schrieb Mario Limonciello:

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

Thank you for this patch series. The overall design seems good to me, but i think
you forgot to extend platform_profile_notify().

Thanks,
Armin Wolf

> ---
> v5:
>   * Adjust mutex handling
>   * Add missing error handling
>   * Drop dev member
>   * Add cleanup handling for module unload
>   * Fix crash on accessing legacy files after all drivers unloaded
>
> Mario Limonciello (20):
>    ACPI: platform-profile: Add a name member to handlers
>    platform/x86/dell: dell-pc: Create platform device
>    ACPI: platform_profile: Add platform handler argument to
>      platform_profile_remove()
>    ACPI: platform_profile: Move sanity check out of the mutex
>    ACPI: platform_profile: Move matching string for new profile out of
>      mutex
>    ACPI: platform_profile: Use guard(mutex) for register/unregister
>    ACPI: platform_profile: Use `scoped_cond_guard`
>    ACPI: platform_profile: Create class for ACPI platform profile
>    ACPI: platform_profile: Unregister class and sysfs group on module
>      unload
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
>    ACPI: platform_profile: Allow multiple handlers
>    platform/x86/amd: pmf: Drop all quirks
>    Documentation: Add documentation about class interface for platform
>      profiles
>
>   .../ABI/testing/sysfs-platform_profile        |   5 +
>   .../userspace-api/sysfs-platform_profile.rst  |  28 +
>   drivers/acpi/platform_profile.c               | 494 ++++++++++++++----
>   .../surface/surface_platform_profile.c        |   7 +-
>   drivers/platform/x86/acer-wmi.c               |   5 +-
>   drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>   drivers/platform/x86/amd/pmf/core.c           |   1 -
>   drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>   drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>   drivers/platform/x86/amd/pmf/sps.c            |   3 +-
>   drivers/platform/x86/asus-wmi.c               |   5 +-
>   drivers/platform/x86/dell/alienware-wmi.c     |   3 +-
>   drivers/platform/x86/dell/dell-pc.c           |  35 +-
>   drivers/platform/x86/hp/hp-wmi.c              |   3 +-
>   drivers/platform/x86/ideapad-laptop.c         |   3 +-
>   .../platform/x86/inspur_platform_profile.c    |   6 +-
>   drivers/platform/x86/thinkpad_acpi.c          |   3 +-
>   include/linux/platform_profile.h              |   6 +-
>   18 files changed, 488 insertions(+), 190 deletions(-)
>   delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>
>
> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2

