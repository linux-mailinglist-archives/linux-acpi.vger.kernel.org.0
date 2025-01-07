Return-Path: <linux-acpi+bounces-10408-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD40A0467C
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 17:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747953A7A48
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F311F238F;
	Tue,  7 Jan 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En1rYrin"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E30286A8;
	Tue,  7 Jan 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267634; cv=none; b=hnf7s27NqqOZzA9L8D2jIaT27mp0Yd5bLg+W3vD9kPPpZ3iv3RdpX6+2Tglaqzr16MrdmpMudGrPY7Z7+iTNbdI0phNgcE8xR3qzE4bsn7/PlFj2+Ssn0G6QrZUVs62+JI3YCqdHQ312yAwz4Mu+x7Nrsq13A0RLkHtNJI9Jtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267634; c=relaxed/simple;
	bh=tIfDI82fljB97BgeeFGgCqw77DcY8qDUrgRIV7P4Efw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBhW5/JnSo8xbtbDsytV3YFMz/FX2Rv1OX8rEChqThyF1j+QWdHeALOyKWVlA8j/f5E8kroVg6kVRdoeoZgIXn0FN2SDM4wSJxwBVAcPVrSN+l+j2L0QM+LW4wdk9UThjkQ4uCKdCHZ14xmAn+ql1oMsuyJOTRrXoLgVGUaIcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En1rYrin; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso20566089a91.1;
        Tue, 07 Jan 2025 08:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736267630; x=1736872430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkcr5ktMkOuwxjKCCWyvhDIhUx5Iy/R01lCIUJHmLQI=;
        b=En1rYrinLx5QE57NEFphjGXEPsliPBDtrWKLwKfgZCXqZg9dv0Hs6Die3406JiaR8i
         11kgU07g2D8/sA5OTBzBW+4ZSM7qErkX4cxt7aUN5WM0RjQlWEE0aiICTmN1vX0cuQqX
         uK3x2OFPnIiLosvp5n7kjsCk7YUdswwX8y8HyZb3zEx5wcFV1tUeNK1vxRxq7ISiVXPr
         DbTeDBLT/wCfdxRLiLY3UumgO2KbDjsMLWc+usaxXEsfLtG2kojxkP95w4CFWRhEWmuZ
         9c3BWmW61+r+wJcWqHd7NzsXmaCMPgSPlyCU9mX5Dx/jYsJfjMHta3LqxfOuIoflNvwD
         7UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736267630; x=1736872430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkcr5ktMkOuwxjKCCWyvhDIhUx5Iy/R01lCIUJHmLQI=;
        b=Pd5mftb60t1kjbxVfb/+CkrNjEaX0d/xS25KE2Uc5kJmZD4q6JShnaIK0Q0FdjcjNv
         r0ggoeohAFf7+ChVMqwHa5cAB8g/K4eNQZt9YCUCq4t+scXsPkjC1iR822FbLwOWwn//
         jJml9/iEBZ7JMsGWIEpQ/GHpeAM+tXSrLk9iPORytTmoGuJ+e83CAyuxrPFuJ9hAVC//
         agWwYMiU0LkIGBM8E2cxA5D8shPHqlXYGWfn/zP6J04fLDoB6pEMmdeuLyc4HkQPEps1
         qqqCWIiYpufVYspUF2Snm+9IhZUAsOITbNG7CggK6FMEtJ2rl1Ah4OMz2EbsvDUeEv/n
         2xew==
X-Forwarded-Encrypted: i=1; AJvYcCWOyc88+gCtVZ6L6fk6xR2GI3llci5NLsB+yw+1RIUh9zFHf8bEEiByH8uDAvtv1oiGm3vgTE4GONZdVSUdVUB7AgZS/Q==@vger.kernel.org, AJvYcCWp0Z3wodZfrXTEX/feDInptIw5QRdHQY3O91JYyNosoT/wtib1SP/8vyz4whZVGq0jlBw8ldY2sdPqpLgY@vger.kernel.org, AJvYcCWsyBffZtgF0Ho9EmZ9e7wJtAhR0QFRyBaaeHymSIwSpJY6Xxyr20kv9JElJsPlKT6a9tE/pgInHDmj@vger.kernel.org
X-Gm-Message-State: AOJu0YywqLVUpYpYZWyYByQkDUhuEFEEEVtN3QPqlFDWSBK4PFQs59WN
	4t/FbjaBXNqO2LXACriD6hSghR4wREZpiNBBE6ukGPOuOtx4hzpIA6yaCCB0Ecor5lfAlfKsqlz
	fTF8SFI1eS0JjeWaOC+uwiuaKnogoi1lQjmo=
X-Gm-Gg: ASbGncul2bgt36xYChtQxPV0EqUw29IQAEFPub3sD157IZ6joHIESxobtneJM96M5cO
	5/n6DrnLAi1f1KSZJ2Y/qZbabhV9PI46/15f1CIE=
