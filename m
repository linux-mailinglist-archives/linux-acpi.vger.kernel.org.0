Return-Path: <linux-acpi+bounces-10403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480DDA04092
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 14:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBB818833C5
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772C51E3DE7;
	Tue,  7 Jan 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aebIRft0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA615C13A;
	Tue,  7 Jan 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255693; cv=none; b=K5Q2AOQCkwQFKe8F88bP7iQlA/jfms2/w89BNBnPZVOjRfxdDZ9p6me+URqIIK0dFCZIwTCKg5rlqdnXB0pSBhzMO/ZvEyjkNtM3XpV0hwRf0Y/0k68JVbiEdZxHep/K626gMzgvLQ2uHERmLhkMBjM6rsa+HgQuV+z92wBlONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255693; c=relaxed/simple;
	bh=f7D5Ua+7bgLqCmFzHGL8d66tzpk9fNZumGYyGs8NFP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhoMNw8GxIk8lqGW/ot8lnYdLknOIUEj0Oe6L+qqlQtTEpBKZ7f7ROQLA3Ct0J5EtYKqo6Zt6pW4pgfsX+d5CBvuGbrzc3j9nDivdmBaSG3IUYZomMuAJUS2SMLAa3bX/H8jSTz2Wa0lS62pCr/zy4TYPffM3xYVVjIehi9O5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aebIRft0; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso17426012a91.0;
        Tue, 07 Jan 2025 05:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736255690; x=1736860490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7D5Ua+7bgLqCmFzHGL8d66tzpk9fNZumGYyGs8NFP4=;
        b=aebIRft05kYeM8AHLzj287rzGt2Bbzxwfw7VBaFEG3Qwh9y13XuexA0uVNbX/WxaC0
         5pzd19rCvSvmh01RunXIRbVm47Lhk9l7u7siwFfpjhaPAHZ5ypEpyU2+cT6MtJMNLSmr
         J5P8hsJdYSJVApLzhkB5qbnXY5Y5Fhinpv/72KKwlRCbE/6FX87s29zVlY2IVtDbAxUP
         jHB+yV1pijqJbWQWIounW8LLB1YweEP8iCHBeUpjIr5ez/sTyC4KnshK75i36Vvq2281
         cFl2EHNGMU1r7mAfHnnN9rz6mtx0wqpzyNabap9KDOX1Wstye5Dqr66FqC+4m+u3nufp
         S27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736255690; x=1736860490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7D5Ua+7bgLqCmFzHGL8d66tzpk9fNZumGYyGs8NFP4=;
        b=Bh1YmirmBAmbP8Zk6QjZuauoWSYEjUvYx06FwiWGzcRf0489obnRdPwmT2KMo+gyqQ
         bi/IQrzYiSqIHuBN5zXXkP2sek7n02Xr17U2U5A91WFX5QKEt2PuG5qFWbStOGWeTjmn
         9WLnZ7jfZJhMhM3BBQtixiNz8xMs4pup7VEZjQbbx9E9fOYI0eGoyChl3QJodJQZLyjV
         td1PutOJ24VjkB2rq/ogIZAB9iwtqUfj6jh2WadFtpGetvRablduYHk8JeMUJlAxxGOp
         IvVKr5JTnyRYTErvjIIGeIo7YHi4VPcqMtKMpLFje5qEONziMNFOYKdMyI5UEutTSRlB
         C/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI4i4BbcarbqPNeNMY/+hCeCrii8kE73VwMAEA+Qzn6/KDDAwE9CsZfhkQWuai3DD1+8I+CkHtSQhT@vger.kernel.org, AJvYcCUajaYur/syyhu3t0MEvERfU1ahChasiW4rtZgFpnEGTwFHA/KS9u7Xd4SxOpW7GaSAephQC6ORdkwxrCscAJ1TXJKFbA==@vger.kernel.org, AJvYcCXC1RRF9RtasW2kxIuelGtF2CTjKMusTuQvSnYqKg7/I5m6JfUl66xyu9cV9Mg2eqev7t1knH1jodC/QGKp@vger.kernel.org
