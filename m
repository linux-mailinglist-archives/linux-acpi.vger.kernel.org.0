Return-Path: <linux-acpi+bounces-817-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E57D15DF
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6A21F232D0
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7812D2230B
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAA200C8
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 17:12:07 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6363ECA;
	Fri, 20 Oct 2023 10:12:05 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-584081ad442so95303eaf.0;
        Fri, 20 Oct 2023 10:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821924; x=1698426724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSf0OWPH0GXx7qZCyOJ1mhypJ8iy5vrrvnjabt+66lE=;
        b=HgKu8rd7GkyNqDeaWEZvYOLXB6g15tTy2rkkoWjoR+9YOMTcFfRnp3tdmHcz/HPnM6
         CFTURVKfj3LNur2oaDKW49Z9V8BLEONMwoECUOTUK3UEt5KJbqQ+YjmX+JG2nlMqWtuf
         fpcMmMmWToYPCHzZFQ6pxrtIKTTxyL6cu1H23wEvl+OEd+ekbmN+/RfiebKXRaMkytGH
         oV/lJZ4BxMm6BRj4x1TpWvciwLiAhgGdwxWArnC8IyEhgPc7skh944NjGne6b63Or0H9
         b10QJcM3m6kqvXusqeAReujkVCrzfd4npYx+PMOMeAgvz0IfygzUD9GFFICP2ykuMF35
         HhyQ==
X-Gm-Message-State: AOJu0YztE7wsV1BDrJhd5CiwisbKr0L7CqNVyTQMaEXepmAjs/6Js0Mr
	s3+qU1DDLuwvEF4iqD2AG/U4Ox9DjrD00e0ejx4=
X-Google-Smtp-Source: AGHT+IHz95bXMdbA0rsyGICD4nQDIXUlkPK1i4VtFqbmPJqzrw3lQedFI/CTB5Bsh07Da/AeNeIUE1IbFvfJL21La/U=
X-Received: by 2002:a4a:e7d1:0:b0:583:ec88:e0 with SMTP id y17-20020a4ae7d1000000b00583ec8800e0mr2723050oov.0.1697821924575;
 Fri, 20 Oct 2023 10:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com> <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com> <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
In-Reply-To: <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:11:53 +0200
Message-ID: <CAJZ5v0jvAeibnXSq92CBd1uXUgRnvsP0kEqfL8Du552=LT1dog@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] ACPI: utils: use acpi_dev_uid_match() for matching _UID
To: Raag Jadav <raag.jadav@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rafael@kernel.org, 
	len.brown@intel.com, robert.moore@intel.com, mika.westerberg@linux.intel.com, 
	mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:38=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > > Convert manual _UID references to use standard ACPI helpers.
> >
> > Yes, while not so obvious this is the correct replacement.
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I think this is the only case which would suffer from the more obvious
> behaviour, i.e.
>
> bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> {
>         const char *uid1 =3D acpi_device_uid(adev);
>
>         return uid1 && uid2 && !strcmp(uid1, uid2);
> }
>
> That said, we can't be particularly sure about it's potential future user=
s,
> especially when the usage will not be limited to just ACPI core since we'=
re
> exporting it.

I actually agree with this, so please switch over to the above.

The above is straightforward and easy to understand and if somebody
wants to treat uid2 =3D=3D NULL as a match, let them check that explicitly
before calling this function.

