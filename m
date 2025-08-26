Return-Path: <linux-acpi+bounces-16058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B72B34FEB
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 02:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FA21B2265C
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 00:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A011548C;
	Tue, 26 Aug 2025 00:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGT4Kb8X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F52EAF9
	for <linux-acpi@vger.kernel.org>; Tue, 26 Aug 2025 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166623; cv=none; b=QCFjLT6Kdtuy47mODUiPWZXY0CcmLY4efEEoWiUWeHizoOZS91qVS9aAnqWPaxhnv4Y/znmbOrAG8pblVTJXw10Zaf/EGLvQsum3Z+5+o6NNKOH64Qq1kP/PBRg2BkqY3NK29uhX6MdVe1WXfnqS6B2VJN38y1Q4wzD9dmyx4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166623; c=relaxed/simple;
	bh=cbg//jCx9UEMU6IgD5fa0/vfNwsndCZx54KubtM8yOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDUEF8ARKvUKiHvajXGG/yRIGoTluEEuaJS1vnZfP74UbH+jte8DK+4ay84P9kx81yJ3qZRDJiINrcYwdPP9bqUQ1vgihUj/MNk2qYxl+QoxyeLO4yrAhKd67zZNJEK1l955mXEfoQQWwrDbfOJ3RH+p4jEEJUg8kVGW4+7u9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGT4Kb8X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459fc675d11so21135e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 17:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756166620; x=1756771420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp0X3104SBCDge2qa7nzeQhf8jC5G3xyTNrHUAomQTs=;
        b=nGT4Kb8X4oMKd1fgNFADF4Wv89+riM64mJ++HTQqPqXKM2ilwTvtCp/eb9zlVoRnVs
         fKhCUszXnu1FmX3t+Bi+OgIKHAQYrsVBVrA67eDy3X6dDleYRdiQwDbwXspSL/s1wDU2
         VBCOxYfeuMoGcatdNIYeAN2TMtoiHAtd0Vq1LWUedOMVgQhFLca2wlWvDucRm1LnPPyK
         4EiVU9a7cIx4eCrJClErBv6EYJJgXqD4alu0l4KOlR1r+0o+6i6oBOqTzyuTf7yKXjZs
         +KOH0uWYZwGLbjtK7yj5fbNEjfe8JAWx4I/NhVDLeDU2eZ+J+p+IX+66KpayAAUuVNBv
         h5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756166620; x=1756771420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp0X3104SBCDge2qa7nzeQhf8jC5G3xyTNrHUAomQTs=;
        b=d+8XHtr3d/zqhy1M0e2/lccqhCcgtkvvUjVT1GHSGexR37yI8D6g1j69IxS4LVNXRq
         mIFXvE4tOmz2X+B8JX6zpA44HpHGjsbUuHa8ioHkOAaPUg3+3lB5XzzaQbaU4zDrLg9R
         BD94aTGNZRA5CUP8TXjOiR5UFCD5XPzMlwlWMs9rnMYzk2pG/UAan++2qLilc7Py6+s8
         VXxh6KBGGrWephX/umZOrCnTEo9rN9TnEbm3lrWDuKen29g2GLEs+5l2FLPZGnICXPRa
         S+nTQNwg7F70HVb0CkpDG0pZl7Lfx9oDTboF6VH/duM1J5tviOYPdRHxugIi1fFnCM9N
         l7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUxjvZrKz361oFQiFai8K66ky07YhBeZqJywDvwK4Rb80KWnnpuFOZ/OvNhbRPTHyVag/S73s4J61B+@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXD2zlTc+yALr9W2rZuAemgPXJdaRxwGJN5j4Gfo9X+tXsqnU
	J9o9aUdZAUcF4UY05Al5Pdgiydfa0dsO7XP+GhvYl/SlS8IhWZC/mgoXJS4pIUEfNdJVhQ7lii0
	y0zTnDZrkQHb4TiCOT3c2m67xMTmGqvO8CMl5O1pv
X-Gm-Gg: ASbGnctwQMB8J7Hvl0OaPE5sEsH1jwCO0HAEf8Uu/n5XI5nRzIXzRNdk5gyIIE2gwyY
	XCJYwEg+KGhxj7gtrUUGkA7UUrQ2Hi0+0Y/Ud1LRKwRHF6ZZg3YYWg255p7/kiGp3qMCpdEn6UK
	CLXRGyb4mCfY8uuUEKVFjDHK2qTw5hrm8k25gU9SxoQ0R/wT50ym1h6bflOu7VqK8buUx+3KTIb
	a9IHif9rfrxW/3Px4rk925iE7hvQxPwKSm/gocOLf50
