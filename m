Return-Path: <linux-acpi+bounces-3885-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B7B8607DF
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 01:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773251F24D24
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 00:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501A3236;
	Fri, 23 Feb 2024 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Ftgx/2j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C28BF9
	for <linux-acpi@vger.kernel.org>; Fri, 23 Feb 2024 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708649723; cv=none; b=dCFknt/cpiB7Lr1GmBony/89ESHWiXikKcSc7ovlziJDH7zjLM/9hqJOtgXFEuyvR/wjoFyDPqQ+GC7rAs9Buf38UT+9yDi2gbnjOy7NFnTLeoV8/DCtj/wNkJYiNY4Rcg+8Tm7Ow3v24zLzmg6qk5I2igm7+/VyKCuhKeLmb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708649723; c=relaxed/simple;
	bh=5kjCp8j/UQEpPhPqZWoKio2bsh6Z8YRqEl1lcKCoPdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ3qAIHkle2LIux+ZfN2D5Av4LBmi2rr/Bj14VRfmsmwcyZ2+2yhvLRkLoQ2SmfLZnG+H/oBrLJACCiBpmT6JNsEVC96902lNzGVmuDBkZ95cTttBYemfeUedEC2uW6Dd2d0+I5sC7a7uJ69fFZ2Z3m10fYdRCf2HWnsOcetYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Ftgx/2j; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so2430a12.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 16:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708649720; x=1709254520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kjCp8j/UQEpPhPqZWoKio2bsh6Z8YRqEl1lcKCoPdM=;
        b=0Ftgx/2jAFs04UxEh55RSEQCbOQYfOXPpZTAhrY2DGFhqhETq42A+CE6HvWHBKJbTe
         dAT+uLVXYG9UrNJpKlQMahTp+5S7jRgTsFGXnQv6Lf7pPjsPPE/VOIp4bULka5ouu5wo
         Q2OOmRTOgEeVX5IbV6FTxBDqgylzo/O0pbC/K+WEKRFpUbQ1pfsOXwlogcOkVXKMfcF2
         09WytAvYD3dZJEIXtaIopop66K6mzQTzn327r2FwaTYBpxPgDoutg2Y7IaNmeBXaoeko
         l8x5+mI98EEfN/8R/3T/rFEuTrNAZJ4eshxkDUXNUnVt1xwDe2Nd5DMcEZTAt7uEFLro
         OkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708649720; x=1709254520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kjCp8j/UQEpPhPqZWoKio2bsh6Z8YRqEl1lcKCoPdM=;
        b=wZ2MMOe2qOe6126zus30GZMINt2NTm0SYJk9rwOnqu5cQHZbwNkhXFo72g53Vjdaae
         FitO9sKpNdDOy0o+xrqMZfJqI5VzjYn1rZ0wTO7Mv/EtP8A9WSnbifsVFpd3DUuvnIq6
         flwx/krB8GmGQHuWftJR4Po5OHzEy2d+jTSfopS3XJbo1QsIIxYnW5ONscgi0AY0P7nf
         VK9fcJchlPVkznrnSdmgX4qJQdsetK7mKvau+Che+RziayseDvLw+pgHtQ+u0g9ALmg0
         bFDoafgOIMLsSntXfqxiq039jBvPemToZGGOWAN4e3FoWBQX6JV7ADFDnYE5jTWZ/Cqg
         isXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaNm3Frys1qXXqlFOjk9wfP/szE3u/OBvaTQ1GiBiiP4mbda+HbiFK8C8d1pJGcvWK2uX+kVPgxkuNfQBMIljd9R5PynEHUhk4IA==
X-Gm-Message-State: AOJu0YwaPWmjFwjsJoE9kDDNwMMtLVJ8JoBLcdCITbAc1w3O06r/OMnb
	EwlkX7DT1qxxwtMM5+dnmGfXF0cKjzr8hSLkFN4pQ3Wa04YTfESBgJVSb5phq998/3qk1zin1uW
	fiC1xMysq6tTo8asPQ6vo1UHZ+JRP2qhhaicVnYkoPn6tsLDGeUQm
X-Google-Smtp-Source: AGHT+IEKSApiDsDWT52bIXThzJBemkvAMEQc57fMaQvv1LlerrWc1/VvLi6QB1yxU0wGVvPjeIBszr5d077cJ68wngU=
X-Received: by 2002:a50:a408:0:b0:565:123a:ccec with SMTP id
 u8-20020a50a408000000b00565123accecmr419373edb.3.1708649719604; Thu, 22 Feb
 2024 16:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
 <CAGETcx8hzYzjKWPz4ACgS=XrVXqg46QHB4hTpP5bDTY9=WFK+Q@mail.gmail.com>
 <ZdXxNFB8bMMFPoki@smile.fi.intel.com> <ZdXxYjYsBQybbilQ@smile.fi.intel.com>
In-Reply-To: <ZdXxYjYsBQybbilQ@smile.fi.intel.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 22 Feb 2024 16:54:39 -0800
Message-ID: <CAGETcx9akN315asPP=e8xieHqs7gKXvHP-BwRxD=vCBuhh8_Jw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it belongs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 21, 2024 at 02:48:52PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 20, 2024 at 06:08:56PM -0800, Saravana Kannan wrote:
> > > On Tue, Feb 20, 2024 at 8:10=E2=80=AFAM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > A few APIs that belong specifically to the fw_devlink APIs
> > > > - are exposed to others without need
> > > > - prevents device property code to be cleaned up in the future
> > > >
> > > > Resolve this mess by moving fw_devlink code to where it belongs
> > > > and hide from others.
>
> ...
>
> > > The rest of the functions here are related to parents and children of
> > > a fwnode. So, why is this function considered to be in the wrong
> > > place?
> >
> > When devlink was added it made a few fields in struct fwnode_handle.
> > These fields have no common grounds with device properties. In particul=
ar
> > struct device pointer is solely for devlinks and shouldn't be used with
> > them. Hence this patch. TL;DR: they semantically do _not_ belong to
> > the device property APIs.

But fwnode_is_ancestor_of() uses none of those new fields and seems
like a very reasonable API to provide. I understand if you want to
make the "device link only" argument for fwnode_get_next_parent_dev().

> On top of that for the 4+ years no new users appeared, so exporting them =
was
> a clear mistake. Hence Fixes tags.

We have plenty of APIs in .h files (not the same as export to modules)
-- that have only 1 user. And even some with no users. You don't move
a string function out of lib/string.c just because there's only one
user of that function. We put functions in C files that make sense.

I think Fixes is a bit of an overkill. It's not a bug. Fixes get
propagated to LTS. This is certainly not LTS worthy. I'm not going to
NACK or push back on this patch for these reasons, but just letting
you know that you come off as unreasonably grumpy when you do these
things even for fwnode_is_ancestor_of() :)

-Saravana

