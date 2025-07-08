Return-Path: <linux-acpi+bounces-15065-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78025AFCA1C
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 14:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900B53AA1DA
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873C42DAFAE;
	Tue,  8 Jul 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bPfuOPJ5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A543F238D53
	for <linux-acpi@vger.kernel.org>; Tue,  8 Jul 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976588; cv=none; b=ofn8SX5O8XjksuXmYsycn0UJ7btlJODJ/7gFJyL86oz3OrGbllQIS2Ew4WEbH5ucs4dctTdsqVaURaocsYwevrU+0jHHBXYFpThjHJkt37DbG219OBHAblIbFfCYKmE/l4yueM4/CSxGdXFZnZf7LKjcRgp6jHlZ7rXDN5Pqq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976588; c=relaxed/simple;
	bh=dyXUujHTnYYHwk8qxqITJQ9BmoorGjnNWrcKqYxBG+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdHLq4TVs1haxsLsiAD/0NoGwDF77KLrWug+n79I6afUoIOuIyaDU8SI3gaj47cUKdpQR7GHs3lPGPc2haFeFgBbCkBeIXkds4G6+t+LQRmjBlcLN7Z0RkcMHDSAtWIN8d41WFWsmoMMWjfeWSzKpspkS5lkW6RXpj6Eyl0Moag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bPfuOPJ5; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b16a0e38so4658344e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jul 2025 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751976585; x=1752581385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMrJyzq+XGe4XZwQoy4OMfTD6mqi6tUL9Fg2sLgmdig=;
        b=bPfuOPJ5hHM3tzsvk8c1huHG5ddFVF4F/WFTYn4FXur6qx8PTjwyBZN3YTx2GjsF0x
         eHBuMmF7NRqBVdP4l6TYsEffOpJlgl9GdeIVxI9Z4LalMscLzGY4pStDCSSI/bzNPWbH
         ZWQI1ibf8O5O8cdH5jvIcPpGvsziUnIeB2GJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751976585; x=1752581385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMrJyzq+XGe4XZwQoy4OMfTD6mqi6tUL9Fg2sLgmdig=;
        b=RC1bY/cyoOZYfSD0KGTB/+nFOHPZU4gvpCxCYnEIoT62mDM45eUcRNX3lA5iZAO28d
         nPlG0grX19jOSFChBtkXsBOYIsoRmsILDDLFNLsSqoFJkGYZQ4vSip9hnmqvypuUEwEQ
         iS5ljXjZ9N0HUjbLp5m/2BU4eCTeGtjbCwFaCH1pryFdwXo4K6qE30BlEBJr9+8u5au5
         /WMz+eBjS1guKVkat3I8RMjaJCdZSjYoR4hX4GE5n1LmvRN0hcf5647m+1tBJp27XR53
         MUuTpCMIxyvwYZ1Gu6vuzrD4vnJPT1PwIjiYLCl12HG+nfXsC6oOXEoP/v4y+acQjvmF
         7ppw==
X-Forwarded-Encrypted: i=1; AJvYcCVMhbCMwIBkw7IygNZnPj+q88d7i2nIwFRPbQQPVLBSTz3uh1whHrovlVhna8VIWvNNFAYn9KwNkPG1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/oHfk4Npq2n52+wwswP/hfWu8VxsMZEse9JjJ6eLLxUDf1FWW
	/H+uqbVl4UsnWbAUSaPD+9wTnFD4IeitzVJgx729AX/X0GS7FqNYpUXi/dIrcdWB/uRTMSeDDgJ
	ZMd7m6M3G
X-Gm-Gg: ASbGncvXe6Hvc5uhzdKNuNinI64Y2h4hKLhJ5PihdeU0uRzap7hdOXVc3NF3+4kKw/S
	OQ5Z6DGPSo5fjapqExK69W1VLHpUcvzQQmO3TdXc783yr/mJPP6zjnT12umSiaiAYyi5SeP703F
	94uUbDom5LnVbemEEnwlsmseQvQSz/9WVkWLKQd2aHmzef1o9M4f0JqLKjGBzISsG7GSJCsAKUv
	zHh2cVcSgpztTXw7OQzzIiLuLC/h1OPG/d2KmMK+X9EE4Gik9BWPQ1wB8G8aTJXi4kqBVG5GsBj
	5BXMk1ZYI+bz++ZUAKXhQCzHg7bTfAKfLqlWY9aA/BP7zw9AY8h67UL548oSgikBE/LAWUpwKRA
	MUIO2ciqp5U7T79G+QtbgcDqzJ4B8
