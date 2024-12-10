Return-Path: <linux-acpi+bounces-10070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F09EBDE9
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 23:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F301667D2
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50FD1EE7BC;
	Tue, 10 Dec 2024 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F0+NbxGx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F32451C7
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870152; cv=none; b=aSvHl3L8v7fkG+6x+8FZjcvJXK7saZf2VcU4KOuSWNCpa4wDhVRHd1Ndz34i7uzOofDtAB5G+hWN/WTkReztSTVBdERdmM0+yALl+I1D7tOfeFYYDYFrs7fxtUBsZVfKDb4hy5JY6n40/VKGTVCNHgm6X+Zl1nXIlY5ENQyxSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870152; c=relaxed/simple;
	bh=tvt3zv+eF6/MbzKSgaDb44zYstTrL0JwPAz1hDN8QLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnJc//1iqLiqAKyYk7D+WZ0LwhVNkZD5jmDbAB34VLhHpYSgq7FHbWTqHgVWgS4GZSJaqP9dPZxP/bjWeKlMmy3hfS1oaY6I73R6RKC0kP7yW1OBvXRrSbqvPX5PBrBZjKP/Q2m3VWUlJQEmvR+jn6KyL6GG9obTDVIRrT8Q1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F0+NbxGx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728ea1573c0so780404b3a.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 14:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733870150; x=1734474950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SegVvC3hp1egRino8jTe24lodQ7Lif4l65T8hABKrm0=;
        b=F0+NbxGx72KEK+x3QzGnM4NLoRarvb7vZ8eyI7JWXeGCqXTMXaujVlAeUw3Ngccd/X
         r25iG1CJB3/o+sRfyYnm0K765Fdc4CLL1VpsQxsJYEignk9AhY3bvcIKSSnyLN19fLV4
         WNDIBIrI75h8lIWBbBZAbA2fwm/8aRjV29OHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733870150; x=1734474950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SegVvC3hp1egRino8jTe24lodQ7Lif4l65T8hABKrm0=;
        b=Epct5k0xUfSXkYdd6tMVCMbZVxpRjcyjeQ/JDXoJktZMzThKzeNevOOOJb/rSr0D1i
         F7gKvUpZdQ3E2Ci7XNQMx78qt63kQemPCNdk+rQVZB3rKAbKJniWzHICsZ2Bpijr4wgG
         f3PBqgx+KV+IXQCiaMHnoDIFytmtwP9D05mqKt9RuTliKCVGIhBwhQBKeGf0I9yU4PxD
         09Eadi0wgPaIJzIxF1zJmR9NI1kw5/9tjH6CqMOkLJYQpSVInZ8qLuBI6YTZZunUBXM1
         rt7j+UTlMYZ/Zrt30i5SIhnHmWn66Klz/24P1ZQH3Ojvoz+EhtSnFy6+lt0rIlgN0BHM
         UmZg==
X-Forwarded-Encrypted: i=1; AJvYcCXj7GEtufZ1OkQg/3VIrbe8LlZ/kEKd8g1icKW3hbvt/3LhUxmQ1ntXJjsE9Z3sG7yWuYmYpTEQAKnZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRaRJ7atM05zJndNsdKy2iDtPy9IbtX4CPTXNN2/twy4FTpEJ
	ClZDHbWWtj9AH6CdNVxMS1Sf4HVfU5b+G8leSaKTZhTX//AF1sQ7FKxWVqJMiEbrX8NUW4l7Bzs
	=
X-Gm-Gg: ASbGncuz4zjvYQPnJe1+cy/RxCEPBue+cAVBzZaVMF0blTEu2PL0BtBXgN5pfUDQnb8
	iTlWAWLyagLmJ5NlI3pZ01bcjcZ5pECGc6BN09/W/7hwIICeq0jIVo3YbruQBaqH3z2rsE32Kdu
	CYSaWXMpldDnImC2QkAdhNlSGKv4pX+8EDEAXUikU8yPp0DIDHs6cHHzCaUIRBNlIcu2ainhdWx
	TO0T/RJ1ym+GWYpAnnEu6tp8RNO512hzmEWW9+MkcuR0OQTQx5VvqeveiNVrH83VbeMvlajxr5b
	315oxFZTkJ7HfwAEfPEY
X-Google-Smtp-Source: AGHT+IHFImOvoqZvepZ6ydG1MvXCL/wcJSvYTEAyciHLt7g+REpwiwjuqM8uDUyZatH9pzcaXFLmaw==
X-Received: by 2002:a05:6a21:78aa:b0:1e1:b1bb:87a0 with SMTP id adf61e73a8af0-1e1c13832e8mr1180328637.34.1733870150472;
        Tue, 10 Dec 2024 14:35:50 -0800 (PST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725db650e00sm6129881b3a.187.2024.12.10.14.35.48
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 14:35:48 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fd5248d663so2117357a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 14:35:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPKywoT7gV/qxtVBC797FKR7bBC7D2ae2qPZqkACKIqUsufxPy/XWelpsoEm+0/tVhavizqv7yGap7@vger.kernel.org
X-Received: by 2002:a17:90b:1c08:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-2f128032323mr929730a91.27.1733870147516; Tue, 10 Dec 2024
 14:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org> <Z1isHpuHqHSX-jHd@kekkonen.localdomain>
In-Reply-To: <Z1isHpuHqHSX-jHd@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 23:35:35 +0100
X-Gmail-Original-Message-ID: <CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
X-Gm-Features: AZHOrDk0jwuT4BPdDBgtbco-BoT1AXVUFGOsS3tfXUhEEPMwjjkEUWAtW-dj0G0
Message-ID: <CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 22:01, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:56:03PM +0000, Ricardo Ribalda wrote:
> > Provide an implementation of acpi_device_hid that can be used when
> > CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/acpi/acpi_bus.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 4f1b3a6f107b..c25914a152ee 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> >
> >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> >
> > +static inline const char *acpi_device_hid(struct acpi_device *device)
> > +{
> > +     return "";
> > +}
>
> I wonder if any caller might expect something of a string if provided?
> Valid _HIDs are either 7 or 8 characters whereas the proper version of the
> function returns "device" when one cannot be found (dummy_hid in
> drivers/acpi/scan.c). Unlikely to be a problem perhaps.

Good point. I changed it to return "device"

Thanks!

>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> > +
> >  static inline acpi_status
> >  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
> >  {
> >
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

