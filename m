Return-Path: <linux-acpi+bounces-12849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BEAA80B7D
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9F04C5B85
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79D27BF75;
	Tue,  8 Apr 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFBWx+A3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4A26F44B;
	Tue,  8 Apr 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116942; cv=none; b=alkmF2yF2ekvrMZQ+fik3sYNMAx/VzNC+cWwEqjQnoo1sA4qPqEwGADMun5WktOb/1BwTikYxhpTVsHqfGYDPqnn3WAlc+Z4JhpjQoT2zAxmYw85T5m8/RkEB2pUP0B4/s4nt5s17gjIE/3oqtvcpUJebDKDGE+yF5AExnTWFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116942; c=relaxed/simple;
	bh=yXcmtixDD0PoYLqvNen2IuNYqv7abzwtOyMM/Tj7nHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHEI9AkgOLpKv3tRiezIjorxXYBKtdkcTMZ2tJbrPWWmleXeg+GjPqedmAg2ct3Kz0vWjGjENMvDyIOAIDGYa61iUMTqcNMlN1ZOqWXl3dMw1hs6UByrLPhCRD9O/nFL+9Otrf1XrvSJ/ZeJMa0M9lerAgT09YVISmVHsQa3lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFBWx+A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921D9C4CEEA;
	Tue,  8 Apr 2025 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744116942;
	bh=yXcmtixDD0PoYLqvNen2IuNYqv7abzwtOyMM/Tj7nHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kFBWx+A36RW5BduMhokMW4S9cQfoxKBObNEyNJXUQdpuB9teVLiIeVI0ttQRoMhay
	 y135QQbErakI+LuxPYF3NwVgxCt95lbmCUsAzGhYoOOPIBTTnQMnJDuYqvker9qv++
	 kvAYyn7MaIx5/E1loYasUlpHfH6zJlOynqrcMS1/ovZv3+PUr6C4u9eaNQCsAXpaEF
	 ptcW7W2Ybb4uQ3ALZS3RLEt/FwKUZ+1/TGDL7tPORF3pL56Ror+0uNOhmuDxuhTJyt
	 J4D9BD6uzC39JDPV/p1vkDFPv+04YmlVkdt4BSj+qycX+atpECGOmVeOP8cYaC0asQ
	 MkC7pX55omNOg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso8564439a12.0;
        Tue, 08 Apr 2025 05:55:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+z2CA9pekcsAjVGNQtrViOPUcMJGreYpYzOLmNDk4+lLWWOTGW0XMCbMjUluGWdlRFW0wIlIuFZt2@vger.kernel.org, AJvYcCX08PduqDxhzApJK5cTSbE4AhS4nz1PEHEjZbedHnUpG61Dt69a7iuUYclUhb7e0R1U9VDhllbz06mh4zxA@vger.kernel.org, AJvYcCXyVn6cAIlC/I9v4TEaUNT0qsRZIFXiXQ0N1XcCc+kqbOP6Aj4DK3BXanPIAZ6MlTb3ep4o1pU26WBulw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyweO0iBD+vFNiqw1P7t9YXnslmJsj7JLWJfYTw/CHE7rsZPSGB
	ISBTcWYpfd7dNuhSt7RJow2DByjcuoMnqlssX+AYuSAWKq2srbFyikIdhXgmejY2v9oho4ER3Fn
	VmaqqINnshSAuN3Uo43Ad+6nbSg==
X-Google-Smtp-Source: AGHT+IHX3cmhU4CasIiAOcjHWKEESLPfy4jA4m/Zb3FSa5kKoGIjnDjHb0p0MvSZw9sdXAgUZ8030FbEZIYnsbAv8Oc=
X-Received: by 2002:a05:6402:26d2:b0:5e6:bc68:8a34 with SMTP id
 4fb4d7f45d1cf-5f0b5da6cafmr13197933a12.7.1744116941174; Tue, 08 Apr 2025
 05:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <20250407223714.2287202-2-sean.anderson@linux.dev> <Z_To8p6xD7aLrEVk@kekkonen.localdomain>
In-Reply-To: <Z_To8p6xD7aLrEVk@kekkonen.localdomain>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Apr 2025 07:55:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLbKSsnNrvo=NWAUbsbd8Yy8v3gbMAu6e+WMofJv0Pcvg@mail.gmail.com>
X-Gm-Features: ATxdqUGElU141KP4c_FXlhXlWpTziFEblEDHqaKqfcCFwzgjRU4KnLoiTvYLb3M
Message-ID: <CAL_JsqLbKSsnNrvo=NWAUbsbd8Yy8v3gbMAu6e+WMofJv0Pcvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] device property: Add optional nargs_prop for get_reference_args
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, Saravana Kannan <saravanak@google.com>, 
	devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 4:14=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Sean,
>
> On Mon, Apr 07, 2025 at 06:37:13PM -0400, Sean Anderson wrote:
> > get_reference_args does not permit falling back to nargs when nargs_pro=
p
> > is missing. This makes it difficult to support older devicetrees where
> > nargs_prop may not be present. Add support for this by converting nargs
> > to a signed value. Where before nargs was ignored if nargs_prop was
> > passed, now nargs is only ignored if it is strictly negative. When it i=
s
> > positive, nargs represents the fallback cells to use if nargs_prop is
> > absent.
>
> If you don't know either the argument count or have a property that tells
> it, there's no way to differentiate phandles from arguments. I'd say such
> DTS are broken. Where do they exist?

#msi-cells for one is optional because we added it after the initial
bindings and missing means 0.

> At the very least this needs to be documented as a workaround and moved t=
o
> the OF framework. I wouldn't add such a workaround to swnodes either, the
> bugs should be fixed instead.

The DT API supports this already.

Rob

