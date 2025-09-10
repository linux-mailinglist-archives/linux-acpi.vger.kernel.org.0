Return-Path: <linux-acpi+bounces-16552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA40B50CD4
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 06:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B635E4E2E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 04:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4ED298CDC;
	Wed, 10 Sep 2025 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDMbaym/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D12296BB7
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757478563; cv=none; b=ZWjCaqA0WPGYK/xXJE/JSWVc3zDTqa5v146TjYPc+stww688oaBFop+0z/GNvCk8Usgw/tW8hm/8ESnsTFJoqLEBGtwFiTmcIm0zhZtJVDtLg3Onn8WLe8+Lx8EmQgRtemNK7b9RyJDWqk9oXhqcgN7PwoW/Vvn6sL7Mbq10gIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757478563; c=relaxed/simple;
	bh=h8SlZrKBvGr7wtd1dtfVP38edu74TWfY89Z0KAjy3x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED4QLYcGBP9vEjeRNFl4ypGzJsYkLDa8D/Bj2mzNHA4NmebSF1gG2jqmGGOMba2oVfQrVR3kCT4viQI2Q0wMtWve7/Zz3UdlkRS3Zao+tPU7J/+U4oHs2ij42xZWCCAUGlgKBTqTDq5v1CnqAwiyg2rOEmxeW8uBqcHsS1G4jkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDMbaym/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45de2856648so30245e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Sep 2025 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757478560; x=1758083360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ARzwmlt6yrpEllGOQjdlWSlNXfWI6GpT8+MnSbYCDU=;
        b=RDMbaym/AWI9Gezp1usFiqu0UeobRZnbH1pA4Jp3RIXEqy/UvHa+/rTgK5JiBh/N8g
         6ArmpRHY1arzqsTlVcFFWEt9SPExn3eP3U0p0e93QIqvyGbru9IbH9z3QsQ0ld5JjPS4
         em+lTiJSop5qivjUQ4YizeeVUCoKJyz8GkoJg8zHafqzbZVsw0k2TBoGyX4qeUV62ekV
         qf1JXXaib0mtelvpUreqmCxsj4qipLBKHd9K6v8j2McDequ1TTh5rRpLZO13gt73xHGf
         M7Fn8oXdhYQhajfA93P3nYQ2NL+339U7xmJ0XYRlUx+KEaZyif0ITXJo1xkxqWw0UVVV
         jo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757478560; x=1758083360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ARzwmlt6yrpEllGOQjdlWSlNXfWI6GpT8+MnSbYCDU=;
        b=h4Uid8qoRTm0TvBi1MQsQA9zAcxVFaMq3YxyjIpUmZkQOSGJ1BD7bZgq038gRGYfpk
         HbvyfqTdePPQN0c1GjnZSSDR6tkeuyZK301UD25kIZZsn17Kq4uQNVXsGJsC1d0qT5Zl
         0CNMBk7y+SydoNNQIri2geeQnQ/YKBURjpiN7f+8Wq5OvmP54bMn5g6CzgCFW/hoIANj
         qV8Qr43s5kiLwkzxt4gAxCT0Q+nZkgweIFMj5VP3EztUmDdH8AbQQCAeawrGZdX98qFC
         2DmZlsYi5npWNWGh1rSal9profd/t2ZrZ1SF+1/4rTwsqb7xBhCZVb5fU3CPoWKvEfTr
         YtJg==
X-Forwarded-Encrypted: i=1; AJvYcCUL4CMZ12R50hg7peG8thJ4msq0y4zuLhGluyvPkTGoSQTW/jqI4xJdO7DC75pXMkUlTHke1f+c4JbG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4879xL7UvhmgnLldL66WAYPruoN+f3Qnn0V3l7sYAAQUrHYKJ
	DTJrXaH+rvRP525wYyrgnncW+Kgoqgu1j1aT5VW+aGw+NC+SNfHGRNTd/M78WDatDsPFT13p7rR
	Of2GX6HL3vMU8Mx5EArY+LYp562VfUbf0guSt/1LL
