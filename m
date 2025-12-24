Return-Path: <linux-acpi+bounces-19837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00978CDB1EE
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Dec 2025 03:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95B1301D0C1
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Dec 2025 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0817818DB35;
	Wed, 24 Dec 2025 02:00:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87ED2BB1D
	for <linux-acpi@vger.kernel.org>; Wed, 24 Dec 2025 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766541629; cv=none; b=b3yVAerCwsfPJ1DUYhmIR7aEZJmr8vRTZvcg2oxNwkekLoC9UTtuyctXfwSPFEzUdokBYPu6die2krClFvRr2wW/tpAF+D3CVk4jNwoKLTU7ny3P3gHNOtkXl/ykoNaztflsHTKuAeygybbQx0nXZNDkLkSprpLFYjNlDnmGnSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766541629; c=relaxed/simple;
	bh=bP6OzLvDhPIw8UzwOyVhjy9qPXvncOlFG/g8rgc0Xxc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJkZVzStu0eQgI+OBEc/e8h1FXbjT7eoVkz/CfGtD8sH3Vy7NK1HdhA8io2Hcs9k/D+7gtl5yKL5A4nKmRZDqWXE7Qh7vQlHJQXloVRXY5pLIv9dT329L/m5wrDLQdiYHKPiH/ZzoPa+rqToKjS9ohRQYM1dKyhITE9u5bGMNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1766541573t010t35411
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.96.96])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12084601525523118900
To: "'Danilo Krummrich'" <dakr@kernel.org>
Cc: "'Bartosz Golaszewski'" <brgl@kernel.org>,
	"'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>,
	<andriy.shevchenko@linux.intel.com>,
	<andy@kernel.org>,
	<broonie@kernel.org>,
	<ckeepax@opensource.cirrus.com>,
	<david.rhodes@cirrus.com>,
	<djrscally@gmail.com>,
	<gregkh@linuxfoundation.org>,
	<heikki.krogerus@linux.intel.com>,
	<krzk@kernel.org>,
	<linus.walleij@linaro.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	<mstrozek@opensource.cirrus.com>,
	<p.zabel@pengutronix.de>,
	<patches@opensource.cirrus.com>,
	<rafael@kernel.org>,
	<rf@opensource.cirrus.com>,
	<sakari.ailus@linux.intel.com>,
	"'Bartosz Golaszewski'" <brgl@kernel.org>,
	"'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>,
	<andriy.shevchenko@linux.intel.com>,
	<andy@kernel.org>,
	<broonie@kernel.org>,
	<ckeepax@opensource.cirrus.com>,
	<david.rhodes@cirrus.com>,
	<djrscally@gmail.com>,
	<gregkh@linuxfoundation.org>,
	<heikki.krogerus@linux.intel.com>,
	<krzk@kernel.org>,
	<linus.walleij@linaro.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	<mstrozek@opensource.cirrus.com>,
	<p.zabel@pengutronix.de>,
	<patches@opensource.cirrus.com>,
	<rafael@kernel.org>,
	<rf@opensource.cirrus.com>,
	<sakari.ailus@linux.intel.com>
