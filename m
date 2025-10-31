Return-Path: <linux-acpi+bounces-18388-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7FC22DB4
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 02:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C8594E8E7F
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B9225762;
	Fri, 31 Oct 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdtBVZx3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4261DE3DC
	for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873610; cv=none; b=ubinHMcQ9hIkA4h//qom9rJ2mD2TxbSaHm2lGHnCdr6vtlbCkK/FXdd7ZRKVXuhd+2HybOy5WREEzjU8hS1cxXzLdmqQUgajFZ8kY0MQhFqK3mt4zgvTxthNRLlxvFD277LSFo36aXl9tB0+fmPqkjAqNb2Fly+0PwvP9QY/xCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873610; c=relaxed/simple;
	bh=/R2PajZdpDBSilz28LyEbbHfwCWVmHXzyoDsVJ1DaIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PE2XAK5qSHIx9yS+YOiFrU0hw8W8ksTClKNfG7B1Y/o4+6vJX0zoxLDKzfXAAPZfkZ8u2YcwysqPZwSFiqnxYeKhpFztijYJJQKWVBS9GZ0FHyamErspvFWJAznH5eXGnRmTxLs8URPukt8Hmy8gBuQrzpyBStjeBpw4XADxfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdtBVZx3; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-81efcad9c90so18752526d6.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761873607; x=1762478407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLeeinn5rkLUxgKFdg/nWVzRKsFjkOZNlZH0y97MZCU=;
        b=TdtBVZx3S3WWl1giFExLb/1j0oOe+d90l0IUPf6QppfRJfzQ4bNhXWc0rppfECxXME
         8eCEXHa5pdjeuZ/bHtYRk1rq0qeve8kJjm602exTBrEJUwzBJEhsB3DSzazmigxlqcJr
         08e5MCZLp+1ZwZBK/j0wSRk4Hd9QfyoI1x6JIh03uYXJvOa5dDKoxrBGTYaxzrdunbWM
         ogSKPjNF3+Kl0uO256y80G02+dRLqwOJuIJvCCi53XnGlS6NxR2sRinLdkIHOucvEUWZ
         RKnSzKOR6HZVvCq0Lfse1d7uwu/YcMV+AdYKoa0Wh2KIOKxPQJhCdA+sCTzTwIWO/VPJ
         Uo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873607; x=1762478407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLeeinn5rkLUxgKFdg/nWVzRKsFjkOZNlZH0y97MZCU=;
        b=uOlI0+tLw50cG2U7LiNxuebyEvsrMPxX6snkifFDz4+/U8r+G4g6m+tp/MhzFmnoSf
         VKlVvA6GQcc9TC0kr5E76giiqqM6NmtgH0x97qCf4LR+RF9s5GnI+hDj/42dQ+uReCR7
         Ufxa6yPrWUFryr2yf1/ApE1FjNJwtYDorwS9xYk3/AXhQHiuVVn0YcUsSwWgbr+QMobC
         XwnwIjJpGz7jPh/ffXtlaYW8oOUyJK2RoOPUNQjFh8IybBBpB2WKvw6iKGaktf9xRH6d
         B3jPPOURp4EfV0hWRITMrsRIJAJ8Rw7H/37IYZWv6qVhfwwFKuhoBVVCxvbpQdm8tOG9
         H41g==
X-Forwarded-Encrypted: i=1; AJvYcCVeN9C5lzMaUsy4XiGtAsQmweS4jYVTqBKQKgNGKcFqR2YJkomI+fnrnxAbV2cV18fCUI/0ZIheHJiO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9b8jq/av8rJtKkMzLK/wrHSYd99gvCvtAVR2clvexkk0ivkRm
	79kIyCBjtKmLK9bqae/MGg5ox+pLMVxqJQPl/PiNqYqA/hWMa9fIpC8+2FGeFLIlTnqRCZvLkrE
	0xz7W01ogvWS8b4YKUQYarJgKmWrftJg=
X-Gm-Gg: ASbGncvbKv/mLBZiyPT+cpHX5WdKV0S20rRXJfTOgrMZdiK7A1MbPRJgy3+eWNGDswE
	Y47749LvDeCMqcMYUswcvhabPuwH2TZjc/3felUzGiG7RQ3Qu5JzxkV4knfMAwHzzaeVLzSTiFp
	hM5AmPyHY32HItRcFjylf//Gn2MKXKwvOg3kxEUjm+oJjdpwBG3uBWbhaEQ7JH8Lp265GdPxyTj
	upSUwZGdv/l5JY6WIlFDNA81pXtOKGlywmocnGOXDcuLL6cmUJIu11ecA9i7Q==