X-Gm-Gg: ASbGncuykosVzG1OxHu0ac8v/5A3mJom/WVGH6q4SoJKsorQk7WpvYs1S9xhiqTlYwb
	dEdgcJqhAaxVJmvq8JOszZ9eEBKIwzTIQL3V+0JG75qyksBNXvejH9k0LiJZn5c2ZBfLZU57K6X
	TDy43ZDhLit23KSamIl/ENXRWQ6NX7CjEZ5ay7AHxsSrnIt0KZtlQxvwFa51Qt8aGc/QiCQDjSN
	SpUsYS0G/iTNHMaYtnxTXXrD0905HUocclRGaCK1ZmWUaBtTsmJOeMZ
X-Google-Smtp-Source: AGHT+IEvzXimzLkbrQbhKOggU+1RyKhM1bG28XJ4hXT+Lqyr4ASfwjZrJpFKuoBhUEgwp3EGxJOqutfamhcQAHtcJH4=
X-Received: by 2002:a05:600c:8584:b0:45b:b6c8:833 with SMTP id
 5b1f17b1804b1-45df81fc2b8mr632305e9.3.1757478559480; Tue, 09 Sep 2025
 21:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830030226.918555-1-jiaqiyan@google.com> <bc8ad4b8-c000-0298-efd1-4a332c4c7820@huawei.com>
In-Reply-To: <bc8ad4b8-c000-0298-efd1-4a332c4c7820@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 9 Sep 2025 21:29:08 -0700
X-Gm-Features: AS18NWBt91Dwe-VR2UyuyHOgPzSqlS7haP5iXxB9mXtktyngCmw2r4m2kCIj4bw
Message-ID: <CACw3F53y=B5nJyS=OWTS7pOpcskgQ6Qt9u7Ts-TAZXig-J64oA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: EINJ: Allow all types of addresses except MMIO
To: Hanjun Guo <guohanjun@huawei.com>
Cc: tony.luck@intel.com, rafael@kernel.org, dan.j.williams@intel.com, 
	bp@alien8.de, mchehab@kernel.org, xueshuai@linux.alibaba.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:35=E2=80=AFAM Hanjun Guo <guohanjun@huawei.com> wr=
