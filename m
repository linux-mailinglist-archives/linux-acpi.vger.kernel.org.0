Return-Path: <linux-acpi+bounces-851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435117D410B
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 22:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2159281461
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43F219E0
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF66ABB
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 18:46:07 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A78B7;
	Mon, 23 Oct 2023 11:46:06 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b4bdb89177so91704b6e.1;
        Mon, 23 Oct 2023 11:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086766; x=1698691566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7qmlsW1aphbWWQFznUoBodF+sYdz65fd6/X5tOb8Ns=;
        b=sK1Y0CIT8/r57x4Q7FkVESE7hdL2NTnL3oWy0oGLQhJqeaSZ+t63Ox7J+9lhs5h0bm
         jx+TV29c04t1BM9JwhEL4E+zTaKz3454bVs+iKxjOs0e76H4H3lblgNd9rxtF7eEWs0w
         NfQWooreBH+KoDHTs/ExV0jWTQ2arNKBW2wC1V0VPicZvnB8Is2RmtfQkoxJGOdYd+iu
         /xkyf0Bh8+d8E2MVDzb5cUBEqGp+uMIYAFOhqzc3OmaSHyvDe6rK3jJYz1XaG9Oj4KZe
         MH3NR3pCN0EJm6TVtTmMv0qq0WLybCxcUb4I6qbXzqWAQvchxb46CYAsFsv5+p2U4WAV
         sIcw==
X-Gm-Message-State: AOJu0YwZdrpZ5n0U24sCUdStSskedU9GU1Ic8+NmyVswAW5LYX6CgZVG
	wY9V23j5mybPHiRxl1hrVAxGv0bb+NEjCto5dOY=
X-Google-Smtp-Source: AGHT+IGS15eSBmMGDbQ6578FNooPNXOmZfULT4eWtObUSpW1lpWIoWGk2LshlD7fu9oFRekvnZM9rUH0iB4abMPca9g=
X-Received: by 2002:a4a:e7d1:0:b0:583:ec88:e0 with SMTP id y17-20020a4ae7d1000000b00583ec8800e0mr10035549oov.0.1698086766162;
 Mon, 23 Oct 2023 11:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023053530.5525-1-raag.jadav@intel.com> <20231023053530.5525-3-raag.jadav@intel.com>
 <ZTZacR86hSmV04M9@smile.fi.intel.com> <ZTaGaDweYpBlxBez@black.fi.intel.com>
In-Reply-To: <ZTaGaDweYpBlxBez@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Oct 2023 20:45:55 +0200
Message-ID: <CAJZ5v0g1nTXRD9D5KxQ2DoSRkaavLGjXVAOWbe3wfDLeoTtV8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] pinctrl: intel: use acpi_dev_uid_match() for
 matching _UID
To: Raag Jadav <raag.jadav@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rafael@kernel.org, 
	len.brown@intel.com, robert.moore@intel.com, mika.westerberg@linux.intel.com, 
	mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net, 
	Jonathan.Cameron@huawei.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, 
	bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 4:43=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Mon, Oct 23, 2023 at 02:35:13PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 23, 2023 at 11:05:26AM +0530, Raag Jadav wrote:
> > > Convert manual _UID references to use the standard ACPI helper.
> >
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > It has a hidden logic that is not aligned with acpi_dev_hid_uid_match()=
.
> > Or revert to your v1 I assume.
>
> I don't see how this has to be aligned with acpi_dev_hid_uid_match() or
> if acpi_dev_hid_uid_match() implementation concerns this specific change,
> since that's not what we intend to do here.
>
> Also, I think acpi_dev_uid_match() implementation in v2 is actually more
> aligned with the previous logic that we're replacing here, since it gives
> us a guaranteed match result as originally intended with strcmp in this
> case. And the "hidden logic" in v1 implementation (match with @uid2 =3D=
=3D NULL)
> is what ends up breaking it in my opinion.
>
> Regardless, for any version (v1 or v2) the usage still remains the same
> in this case.

Right, so it is a bit unclear what all of the fuss is about.

> > As I asked you, please drop this one.
>
> But okay, as you wish :(
>
> Rafael, should I send a v3 with dropped tags?

No need to resend in general, I can drop tags from the patches just fine.

For this one, though, I'd like to get a maintainer's ACK, so it may be
necessary to resend it without the tag.

