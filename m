Return-Path: <linux-acpi+bounces-10428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504BBA05353
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 07:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369507A2476
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 06:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77DE1A7255;
	Wed,  8 Jan 2025 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd+Lco9J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26419EEBF;
	Wed,  8 Jan 2025 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736318381; cv=none; b=YCfPU5x0h7zZJUolR/b7hblDcFoISPElMSuVUQKsdygTwVwKwqL4hAdMkUBlI3Yh6XUnXVIB7TS2MGDb6rxzRQb9yj5tHeanQFF2zE5o5jbDBcqlEn6gQ4B7ZxLsUKwENC01YkM6Yz/rGMKTs7g5Rgb847fvMPnXahmbn9oZx8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736318381; c=relaxed/simple;
	bh=Y2Rym7wN24H634GDba5XHQmmggHq37wC92W1HMI6jBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC9lnmoq6xgkspTisVoKVhxP9DnZ0W950TwowFHpqTTW2PPmqB4OxdmRE78luIhCCH0/45LO3uz21ZoBaJHR4jpXufKbwj7IMHSAOzyh/MQ2wXx1RBxKXaAcVbq5h3wr0ZBK03GIPWUHq21GOCYhLbci8YbFmRiEJgBEyd+kOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dd+Lco9J; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85c4e74e2baso3127351241.0;
        Tue, 07 Jan 2025 22:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736318379; x=1736923179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HctyhvaChLTZSAhLoKirYpByW1qn38IXcafGBCGBDRs=;
        b=Dd+Lco9Jfujqw5Fz0za3eaQajO7zAPf+qczFkIKDKJZN3Qiby7pOWkB19V6yn2MmZg
         pJhC0tEPCEtyBlmdXJGjVVG0rcZCfHHDdk9quLHxhf+ireFOiz6d5huNClNdmK0C8f7n
         mRN6462V269gfOPqR4B0WdwUKr2Or+j7GPYDkObPNGCII6oJj1yWbkgpD9MzgEP0uNAP
         oATE1SwNi+GyQABhcc1Zknt7rBfm2A9H4mkSeFSVV39CLjGKqGaabz+gt7zSONr5sIMA
         lDS/OeYqQ/SncXADG48fuL5ARODEJhnNRr0OOBJQD6KQEALNfVVZAKPrFkNPr+zYfSFW
         aJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736318379; x=1736923179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HctyhvaChLTZSAhLoKirYpByW1qn38IXcafGBCGBDRs=;
        b=D1gEe2ZfT5L5Tdpfxn8IV5WHHG4SiMsyOphxYWjixAq7FM/AENhZmaj8qGmY2uBkly
         MwO+wgolXLHQ/9LAytnlZ0431B6UpKUV/laR8jt6ae93ETmmjlhCVGDGRN2ataMz/C+A
         zkhb6DoNYUvzXn1wxxVdjie1saudnZLSAXQrvbQCqsqJ5xrxnDp9txEXk9E6hEH5Nbnf
         /tfgx6TvD/oRnZr3+9jQkt28YYcUxBa6nAUs9Y8YZzLqkWP1ySKc+j5yv4Hb7mCLihGE
         vdw9aA92Musvl4CXhEG5L12K40WXBUotc68SdlbX5VWoi3vtSKjp4Pg0Cyek2gAJHRaK
         vB0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgAnGHiK7nuMnnJkgpzN5ARCGyu/aT5jWqs7QX35uONkB6fDYg3WJI5Awiypmmhtyd2dVGeY+bVcrh@vger.kernel.org, AJvYcCWLzlr9XNR6ACEgCV3CHPyzT5FunUTLO1ujY4OvdpOpCqKnwARzeP0tL1X6CCS+YE95TPVisaDAzpxDy1lX@vger.kernel.org, AJvYcCXe80Zxm4yd34n8Htujzfjne2Uj4W0rxjVs/x6AwqxiVOyYHZe1fvxRa7J2IdRIWqXk94k0sSRxp4TAbo7ID/JhDIgj5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHEPx7zRHB1DfK7DCT34gksbSzgK6bC2KuYQAl4jxpzqOEmhIt
	sEY3mCkTBmGn0r/kkWtYFG8NETfhaC54g8IRcbaNyNiumBL8mxdm
