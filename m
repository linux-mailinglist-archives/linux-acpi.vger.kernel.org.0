Return-Path: <linux-acpi+bounces-11667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46585A4AB65
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 14:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0F616F181
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B119D1DEFF5;
	Sat,  1 Mar 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="oM2ogdSr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51C1E522;
	Sat,  1 Mar 2025 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740837105; cv=none; b=kWezfzcjvRojxyFaSAH/kt00BlzvMXd17U181TPRIiqN7rgWPmV/puAyidal2tO4KglfXH2WmpI6372mAxlweitprd2eMrE6r3g18Bcf/u3HmR+oEe77zFL+vC8suBCer1i0qM0lsFCD//GcKxX8Zi386ia5w48B3XxIypURG18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740837105; c=relaxed/simple;
	bh=YTJP23WW41o2PbQVahhPiI+u5spBFJhoWa1lqhO5P7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Syn2bFbH1uIqeUBqxvIdKkhR5uFfOQlH4xCiWJmFgEAp4Cx1Of7x/bm7EPnqZ0MLcjg/EE2zuIyHTqW+wqD7lXUpjFqZSCmFTc/f/FiFzDK07DKgMHc7uPsipyfaJLOv1MuYK3Msu8WRa1UIRgEoRKgDQDlIuaBc28gZHf6yutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=oM2ogdSr; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D77412E08F4A;
	Sat,  1 Mar 2025 15:51:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740837100;
	bh=SdcCq4Bn8BvVfkKQrC7rH6P6W4SeLi+Ts1tELGCaJBM=;
	h=Received:From:Subject:To;
	b=oM2ogdSrFcgOqM5eaZiCKf+/mV9840yyalOrmuxdeEXgo3h9sRNfz8yAR24geFWRc
	 1kCrpHR8uHpDuktLxowkbTfLFZWdUvKbS65RNicCrarF4zVceoj+eA6RJzNSsvz/iP
	 J3of5qpiZqyjDCVjoItAERijgXqMsN3jxcjLfKzc=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.173) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f173.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-30797730cbdso29156411fa.3;
        Sat, 01 Mar 2025 05:51:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUHGddIVlLeDuNbc/+HpF/wKukqew/WQHwowabl4aK4waZmZgUKS1WNSO3bvsx0QJfm+28ZyWQ3WuRtGGZi@vger.kernel.org,
 AJvYcCWR2SDsejv5MlbO3TNHwVxHuBHhnQ5g5PzOQJV7w61WWjQAgmGOjgfltziY4NFbr2Yma+dJsIG7HEPoQsdG20AK2NjdDg==@vger.kernel.org,
 AJvYcCXVLHgToWL7/k2q4WqzxYoyCi6R5JqEIIfqrtloXaS37hxcSU8Pn8hDV9lrfMdVKWysp4Sy5XM4k9Sg@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAnXL6JSNMUEztnVQQyf00Kw+vtbrQ/eS4UmpFM+Eih+9dIQC
	+WU0OCeugEdl1bPC5m//27Rt2GmoqNW0WHLKO54kVbGpfPtRgHKTMz1OgZQmopnWTD5X2Uvd/h6
	Oo5dzzy4eLhvMA+OKuV5X229eUdg=
X-Google-Smtp-Source: 
 AGHT+IEg8CoQtxbP5TzTnoUS6Iqm6WraDWNIBrPuQd1JEZXlkk9IzsHlW6KJaar5lSeKBdBbMgXbKF3LZ+IzJDzDDIw=
X-Received: by 2002:a2e:be15:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-30b9326afc7mr34766591fa.18.1740837098219; Sat, 01 Mar 2025
 05:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170155.2623386-1-superm1@kernel.org>
 <CAGwozwFoqUPiZjozj5MHV5-4dVF3Ef0Wy-Sn5v38keHp2BfStQ@mail.gmail.com>
 <8ae80eef-ce73-401a-97ae-cc62416bd2a7@kernel.org>
In-Reply-To: <8ae80eef-ce73-401a-97ae-cc62416bd2a7@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 1 Mar 2025 14:51:26 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEBYD144ZTzhB7dFMkTb1cxL6Xw4zm=RPKsF0BXzxOG7Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpHha3Cr21Qgp7GtV-gNQ6OaekouYABlHKKjwOlNrzBGgSX6gQ4koIe8Mk
Message-ID: 
 <CAGwozwEBYD144ZTzhB7dFMkTb1cxL6Xw4zm=RPKsF0BXzxOG7Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
To: Mario Limonciello <superm1@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174083709969.7533.15084913044942707860@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 1 Mar 2025 at 14:44, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 3/1/25 05:09, Antheas Kapenekakis wrote:
> > I just tested this. The behavior of this patch series matches mine
> > 1-1. Feel free to add a tested-by.
>
> I understand your intent, but can you please explicitly type out your
> tag?  This is especially important because maintainers often use 'b4' to
> pull all tags out of an email thread when accepting patches.

Tested-by: Antheas Kapenekakis <lkml@antheas.dev>

> >
> > IMO it is a bit cleaner/thought through than my series, so I am fine
> > with dropping mine. Should be as it is essentially a V3
> >
> >
>
> <strip>
>
> Also; Rafael mentioned this in another thread, but please refrain from
> top posting when possible [1].
>
> [1]
> https://www.kernel.org/doc/html/v6.14-rc4/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

Ack

