Return-Path: <linux-acpi+bounces-9504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5269C625E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 21:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C411F213B5
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336EA218D68;
	Tue, 12 Nov 2024 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auQSndQ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616D19F115;
	Tue, 12 Nov 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442610; cv=none; b=U45Xg3j/TBnomAJYnK9BxwxK1C1L8mIvnJunhDCjuOkbZcu/RDk+tg2HD/f+9HaZNaBuhCMypADFjJ3rQ04VxXcj+JLnv/wxfSBJfJRTvEB2rqdMzwkUt9NgYkzT65044UAJQzP1qw9BQ0IYREgq6LtxyOgPkYFZE4C6d36N0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442610; c=relaxed/simple;
	bh=SS/rjAXPtHfu1bb9tzPEZAUs5OUMggHetyMYQXeht2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7iu9tEhFCrgyVa6Je+VHaxiFt3OH6glt9S/+R1kR9ei53H7o+kl0brnejz98yDwmHT2YG9ydZtW8xr3gDYCKE9kLMMNEwV3FTHZFRH7WG6nd1gAKTTL1fKXH1sMKdbPxXo8QphiYfP9HiD1/21PsisjAV7StGdMFHHGHuyOCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auQSndQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB76C4CED8;
	Tue, 12 Nov 2024 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731442609;
	bh=SS/rjAXPtHfu1bb9tzPEZAUs5OUMggHetyMYQXeht2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=auQSndQ7pmBKqUbxPMPXjaW8kj7UDtrLfTzHIGvSe2+Pvc5qNErEzR7comGF6Hc3b
	 c7hvZzDcSsmNDR6Js30Fx3G6ftnWCgVPIAAvNR+qL4ihQh3A4OAg0g3BLPDnXukg/4
	 339k8V3MaAmcPf48pMy5L2HWma17f08kig5R49l1C2zItuXFkwHOoqKSYH+0k1ISTl
	 vnFaCj+PPkje6in9gONW28TpLPPUtfNIuHipAPASy5twpvzXTpbEc9Qijoz9TR/Af8
	 jMYeiYxP51ubQxovywHIMEsJdIqfbwkSKQDlx8uqaOeqo4YY7FHnhvvR1m6SHqBTsu
	 KXf+kndc/oCWA==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7181b86a749so2697125a34.3;
        Tue, 12 Nov 2024 12:16:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXN9saMb096f/A7QU7jEjunEqRhLMrMnrJ5kVLrOSXOdbLW01sCdhxkxYfnZOVvdQEleNSNYlHwWyhP@vger.kernel.org, AJvYcCXZXIiS+k1R7pw4YLRETCyF7pdX60lOYJbbmgfG2vsrPFhayWhvDBtljNMzx/9rWbJ70WspK9ncUdn0eAYn@vger.kernel.org, AJvYcCXi8ZGhOQwONukQzBIEJSs4aKX5g92x0e6YEtR+jOetHdCP3oo47LhcB/JXOhWV8L8rnzlPjEjLdKTmUEtXBjSL+lnjwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WvzBoRwU6xZkwZfKUIMYsORNU++ydA+LwbIfRy6YqqsOzgwX
	fNubvKnsYXP/fMEB7hcw0C2itoWT9x21MEqTxZ5nJCH0V+pXpt61rqZqyJDPIunF63TGUBrsclA
	crz7G1dH6nq2bFr1fMRdJ7qXE0Uw=
