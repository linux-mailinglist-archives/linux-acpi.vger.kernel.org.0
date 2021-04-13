Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6352435DB5C
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhDMJgV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 05:36:21 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:38441 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhDMJgU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Apr 2021 05:36:20 -0400
Received: by mail-oo1-f45.google.com with SMTP id y23-20020a4ade170000b02901e6250b3be6so1199948oot.5
        for <linux-acpi@vger.kernel.org>; Tue, 13 Apr 2021 02:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIg5o9ripbpko5Q3BIHhp8Gr7ZkG78VbbgSlQpkzJY8=;
        b=foNh4G3TOR+PDLTMepnipkBLc/yJpDA6mmvHaUQw4/lX1TzKEIQeazDn/fxBdJmWzB
         Rb0FbwpU0XMKbQX4hzgerMCLCxMNKQ01+Y4Ffa2X/cIAUuS6sn9e/kTe9asC/0Uhp4Ul
         BjWY2XWKo/K8uAJ8hNZ4gnulSL6BAwJQc5Ki86xk7usrQ95lHuvntsbyE616P3ZMGqdw
         4Z2eU6MSOzXxoPv5dD9SPgn5fVrmCN55J0D/n0QiGuWt0JDZ/14U4nxirpaZvT54ScOK
         Oi8Ho4nDuusYXFzjWFpGVTIakXcq35fUJ/ctKlEM9XOSSG+nyM7sA/FN1YtsX3MuAjjZ
         8cmQ==
X-Gm-Message-State: AOAM533Khanm2/eF47ot4anufvtGFO8TMRqE7RViIoT1yCNtKXjWPrYm
        t9unzJtxL147GuKrw90V6x3dOBFVYaeOOAE1wuE=
X-Google-Smtp-Source: ABdhPJxGQC15YZr7YtZeIyoBou6X73FBZJejmRyXq2SeLevSTxJwqWWGF+IdO92hnwVySA0l3MA5agiRYPAxQcg2Q2k=
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr26121710oos.2.1618306560678;
 Tue, 13 Apr 2021 02:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <7d941a3c-bced-09cf-27a1-b61f0d20ef4c@redhat.com>
 <CAJZ5v0iLSbfRH9A3EMUTrY5=vPdp=uVOF2XQnWkAbko9NjPqJg@mail.gmail.com>
 <CAJZ5v0gOMZbyD5r+bCL9vD6_NrFz0nAq+eY2QDtxOY4DfsXG6w@mail.gmail.com> <273d3ea7-aa74-6556-7fef-fb65b620bc95@redhat.com>
In-Reply-To: <273d3ea7-aa74-6556-7fef-fb65b620bc95@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Apr 2021 11:35:48 +0200
Message-ID: <CAJZ5v0i=Ahxjnx_K1M+BPDdR-3_v8aBTPVFRg3s+bG9OeaEiwQ@mail.gmail.com>
Subject: Re: [5.12 regression] DSDT overriding from initrd no longer works
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b0005705bfd75bd9"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--000000000000b0005705bfd75bd9
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 12, 2021 at 8:53 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 4/12/21 8:11 PM, Rafael J. Wysocki wrote:
> > On Mon, Apr 12, 2021 at 8:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> On Mon, Apr 12, 2021 at 7:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>
> >>> Hi Rafael,
> >>>
> >>> Sorry about the timing of reporting this regression.
> >>
> >> Oh well.
> >>
> >>> I just noticed that overriding the DSDT (*) from the initrd will not work in 5.12,
> >>> this is caused by:
> >>>
> >>> commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
> >>>
> >>> This makes the initial acpi_locate_initial_tables() call happen earlier
> >>> then before, but the acpi_table_upgrade) call in arch/x86/kernel/setup.c is
> >>> not moved up, so the tables in the initrd are now only parsed and saved
> >>> after the initial ACPI table scanning has already been done.
> >>>
> >>> I guess fixing this might be as easy as moving the acpi_table_upgrade) call
> >>> higher in arch/x86/kernel/setup.c but I'm not sure if that is save to do.
> >>
> >> Why do you think it may not be safe?
> >
> > OK, so it won't work in some cases, because acpi_table_upgrade() needs
> > to be called after reserve_initrd(),
>
> Right I notice it was sitting right after reserve_initrd() which made me think
> that it probably needed to be after that. Sorry I should have mentioned that
> in my original email.
>
> > so I guess the commit above will
> > need to be reverted.
>
> One possible solution which I was wondering about is to modify
> acpi_table_initrd_scan() to have it call acpi_tb_override_table()
> instead of acpi_install_table() for existing tables using the matching
> logic from acpi_table_initrd_override(). But I'm not sure when the
> parsing of the DSDT is done. If acpi_table_initrd_scan() runs before
> the first parsing of the DSDT is done then I think that that should work.
>
> This might be more 5.13 material though and for 5.12 a revert is
> probably best.

The attached change should make it work again, though.  Can you please verify?

> I also just remembered that at least the Intel audio folks rely on
> DSDT overrides to get some (prototype) boards in their CI to work.

But they haven't complained so far.

--000000000000b0005705bfd75bd9
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-x86-ordering.patch"
Content-Disposition: attachment; filename="acpi-x86-ordering.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_knftwlhs0>
X-Attachment-Id: f_knftwlhs0

LS0tCiBhcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYyB8ICAgIDUgKystLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtcG0vYXJjaC94
ODYva2VybmVsL3NldHVwLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9hcmNoL3g4Ni9r
ZXJuZWwvc2V0dXAuYworKysgbGludXgtcG0vYXJjaC94ODYva2VybmVsL3NldHVwLmMKQEAgLTEw
NDUsOSArMTA0NSw2IEBAIHZvaWQgX19pbml0IHNldHVwX2FyY2goY2hhciAqKmNtZGxpbmVfcCkK
IAogCWNsZWFudXBfaGlnaG1hcCgpOwogCi0JLyogTG9vayBmb3IgQUNQSSB0YWJsZXMgYW5kIHJl
c2VydmUgbWVtb3J5IG9jY3VwaWVkIGJ5IHRoZW0uICovCi0JYWNwaV9ib290X3RhYmxlX2luaXQo
KTsKLQogCW1lbWJsb2NrX3NldF9jdXJyZW50X2xpbWl0KElTQV9FTkRfQUREUkVTUyk7CiAJZTgy
MF9fbWVtYmxvY2tfc2V0dXAoKTsKIApAQCAtMTEzMiw2ICsxMTI5LDggQEAgdm9pZCBfX2luaXQg
c2V0dXBfYXJjaChjaGFyICoqY21kbGluZV9wKQogCXJlc2VydmVfaW5pdHJkKCk7CiAKIAlhY3Bp
X3RhYmxlX3VwZ3JhZGUoKTsKKwkvKiBMb29rIGZvciBBQ1BJIHRhYmxlcyBhbmQgcmVzZXJ2ZSBt
ZW1vcnkgb2NjdXBpZWQgYnkgdGhlbS4gKi8KKwlhY3BpX2Jvb3RfdGFibGVfaW5pdCgpOwogCiAJ
dnNtcF9pbml0KCk7CiAK
--000000000000b0005705bfd75bd9--
