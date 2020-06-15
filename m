Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0118E1F9E05
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 19:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgFORDU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFORDU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2020 13:03:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F8C05BD43
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2020 10:03:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so20118979ljc.8
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2020 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+e+6oiMfPcuzfOioIuAZY78N0uqSVxHMMheHIvnJFI=;
        b=ZdDL5AnKuDKjT78TYGdiLM90FU4CSgVPQvBPwBxI4352g9rT5orcRSoCEyhOgCzmrb
         4e5RDz3iPk4xgm/IQFSISxou4eEhtOFpaahQc3QKC4aym1agnSpfRVXS8vTqXb2Plmrd
         JE+g5jt9NSl4Bg3MUUdIcJO1AZwUTx6w0nfikkonIXSuSDXlbWYxbECK8lmFLj4afdYC
         HrXWm/+8PH0LuJZpduXLjdnuoL+cnyvy/wanzTOdUAr9jrz/ji7YRX+MTUSO0WBJYFXJ
         eCTY/xUIKoC3WPvskinA4vXddp2oIjFSeL+i1Yt4RZNpAH1rkFIT1NsfcEEsKZQU8Oth
         aD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+e+6oiMfPcuzfOioIuAZY78N0uqSVxHMMheHIvnJFI=;
        b=EsVE59CIMCp6yZCcKE2ArhkGTceMt1ZSg4QvQz+15sLRWLYML6JzTpnnJu599xzzsP
         itxVx+nKSBq0qO1GpGvCimFseO4sXCa7HtwEG99jYdEiNjLHNF1An4rsHHhtKdAWWTNS
         D0vgD6xfElpxY99NdaIyEO5pEy1NIAVPSQr05XFyZpSVAnqcfnDKPBwv+NTZZ7dNGUXe
         q7Tal/uBjyqm/d+wWpJqXqhG6RMkNJ4/k4+jRzI72yErVeN8+vqbD1uomLlFJyRm/wlH
         vmxeMf4ZspJcxtUm370M+oQ/JMZtKLBmjscw3kHudQEsDBCdnrtcxT3D22TbpWAidRWA
         1Jvg==
X-Gm-Message-State: AOAM533QMWS8t75o6res+HHHCxVCc0adoZoShqvZJxjo2UoPBzvEojWE
        XKREgb++HEyjj4JLKsjvwZtaxW6YLHXAQnIWlWZiJw==
X-Google-Smtp-Source: ABdhPJxKghjauWCQ06S7R7giwAOWLRv8YnNXKPN82l+nvWY9jbQW3XjbsykSVqW3lMHbTPuJcLGB8eKa4JCQbYJKd3Y=
X-Received: by 2002:a05:651c:38b:: with SMTP id e11mr12109574ljp.415.1592240597617;
 Mon, 15 Jun 2020 10:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
 <206DB19C-0117-4F4B-AFF7-212E40CB8C75@oracle.com>
In-Reply-To: <206DB19C-0117-4F4B-AFF7-212E40CB8C75@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Jun 2020 19:02:51 +0200
Message-ID: <CAG48ez3fQbBLUBUkSaF-0b_DhL8M_1JU4DKkjTYXGB_6G1RgiA@mail.gmail.com>
Subject: Re: [oss-security] lockdown bypass on mainline kernel for loading
 unsigned modules
To:     John Haxby <john.haxby@oracle.com>
Cc:     oss-security@lists.openwall.com,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 15, 2020 at 6:24 PM John Haxby <john.haxby@oracle.com> wrote:
> > On 15 Jun 2020, at 11:26, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Yesterday, I found a lockdown bypass in Ubuntu 18.04's kernel using
> > ACPI table tricks via the efi ssdt variable [1]. Today I found another
> > one that's a bit easier to exploit and appears to be unpatched on
> > mainline, using acpi_configfs to inject an ACPI table. The tricks are
> > basically the same as the first one, but this one appears to be
> > unpatched, at least on my test machine. Explanation is in the header
> > of the PoC:
> >
> > https://git.zx2c4.com/american-unsigned-language/tree/american-unsigned-language-2.sh
> >
> > I need to get some sleep, but if nobody posts a patch in the
> > meanwhile, I'll try to post a fix tomorrow.
> >
> > Jason
> >
> > [1] https://www.openwall.com/lists/oss-security/2020/06/14/1
>
>
> This looks CVE-worthy.   Are you going to ask for a CVE for it?

Does it really make sense to dole out CVEs for individual lockdown
bypasses when various areas of the kernel (such as filesystems and
BPF) don't see root->kernel privilege escalation issues as a problem?
It's not like applying the fix for this one issue is going to make
systems meaningfully safer.
