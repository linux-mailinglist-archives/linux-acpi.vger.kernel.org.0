Return-Path: <linux-acpi+bounces-18678-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5830C41A1F
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 21:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869CF3BBB01
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D430DEA0;
	Fri,  7 Nov 2025 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6gxHOYz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA324DD1F
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2025 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548680; cv=none; b=tivIACvK22EUn/BJ45W3ictRKTEovdp2qlHkMknym/XX7EeeNW7XjCRY7KyPXHXVPmqjos5zbhYFAwrLc6bl9ax567MM9+hdOxOCnRDlXE29fyu78o39fY9j4UVxAVqD4a7VCD5p+bHtFMX+8VttKE4pDwFecNYwcTFNBhaoQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548680; c=relaxed/simple;
	bh=WTtbFz33dXhqJo9ANoAPz8grF76PUGzuxWS4fyg+qNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBa+82YYIOJjjigorcQipE4SOxLqQPKc49cgDNKNZORU7D/5nRmjtzzbtEspDX/PPCcvFjZ390D4TCSwsR6fTeSlgp7tBYO/D7pYg5wq8SJO1yl4sMUb9QxAYlc2yA5K1VfcXvfWYbno16CAZ2gWQkiw0ZBqvtz5sSUNsU7HhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6gxHOYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278FCC113D0
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2025 20:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762548680;
	bh=WTtbFz33dXhqJo9ANoAPz8grF76PUGzuxWS4fyg+qNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e6gxHOYz6sjSzfeFkx4yUp9Jt0GU/yyM9265M4O8QQdNuhVEOBoaCWS9ipEjqhul3
	 HjyMipjUpFlXH1hICKpIiZ1qxNR711Hbq3wiHADSopuureeCHIaCG3XTEBNHbcpHPt
	 8bZY0Y63h2s8VkeBKhxdSjxMk9mWWUOTJQBuRJIpKh2XP9cX0WHVLr7+1PGBQRkr+u
	 bIlFdrf5xZ2g2XYOENfBDR9kp8kmYlct/z14EuvOadVaBrXbvKsY/FuVuSVBoCD29d
	 GoQwwjYgQg6TaR3QCLLQBgaUHT8Gn28wFbh8nW0MhonWfs0mTxfjPRIJBS2TCAYjxO
	 icld4NRNRZ0bw==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-450063be247so489836b6e.2
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2025 12:51:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHs0wqRS1peX2Hexpq3Ul9SSSB9j1c4fOhupEQUJNb0CdgRUjV0cPsiAeSwwWP1hS0E//TOtzbQwMY@vger.kernel.org
X-Gm-Message-State: AOJu0YxEp5E8IVBiWHNdjJAqoH3Rus5inNb1O3a2i5sAGLPXauCjOp9T
	Qdwk5SMFdsTfiYhCy+uTJgmH/j3qL4PM0p2WH1z+6vbVyehypPMAF5pH9zKXpbesb9A5EU3BfmP
	kM4KFZqWtmpHJJSNe6xDzxSdLZOlNgkU=
X-Google-Smtp-Source: AGHT+IFOeJxOzK13dXv6/IvbdfBV5woURzjQq5it8IcVKiVCMbd4OG+sLlTTZLFjY6qk+dq3Ob+E6g7ptHvyJi3CuD4=
X-Received: by 2002:a05:6808:30a1:b0:441:c851:b3c with SMTP id
 5614622812f47-4502a245b87mr347755b6e.25.1762548679337; Fri, 07 Nov 2025
 12:51:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030023228.3956296-1-kaushlendra.kumar@intel.com> <SJ1PR11MB608336094D9FA095D1EE2EAFFCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608336094D9FA095D1EE2EAFFCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 21:51:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j8T_psbfg-3K0kKOeuU4+wq38_K6cUkJpHydKrEJB8xA@mail.gmail.com>
X-Gm-Features: AWmQ_blyhlNO_UjhwGQxgr6Ic681oF6vYdeQt_Jgvgw5vImntltCgQ2-DPuZLX4
Message-ID: <CAJZ5v0j8T_psbfg-3K0kKOeuU4+wq38_K6cUkJpHydKrEJB8xA@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: mrrm: Fix memory leaks and improve error handling
To: "Luck, Tony" <tony.luck@intel.com>, "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:28=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > Add proper error handling and resource cleanup to prevent memory leaks
> > in add_boot_memory_ranges(). The function now checks for NULL return
> > from kobject_create_and_add(), uses local buffer for range names to
> > avoid dynamic allocation, and implements a cleanup path that removes
> > previously created sysfs groups and kobjects on failure.
> >
> > This prevents resource leaks when kobject creation or sysfs group
> > creation fails during boot memory range initialization.
> >
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Applied as 6.18-rc material, thanks!

