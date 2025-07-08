Return-Path: <linux-acpi+bounces-15069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C695AFCE66
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F411885893
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D61D2DC35C;
	Tue,  8 Jul 2025 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iV/SHiw1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A9D2E0412
	for <linux-acpi@vger.kernel.org>; Tue,  8 Jul 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986724; cv=none; b=FwfgkgGH4GxDjdm4YhHCmRQm8MPzcvuN6VFWvxk9ZzkLrUTcCuGcmYgQwf1oOQKFCc3/NzegYZt4AOoa0zDSW4t2WzC8cAgqHQGgag5z6+v6sGQ736WkMRYsPWRM9oJq2Y3WdcA2FCorPyfLvGt/XO8+J6nZ1BZnhkJBOidWzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986724; c=relaxed/simple;
	bh=HGTpVxEEJn+4Z8F/2vfMSUr1vMJyUPWvL7WDo/xrVN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luLV3sbeR+MY1MCjxMLsfSVwDlUc7bAF+kGtWc4G89F9FqPHByeTZtoncwsRqcDYnK23TbtinzWUG/AXOtHz1J1tpnyqojmBoB+gBh5av2gjXeKcQ2hDEX5GTcaBcO1fp7IvBSKWv0Nw6eAG2KsnhfZR6aCbegXzXHFPltC7gLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iV/SHiw1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553dceb345eso5259820e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jul 2025 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751986720; x=1752591520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsjEc9LmeMOTlM1N3xvojXwrwvOBpBec3I1iTp5IlDk=;
        b=iV/SHiw1WPWcKwV+GMPbxGhFJWHy3MSOaVW3Q6Nz2n2AqdKiKGyAed3rI3h+s6Y06K
         edWkKrK8zTRDLssDBG1VL9FrH57jl7+wla8Hv1JqWMZA6rpjQ0/R+LYEPx6eXcIt4/ie
         6FOrMOKFq6jQGWc2aqpC6JlsKHrq7rgCCULvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986720; x=1752591520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsjEc9LmeMOTlM1N3xvojXwrwvOBpBec3I1iTp5IlDk=;
        b=YpXW1PWsKNrT8PIsLuwbQuJtb6JEjfRBg78Fkia0B+O5irTCnhu7+sOl+k48UfUID2
         agRZRvKGPf6yvhtSqq0bDu6nDUbzVOfws4vNkcVB+JMQ98mk4fxzGm7UKdrxBNS5wSGC
         Jd8IBtipJRsghWUBelBoBMgDhggpX5wXT0k69Z4FEhqSr6dUpafJSI1grIheud2rtS8x
         DEyXXZev6F/iY9oGwvQN2GKJl+6q5dH3dDaVJFc252xoHmG7XSru7btyM76isu9TITwL
         KP6HAUXYmSkHAATAQX9GlRBC0or+I1SSJILoMfAoTm7SFBj0mw5fBc15KbC59KPR58zj
         FY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnbiQuhkCT0SKbgumYIeBffCmir1O5fAvR2zDfNmvMOW9abqNlNlEjD6yiT4sds3Wuw8PLM5rCth4X@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++WyCziPzFluuIGf1KAyBbsfKRtzjsUfntr2hBEO4NP0oLvId
	R6MI0LnWOAWZzquc035IXYciJ5yUfUqH5bRHZmdVi6EfVUzf5E2cN54J5+rDAoTVl+6yOUQA5JO
	jpoNb2bqM
X-Gm-Gg: ASbGncuearsgl/av6DiU87/iz+6CEbQUj3MIjM9zGlzVXZ3WTyAfwhTgOoszH8BbY2T
	ahzZXEgZt3ju0SWK4nGGflaxBZ+7KX1nxGTmV4+5u3lv6XdgEOjUhgLnuYNv3o+Yqkcw3fAmvTO
	3TFgBtUiE3SfE92xl8Z46kt//XRd3EpAHjG7MmntJSQ5C6uX0fIrovSAdTWB/9ULPEvKaKT76/m
	BYfB4NthMqP4hphu/RYizkERlLMoIuUyWexLswCfMfz+xOCvefcXYM3OtlVZxI3P5NG5CpNoIN+
	RGvcvNysFt9Ir4VpfCJXu4+uYLh4l9wlIIDpsH5pEQUl3GLicrYqgt2mdm5TTrZ2mKEq2NdKJaj
	vilZFc/eIiMZjpwgSiHwDeXBU
