Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251B81EFE24
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgFEQj4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 12:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgFEQjz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 12:39:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44226C08C5C4
        for <linux-acpi@vger.kernel.org>; Fri,  5 Jun 2020 09:39:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so10772836eje.13
        for <linux-acpi@vger.kernel.org>; Fri, 05 Jun 2020 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MiHJvWvFUN4W4TOaBTTRVwH9Kbcz3EtLSrutNpEo/8=;
        b=BXGx739NHMzDG5jF4pX2SjGcZdBMtypWsjdXc+T5TXcMRY3QFLn1zVYTB10ArVqHfw
         bS2lJVfCpuTD82oSoAPn3j92VWPnGK3U9NUDm8MQimf3XMKwYy5kLcX07pC1YGpVXB2O
         3gP+9IYgz88+xJpYfAzaurF+CZ8yPzls/rjK0WfZtXiZKUXRZsqhDHr4qc11YmqpXt9e
         r86XRpvXT+Cy7gLPk8Rype/AN669h2aux8SKpgTvrVFDhanzHQcIcspCONHUC6/YyZs1
         5ZPK/WfUFfhDs5cz5AFCES84sqyqXKNvoU5i+bNAsSbPuv0mImc46an+0ZEFKox19Ymn
         uSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MiHJvWvFUN4W4TOaBTTRVwH9Kbcz3EtLSrutNpEo/8=;
        b=egPDnCSJ/JVHij40tGhdTBVAG5m3b4PQzv7BphMnhWLVKxoM3vAl7JFSPIFI54plIb
         WK2xJOhvV3tZE8H0IMd8hNy+heLer/EhhrWXn8JNFstPlCmEIk/KRL4Qjs5NL98kQi7X
         PekyQoWiFNF2pyG2w7LBkayOGMC6pfTZBWmqQcf4zo/XuApOJYfRI0G7vOLozBSTZP74
         Gr7J58KnxBxFw7ZiKIvN5hLetlOKLj9DcD1h8BbKATqb+SPJtrlBpA7nKnwrUEr5fHog
         E9pl6Kp0KU5xfOmvYz31CPcUNa9h+/gjbvfWUqeKVTqR3r9Hm14zasOlfY7AlwFNVSA9
         q9NA==
X-Gm-Message-State: AOAM531ow7QZiMTpPkfaRmCYefzOKnisij3I+CUFnyHog2gXPQpBTICM
        zjusI6EpcTyT9/4IgrU5lR4JwpO50TUSYbubKGrHTw==
X-Google-Smtp-Source: ABdhPJz9NOYy2yZ6H8XGWcEzcmqj7Uj80HxfYALJr2J1pSWlpcP4qVMIo7RE/ZyxbXyEIMN2Y5wxAGBnr9c0Vhr3t/s=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr4137917ejb.237.1591375193798;
 Fri, 05 Jun 2020 09:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com>
 <CAPcyv4gQNPNOmSVrp7epS5_10qLUuGbutQ2xz7LXnpEhkWeA_w@mail.gmail.com> <CAJZ5v0g-TSk+7d-b0j5THeNtuSDeSJmKZHcG3mBesVZgkCyJOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0g-TSk+7d-b0j5THeNtuSDeSJmKZHcG3mBesVZgkCyJOg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Jun 2020 09:39:42 -0700
Message-ID: <CAPcyv4iECAzRjAUJ1hymOzZRjBYQ_baFrSz=2ah=2pfehn9S_g@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Drop rcu usage for MMIO mappings
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 5, 2020 at 9:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
[..]
> > The fix we are looking at now is to pre-map operation regions in a
> > similar manner as the way APEI resources are pre-mapped. The
> > pre-mapping would arrange for synchronize_rcu_expedited() to be elided
> > on each dynamic mapping attempt. The other piece is to arrange for
> > operation-regions to be mapped at their full size at once rather than
> > a page at a time.
>
> However, if the RCU usage in ACPI OSL can be replaced with an rwlock,
> some of the ACPICA changes above may not be necessary anymore (even
> though some of them may still be worth making).

I don't think you can replace the RCU usage in ACPI OSL and still
maintain NMI lookups in a dynamic list.

However, there are 3 solutions I see:

- Prevent acpi_os_map_cleanup() from triggering at high frequency by
pre-mapping and never unmapping operation-regions resources (internal
discussion in progress)

- Prevent walks of the 'acpi_ioremaps' list (acpi_map_lookup_virt())
from NMI context by re-writing the physical addresses in the APEI
tables with pre-mapped virtual address, i.e. remove rcu_read_lock()
and list_for_each_entry_rcu() from NMI context.

- Split operation-region resources into a separate mapping mechanism
than APEI resources so that typical locking can be used for the
sleepable resources and let the NMI accessible resources be managed
separately.

That last one is one we have not discussed internally, but it occurred
to me when you mentioned replacing RCU.
