Return-Path: <linux-acpi+bounces-14279-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4BDAD4362
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 21:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B641C3A529D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6030F264A9D;
	Tue, 10 Jun 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPHJbBUP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182B2652A4;
	Tue, 10 Jun 2025 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749585501; cv=none; b=eordKPgfzGm2J2aLoztHVFVxdTLSh8iX7jyzDc75mxeXON/SMTiMVtPXraNX0J+08oWsXE6GZE7TLbB68NydTnlvDahcakCRvCZLbvfuPI9XtFVuvW/r0R2DclY9JvMf7dfHvYd0b8dI5Th5heq5zQh6axfyhzwXgGcb6qoXlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749585501; c=relaxed/simple;
	bh=7e/EGtYeLe3KYmuJolZr95z5krcUt1zgBSfn2PjSeDI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=it0dyRdJkngdAyr0uAaSBb+W1NH2t1ALwmG/FH0Ngj0RNJDeI++WJG0WxK+KvXiU8wNQh4agtx2g2MtjuIU0waqzdJUZXwYjB9QesTDEUKH9eeY49C+fH70hVMEmO9M4PrnvVEAjVs97NS4x+lu3/FisWzJvzT18tkB/zKjl+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPHJbBUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24815C4CEED;
	Tue, 10 Jun 2025 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749585499;
	bh=7e/EGtYeLe3KYmuJolZr95z5krcUt1zgBSfn2PjSeDI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=sPHJbBUPB8JKR5dDmXdoaSIqn5CVNSPvuULL2uP+8ErRHbWWgbKf3n4iHSGZbObg9
	 W+UO1ksOYSbfLAHCFa0tP2OF6G4XGkhzLY3bGy2U6S+Yf8rXs/ZImP8QAj90x7+Wyz
	 Gmc7TQgl7dm/DhnDSUMrqU/M9/Jl3KejBmC7sVSAlODPh8C4NwLcaJTyWcevPEvyP9
	 v1jcE0BbY6Ploik3mum20vWRGC2igiZXX3fym0EHSqASkl5g06j79ftrbquF8wlE2C
	 lziaPQaRdZ8lazYQqSIDkXTF4RbxKCzIm18vw126fZCf5JwunXrUrHwvPZfx6BjMMG
	 4SMXJYJOAyB4w==
Date: Tue, 10 Jun 2025 21:58:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
cc: j@jannau.net, Arnd Bergmann <arnd@arndb.de>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] HID: lenovo: Remove CONFIG_ACPI dependency
In-Reply-To: <4262d612-f929-4d62-baf3-c334ff46d30f@gmx.de>
Message-ID: <p3ps345p-6173-040r-4298-rn34697932p0@xreary.bet>
References: <20250519-hid_lenovo_acpi_dependency-v2-1-124760ddd6f7@jannau.net> <4262d612-f929-4d62-baf3-c334ff46d30f@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 May 2025, Armin Wolf wrote:

> > The hid-lenovo driver supports external Bluetooth and USB devices which
> > can be used with non-ACPI systems/kernels. Call platform_profile_cycle()
> > only if CONFIG_ACPI_PLATFORM_PROFILE is enabled and select
> > CONFIG_ACPI_PLATFORM_PROFILE only if ACPI is enabled.
> > This should not affect functionality since only the detachable keyboard
> > of a x86 tablet with a custom connector has an hotkey for cycling
> > through power profiles.
> >
> > Fixes: 52572cde8b4a4 ("HID: lenovo: select CONFIG_ACPI_PLATFORM_PROFILE")
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> > hid-lenovo supports external generic USB and Bluetooth devices and
> > should be buildable and usable on non-ACPI kernels and systems. Commit
> > 84c9d2a968c82 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd Fn
> > keys") added a hot key to cycle through power profiles using ACPI's
> > platform_profile. This resulted in adding a dependency on ACPI and
> > selecting CONFIG_ACPI_PLATFORM_PROFILE to fix build an link errors in
> > commit 52572cde8b4a ("HID: lenovo: select
> > CONFIG_ACPI_PLATFORM_PROFILE"). This is undesirable for HID drivers
> > supporting generic USB and Bluetooth devices. So instead call
> > platform_profile_cycle() only CONFIG_ACPI_PLATFORM_PROFILE is enabled
> > and select the latter only if ACPI is enabled.
> >
> > Supercedes with Armin Wolf's "ACPI: platform_profile: Add support for
> > non-ACPI platforms" [1] the earlier removel in "HID: lenovo: Unbreak
> > USB/BT keyboards on non-ACPI platforms" [2].
> >
> > [1]:
> > https://lore.kernel.org/linux-acpi/20250518185111.3560-1-W_Armin@gmx.de/
> > [2]:
> > https://lore.kernel.org/linux-input/20250512-hid_lenovo_unbreak_non_acpi-v1-1-e9e37ecbfbfe@jannau.net/
> > ---
> > Changes in v2:
> > - drop stub platform_profile_cycle()
> > - call platform_profile_cycle() conditioanlly
> > - drop 'depends on ACPI || !ACPI'
> > - Link to v1:
> > https://lore.kernel.org/r/20250518-hid_lenovo_acpi_dependency-v1-0-afdb93b5d1a6@jannau.net
> > ---
> >   drivers/hid/Kconfig      | 3 +--
> >   drivers/hid/hid-lenovo.c | 6 ++++--
> >   2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index
> > a503252702b7b43c332a12b14bc8b23b83e9f028..1656bb1504f750d73011d3f008e27b4436a58678
> > 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -595,8 +595,7 @@ config HID_LED
> >   
> >   config HID_LENOVO
> >   	tristate "Lenovo / Thinkpad devices"
> > -	depends on ACPI
> > -	select ACPI_PLATFORM_PROFILE
> > +	select ACPI_PLATFORM_PROFILE if ACPI
> >    select NEW_LEDS
> >    select LEDS_CLASS
> >    help
> > diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> > index
> > af29ba840522f99bc2f426d4753f70d442cef3af..73c6a26638a22ad1c8368112e8ab185232a9df12
> > 100644
> > --- a/drivers/hid/hid-lenovo.c
> > +++ b/drivers/hid/hid-lenovo.c
> > @@ -728,9 +728,11 @@ static int lenovo_raw_event_TP_X12_tab(struct
> > hid_device *hdev, u32 raw_data)
> >      if (hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB) {
> >       report_key_event(input, KEY_RFKILL);
> >       return 1;
> > +			} else if (IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)) {
> > +				platform_profile_cycle();
> > +				return 1;
> >      }
> 
> Please turn the "if else" into a single "if":
> 
> 	if (IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)) {
> 		platform_profile_cycle();
> 		return 1;
> 	}
> 
> 	return 0;
> 
>  With this being done:
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Makes sense; Janne, are you planning to send updated patch, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs


