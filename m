Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A903AFD05A
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 22:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNVbp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 16:31:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44488 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNVbp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 16:31:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id c19so6186351otr.11
        for <linux-acpi@vger.kernel.org>; Thu, 14 Nov 2019 13:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2H62n5cl7Zl0IVKhutCc2fB9tvl/8YBY4uMqiHWJYM=;
        b=XemidhCKhsNdmfAGiHuY1IuGaH6iRtOub403Oguw7OKMHgtZ3WhwkmC7MDrO8HJxqE
         Pmm9IEGeeFShDtmqh8WpksF0PtLiDs2BwuEKTTUva31VnJdwuEZok3F7XxH6/p/Lvwya
         e0VDuSxpBla6tktu/YfNFWPN9d1FWAROn6LESSYLDTmKshmdWJQlSIAiHbR+sM+NTXeE
         n3CKmTQLM9Str7aIW+Sy/86rHtJMj2DVOeaZb2209E7pESumk9gJDrvRvrkrMvMX6JLq
         sEFu8MUo43SzGJjOeFhzMyl+NiY8uzW1uEaUY5oulMsuGjSQ/v5xtBcboj9/dF7sjyP2
         nq4g==
X-Gm-Message-State: APjAAAXoRL6nM3MB3AqnEfkJMpRrUhuYdLkXmMtjmuDoE1l9sUVVmQTP
        5UKuMvA+PPXN9/FyAsjpy/pH33YBq6gqF+DfFaTNF1fu
X-Google-Smtp-Source: APXvYqyJTeAA1bnNsAHvMla+i8yrRT21h6duR8XaSsJFdSccffBG5j0abW8swkRx8jE/Z/KF1RO0e2bOjzjlJxjFSvQ=
X-Received: by 2002:a05:6830:232a:: with SMTP id q10mr9268071otg.262.1573767104625;
 Thu, 14 Nov 2019 13:31:44 -0800 (PST)
MIME-Version: 1.0
References: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
 <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com>
 <cd3bd414-50c8-4751-8370-6a17b3b338f6@www.fastmail.com> <CAJZ5v0hN2PrFUQkWtTB2DfDVtyGubS+iPRU7WA1wM--1R+N7kQ@mail.gmail.com>
 <2a86e8b1-c631-4705-885e-779997589751@www.fastmail.com> <CAJZ5v0hzwsuxZUKc-QdxwOnJ6xmVHBccg2ubaOYUmhnPMQKEAQ@mail.gmail.com>
 <b450cff7-f3ef-4523-b86b-d0fd0ea4923e@www.fastmail.com> <CAJZ5v0hCrNoEA=TKVbsG0TPLLKT1br6N7O+sSm=KDA+QwX6fOg@mail.gmail.com>
 <1c8765d1-1209-43b7-97d3-4c454b15852b@www.fastmail.com>
In-Reply-To: <1c8765d1-1209-43b7-97d3-4c454b15852b@www.fastmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 22:31:33 +0100
Message-ID: <CAJZ5v0hy2QpJtnGVvOOggOzTDifD1HYosN9vf0y_=15b+M8v0Q@mail.gmail.com>
Subject: Re: how to disable the "button" kernel module?
To:     Bruno Dantas <kernel@dantas.airpost.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 8:36 PM Bruno Dantas <kernel@dantas.airpost.net> wrote:
>
> > As I said, that may be the panel state rather than the lid switch status.
> >
> One last question: What keeps tabs on the "panel state"?
> Is it the kernel, a kernel module, X, or something else? Would you be so kind as to point me in the right direction?
> I'd like to find what keeps track of the panel state so that I can disable it (or configure it to lie and say that the panel is always open).
>
> Most internet searches for "panel state" lead me right back to the laptop lid switch, which I guess has been a red herring all along.

Not necessarily.

The i915 driver (for Intel GPUs) contains some code related to that
too, see drivers/gpu/drm/i915/display/intel_opregion.c for example.
