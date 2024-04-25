Return-Path: <linux-acpi+bounces-5384-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0D8B289B
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Apr 2024 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5BEFB26355
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Apr 2024 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F3B1514ED;
	Thu, 25 Apr 2024 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O2tq0uoX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA081514C0
	for <linux-acpi@vger.kernel.org>; Thu, 25 Apr 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071518; cv=none; b=s3iM6kswU834s3wz4Mr+Az1wMKwDQuXmd+Yp2aKSC4KZM9HCZKRJew9n8oFGg902FUr+DTadt4wL3xQZiz86Z+NutIDubIyTXkvlYgT/0xi4McjC2Jc3//k684jV3S0mFtyOKVRGiMh2hWvEvKC158cmOdggItn8htX56gc+An4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071518; c=relaxed/simple;
	bh=OVpsYfA8Qvyh7CR1+bvLaN9uwU+c3vdVxNAvJVeMlHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kI5iW/Of25HHbZDZnXlndIV8swK2EvfKJ69X38OVGn6vaxjMmXJybE7w95hdFD+8BfXQzVB48k+iyBlXoGBXczpA++TlT316cfAd19j+iDPd1G8XRWcMUhJxgFDGmnCTYNOl+aQh6KZf41uri3YNUnWR8nMY3lY/F0QOjkEPi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O2tq0uoX; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so2346486e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Apr 2024 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714071514; x=1714676314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ce4eWZ96+PrDKbqu3JpH3mxBstfm8l4HTUGuvQBwL34=;
        b=O2tq0uoXJdvJEReh3iYL6qanMPcCXV3+BCB4zB+04uKxo64KWrSXgHT+Fn60fRktgJ
         oKNkwhebQN1cbviut4hcvnH+Jyp1wdWB/SinhTQPWmikxoge48vp11yDSpfvOtzayxPd
         Fy7fcMGKmWxt9+ozmxMz5Ai6Dz/IHLI86IUZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071514; x=1714676314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ce4eWZ96+PrDKbqu3JpH3mxBstfm8l4HTUGuvQBwL34=;
        b=MGk39ra89CHINYkGVRetJs4HuuU/kM5CrTf/w2Yhle9e4ws0x/NPCCRb7lnXH6pqfr
         5Wfs7GIPwOeFKPrc1Gel1z41ni/aXXnMGoBNy5FihX8pryX0YhtcvDIxeoLXqPg2feGq
         D+juc8MuhwUdS/GfpwgKNHqYvQ56ezpYqt0ozg/M9vNiDGDMS1Hw1OClFWdZ3879nuwR
         Y7Hx4tQ9rleu6c3CZ0HxgYuVgk2zU08JedkCEvhorF93DFKYj/ljviRNY+5cA6U3vFPq
         2T6xm3YuLaczJnoNUaN/xkiCSdbKSnLMgz62q2CoLL7gxc7kJ1yDlwpapBaEm4CYxVE2
         k9pQ==
X-Gm-Message-State: AOJu0YyhvZMi0k5eKGem1bXJGKQvtrNZd6MioNf7IAs1QKTwscJtjWdL
	Ypr+Np/zhP93u+oOZnlZP/+odVGQEKy3Po33PESFo59z1uFckosuhxngECyhWkdSyxB7mrdCSk/
	pJF8=
X-Google-Smtp-Source: AGHT+IFPFzo6RuT6F3CehOp+xUVpNAtowCbmvTzXrCFeTGgz1ggNCMx2BkYx6cL6dUssXRKdPEvVfg==
X-Received: by 2002:ac2:4e8e:0:b0:51a:ff87:bae with SMTP id o14-20020ac24e8e000000b0051aff870baemr185148lfr.7.1714071514670;
        Thu, 25 Apr 2024 11:58:34 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m14-20020a19434e000000b00516d0c24008sm2959213lfj.306.2024.04.25.11.58.33
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 11:58:33 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so2346423e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Apr 2024 11:58:33 -0700 (PDT)
X-Received: by 2002:a05:6512:ba7:b0:51a:fc86:fc6d with SMTP id
 b39-20020a0565120ba700b0051afc86fc6dmr218319lfv.22.1714071512772; Thu, 25 Apr
 2024 11:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Apr 2024 11:58:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
Message-ID: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 10:46, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Fix bit offset computation in MASK_VAL() macro used for applying
>    a bitmask to a new CPPC register value (Jarred White).

Honestly, that code should never have used GENMASK() in the first place.

When a helper macro is more complicated than just doing the obvious
thing without it, it's not a helper macro any more.

Doing

    GENMASK(((reg)->bit_width) - 1, 0)

is literally more work than just doing the obvious thing

    ((1ul << (reg)->bit_width) - 1)

and using that "helper" macro was actually more error-prone too as
shown by this example, because of the whole "inclusive or not" issue.

BUT!

Even with that simpler model, that's still entirely buggy, since 'val'
is 64-bit, and these GENMASK tricks only work on 'long'.

Which happens to be ok on x86-64, of course, and maybe in practice all
fields are less than 32 bits in width anyway so maybe it even works on
32-bit, but this all smells HORRIBLY WRONG.

And no, the fix is *NOT* to make that GENVAL() mindlessly just be
GENVAL_ULL().  That fixes the immediate bug, but it shows - once again
- how mindlessly using "helper macros" is not the right thing to do.

When that macro now has had TWO independent bugs, how about you just
write it out with explicit types and without any broken "helpers":

   static inline u64 MASK_VAL(const struct cpc_reg *reg, u64 val)
   {
        u64 mask = (1ull << reg->bit_width)-1;
        return (val >> reg->bit_offset) & mask;
   }

which is a few more lines, but doesn't that make it a whole lot more readable?

And maybe this time, it's not a buggy mess?

               Linus

