Return-Path: <linux-acpi+bounces-10414-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F63A0481E
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE716535F
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EEE1F4E4F;
	Tue,  7 Jan 2025 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4mvV88d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4F1F37B8;
	Tue,  7 Jan 2025 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270750; cv=none; b=InT2XO9Bl5kABkb2gKZOx1mEdvfhwAzjEpXMJFfLjDXlZRiX5vuzYhyBsBN3QYZVYLwsGP8gUANSvtbO1OzquN43RobcETVP52YRC/iP8pwzae+txBHhKwPXrnXeDLSIEceowo/XJk3Ct2663ZUGWzpl+YOltHKWHs7Z8D5V0nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270750; c=relaxed/simple;
	bh=P9t+yMktnHNVfsv+x+epHKYdLj72zIeZxu8ub0Xdi3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfa2Z+wzO5WWZNOBBgPoMwCQEDRYSDx8olQAof+4zGooryKhhe+xWNiBCV8jPJ29fq6FsYzoH5tSvPxuCjuEAYygMrnjcRezkIfALYGuYrrqpeBqjdpqwOnhkJ3r+khcU852et5dzNgjF88rRgCb3J5YHEt2sTqgUaDZUC5J0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4mvV88d; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85c436db302so5624241.0;
        Tue, 07 Jan 2025 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736270746; x=1736875546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DLpfsxsH8zBff1mg2vsy7m+Lf2nrbmoBVb1UPiwsnV8=;
        b=l4mvV88dd+2J0O2yH0+RLmveHMA7L1EuEBPfLKuj+1C0utrP611SPBaEgKN2gN2KIr
         krhjRQPF8nZbny3PSe7M+8P4a1MrharrBZ5AkCiGPCDvuU4mYVmdz8nA+1MMSojD8bZ2
         gPf7T4IlQWUPdPI4pHHfRRRnQ3fIgptJe6FGR9cG6FkIJQjnBJFfKzGHk3Ntq4t4Da6e
         LeV+g/TMa6Xsq7lJi1HtkGuDFPqzTXCAkhgYGZZO9r6c3tCHk8G4CGZP/JlcpPNjD+DQ
         ClItgMh6eyWxXpBEiUQSL4kJ5ARBIDURplkfC201pAYjdv49I7gdwub/0QsevP8q2Tbm
         6yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270746; x=1736875546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLpfsxsH8zBff1mg2vsy7m+Lf2nrbmoBVb1UPiwsnV8=;
        b=Ddzlj23jN5o3LA9NILoC/i4twsNAZ1X5Ts6TCQz8Ek0oPRIvoCmnEt+JWXWegCjewJ
         H5rsh6EtjKeqHDZmkTeZoGB0YUSBqy547LjvPdhDSpqijF/WOSq6BTT0oLpq8129yu7K
         TAwHNvrDg1SwA1Gpu5amFR1ZfS284Hr7/HAoCND62wUxml5y+58bCZux351x+zQ57FLr
         c6yxVqby40FTClKjYt3yvyOk+lB8rD+a2qUNguzAeCdTOE+0g3jfl1gQT6m4ycAxu84D
         Z1asIIjPhI6gEuD9GH/DmHl3d4SG2n6iYPhkVKcKqtFvB9EN3BLb+eE85xU0WMzZrlTs
         XypA==
X-Forwarded-Encrypted: i=1; AJvYcCUhhp1y3TnEEWcS+r2+rho4+u4MetNEhEgHdJg1fjBtv8YiyzuMQ8CsGCxHHo0/lIebzymYOfwWdOPl3oRJ@vger.kernel.org, AJvYcCWFptzJP5I83zBPDraVV0wwAUazCrtPsGSkTVrSI1XnV20YZ7k1VGcBLUDrYBdDzllBj9p1/RVUo15A@vger.kernel.org, AJvYcCWKIoPeQLRb+56nnexcBQZa78voJ0rbeAYANGNpm9NqvCgdmIRlSp41YXJWdXn6+zpb+/8gavLynXgUrBIxhJy6mvnZRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeh9LuvtSmUFRCysA+P+uqh8ZgdvpJC9xC8WJ/T76UOfnOQ/Aw
	5a1Hamt/kZJ5AQ57MYxOwfc828O1ij8XZGrCPQCL7uDFXoI56b7DzwVlW2jt
X-Gm-Gg: ASbGncvEQnOTY7IfZTrq1bIOOTZIp8JpzLnRuxncXQVyLKa/likSBW7j6DcVOAHjvdb
	NHGxdsHRiI45A30chpd+VxxzGBOa5tuwe6YC6vSw8+3fgR3zYOKwFNW3L6STgErGPl0uJ9VPGu/
	FAHYwO8mw8UiVw3Sp0o8zP1+Dky+PuhBCRytru6ShZ3ItCpzpS6ofsKmt53Q3fiWNWEK9a55Q1f
	40L29vmkPLTZsj5I0rF2VYB872WM6+lrtfhvHGMOc8gZDJ+g4N52A==
X-Google-Smtp-Source: AGHT+IEwvLhACfk74kgCoBRRXG3TNRsw6k9OAGNyK0Ns7EbFgnrcSon/7GQZYwV/4Gb5KlXn9/iUPQ==
X-Received: by 2002:a05:6102:374b:b0:4af:fc7d:b74a with SMTP id ada2fe7eead31-4b3c1e1f315mr2971663137.2.1736270746331;
        Tue, 07 Jan 2025 09:25:46 -0800 (PST)
