Return-Path: <linux-acpi+bounces-5386-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319FD8B28F0
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Apr 2024 21:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22BE283B73
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Apr 2024 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831761514F8;
	Thu, 25 Apr 2024 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NLaMPAaD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342C15099C
	for <linux-acpi@vger.kernel.org>; Thu, 25 Apr 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072718; cv=none; b=UaphZKdGF7E4W6onrTOz1vBETqai0glh+o6NuABnd+2MKeOjQskrz8YAcJf9LbSyFo/qPmcNfeVoUJyMUcTd8L4O6x01QCFP66xDA93ojYi9xsZLzda20llr23A/MF52nbn5vCJs4b/pfzD2zHkQjd3QRwM4vahS7C0DNnU1Itk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072718; c=relaxed/simple;
	bh=9SMxCSKhvmc+6oVvqLR1AsFgyVSziSQPD4cUWIChFV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlrVBK+bQHYDi1K1U/A7iOj/Qs/fSYjIVCG7RegPN0YC66MXfRIKDm5yhdfWAsI1+nwud83Bd7W59VMozaRo+F8IYo2JghvtCb179LuwW1SPosDYiX2jzPv62qf/vp0OE7iASRh9I2RyVmjXrocFuam0OkxCXbUHxCIIuUw2cAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NLaMPAaD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4715991c32so145768466b.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Apr 2024 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714072714; x=1714677514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ev52rMR4Q4Woczb+9iTzXyh9tVmc6K3sVmdOuWpY6dU=;
        b=NLaMPAaDAfWyAjYqlc8UoygSIrawsyKNAlA7ESSWqmOyuD7gYLHRVsXShcg27laH8C
         nrJd6Nj6G8fx4R8h0a8lGW4sjlZ9kMbuxbjuZPoDCVrR4Sw84QIFhpBf3t6MTgRss3lj
         taDq8/QEE0XVuwzqEDWPUP3Xc4yEjWjtvE2Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714072714; x=1714677514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ev52rMR4Q4Woczb+9iTzXyh9tVmc6K3sVmdOuWpY6dU=;
        b=XQmBvc4teJdf9Yb9Oiq1FZgfm3Hq/q8lPo+JqhbD0e31x6gJ0wn6qG1JCRfeBffhBx
         Ui/Vfh6V6KZSluRFgW0v6x5owx/JUM7ws7urd46+4wltFCpNhnida2g7UENdvTCRJ0Nz
         KI1oT5CBjJSk/+CZJNUfDiwg+EC9x4IUa6xvB6pPMLlRDkTEJ8HvBQi++KGZ4snrAwBq
         BpOoqxpInVwQKeQ2pxr33lIarv58HpJihtTnioYiQdROr25+4Vq37iBb0BrLnz6/nOV7
         nHD09kTIEannFQDdfIhylrYDEmLCZRBciXyUjSc4X2Qv7XbwcQ2xkbqAnvPfsusn1maF
         nw6g==
X-Gm-Message-State: AOJu0YxqmwRjz0q59UTMph/2J5XZ9hkrAQj7d/1luZLxN8ymYInYLwHM
	30EqfiSx39o8FgGUK9GXFpKGj04e4qIguq65m8idZT33KqsIPX2YqhpkhnhqrlaO3guNppak3e+
	ESZT7hA==
X-Google-Smtp-Source: AGHT+IGbR5e2gj9UlEimGUq+mfo4qs+RNktGeHRpIQ0jXzhfK20tlwFfzLgqDqRB1QWecmEtD9XWiA==
X-Received: by 2002:a17:906:315b:b0:a58:8bb8:a35 with SMTP id e27-20020a170906315b00b00a588bb80a35mr419660eje.4.1714072714509;
        Thu, 25 Apr 2024 12:18:34 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id bl20-20020a170906c25400b00a55358244ffsm9815168ejb.204.2024.04.25.12.18.33
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 12:18:33 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4715991c32so145767466b.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Apr 2024 12:18:33 -0700 (PDT)
X-Received: by 2002:a17:906:1345:b0:a4e:cd5c:da72 with SMTP id
 x5-20020a170906134500b00a4ecd5cda72mr421167ejb.63.1714072713361; Thu, 25 Apr
 2024 12:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
 <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
In-Reply-To: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Apr 2024 12:18:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj52PUZ0xtoLs79B9uar6h7FVaKC0gbD-a_wZxDjH2ViQ@mail.gmail.com>
Message-ID: <CAHk-=wj52PUZ0xtoLs79B9uar6h7FVaKC0gbD-a_wZxDjH2ViQ@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jarred White <jarredwhite@linux.microsoft.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 11:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And maybe this time, it's not a buggy mess?

Actually, even with MASK_VAL() fixed, I think it's *STILL* a buggy mess.

Why? Beuse the *uses* of MASK_VAL() seem entirely bogus.

In particular, we have this in cpc_write():

        if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
                val = MASK_VAL(reg, val);

        switch (size) {
        case 8:
                writeb_relaxed(val, vaddr);
                break;
        case 16:
                writew_relaxed(val, vaddr);
                break;
        ...

and I strongly suspect that it needs to update the 'vaddr' too. Something like

        if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
                val = MASK_VAL(reg, val);
  #ifdef __LITTLE_ENDIAN
                vaddr += reg->bit_offset >> 3;
                if (reg->bit_offset & 7)
                        return -EFAULT;
  #else
                /* Fixme if we ever care */
                if (reg->bit_offset)
                        return -EFAULT;
  #endif
        }

*might* be changing this in the right direction, but it's unclear and
I neither know that CPC rules, nor did I think _that_ much about it.

Anyway, the take-away should be that all this code is entirely broken
and somebody didn't think enough about it.

It's possible that that whole cpc_write() ACPI_ADR_SPACE_SYSTEM_MEMORY
case should be done as a 64-bit "read-mask-write" sequence.

Possibly with "reg->bit_offset == 0" and the 8/16/32/64-bit cases as a
special case for "just do the write".

Or, maybe writes with a non-zero bit offset shouldn't be allowed at
all, and there are CPC rules that aren't checked. I don't know. I only
know that the current code is seriously broken.

                   Linus

