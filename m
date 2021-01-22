Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267BB3006B6
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 16:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbhAVPIn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 10:08:43 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39025 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbhAVPIL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 10:08:11 -0500
Received: by mail-ot1-f43.google.com with SMTP id i30so5328221ota.6
        for <linux-acpi@vger.kernel.org>; Fri, 22 Jan 2021 07:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0vuBVSl8273wWbC+VRtyHkp2LyQZPUZzS7RzbIKIoA=;
        b=X5oULQDatS8C3lx03O5xeUnwy2kkzQ2SKhYJAAa5f1bLA6JPGdnmNz5zy/rWY+Id+5
         TxzFqyQUuomy7S1kSS9WHy39RpY+qFAUxQfk+ktNS9qmtPZGYI5l4f6b6r1teVGo1GFb
         fOpMLkzqEQy90JKHA2IV5Y9svhzMVlEqFFrMsYogqMbzK/GsKidvxe/QJo+IX+1dprWK
         ID0EdCv8mji8OkYbqQbWOGb0NAasLIaQLVI32gnLJLQgS/CmP1muUu6h7xEfDLy3A+YR
         OYbVevQBuIESnapdIFiJ0IxRh8NoYhSg9lpZuviiHnacPXsIzcSQmxBjFkd42R1+CBOv
         tpmA==
X-Gm-Message-State: AOAM530lRBSeMTFC2fNYu5BUtDtU/TPB1SwLHqhlsuc3pZpFjeE4/gfm
        4y7lSszIrbzufMXwHKmSL9jdrni4/2Sya8grUvE=
X-Google-Smtp-Source: ABdhPJwdz+cs4vtE3ivl50gsy6a1s0hP6mehhRhB5cVfg7UGw6r3uKUBPXrlWewM7xlP/EgcL8PkP1NdThteDWm7anM=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr3579919ota.260.1611328037259;
 Fri, 22 Jan 2021 07:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20210122002357.370836-1-erik.kaneda@intel.com>
In-Reply-To: <20210122002357.370836-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 16:07:06 +0100
Message-ID: <CAJZ5v0iFkA1rXV0kuv2aQtXtOZYGpR20jdMzZRtwJkmqbCDxdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ACPICA release 20201217 and 20210105
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 22, 2021 at 1:56 AM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This series contains ACPICA versions 20201217 and 20210105. These
> releases are quite small and contain trivial or stylistic fixes as well
> as deprecating MTMR and VRTC tables. The copyright update patch is large
> in size so it might not come through the mailing list. As an
> alternative, this patch set is hosted at the following link on github:
>
> https://github.com/SchmErik/linux/tree/20210105
>
> v2 - replace missing line in include/acpi/actypes.h in Nick's fallthrough
> patch. It looks like this line was missing due to a bug in ACPICA's
> linuxize scripts...

I've just replaced the defective patch and retained the rest from the
previous version.

Thanks!
