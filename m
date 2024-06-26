Return-Path: <linux-acpi+bounces-6613-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC749178EF
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 08:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB6BB21B5F
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 06:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ED614D6EB;
	Wed, 26 Jun 2024 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4sb1/19"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8913A869;
	Wed, 26 Jun 2024 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383388; cv=none; b=AZihES0E6Vr0JtQA0b4J24Sm6N1Q443wtGHTV61HRnDWvsZNX0zfzfMNjepgW0W6ommu1syqTySAb/W/rTtCotXtMStQAOrE4lvySgysZjI2jyfTxUr0t+vm+cqW0pQzETY+opeze+emJo3FcNxSoL6lE+mdhHJSSJ66vgi2mVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383388; c=relaxed/simple;
	bh=wcTOigAllogu0DSwfrGUFSIGPo2YkJCiUGsMUNsrS1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUsYhMWgJQKj2/lvvkMM9EbY+7NvPevvM6YlClONHNYdxZBkfPssMNgu/1OOjsf6bi3wf/fxRYQfipEMKkWUAraCFVx/uM6U77Qp3MFZnOGGLLHeveewZ/aL60HBU00ijvCRQ1JkqbUwB7hc23fSSFQettUgW3wenQ0ZUwKWNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4sb1/19; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so7228530a12.3;
        Tue, 25 Jun 2024 23:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719383385; x=1719988185; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wcTOigAllogu0DSwfrGUFSIGPo2YkJCiUGsMUNsrS1M=;
        b=M4sb1/19vOECk7+3+25kXwV8ruCLXC0vNncNCPzlKESixAi5abS6JTZNfEtGfTs9lN
         Z2U0rExUA6YBRn0dlnFYT3VBjqlqS/hQz0k7QwlmPi2wdhr2pMirBK0xVZyySp9FMkN4
         DYs94bn+OTPpGXVOs/zLhyiIxmFrq37aODH3OLBawCKNAH1JCvNHYMEI8BzfgHGXn62Y
         Y1vMY26B8t9W2PjsZcHe45eiSVdHd0R9hzKWic+KE8CkbEJopDOIjsJoL8TFJfs+cH4/
         M7yA1bb1WSafpPUGKADZyO9cD/mrz2CCmPY6ryqGKZF+yTmU38HvxuokkZwzZFFhj/ob
         QEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719383385; x=1719988185;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcTOigAllogu0DSwfrGUFSIGPo2YkJCiUGsMUNsrS1M=;
        b=kmxHzPzJJwYj/7A4mYsCamBLHVcYNamy2QnjEuSygsV9ZNXN7Zw15gE6+U2hfJS3WR
         cGCI3FDwds+yxMTaCs1/cqa5MQviVYmU5RAK66WRnSQob6YQNC47bIKNNYFnRAEotHqK
         lwPvUL9FrFsUkNZ2JTrZ2rY4/7a/Yk7R2liOJwXD7Wn7p0MLuawLF8DHiDbKjSrm5Bj1
         VRPQFaZrPb9pUR4BNY0RCjuPxc27eKhdze291hv5iAUzW7yikX/j6Ls/g7cfqnNNcwpe
         ARICz+TWbdsdWn2B+efMrgswkEY1wCTqobpNuHcd74W0KWaSRnwRq7qGUaCNH0kxO2g1
         MoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT07E4rTxKOlRkq8grMyB5mmhsa0I2YqjTmbD6dyW4SuPXV6Fo7wjJYCDKGpfX+yua3SQ5N7r2Lkc9pSJXD0xc00G8bzMkRmBEqQkfyfJ+UowtPgGrj1CEEDsn4earzMIg1r2x9Dx3YElIdyQejphuin8jWvijV1/siA5CuILuo82yFMyx3d0A//RLxIo+OgBXgzOytaqPrcMcRFgcXekMEQ==
X-Gm-Message-State: AOJu0YztiUQ0ZEiSOrOi+dSCq4PFPqS29D8tdBh1fKP21/tbRAaWxfKC
	l+tCt5Y/aqW3MVm/SsuxNkpZ907zLStfkDEIdj+JAOM4IVpmBdRP
X-Google-Smtp-Source: AGHT+IEUoyW0X469t4cMCMQD6yp4U9TgW6q8ZrFrHJwvys/gFlNpzy8MrNRr98L4zzJEB6+G47h3zQ==
X-Received: by 2002:a50:9ee6:0:b0:57d:5bc:56d9 with SMTP id 4fb4d7f45d1cf-57d4bd5630bmr5980637a12.2.1719383384511;
        Tue, 25 Jun 2024 23:29:44 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30534e2asm6812991a12.70.2024.06.25.23.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:29:44 -0700 (PDT)
Message-ID: <7b194e7c4a96cacb13756b05ca7738010742eb12.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] hwmon: (ltc2992) Use
 fwnode_for_each_available_child_node_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,  Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, Rob Herring
 <robh@kernel.org>, devicetree@vger.kernel.org
Date: Wed, 26 Jun 2024 08:33:35 +0200
In-Reply-To: <ZlSY8tjYm5g9bEJ_@surfacebook.localdomain>
References: 
	<20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
	 <20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
	 <20240526144851.493dd3f2@jic23-huawei>
	 <ZlSY8tjYm5g9bEJ_@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-27 at 17:30 +0300, Andy Shevchenko wrote:
> Sun, May 26, 2024 at 02:48:51PM +0100, Jonathan Cameron kirjoitti:
> > On Thu, 23 May 2024 17:47:16 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >=20
> > > The scoped version of the fwnode_for_each_available_child_node() macr=
o
> > > automates object recfount decrement, avoiding possible memory leaks
> > > in new error paths inside the loop like it happened when
> > > commit '10b029020487 ("hwmon: (ltc2992) Avoid division by zero")'
> > > was added.
> > >=20
> > > The new macro removes the need to manually call fwnode_handle_put() i=
n
> > > the existing error paths and in any future addition. It also removes =
the
> > > need for the current child node declaration as well, as it is interna=
lly
> > > declared.
> > >=20
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >=20
> > This looks like another instances of the lack of clarify about=20
> > what device_for_each_child_node[_scoped]() guarantees about node
> > availability.
> > On DT it guarantees the node is available as ultimately calls
> > of_get_next_available_child()
> >=20
> > On ACPI it doesn't (I think).
> > For swnode, there isn't an obvious concept of available.
> >=20
> > It would be much better if we reached some agreement on this and
> > hence could avoid using the fwnode variants just to get the _available_=
 form
> > as done here.
>=20
> > Or just add the device_for_each_available_child_node[_scoped]()
> > and call that in almost all cases.
>=20
> device_for_each*() _implies_ availability. You need to talk to Rob about =
all
> this. The design of the device_for_each*() was exactly done in accordance=
 with
> his suggestions...
>=20
> > In generic code, do we ever want to walk unavailable child nodes?
>=20
> ...which are most likely like your question here, i.e. why we ever need t=
o
> traverse over unavailable nodes.
>=20

I have some vague idea of Rob talking about CPUs being one of the reasons f=
or
the current design. Don't remember for sure. At least (if not already) havi=
ng
this clearly documented would be nice.

- Nuno S=C3=A1

