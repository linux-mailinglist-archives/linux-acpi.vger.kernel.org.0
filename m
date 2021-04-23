Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52E2369985
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbhDWS0W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 14:26:22 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34557 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbhDWS0N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 14:26:13 -0400
Received: by mail-oi1-f176.google.com with SMTP id k18so45096281oik.1;
        Fri, 23 Apr 2021 11:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgWGrU+NRgbqW5EZG+gvjikL17VEIwiL+m90q0aPjwU=;
        b=bOP/JV2gXaA1tS5cPh4kRC8B3l3H8YLhYtMCw4g0c0qAovC3nDahc/MVCEjEwFiOCH
         Dkyo2q0YqCoTXNzXlk16/toi/1QOoMlA4dzY9qD8PkYPEARrHygeKG/b7weMgQp2y4n6
         /+P4fH2G9CF2WKMRQMtruyKZlcGSDfkkCpxSkv6kwbA2OnHFo8Vhz/J5ZppCcRxJvlGq
         7GoMrWacuSER70pp04Fv76IrzpdytOYBFZvRFJszHhJd/yrTRXQMPJjC+n6PocChuR36
         KLhWLxC0cJvTFf+O2w7g44zttEFq5dEybGGdYYv/R3dIn4hiIQ5VyPqmZBwEgEQt+4W4
         P8/A==
X-Gm-Message-State: AOAM532qKIHd+GvNbL/aTAzEONNOWjcOfKClUsDyZAbiDD0Y9ZCYzREk
        eIdCl2Zrua9yZaTReMC9dM3yQId1QcMhl3WVP6M=
X-Google-Smtp-Source: ABdhPJzIW9nCpFD4K+luzh3oa4XdA6nBZsXZR10JnAacbR+a5loiOX9m3bVXP0pS7HUWcs68mtIJTozgOqDI0y55Jkg=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr3628059oib.69.1619202335347;
 Fri, 23 Apr 2021 11:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210422214930.716596-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0gH-Zg7YZPf9joaMt1zfYfNkUGpo596=9QEJ1NKAw87qQ@mail.gmail.com> <df09a419-c881-c987-ef07-1b0e05bb171e@linux.intel.com>
In-Reply-To: <df09a419-c881-c987-ef07-1b0e05bb171e@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 20:25:24 +0200
Message-ID: <CAJZ5v0gzCSrjjEKfu-whehh28eNMPaDAmjpBEikFFV00iEqbBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPICA: Add SVKL table headers
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 6:52 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 4/23/21 5:36 AM, Rafael J. Wysocki wrote:
> > Evidently, this is ACPICA material, so I'm expecting to receive this
> > patch from Erik within the normal ACPICA development process, so I'm
> > not sure what the purpose of this submission is.
> >
>
> Erik already sent a pull request to merge this patch to ACPICA repo.
>
> After he updated the ACPICA commit ID, he sent it to me for Linux
> submission.
>
> I am not sure whether there is a special process for ACPICA related
> submission to Linux kernel. But if I had to guess, since I have sent
> both SVKL and MADT patches at the same time, Erik might have assumed
> that it should be merged in the same patch set and hence sent to me
> for upstream submission.
>
> > Has this patch been posted here for reference only?
>
> If this submission is incorrect, I can request Erik to submit it again
> for upstream merge.

All of the sign-offs under the original ACPICA commit should have been
preserved, then.