X-Gm-Message-State: AOJu0YwvYeyxb3SOciWVrepu5HcviwF23rRPttbnO9QWWJfi9Kdthb/O
	uf2yMDt3yuWezLZNJte367NXig/tSWD6LJPjPGwfgykOI7OqCYSgsQvTfCH2cEAYXSf+LUf/+J1
	qCpd31Vt2aB178vfjDJH1rxkmokg=
X-Gm-Gg: ASbGnctxWcfmnOvLZsjVoK8alMbUmPufyxvqMGc9RPO2CJoDCKy5DAR3oJRqZMHGJBq
	NADvF0bkg/kVpeTQbzueDElb8BRWyHfnKa8S9/hfLbnX+uyFV2c2azrPNBPBKD3qu+5QMMrA=
X-Google-Smtp-Source: AGHT+IE4gBeMEB+bwTMO3rtwtelEiVCem8tm0YyrT7HwH05hcKZU9QvpCJmA/01hI9IebPMSNY/P7//rWYkInLHtxzs=
X-Received: by 2002:a17:90b:54c4:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-2f452e38d72mr93343908a91.20.1736255689596; Tue, 07 Jan 2025
 05:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106044605.12494-1-kuurtb@gmail.com> <33a5b6a2-e4df-4bfc-88a9-a9e8309c7f7a@app.fastmail.com>
In-Reply-To: <33a5b6a2-e4df-4bfc-88a9-a9e8309c7f7a@app.fastmail.com>
From: Hridesh MG <hridesh699@gmail.com>
Date: Tue, 7 Jan 2025 18:44:13 +0530
X-Gm-Features: AbW1kvZFdg73dmST_4wyASXDT7TrZUoeYV-z5vqluRnWxwA9ZHTnXngWd6BAzA0
Message-ID: <CALiyAonc81o1FreDaWiik3XaqKYVf=wYHX+vaE2_1w66LhJTnA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] ACPI: platform_profile: Let drivers dynamically
 refresh choices
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Kurt Borja <kuurtb@gmail.com>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, josh@joshuagrisham.com, 
	"Derek J . Clark" <derekjohn.clark@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lee Chun-Yi <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, 
	Lyndon Sanche <lsanche@lyndeno.ca>, Ike Panhc <ike.pan@canonical.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Armin Wolf <W_Armin@gmx.de>, 
	"Limonciello, Mario" <mario.limonciello@amd.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Alexis Belmonte <alexbelm48@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 7:49=E2=80=AFAM Mark Pearson <mpearson-lenovo@squebb=
.ca> wrote:
>
> Hi Kurt,
>
> On Sun, Jan 5, 2025, at 11:45 PM, Kurt Borja wrote:
> > Hello,
> >
> > Some drivers may need to dynamically modify their selected `choices`.
> > Such is the case of the acer-wmi driver, which implemented their own
> > profile cycling method, because users expect different profiles to be
> > available whether the laptop is on AC or not [1].
> >
> > These series would allow acer-wmi to simplify this custom cycling metho=
d
> > to use platform_profile_cycle(), as it's already being proposed in thes=
e
> > series [2]; without changing expected behaviors, by refreshing their
> > selected choices on AC connect/disconnect events, which would also solv=
e
> > this discussion [3].
> >
> > Additionally, I think the platform_profile_ops approach would enable us
> > to hide the platform_profile_handler in the future, and instead just pa=
ss
> > the class device to get/set methods like the HWMON subsystem does.
> >
> > I think having this kind of flexibility is valuable. Let me know what y=
ou
> > think!
> >
>
> I personally would love to see how this would be used for the acer issue =
highlighted to see how it would work out. It feels like the series is short=
 a patch :)

I do think that having this flexibility would be good, as i was
considering manually clearing the set bits and calling platform_notify
for the acer series, but in my specific case (for devices using the
predator v4 interface) it was found that the hardware was responsive
to all profiles regardless of AC/battery mode so it made sense to
leave this kind of artificial limiting of profiles to the
userspace--similar to how the Windows driver handles it through the
Nitro Sense app.

I feel like users should have the power to utilize their hardware in
the way they want it to, though if there is a compelling reason to
limit the profiles then i'd be more than happy to add this to the
series :)


--
Hridesh MG

