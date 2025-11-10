Return-Path: <linux-acpi+bounces-18756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3298C49548
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 21:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5438A34B76B
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8417A2F5469;
	Mon, 10 Nov 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8NhlwoO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6702F5462
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808195; cv=none; b=MEHkwqwZydl0kq5Ivo+BnMwCok467CDJZzPqoWJpWqRZDGeDXlyeZQ5UmiPKbry8ido6+4RvMsXKspax8zCt24p1PGRYvSZd5KURQLDzwhaBeMWffBxpiVbxya6wHA37P5Xo1FMSxqboaaF8Lh3Fu20Rpeg/WeSL0eSWgpjr7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808195; c=relaxed/simple;
	bh=nzONvQzcT0llpH+eHhBSyHjuk/OUfjr2rQUOpvgixH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILiLH1Pr2Y8yEGxPjy09Zwp9qB1bX7ntdTvVPn3nLy90gGwhqOk+zzTP3EoEiDU4QJmDmO2z1Ks4tcdP56tzRXTOpfoR7hE0SeKoKR6wQq4kSvSO0TWfK8NIC1RbcArsh/Xq61PFK6SLTDPJ/0XPYDRgFnESYVy76jBLN6Au+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8NhlwoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7048C2BC87
	for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 20:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808194;
	bh=nzONvQzcT0llpH+eHhBSyHjuk/OUfjr2rQUOpvgixH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G8NhlwoOC9R1N/WHZGjSUGqnXPNeQE9SMcW+Akv2hGLqZGqSsy2NHf1454ExZ73u2
	 nZdgt8yjhN2gnFXlGoOKlqv8gaJgZyl5JjfVF/dECAqH31hpVwV67nBD3BLkVP2BwE
	 31Ek/JsYbvW9/9vr7JlaOE22Gz7xdiPap0ad+BaUpr3+BxGtoH5B46dnh2t4y7muwE
	 U+0uGVXJemTUIAyyl7KAvOP10h6UySMtzUEv8Xn1RLPEvASOMeuL2EO+0/HeayBgnf
	 HI18s9R8m9/SDMtA0ferjnSVGs+12Uw1KE83FJx+7yp07aTDg1RU5Jr8Y+RxySgwBP
	 TDS8czEp1aCRg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-656b7a2e7dcso1670814eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2025 12:56:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3MyzV/Jq/as1uj6iWA0KKZH0YsMt0zagktpIifsY+4BHXtY6J/uijLwyeqZp4U7FXDEHEFApu51fu@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrwP1eORbMXnpsHorQN7ihdYdMdBU2rBFx2ghXhVo/6OLkA94
	IAm9jXJcstHPjX7MMuJ2TudnS9mwKsKnDlSdPXqjUBuhFtjwlHn7egrUqqa1vTnuXtBhKX66HMl
	tIOMA4GopN0cClA5sZQFrtbxB7ssNIDE=
X-Google-Smtp-Source: AGHT+IG9Pjhham/qiDKmpchvbrQfXUjTk8mGOJBEgwPxvNy79OZ7viUKrocFLv1OXkrYVlSrLtSQL71+JS5eADJZCUE=
X-Received: by 2002:a05:6820:2188:b0:656:735e:9f25 with SMTP id
 006d021491bc7-656d8e88d10mr4580147eaf.8.1762808193960; Mon, 10 Nov 2025
 12:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
 <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local> <20251027205816.GB14161@ranerica-svr.sc.intel.com>
 <20251029111358.GDaQH29lURT0p_WWsb@fat_crate.local> <20251030054350.GA17477@ranerica-svr.sc.intel.com>
 <20251103134037.GOaQiw1Y6Iu_ENu6ww@fat_crate.local> <20251110174938.GA26690@ranerica-svr.sc.intel.com>
 <20251110194638.GCaRJBHrJgwjRY5aQr@fat_crate.local>
In-Reply-To: <20251110194638.GCaRJBHrJgwjRY5aQr@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Nov 2025 21:56:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmu4onvrp_it=xTHsScE98AjDkCg00Tdhhtiz93b=aqw@mail.gmail.com>
X-Gm-Features: AWmQ_blbmx2tUH8jtiT6HsqvdY-s9EsP0qINVvRWzIyPuM-EMjwcy7mK231nDL4
Message-ID: <CAJZ5v0jmu4onvrp_it=xTHsScE98AjDkCg00Tdhhtiz93b=aqw@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to smpwakeup.c
To: Borislav Petkov <bp@alien8.de>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:47=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Nov 10, 2025 at 09:49:38AM -0800, Ricardo Neri wrote:
> > I apologize for my late reply. Also, I am sorry I was not clear. I need=
ed to
> > consult with a few stakeholders whether they could live with the increa=
se in
> > size resulting from having CONFIG_ACPI=3Dy. They can.
> >
> > If it is OK with Rafael, I plan to post a new version that drops this p=
atch and
> > adds the necessary function stubs for the !CONFIG_ACPI case.
>
> Sounds good to me.

Yeah, sounds good.

> It is the simplest thing to do. If the size increase bothers someone, we =
can
> always do the more involved refactoring later.

So long as they have a good enough justification for it that is.

