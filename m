Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763453A081E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhFIAJH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 20:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhFIAJH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 20:09:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6EEC061787
        for <linux-acpi@vger.kernel.org>; Tue,  8 Jun 2021 17:07:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h16so317450pjv.2
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GV9nzlHjuf7NCFb6LdJq8dcslquY+0P8BRy8EWccMJQ=;
        b=IvLhda9dAdPsWp2e1qg11jdD25V8E+CyAlL2atOWouCB3ilCZeJv4x3h00X4H3vcFL
         4VDBMfvZkRAFh790xsI7hLTynbi5imIUzIdKJhLQI6q/l1JRVLAA0nbr3VC1JF9OOJVG
         4I0ghW/qGrT4Mqx420+rS9UmNCWzr5f/+JKJ1v60DI6PkepbqBRQm4nKUKq/WVXWfVvz
         rT/N5C/tytroucQPSqkMp9hfiVa61caGujH0EmZMTRkGA32WTtKNDOYXZBfeKWb4enCW
         zV4WPQAAE2YVhiMYJIn4R3q2dAJNblcCJ8FprosYRdOxNLss0oUw6cgUTJojtDNNbQoj
         DVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GV9nzlHjuf7NCFb6LdJq8dcslquY+0P8BRy8EWccMJQ=;
        b=dIFFpkz1AQ8I7SBjYkZM3wMOa3nu4AvQBzRsQNVeuAXKQOh8GUtE8ETR4NJMnXPDTa
         q7jiH9KarphVwVEgAwnWk4wkZar7PgONsDYDxflrqhUD2283JQ4jgRnabS/x2xs0ednl
         M7+uk1onafs8suaRHwIRMvTJ3tR7qWgEGAPVvjVgGxhGKFrs1QKSoUcmhG/+uhMv1OTG
         OYe1329eBYq/ZnGfjZY8IOBjdbDhiUXZPEzySVT/IbL2BVdx8i90B9YZyWmWtRAXJ4Yj
         S6JDAYD6F/8WtqQSQ0NsSOqMBJDto4W41fhNClK00hKk8nsRSLjcgvOQOOXACbP9A9Ui
         qdFw==
X-Gm-Message-State: AOAM531Fbg8juhE2LWSL823n0Rz6exhtJUyZCrjiAL3th5wQQwt1PB3Z
        SgVnNzLXQxxoDLnQnJsfYTWv2F7CeHlH4HoCc5UJXg==
X-Google-Smtp-Source: ABdhPJwOwb7XuxqU5bkXCuzqJvxOAaOUMiuAxR4pVlLHyGgFzYHmtGhJx2qXkz+4gbtmvaw28Qehpx8wS6Xv0nYErpk=
X-Received: by 2002:a17:902:ed0c:b029:104:fb4b:453c with SMTP id
 b12-20020a170902ed0cb0290104fb4b453cmr2617099pld.27.1623197233127; Tue, 08
 Jun 2021 17:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
 <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4hoxc2+50EOFuq8NOa_CBFKX_A549Vw4U24V5SG25ftxQ@mail.gmail.com> <9d88cb37-f594-534a-ae2a-5a51f97db2a8@intel.com>
In-Reply-To: <9d88cb37-f594-534a-ae2a-5a51f97db2a8@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 17:07:02 -0700
Message-ID: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 8, 2021 at 4:38 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/8/21 4:32 PM, Dan Williams wrote:
> >> Persistent memory is also currently not supported. Another code
> >> path that uses WBINVD is the MTRR driver, but EPT/virtualization
> >> always disables MTRRs so those are not needed. This all implies
> >> WBINVD is not needed with current TDX.
> > Let's drop the last three paragraphs and just say something like:
> > "This is one of a series of patches to usages of wbinvd for protected
> > guests. For now this just addresses the one known path that TDX
> > executes, ACPI reboot. Its usage can be elided because FOO reason and
> > all the other ACPI_FLUSH_CPU_CACHE usages can be elided because BAR
> > reason"
>
> A better effort at transparency can be made here:
>
>         This patches the one WBINVD instance which has been encountered
>         in practice: ACPI reboot.  Assume no other instance will be
>         encountered.
>

That works too, but I assume if ACPI_FLUSH_CPU_CACHE() itself is going
to be changed rather than sprinkling protected_guest_has() checks in a
few places it will need to assert why changing all of those at once is
correct. Otherwise I expect Rafael to ask why this global change of
the ACPI_FLUSH_CPU_CACHE() policy is ok.