X-Gm-Gg: ASbGncttvynZzM58QCT+AlGmjcOhvAobHk1zvsxVav7KPDhuyPkruOOnAvShAzxBWdf
	D5l6ZSKqqesKHBhPoez5IEro7XNoDi6k9J1MlltnwHX4+eLUkV2tn4ALsopr+/G14qgz09/OaQ3
	vDfOdah9Z4YEy0aN3M1ReePCgpCvA505qBWhUE9obZVjWEB76nuHkFKsrnavQT3DlqbYALbhFQ2
	RwBxKsdW8AjOz7ZzPVhBUr7IErfwaFupq2nJyDcBSuAO2j8eAeXPw==
X-Google-Smtp-Source: AGHT+IEtOp9GS/mUdKzXgnt0rnUKqaQvqnGHl+EKznX0I5rGzpwbicujKROtr/6Piq6xvztFo/bEug==
X-Received: by 2002:a05:6102:1497:b0:4b2:4a38:7b8f with SMTP id ada2fe7eead31-4b3d10485c0mr1376005137.17.1736318379008;
        Tue, 07 Jan 2025 22:39:39 -0800 (PST)
Received: from alphacentauri ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8610ac4bce7sm8179585241.13.2025.01.07.22.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:39:38 -0800 (PST)
Date: Wed, 8 Jan 2025 01:39:33 -0500
From: Kurt Borja <kuurtb@gmail.com>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Hridesh MG <hridesh699@gmail.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, josh@joshuagrisham.com, 
	"Derek J . Clark" <derekjohn.clark@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Lee Chun-Yi <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, 
	Lyndon Sanche <lsanche@lyndeno.ca>, Ike Panhc <ike.pan@canonical.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Armin Wolf <W_Armin@gmx.de>, 
	Colin Ian King <colin.i.king@gmail.com>, Alexis Belmonte <alexbelm48@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com, 
	ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH 0/3] ACPI: platform_profile: Let drivers dynamically
 refresh choices
Message-ID: <sjno57hd66wvjlplnv42fgb7wt62y5xh2dpbsx2r22x6mlneth@ohnyf3za545l>
References: <20250106044605.12494-1-kuurtb@gmail.com>
 <33a5b6a2-e4df-4bfc-88a9-a9e8309c7f7a@app.fastmail.com>
 <CALiyAonc81o1FreDaWiik3XaqKYVf=wYHX+vaE2_1w66LhJTnA@mail.gmail.com>
 <2e71a4a9-6ec6-4ac7-8640-d80dcdfd7776@amd.com>
 <CALiyAonp1eow2ht_Cmux0B5+-Ukx7YxsE59c4VzwfSvL61iQ5g@mail.gmail.com>
 <205c47ef-6651-4a57-bbe4-adf1b8a25983@amd.com>
 <zelin5tbkup26skhs3dwacwxl33h4ryzgrn3nefay7fxotb5v7@aumb6v7hexpc>
 <4cbfaa44-5ba6-4ccd-8db6-e74af8fe4bba@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cbfaa44-5ba6-4ccd-8db6-e74af8fe4bba@amd.com>

On Tue, Jan 07, 2025 at 11:28:06AM -0600, Limonciello, Mario wrote:
> > 
> > After giving it some thought, I agree with you and Hridesh. Kernel
> > should not limit profile choices if they *are* selectable.
> > 
> > If a "proof of concept" patch is still interesting I'll be glad to send
> > it, otherwise I think my original idea has too many problems. User-space
> > should be able to handle these special cases.
> > 
> > I think an attribute allowing/disallowing power sensitive values is
> > interesting. Maybe allow users too attach/detach individual profiles
> > from being selected/cycled? On that note, it would also be interesting to
> > be able to detach invidivual "profile handlers" from the legacy
> > `acpi_kobj`. But I'm not sure if this added complexity would be worth it.
> > 
> > Anyway.. Mario, do you think hiding platform_profile_handler from
> > drivers is something worth pursuing? Similar to what the hwmon class
> > does. I feel having some struct members like `minor` and `choices`
> > exposed, or having the profile_get/profile_set callbacks not being
> > const, while it's not the end of the world, could be problematic.
> 
> Yeah, I think this is still an interesting idea that's still worth pursuing.
> 
> Making the API simpler for drivers is a net benefit and reduction in tech
> debt.

That's good to hear.

I'm working on it! Hopefully I'll be able to submit it in a couple of
days.

~ Kurt

> 