X-Google-Smtp-Source: AGHT+IHSgB+bYb4MI+mf1DCxTNsoVXDLl1N8W8tMqDfT1PKvMXvIjgarLk+h9LijUfSFFdk18Y0rx025r4yfmrbjnp4=
X-Received: by 2002:a05:600c:a408:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45b66a2b6b4mr238495e9.2.1756166620039; Mon, 25 Aug 2025
 17:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825223348.3780279-1-jiaqiyan@google.com> <aKzuCobhkx9X-axW@agluck-desk3>
In-Reply-To: <aKzuCobhkx9X-axW@agluck-desk3>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 25 Aug 2025 17:03:28 -0700
X-Gm-Features: Ac12FXwg9TWLkI45dLcPuLwhOhMpZNUrFkczfls3rp0PRG3DYIHiYtDOlsRM2ME
Message-ID: <CACw3F52ov0ZwaecdP2Ky-N5h6hC4dwDZfjysoVF4oF-AhMRbbA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: APEI: EINJ: Allow injection on legacy persistent memory
To: "Luck, Tony" <tony.luck@intel.com>, Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org
Cc: bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org, 
	xueshuai@linux.alibaba.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 4:13=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> On Mon, Aug 25, 2025 at 10:33:48PM +0000, Jiaqi Yan wrote:
> > Legacy persistent memory, e.g. Device DAX configured like the following
> >
> >   440000000-303fffffff : Persistent Memory (legacy)
> >       440000000-47fffffff : dax1.0
> >       480000000-4bfffffff : dax2.0
> >       4c0000000-4ffffffff : dax3.0
> >       500000000-53fffffff : dax4.0
> >       ...
> >
> > can support recover from Machine Check Exception due to memory failure.
> > Therefore there is need to test it by injecting memory error
> > using EINJ to legacy persistent memory.
> >
> > However, current EINJ only check if physical address falls into the
> > IORES_DESC_PERSISTENT_MEMORY_LEGACY region. So attempt to inject
> > error to "Persistent Memory (legacy)" fails with -EINVAL.
> >
> > Allow EINJ to inject at physical address belongin to
> > IORES_DESC_PERSISTENT_MEMORY_LEGACY.
> >
> > Tested on a machine configured with Device DAX:
> >   memmap=3D4G!12G nd_e820.pmem=3D12G,4G,mode=3Dfsdax memmap=3D176G!17G
> >   nd_e820.pmem=3D17G,1G,mode=3Ddevdax,align=3D1G memmap=3D176G!209G
> >   nd_e820.pmem=3D209G,1G,mode=3Ddevdax,align=3D1G memmap=3D176G!401G
> >   nd_e820.pmem=3D401G,1G,mode=3Ddevdax,align=3D1G memmap=3D176G!593G
> >   nd_e820.pmem=3D593G,1G,mode=3Ddevdax,align=3D1G
> >
> > Injected error at 0x35238d2000, within Device DAX region and
> > allocated to a userspace test process. EINJ driver now issue the
> > injection request to firmware, and firmware logs shows injection
> > at 0x35238d2000 succeeded. The userspace test process then
> > accessed 0x35238d2000, caused a MCE, and killed by SIGBUS.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  drivers/acpi/apei/einj-core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-cor=
e.c
> > index 2561b045acc7b..e746fa66f92ff 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -712,6 +712,8 @@ int einj_error_inject(u32 type, u32 flags, u64 para=
m1, u64 param2, u64 param3,
> >                               !=3D REGION_INTERSECTS) &&
> >            (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DE=
SC_PERSISTENT_MEMORY)
> >                               !=3D REGION_INTERSECTS) &&
> > +          (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DE=
SC_PERSISTENT_MEMORY_LEGACY)
> > +                             !=3D REGION_INTERSECTS) &&
>
> I chatted offline with Dan Williams. He wondered whether this sanity
> check should just be reduced to pass through any address except MMIO
> and leave it to the BIOS to decide what is a legitimate injection
> target.

I guess that's fine, but wonder should the EINJ driver still exclude
IORES_DESC_ACPI_TABLES and IORES_DESC_ACPI_NV_STORAGE? to prevent
that, say, by coincidence or not an error "corrupted" EINJ table
itself, or "corrupted" other ACPI data.

>
> >            (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DE=
SC_SOFT_RESERVED)
> >                               !=3D REGION_INTERSECTS) &&
> >            !arch_is_platform_page(base_addr)))
> > --
> > 2.51.0.268.g9569e192d0-goog
>
> -Tony

