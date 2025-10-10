Return-Path: <linux-acpi+bounces-17734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9A7BCEC71
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Oct 2025 01:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DBE3A482A
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 23:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F147F2EA164;
	Fri, 10 Oct 2025 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BupDfTxv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373472EA14D
	for <linux-acpi@vger.kernel.org>; Fri, 10 Oct 2025 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760140197; cv=none; b=lQK1Dp1YgmRz4iYtz6YYJ01rdzx2X6i9eAgK374JKp29vBsQM5CDf7r/wE3esfv72IZnlAcgx9oeGagjMmbTm1UIMmi5xN4Bfm1oh+isNgNdtnc7uZopvECQEC7eL0/hQrePsBpOYLRl1Av2K9U6TqfMLfq4pjex9VZYKRfSWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760140197; c=relaxed/simple;
	bh=nWteJCdTRmV6+9s9peexAHreadwYn0foAUOzTTldCew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fwt72MeV5Sx0+naC0Reny6N3toiNyAZsNHFjfT1JocSpCXrGf7IC7ZwB0rtFGNtNI7HzOJ2uQcMDMO59imh3b1C501vac9J7ThGMCpMYxsqGeggIiwH0qzgezlbCsQNYIZjWoLFM2AnjPU37EooXFAWnRy2MUnN2QdJKeTJH3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BupDfTxv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4060b4b1200so1230033f8f.3
        for <linux-acpi@vger.kernel.org>; Fri, 10 Oct 2025 16:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760140194; x=1760744994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWteJCdTRmV6+9s9peexAHreadwYn0foAUOzTTldCew=;
        b=BupDfTxv5Pq7lT7BYAzcajdCjINpun1dHRcCFSli60tJ+7qTQwCc+eyeXJH7oG0TcL
         FLMSJSAdSyu8tV+Id9t0qPTQT/U7I1UPtQsOm209zh70AuXL6TsRdZ7jgkP+wfntLYx8
         7jhziQkcQMkBBccg39lp03ZuU/cuCyUa3MijrjIvt9jody7o43yPmksz/taSqiJukFtq
         0z1aimfTJZ0xkGKLY+eWXoc/MfMhX/bIR4mMP9oR5kCEhCKyVr3j0cjx4zf01X8Dlax5
         siErZ6uPF8/Lm7IZop1myrx6kuQyRglUqI7vu726tL79mVjlWV2sYMHm0HXB1RA0EF2L
         8QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760140194; x=1760744994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWteJCdTRmV6+9s9peexAHreadwYn0foAUOzTTldCew=;
        b=Z5ipfaOrTJ0IwshpJaB+uNe6oftijE37GFOyOcFF3mrmj1sdH3pVzt7hzO5Xfc+huF
         abGfChBDAQyZCdoGnus/isJLImA5M5Rx2IpF9VL2yYYh3vWXhcQynVDTH7ZYwXURbaHv
         DX351Ml1S//zZkmNSVoKHn1+QWsEoIC2bgNTHWw/pfddtFwNo4cUb7D+XBQ94eXEESVu
         5WNkA3zYDqmIQcyvX0H/8JkzLslKvLsAO1Vx+UJjLOttPZ9JXutB2iz0eG0h9AQI7O2v
         qcD8yGe39gWI+Ms+EWWBdk7C09UBIPF+VakP4NPz5zMy1+aTtofUmzP7PnfCFnyaiB9Q
         AVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLMSnY8ht6iB0WNOuhE9MyYtVALgOKP6VQJ5izK8gqLd6gxNbmhaXE8A2rFmqOF+n/zgvgINvkTdIB@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZHKVP9XQzsocoMVkY2okijxBTNu6ptagK+jEvlC1VWBsH31T
	Ww2Umnr6p0E9duxFUeeYq9f4CxQDWUH3sMyczjV2edKdsajyfQztFF357tIcn2+5vhYo6A6V5yn
	CTflyz27GtUiRu91RuO3u1lIO2BUsSHCorchxBEU8
X-Gm-Gg: ASbGncuRIamLPVi61/cnEJts67BQL5nwktyzE+4zxIOCitW8n8yWYsn6RgsDZr/KvYz
	8OywabPmnM6h/Wi3yHNvVfeCwUTvzZKbU9RaFDrdt3MAtDwRmZMd4raGwaQfk8r3g9Oemx39b3k
	3/DN4LI5Z2VkB6ABeoQSMUjRr27Dxe/brnKfEozgd4FNb8VA1SGlaXfxUdD8TiVzsr2f0rGKD5w
	EeAC9UJiKPfhH4B+icqZt1aTzmErTi/n6jQJnu/J1VgO5W6gp99u+5FmvhY4sb5WOHUy2px+A==
X-Google-Smtp-Source: AGHT+IGS7tHdk0+ETIMQ93W4HeQKhAfSX1r/IP5abeF7P47AIA+uA/W8V68hokpCSKCF75Q0Jydg46lHFEFDPVRzp1M=
X-Received: by 2002:a5d:5c8a:0:b0:3e9:d54:19a0 with SMTP id
 ffacd0b85a97d-4267b3396eemr8310605f8f.57.1760140193870; Fri, 10 Oct 2025
 16:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas> <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
 <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
 <mafs0a51zmzjp.fsf@kernel.org> <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
In-Reply-To: <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
From: Jason Miu <jasonmiu@google.com>
Date: Fri, 10 Oct 2025 16:49:42 -0700
X-Gm-Features: AS18NWAkIO8EZmSKJ-cwcP3nrGVdmHJFmF8q10W7Jv6EeQBfqtNvpvxC46iB9-0
Message-ID: <CAHN2nPK34YfrysN+sraiFVjU_9Lw7E-yFVF-9x+nt1OUppZX8Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Chris Li <chrisl@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Oct 9, 2025 at 4:21=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
> >
> > On Tue, Oct 07 2025, Chris Li wrote:
> >
> > [...]
> > > That will keep me busy for a while waiting for the VFIO series.
> >
> > I recall we talked in one of the biweekly meetings about some sanity
> > checking of folios right before reboot (make sure they are right order,
> > etc.) under a KEXEC_HANDOVER_DEBUG option. If you have some spare time
> > on your hands, would be cool to see some patches for that as well :-)
>
> Sure, I will add that to my "nice to have" list. No promised I got
> time to get to it with the PCI. It belong to the KHO series not PCI
> though.
>
> Chris

Hi Pratyush, Chris,

For the folio sanity check with KEXEC_HANDOVER_DEBUG, I can follow
that up. Would you tell me what we like to check before reboot, I may
have missed some context. Thanks!

--
Jason Miu

