Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D8E7EB8
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2019 04:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfJ2DHN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Oct 2019 23:07:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36570 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfJ2DHL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Oct 2019 23:07:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so8552886otm.3
        for <linux-acpi@vger.kernel.org>; Mon, 28 Oct 2019 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qnT1ZP3CJMcSq6L0LWTa2iyPLJWEkUMtmJ85EPCi4g=;
        b=jyz7BkXWDwIX8GIPgfsfU1Pk6DOEgI+jy3ge8ri0/tATonbTF5qMMpBr8OzN84eXdp
         PPt89jzMeUxP8VByrdcY6vy+QfDNxLaz5t3bfOpjE3qK/z0Y6sVf/67nxVjzgDMT6LwA
         CoHFbgv1Yxc/p9ZwMpRlaW4qe3M/lf+xa+L1uePYN9n4O6BRpFkzmZ0Y6YA7+lcE00C9
         BA5GAq+HwCw+Luc/VgNTBdTfTjFIZ0ciIfSzHseq3VqwQyL/ch+xTZG9+AotHo9RWzRO
         14xtUdOKCD/RezUjBH09AEwDzLaEs0vk4d1wEu36ShlQheSwdhpQNHw2QyktRxd5VdNH
         boZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qnT1ZP3CJMcSq6L0LWTa2iyPLJWEkUMtmJ85EPCi4g=;
        b=X+HWF4TeGvWx62X+oVBq0P5HxqYSj8xAnxdUMomN5W+JTdLrE5+M1RzYaei0gN1Cau
         viXxWnqYoqKiBGFRiNjKizSZ9ezahtXwAI4AqgWaLEIjcKKJqN+Pmkq6vEI5TfZ6eRtX
         vHOwwKD5n/J5z3Lx8x2ErI0yOp+wi0ZTGXn0+qdHsIEn2xCU+WdZMM4wbBBgIkcko6DN
         41hynrSb5MNfYytYgsulMpC5bClgafj7RRjWcILGthrtzufiKu9yuRUkdjeb03zOHv0d
         mn6F6uUz64rPgD1Julk39fvGnexBm5MuE2KQN7C7asmJFggmQUcsMepmYw2Ubjy2QxxW
         P13A==
X-Gm-Message-State: APjAAAXJOYVzlIisFsVWSYO7EVIcc940f084AexHLu3uzlirLNLY9tnt
        abnoMA3hdxlcPv1sKmyut4gLAxC6vk4iZg+14uWZ5w==
X-Google-Smtp-Source: APXvYqy4FOA2jwEsa1Q9F6uRXTEMb/1i6qDZEx0Kz8n+9VLiVD9T6IqpNu6c/DSljpUoRARs+eP4jGbnneNiRziV86M=
X-Received: by 2002:a05:6830:18d1:: with SMTP id v17mr2212366ote.71.1572318429791;
 Mon, 28 Oct 2019 20:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0j_-iSqiysZiW=J8Y5FCAjnPC7ZvevrLsYhngWr6mT6GQ@mail.gmail.com>
 <CAPcyv4js1XqSe1kNeWob=ftscYFKQF+04PrKj7XDiEWUWvnMvQ@mail.gmail.com> <1666116.19LcctqB44@kreacher>
In-Reply-To: <1666116.19LcctqB44@kreacher>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 28 Oct 2019 20:06:58 -0700
Message-ID: <CAPcyv4i2gxocbT9nB5k9+Qea5WftJLSoArXjymkwyZ=+8GBFcQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] acpi/numa: Establish a new drivers/acpi/numa/ directory
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 28, 2019 at 8:13 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, October 22, 2019 6:48:12 PM CET Dan Williams wrote:
> > On Tue, Oct 22, 2019 at 3:02 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Oct 18, 2019 at 11:25 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > >  On Wed, Oct 16, 2019 at 3:13 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > >
> > > > > Currently hmat.c lives under an "hmat" directory which does not enhance
> > > > > the description of the file. The initial motivation for giving hmat.c
> > > > > its own directory was to delineate it as mm functionality in contrast to
> > > > > ACPI device driver functionality.
> > > > >
> > > > > As ACPI continues to play an increasing role in conveying
> > > > > memory location and performance topology information to the OS take the
> > > > > opportunity to co-locate these NUMA relevant tables in a combined
> > > > > directory.
> > > > >
> > > > > numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> > > > > hmat.c.
> > > > >
> > > > > Cc: Len Brown <lenb@kernel.org>
> > > > > Cc: Keith Busch <kbusch@kernel.org>
> > > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > Please note that https://patchwork.kernel.org/patch/11078171/ is being
> > > > pushed to Linus (it is overdue anyway), so if it is pulled, there will
> > > > be a merge conflict with this patch.
> > > >
> > > > Respin maybe?
> > >
> > > Actually, would you mind it if I took this one into the ACPI tree right away?
> > >
> > > There's https://patchwork.kernel.org/patch/11198373/ queued up that,
> > > again, will clash with it.
> > >
> > > Also, there is the generic Initiator proximity domains series from
> > > Jonathan depending on it and I would like to move forward with that
> > > one if there are no objections.
> >
> > Given Ard has acked all the EFI core and ARM changes can we proceed
> > with merging the EFI Specific Purpose Memory series through Rafael's
> > tree? It would need acks from x86 maintainers.
>
> In the face of the lack of responses here, I think I will apply this patch
> alone and expose a stable branch containing it in case somebody else wants
> to pull it in.

Ok.

x86 folks, any concerns about Rafael taking the whole lot?
