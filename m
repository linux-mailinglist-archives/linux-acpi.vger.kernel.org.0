Return-Path: <linux-acpi+bounces-18163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295BC03127
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 20:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C3D3B06C9
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 18:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95F2836A6;
	Thu, 23 Oct 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLCV8LWz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2935B120
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245478; cv=none; b=Pbdxv6w0kScnt2d5tgqxELKBLYlMj+sKYgSKv7gAOd0zIC0bLYgDh/HZ227J0eZpmBoGFCW6eWKjAzKlQzhqAj97xESRbBbsWvyelaB/Bnmib+B850hHqzqEYTSrU2baV/3sZq6KPTZ0EZn4WG/6mDFFZLu5xxgfIGbz7NEk5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245478; c=relaxed/simple;
	bh=yclZU/krkrcJNTHYs1a/Ose0CM2p4xAA1NpE1Z5NhIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncWS1HjuCaau4YlA9myFCLg6+T4uzemplLSSUjE/gwbPBUJ9sAfbxofSG2DwtrFAPP+eA63hreWfiCM4DMjYGJWqu8BEG66PWDvbV0lEYEuOa0qtEDUZID4EeIUwkPPDJooY1vRa8rhvg6AjlLwDa5FTK3rsC6vrxpoCTZlAyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLCV8LWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D1AC4CEFF
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761245477;
	bh=yclZU/krkrcJNTHYs1a/Ose0CM2p4xAA1NpE1Z5NhIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iLCV8LWzS4UN3Z9BHsVcf5a7TKcGBu+Yjy3+DaKJlCpnb03GOxOJII3OJPzClah4L
	 eg1LiHmosSP9xvVqoVk6lEN0/I5pRTWssMJCXzR/VgV7v9F353Psu+qGG1D4c/esgd
	 tRqBB7E00TdhNWFLC5FFWkPQ3doOEBdIPmm2FnCM6ACNNvaYSJ8euiDq7kdpwfBaGz
	 J8Er5yY7wamW+7FgQ4NAaWsKJuMwEOaad1R3pYuS47l+O4/Eh4PVvMuHTwjeGZY9v6
	 TBMvwoSS6793xMPRh3KGDTYhpUmODTTmjM3M2K4ktjf+kYMosa12iLJvnvyq0e67E+
	 IWZc/8Y5sli6g==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-64a6cff75e9so336314eaf.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 11:51:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiKqiDWgEncMS1h7gxlXgDBt6RAMbcB5y4IZz7zyKcvCoeeEXzqFGjGo0UopkRE3j7D3PpKxVi4Xvi@vger.kernel.org
X-Gm-Message-State: AOJu0Yztz2oxL5KqOBEYjrWcTafFgbsRCARylvI5Pankrufk9FJ7UYEk
	vFnQjKcW96WmW104D9jsRbSULVFyOJ6hNfI9ucD7OIEyL4jGDFgDEZXs6WyEy0Re2KnqRYewVFT
	srokG2f45OyhRsTOyIApj6RRW78jBzPQ=
X-Google-Smtp-Source: AGHT+IEGlrA2tIZjRTjUxrWjNMeSXBMeR/3TmzD7/9IyoNmW9DR5dApIhJs1FEbo3ID9rck8DzYQhLSwBbOSCMybCuE=
X-Received: by 2002:a05:6870:2b12:b0:36d:287c:694f with SMTP id
 586e51a60fabf-3c98d0c76ffmr12646634fac.30.1761245477276; Thu, 23 Oct 2025
 11:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022200704.2655507-1-danisjiang@gmail.com> <83852558-0fdc-493c-8f44-95356480c8aa@kernel.org>
In-Reply-To: <83852558-0fdc-493c-8f44-95356480c8aa@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 20:51:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hZaOALPUB63zqSJt+3E82YM=oU6d08UitHWcuc2iMDSA@mail.gmail.com>
X-Gm-Features: AS18NWDFl2L0oQKDod5Y7100pSGWoUy5AMpurCSHDpagcdmJhEBc9g6yX1gWlo4
Message-ID: <CAJZ5v0hZaOALPUB63zqSJt+3E82YM=oU6d08UitHWcuc2iMDSA@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
To: Hans de Goede <hansg@kernel.org>, Yuhao Jiang <danisjiang@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:25=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Hi,
>
> On 22-Oct-25 10:07 PM, Yuhao Jiang wrote:
> > The switch_brightness_work delayed work accesses device->brightness
> > and device->backlight, which are freed by
> > acpi_video_dev_unregister_backlight() during device removal.
> >
> > If the work executes after acpi_video_bus_unregister_backlight()
> > frees these resources, it causes a use-after-free when
> > acpi_video_switch_brightness() dereferences device->brightness or
> > device->backlight.
> >
> > Fix this by calling cancel_delayed_work_sync() for each device's
> > switch_brightness_work in acpi_video_bus_remove_notify_handler()
> > after removing the notify handler that queues the work. This ensures
> > the work completes before the memory is freed.
> >
> > Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a =
brightness up/down keypress")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
> > ---
> > Changes in v3:
> > - Move cancel_delayed_work_sync() to acpi_video_bus_remove_notify_handl=
er()
> >   instead of acpi_video_bus_unregister_backlight() for better logic pla=
cement
> > - Link to v2: https://lore.kernel.org/all/20251022042514.2167599-1-dani=
sjiang@gmail.com/
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hansg@kernel.org>

Applied as 6.18-rc material, thanks!

> > ---
> >  drivers/acpi/acpi_video.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 103f29661576..be8e7e18abca 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -1959,8 +1959,10 @@ static void acpi_video_bus_remove_notify_handler=
(struct acpi_video_bus *video)
> >       struct acpi_video_device *dev;
> >
> >       mutex_lock(&video->device_list_lock);
> > -     list_for_each_entry(dev, &video->video_device_list, entry)
> > +     list_for_each_entry(dev, &video->video_device_list, entry) {
> >               acpi_video_dev_remove_notify_handler(dev);
> > +             cancel_delayed_work_sync(&dev->switch_brightness_work);
> > +     }
> >       mutex_unlock(&video->device_list_lock);
> >
> >       acpi_video_bus_stop_devices(video);
>

