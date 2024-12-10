Return-Path: <linux-acpi+bounces-10045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372469EBA60
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D8F1672C2
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E822618B;
	Tue, 10 Dec 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CYz4+3Ga"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8152214233
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860571; cv=none; b=uyx48AlgW+YUq1wNuSR8lCyI20oPt8qYEeArqBzpmnpSdYDw54Wgi888IVMQMC8CKqCacH5vRCCsi8ApakAQMR5E9VcZWSgkGpEXb0YYRQCZV7/vIMC+wqhOQ7ZYLesbkrN+04JE323htzfKkBR831u1HOSMv8LDXu92+FMTTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860571; c=relaxed/simple;
	bh=e6N+GiKT6QGfW61aH0GmQOtN0oMTDgLGk2yx2uhx9Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pa5b7LnDFl45PASwTVzKVAIDdvKDrqzFZHsfz1kNVjZxHdBOEsyzVDcw5PoUNJBULE7EY9ETmB0+piJHBJ8Ys1zi4ACqJVYO/TW9VO5xto82YxA3BcnQU8+lTAUPL8+vXaIOVdKUNzjVlPv4gJ7QqViajdzO6u2O2qJSFZhjIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CYz4+3Ga; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728e1799d95so1172304b3a.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860568; x=1734465368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhVnUUt21FbgPDOVIQ39erkKtCV93uZ7UVN8hJAABAg=;
        b=CYz4+3Ga9qjLTp3Nl0pjBhSOaXx0jGhnm+gMSPYxMJCpZ9PlgOg9o/limlUs8Cygkm
         fjLHRWkAvMey07j1YZxtcULQDMbwOkf+By+6f9IHveuzg+FSMAjIJjqCmRii98Anw/00
         xjLEMzcfU7NBmYzxFPiiFMgRUu4Peb6CvUo08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860568; x=1734465368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhVnUUt21FbgPDOVIQ39erkKtCV93uZ7UVN8hJAABAg=;
        b=Pxxg+QXy1huTaFgNVwe914rt5pA7ro+DjpCF5Fh0wglMjPEzIhR8aCS7jnIDQW196G
         zuNi2iBxfujk8p0o7ssXTaNu5GSk/gfXLL3YhwUiB7V2BkobILZvP6ecyXkV5X8RkUsJ
         1RIfJ71kWVfju9vgj2JoIYRBEpK/MaWly6eHzi3OyDpDZr4m/LC+Ne+tpvd7oksvc6DG
         1qHrUbz3bSJW0GPyHjirTMJxeyBS0EDS4epCcYm+xTgW0z1ZfRQ4opFD+qaBPuYlpeWu
         07W+4gueEfQNziAvE9zjV5VplVDdmgdOBUUgwmv/fghnzPGCiaWCOkGSr1m+Pa1xWDEd
         KVpg==
X-Forwarded-Encrypted: i=1; AJvYcCX6i/DISAUxn3Rq7W/MVf5EtTf22UAT4VNxRXlMCkUl2u7dnQXcS+WipMG7G1hA47VpqlqplYQgPYx4@vger.kernel.org
X-Gm-Message-State: AOJu0YzNC6cMMMbAhXsqR8hLyQO1KQGx0xnpZf+MYCuUE3wsBl6JTOVJ
	8MT9r2BXckCNwKwomuvnt1tR3AIz6BRdXXAEsZpuUPtIJA0vTE3npVL9rKZ+fC/nrjj9+BamWr4
	=
X-Gm-Gg: ASbGncvqB/WllIrk8IsjXwpy7/j/lypHI2zv7JNoSPwoOp9BxC3zuoaUO+zaRhY2bqs
	L09CfhJO7l0BR4wizD7bN2q2z9/1831sg+5l9kBhoGcLKZzjwAFwP0D88IbtbgEU+tVnFw5LB8T
	QI2u1vFuDet9XOpuGDCQi9jUZi3z1EWPozdkk3yvT17K/qqjQx6mub8/BgWdhvHR81/aL3kpGW7
	5gXvqU/yGOt0S0r28OPxYH6retgol0GMUHn3l86PPK0XAryP6Ap+mrb8Goz9GNUY2Nsn78oYhfz
	lCe2DjtP04qujweFPMK1kZs=
X-Google-Smtp-Source: AGHT+IEZf9Wcid3/lcm1i0KNfD38/910M+s1Dgyo5+m8xHGaR4V5AKIpUGBqerwdAPiVBYF7ZddzkQ==
X-Received: by 2002:a05:6a00:1796:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-728ed450565mr347864b3a.22.1733860568314;
        Tue, 10 Dec 2024 11:56:08 -0800 (PST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e39882d2sm5109892b3a.79.2024.12.10.11.56.07
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:56:07 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd49d85f82so2141836a12.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVO+8Jg6LNxtL52Y9EsyUPNsxCu7FjOJY/l1zN0Xym2zHcwXKLZjg6W3ug501cHwDS7fPVP+juV8byB@vger.kernel.org
X-Received: by 2002:a17:90b:4c84:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2f127f50d18mr438841a91.7.1733860566933; Tue, 10 Dec 2024
 11:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
 <20241122-fix-ipu-v2-3-bba65856e9ff@chromium.org> <CAJZ5v0i9SresLT14aWuyodKyi2y3yyC8wLMYzrSD4ec=9WVSvg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i9SresLT14aWuyodKyi2y3yyC8wLMYzrSD4ec=9WVSvg@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 20:55:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCsYcQBzUzjACQdhASarR9Ad4bnD035+DZzJnrQboXVDAA@mail.gmail.com>
X-Gm-Features: AZHOrDkADV0-JEZsLMswWL8-2MF9FWIqIKoMqh9rPKxVkdv7pvHri8tCHfHVYAw
Message-ID: <CANiDSCsYcQBzUzjACQdhASarR9Ad4bnD035+DZzJnrQboXVDAA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2024 at 19:31, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Nov 22, 2024 at 10:48=E2=80=AFAM Ricardo Ribalda <ribalda@chromiu=
m.org> wrote:
> >
> > Provide an implementation of acpi_get_physical_device_location that can
> > be used when CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/acpi/acpi_bus.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index eaafca41cf02..4888231422ea 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -43,9 +43,6 @@ acpi_status
> >  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_cod=
e,
> >                   struct acpi_buffer *status_buf);
> >
> > -acpi_status
> > -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > -
> >  bool acpi_has_method(acpi_handle handle, char *name);
> >  acpi_status acpi_execute_simple_method(acpi_handle handle, char *metho=
d,
> >                                        u64 arg);
> > @@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t =
*guid, u64 rev, u64 funcs);
> >  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t =
*guid,
> >                         u64 rev, u64 func, union acpi_object *argv4);
> >  #ifdef CONFIG_ACPI
> > +acpi_status
> > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > +
> >  static inline union acpi_object *
> >  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 re=
v,
> >                         u64 func, union acpi_object *argv4,
> > @@ -1003,6 +1003,8 @@ static inline int unregister_acpi_bus_type(void *=
bus) { return 0; }
> >
> >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> >
> > +#define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
>
> This is a function, so static inline please.
>
> Analogously in patches [4,6/7].
>
> And you can merge patches [2-6/7] together into one patch, as far as
> I'm concerned.

I was trying to avoid some extra ACPI_PTR and a forward declaration...
But overall I think it looks nicers with static inlines.

I have kept the patches separately. Feel free to squash them if your
prefer that way


Thanks!
>
> > +
> >  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                  =
 \
> >         for (adev =3D NULL; false && (hid) && (uid) && (hrv);)
> >
> >
> > --



--=20
Ricardo Ribalda