ote:
>
> On 2025/8/30 11:02, Jiaqi Yan wrote:
> > EINJ driver today only allows injection request to go through for two
> > kinds of IORESOURCE_MEM: IORES_DESC_PERSISTENT_MEMORY and
> > IORES_DESC_SOFT_RESERVED. This check prevents user of EINJ to test
> > memory corrupted in many interesting areas:
> >
> > - Legacy persistent memory
> > - Memory claimed to be used by ACPI tables or NV storage
> > - Kernel crash memory and others
> >
> > There is need to test how kernel behaves when something consumes memory
> > errors in these memory regions. For example, if certain ACPI table is
> > corrupted, does kernel crash gracefully to prevent "silent data
> > corruption". For another example, legacy persistent memory, when manage=
d
> > by Device DAX, does support recovering from Machine Check Exception
> > raised by memory failure, hence worth to be tested.
> >
> > However, attempt to inject memory error via EINJ to legacy persistent
> > memory or ACPI owned memory fails with -EINVAL.
> >
> > Allow EINJ to inject at address except it is MMIO. Leave it to the BIOS
> > or firmware to decide what is a legitimate injection target.
> >
> > In addition to the test done in [1], on a machine having the following
> > iomem resources:
> >
> >      ...
> >      01000000-08ffffff : Crash kernel
> >      768f0098-768f00a7 : APEI EINJ
> >      ...
> >    768f4000-77323fff : ACPI Non-volatile Storage
> >    77324000-777fefff : ACPI Tables
> >    777ff000-777fffff : System RAM
> >    77800000-7fffffff : Reserved
> >    80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> >    90040000-957fffff : PCI Bus 0000:00
> >    ...
> >    300000000-3ffffffff : Persistent Memory (legacy)
> >    ...
> >
> > I commented __einj_error_inject during the test and just tested when
> > injecting a memory error at each start address shown above:
> > - 0x80000000 and 0x90040000 both failed with EINVAL
> > - request passed through for all other addresses
> >
>
> ...
>
> > Changelog
> >
> > v1 [1] -> v2:
> > - In addition to allow IORES_DESC_PERSISTENT_MEMORY_LEGACY, open the
> >    door wider and only exclude MMIO per suggestion from Tony [2]
> > - Rebased to commit 11e7861d680c ("Merge tag 'for-linus' of git://git.k=
ernel.org/pub/scm/virt/kvm/kvm")
> >
> > [1] https://lore.kernel.org/linux-acpi/20250825223348.3780279-1-jiaqiya=
n@google.com
> > [2] https://lore.kernel.org/linux-acpi/SJ1PR11MB60835824926BEE57F094DE6=
FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com
>
> For the Changelog, it's better to move it to below...
>
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
>
> ... here.

Noted, thanks!

>
> >   drivers/acpi/apei/einj-core.c | 50 +++++++++++++++++++++++++++++-----=
-
> >   1 file changed, 42 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-cor=
e.c
> > index 2561b045acc7b..904930409fdb2 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -656,6 +656,44 @@ static int __einj_error_inject(u32 type, u32 flags=
, u64 param1, u64 param2,
> >       return rc;
> >   }
> >
> > +/* Allow almost all types of address except MMIO. */
> > +static bool is_allowed_range(u64 base_addr, u64 size)
> > +{
> > +     int i;
> > +     /*
> > +      * MMIO region is usually claimed with IORESOURCE_MEM + IORES_DES=
C_NONE.
> > +      * However, IORES_DESC_NONE is treated like a wildcard when we ch=
eck if
> > +      * region intersects with known resource. So do an allow list che=
ck for
> > +      * IORES_DESCs that definitely or most likely not MMIO.
> > +      */
> > +     int non_mmio_desc[] =3D {
> > +             IORES_DESC_CRASH_KERNEL,
> > +             IORES_DESC_ACPI_TABLES,
> > +             IORES_DESC_ACPI_NV_STORAGE,
> > +             IORES_DESC_PERSISTENT_MEMORY,
> > +             IORES_DESC_PERSISTENT_MEMORY_LEGACY,
> > +             /* Treat IORES_DESC_DEVICE_PRIVATE_MEMORY as MMIO. */
> > +             IORES_DESC_RESERVED,
> > +             IORES_DESC_SOFT_RESERVED,
> > +             IORES_DESC_CXL,
>
> Sorry, I'm not familiar with CXL, but I see the code in einj_error_inject=
():
>
> /*
>   * Injections targeting a CXL 1.0/1.1 port have to be injected
>   * via the einj_cxl_rch_error_inject() path as that does the proper
>   * validation of the given RCRB base (MMIO) address.
>   */
> if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM))
>         return -EINVAL;
>
> So eject an error for CXL memory, there is a new interface which
> means it's not handled here, do we need to remove IORES_DESC_CXL?

Thanks for catching this. I agree we should remove IORES_DESC_CXL. It
is unnecessary to check if base_addr intersects IORES_DESC_CXL.

My previous (and totally wrong) thought was, if the error type happens
to be vendor-defined CXL memory, that is, for some reason a vendor
implements EINJ for CXL but not using type bit[12:17],
einj_is_cxl_error_type will be false and the checks for base_addr will
happen, and I wanted the check pass through. Now I think this weird
case should be impossible given no vendor ever tries to add
IORES_DESC_CXL to the previous check.

Will fix both places in V3.

>
> Thanks
> Hanjun

