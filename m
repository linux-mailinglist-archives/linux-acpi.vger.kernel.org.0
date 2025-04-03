Return-Path: <linux-acpi+bounces-12695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53615A7A783
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B683A5E8F
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28F250BF7;
	Thu,  3 Apr 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfZlmIzq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2EC2475C8;
	Thu,  3 Apr 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696344; cv=none; b=Ym1b7MGoDEqQu1jMhnGMjPidEZn9gG6G3Z0MJ+sV0IVoW3xRnjTjVinTLCPScaIU5d7p+6frNMUV3YnlPZgiKVwb2clmJgEOcU1SOcKW9vdXB2XStSa+L5AVHLk67leOm1DLL2SsES3mN89MW5+iRCH5L4Pd5rEin39uqRAAfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696344; c=relaxed/simple;
	bh=K4chVx16zdFxQ/zMx+rUA1zlJffuh94xSn7jfKJuOKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMFQMGtajB6vztw9xQV4VJbmmCJ4aiSbWw6N7wSjYZHLsDFJIFfARFl5pnLgEZlJOc3xqI2RDATb33YQroOWmCP0oQd0keI/S5eeJ33nHZCdDhuI+cZoPbPJrojRlCoztTE0r8gKisTs54glK2EReqMvJNs/vtoLhK5t7POdcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfZlmIzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467ADC4CEF1;
	Thu,  3 Apr 2025 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743696344;
	bh=K4chVx16zdFxQ/zMx+rUA1zlJffuh94xSn7jfKJuOKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hfZlmIzqFMpr40rvVrb3zernzORrsdSaUSEc5Cen0b9Sa7I365hUE9PsjyBAEnKL2
	 x1jHdckfbPPoauhQMPKKDaPo19kZYBlkdFaDPyLBuXT6vS8PgG84/B8EvOH0qyL8Fr
	 ZZRuxvx4wy7PVzab9OHn0uw1D1HYsJ6YCNYD45ZTHMjqpPwQK8y1spIG5c1HlO2CFi
	 TlX5eKRLN0cM0bFUQ2Ic1xvNZkXBa+s9S21NUL8RKW1SrnK/8u4QgIH0wGDQbI7BY4
	 TdpaC1WAALgpLXHdz+ZRpFclXmIODpt/drgmHyIpvvV95RkQs7iJ77BMT9mbiX1eSt
	 2EzT7p+JPNlEw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so1714348a12.1;
        Thu, 03 Apr 2025 09:05:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcMNi2zSS8HC9PWoIGNbWYBaq2u0m7MPK0DmZ/IfO44/WYfdVTVZtbm9UfEch8lyKeV+LQwLPUSjUHWsa8TS4=@vger.kernel.org, AJvYcCWl8OL8TpE0RDqTod5mV45Sc81Lmc5e5uDTfE437gMdy6HWOmz+GthOmyFLwRKRQkShISFlcmWy817j@vger.kernel.org, AJvYcCXmAW3STzRmUiIKTtZLj6hsd+KyLSjjEKo34l1TfJeuQhMjB1RsvD/atX6QlWRYULWQTHPO+b2jAe/wPtyt@vger.kernel.org, AJvYcCXxLK5nfKWR4rYW43Opoqdu6xdnm9NkxP3A0/xlQpaWsNrSMmTmnrDo/onVB8wrzhmgvNhVxHIOvUBv0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YziYvLQZiYnBKu6m3p6BCbgDjeiB4+TKY3Qi0iNURTXmF27IOcx
	uBqjQYi44Mgpx9DZcKYJ/ENV9jk0o0n28M2t5ejTOw0yyl2gg1AghNTmzP5rMPMw2RZlhyRmRHp
	wkEBOiHwgjNINu8eqDrigtJ06IA==
X-Google-Smtp-Source: AGHT+IFS3bcl2DkBP6ddMY79BX/0/GPgj4JeHVuZiYZHa6CUJJ0v10ks6UBxpWk96/cGVBioxR3FepILQTugx8G6FvM=
X-Received: by 2002:a05:6402:4404:b0:5ec:9545:74bd with SMTP id
 4fb4d7f45d1cf-5f087253323mr2667013a12.27.1743696342727; Thu, 03 Apr 2025
 09:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-1-remo@buenzli.dev> <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
In-Reply-To: <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Apr 2025 11:04:32 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
X-Gm-Features: ATxdqUFYnosSxAW95KcCbZ0o0Yx-TM-nSD3poqFEmgDq0uJ6ZhgSuKCskNSHKI4
Message-ID: <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] device property: Add fwnode_property_read_int_array()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 3:41=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
> > The rust bindings for reading device properties has a single
> > implementation supporting differing sizes of integers. The fwnode C API
> > already has a similar interface, but it is not exposed with the
> > fwnode_property_ API. Add the fwnode_property_read_int_array() wrapper.
>
> ...
>
> > +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
>
> I'm not sure about this. We have a lot of assumptions in the code that th=
e
> arrays beneath are only represented by the selected number of integer typ=
es.
> This opens a Pandora's box, e.g., reading in u24, which is not supported =
by
> the upper layers..

We can probably drop the export if it is just that which you object to.

Without this function, the implementation is just multiple levels of
switch statements to work-around what's needed for the nicest rust
API.

Rob

