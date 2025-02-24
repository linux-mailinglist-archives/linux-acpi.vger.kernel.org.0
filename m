Return-Path: <linux-acpi+bounces-11441-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D0A4305B
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 23:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F418874A5
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F2D20ADE6;
	Mon, 24 Feb 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ti7M8Z/R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C81632C8;
	Mon, 24 Feb 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437930; cv=none; b=O1961voE7MESPuA0Z3aSdSofTbHsst7AnAZf7obtEfz1Sjlg/YR6QGIQyhNq1mMz5fy6xiO8HnA5rsVicq8MUFXJELomVGvZSqKvKMVl/oR9C/cO81i4GSFp5Ha+VsPDfNKSRd1jpGPvWR6tsgHne5D1HqG7qcKM07+svYNq/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437930; c=relaxed/simple;
	bh=TJEHHy3LCZiP5/62e4brrNFOnBc5vgm/HSV4XuoZGJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hP5R6putAIzXQMqxcLPhY2zX/xT/wFoLVTYQELTACdEYuC9xWciVdSRLrRyrLN1vojFQVvYYjh9FTTTONUeOvS+r2mVsHkr0FJpr1tNs6BWKAxThE8tCfnrDwMAs4d+8xQDlaCm3/gxpptO4bMBHE+Jk3o9vIIhhndJhGWJ4usQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ti7M8Z/R; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 5CC182E07CD9;
	Tue, 25 Feb 2025 00:58:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740437925;
	bh=TJEHHy3LCZiP5/62e4brrNFOnBc5vgm/HSV4XuoZGJ8=;
	h=Received:From:Subject:To;
	b=ti7M8Z/Rh4FC57+sAyKFK4rJ9EhreXuJEfy1K+4PBwUmI/h42bdOvIBRr12r/IEqq
	 MH0Xyb/dR59zf5pMmbqvWxNoMEVh2cwhEdxT1rLjMbjnqCRvERU2YmKUuePgHkNsY+
	 Ww95oJzrOyAV4FQjHCmsrGWElqCGnc7ynMKyzW3g=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-307bc125e2eso46549481fa.3;
        Mon, 24 Feb 2025 14:58:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUC/zWWe/1rHlsSfkOcyK4WtyOlyRC2HVJXkgW85tmEz43rD3C5Kmw53DftI6zuAGnoS7/l2XVg6Yhi@vger.kernel.org,
 AJvYcCW9vbvGB4htch2WLsS3Fxdlnya15rAzGFIGo6CdDn9mK3ZkVQqSa02noTKK9GLXQMGQySD5zOMLWADRl/30@vger.kernel.org,
 AJvYcCXqBq146RfqQXHHp49I++vTvJlEfeS2CfkvkW3zik0XQfdriWg7ykh/9h96b00kKj90PP77bY5pPfUYxS9X19KBXM3ZsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRcM8xZvSPNr14GFLfzYP7liSk8uNvGp9YZlkeg29FKcjBSqv
	LWvzmjYP9Og+1XpcdMySPimAroqDeELcX+bPOzGee6DAuB4f5oy7WIgsXQuyQn8pCO4AB5XybHb
	H792svnvrwnzlZvpvLwqvcu4duqA=
X-Google-Smtp-Source: 
 AGHT+IFgS5Jf8cF5xK8CUiAknTWti5yQK5aihC/1WFVjWYomlVv8iGG0C4+a0qb4GOyJ1vJPthrR7RAup19lAy+6yIw=
X-Received: by 2002:a2e:bea1:0:b0:308:f268:7803 with SMTP id
 38308e7fff4ca-30a80c0f196mr3153271fa.3.1740437924547; Mon, 24 Feb 2025
 14:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
 <9fa91732-3085-4e79-9a8f-b38263ee7d08@gmx.de>
 <CAGwozwHZCLaVD8iRgRxvQNqw3v+T9J+omMF+JoNe1r=+S1-OsA@mail.gmail.com>
In-Reply-To: 
 <CAGwozwHZCLaVD8iRgRxvQNqw3v+T9J+omMF+JoNe1r=+S1-OsA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 24 Feb 2025 23:58:32 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEEbsLOJROm7rW-240Zoqh3K_JOtZE_NL8AnLy1eChR6A@mail.gmail.com>
X-Gm-Features: AWEUYZmaJTQ_l84O0BRgQfX82lNWJ577I0-sniUoCBiXhFLoHswQJUTSGh8FOQs
Message-ID: 
 <CAGwozwEEbsLOJROm7rW-240Zoqh3K_JOtZE_NL8AnLy1eChR6A@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Armin Wolf <W_Armin@gmx.de>
Cc: Luke Jones <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174043792568.5132.11835100726030697445@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Yes, making asus-wmi use low-power is indeed the easiest solution, but
if I thought it was good enough, I would have done that already as a
downstream consumer of the kernel.

I just want to be done with this once and for all, so I spent an extra
hour today solving this in a cleaner way.

Antheas

