Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DAA1F9E6F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgFOR3E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 13:29:04 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:48197 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbgFOR3D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Jun 2020 13:29:03 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id dccef2eb;
        Mon, 15 Jun 2020 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=m3AkrHNEP3fRbfUKcEmklayjG/Y=; b=Vnq6wL
        H/GlVughWBz9MLzBZDqFOiVvq2odnVCIbltAHG4OcPm6lhEaWSbaSpOAsRDBUegE
        u4n8TSF+EVf4oL2tJBhzCgEGDf2ucmy8SFWoZr+IgFgRssQOA676SDON+KhSRcaH
        ER9uKsvFET2KNE0JPtUDKaXA522KHU1wOPszZI0fGnn8BpO4K6LM0emM3o6Svvux
        1aK7vssIcYM6LXiZoLWfTWRiZ+aTwB5CTnAZRMPEQWZej12knFGOV5w2+gfunJAj
        UEnGhaV0TlmQ+iId591+3P5pWi7UjC7WbXe+WiLSg5IaWQR6ls22oibMsADEYKgW
        A/5WpHmLFRsUCo1Q==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 182ff700 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Jun 2020 17:11:07 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id z2so16074860ilq.0;
        Mon, 15 Jun 2020 10:28:59 -0700 (PDT)
X-Gm-Message-State: AOAM533lQqLJiyEF/nyHC1TbHvDC2yPn6Eh8uGsjgUBKkDHWVtih5nJC
        wZD8ZriQpNq/qpVOHX1HndP38JW2jv1H8oZOAJ8=
X-Google-Smtp-Source: ABdhPJxbrQ3bGRl0GkiYs6/6hV26W43YxBqSNtYmC1faaRba+IWxUls2u4WXMRsQ/6ex5PHS+Qi1f/omynEyBDBFhSs=
X-Received: by 2002:a05:6e02:605:: with SMTP id t5mr28160520ils.231.1592242138131;
 Mon, 15 Jun 2020 10:28:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:ca6:0:0:0:0 with HTTP; Mon, 15 Jun 2020 10:28:57
 -0700 (PDT)
In-Reply-To: <CAG48ez3fQbBLUBUkSaF-0b_DhL8M_1JU4DKkjTYXGB_6G1RgiA@mail.gmail.com>
References: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
 <206DB19C-0117-4F4B-AFF7-212E40CB8C75@oracle.com> <CAG48ez3fQbBLUBUkSaF-0b_DhL8M_1JU4DKkjTYXGB_6G1RgiA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 15 Jun 2020 11:28:57 -0600
X-Gmail-Original-Message-ID: <CAHmME9oR=X2OayrySfVaA-1uxHGAu0ix2caf9jAvNg72V0mbyg@mail.gmail.com>
Message-ID: <CAHmME9oR=X2OayrySfVaA-1uxHGAu0ix2caf9jAvNg72V0mbyg@mail.gmail.com>
Subject: Re: [oss-security] lockdown bypass on mainline kernel for loading
 unsigned modules
To:     Jann Horn <jannh@google.com>
Cc:     John Haxby <john.haxby@oracle.com>,
        oss-security@lists.openwall.com,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/15/20, Jann Horn <jannh@google.com> wrote:
> On Mon, Jun 15, 2020 at 6:24 PM John Haxby <john.haxby@oracle.com> wrote:
>> > On 15 Jun 2020, at 11:26, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> > Yesterday, I found a lockdown bypass in Ubuntu 18.04's kernel using
>> > ACPI table tricks via the efi ssdt variable [1]. Today I found another
>> > one that's a bit easier to exploit and appears to be unpatched on
>> > mainline, using acpi_configfs to inject an ACPI table. The tricks are
>> > basically the same as the first one, but this one appears to be
>> > unpatched, at least on my test machine. Explanation is in the header
>> > of the PoC:
>> >
>> > https://git.zx2c4.com/american-unsigned-language/tree/american-unsigned-language-2.sh
>> >
>> > I need to get some sleep, but if nobody posts a patch in the
>> > meanwhile, I'll try to post a fix tomorrow.
>> >
>> > Jason
>> >
>> > [1] https://www.openwall.com/lists/oss-security/2020/06/14/1
>>
>>
>> This looks CVE-worthy.   Are you going to ask for a CVE for it?
>
> Does it really make sense to dole out CVEs for individual lockdown
> bypasses when various areas of the kernel (such as filesystems and
> BPF) don't see root->kernel privilege escalation issues as a problem?
> It's not like applying the fix for this one issue is going to make
> systems meaningfully safer.
>

Indeed, I'm more or less of the same mind: lockdown is kind of a
best-effort thing at the moment, and it'd be crazy to rely on it,
considering various bypasses and differing attitudes on the security
model from different subsystems. This acpi bypass is a bug, maybe, but
it doesn't feel like a "real" security bug, because I'm not sure why
this would be a feature somebody would want to lean on at this point
in time. I wrote a PoC for this one rather than others because it
seemed fun and technically interesting to poke around with acpi in
this way, not because it's particularly rare or something.