X-Google-Smtp-Source: AGHT+IEbmRcoqGcwNEI9wXZ/2Xuv9CNaJRoSUqwyug6wtC8Ip8PX7K9TgOV8xAA2brbHWRPkE+31xM/qKoRjdxWw6BI=
X-Received: by 2002:a05:6214:e45:b0:87c:20b5:6685 with SMTP id
 6a1803df08f44-8802f4f8ea0mr23094946d6.55.1761873606895; Thu, 30 Oct 2025
 18:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026081240.997038-1-derekjohn.clark@gmail.com>
 <20251026081240.997038-4-derekjohn.clark@gmail.com> <4c3a594b-7a57-4b5e-85c8-e9337d70c7e6@kernel.org>
 <1411B6CE-132B-4450-BB27-9ED44BD897B0@gmail.com> <e3f19e6b-9500-4283-aae8-24ebba2bbb60@kernel.org>
In-Reply-To: <e3f19e6b-9500-4283-aae8-24ebba2bbb60@kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 30 Oct 2025 18:19:56 -0700
X-Gm-Features: AWmQ_bkaD-yhBt9MtVyJSewcJAo2YppAMOaIyrkykyYKFDy53ykMkV-9krNHVmE
Message-ID: <CAFqHKT=brdboD_=kfCHqPza+gbHvAicWnY9vcCDhPb3YBLzTaA@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: lenovo-wmi-gamezone Use explicit allow list
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Zhixin Zhang <zhangzx36@lenovo.com>, 
	Mia Shao <shaohz1@lenovo.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Kurt Borja <kuurtb@gmail.com>, 
	platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 2:19=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
>
>
> On 10/26/25 2:22 PM, Derek J. Clark wrote:
> > On October 26, 2025 10:50:40 AM PDT, Mario Limonciello <superm1@kernel.=
org> wrote:
> >>
> >>
> >> On 10/26/25 3:12 AM, Derek J. Clark wrote:
> >>> The stubbed extreme mode issue seems to be more prevalent than previo=
usly
> >>> thought with multiple users having reported BIOS bugs from setting
> >>> "performance" when using userspace tools such as PPD. To avoid this e=
ver
> >>> being possible, make enabling extreme mode an explicit allow list ins=
tead.
> >>> These users will still be able to set extreme mode using the Fn+Q key=
board
> >>> chord, so no functionality is lost. Currently no models have been
> >>> validated with extreme mode.
> >>

Hi Mario.
> >> So what exactly happens when a user uses FN+Q to change to extreme mod=
e but it's now in the allow list?  Does it report as "custom" mode?

The affected user that originally reported this issue to me was able
to test. With the series applied he booted into Linux after setting
extreme in Windows. Both the legacy firmware interface and the new
class interface report "extreme" despite it not being available in the
profile options. He also reported expected behavior from the power
slider in KDE's PPD widget.

> > It turns out I got a correction after posting this that I'll need to in=
clude for v2. Extreme is never actually set using Fn+Q and can only be set =
in software. In that case, functionality is lost (though extreme should mat=
ch custom mode default values, so only slightly). The only chance this coul=
d happen realistically would be if a user switched from windows in extreme =
mode and then booted windows, since the setting is retained.

I got more amplifying information on this that explains the back and
forth confusion. In windows there is a toggle in the userspace UI that
can add or remove the extreme profile from the Fn+Q macro cycle, so
sometimes this scenario will be possible and sometimes not. I don't
see anything in the documentation for extreme mode toggling
specifically, but there is a toggle for custom mode in Fn+Q so that
could be a translation error or a mistake in the docs. I'll need to
get amplification from Lenovo on this, but adding it will also depend
on the series by Rong that adds capdata00 so I'll forgo adding the
toggle functionality in this series. Once Rong's series is accepted
and I can get amplification from Lenovo I'll submit another series to
add it as an attribute in the lenovo-wmi-other firmware-attributes.

> Is retaining the setting across reboots/OSes the "expected" behavior?
> Or should it be resetting to balanced at startup?

> If you set it explicitly to balanced when the module is loaded that
> would help to alleviate any of these corner cases.

This is expected behavior, and it can be set in BIOS manually as well.
I don't think changing this at driver load is necessary and would
probably be confusing to users who expect it to remain consistent.

> >
> > TBS, I'm asking some folks to test exactly that situation so we can kno=
w definitely. My assumption was that it would report extreme normally but n=
ot be setable.
> >
> >> I feel like this is going to turn into an impedance mismatch.  I'm lea=
ning it's better to just expose extreme mode so that userspace knows what's=
 actually going on.
