Return-Path: <linux-acpi+bounces-17571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F56BB7A10
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 18:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C00A5347685
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C872D4B5F;
	Fri,  3 Oct 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyIpRZ10"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE092D46A1
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510635; cv=none; b=cE7NCGjdp/X/5N1w+GHohz//+3BtiO2GZbnLNof5kss7UJYF1DfX7k1yISJR76dshshaNFhYG4TiYshr6kvP5vSC3TAEjBQ1nd3kXM8GfdxOKxgvzEprLKy4SPwEssrWhVsFEm8I0iAQYmn2cE0pE49vN9NARPzzeVcBkAfNNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510635; c=relaxed/simple;
	bh=fhtGb8MKf0acPfP7W+qYvuGjDAQFV/6NeqY3BWv6/q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUqfm6CSaysKJyQokQuX+ncXAUu41TzBkQl5A61HMiIOigO+VhO77GWfADMEZ13mz32lZrS4HNi61knMeVVqCw52nMlFMOuMwpxUJgryCdzMW4167SSZJk/E5QB6V25GpPAwFRo8i+0E7DD4cZ5eao04aHqAao7Hg0oJ3FW2sMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyIpRZ10; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-33c9f2bcdceso4504061fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759510632; x=1760115432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhtGb8MKf0acPfP7W+qYvuGjDAQFV/6NeqY3BWv6/q8=;
        b=WyIpRZ10LdSclUQ8BdebSdYqLgOQ3eTHafYx0s/J+Kt7ysDDbj9dtN1qOuye1XNGdH
         UCdpg7qDKeHmV+LbkcztEttYXPUrckY3DKoAApTBtgTlaFD1zI7tXMlj2/SWJDJKr7oo
         Yf4tgc5MSJ2aakoZqx83xODWvAzWpkNaPp5uxTSSN0DxWFuz4IbROtU3cqcyB8t2+hdU
         ZbuYD/YhP832Jp3e5+bKkHQ1eiZWEGGK32d+BjB5a0FkQFN6PFoP8X52riru3mdvG6XH
         hMMtaMr8WFYH4PyGcu+sPCcM/Xx6hJ1kjAhO00Nb2q9VM2I5oknDlnkzJETofbciIuB0
         cM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510632; x=1760115432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhtGb8MKf0acPfP7W+qYvuGjDAQFV/6NeqY3BWv6/q8=;
        b=s7okS2qV4X/MQsCcQWo2XdL732fJi9NBbYyzJg6j180EnzTiX/cisf5R2ivqbFZl/S
         sASlf7iDO4G5qtlQ+cz/bnMIo9Sfc2v9NiILNx298wALD3o1Yniah062i2UpMaUeDyd/
         t0W1bw6XaCO5zyr/CPprLNDPItD/Vd8e2e4+Shpt+xdM6rgvOba6Dwi91jG9dr9vRixx
         NZLLZWehiaGvBFGFQSpyya4fXgYLygHlKcvwbJtlfq+4ncok3nLJ4njY6owUFkrFPM/x
         0MZvjNgu/K8Lv4Vn0ZxUymtxhHllLqaQVJSzNXL0l8cUpco5J5V9W6ee/wyPFgyNU94Z
         Hflw==
X-Forwarded-Encrypted: i=1; AJvYcCWVsEVliwEtFWaatyrxQp8BKZn8caQYRjmmbHWKkCX6Gng1vaONx4L3qNBkwjHCqLLXWBtc/ccQzWrz@vger.kernel.org
X-Gm-Message-State: AOJu0YygouHHYnIxR9Z68T/CQTF9cbNN4id8iAvJ+Hhda8khkXecfy2w
	R8tvm55s/QL036S0BdX7tEG998wj9lqMGfPnQfMbA076peU8N2yKjmEYfsOvmBYqy83E69+XYtX
	mQxtiX5iQZWfCcDO2wC9rDkWM8XHCve1ynNNtZgu4
X-Gm-Gg: ASbGnct2IAC0ZWGb6nbR9j49+lWQIivwwi5Upw9Q6BJATkYUPZ3SukUXdYFSmgA1WwW
	iq0/l1uk8LJuN2VyKFbQI2nauyy3QwuqZHpek0zWoKkxrYt5JVRa1AVzmZW0b8yx+3JDMKpNSZT
	B0jJ0qj8h0/EpCsRDjeDs753kX4ZZkEHWoKlkoES3eVber98yk0a5uicCYwbJwxGyS7qLkPwCBt
	Fa5Ee6wYZRHy+rJgnhz9ZrPdFApQ1wpYNIiWw7uqn3fgo71yzdy+6F8iFQ=
X-Google-Smtp-Source: AGHT+IHx4msmP8R5V9b/xox6XRZLBn0CUiuZpFE8vOZ7vDw17w2ogkYyO9PNCJUCLBBZcfaX3qrzD8wpS9Karp2Eb1U=
X-Received: by 2002:a2e:bc0b:0:b0:368:2cf8:5121 with SMTP id
 38308e7fff4ca-374c37e9321mr11855241fa.27.1759510631679; Fri, 03 Oct 2025
 09:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929174831.GJ2695987@ziepe.ca> <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca> <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
 <20251003120358.GL3195829@ziepe.ca> <CALzav=fci3jPft+SXJ6tPG3=jRX7jjJPwnP=zWAb2Sui++vKPw@mail.gmail.com>
 <20251003161642.GQ3195829@ziepe.ca> <CA+CK2bBLuGAMwVgj87p_H12P9yy6J99WwX8vwZbFfY0RTYsXDA@mail.gmail.com>
In-Reply-To: <CA+CK2bBLuGAMwVgj87p_H12P9yy6J99WwX8vwZbFfY0RTYsXDA@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Oct 2025 09:56:44 -0700
X-Gm-Features: AS18NWCIcQQViHOaxbODIYnXboXPFcH0JzxYcP4VPxMerxQhIMypGFFdK4P9F68
Message-ID: <CALzav=c9wJvN2Hy+XNjZfmKFEPomTyMBVfCXQ4601_CtN7SXfw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:28=E2=80=AFAM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> On Fri, Oct 3, 2025 at 12:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
> >
> > On Fri, Oct 03, 2025 at 09:03:36AM -0700, David Matlack wrote:
> > > > Shutting down enough of the PF kernel driver to safely kexec is alm=
ost
> > > > the same as unbinding it completely.
> > >
> > > I think it's totally fair to tell us to replace pci-pf-stub with
> > > vfio-pci. That gets rid of one PF driver.
> > >
> > > idpf cannot be easily replaced with vfio-pci, since the PF is also
> > > used for host networking.
> >
> > Run host networking on a VF instead?
>
> There is a plan for this, but not immediately. In upstream, I suspect
> vfio-pci is all we need, and other drivers can be added when it really
> necessary.

Sounds good to me.

