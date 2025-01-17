Return-Path: <linux-acpi+bounces-10732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0CAA148D9
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 05:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24A216720D
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 04:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F35D1F63FC;
	Fri, 17 Jan 2025 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7zUANY9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC068C11;
	Fri, 17 Jan 2025 04:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737088086; cv=none; b=d88+3CnappYhlOc5sSGyeb2GnLg/R/6rC1FNSXXEe0JWMo45LCmttvDW2XM1lUBbUdNCDkSEIfosMfPXA25TCFDj4jA0fD0DtGE0wEjIOppJDB+P6xSR3EtlzqKwIycKmp4d3QZJopKZEvpuwkl/w1gqQgvRY0W+/WTZtmqLDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737088086; c=relaxed/simple;
	bh=zpvBOBIWNbcka/K1tkb9pFpfz2po0uC0iD567858Y7E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=We47Ynr55ekhW12EWjbbEgBgDMQrSwPyPOeXQQJ2qxPpRXRwyoqhCRCAsOL6of8Zx4iRWEyVCXywxPg5kXwuhsDGdmNDp3E4dZcntFLawvCnW39frUM+6HFj72+GBIy+x5rUWwIFi/DzB6UHcleQVUw3VJqQxSQ+E4Qwe1Cib9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7zUANY9; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51cccb020a9so903296e0c.0;
        Thu, 16 Jan 2025 20:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737088083; x=1737692883; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bG3f7y/u6GJFmQaddU0I8bnKf7GyHxvKs5bkvgDY7Y=;
        b=i7zUANY9s0QvFENNFXQyeYMHPml0kdC+bbTkXulavCiVyiYe6Rvqpd7NA6tkpXuACK
         ulFHWlMT/9heQUU67GZUWb54BXtahccFxjzR2WLqpUrKI4dq6y2BcYUWfcVrbncleAmo
         qSN/Z+J+CmXMjEeW9ZIuDQCizaAAyRbu7d6AR+3edN0m7hYWjMTkXZj3oVpgLHG9Hu29
         TDTUWTmu49g79ktGYmdzeypWIMAnQ/WOun5fpDi3MQZldgk6mE5JVLPpAtgW/8XfAnCU
         vTFTJheRevgR9hs/rIc+NCK+6LyUDbLH5DTQRbqonUooENK/lo5BcsO0vl0IkwKQYuyS
         +Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737088083; x=1737692883;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bG3f7y/u6GJFmQaddU0I8bnKf7GyHxvKs5bkvgDY7Y=;
        b=t8Ifnn9FN9ofOMXomP2CsVzKcClwgFA3E8yg0H6Jnrz9hdNUehozjB5dRuS8yyu3Dq
         UpRwtn+mB+pdex2fFqgu7VBCUJ4l0CQH68iElybTsNVFzNuiPvJsn2FxIvesfpwPDDwL
         cxYYTTA+VhLuIBHIpXmk/0Glg3C42McXK31yH+Z9BcdSpVncIymySFfLpWeGm7JojkOL
         5mz/MmDiOCeexX3goyB0IH0+G2sY2nrxHPYJGXyGnsNYB98mBaBe79p0Exbq6N6/wObb
         CFjTOL7T4qhS5+pRIfY/UVQYW7KUivdoWouzWwF55BMT+wjLsxB4NK+2QctqxCau3Gss
         2E9A==
X-Forwarded-Encrypted: i=1; AJvYcCWLJglJOjv28CJvh883WzpweZCdEKH1XW8ZzUGzL5CZeaG8MvFHloVn8ct2e7IAvowAfEmwwFM/g4YQilbnoKCbEfiQPA==@vger.kernel.org, AJvYcCWz5uV0+tdQuKsOANHAqfjBi4i9239wvXq2ZmYAefF7JFcex3Uzh9WniHGtNS6KMVlNXS+/E54bIkEmXm2/@vger.kernel.org, AJvYcCXFANyqwgZyAhO8A6uMzwNBFAUba2B+MtjLCUMxnQIH+X9pWX6+7zSqxyBADLS+80B8CiqVyTqAdwDe@vger.kernel.org
X-Gm-Message-State: AOJu0YzrN1DR9tidWRaNGfPAGzwDrPg0OrH8i9k0/qDekK9i4MrNcXl4
	5/iAynsTz3XV/r+pjIWP3FjWEE3pbQCjCf3ZpCMhyEczaUsBmKDC
X-Gm-Gg: ASbGncvGZlD8GJwdCBHLcH4BpLXYmGzz/K0qj/09dsE5vshvh3Z1ktDOZzTvkBMx1bI
	pO1E6IyRALIKVeiHzEfDGE1Fbv6i0ehahgBuTixWOAH3EuBXJDdL/RU4DoA5/lbg0gObfB0KMWc
	wAQhQ2ppdXtxqveQ/6OsMqMAdjTOjkbTHI3nwtUKHf1LWHFdfsShlZPPVtXDTpAAmQSvS90+6Wn
	jwHoerHZwUYtCM3ABI97YKYIRywilF4EiiY77TEwML6iSCe