> >
> > It's possible, I'll wait for confirmation of the behavior from someone =
with the affected hardware.
>
> OK.
>
> >
> > Thanks,
> > Derek
> >
> >> I feel the bug situation will actually improve because PPD and Tuned h=
ave no idea what extreme mode means so it won't be "easy" to get into it.  =
This at least will allow discovery of BIOS bugs as well that can then get r=
eported and fixed in BIOS.

I'm leaning towards the original deny list now because of this as
well. I'll drop patch 3 for v2 unless Armin or Ilpo have a
disagreement.

Thanks,
Derek

> >>
> >>>
> >>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> >>> ---
> >>>    .../wmi/devices/lenovo-wmi-gamezone.rst       | 10 +++---
> >>>    drivers/platform/x86/lenovo/wmi-gamezone.c    | 33 ++-------------=
----
> >>>    2 files changed, 8 insertions(+), 35 deletions(-)
> >>>
> >>> diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Docu=
mentation/wmi/devices/lenovo-wmi-gamezone.rst
> >>> index 6c908f44a08e..79051dc62022 100644
> >>> --- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> >>> +++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> >>> @@ -31,11 +31,11 @@ The following platform profiles are supported:
> >>>    Extreme
> >>>    ~~~~~~~~~~~~~~~~~~~~
> >>>    Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" p=
rofile
> >>> -enabled in their BIOS.
> >>> -
> >>> -For some newer devices the "Extreme Mode" profile is incomplete in t=
he BIOS
> >>> -and setting it will cause undefined behavior. A BIOS bug quirk table=
 is
> >>> -provided to ensure these devices cannot set "Extreme Mode" from the =
driver.
> >>> +enabled in their BIOS. For some newer devices the "Extreme Mode" pro=
file
> >>> +is incomplete in the BIOS and setting it will cause undefined behavi=
or. To
> >>> +prevent ever setting this on unsupported hardware, an explicit allow=
 quirk
> >>> +table is provided with all validated devices. This ensures only full=
y
> >>> +supported devices can set "Extreme Mode" from the driver.
> >>>      Custom Profile
> >>>    ~~~~~~~~~~~~~~
> >>> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/pla=
tform/x86/lenovo/wmi-gamezone.c
> >>> index faabbd4657bd..0488162a7194 100644
> >>> --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> >>> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> >>> @@ -47,10 +47,6 @@ struct quirk_entry {
> >>>     bool extreme_supported;
> >>>    };
> >>>    -static struct quirk_entry quirk_no_extreme_bug =3D {
> >>> -   .extreme_supported =3D false,
> >>> -};
> >>> -
> >>>    /**
> >>>     * lwmi_gz_mode_call() - Call method for lenovo-wmi-other driver n=
otifier.
> >>>     *
> >>> @@ -241,31 +237,8 @@ static int lwmi_gz_profile_set(struct device *de=
v,
> >>>     return 0;
> >>>    }
> >>>    +/* Explicit allow list */
> >>>    static const struct dmi_system_id fwbug_list[] =3D {
> >>> -   {
> >>> -           .ident =3D "Legion Go 8APU1",
> >>> -           .matches =3D {
> >>> -                   DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >>> -                   DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1")=
,
> >>> -           },
> >>> -           .driver_data =3D &quirk_no_extreme_bug,
> >>> -   },
> >>> -   {
> >>> -           .ident =3D "Legion Go S 8APU1",
> >>> -           .matches =3D {
> >>> -                   DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >>> -                   DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1=
"),
> >>> -           },
> >>> -           .driver_data =3D &quirk_no_extreme_bug,
> >>> -   },
> >>> -   {
> >>> -           .ident =3D "Legion Go S 8ARP1",
> >>> -           .matches =3D {
> >>> -                   DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >>> -                   DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1=
"),
> >>> -           },
> >>> -           .driver_data =3D &quirk_no_extreme_bug,
> >>> -   },
> >>>     {},
> >>>      };
> >>> @@ -278,7 +251,7 @@ static const struct dmi_system_id fwbug_list[] =
=3D {
> >>>     * Anything version 5 or lower does not. For devices with a versio=
n 6 or
> >>>     * greater do a DMI check, as some devices report a version that s=
upports
> >>>     * extreme mode but have an incomplete entry in the BIOS. To ensur=
e this
> >>> - * cannot be set, quirk them to prevent assignment.
> >>> + * cannot be set, quirk them to enable assignment.
> >>>     *
> >>>     * Return: bool.
> >>>     */
> >>> @@ -292,7 +265,7 @@ static bool lwmi_gz_extreme_supported(int profile=
_support_ver)
> >>>             dmi_id =3D dmi_first_match(fwbug_list);
> >>>     if (!dmi_id)
> >>> -           return true;
> >>> +           return false;
> >>>             quirks =3D dmi_id->driver_data;
> >>>
> >>
> >
>