X-Google-Smtp-Source: AGHT+IH/JnJpO5YQfQKUNDwekjJUjo6v6sqC4pmMl3hn+ZnZhzkr5nmVDlDnDh840H/gbeKpvSjgdRrOVbFJlVofLXY=
X-Received: by 2002:a05:6830:6c0c:b0:710:fef4:3c92 with SMTP id
 46e09a7af769-71a1c288988mr17676536a34.21.1731442608496; Tue, 12 Nov 2024
 12:16:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109044151.29804-1-mario.limonciello@amd.com>
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 21:16:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gaNKKbf29WD5keQxJdgP93P_iWiQMwp7cOL9NCUumeZA@mail.gmail.com>
Message-ID: <CAJZ5v0gaNKKbf29WD5keQxJdgP93P_iWiQMwp7cOL9NCUumeZA@mail.gmail.com>
Subject: Re: [PATCH v6 00/22] Add support for binding ACPI platform profile to
 multiple drivers
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D . Jones" <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alexis Belmonte <alexbelm48@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, 
	"open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>, 
	"open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Matthew Schwartz <matthew.schwartz@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 5:42=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Currently there are a number of ASUS products on the market that happen t=
o
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
> ---
> v6:
>  * Add patch dev patch but don't make mandatory

Probably a typo?

Which patch is it, BTW?

In any case, if the merge window for 6.13 starts on the upcoming
weekend, which is likely to happen AFAICS, I'll defer applying this
series until 6.13-rc1 is out.

It's larger and it's been changing too often recently for me to catch
up and I'll be much more comfortable if it spends some time in
linux-next before going into the mainline (and not during a merge
window for that matter).

>  * See other patches changelogs for individualized changes
>
> Mario Limonciello (22):
>   ACPI: platform-profile: Add a name member to handlers
>   platform/x86/dell: dell-pc: Create platform device
>   ACPI: platform_profile: Add device pointer into platform profile
>     handler
>   ACPI: platform_profile: Add platform handler argument to
>     platform_profile_remove()
>   ACPI: platform_profile: Pass the profile handler into
>     platform_profile_notify()
>   ACPI: platform_profile: Move sanity check out of the mutex
>   ACPI: platform_profile: Move matching string for new profile out of
>     mutex
>   ACPI: platform_profile: Use guard(mutex) for register/unregister
>   ACPI: platform_profile: Use `scoped_cond_guard`
>   ACPI: platform_profile: Create class for ACPI platform profile
>   ACPI: platform_profile: Add name attribute to class interface
>   ACPI: platform_profile: Add choices attribute for class interface
>   ACPI: platform_profile: Add profile attribute for class interface
>   ACPI: platform_profile: Notify change events on register and
>     unregister
>   ACPI: platform_profile: Only show profiles common for all handlers
>   ACPI: platform_profile: Add concept of a "custom" profile
>   ACPI: platform_profile: Make sure all profile handlers agree on
>     profile
>   ACPI: platform_profile: Check all profile handler to calculate next
>   ACPI: platform_profile: Notify class device from
>     platform_profile_notify()
>   ACPI: platform_profile: Allow multiple handlers
>   platform/x86/amd: pmf: Drop all quirks
>   Documentation: Add documentation about class interface for platform
>     profiles
>
>  .../ABI/testing/sysfs-platform_profile        |   5 +
>  .../userspace-api/sysfs-platform_profile.rst  |  28 +
>  drivers/acpi/platform_profile.c               | 537 ++++++++++++++----
>  .../surface/surface_platform_profile.c        |   8 +-
>  drivers/platform/x86/acer-wmi.c               |  12 +-
>  drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>  drivers/platform/x86/amd/pmf/core.c           |   1 -
>  drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>  drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>  drivers/platform/x86/amd/pmf/sps.c            |   4 +-
>  drivers/platform/x86/asus-wmi.c               |  10 +-
>  drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
>  drivers/platform/x86/dell/dell-pc.c           |  36 +-
>  drivers/platform/x86/hp/hp-wmi.c              |   8 +-
>  drivers/platform/x86/ideapad-laptop.c         |   6 +-
>  .../platform/x86/inspur_platform_profile.c    |   7 +-
>  drivers/platform/x86/thinkpad_acpi.c          |  16 +-
>  include/linux/platform_profile.h              |   9 +-
>  18 files changed, 553 insertions(+), 213 deletions(-)
>  delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>
>
> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
> --
> 2.43.0
>