References: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com> <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com> <030001dc73e8$56e38330$04aa8990$@trustnetic.com> <CAMRc=Meugd9tEDefPnYHidDMTdCP+8fptVXNvqjSi1tjXPuVRA@mail.gmail.com> <030101dc73f1$46a62b40$d3f281c0$@trustnetic.com> <DF5J7H0BSBTK.362ZAJTRBK6U1@kernel.org>
In-Reply-To: <DF5J7H0BSBTK.362ZAJTRBK6U1@kernel.org>
Subject: RE: [PATCH v7 3/9] software node: allow referencing firmware nodes
Date: Wed, 24 Dec 2025 09:59:32 +0800
Message-ID: <031401dc7478$f2246040$d66d20c0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzaRfJPMiwz9071uYI3gJ0t6u2qwFWX8iGAiY76pIB9a+LsAJlPnfRAfA44Bm0M9/nYA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MusMsqF/YqAwz7s9nQYx7UQue6B0CR6ctC53Vx6NrP9uEArPgY4HVlQ1
	yjRTQmIZol6Cwd5hX1lR0EMUqBz0G7dyzcoe1V4mo6eh0UpNUbcFGfalV8iWjwUJ7lNgm/9
	EF0c3r00+2lRKAIOuWz66vtkdh/BsrBKMPs37LVxFWnzaBwjuBG1/EdudYWhtP+msmq4lzO
	I00t77Ffe299HlAzu73K2sXrNLLuTlvtfRDXEF76v1nDWj8/m9Xvz39B0H26cfrVHGsWy4B
	QZZ6xcCHINtvpvbDyoCBnmZFymwhewLpJlm2UAEJEFiguSkkoeEG2MxsS3M6hjUgAB+hvJ0
	iJ/ixaSHZs/2FikRgRZyKqwVd5VrXAgMOd52vaTMptWE+mcAgHgSioFNH8tnB+e8ZZsywJp
	9p6Ba4uSKQExqRlASozqXKQ5AlSlx1RBHfybW6HzCcjEulYEQNza4us/LvyJstKQcC2eCUJ
	z9+1YCp2P/H+fP+5cyC9uKOIAOeASvPrzWLxXku2UGt8Q6gdsAWnvPVpl73AWZ9PkAt1NmL
	RiLTx+/kDHGN1GbWKvRr3Wgiy+MLT0stn1rm/PKfm6hibUnORGsDggNPffopCWNoML1zuY1
	MLjNmxv9xFGc7QAeOfdt2gjj+LZ1ev4SmdlBntNZ4cHYSA6A/QwDB924Wf4W3O/WLU60X9k
	Bl3HTtKiwp68HshzXv9c/8Yc7IgWsjSa+wBjBt+Q5n5b85mkYwuoQpIJmTVHM+iFfrpXVlD
	NNujdoSAIGKlNaeJd6ARqhyubqdbyP/5XOIJweJahmfE2cFP3+LeYN+VtIuW0qFba0yqYEL
	anQWJDDFy3KB9B8+MKxc3+tCQCV3iLE+Qol1Jxb+RiK6E5qiyaGTVD1uHGqSvXgRWE5h2UO
	h9OyzhsgpZDfZ0tZz3yrv2ygjXHXfnXm2zIfAEuw7HtmZgvJlvQXVOXzf0LOr7UBHE2nKAs
	Gh3ub7jvxUdIWZM0IfBPl2JIMyFw3L1XiOD450Jb1Lnk8A0fDJPqzHheuB/bRJDZyO5NM/x
	5o2vsAjmtEFbSONOUTwWaISKhImUzpj77KdNoGJg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On Tue, Dec 23, 2025 6:42 PM, Danilo Krummrich wrote:
> On Tue Dec 23, 2025 at 10:48 AM CET, Jiawen Wu wrote:
> > On Tue, Dec 23, 2025 5:37 PM, Bartosz Golaszewski wrote:
> >> On Tue, Dec 23, 2025 at 9:44=E2=80=AFAM Jiawen Wu =
<jiawenwu@trustnetic.com> wrote:
> >> > And I temporarily added this line to fix it:
> >> >
> >> > diff --git a/include/linux/property.h b/include/linux/property.h
> >> > index 272bfbdea7bf..e30ef23a9af3 100644
> >> > --- a/include/linux/property.h
> >> > +++ b/include/linux/property.h
> >> > @@ -371,6 +371,7 @@ struct software_node_ref_args {
> >> >  (const struct software_node_ref_args) {                          =
      \
> >> >         .swnode =3D _Generic(_ref_,                               =
\
> >> >                            const struct software_node *: _ref_, \
> >> > +                          struct software_node *: _ref_,       \
> >> >                            default: NULL),                      \
> >> >         .fwnode =3D _Generic(_ref_,                               =
\
> >> >                            struct fwnode_handle *: _ref_,       \
> >> >
> >>
> >> Ah I see, we'd assign struct software_node * to const struct
> >> software_node * and it used to work but with _Generic() we need the
> >> exact type. I agree with this approach, do you want to send a =
proper
> >> patch?
> >
> > It might be more appropriate for you to send the patch, and could =
also
> > check if there are any other missed details, like for fwnode...
> > I'm not very proficient in this field. :)
>=20
> There is already [1], which I queued up in the driver-core tree to =
send as fix
> for -rc3.
>=20
> [1] =
https://lore.kernel.org/lkml/20251219083638.2454138-1-sakari.ailus@linux.=
intel.com/

I apologize for not noticing this patch... I did something superfluous.



