Return-Path: <linux-acpi+bounces-11019-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C84B2A30E24
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 15:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0EB167ED6
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916424E4A8;
	Tue, 11 Feb 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oABa6pkf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADD24E4AB;
	Tue, 11 Feb 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283784; cv=none; b=NVl/EBm988UZ/nleCOJpAgWueMU2mT2CIRo+qj3esPxTOdUrf9Fajd7aMI6UA+QQAVL3W+QNtzcPedM+YYUxShYxCPLCIXkqFns8LjvrQfapSXR9acM0aGTUex9KAIrYjXqpjJnkyU/F0PNz0XVWyH9hqRrUzxoyEAg/FK9kGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283784; c=relaxed/simple;
	bh=tEFiFKnKGtvJHhnZ+Z9MAfG3eTneciF2Rj7ELcFgcAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFCvBVSfC2Wv/Ccn0dZE4yLCnBe3DSAalyYxwctS3kjEuIy9Kpx9/DqQE82QRgRn6OdNw3RD8HmArR0p6cm3Sut/t3VqSiKCOD+CbKhKNZrKH0deVpns1GylxAEhb8okMMOi5K5lcnTFZJAGhiM6RKuxZLWMKvLy7rH5bDnKCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oABa6pkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661ABC4CEE8;
	Tue, 11 Feb 2025 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739283783;
	bh=tEFiFKnKGtvJHhnZ+Z9MAfG3eTneciF2Rj7ELcFgcAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oABa6pkf8LLDQZ16qEUrttJD/f7oGW1lk2vKYrlkszlcqe/BOna0BRlBf+5ppsKPw
	 xxciR9GYzR/0TRktPT3/ru6w1MWZP80BEciur0JWmfsadtHXiEb+yjxu8gl9+HPwc8
	 0njgRcoxl1YqDl+GpfBn598syxHoyPPenfJCEMOrJ9W9PpXEL4yaRSKgJXrM2QH6PC
	 64hHeSPeWe1CBKOSRcNsBZqArKLAZvsaptCFHUJqzxFORri2+PkAeOHl9AbWd+GjH5
	 i1bBSUjzRl/yzrRk7Q8e9RT3lvNHhySPzSuaZIir0WQXo13SMU5jIkAX9G6WTQLh6T
	 G4WvXbgblqtzQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de7531434fso4433632a12.0;
        Tue, 11 Feb 2025 06:23:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrshAwZ1F3xz7Q4CmC1OGg9hw7AdMER6EkGQM82XqBTO12/WuoO/j4SxLomptT2LqejKPsFBflrybn@vger.kernel.org, AJvYcCW6LESS2UZA5VobTJCPGPqSyOluea1QwwRDp9H2KWOU4joN6tJ6/9aK5xGq2Ks6PFSQk7qS9tkfE5Ee98QK@vger.kernel.org, AJvYcCWUMXF91Tml0j9R16A4SU4dUm9XvgoME9OE9gYkzWY34uK/DM0SX0XceUjEQtpczSH8p8Mb3T1JIYPS7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRL5QSBlb0wP4KerBLNwEMQei+TC8tLatLXczRcr+ySbNFSLr
	200P8ZfdWlXtxlc+gyKrtSkP6JQ2wkewkRgXdiLLlJCmho6T2jsUsAgmyXbc2Vk2nABU1fq/lFU
	uYNHCMioKin2gQ/yZ9zTCiz5CyQ==
X-Google-Smtp-Source: AGHT+IEWjrN1dE5d5DShQ1yB2Zb6ZZNItUV8btIUpQeAAg4iby05aXF7qHbY0NoPrSJgrbi/2Q3svphGQx22vrPLJf0=
X-Received: by 2002:a05:6402:90f:b0:5cf:43c1:6ba7 with SMTP id
 4fb4d7f45d1cf-5de458cd983mr19678331a12.30.1739283781948; Tue, 11 Feb 2025
 06:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-fix_arg_count-v3-1-a084a5013008@quicinc.com>
 <Z6oclML_DC1Vnf6z@smile.fi.intel.com> <73eb84f3-8b9d-41f4-9b59-d059111a3d03@icloud.com>
 <Z6tBlfmTFu9916LA@smile.fi.intel.com> <a682824a-1b65-4b05-9e42-3edc167600a8@icloud.com>
In-Reply-To: <a682824a-1b65-4b05-9e42-3edc167600a8@icloud.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Feb 2025 08:22:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6wg3Q9FxKOzrnRo_s1ZznLurfsDuWJ+XVQzA5YS6Rsw@mail.gmail.com>
X-Gm-Features: AWEUYZkm5aMd5__6uxxCRufUsNgJ0BUSAa1JYPsM0qydqkvJGXC5VeHibCcGjkA
Message-ID: <CAL_JsqJ6wg3Q9FxKOzrnRo_s1ZznLurfsDuWJ+XVQzA5YS6Rsw@mail.gmail.com>
Subject: Re: [PATCH v3] of: property: Increase NR_FWNODE_REFERENCE_ARGS
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Len Brown <lenb@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:40=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> On 2025/2/11 20:24, Andy Shevchenko wrote:
> >>>> -#define NR_FWNODE_REFERENCE_ARGS  8
> >>>> +#define NR_FWNODE_REFERENCE_ARGS  16
> >>> Thinking of the case, perhaps you also want
> >>>
> >>> static_assert(NR_FWNODE_REFERENCE_ARGS =3D=3D MAX_PHANDLE_ARGS);
> >>>
> >>> to be put somewhere, but I don't think we can do it in this header fi=
le.
> >> thank you Andy for code review.
> >>
> >> yes. it seems there are good location to place the static_assert().
> >>
> >> is it okay to associate two macros by
> >> #define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS
> > I was thinking about this and I don't see how it can be done without
> > introducing more chaos (dependency hell) into the headers. So, I won't
> > take this path or even consider it deeper.
> >
>
> i have confirmed that:
>
> of.h includes fwnode.h indirectly
> fwnode.h does not include of.h directly or indirectly

Only for struct fwnode_handle. I don't think we want to add to that.
For the most part, fwnode is a layer above DT and the DT code should
know nothing about fwnode.

> in theory, dependency between both headers should also be like this.
>
> So, it is simple to use below define in of.h
> #define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS
>
> >> OR
> >> replace all MAX_PHANDLE_ARGS instances with NR_FWNODE_REFERENCE_ARGS
> >> ?
> > This sounds plausible to me, but you need a blessing from OF people as
> > the naming may be a bit confusing (for them) as "phandle" is well estab=
lished
> > term in OF realm.
>
> phandle is a type of DT firmware node reference. so this solution
> seems suitable as well.
>
> struct software_node_ref_args also uses NR_FWNODE_REFERENCE_ARGS directly=
.
>
> let us wait for more comments.

I prefer what you have here with the static_assert() added.

Rob

