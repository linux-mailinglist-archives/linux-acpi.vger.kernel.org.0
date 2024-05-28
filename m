Return-Path: <linux-acpi+bounces-6020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B708D14FB
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 09:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407B2B21F69
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BFF6F079;
	Tue, 28 May 2024 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W90IK/c4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9A1DFEF;
	Tue, 28 May 2024 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880252; cv=none; b=q5Fa0Jg/RdOrAyJLNIv2v00xRAY8fMWzsI0i5NdAcIwxdu0L9kBy2mMfiaGZKBOpWVe2HwyG2/KwHpWzzx4ZjYleHtgr3PW7/3T2jsbqt5G447HXLZ3nzvyaXrCD4qWJvu9wUNtLqKHxk1JYVz7tI0Av9EMPGkQr46wG3qU97Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880252; c=relaxed/simple;
	bh=KkBAfogugbkW2O0LOYJjRMTGe7b+beTAQAAYCHitrSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb8s9IyuTppZob7AqR7JdbB7bHy+YmBiYMXd9tCTcJgc9zpo7GwQ2wYkD4t2nivmRdgGQjrYutH55jHO+6d6MS6YmYQg/EYCtJ0qsh5yNBI0rnssJ5xJ6wOz4YF7GOCbf1onTgBnnzb/9vfjMBjla3xHZHWCXV6DDURHMpeDGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W90IK/c4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a61b70394c0so54521166b.1;
        Tue, 28 May 2024 00:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716880249; x=1717485049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/s9yBRWbo/r0O8Z/cxTazxChBuiXDaKpK3jfdwE8WM=;
        b=W90IK/c4VjF2dnf/UlLHMrNdIB1cXEXtcSJxST8HCBxejhX4Vxerz9tSt+Abchl1J3
         XYl9Lx6K/6nIjqfkJ5+v2xXwQ0MdakzAG188xD7kzXVMw9mRnRKu/NgLpd1H5OrA6IyP
         i8UrP0J236pPNLey40QVFTDZiORmHCuyGHPXxAzSb6hVuw7tPfBhJoKYli9jon8A1ldb
         byIzEUUUnP3HrDsZybZHCdv4EkRLWca5O2CRLKycHeBOlhAIZ7P33CWKOh97nEHn/qsa
         6OGDE+QCo3yPWlJkwkQSbdp+XTtJYjj/wasUeKwF8cI+SyvTUH1/TF8CKVi6aCMWw73L
         XUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716880249; x=1717485049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/s9yBRWbo/r0O8Z/cxTazxChBuiXDaKpK3jfdwE8WM=;
        b=dmwkkf3HdtLTWeD/MFUo42fIrlG8l6BZWIZ7s9hilwSu+xUgAX0C7Lnto3kQC5MOdn
         CgexDDMtTfhez4SXL0qBYbUQ/T2h3aPn+mBEevRQ8d+RcdMLM7ZqdXD6ZNhkAD5Xi7U2
         Atu5Enn0gTw0/KQ69s8UFcx1SiQkbAULzsOZQNHW+E0REsL1iIkAUKcEY+TCxh3NqEJP
         yx9Ouiv50rcX5qNuqSA0qe8C+FjJOt9kdnCgcZAu0SIJbEDu1BpkXXGq0E4GosK3HkTd
         OPjUbhDwoSrVELBOm0r0hpHL+YRCYC+XDnaPkpyZPZtkl+zQnTpw5ky9l40YSYu/c0kK
         m/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4sS/Ej67S/mjJzEpF2kUTzLBRMe7Drcb8Y+Li/IgrasxmNs7wHC0IqkC9uGXmVwkMrZCVVdpGThcRBTEQXqvPpgYq9+hGlpbkvAttnSojTqIEkhsRX+coc6zXbYBhgHuOHPnlZucSrw==
X-Gm-Message-State: AOJu0YxnfPZC2SvZwC3+1zncNizr45OeOncsbudY+J9QrD3DnrGThUz3
	mpXnDh3BFJKrQq3uxNzJJj10XfhJCrLGFtSH8J/Zs7L5MAt3x5EWIqR/0x+mib4RRAmMMYcw1tG
	PzdOwWOJSHVxWsmtA9/xOK6kqmZ4=
X-Google-Smtp-Source: AGHT+IFkFqHZlMHOiiqpXeBvNmTipsaQWh1bhN4lD+r0MQrHex0I6vDSdWLTYasgp8hDatCwXWfTEctoN4qNYgqX6+M=
X-Received: by 2002:a17:907:7412:b0:a5a:769d:1f8f with SMTP id
 a640c23a62f3a-a6265115f1amr596143466b.68.1716880248572; Tue, 28 May 2024
 00:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527202424.1430103-1-andy.shevchenko@gmail.com> <ZlVkgf_XCZcZd388@infradead.org>
In-Reply-To: <ZlVkgf_XCZcZd388@infradead.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 28 May 2024 10:10:11 +0300
Message-ID: <CAHp75VfqETdPQP2JBq+nWzZrsyeipV8cTspuTA7pt6b1P62wAQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PNP: Export pnp_bus_type for modules
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guanbing Huang <albanhuang@outlook.com>, 
	Guanbing Huang <albanhuang@tencent.com>, Woody Suwalski <terraluna977@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 7:58=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, May 27, 2024 at 11:24:24PM +0300, Andy Shevchenko wrote:
> > Since we have dev_is_pnp() macro that utilises the address of pnp_bus_t=
ype
> > variable, the users, which can be compiled as modules, will be failed t=
o
> > build. Export the variable to the modules to prevent build breakage.
>
> NAK.  Please move dev_is_pnp out of line and export it (as
> EXPORT_SYMBOL_GPL), please.  bus types should be private unless we have
> really good reasons for them not to be private.

Works for me, I'll redo it in the v2, thank you for the review.

--=20
With Best Regards,
Andy Shevchenko