Received: from alphacentauri ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf9b9191sm7805259137.13.2025.01.07.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 09:25:45 -0800 (PST)
Date: Tue, 7 Jan 2025 12:25:40 -0500
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
Message-ID: <zelin5tbkup26skhs3dwacwxl33h4ryzgrn3nefay7fxotb5v7@aumb6v7hexpc>
References: <20250106044605.12494-1-kuurtb@gmail.com>
 <33a5b6a2-e4df-4bfc-88a9-a9e8309c7f7a@app.fastmail.com>
 <CALiyAonc81o1FreDaWiik3XaqKYVf=wYHX+vaE2_1w66LhJTnA@mail.gmail.com>
 <2e71a4a9-6ec6-4ac7-8640-d80dcdfd7776@amd.com>
 <CALiyAonp1eow2ht_Cmux0B5+-Ukx7YxsE59c4VzwfSvL61iQ5g@mail.gmail.com>
 <205c47ef-6651-4a57-bbe4-adf1b8a25983@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <205c47ef-6651-4a57-bbe4-adf1b8a25983@amd.com>

On Tue, Jan 07, 2025 at 10:47:39AM -0600, Limonciello, Mario wrote:
> 
> 
> On 1/7/2025 10:33 AM, Hridesh MG wrote:
> > On Tue, Jan 7, 2025 at 9:21 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > > 
> > > On 1/7/2025 07:14, Hridesh MG wrote:
> > > > On Tue, Jan 7, 2025 at 7:49 AM Mark Pearson <mpearson-lenovo@squebb.ca> wrote:
> > > > > 
> > > > > Hi Kurt,
> > > > > 
> > > > > On Sun, Jan 5, 2025, at 11:45 PM, Kurt Borja wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > Some drivers may need to dynamically modify their selected `choices`.
> > > > > > Such is the case of the acer-wmi driver, which implemented their own
> > > > > > profile cycling method, because users expect different profiles to be
> > > > > > available whether the laptop is on AC or not [1].
> > > > > > 
> > > > > > These series would allow acer-wmi to simplify this custom cycling method
> > > > > > to use platform_profile_cycle(), as it's already being proposed in these
> > > > > > series [2]; without changing expected behaviors, by refreshing their
> > > > > > selected choices on AC connect/disconnect events, which would also solve
> > > > > > this discussion [3].
> > > > > > 
> > > > > > Additionally, I think the platform_profile_ops approach would enable us
> > > > > > to hide the platform_profile_handler in the future, and instead just pass
> > > > > > the class device to get/set methods like the HWMON subsystem does.
> > > > > > 
> > > > > > I think having this kind of flexibility is valuable. Let me know what you
> > > > > > think!
> > > > > > 
> > > > > 
> > > > > I personally would love to see how this would be used for the acer issue highlighted to see how it would work out. It feels like the series is short a patch :)
> > > > 
> > > > I do think that having this flexibility would be good, as i was
> > > > considering manually clearing the set bits and calling platform_notify
> > > > for the acer series, but in my specific case (for devices using the
> > > > predator v4 interface) it was found that the hardware was responsive
> > > > to all profiles regardless of AC/battery mode so it made sense to
> > > > leave this kind of artificial limiting of profiles to the
> > > > userspace--similar to how the Windows driver handles it through the
> > > > Nitro Sense app.
> > > > 
> > > > I feel like users should have the power to utilize their hardware in
> > > > the way they want it to, though if there is a compelling reason to
> > > > limit the profiles then i'd be more than happy to add this to the
> > > > series :)
> > > > 
> > > > 
> > > > --
> > > > Hridesh MG
> > > 
> > > I agree with Mark, this series is missing the patch that shows exactly
> > > how this would be used.  Furthermore; what exactly are the differences
> > > in choices between AC or DC?
> > On the predator series, the Windows OEM application only allows you to
> > select the low-power and balanced platform profiles on DC. These
> > profiles can however still be activated through WMI methods and the
> > hardware will apply them.
> 
> So on Windows if you are on DC and pick "performance" then go to AC it will
> automatically switch you back to "balanced" and you can't pick "performance"
> again until you go to "DC"?
> 
> This sounds totally counterintuitive to me at least.  If you're going to
> gimp people on anything, gimp them on DC.
> 
> > 
> > > To "userspace" I fail to understand how "balanced" is different from AC
> > > to DC for example.
> > It is not, the profiles or states themselves are not modified between
> > AC and DC, just the switching between them is affected.
> > 
> 
> IMO - just because Windows does this doesn't mean we need to in Linux. If
> there are only 3 sets of profiles, I'm of the opinion we should let users
> pick any of the 3 profiles in "AC" or "DC" state.

Hi!

After giving it some thought, I agree with you and Hridesh. Kernel
should not limit profile choices if they *are* selectable.

If a "proof of concept" patch is still interesting I'll be glad to send
it, otherwise I think my original idea has too many problems. User-space
should be able to handle these special cases.

I think an attribute allowing/disallowing power sensitive values is
interesting. Maybe allow users too attach/detach individual profiles
from being selected/cycled? On that note, it would also be interesting to
be able to detach invidivual "profile handlers" from the legacy
`acpi_kobj`. But I'm not sure if this added complexity would be worth it.

Anyway.. Mario, do you think hiding platform_profile_handler from
drivers is something worth pursuing? Similar to what the hwmon class
does. I feel having some struct members like `minor` and `choices`
exposed, or having the profile_get/profile_set callbacks not being
const, while it's not the end of the world, could be problematic.

~ Kurt

> 

