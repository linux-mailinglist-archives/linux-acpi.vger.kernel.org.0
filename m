Return-Path: <linux-acpi+bounces-12866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303CFA80FD5
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D1019E4FE0
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA522A7F3;
	Tue,  8 Apr 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzrx13MO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981322A4D6;
	Tue,  8 Apr 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125585; cv=none; b=qLJtuf2EE+KB+u3MAeCncPg+460XRdOmfWKo/LTbs5F3R70e3PYMLOm3A62LYqRhwqsn9y/8BR7MSS2RnDWauNQLOJ43LJDrECYILDKtgqw6Ota3kBJY1qvjTpiH9i0s3HBCla76SifX/TNUP9pjuObwK7BwtBajxhP+htAEgc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125585; c=relaxed/simple;
	bh=5r+8gccGfjZhRBhcCBd1dzGJn2Jkz7RXA3qq2bWhCK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmC2nRh08lPDnLr3LPCHkEQcygw+qfIYWbfVph1cEnF9sHi5ETrB3dulM3A0GALCkkFje3WxolFlvcJHqwtiTEIghPixEx2yROfpfKc6/68ShhsWcKz7qJ1yUvmeL739OLFQF62kNOmnhJVKZIF0JOopk3H3RBQMsadTbpdpsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzrx13MO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31962C4CEEA;
	Tue,  8 Apr 2025 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125585;
	bh=5r+8gccGfjZhRBhcCBd1dzGJn2Jkz7RXA3qq2bWhCK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bzrx13MOl6Y45pMoXjn8QqKm163EL1u/4qzRTOhy23zM+gDi/ZKX8fNA2lq2XB3qd
	 IxJdcD4u+zX/OLe9RKy9JZzPCtgJgMVb4yTFzfeGCZ6miHZX3Eue3JU9Vlxfyq3J7V
	 SLuBUU0chWF1Mb8adeecdr/MVMwML+vAFdceP1LVxGBJyKTl/WJomYQB+N8kdoLKT3
	 MvEIUB859iJz0tM54FgT2PatbG2iY/iRp2mbFdtuOURBbRae5OJLJNnEWlOdvJBqjO
	 7U7pZm/BWNrNn+LWiKwA/Sl0jgKeJp0SwJHIESYmKe/XVWXkyAQQwchP5NvR28K/gx
	 ONnnosx+eqcVQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so917841166b.1;
        Tue, 08 Apr 2025 08:19:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUu1iBPJue4CFtRBIQVuiosug1lgczpJti04HsJh/t8M7/nIgDH78Lo6G9qiM93FJ3RS6ri+iBMCnUIrA==@vger.kernel.org, AJvYcCV4oAfNRjwWJcs29WV7Js9XlnhBkMBWNf/qj0/mdVuUjHnYI0nM5doAGuQExQ99/Ed7iiV92qTKwFikwOcV@vger.kernel.org, AJvYcCW7iODb+YLvdwACsrreMxusM2WtrR8vv55ILZv3HXQtKWVIM4hy5ckDuhrjbpG5/aywWB3Ducc55vLm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3h3bMcveu7pjeetvF0NdpPVvgRaZ19rDV/KR8r5P2//c7cqRM
	fYxhUgBgLIB0QJ4YqNcnD2hIOQaN53xbNBwFMz38ZRLJhWjjTsaxxCudwQS73j1j4nawBftUl+a
	FlUPT0p5rqdRlDqIRYHoce/Avdw==
X-Google-Smtp-Source: AGHT+IF3F02goH1mkXM1CLVQ1LdqaDZim54698ZOk0FvN2HsFWZHQ7Bc94XvEpjtOZ9EFcTOA1a4uKMEgk+52atGWFM=
X-Received: by 2002:a17:907:3f19:b0:ac2:d0e6:2b99 with SMTP id
 a640c23a62f3a-ac7d1976666mr1648980366b.36.1744125583758; Tue, 08 Apr 2025
 08:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <20250407223714.2287202-3-sean.anderson@linux.dev> <CAL_JsqLQvyBvOXJJhRcnVAVx81MUf9YwtyZ5VC-whwY=uoeDXw@mail.gmail.com>
 <52d79db7-f1fa-4695-aeb6-d07d6c2f90dc@linux.dev>
In-Reply-To: <52d79db7-f1fa-4695-aeb6-d07d6c2f90dc@linux.dev>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Apr 2025 10:19:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ_EqsxrY67OPm+t6tU5ikFA-TZ-fFqHPYQMuy16c_kLg@mail.gmail.com>
X-Gm-Features: ATxdqUHSWs5RSXg2lA9S4EXsZuIsQgjtK7SB7Iy6RQkc9ncfm736BRinxEHrnCA
Message-ID: <CAL_JsqJ_EqsxrY67OPm+t6tU5ikFA-TZ-fFqHPYQMuy16c_kLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] device property: Add fwnode_property_get_reference_optional_args
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 10:12=E2=80=AFAM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> On 4/8/25 09:00, Rob Herring wrote:
> > On Mon, Apr 7, 2025 at 5:37=E2=80=AFPM Sean Anderson <sean.anderson@lin=
ux.dev> wrote:
> >>
> >> Add a fwnode variant of of_parse_phandle_with_optional_args to allow
> >> nargs_prop to be absent from the referenced node. This improves
> >> compatibility for references where the devicetree might not always hav=
e
> >> nargs_prop.
> >
> > Can't we just make fwnode_property_get_reference_args() handle this
> > case? Or why is it not just a 1 line wrapper function?
>
> fwnode_property_get_reference_args ignores nargs when nargs_prop is
> non-NULL. So all the existing callers just pass 0 to nargs. Rather than
> convert them, I chose to add another function with different defaults.
> There are only four callers that pass nargs_prop, so I could just as
> easily change the callers instead.

Why do you have to change the callers? nargs value won't matter
because they obviously have nargs_prop present or they would not have
worked in the first place. If behavior changes because there's an
error in their DT, who cares. That's their problem for not validating
the DT.

Rob

