Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAFF3A2CDA
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhFJN0M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 09:26:12 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:45055 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhFJN0M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 09:26:12 -0400
Received: by mail-oo1-f50.google.com with SMTP id o5-20020a4a2c050000b0290245d6c7b555so6762428ooo.11
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 06:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPNdlk/fgYlvNPh9a4NZpta/ociWNbrDy2MwwOfzaUI=;
        b=hOQL7E+ujwDneqwKVgbuPhSH2H2Sa0n19wIlx6RsyRg3QxlXBjVziuZL+CR2b0SOCP
         Xwadca5MkjDt/x+Q4waaOnx/fWPmIjZrNFAi2aJWqXClrdqYcWXbQsxPlJ6dZnDWXLgn
         bYKZguzN+TQ8rDZn0I3J4r32Vg2v8GNApOyM7YoP9wKK72NYCuK7iqmzxTyypVx73xTn
         ggI/qADd/0c3sOaDzxwz59S03kfdpMQjmqNnT5eEgLgk2fwS7Ke2eFy4v5Jz9EhmVjk3
         8V6DdHu9RLvk6Gqr83PM8j9nBPwvvjMCZwmn0l5B5CQffhM9g0qhK/ss38XUhBCH/FUV
         e5gw==
X-Gm-Message-State: AOAM532xmLDdlE8LhPDmq6jnTsvEFRAq9iiRlSok+17zL1UxPkZt+4/5
        ZtZ4WrVphiANKEN2dTOy8gUwRbmoiHXeei0M/EU=
X-Google-Smtp-Source: ABdhPJxOXAY3VfzRxYBFTl9F0/lyzh26xM1Wt3rZp2cR6ONxDI4C7ZNaK3En2b+fGS4P3UDIe3saV1DpYw4mLctHjMM=
X-Received: by 2002:a4a:a9c8:: with SMTP id h8mr2393999oon.1.1623331445694;
 Thu, 10 Jun 2021 06:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210610034153.3882311-1-erik.kaneda@intel.com>
In-Reply-To: <20210610034153.3882311-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jun 2021 15:23:54 +0200
Message-ID: <CAJZ5v0hN8ZH53i7YzdKaEKWVtEStH5OOVE1tju0NRwGr9AZreg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Update PRM patches to fix some issues...
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 10, 2021 at 6:16 AM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> Hi Rafael, I found out that there were several misspelled struct fields
> that resulted from merging my PRM code with ACPICA material that caused
> build errors. This patch set resolves build issues by
>
>   1) fixing the spelling errors
>   2) defining the struct acpi_prmt_module_header that got left off.
>      This struct is used by acpi_parse_table_entries and is not used by
>      ACPICA so it was left out accidentally.
>
> This patch set also fixes a crash that was caused when I split up
> acpi_table_prmt and acpi_table_prmt_header. These structs used to be
> defined in a single struct acpi_table_prmt but it was split up in
> order to facilitate iASL compiler implementation. The size of the
> 36-byte ACPI table header + the size of any additional fields are
> needed as parameter to the acpi_parse_table_entries function. When I
> split up acpi_table_prmt into two different structs, I did not adjust
> the parameter to acpi_parse_table_entries and this ended up breaking
> the PRMT parsing. I've fixed this by changing the parameter to
> acpi_parse_table_entries to account for this additional struct.
>
> Sorry for the confusion! This patchset should clear things up and
> runs the PRM handler in the edk2 PRM samples without any issues.
>
> I've based this on rc-5.

Applied (instead of the previous version), thanks!