X-Google-Smtp-Source: AGHT+IFXUX/6GiCGPwIr4VhfF7iGCHFgEQUjPIMvipr3d0nTX75oF3cd0FVf8aDasfIy4Ul5kGnVUs8FHiWPMSAU9/w=
X-Received: by 2002:a17:90b:270e:b0:2ee:9229:e4bd with SMTP id
 98e67ed59e1d1-2f53cba7a0dmr5509203a91.2.1736267629982; Tue, 07 Jan 2025
 08:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106044605.12494-1-kuurtb@gmail.com> <33a5b6a2-e4df-4bfc-88a9-a9e8309c7f7a@app.fastmail.com>
 <CALiyAonc81o1FreDaWiik3XaqKYVf=wYHX+vaE2_1w66LhJTnA@mail.gmail.com> <2e71a4a9-6ec6-4ac7-8640-d80dcdfd7776@amd.com>
In-Reply-To: <2e71a4a9-6ec6-4ac7-8640-d80dcdfd7776@amd.com>
From: Hridesh MG <hridesh699@gmail.com>
Date: Tue, 7 Jan 2025 22:03:12 +0530
X-Gm-Features: AbW1kvbXgi7SB_V3mQNjfTUNpnZ_ZXG3CNLkTQ3MXL3vOKQ3ZL9xnFlaRdvJExw
Message-ID: <CALiyAonp1eow2ht_Cmux0B5+-Ukx7YxsE59c4VzwfSvL61iQ5g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] ACPI: platform_profile: Let drivers dynamically
 refresh choices
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Kurt Borja <kuurtb@gmail.com>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, josh@joshuagrisham.com, 
	"Derek J . Clark" <derekjohn.clark@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lee Chun-Yi <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, 
	Lyndon Sanche <lsanche@lyndeno.ca>, Ike Panhc <ike.pan@canonical.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Armin Wolf <W_Armin@gmx.de>, Colin Ian King <colin.i.king@gmail.com>, 
	Alexis Belmonte <alexbelm48@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:21=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 1/7/2025 07:14, Hridesh MG wrote:
> > On Tue, Jan 7, 2025 at 7:49=E2=80=AFAM Mark Pearson <mpearson-lenovo@sq=
uebb.ca> wrote:
> >>
> >> Hi Kurt,
> >>
> >> On Sun, Jan 5, 2025, at 11:45 PM, Kurt Borja wrote:
> >>> Hello,
> >>>
> >>> Some drivers may need to dynamically modify their selected `choices`.
> >>> Such is the case of the acer-wmi driver, which implemented their own
> >>> profile cycling method, because users expect different profiles to be
> >>> available whether the laptop is on AC or not [1].
> >>>
> >>> These series would allow acer-wmi to simplify this custom cycling met=
hod
> >>> to use platform_profile_cycle(), as it's already being proposed in th=
ese
> >>> series [2]; without changing expected behaviors, by refreshing their
> >>> selected choices on AC connect/disconnect events, which would also so=
lve
> >>> this discussion [3].
> >>>
> >>> Additionally, I think the platform_profile_ops approach would enable =
us
> >>> to hide the platform_profile_handler in the future, and instead just =
pass
> >>> the class device to get/set methods like the HWMON subsystem does.
> >>>
> >>> I think having this kind of flexibility is valuable. Let me know what=
 you
> >>> think!
> >>>
> >>
> >> I personally would love to see how this would be used for the acer iss=
ue highlighted to see how it would work out. It feels like the series is sh=
ort a patch :)
> >
> > I do think that having this flexibility would be good, as i was
> > considering manually clearing the set bits and calling platform_notify
> > for the acer series, but in my specific case (for devices using the
> > predator v4 interface) it was found that the hardware was responsive
> > to all profiles regardless of AC/battery mode so it made sense to
> > leave this kind of artificial limiting of profiles to the
> > userspace--similar to how the Windows driver handles it through the
> > Nitro Sense app.
> >
> > I feel like users should have the power to utilize their hardware in
> > the way they want it to, though if there is a compelling reason to
> > limit the profiles then i'd be more than happy to add this to the
> > series :)
> >
> >
> > --
> > Hridesh MG
>
> I agree with Mark, this series is missing the patch that shows exactly
> how this would be used.  Furthermore; what exactly are the differences
> in choices between AC or DC?
On the predator series, the Windows OEM application only allows you to
select the low-power and balanced platform profiles on DC. These
profiles can however still be activated through WMI methods and the
hardware will apply them.

> To "userspace" I fail to understand how "balanced" is different from AC
> to DC for example.
It is not, the profiles or states themselves are not modified between
AC and DC, just the switching between them is affected.

--=20
Thanks,
Hridesh MG

