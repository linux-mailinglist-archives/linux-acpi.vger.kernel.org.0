Return-Path: <linux-acpi+bounces-5385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC48B28A9
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Apr 2024 21:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA72BB2119E
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Apr 2024 19:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5914F9EA;
	Thu, 25 Apr 2024 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iq9a5Joh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E439FCF
	for <linux-acpi@vger.kernel.org>; Thu, 25 Apr 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071694; cv=none; b=fCHBgDUiGzMDT1+SdsOo5mqgri3JO9A/cBiImiLfnxBW3Mkruos1tVQ4awd3sgi4QN2W2Xkp1VDUgzjt1FNutOM1qb1iDVy3bl6fg+CiLynIrJFPzx/BJvRngo6jVStGzvYNl8NtRwUZwEa67QrIyQK4EDzFaHWhLnukSz/TJTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071694; c=relaxed/simple;
	bh=JeXz2/TFeNnXiSq/81VOk+f7TlrQg/8jpIhKlDJ3Qcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+2fXxGpNS810dUMbbg62jQbhiLSeVTaU6N1+w/0x0IxTpfIR1GxSZZgaXdktfrt48aD/90vr5yBNmIa7h7AbiPpJmNAzww1qJ90K8AHENjEe4Fuq0CmV7PqnzMdznCjjocgpCy2nzDhwx/z5o/QDpyqvDjAE853ISL51Y+z+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Iq9a5Joh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a524ecaf215so174278866b.2
        for <linux-acpi@vger.kernel.org>; Thu, 25 Apr 2024 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714071691; x=1714676491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+CfDSUKDWMFi6696XWhw/F7Vcz9ViYAQl2uJokcaMA=;
        b=Iq9a5JohsTpZ1Plw8lZtgNq/zWMOnM/vDa6gZR988KJL3wzjPGq9S1AdIubOwOi8CH
         NPpmx9mtAibp77SJE81y/Z4W08avKFQ5qUZQ8IR2OfV8DUFBdPKD7igii1OzhoNYfDFr
         PzqrW1WJmyNn5Z5FOd5FWMytOdAVjucQnXWuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071691; x=1714676491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+CfDSUKDWMFi6696XWhw/F7Vcz9ViYAQl2uJokcaMA=;
        b=wcAWnjxmvl8sOx8L0fxGmFZWuAD/5QDhLRY5XaiU5HOJV+VH9tTHKAnFc+qNeAdxTV
         pBdQpcY05kCa3LRUqYL32t+HXhi+IPp4Nqqfttf7jgGpjlckdEKuDaCoEf4NR6gXhD+S
         ja3PsL+xOoBQP10/unEbbTLd2DDKkwmWMzjkOWWdzv17GluwWnXFjxc92ZfSwvYEMRy/
         ENt5wTVGGEXHa5gUht2LJbSok5+urrMzg+gQMOaZ0Ty4GV5hy380CE+bXz5zykh8gFWG
         8JLwu4jineWH/KtWYBAnCFS++XPprn4B85Rp9OdBSXZc++nWAkrKAnHEfmxGwVi+sfh+
         6u4A==
X-Gm-Message-State: AOJu0YwmJ21DN4TbsU+801DVTTbb6HCISd4/f70vKeaYlXTPAswr8HQS
	jTDqXYXyGfJGXolaPHnbf3gtpzEQjZ8tNzB+ohiz5kqUVjCKmyXN0BhOGBmtvPsmCVDVJHbfySc
	tKo6TEA==
X-Google-Smtp-Source: AGHT+IH4kMMJnRJtylNwFfQenf4pVb5CPskxrLbWLUBxz3GdLvFgoVy792LrAMQH6oMUUPu2wNPAnw==
X-Received: by 2002:a17:907:bb97:b0:a52:2d35:5e28 with SMTP id xo23-20020a170907bb9700b00a522d355e28mr419855ejc.57.1714071690763;
        Thu, 25 Apr 2024 12:01:30 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00a58a44a4419sm1461889ejb.57.2024.04.25.12.01.28
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 12:01:29 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51addddbd4so163388366b.0
        for <linux-acpi@vger.kernel.org>; Thu, 25 Apr 2024 12:01:28 -0700 (PDT)
X-Received: by 2002:a17:907:76a4:b0:a57:b828:5f4b with SMTP id
 jw4-20020a17090776a400b00a57b8285f4bmr452572ejc.58.1714071688536; Thu, 25 Apr
 2024 12:01:28 -0700 (PDT)
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
Date: Thu, 25 Apr 2024 12:01:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg2hknXUtxq8F7caSmbtRNpss0zhDwv505L25dfQBXDA@mail.gmail.com>
Message-ID: <CAHk-=wgg2hknXUtxq8F7caSmbtRNpss0zhDwv505L25dfQBXDA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 11:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> When that macro now has had TWO independent bugs, how about you just
> write it out with explicit types and without any broken "helpers":
>
>    static inline u64 MASK_VAL(const struct cpc_reg *reg, u64 val)
>    {
>         u64 mask = (1ull << reg->bit_width)-1;
>         return (val >> reg->bit_offset) & mask;
>    }
>
> which is a few more lines, but doesn't that make it a whole lot more readable?
>
> And maybe this time, it's not a buggy mess?

Just to clarify: that was written in the MUA, and entirely untested.
Somebody should still verify it, but really, with already now two
bugs, that macro needs fixing for good, and the "for good" should be
looking at least _something_ like the above.

And despite needing fixing, I've done the pull, since bug #2 is at
least less bad than bug#1 was.

                   Linus