X-Google-Smtp-Source: AGHT+IFhhX4fhnPNTwNuhGqyY2/suTVp7p5nTFKrRXQgH8lPDYMoFYHPOiJTI/H8TjuR1ZvRqBkSYw==
X-Received: by 2002:a05:6512:15a7:b0:553:2633:8a65 with SMTP id 2adb3069b0e04-556dd6bccd3mr5206709e87.30.1751986720220;
        Tue, 08 Jul 2025 07:58:40 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384a7f0esm1683015e87.154.2025.07.08.07.58.38
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:58:39 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553dceb345eso5259767e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jul 2025 07:58:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkp9apJegByc/q6kP4ZPMYY0FyBrHrrKkNBSYAXPZ7llyBrOKS7zJ2wnRD7ui7Ghd1aA/lfpAhN+z/@vger.kernel.org
X-Received: by 2002:a05:6512:ac8:b0:553:3028:75ae with SMTP id
 2adb3069b0e04-556de076273mr5727105e87.46.1751986718368; Tue, 08 Jul 2025
 07:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org> <aGw_1T_Edm8--gXW@kekkonen.localdomain>
 <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com>
 <aGzjTRSco39mKJcf@kekkonen.localdomain> <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>
 <aG0NI2V0Tfh2HZ6O@kekkonen.localdomain>
In-Reply-To: <aG0NI2V0Tfh2HZ6O@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 8 Jul 2025 16:58:25 +0200
X-Gmail-Original-Message-ID: <CANiDSCu=wU_Oi7CLPcYTC3Xf_pGbDroaVitPAiAj7ND5pXy-6g@mail.gmail.com>
X-Gm-Features: Ac12FXx3zIz7eqEIVhgOFhdr-yyA-k97hK_sQ1bucetsK4DfnOnoX-8awEd9Sp8
Message-ID: <CANiDSCu=wU_Oi7CLPcYTC3Xf_pGbDroaVitPAiAj7ND5pXy-6g@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] media: ipu-bridge: Use v4l2_fwnode for unknown rotations
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jul 2025 at 14:21, Sakari Ailus <sakari.ailus@linux.intel.com> wr=
ote:
>
> Hi Ricardo,
>
> On Tue, Jul 08, 2025 at 02:09:28PM +0200, Ricardo Ribalda wrote:
> > On Tue, 8 Jul 2025 at 11:22, Sakari Ailus <sakari.ailus@linux.intel.com=
> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Tue, Jul 08, 2025 at 11:16:25AM +0200, Ricardo Ribalda wrote:
> > > > Hi Sakari
> > > >
> > > > Thanks for your review
> > > >
> > > > On Mon, 7 Jul 2025 at 23:45, Sakari Ailus <sakari.ailus@linux.intel=
.com> wrote:
> > > > >
> > > > > Hi Ricardo,
> > > > >
> > > > > On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
> > > > > > The v4l2_fwnode_device_properties contains information about th=
e
> > > > > > rotation. Use it if the ssdb data is inconclusive.
> > > > >
> > > > > As SSDB and _PLD provide the same information, are they always al=
igned? Do
> > > > > you have any experience on how is this actually in firmware?
> > > >
> > > > Not really, in ChromeOS we are pretty lucky to control the firmware=
.
> > > >
> > > > @HdG Do you have some experience/opinion here?
> > > >
> > > > >
> > > > > _PLD is standardised so it would seem reasonable to stick to that=
 -- if it
> > > > > exists. Another approach could be to pick the one that doesn't tr=
anslate to
> > > > > a sane default (0=C2=B0).
> > > >
> > > > I'd rather stick to the current prioritization unless there is a
> > > > strong argument against it. Otherwise there is a chance that we wil=
l
> > > > have regressions (outside CrOS)
> > >
> > > My point was rather there are no such rules currently for rotation: o=
nly
> > > SSDB was being used by the IPU bridge to obtain the rotation value,
> > > similarly only _PLD is consulted when it comes to orientation.
> >
> > So something like this:?
> >
> > static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
> >                                      struct ipu_sensor_ssdb *ssdb,
> >                                      struct
> > v4l2_fwnode_device_properties *props)
> > {
> >         if (props->rotation !=3D V4L2_FWNODE_PROPERTY_UNSET)
> >                 return props->rotation;
> >
> >         switch (ssdb->degree) {
> >         case IPU_SENSOR_ROTATION_NORMAL:
> >                 return 0;
> >         case IPU_SENSOR_ROTATION_INVERTED:
> >                 return 180;
> >         }
> >
> >         dev_warn(ADEV_DEV(adev),
> >                  "Unknown rotation %d. Assume 0 degree rotation\n",
> >                  ssdb->degree);
>
> Maybe:
>
>         acpi_handle_warn(acpi_device_handle(adev), ...);
>
> ?
>
> >         return 0;
> > }
>
> Looks good to me. Maybe something similar for orientation?

Do you mean using ssdb also for orientation or using acpi_handle_warn?


I cannot find anything related to orientation for SSDB
https://github.com/coreboot/coreboot/blob/main/src/drivers/intel/mipi_camer=
a/chip.h#L150

Am I looking in the right place?

Regards!
>
> --
> Regards,
>
> Sakari Ailus



--=20
Ricardo Ribalda