X-Google-Smtp-Source: AGHT+IHHy+y1rQjmGxAPK60SR4m2UZn8ZSSQ/Bz0ThwNlwd/bB7c3mn1addjLg1bea93CmK5LN34Ew==
X-Received: by 2002:a05:6512:1252:b0:553:302b:85ce with SMTP id 2adb3069b0e04-557f82fff7fmr1024335e87.7.1751976584635;
        Tue, 08 Jul 2025 05:09:44 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-557eb2f57c6sm1022639e87.249.2025.07.08.05.09.41
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 05:09:43 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b43846e8cso34841291fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jul 2025 05:09:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmqDrXav9SBBaaKYwDocmHJZSvvXUm2Zn1eBZTW0MG+78yPjm4/bwuFxZoyrVRHGMBxBOe4zs7LjHr@vger.kernel.org
X-Received: by 2002:a2e:8e3c:0:b0:32f:1c0f:fb74 with SMTP id
 38308e7fff4ca-32f39b2409amr8468421fa.22.1751976580861; Tue, 08 Jul 2025
 05:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org> <aGw_1T_Edm8--gXW@kekkonen.localdomain>
 <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com> <aGzjTRSco39mKJcf@kekkonen.localdomain>
In-Reply-To: <aGzjTRSco39mKJcf@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 8 Jul 2025 14:09:28 +0200
X-Gmail-Original-Message-ID: <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>
X-Gm-Features: Ac12FXyPY8jp6OO5y2rUkBGCgm071L0BZh3437cx12a8IP9Dnshn9sW-VSnuQ7c
Message-ID: <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>
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

On Tue, 8 Jul 2025 at 11:22, Sakari Ailus <sakari.ailus@linux.intel.com> wr=
ote:
>
> Hi Ricardo,
>
> On Tue, Jul 08, 2025 at 11:16:25AM +0200, Ricardo Ribalda wrote:
> > Hi Sakari
> >
> > Thanks for your review
> >
> > On Mon, 7 Jul 2025 at 23:45, Sakari Ailus <sakari.ailus@linux.intel.com=
> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
> > > > The v4l2_fwnode_device_properties contains information about the
> > > > rotation. Use it if the ssdb data is inconclusive.
> > >
> > > As SSDB and _PLD provide the same information, are they always aligne=
d? Do
> > > you have any experience on how is this actually in firmware?
> >
> > Not really, in ChromeOS we are pretty lucky to control the firmware.
> >
> > @HdG Do you have some experience/opinion here?
> >
> > >
> > > _PLD is standardised so it would seem reasonable to stick to that -- =
if it
> > > exists. Another approach could be to pick the one that doesn't transl=
ate to
> > > a sane default (0=C2=B0).
> >
> > I'd rather stick to the current prioritization unless there is a
> > strong argument against it. Otherwise there is a chance that we will
> > have regressions (outside CrOS)
>
> My point was rather there are no such rules currently for rotation: only
> SSDB was being used by the IPU bridge to obtain the rotation value,
> similarly only _PLD is consulted when it comes to orientation.

So something like this:?

static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
                                     struct ipu_sensor_ssdb *ssdb,
                                     struct
v4l2_fwnode_device_properties *props)
{
        if (props->rotation !=3D V4L2_FWNODE_PROPERTY_UNSET)
                return props->rotation;

        switch (ssdb->degree) {
        case IPU_SENSOR_ROTATION_NORMAL:
                return 0;
        case IPU_SENSOR_ROTATION_INVERTED:
                return 180;
        }

        dev_warn(ADEV_DEV(adev),
                 "Unknown rotation %d. Assume 0 degree rotation\n",
                 ssdb->degree);
        return 0;
}




>
> --
> Regards,
>
> Sakari Ailus



--=20
Ricardo Ribalda

