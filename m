Return-Path: <linux-acpi+bounces-14739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C6AEA623
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D21167966
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1B2ED155;
	Thu, 26 Jun 2025 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDNoOTZB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CD2F1FF9;
	Thu, 26 Jun 2025 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965040; cv=none; b=bivuahxhlHr+CUklj58aN00n20v4ZIZC47bwTT7qtu5r6yslbwKvRAr5JSc1u2JMharXeINLF3IhY3FX+fl77hfimpk0GnozNpnXxtCT5dlxuhZW1lLtpw9c8ba6TVrW8G4tH6ixwRuCb5MHS6seYUiwfc3g91KS64vfVdtpTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965040; c=relaxed/simple;
	bh=XmDYRAp6BuOpP4bpcfmam3eGYJQ/2OiIuKHCyXBaPNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvdRe1Ph2o+nBqLyJ3OHWMXL2rEJa+IJi6Sqaop+g2gfC6wUxauqpMvmRL5CtSUIC0mJ4iTSP2wq3JZlsTYFF8fbmP5UlLGDgKzqnLa9tsd+37O0lN5NXcRy3FiNb+tM6wUwzr/dPTyQJ6uoL2cXqmipGPlQHsPjOvyHT5pDNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDNoOTZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEECC4CEEB;
	Thu, 26 Jun 2025 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750965039;
	bh=XmDYRAp6BuOpP4bpcfmam3eGYJQ/2OiIuKHCyXBaPNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qDNoOTZBlCx+zYQ7I9zrvS5EY8SyllnG1Qvy6vcUyT7cl+ceufgmG+ngE+D1laRTd
	 RF/Pjjz71XbM7O7HpxJp2GZvmVrcqBcp363/uG4phklogaE/0/qoEpn23UwVWndBRs
	 j0qDGNLFgLEj/IBfnHcgjQOO5EgrSzjBqW85vbHCkQrJcPrWLzD13TPNJwQzfu5nPq
	 bD0v0VIMqxI/JvRYht6C/DIq3LzFBO1hW3qAsufyhH6sCZnxpnAMJIZe2Cno9/4m+E
	 PYg41QjSJ4q/+jxCr3c2kcgaDFMyTxo2MqLk6hRr9glETZRmMtm/4Nj0OcpqEl9yIv
	 LNLjq1SqLB33w==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4080548891fso629423b6e.3;
        Thu, 26 Jun 2025 12:10:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaSY93ICebYg/vlS4TOUW80/soUs5ulS5keyJieM4QumyfyCML1r6ILUtcutuBttOemhUpO/5POX002S0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ifEXtAm1uYyMGVkqO4mfZaznbRQnRvL+zMT87MpWA8mUdUOx
	SjBPB9ho8DVdoTZL6B4lfr4/xM4lFQM5DgXn2BGlOSPpo2UFH3tzSXqEY9LMWmOYbTxEYg6qeAO
	j3dyrf5gOpo96i8yWwCUfaWycz2ISUxo=
X-Google-Smtp-Source: AGHT+IHD1qmk9pk5B4edgltcIvzD7SMsJJDJK9GTvJZ/7K09X3FZBvZtU7hInMMNNpa59I8HOFbDIrFtBYWyFhGSZNs=
X-Received: by 2002:a05:6871:82a:b0:2c7:6f57:3645 with SMTP id
 586e51a60fabf-2efed67879emr130739fac.18.1750965038879; Thu, 26 Jun 2025
 12:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com> <aFqwWToG3HBe3rEo@smile.fi.intel.com>
In-Reply-To: <aFqwWToG3HBe3rEo@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 21:10:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLvnCto-UQVdRP-JpbmfRC=Z7i3HnDxobWeRdTNsaNUA@mail.gmail.com>
X-Gm-Features: Ac12FXyy2znWc7gcTqJKDAVrB7Tde1FeBdkVhuF4VFkKrysTyrUw5XnYHaOHH5o
Message-ID: <CAJZ5v0iLvnCto-UQVdRP-JpbmfRC=Z7i3HnDxobWeRdTNsaNUA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] ACPI: proc: A few cleanups
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 4:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 12, 2025 at 11:11:24PM +0300, Andy Shevchenko wrote:
> > While looking into warning related to export.h inclusion, I took
> > the opportunity to make the module up-to-date to the modern APIs.
> > Hence this mini-series. Note, the first patch is to make the used
> > type consistent across the files.
>
> Hmm... Any comments on this? Do I need to do anything?

Nope.  All queued up for 6.17, thanks!