X-Google-Smtp-Source: AGHT+IF1ne2Umtga57CR8UgTI5gtz1QiB6L3qwZlW//xYwFTBFhqKIhRn2Ws+Ti9QVlDmevNrv2K7A==
X-Received: by 2002:a05:6122:885:b0:515:f586:5298 with SMTP id 71dfb90a1353d-51d5b2cbc82mr976773e0c.7.1737088083506;
        Thu, 16 Jan 2025 20:28:03 -0800 (PST)
Received: from localhost ([2800:bf0:82:1159:c837:3446:190b:188d])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cf559bbe2sm248324e0c.11.2025.01.16.20.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 20:28:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jan 2025 23:27:58 -0500
Message-Id: <D742BYPBXGJB.KVIXKVELQAG0@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Limonciello, Mario"
 <mario.limonciello@amd.com>, "Armin Wolf" <W_Armin@gmx.de>, "Joshua
 Grisham" <josh@joshuagrisham.com>, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Hans de Goede" <hdegoede@redhat.com>,
 "Maximilian Luz" <luzmaximilian@gmail.com>, "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>, "Corentin Chary"
 <corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, "Lyndon
 Sanche" <lsanche@lyndeno.ca>, "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>, "Alexis Belmonte"
 <alexbelm48@gmail.com>, "Ai Chao" <aichao@kylinos.cn>, "Gergo Koteles"
 <soyer@irl.hu>, <Dell.Client.Kernel@dell.com>,
 <ibm-acpi-devel@lists.sourceforge.net>
Subject: Re: [PATCH v4 00/19] Hide platform_profile_handler from consumers
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250116002721.75592-1-kuurtb@gmail.com>
 <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com>
In-Reply-To: <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com>

On Thu Jan 16, 2025 at 5:20 PM -05, Mark Pearson wrote:
> Hi
>
> On Wed, Jan 15, 2025, at 7:27 PM, Kurt Borja wrote:
> > Hi :)
> >
> > The merge window is about to open, so I rebased this patchset on top of
> > pdx86/review-ilpo-next to pick up acer-wmi latest commits, in case we
> > manage to squeeze this into v6.14.
> >
> > ~ Kurt
> > ---
> > v3 -> v4:
> >
> > [09/19]
> >   - Replace error message with a user-friendly one
> >
> > v3:=20
> > https://lore.kernel.org/platform-driver-x86/20250115071022.4815-1-kuurt=
b@gmail.com/
> >
> > Kurt Borja (19):
> >   ACPI: platform_profile: Replace *class_dev member with class_dev
> >   ACPI: platform_profile: Let drivers set drvdata to the class device
> >   ACPI: platform_profile: Remove platform_profile_handler from callback=
s
> >   ACPI: platform_profile: Add `ops` member to handlers
> >   ACPI: platform_profile: Add `probe` to platform_profile_ops
> >   platform/surface: surface_platform_profile: Use
> >     devm_platform_profile_register()
> >   platform/x86: acer-wmi: Use devm_platform_profile_register()
> >   platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
> >   platform/x86: asus-wmi: Use devm_platform_profile_register()
> >   platform/x86: dell-pc: Use devm_platform_profile_register()
> >   platform/x86: ideapad-laptop: Use devm_platform_profile_register()
> >   platform/x86: hp-wmi: Use devm_platform_profile_register()
> >   platform/x86: inspur_platform_profile: Use
> >     devm_platform_profile_register()
> >   platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
> >   ACPI: platform_profile: Remove platform_profile_handler from exported
> >     symbols
> >   ACPI: platform_profile: Move platform_profile_handler
> >   ACPI: platform_profile: Clean platform_profile_handler
> >   ACPI: platform_profile: Add documentation
> >   ACPI: platform_profile: Add a prefix to log messages
> >
> >  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
> >  drivers/acpi/platform_profile.c               | 172 +++++++++++++-----
> >  .../surface/surface_platform_profile.c        |  48 ++---
> >  drivers/platform/x86/acer-wmi.c               | 114 ++++++------
> >  drivers/platform/x86/amd/pmf/core.c           |   1 -
> >  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
> >  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
> >  drivers/platform/x86/asus-wmi.c               |  55 +++---
> >  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
> >  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
> >  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
> >  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
> >  .../platform/x86/inspur_platform_profile.c    |  48 +++--
> >  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
> >  include/linux/platform_profile.h              |  37 ++--
> >  15 files changed, 495 insertions(+), 337 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-prof=
ile
> >
> >
> > base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
> > --=20
> > 2.48.1
>
> For the series up to v4 commit 15/19:
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

This covers the most important patches, thank you very much!

~ Kurt

>
> I need to go over the last few commits just once more, as there a few pie=
ces I need to get my head around - and I'm not going to get it done this ev=
ening. Hope it's OK to add review for the bits that I have done.
>
> Thanks
> Mark


