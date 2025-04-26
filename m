Return-Path: <linux-acpi+bounces-13304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0859EA9DAF7
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Apr 2025 15:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475E91BA6E3C
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Apr 2025 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D65C77111;
	Sat, 26 Apr 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXcCckU8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605ABC148;
	Sat, 26 Apr 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673165; cv=none; b=hIfYcZyKBlqqbLvnXR8yp/kLnETkSvCj+KZW3jtUej4yb/W93CLXh5TeGaFHjwy3e8oqrrCtMgHT/DLwvJAqIhHSYJ5l6XBwPAySG7FAiVs9O/em0jQRB0Ml8XLJHBxbLYnfDvQiNfmreiLndB705jZqAdP8EJQQh6vNp74/AvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673165; c=relaxed/simple;
	bh=VkCXz5Dyv5Xl7DRt7jpLZ56dgEcM8vVpm6+b0HoXfZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNzKT4fYa3qJjTHhjuoxDsXo+eU32iG+AbciKlTgvjZKp4fkRdLJpEowlOcQBm2ei0Chbf9knwWBpL0Uv7XXP1AG4iSvd2yKFjFe7fyLm1l7CMHybTX3CreGJrMngH4kzC/PySiGZryR+kfqI485kcfSt7mTtY+f87KVWu4DCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXcCckU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEF5C4CEEC;
	Sat, 26 Apr 2025 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673164;
	bh=VkCXz5Dyv5Xl7DRt7jpLZ56dgEcM8vVpm6+b0HoXfZY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FXcCckU8JmtQ179pd297UiT+aLmSBYveeLOp/IMT776SMzicSYmZ5uk7iHpT6pzwg
	 Rxm0NzpCh3yLoTRoIsoOwoqzQGZy8HfKQ/XL269y1xwvnI3sIbk3aRnIo4q4hNmZoo
	 t7FElofKw0Uer66zDzJ4nNU1YlM+jU0465QfAEwn8kSRbqGgQW/CqK8QjEsQ5c55gJ
	 o1B6a2SK2ZBBPLsVwcWuxuRS/ApQWMefut6rVhNKmhgMxfna0QMUGe6VW1+nNWsB0r
	 Bk4/BZJYYotsi31dWkfGt/0F5SOqtbsoDhP0KOjLoOIB+JK0tglxawwqHBdsWsU01W
	 GI3azbl+R0iUg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-604ad0347f5so831668eaf.2;
        Sat, 26 Apr 2025 06:12:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEF9Z+oTVcJ6AWqG8RR+wKHjkU/jI4OsyF8AWcqtCJYuXO61JiTLVeSRNHjeNQrldeDVVRogOuSX7D@vger.kernel.org, AJvYcCVuqtneypUW2xw3mSmvp3VVh4JDCKmEM6IyD/T0lX9QfTiLWnO00mRxK23gBPIt2xnyM0UuLoE6ZI0hCGur@vger.kernel.org
X-Gm-Message-State: AOJu0YxlILFWq/4qqPtCXfaw4p4sKg7IPhOoBQi4JGqwzC1MGMBeHolm
	NWdxwIU6r7hwtrUGE8ZNFU2sAxprrk7rrX6h8lgemsRpMRDGqC1QF8iwxyi9iaH94TluED7rrtZ
	SWrCm5qj33EnnXatjQXStxRGD+X4=
X-Google-Smtp-Source: AGHT+IGP//y7KuRvMvn2qjGggs8FICw0qDZNvhgvqZhto/fMzBabLLv+Vw24b3b4WTZFrkwLpUJD5EsLD6FyaAR801w=
X-Received: by 2002:a05:6870:718e:b0:29e:43ce:a172 with SMTP id
 586e51a60fabf-2d9be84dc03mr1926423fac.28.1745673163908; Sat, 26 Apr 2025
 06:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410165456.4173-1-W_Armin@gmx.de> <91ea8aed-5f98-4e4e-b3ee-fdc86d54f787@gmx.de>
In-Reply-To: <91ea8aed-5f98-4e4e-b3ee-fdc86d54f787@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 26 Apr 2025 15:12:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jOR9=jA=8XASBpxJyXaB4TvXmxcZQWq1qUgq1J4h_tEg@mail.gmail.com>
X-Gm-Features: ATxdqUHifHTfeBpAeqXIMdjPOInWBREEGF2ZrX8nj2LAxJxVEAocw5EQ3OcUzZ4
Message-ID: <CAJZ5v0jOR9=jA=8XASBpxJyXaB4TvXmxcZQWq1qUgq1J4h_tEg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: thermal: Properly support the _SCP control method
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 1:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 10.04.25 um 18:54 schrieb Armin Wolf:
>
> > The ACPI specification defines an interface for the operating system
> > to change the preferred cooling mode of a given ACPI thermal zone.
> > This interface takes the form of a special ACPI control method called
> > _SCP (see section 11.4.13 for details) and is already supported by the
> > ACPI thermal driver.
> >
> > However this support as many issues:
> >
> >   - the kernel advertises support for the "3.0 _SCP Extensions" yet the
> >     ACPI thermal driver does not support those extensions. This may
> >     confuse the ACPI firmware.
> >
> >   - the execution of the _SCP control method happens after the driver
> >     retrieved the trip point values. This conflicts with the ACPI
> >     specification:
> >
> >       "OSPM will automatically evaluate _ACx and _PSV objects after
> >        executing _SCP."
> >
> >   - the cooling mode is hardcoded to active cooling and cannot be
> >     changed by the user.
> >
> > Those issues are fixed in this patch series. In the end the user
> > will be able to tell the ACPI firmware wether he prefers active or
> > passive cooling. This setting will also be interesting for
> > applications like TLP (https://linrunner.de/tlp/index.html).
> >
> > The whole series was tested on various devices supporting the _SCP
> > control method and on a device without the _SCP control method and
> > appears to work flawlessly.
>
> Any updates on this? I can proof that the new interface for setting the c=
ooling mode
> works. Additionally the first two patches fix two issues inside the under=
lying code
> itself, so having them inside the mainline tree would be beneficial to us=
ers.

Sure.

I'm going to get to them next week, probably on Monday.

