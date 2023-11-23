Return-Path: <linux-acpi+bounces-1788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC67F61B8
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 15:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466951C20ED6
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8225764
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnc7UROO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927631A8;
	Thu, 23 Nov 2023 04:51:29 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cbe68095a3so472680b3a.3;
        Thu, 23 Nov 2023 04:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700743889; x=1701348689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lua/407sLR7U5g7Ynk/F+LhzLi2h/XJEhubjfBRyzWM=;
        b=Mnc7UROOhWvLQSEPUeJ+YFi9OKXv/e+PO6Ic2xiVyQeZSevJE17+3Bsl/Xl84F4K9r
         xR1woIhMAHnCiQbkTwZuymrq7TZYouo6/5MsZB5WvEXQjmy+YV/vMGHc4dIbH+LaBLCr
         muUnJcNXkmbHOk04hW8IgX6O2ra7NA0/6u8zaVFrRqSt7bn7nXUhK8IuRWlNI/VhgPCu
         Kt6feXDQ8CYC8wLETiUxdW1VLCTDa0V0mnijz51lu5WwYMo0fEzJSW8QLqERTUyxp92Q
         KFRumfhe+YqGMzyxs8RpC4dlQWHH8t5zzELl1XiX5O1PNsXURIex2KrJ+SWT5faIif+g
         w4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700743889; x=1701348689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lua/407sLR7U5g7Ynk/F+LhzLi2h/XJEhubjfBRyzWM=;
        b=SQah+YOcZd/gp5gTQF2cpYrmK5FzFarR9gfPaJDYEgNDiDo4iJJsVG04T6bDsqqjsp
         v8dGYJFUOEIwd+Ueu7RjwV3GEPa3Hv5M7vUMMqmiYgR2GXO0nttSXAd1rcxHNQ34KL6/
         4aatx1Sasx7bfWHICONwxhPxufV3B7TG5t4zf61JLxLBn8QfPOAJLusjusn+85usoE9c
         GLrA6+6o/sliaikoj7Q3WdGVR5l5HeLQYnmLyRRgi32hhHofLiGoGIyFsTERF7anXxPT
         0oVdXjsvoaYgyFP/lwKrx/pQH4JShWXhEEG/DeeuK7onh0+7D8BNOLSWYpcp0lNnT7mg
         pbpw==
X-Gm-Message-State: AOJu0Yxz4y3mo+zQsNcfSkjXedSHWFUMSMdduEbeJS4SW2KrT5Ddr6MX
	0vdkthYuq9HngB4hOj4PRGA=
X-Google-Smtp-Source: AGHT+IHPjfg2D7ucdRYYUKQc6MDSWRv+kQYYT7mIt1RvV6aQz7kIkjD5Y2nMDmRJHpUcwd6d13d8bw==
X-Received: by 2002:a05:6a00:180e:b0:6cb:8c91:682 with SMTP id y14-20020a056a00180e00b006cb8c910682mr6205845pfa.29.1700743888923;
        Thu, 23 Nov 2023 04:51:28 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p126-20020a634284000000b005b9288d51f0sm1285107pga.48.2023.11.23.04.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:51:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 46F561015D896; Thu, 23 Nov 2023 19:51:24 +0700 (WIB)
Date: Thu, 23 Nov 2023 19:51:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Linux regression tracking #update (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Arnas <arnasz616@gmail.com>
Subject: Re: Fwd: [Regression] S3 Sleep Mode failures since Linux 6.x on Dell
 Inspiron 15 5593
Message-ID: <ZV9KzFGSqFsJl4YA@archie.me>
References: <585dcc9e-7e72-473a-98ec-4f06018d542f@gmail.com>
 <ZV4AP1GY3fHAxmtx@archie.me>
 <bbeb662d-78d0-4157-b062-b061eab66088@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0roWu1Dj6Rps07pF"
Content-Disposition: inline
In-Reply-To: <bbeb662d-78d0-4157-b062-b061eab66088@leemhuis.info>


--0roWu1Dj6Rps07pF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 05:55:20PM +0100, Linux regression tracking #update=
 (Thorsten Leemhuis) wrote:
> On 22.11.23 14:21, Bagas Sanjaya wrote:
> > On Tue, Sep 26, 2023 at 07:25:48AM +0700, Bagas Sanjaya wrote:
> >> I notice a regression report on Bugzilla [1]. Quoting from it:
> >>> I'm having some weird issues with sleep mode on any 6.x Linux kernel =
version - it's a toss-up when I close the lid as to whether it will sleep p=
roperly or not - when it fails, the screen will lock, but it will not actua=
lly enter S3 sleep - it just blanks the screen, but the laptop stays on (an=
d fan does too).
> > [...]
> >> #regzbot introduced: v5.15..v6.1 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D217950
> >>
> >> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217950
> >=20
> > Hi Thorsten and all,
>=20
> Bagas, please ask me things like this in private. Developers get enough
> mail already, we should try our best to not increase the amount too much
> with stuff that is just there for regression tracking stuff.

Thanks for the pro tip.

>=20
> > It seems like the BZ reporter is really busy with his college life; IOW
> > he can only bisect in the winter break [1]. Should I mark this regressi=
on
> > as inconclusive for now?
>=20
> Let's put it on regzbot's back-burner.
>=20
> #regzbot backburner: will take a while until this is bisected
> #regzbot ignore-activity
>=20

Thanks for the handling!

--=20
An old man doll... just what I always wanted! - Clara

--0roWu1Dj6Rps07pF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZV9KwwAKCRD2uYlJVVFO
o35oAQDoFPGsSeS0PpX/PIJJXi1UPNnPCUCfsAgPSjHS5ehV8QD/ezxLrWj+jpxC
r3pi76SjlUG3gRAWA6s84IJVjT9oPgA=
=mjAB
-----END PGP SIGNATURE-----

--0roWu1Dj6Rps07pF--

